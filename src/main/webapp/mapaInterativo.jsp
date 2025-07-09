<%@ page import="controllers.LocalController"%>
<%@ page import="models.Local"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
<meta charset="UTF-8">
<title>Mapa Interativo - DeepBlue</title>
<link rel="stylesheet" href="static/css/main-styles.css">
<link rel="stylesheet" href="static/css/mapa-styles.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" crossorigin="" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
	crossorigin=""></script>
</head>

<body>
	<header class="header" id="header">
		<div class="logo">DeepBlue</div>
		<nav>
			<a href="index.html"><i class="fas fa-home"></i> Início</a> <a
				href="mapaInterativo.jsp"><i class="fas fa-map"></i> Mapa
				Interativo</a> <a href="locais.jsp"><i class="fas fa-map-marker-alt"></i>
				Locais</a> <a href="agencias.jsp"><i class="fas fa-search"></i>
				Agências</a> <a href="faq.html"><i class="fas fa-comments"></i> FAQ</a>
			<a href="login-usuario.html" id="informacoes-login"><i
				class="fas fa-user"></i> Login/Cadastro</a>
		</nav>
	</header>
	<main>
		<div style="position: relative;">
			<div class="faixa-superior"></div>
			<section class="mapa-container">
				<div id="map"></div>
			</section>
		</div>
	</main>
	<footer class="footer">
		<p>&copy; 2025 DeepBlue. Todos os direitos reservados.</p>
	</footer>

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
		  location.reload();
		}

        // Header scroll effect
        window.addEventListener('scroll', () => {
            const header = document.getElementById('header');
            if (window.scrollY > 100) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });

    <%
        LocalController lController = new LocalController();
        List<Local> lista = lController.listaLocais();
    %>
        // Centralize o mapa no primeiro local, se houver
        <% if (lista != null && !lista.isEmpty()) { %>
            var map = L.map('map').setView([<%= lista.get(0).getLatitude() %>, <%= lista.get(0).getLongitude() %>], 9);
        <% } else { %>
            var map = L.map('map').setView([0, 0], 2);
        <% } %>
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        // Adicione os marcadores dinamicamente
        <% for (Local local : lista) { %>
            L.marker([<%= local.getLatitude() %>, <%= local.getLongitude() %>])
                .addTo(map)
                .bindPopup('<b><%= local.getNome() %></b><br><%= local.getDescricao() %><br><a href="local-detalhe.jsp?id=<%= local.getId() %>">Ver detalhes</a>');
        <%}%>
        
    </script>

</body>

</html>