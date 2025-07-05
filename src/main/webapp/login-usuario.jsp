<!-- filepath: c:\Users\Usuario\OneDrive\Área de Trabalho\Workspaces\.java\ENTRA21\DeepBlue-Prototype\src\main\webapp\login.jsp -->
<%@ page import="controllers.UsuarioController" %>
<%@ page import="models.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    request.setCharacterEncoding("UTF-8");

    String email = request.getParameter("email");
    String senha = request.getParameter("senha");
    String mensagem = "";
    Usuario usuario = new Usuario();

    if (email != null && senha != null) {
        UsuarioController userControl = new UsuarioController();
        boolean loginValido = userControl.loginUser(email, senha);

        if (loginValido) {
            usuario = userControl.getUsuarioByEmail(email);
            mensagem = "Login realizado com sucesso!";
            // Você pode redirecionar ou exibir mensagem
        } else {
            mensagem = "E-mail ou senha inválidos.";
        }
    } else {
        mensagem = "Preencha todos os campos.";
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Login - DeepBlue</title>
    <link rel="stylesheet" href="static/css/main-styles.css">
    <link rel="stylesheet" href="static/css/login-styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body style="background: var(--azul-profundo, #f5f8fa);">
    <section class="hero" style="min-height: 100vh; display: flex; align-items: center; justify-content: center;">
        <div class="hero-login-container">
            <h2 class="hero-login-title">Login</h2>
            <div style="text-align:center; margin-top:2rem;">
                <%= mensagem %>
            </div>
        </div>
    </section>
    <% if (usuario != null) { %>
    <script>
        // Salva os dados do usuário no localStorage (exceto senha)
     
            localStorage.setItem('usuario', JSON.stringify({
                id: "<%= usuario.getId() %>",
                nome: "<%= usuario.getNome() %>",
                email: "<%= usuario.getEmail() %>",
        }));
        // Redireciona para a página principal após login
        window.location.href = "index.html";
    </script>
    <% } %>
</body>
</html>