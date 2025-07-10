<%@ page import="controllers.LocalController" %>
<%@ page import="controllers.AgenciaLocalController" %>
<%@ page import="models.Local" %>
<%@ page import="models.AgenciaLocal" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String mensagem = "";

    if (request.getMethod().equalsIgnoreCase("POST")) {
        String localidadeLocal = request.getParameter("localidade-local");
        String situacaoLocal = request.getParameter("situacao-local");
        String nomeLocal = request.getParameter("nome-local");
        String descricaoLocal = request.getParameter("descricao-local");
        String latitudeLocal = request.getParameter("latitude-local");
        String longitudeLocal = request.getParameter("longitude-local");
        String idAgenciaStr = request.getParameter("idAgencia");

        if (localidadeLocal == null || situacaoLocal == null || nomeLocal == null || descricaoLocal == null ||
            latitudeLocal == null || longitudeLocal == null || idAgenciaStr == null ||
            localidadeLocal.trim().isEmpty() || situacaoLocal.trim().isEmpty() || nomeLocal.trim().isEmpty() ||
            descricaoLocal.trim().isEmpty() || latitudeLocal.trim().isEmpty() || longitudeLocal.trim().isEmpty()) {

            mensagem = "Todos os campos são obrigatórios. Preencha corretamente.";
        } else {
            int idAgencia = Integer.parseInt(idAgenciaStr);

            LocalController localController = new LocalController();
            Local novoLocal = new Local(localidadeLocal, situacaoLocal, nomeLocal, descricaoLocal, latitudeLocal, longitudeLocal);

            int idLocalInserido = localController.cadastrarLocalRetornandoId(novoLocal); // esse método retorna o ID

            if (idLocalInserido > 0) {
                AgenciaLocalController alc = new AgenciaLocalController();
                alc.adicionar(new AgenciaLocal(idAgencia, idLocalInserido));
                response.sendRedirect("painel-agencia.jsp");
            } else {
                mensagem = "Erro ao cadastrar local.";
            }
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Cadastro de Local</title>
</head>
<body>
<% if (!mensagem.isEmpty()) { %>
    <h3><%= mensagem %></h3>
<% } %>
</body>
</html>