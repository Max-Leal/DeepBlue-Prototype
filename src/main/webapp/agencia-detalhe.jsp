<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="models.Agencia, controllers.AgenciaController" %>
<%@ page import="Enums.Situacao" %>
<%
    String idParam = request.getParameter("id");
    Agencia agencia = null;

    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);
            AgenciaController controller = new AgenciaController();
            agencia = controller.getAgenciaById(id);
        } catch (NumberFormatException e) {
            out.println("<p>ID inválido!</p>");
        }
    } else {
        out.println("<p>ID não fornecido!</p>");
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title><%= (agencia != null) ? agencia.getNomeEmpresarial() : "Agência não encontrada" %></title>

    <link rel="stylesheet" href="static/css/main-styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        .detalhes-container {
            margin-top: 120px;
            padding: 3rem 2rem;
            max-width: 800px;
            margin-left: auto;
            margin-right: auto;
            background: var(--cinza-claro);
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
        }

        .detalhes-container h1 {
            font-size: 2.5rem;
            color: var(--azul-escuro);
            margin-bottom: 1rem;
        }

        .detalhes-container p {
            font-size: 1.1rem;
            margin-bottom: 0.8rem;
            color: var(--cinza-medio);
        }
    </style>
</head>
<body>

<header class="header" id="header">
    <div class="logo">DeepBlue</div>
    <nav>
        <a href="index.html"><i class="fas fa-home"></i> Início</a>
        <a href="mapaInterativo.jsp"><i class="fas fa-map"></i> Mapa Interativo</a>
        <a href="locais.jsp"><i class="fas fa-map-marker-alt"></i> Locais</a>
        <a href="agencias.jsp"><i class="fas fa-search"></i> Agências</a>
        <a href="faq.html"><i class="fas fa-comments"></i> FAQ</a>
        <a href="login-usuario.html" id="informacoes-login"><i class="fas fa-user"></i> Login/Cadastro</a>
    </nav>
</header>

<main class="detalhes-container">
<% if (agencia != null) { %>
    <h1><%= agencia.getNomeEmpresarial() %></h1>
    <p><strong>CNPJ:</strong> <%= agencia.getCnpj() %></p>
    <p><strong>Email:</strong> <%= agencia.getEmail() %></p>
    <p><strong>Situação:</strong> <%= agencia.getSituacao().toString().toLowerCase().replace("_", " ") %></p>
<% } else { %>
    <h1>Agência não encontrada</h1>
    <p>Verifique se o ID está correto na URL.</p>
<% } %>
</main>

<footer class="footer">
    &copy; 2025 DeepBlue. Todos os direitos reservados.
</footer>

</body>
</html>
