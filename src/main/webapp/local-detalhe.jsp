<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="models.Local, controllers.LocalController" %>
<%
    String idParam = request.getParameter("id");
    Local local = null;

    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);
            LocalController controller = new LocalController();
            local = controller.getLocalById(id);
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
    <title><%= (local != null) ? local.getNome() : "Local não encontrado" %></title>

    <!-- Estilos principais -->
    <link rel="stylesheet" href="static/css/main-styles.css">

    <!-- Ícones FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Mapa Leaflet -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

    <style>
        #mapa {
            width: 100%;
            height: 400px;
            border-radius: 20px;
            margin-top: 2rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .detalhes-container {
            margin-top: 120px;
            padding: 3rem 2rem;
            max-width: 1000px;
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

<!-- Cabeçalho fixo -->
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
<% if (local != null) { %>
    <h1><%= local.getNome() %></h1>
    <p><strong>Localidade:</strong> <%= local.getLocalidade() %></p>
    <p><strong>Descrição:</strong> <%= local.getDescricao() %></p>
    <p><strong>Situação:</strong> <%= local.getSituacao() %></p>

    <div id="mapa"></div>

    <script>
    document.addEventListener('DOMContentLoaded', () => {
		  const el = document.getElementById("informacoes-login");
		  const usuario = localStorage.getItem("usuario");
		  const agencia = localStorage.getItem("agencia");

		  const dados = usuario ? JSON.parse(usuario) : agencia ? JSON.parse(agencia) : null;
		  const nome = dados?.nome || dados?.nomeEmpresarial;
		  const email = dados?.email;

		  if (el && nome && email) {
		    const div = document.createElement("div");
		    div.className = "usuario-logado";

		    ["Bem-vindo, " + nome, email].forEach(text => {
		      div.appendChild(document.createTextNode(text));
		      div.appendChild(document.createElement("br"));
		    });

		    const btn = document.createElement("button");
		    btn.textContent = "Sair";
		    btn.id = "logout-btn";
		    btn.style.marginTop = "0.5rem";
		    btn.onclick = () => {
		      localStorage.removeItem("usuario");
		      localStorage.removeItem("agencia");
		      location.reload();
		    };

		    div.appendChild(btn);
		    el.replaceWith(div);
		  }
		});



		function logout() {
		  localStorage.removeItem("usuario");
		  localStorage.removeItem("agencia");
		  location.reload();
		}
  	
        const lat = parseFloat("<%= local.getLatitude() %>");
        const lng = parseFloat("<%= local.getLongitude() %>");
        const map = L.map('mapa').setView([lat, lng], 13);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 18
        }).addTo(map);

        L.marker([lat, lng])
            .addTo(map)
            .bindPopup("<%= local.getNome() %>")
            .openPopup();
    </script>
<% } else { %>
    <h1>Local não encontrado</h1>
    <p>Verifique se o ID está correto na URL.</p>
<% } %>
</main>

<footer class="footer">
    &copy; 2025 DeepBlue. Todos os direitos reservados.
</footer>

</body>
</html>
