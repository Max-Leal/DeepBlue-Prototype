<%@ page import="models.Agencia, models.Usuario, models.Mensagem, Enums.TipoUsuario"%>
<%@ page import="controllers.AgenciaController, controllers.UsuarioController, controllers.MensagemController"%>
<%@ page import="java.util.List, java.util.Set, java.util.HashSet"%>
	
<%
// --- Bloco de Autenticação (sem alterações) ---
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

Long idUsuarioLogado = null; // Renomeado para maior clareza
TipoUsuario tipoUsuarioLogado = null; // Renomeado para maior clareza
boolean logado = false;

if (usuarioLogado == null) {
	if (agenciaLogada != null) {
		idUsuarioLogado = agenciaLogada.getId();
		tipoUsuarioLogado = TipoUsuario.agencia;
		logado = true;
	}
} else {
	idUsuarioLogado = usuarioLogado.getId();
	tipoUsuarioLogado = TipoUsuario.usuario;
	logado = true;
}

// --- Início do Bloco do Chat ---
if (logado) {
	MensagemController mc = new MensagemController();
	UsuarioController uc = new UsuarioController();
	AgenciaController ac = new AgenciaController();

	List<Mensagem> mensagens = mc.buscarConversas(idUsuarioLogado, tipoUsuarioLogado);
	// Usaremos um Set para garantir que cada conversa seja exibida apenas uma vez. É mais eficiente.
	Set<String> conversasProcessadas = new HashSet<>();
%>
<div id="chat-widget">
	<div id="chat-header" onclick="toggleChat()">Mensagens</div>
	<div id="chat-contacts">
	<%
	for (Mensagem m : mensagens) {
		// --- INÍCIO DA LÓGICA CORRIGIDA ---

		Long idContato = null;
		TipoUsuario tipoContato = null;

		// 1. Identifica quem é o "outro" na conversa.
		// Se o remetente da mensagem NÃO for o usuário logado, então o remetente é o contato.
		if (!m.getRemetenteId().equals(idUsuarioLogado)) {
			idContato = m.getRemetenteId();
			tipoContato = m.getRemetenteTipo();
		} else {
			// Caso contrário, o destinatário é o contato.
			idContato = m.getDestinatarioId();
			tipoContato = m.getDestinatarioTipo();
		}

		// 2. Cria uma chave única para a conversa para não exibir duplicatas.
		String chaveConversa = tipoContato.toString() + "-" + idContato.toString();

		// 3. Verifica se esta conversa já foi adicionada à lista.
		if (!conversasProcessadas.contains(chaveConversa)) {
			String nomeContato = "Contato desconhecido"; // Valor padrão

			// 4. Busca o nome do contato com base no seu tipo.
			if (tipoContato.equals(TipoUsuario.usuario)) {
				Usuario usuario = uc.getUsuarioById(idContato);
				if (usuario != null) {
					nomeContato = usuario.getNome();
				}
			} else if (tipoContato.equals(TipoUsuario.agencia)) {
				// Assumindo que o ID da agência é um Integer no seu controller.
				Agencia agencia = ac.getAgenciaById(idContato.intValue());
				if (agencia != null) {
					nomeContato = agencia.getNomeEmpresarial();
				}
			}
			
		%>
		
			<!-- Exibe o contato na interface -->
			<div id="contact">
				<span class="name-contact"><%= nomeContato %></span> 
				<span class="type-contact"><%= tipoContato %></span>
				<span class="time-contact"><%= m.getDataEnvio() %></span>
			</div>
			
			<%
			// Adiciona a chave da conversa ao set para não processá-la novamente.
			conversasProcessadas.add(chaveConversa);
		}
		// --- FIM DA LÓGICA CORRIGIDA ---
	}
	%>
	</div>
	
	<!-- Seu HTML, CSS e Script continuam aqui -->
	<!--<div id="chat-body">
        <div id="chat-messages">
        </div><input type="text" id="chat-input" placeholder="Digite sua mensagem..." onkeypress="if(event.key==='Enter') sendMessage()"> 
    </div>-->
</div>

<style>
#chat-widget {
	background-color: white;
	position: fixed;
	bottom: 10px;
	right: 20px;
	width: 300px;
	font-family: Arial, sans-serif;
	padding-bottom: 10px;
	border-radius: 8px;
}

#chat-header {
	background: #007bff;
	color: white;
	padding: 8px;
	cursor: pointer;
	border-radius: 8px 8px 0 0;
	text-align: center;
}

#chat-body {
	display: none;
	background: white;
	border: 1px solid #ccc;
	border-top: none;
	height: 300px;
	display: flex;
	flex-direction: column;
}

#chat-messages {
	flex: 1;
	padding: 8px;
	overflow-y: auto;
	font-size: 14px;
}

#chat-input {
	border: none;
	padding: 8px;
	border-top: 1px solid #ccc;
}

#contact {
	margin: 5px;
}
</style>

<script>
	function toggleChat() {
		const body = document.getElementById("chat-body");
		body.style.display = body.style.display === "none" ? "flex" : "none";
	}

	function sendMessage() {
		const input = document.getElementById("chat-input");
		const msg = input.value.trim();
		if (msg) {
			document.getElementById("chat-messages").innerHTML += `<div><b>Você:</b> ${msg}</div>`;
			input.value = "";
		
		}
	}
</script>
<% } %>
