<%@ page import="controllers.AgenciaController"%>
<%@ page import="models.Agencia"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>DeepBlue SC - Turismo Náutico em Santa Catarina</title>
<link rel="stylesheet" href="static/css/main-styles.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
<style>
/* Container da seção CRUD */
.agencias-section {
	max-width: 900px;
	margin: 2rem auto;
	background: #f9fafb;
	border-radius: 18px;
	box-shadow: 0 2px 12px rgba(1, 32, 58, 0.08);
	padding: 2rem 1.5rem;
	border: 1px solid #e0e7ef;
}

.agencias-section h2 {
	color: #1e3a5c;
	font-size: 1.6rem;
	margin-bottom: 1.2rem;
	text-align: center;
	letter-spacing: 1px;
}

.agencias-lista {
	display: flex;
	flex-direction: column;
	gap: 1.2rem;
}

/* Card de agência */
.agencia-card {
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(59, 130, 246, 0.08);
	padding: 1.2rem 1.5rem;
	border-left: 6px solid #1e3a5c;
	transition: box-shadow 0.2s;
}

.agencia-card:hover {
	box-shadow: 0 4px 16px rgba(59, 130, 246, 0.15);
}

.agencia-nome {
	font-size: 1.2rem;
	color: #1e3a5c;
	margin-bottom: 0.5rem;
	font-weight: 600;
}

.agencia-info {
	font-size: 1rem;
	color: #333;
}

.agencias-lista p {
	color: #888;
	text-align: center;
	margin: 2rem 0 0 0;
}

/* Botões CRUD (exemplo, caso queira adicionar depois) */
.crud-btn {
	background: #1e3a5c;
	color: #fff;
	border: none;
	border-radius: 6px;
	padding: 0.5rem 1.2rem;
	margin: 0 0.3rem;
	font-size: 1rem;
	cursor: pointer;
	transition: background 0.2s;
}

.crud-btn:hover {
	background: #2563eb;
}
</style>
</head>
<body>
	<header class="header" id="header">
		<div class="logo">DeepBlue SC</div>
        <nav>
            <a href="index.html"><i class="fas fa-home"></i> In�cio</a>
            <a href="mapaInterativo.jsp"><i class="fas fa-map"></i> Mapa Interativo</a>
            <a href="locais.jsp"><i class="fas fa-map-marker-alt"></i> Locais</a>
            <a href="agencias.jsp"><i class="fas fa-search"></i> Ag�ncias</a>
            <a href="faq.html"><i class="fas fa-comments"></i> FAQ</a>
            <a href="login-usuario.html"><i class="fas fa-user"></i> Login/Cadastro</a>
        </nav>
	</header>

	<section class="valores fade-in" id="valores">
		<h2>Nossos Diferenciais</h2>
		<div class="cards">
			<div class="card fade-in">
				<h3>Mapa Interativo</h3>
				<p>Descubra naufrágios, atividades e pontos turísticos
					filtráveis com nossa tecnologia de ponta.</p>
			</div>
			<div class="card fade-in">
				<h3>Recomendações Personalizadas</h3>
				<p>Encontre experiências sob medida para você com base em suas
					preferências e histórico.</p>
			</div>
			<div class="card fade-in">
				<h3>Intermediação Segura</h3>
				<p>Reserve e pague com segurança total, com suporte dedicado
					24/7 para sua tranquilidade.</p>
			</div>
		</div>
	</section>

	<section class="agencias-section fade-in" id="agencias">
		<h2>Agências Cadastradas</h2>
		<div class="agencias-lista">
			<%
			AgenciaController aController = new AgenciaController();
			List<Agencia> agencias = aController.listaAgencias();
			if (agencias != null && !agencias.isEmpty()) {
				for (Agencia agencia : agencias) {
			%>
			<div class="agencia-card">
				<div class="agencia-nome"><%=agencia.getNomeEmpresarial()%></div>
				<div class="agencia-info">
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