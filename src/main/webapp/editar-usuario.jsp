<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="models.Usuario"%>
<%@ page import="controllers.UsuarioController"%>
<%@ page import="utils.HashUtil"%>
<%-- Imports necessários para a lógica de atualização --%>

<%
// Esta variável armazenará mensagens de feedback para o usuário
String errorMessage = null;

// =================================================================
// =========== LÓGICA DE PROCESSAMENTO DO FORMULÁRIO (POST) ========
// =================================================================
if ("POST".equalsIgnoreCase(request.getMethod())) {

	// 1. Instanciar o controller
	UsuarioController usuarioController = new UsuarioController();

	// 2. Obter os parâmetros do formulário
	long id = Long.parseLong(request.getParameter("id"));
	String nome = request.getParameter("nome");
	String email = request.getParameter("email");
	String fotoUrl = request.getParameter("foto"); // Agora é uma URL de texto

	String senhaAtual = request.getParameter("senhaAtual");
	String novaSenha = request.getParameter("novaSenha");
	String confirmarSenha = request.getParameter("confirmarSenha");

	// 3. Obter o usuário atual do banco para ter os dados mais recentes (especialmente a senha)
	Usuario usuarioParaAtualizar = usuarioController.getUsuarioById(id);

	if (usuarioParaAtualizar != null) {

		// 4. Atualizar os campos básicos
		usuarioParaAtualizar.setNome(nome);
		usuarioParaAtualizar.setEmail(email);
		usuarioParaAtualizar.setFoto(fotoUrl);

		// 5. Lógica de atualização de senha
		boolean senhaValida = true; // Assume que a senha é válida até que se prove o contrário
		if (novaSenha != null && !novaSenha.isEmpty()) {

	// Se o usuário quer mudar a senha, a senha atual DEVE ser fornecida
	if (senhaAtual == null || senhaAtual.isEmpty()) {
		errorMessage = "Para alterar a senha, você deve fornecer sua senha atual.";
		senhaValida = false;
	}
	// Verifica se a senha atual corresponde à do banco de dados
	else if (!HashUtil.verificarSenha(senhaAtual, usuarioParaAtualizar.getSenha())) {
		errorMessage = "A senha atual está incorreta.";
		senhaValida = false;
	}
	// Verifica se a nova senha e a confirmação são iguais
	else if (!novaSenha.equals(confirmarSenha)) {
		errorMessage = "A nova senha e a confirmação não correspondem.";
		senhaValida = false;
	}
	// Se todas as verificações passaram, atualiza a senha
	else {
		usuarioParaAtualizar.setSenhaHash(novaSenha); // O método já faz o hash
	}
		}

		// 6. Se não houve erros de senha, prosseguir com a atualização
		if (senhaValida) {
	try {
		usuarioController.updateUsuario(id, usuarioParaAtualizar);

		// 7. CRÍTICO: Atualizar o objeto na sessão para refletir as mudanças!
		session.setAttribute("usuarioLogado", usuarioParaAtualizar);

		// 8. Adiciona uma mensagem de sucesso na sessão para exibir na próxima página
		session.setAttribute("successMessage", "Perfil atualizado com sucesso!");

		response.sendRedirect("home.jsp");
		return; // Impede que o resto da página seja executado após o redirect

	} catch (Exception e) {
		errorMessage = "Ocorreu um erro ao atualizar o perfil: " + e.getMessage();
	}
		}
	} else {
		errorMessage = "Usuário não encontrado. Por favor, faça login novamente.";
	}
}
// Fim da lógica de POST

// Obtém o usuário da sessão para preencher o formulário no caso de um GET ou de um erro no POST
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

// Medida de segurança: se não houver usuário logado, redireciona
if (usuarioLogado == null) {
	response.sendRedirect("logout.jsp"); // Usar logout.jsp para invalidar a sessão
	return;
}
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Editar Perfil - DeepBlue</title>
<%-- O restante do seu CSS e links do <head> permanece o mesmo --%>
<link rel="stylesheet" href="static/css/main-styles.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">
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
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	padding: 2rem 0;
}

.form-container {
	margin-top: 100px;
	background-color: #fff;
	padding: 40px;
	border-radius: 12px;
	box-shadow: 0 4px 15px rgba(0, 0, 0, 0.1);
	width: 100%;
	max-width: 650px;
}

.form-container h1 {
	color: var(--azul-profundo);
	text-align: center;
	margin-bottom: 20px;
}

.current-photo-section {
	text-align: center;
	margin-bottom: 20px;
}

