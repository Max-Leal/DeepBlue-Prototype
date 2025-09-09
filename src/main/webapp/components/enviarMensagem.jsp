<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="models.Usuario, models.Agencia, models.Mensagem, Enums.TipoUsuario" %>
<%@ page import="controllers.MensagemController" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="com.google.gson.Gson" %>
<%@ page import="com.google.gson.GsonBuilder" %>
<%@ page import="utils.LocalDateTimeAdapter" %>
<%@ page contentType="application/json" pageEncoding="UTF-8" trimDirectiveWhitespaces="true" %>
<%!
	// Classe auxiliar interna para facilitar o parse do JSON vindo do front-end.
	// Os nomes dos atributos (conteudo, chaveDestinatario) devem ser iguais aos do objeto JS.
	private static class MensagemPayload {
		String conteudo;
		String chaveDestinatario;
	}
%>
<%
	// Objeto Gson para serialização e desserialização de JSON
	Gson gson = new GsonBuilder()
	    .registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter())
	    .create();

	try {
		// --- 1. AUTENTICAÇÃO: Identificar o remetente pela sessão ---
		Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
		Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

		Long remetenteId = null;
		TipoUsuario remetenteTipo = null;

		if (usuarioLogado != null) {
			remetenteId = usuarioLogado.getId();
			remetenteTipo = TipoUsuario.usuario;
		} else if (agenciaLogada != null) {
			remetenteId = agenciaLogada.getId();
			remetenteTipo = TipoUsuario.agencia;
		}

		if (remetenteId == null) {
			response.setStatus(HttpServletResponse.SC_FORBIDDEN); // Código 403 Forbidden
			out.print("{\"error\":\"Acesso negado. Usuário não autenticado.\"}");
			return;
		}

		// --- 2. LEITURA DA REQUISIÇÃO: Ler o corpo (body) da requisição AJAX ---
		BufferedReader reader = request.getReader();
		MensagemPayload payload = gson.fromJson(reader, MensagemPayload.class);

		// --- 3. PROCESSAMENTO: Montar o objeto Mensagem ---
		String[] partesChave = payload.chaveDestinatario.split("-");
		TipoUsuario destinatarioTipo = TipoUsuario.valueOf(partesChave[0]);
		Long destinatarioId = Long.parseLong(partesChave[1]);

		Mensagem novaMensagem = new Mensagem();
		novaMensagem.setConteudo(payload.conteudo);
		novaMensagem.setRemetenteId(remetenteId);
		novaMensagem.setRemetenteTipo(remetenteTipo);
		novaMensagem.setDestinatarioId(destinatarioId);
		novaMensagem.setDestinatarioTipo(destinatarioTipo);
		novaMensagem.setDataEnvio(LocalDateTime.now()); // O servidor define o timestamp

		// --- 4. AÇÃO: Chamar o seu controller para salvar no banco ---
		MensagemController mc = new MensagemController();
		mc.enviarMensagem(novaMensagem); // Chamando o método que você forneceu

		// --- 5. RESPOSTA: Enviar a mensagem recém-criada de volta como confirmação ---
		response.setStatus(HttpServletResponse.SC_OK); // Código 200 OK
		out.print(gson.toJson(novaMensagem));

	} catch (Exception e) {
		// Se qualquer erro ocorrer (ex: falha no banco, JSON inválido), captura aqui
		response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Código 500
		out.print("{\"error\":\"Ocorreu um erro no servidor: " + e.getMessage() + "\"}");
		e.printStackTrace(); // Logar o erro no console do servidor para depuração
	} finally {
		out.flush();
	}
%>