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
            Agencia agencia = new Agencia(nomeEmpresarial,cnpj,email,senha,situacao);
         
            AgenciaController agenciaControl = new AgenciaController();
            if (nomeEmpresarial.trim().isEmpty() || cnpj.trim().isEmpty() || email.trim().isEmpty() || senha.trim().isEmpty()) {
                mensagem = "Dados inválidos. Verifique as informações e tente novamente.";
                throw new Exception(mensagem);
            }
            agenciaControl.registerAgencia(agencia);
            response.sendRedirect("login-agencia.html");
        } catch (Exception e) {
            mensagem = "Erro ao cadastrar agência: " + e.getMessage();
        }
    } else {
        mensagem = "Preencha todos os campos do formulário.";
    }
    response.sendRedirect("login-agencia.html");


%>
