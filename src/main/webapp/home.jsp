<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="models.Usuario, models.AvaliacaoAgencia"%>
<%@ page import="controllers.AvaliacaoAgenciaController"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="java.util.*"%>

<%
// A instância do controller é criada aqui para ser usada no corpo da página
AvaliacaoAgenciaController aac = new AvaliacaoAgenciaController();
%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
<meta charset="UTF-8">
<title>Meu Perfil - DeepBlue</title>
<link rel="stylesheet" href="static/css/main-styles.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<style>
/* ====== 1. ESTILOS GLOBAIS E VARIÁVEIS ====== */
:root {
	--azul-profundo: #01203a;
	--azul-escuro: #1e3a8a;
	--azul-medio: #3b82f6;
	--azul-agua: #60a5fa;
	--azul-claro: #93c5fd;
	--fundo-pagina: #eef2f9;
	--cor-card: #ffffff;
	--cor-texto: #333;
	--cor-borda-suave: #eee;
}

/* Boa prática para um controle de layout mais previsível */
*, *::before, *::after {
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	margin: 0;
	padding: 0;
	background-color: var(--fundo-pagina);
	color: var(--cor-texto);
	min-height: 100vh;
}

/* ====== 2. LAYOUT DO DASHBOARD COM CSS GRID ====== */
.dashboard-container {
	display: grid;
	grid-template-columns: 2fr 5fr 3fr;
	gap: 30px; 
	align-items: start;
	margin: 7.5% 2.5%; 
}

/* ====== 3. ESTILOS DOS CARDS ====== */
.dashboard-card {
	background-color: var(--cor-card);
	padding: 30px;
	border-radius: 12px;
	box-shadow: 0 4px 20px rgba(0, 0, 0, 0.07);
}

.dashboard-card h1, .dashboard-card h2 {
	color: var(--azul-profundo);
	margin-top: 0;
	margin-bottom: 25px;
	padding-bottom: 15px;
	border-bottom: 1px solid var(--cor-borda-suave);
	font-size: 1.3rem;
}

/* Card de perfil específico */
.profile-card {
	text-align: center;
}

.profile-picture {
	width: 150px;
	height: 150px;
	border-radius: 50%;
	object-fit: cover;
	margin-bottom: 20px;
	border: 4px solid var(--azul-agua);
}

.profile-details p {
	font-size: 1rem;
	margin: 10px 0;
	text-align: left;
}

.profile-details p strong {
	color: var(--azul-escuro);
	min-width: 70px;
	display: inline-block;
}

/* Coluna da direita e seus cards */
.right-column {
	display: flex;
	flex-direction: column;
	gap: 30px;
}

/* Itens de comentário */
.comment-item {
	border-bottom: 1px solid var(--cor-borda-suave);
	padding-bottom: 15px;
	margin-bottom: 15px;
}
.comment-item:last-child {
	border-bottom: none;
	margin-bottom: 0;
	padding-bottom: 0;
}
.comment-header, .comment-body, .comment-footer {
	margin: 0;
	padding: 4px 0;
}
.comment-footer small {
	color: #888;
}

/* Botão primário */
.btn-primario {
	background: linear-gradient(45deg, var(--azul-medio), var(--azul-agua));
	color: white;
	border: none;
	padding: 0.8rem 2rem;
	border-radius: 30px;
	font-weight: 600;
	cursor: pointer;
	transition: background 0.3s ease;
	font-size: 1rem;
	margin-top: 20px;
	width: 100%;
}
.btn-primario:hover {
	background: linear-gradient(45deg, var(--azul-claro), var(--azul-medio));
}


/* ====== 4. DESIGN RESPONSIVO (MOBILE) ====== */
@media (max-width: 1200px) {
	/* Para tablets e telas menores, ajusta as colunas fixas */
	.dashboard-container {
		grid-template-columns: 280px 1fr 280px;
		width: calc(100% - 40px);
		gap: 20px;
	}
}

@media (max-width: 992px) {
	/* Para celulares, o layout vira uma coluna única */
	.dashboard-container {
		grid-template-columns: 1fr; /* Apenas uma coluna */
		margin-top: 90px;
	}
}
</style>
</head>

<body>
	<%
	Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

	// Medida de segurança: se não houver usuário logado, redireciona para a página de login
	if (usuarioLogado == null) {
		response.sendRedirect("login-usuario.jsp");
		return; // Interrompe a renderização da página
	}
	%>

	<script>
		window.usuarioLogado = <%=usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null"%>;
		window.usuarioEmail = <%=usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null"%>;
	</script>

	<script src="static/js/header.js"></script>

	<div class="dashboard-container">

		<div class="dashboard-card profile-card">
			<h1>Meu Perfil</h1>
			<img
				src="${sessionScope.usuarioLogado.foto != null && !sessionScope.usuarioLogado.foto.isEmpty() ? sessionScope.usuarioLogado.foto : 'static/images/default-avatar.png'}"
				alt="Foto de Perfil" class="profile-picture">
			<div class="profile-details">
				<p>
					<strong>Nome:</strong> ${sessionScope.usuarioLogado.nome}
				</p>
				<p>
					<strong>Email:</strong> ${sessionScope.usuarioLogado.email}
				</p>
			</div>
			<button onclick="window.location.href='editar-usuario.jsp'"
				class="btn-primario">Editar Dados</button>
		</div>

		<div class="dashboard-card comments-card">
			<h2>Últimos comentários sobre agências</h2>
			<%
			List<AvaliacaoAgencia> ultimasAvaliacoes = aac.getUltimasAvaliacoes(4);
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
			
			if (ultimasAvaliacoes == null || ultimasAvaliacoes.isEmpty()) {
			%>
				<p>Nenhum comentário recente para exibir.</p>
			<%
			} else {
				for (AvaliacaoAgencia avaliacao : ultimasAvaliacoes) {
			%>
					<div class="comment-item">
						<p class="comment-header">
							<% for (int i = 1; i <= 5; i++) { %>
								<span style="color: <%= (i <= avaliacao.getEscala()) ? "gold" : "#ccc" %>;">&#9733;</span>
							<% } %><br>
							<strong><%=avaliacao.getNomeUsuario()%></strong> avaliou a agência <strong><%=avaliacao.getNomeAgencia()%></strong>
						</p>
						<p class="comment-body">
							<em>"<%=avaliacao.getSugestao()%>"</em>
						</p>
						<p class="comment-footer">
							<small><%=avaliacao.getDataAvaliacao().format(formatter)%></small>
						</p>
					</div>
			<%
				} // Fim do for
			} // Fim do else
			%>
		</div>

		<div class="right-column">
			<div class="dashboard-card agencies-card">
				<h2>TOP 5 AGENCIAS</h2>
				<p>Nenhuma agência no ranking.</p>
			</div>
			<div class="dashboard-card places-card">
				<h2>TOP 5 LUGARES</h2>
				<p>Nenhum lugar no ranking.</p>
			</div>
		</div>

	</div>
	<jsp:include page="components/chat.jsp" />
</body>
</html>