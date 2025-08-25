<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="models.Usuario" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
	<meta charset="UTF-8">
	<title>Meu Perfil - DeepBlue</title>
	<link rel="stylesheet" href="static/css/main-styles.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
		rel="stylesheet">

	<style>
		:root {
			--azul-profundo: #01203a;
			--azul-escuro: #1e3a8a;
			--azul-medio: #3b82f6;
			--azul-agua: #60a5fa;
			--azul-claro: #93c5fd;
			--fundo-dashboard: #eef2f9; /* Cor de fundo do painel principal */
		}

		body {
			font-family: 'Poppins', sans-serif;
			margin: 0;
			padding: 0;
			background-color: var(--fundo-dashboard); /* Alterado para a cor de fundo do dashboard */
			min-height: 100vh;
		}

		/* NOVO: Container principal do dashboard */
		.dashboard-container {
			display: flex;
			gap: 30px;
			padding: 30px;
			margin: 120px auto 40px auto; /* Margem superior para o header */
			max-width: 1400px;
			width: 95%;
		}

		/* NOVO: Estilo genérico para todos os painéis (cards) */
		.dashboard-card {
			background-color: #fff;
			padding: 30px;
			border-radius: 12px;
			box-shadow: 0 4px 20px rgba(0, 0, 0, 0.07);
		}
		
		.dashboard-card h2 {
			color: var(--azul-profundo);
			margin-top: 0;
			padding-bottom: 15px;
			border-bottom: 1px solid #eee;
			font-size: 1.2rem;
		}

		/* Coluna do Perfil (esquerda) */
		.profile-card {
			flex: 0 0 320px; /* Não cresce, não encolhe, largura base de 320px */
			text-align: center;
		}
		
		.profile-card h1 {
			color: var(--azul-profundo);
			margin-bottom: 30px;
			font-size: 1.5rem;
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
			color: #333;
			margin: 10px 0;
			text-align: left;
		}
		
		.profile-details p strong {
			color: var(--azul-escuro);
			min-width: 70px;
			display: inline-block;
		}
		
		/* Coluna de Comentários (central) */
		.comments-card {
			flex: 1; /* Ocupa o espaço restante */
		}
		
		/* NOVO: Wrapper para as colunas da direita */
		.right-column {
			flex: 0 0 320px; /* Largura fixa igual à do perfil */
			display: flex;
			flex-direction: column;
			gap: 30px;
		}

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
	</style>
</head>

<body>
	<%
		Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

		// Medida de segurança: se não houver usuário logado, redireciona para a página de login
		if (usuarioLogado == null) {
			response.sendRedirect("login.jsp");
			return; // Interrompe a renderização da página
		}
	%>

	<script>
		// Passa dados para o JavaScript, se necessário (ex: para o header)
		window.usuarioLogado = <%= usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null" %>;
		window.usuarioEmail = <%= usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null" %>;
	</script>
	
	<script src="static/js/header.js"></script>

	<div class="dashboard-container">
		
		<div class="dashboard-card profile-card">
			<h1>Meu Perfil</h1>
			<img src="${sessionScope.usuarioLogado.foto != null && !sessionScope.usuarioLogado.foto.isEmpty() ? sessionScope.usuarioLogado.foto : 'static/images/default-avatar.png'}" 
				 alt="Foto de Perfil" class="profile-picture">
			<div class="profile-details">
				<p><strong>Nome:</strong> ${sessionScope.usuarioLogado.nome}</p>
				<p><strong>Email:</strong> ${sessionScope.usuarioLogado.email}</p>
			</div>
			<button onclick="window.location.href='editar-usuario.jsp'" class="btn-primario">Editar Dados</button>
		</div>

		<div class="dashboard-card comments-card">
			<h2>Últimos comentários</h2>
			
			<p>Nenhum comentário recente para exibir.</p>
			
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