<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="controllers.AgenciaController"%>
<%@ page import="models.Agencia"%>
<%@ page import="models.Usuario"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>DeepBlue - Turismo Náutico em Santa Catarina</title>
<link rel="stylesheet" href="static/css/crud-styles.css">
<link rel="stylesheet" href="static/css/main-styles.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

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
	margin-bottom: 20px;
	margin-top: 20px;
	padding-bottom: 20px;
	max-width: 100%;
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

	<%
	Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
	Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
	%>
	<script>
    window.usuarioLogado = <%=usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null"%>;
    window.usuarioEmail = <%=usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null"%>;
    window.agenciaLogada = <%=agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null"%>;
    window.agenciaEmail = <%=agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null"%>;
</script>

	<script src="static/js/header.js"></script>
	<section class="crud-section" id="agencias">
		<h1 class="crud-titulo">Agências Cadastradas</h1>
		<div class="search-container">
			<form method="get" action="agencias.jsp"
				style="display: flex; width: 100%;">
				<input type="text" name="query" placeholder="Buscar por nome..."
					style="flex-grow: 1;">
				<button type="submit">Buscar</button>
			</form>
		</div>
		<div class="crud-lista">
			<%
			String query = request.getParameter("query");
			AgenciaController aController = new AgenciaController();

			List<Agencia> todasAgencias = aController.listaAgencias();
			List<Agencia> agenciasFiltradas = new ArrayList<>();

			if (query != null && !query.trim().isEmpty()) {
				for (Agencia agencia : todasAgencias) {
					if (agencia.getNomeEmpresarial().toLowerCase().contains(query.toLowerCase())) {
				agenciasFiltradas.add(agencia);
					}
				}
			} else {
				agenciasFiltradas = todasAgencias;
			}

			if (agenciasFiltradas != null && !agenciasFiltradas.isEmpty()) {
				for (Agencia agencia : agenciasFiltradas) {
			%>
			<div class="crud-card">
				<div class="crud-nome"><%=agencia.getNomeEmpresarial()%></div>
				<div class="crud-info">
					<b>CNPJ:</b>
					<%=agencia.getCnpj()%><br> <b>Email:</b>
					<%=agencia.getEmail()%><br> <b>Situação:</b>
					<%=agencia.getSituacao()%>
				</div>
				<div style="margin-top: 1rem;">
					<a href="agencia-detalhe.jsp?id=<%=agencia.getId()%>"
						class="cta-btn">Ver Detalhes</a>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<p>Nenhuma agência encontrada.</p>
			<%
			}
			%>
		</div>
	</section>

	

	<jsp:include page="components/chat.jsp" />
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
        
    </script>
</body>
</html>