<%@ page import="controllers.LocalController"%>
<%@ page import="models.Local, models.Agencia, models.Usuario"%>
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
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	background: linear-gradient(135deg, var(--azul-profundo) 0%,
		var(--azul-agua) 100%);
	min-height: 100vh;
	position: relative;
	display: flex;
	flex-direction: column;
}

body::before {
	content: '';
	position: fixed;
	top: 0;
	left: 0;
	right: 0;
	bottom: 0;
	background:
		url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 320'%3E%3Cpath fill='%23ffffff' fill-opacity='0.1' d='M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z'%3E%3C/path%3E%3C/svg%3E")
		bottom repeat-x;
	z-index: -1;
}
</style>
</head>

<body>
	<div class="page-wrapper">
		<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
%>
		<script>
    window.usuarioLogado = <%= usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null" %>;
    window.usuarioEmail = <%= usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null" %>;
    window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
    window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
</script>
		<!--<script src="static/js/header.js"></script>-->
		<main>
			<div>
				<form method="get" action="mapaInterativo.jsp">
					<input type="text" name="query" placeholder="Buscar por nome...">
					<button type="submit">Buscar</button>
				</form>
			</div>
			<div style="position: relative; margin: 9%;">
				<section class="mapa-container">
					<div id="map"></div>
				</section>
			</div>
		</main>
		<div style="margin: 4%"></div>
		<footer class="footer" style="background-color: #01203a">
			<p>&copy; 2025 DeepBlue. Todos os direitos reservados.</p>
		</footer>
	</div>
	
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

     // Adicione os marcadores dinamicamente com filtro da query
        <%
            String query = request.getParameter("query");
            LocalController controller = new LocalController();
            List<Local> todosLocais = controller.listaLocais();

            List<Local> locais = new ArrayList<>();

            if (query != null && !query.trim().isEmpty()) {
                for (Local local : todosLocais) {
                    if (local.getNome().toLowerCase().contains(query.toLowerCase())) {
                        locais.add(local);
                    }
                }
            } else {
                locais = todosLocais;
            }
        %>

        <% for (Local local : locais) { %>
            L.marker([<%= local.getLatitude() %>, <%= local.getLongitude() %>])
                .addTo(map)
                .bindPopup('<b><%= local.getNome() %></b><br><%= local.getDescricao() %><br><a href="local-detalhe.jsp?id=<%= local.getId() %>">Ver detalhes</a>');
        <% } %>

    </script>

</body>

</html>