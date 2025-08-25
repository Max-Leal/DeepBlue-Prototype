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
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

	<style>
		:root {
			--azul-profundo: #01203a;
			--azul-escuro: #1e3a8a;
			--azul-medio: #3b82f6;
			--azul-agua: #60a5fa;
			--azul-claro: #93c5fd;
		}

		body {
			font-family: 'Poppins', sans-serif;
			margin: 0;
			padding: 0;
			background-color: #f4f6f9;
			display: flex;
			flex-direction: column;
			align-items: center;
			min-height: 100vh;
		}

		/* Container para centralizar o conteúdo do perfil */
		.profile-container {
			margin-top: 120px; /* Espaço para o header */
			background-color: #fff;
			padding: 40px;
			border-radius: 12px;
			box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
			width: 100%;
			max-width: 600px;
			text-align: center; /* Centraliza o texto e o botão */
		}
		
		.profile-container h1 {
			color: var(--azul-profundo);
			margin-bottom: 30px;
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
			font-size: 1.1rem;
			color: #333;
			margin: 10px 0;
			text-align: left; /* Alinha os detalhes à esquerda dentro do container */
			padding-left: 20px;
		}
		
		.profile-details p strong {
			color: var(--azul-escuro);
			min-width: 80px;
			display: inline-block;
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
			margin-top: 20px; /* Espaço acima do botão */
		}

		.btn-primario:hover {
			background: linear-gradient(45deg, var(--azul-claro), var(--azul-medio));
		}
	</style>
</head>

<body>
<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
%>
<script>
    window.usuarioLogado = <%= usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null" %>;
    window.usuarioEmail = <%= usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null" %>;
</script>

		<script src="static/js/header.js"></script>

	<%
		// Medida de segurança: se não houver usuário logado, redireciona para a página de login
		if (usuarioLogado == null) {
			response.sendRedirect("login.jsp");
			return; // Interrompe a renderização da página
		}
	%>

	<script>
		window.usuarioLogado = <%= usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null" %>;
		window.usuarioEmail = <%= usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null" %>;
	</script>
	
	<div class="profile-container">
		
		<h1>Meu Perfil</h1>

		<img src="${sessionScope.usuarioLogado.foto != null ? sessionScope.usuarioLogado.foto : 'static/images/default-avatar.png'}" 
			 alt="Foto de Perfil" class="profile-picture">

		<div class="profile-details">
			<p><strong>Nome:</strong> ${sessionScope.usuarioLogado.nome}</p>
			<p><strong>Email:</strong> ${sessionScope.usuarioLogado.email}</p>
			</div>

		<button onclick="window.location.href='editar-usuario.jsp'" class="btn-primario">Editar Dados</button>
	
	</div>
		<jsp:include page="components/chat.jsp" />
	</body>
</html>