<%@ page import="models.Agencia" %>
<%@ page import="controllers.AgenciaController" %>
<%@ page import="Enums.Situacao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String nomeEmpresarial = request.getParameter("nome_empresarial");
    String cnpj = request.getParameter("cnpj");
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");
    String situacaoStr = request.getParameter("situacao");

    String mensagem = "";

    if (nomeEmpresarial != null && cnpj != null && email != null && senha != null && situacaoStr != null) {
        try {
            Situacao situacao = Situacao.valueOf(situacaoStr.toUpperCase());
            Agencia agencia = new Agencia();
            agencia.setNomeEmpresarial(nomeEmpresarial);
            agencia.setCnpj(cnpj);
            agencia.setEmail(email);
            agencia.setSenha(senha);
            agencia.setSituacao(situacao);
            AgenciaController agenciaControl = new AgenciaController();
            agenciaControl.registerAgencia(agencia);
            mensagem = "Cadastro realizado com sucesso! <a href='login-agencia.jsp'>Clique aqui para entrar</a>.";
        } catch (Exception e) {
            mensagem = "Erro ao cadastrar agência: " + e.getMessage();
        }
    } else {
        mensagem = "Preencha todos os campos do formulário.";
    }
%>
<%= mensagem %>