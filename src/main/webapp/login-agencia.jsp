<%@ page import="controllers.AgenciaController" %>
<%@ page import="models.Agencia" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");
String mensagem = null;

    String email = request.getParameter("email");
    String senha = request.getParameter("senha");
    Agencia agencia = null;

    if (email != null && senha != null) {
        AgenciaController agenciaControl = new AgenciaController();
        boolean loginValido = agenciaControl.loginAgencia(email, senha);

        if (loginValido) {
            agencia = agenciaControl.getAgenciaByEmail(email);
            
        }
    }
%>
<% if (agencia != null) { %>
<script>
    // Salva os dados da agência no localStorage (exceto senha)
    localStorage.setItem('agencia', JSON.stringify({
        id: "<%= agencia.getId() %>",
        nomeEmpresarial: "<%= agencia.getNomeEmpresarial() %>",
        email: "<%= agencia.getEmail() %>",
        situacao: "<%= agencia.getSituacao() %>"
    }));
    // Redireciona para a página principal da agência após login
    window.location.href = "index.html";
</script>
<% } %>