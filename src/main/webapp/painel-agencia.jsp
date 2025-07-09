<%@ page import="controllers.LocalController" %>
<%@ page import="models.Local" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String mensagem = "";
    LocalController locaisController = new LocalController();

    if  (request.getMethod().equalsIgnoreCase("POST")) {
        String localidadeLocal = request.getParameter("localidade-local");
        String situacaoLocal = request.getParameter("situacao-local");
        String nomeLocal = request.getParameter("nome-local");
        String descricaoLocal = request.getParameter("descricao-local");
        String latitudeLocal = request.getParameter("latitude-local");
        String longitudeLocal = request.getParameter("longitude-local");

        // Tratamento para entrada nula ou vazia
        if (localidadeLocal == null || localidadeLocal.trim().isEmpty() ||
            situacaoLocal == null || situacaoLocal.trim().isEmpty() ||
            nomeLocal == null || nomeLocal.trim().isEmpty() ||
            descricaoLocal == null || descricaoLocal.trim().isEmpty() ||
            latitudeLocal == null || latitudeLocal.trim().isEmpty() ||
            longitudeLocal == null || longitudeLocal.trim().isEmpty()) {
            mensagem = "Todos os campos são obrigatórios. Preencha corretamente.";
        } else {
            Local novoLocal = new Local(localidadeLocal, situacaoLocal, nomeLocal, descricaoLocal, latitudeLocal, longitudeLocal);
            boolean sucesso = locaisController.cadastrarLocal(novoLocal);

            if (sucesso) {
                response.sendRedirect("painel-agencia.html");
            } else {
                mensagem = "Erro ao cadastrar local. Tente novamente.";
            }
        }
    }
