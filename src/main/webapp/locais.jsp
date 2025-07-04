<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="controllers.LocalController" %>
<%@ page import="models.Local" %>
<%@ page import="java.util.List" %>
<%
    LocalController localController = new LocalController();
    List<Local> listaLocais = localController.listaLocais();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <title>Lista de Locais</title>
<link rel="stylesheet" href="static/css/main-styles.css">
</head>
<body>
	   <div class="page-wrapper">
    <header class="header" id="header">
        <div class="logo">DeepBlue SC</div>
        <nav>
            <a href="index.html"><i class="fas fa-home"></i> Início</a>
            <a href="mapaInterativo.jsp"><i class="fas fa-map"></i> Mapa Interativo</a>
            <a href="locais.jsp"><i class="fas fa-map-marker-alt"></i> Locais</a>
            <a href="agencias.jsp"><i class="fas fa-search"></i> Agências</a>
            <a href="faq.html"><i class="fas fa-comments"></i> FAQ</a>
            <a href="login-usuario.html"><i class="fas fa-user"></i> Login/Cadastro</a>
        </nav>
            </header>
            
    <h2>Locais Cadastrados</h2>

    <%
        for (Local local : listaLocais) {
    %>
        <div class="local-cards">
            <strong>Localidade:</strong> <%= local.getLocalidade() %><br>
            <strong>Situação:</strong> <%= local.getSituacao() %><br>       
            <strong>Descrição:</strong> <%= local.getDescricao() %><br>
            <strong>Coordenadas:</strong> <%= local.getLongitude() + local.getLatitude()%>
        </div>
    <%
        }
        if (listaLocais.isEmpty()) {
    %>
        <p>Nenhum local cadastrado.</p>
    <%
        }
    %>
    <footer class="footer">
        <p>&copy; 2025 DeepBlue SC. Todos os direitos reservados.</p>
    </footer>
    </div>
</body>
</html>
            
   