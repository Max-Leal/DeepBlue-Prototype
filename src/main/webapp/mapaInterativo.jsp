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

.search-container {
	display: flex;
	margin: auto;
	padding-bottom: 20px;
	max-width: 900px;
}

.search-container input[type="text"] {
	border: 1px solid #013a6b;
	padding: 10px;
	margin: 0;
	border-radius: 0; /* Define as bordas quadradas */
	flex-grow: 1; /* Permite que o input ocupe o espaço disponível */
	font-size: 1rem;
	border-right: none; /* Remove a borda direita para unir ao botão */
}

.search-container button {
	padding: 10px 20px;
	border: 1px solid #013a6b;
	background-color: #013a6b;
	color: white;
	cursor: pointer;
	margin: 0;
	border-radius: 0; /* Define as bordas quadradas */
	font-size: 1rem;
}

.search-container button:hover {
	background-color: #02579b; /* Cor para o efeito hover */
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

		<main>
			<script src="static/js/header.js"></script>

			<div style="position: relative; margin: 9%;">
				<div class="search-container">
					<form method="get" action="mapaInterativo.jsp"
						style="display: flex; width: 100%;">
						<input type="text" name="query" placeholder="Buscar por nome..."
							style="flex-grow: 1;">
						<button type="submit">Buscar</button>
					</form>
				</div>
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
        <%}%>

    </script>

	<jsp:include page="components/chat.jsp" />
</body>

</html>