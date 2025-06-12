<!-- filepath: c:\Users\Usuario\OneDrive\Área de Trabalho\Workspaces\.java\ENTRA21\DeepBlue-Prototype\src\main\webapp\registrar.jsp -->
<%@ page import="models.Usuario" %>
<%@ page import="Enums.TipoUsuario" %>
<%@ page import="controllers.UsuarioController" %>
<%@ page import="java.time.LocalDate" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	
	UsuarioController userControl = new UsuarioController();

    request.setCharacterEncoding("UTF-8");

    String nome = request.getParameter("nome");
    String dataNascimentoStr = request.getParameter("data_nascimento");
    String cpf = request.getParameter("cpf");
    String email = request.getParameter("email");
    String senha = request.getParameter("senha");
    String tipoStr = request.getParameter("tipo");

    String mensagem = "";

    if (nome != null && dataNascimentoStr != null && cpf != null && email != null && senha != null && tipoStr != null) {
        try {
            LocalDate dataNascimento = LocalDate.parse(dataNascimentoStr);
            TipoUsuario tipo = TipoUsuario.valueOf(tipoStr);
            Usuario usuario = new Usuario(nome, dataNascimento, cpf, email, senha, tipo);
            userControl.registerUser(usuario);
            mensagem = "Cadastro realizado com sucesso! <a href='login.html'>Clique aqui para entrar</a>.";
        } catch (Exception e) {
            mensagem = "Erro ao cadastrar usuário: " + e.getMessage();
        }
    } else {
        mensagem = "Preencha todos os campos do formulário.";
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Registro - DeepBlue SC</title>
    <link rel="stylesheet" href="static/css/main-styles.css">
    <link rel="stylesheet" href="static/css/login.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="background: var(--azul-profundo, #f5f8fa);">
    <section class="hero" style="min-height: 100vh; display: flex; align-items: center; justify-content: center;">
        <div class="hero-login-container">
            <h2 class="hero-login-title">Cadastro</h2>
            <div style="text-align:center; margin-top:2rem;">
                <%= mensagem %>
            </div>
        </div>
    </section>
</body>
</html>