.profile-picture {
	width: 120px;
	height: 120px;
	border-radius: 50%;
	object-fit: cover;
	border: 4px solid var(--azul-agua);
}

.form-group {
	margin-bottom: 1.5rem;
}

.form-group label {
	display: block;
	margin-bottom: 8px;
	font-weight: 500;
	color: var(--azul-escuro);
}

.input-padrao, .input-text {
	width: 100%;
	padding: 0.7rem 1rem;
	border: 1px solid var(--azul-claro);
	border-radius: 8px;
	font-size: 1rem;
	outline: none;
	transition: 0.3s;
	font-family: 'Poppins', sans-serif;
	box-sizing: border-box;
}

.input-padrao:focus {
	border-color: var(--azul-medio);
	box-shadow: 0 0 5px rgba(59, 130, 246, 0.3);
}

.password-note {
	font-size: 0.85rem;
	color: #555;
	margin-top: 5px;
}

.button-group {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-top: 30px;
}

.btn {
	border: none;
	padding: 0.8rem 2rem;
	border-radius: 30px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	font-size: 1rem;
	text-decoration: none;
	text-align: center;
}

.btn-primario {
	background: linear-gradient(45deg, var(--azul-medio), var(--azul-agua));
	color: white;
}

.btn-primario:hover {
	background: linear-gradient(45deg, var(--azul-claro), var(--azul-medio));
}

.btn-secundario {
	background-color: transparent;
	color: var(--azul-medio);
	border: 2px solid var(--azul-medio);
}

.btn-secundario:hover {
	background-color: var(--azul-medio);
	color: white;
}

.error-message {
	background-color: #f8d7da;
	color: #721c24;
	border: 1px solid #f5c6cb;
	padding: 1rem;
	border-radius: 8px;
	margin-bottom: 20px;
	text-align: center;
}
</style>
</head>

<body>

	<script>
    window.usuarioLogado = <%= usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null" %>;
    window.usuarioEmail = <%= usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null" %>;
	</script>
	<script src="static/js/header.js"></script>

	<div class="form-container">
		<h1>Editar Perfil</h1>

		<%-- Exibe a mensagem de erro, se houver alguma --%>
		<%
		if (errorMessage != null) {
		%>
		<div class="error-message">
			<%=errorMessage%>
		</div>
		<%
		}
		%>

		<form action="editar-usuario.jsp" method="POST">

			<input type="hidden" name="id"
				value="${sessionScope.usuarioLogado.id}">

			<div class="current-photo-section">
				<label>Foto Atual</label><br> <img
					src="${sessionScope.usuarioLogado.foto != null && !sessionScope.usuarioLogado.foto.isEmpty() ? sessionScope.usuarioLogado.foto : 'static/images/default-avatar.png'}"
					alt="Foto de Perfil" class="profile-picture">
			</div>

			<div class="form-group">
				<label for="foto">URL da Foto de Perfil</label> <input type="text"
					id="foto" name="foto" class="input-text"
					placeholder="Insira a URL da sua imagem de perfil"
					value="${sessionScope.usuarioLogado.foto}">
			</div>

			<div class="form-group">
				<label for="nome">Nome</label> <input type="text" id="nome"
					name="nome" class="input-padrao"
					value="${sessionScope.usuarioLogado.nome}" required>
			</div>

			<div class="form-group">
				<label for="email">Email</label> <input type="email" id="email"
					name="email" class="input-padrao"
					value="${sessionScope.usuarioLogado.email}" required>
			</div>

			<hr style="margin: 30px 0; border: 1px solid #eee;">

			<div class="form-group">
				<label for="senhaAtual">Senha Atual</label> <input type="password"
					id="senhaAtual" name="senhaAtual" class="input-padrao"
					placeholder="Digite sua senha atual para alterá-la">
				<p class="password-note">Preencha os três campos de senha apenas
					se desejar alterá-la.</p>
			</div>

			<div class="form-group">
				<label for="novaSenha">Nova Senha</label> <input type="password"
					id="novaSenha" name="novaSenha" class="input-padrao"
					placeholder="Mínimo 6 caracteres">
			</div>

			<div class="form-group">
				<label for="confirmarSenha">Confirmar Nova Senha</label> <input
					type="password" id="confirmarSenha" name="confirmarSenha"
					class="input-padrao" placeholder="Repita a nova senha">
			</div>

			<div class="button-group">
				<a href="home.jsp" class="btn btn-secundario">Cancelar</a>
				<button type="submit" class="btn btn-primario">Salvar
					Alterações</button>
			</div>
		</form>
	</div>
</body>
</html>