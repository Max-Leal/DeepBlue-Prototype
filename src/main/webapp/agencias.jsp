<%@ page import="controllers.AgenciaController"%>
<%@ page import="models.Agencia"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>DeepBlue SC - Turismo N�utico em Santa Catarina</title>
<link rel="stylesheet" href="static/css/main-styles.css">
<link rel="stylesheet" href="static/css/crud-styles.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

</head>
<body>
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


	<section class="crud-section" id="agencias">
		<h1 class="crud-titulo">Agências Cadastradas</h1>
		<div class="crud-lista">
			<%
			AgenciaController aController = new AgenciaController();
			List<Agencia> agencias = aController.listaAgencias();
			if (agencias != null && !agencias.isEmpty()) {
				for (Agencia agencia : agencias) {
			%>
			<div class="crud-card">
				<div class="crud-nome"><%=agencia.getNomeEmpresarial()%></div>
				<div class="crud-info">
					<b>CNPJ:</b>
					<%=agencia.getCnpj()%><br> <b>Email:</b>
					<%=agencia.getEmail()%><br> <b>Situação:</b>
					<%=agencia.getSituacao()%>
				</div>
			</div>
			<%
			}
			} else {
			%>
			<p>Nenhuma agência cadastrada no momento.</p>
			<%
			}
			%>
		</div>
	</section>

	<footer class="footer">
		<p>&copy; 2025 DeepBlue SC. Todos os direitos reservados.</p>
	</footer>

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