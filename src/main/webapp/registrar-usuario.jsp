<%@ page import="models.Usuario" %>
<%@ page import="controllers.UsuarioController" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	session.invalidate();
    request.setCharacterEncoding("UTF-8");

    String mensagem = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nome = request.getParameter("nome");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (nome != null && email != null && senha != null) {
            try {
                Usuario usuario = new Usuario();
                usuario.setNome(nome.trim());
                usuario.setEmail(email.trim());
                usuario.setSenhaHash(senha.trim());
                usuario.setFoto(null); // inicialmente nulo
                UsuarioController userControl = new UsuarioController();
                userControl.registerUsuario(usuario);

                response.sendRedirect("login-usuario.jsp");
                return;

            } catch (Exception e) {
                mensagem = "Erro ao cadastrar usuário: " + e.getMessage();
            }
        } else {
            mensagem = "Preencha todos os campos do formulário.";
        }
    }
%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Registrar Usuário - DeepBlue</title>
    <link rel="stylesheet" href="static/css/main-styles.css">
    <link rel="stylesheet" href="static/css/login-styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
</head>

<body>
    <script src="static/js/header.js"></script>
    <div style="padding-top: 4.5%">
        <section class="hero">
            <div class="hero-login-container">
                <h2 class="hero-login-title">Criar nova conta</h2>

                <% if (!mensagem.isEmpty()) { %>
                    <div style="color: red; font-weight: bold; text-align: center; margin-bottom: 10px;">
                        <%= mensagem %>
                    </div>
                <% } %>

                <form method="post" class="hero-login-form" autocomplete="off">
                    <div class="form-group">
                        <label for="nome">Nome completo</label>
                        <div class="input-wrapper">
                            <i class="fas fa-user input-icon"></i>
                            <input type="text" id="nome" name="nome" placeholder="Digite seu nome completo" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email">E-mail</label>
                        <div class="input-wrapper">
                            <i class="fas fa-envelope input-icon"></i>
                            <input type="email" id="email" name="email" placeholder="Digite seu melhor e-mail" required>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="senha">Senha</label>
                        <div class="input-wrapper">
                            <i class="fas fa-lock input-icon"></i>
                            <input type="password" id="senha" name="senha" placeholder="Crie uma senha" required>
                            <button type="button" class="password-toggle"
                                onclick="togglePassword('senha', 'toggleIcon1')">
                                <i class="fas fa-eye" id="toggleIcon1"></i>
                            </button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="confirmarSenha">Confirmar Senha</label>
                        <div class="input-wrapper">
                            <i class="fas fa-lock input-icon"></i>
                            <input type="password" id="confirmarSenha" placeholder="Repita a senha" required>
                            <button type="button" class="password-toggle"
                                onclick="togglePassword('confirmarSenha', 'toggleIcon2')">
                                <i class="fas fa-eye" id="toggleIcon2"></i>
                            </button>
                        </div>
                    </div>
                    <button type="submit" class="hero-login-btn"><span>Registrar</span></button>
                </form>

                <div class="hero-login-register">
                    <span>Já tem uma conta?</span>
                    <a href="login-usuario.jsp">Entrar</a>
                </div>
            </div>
        </section>
    </div>

    <script>

        function togglePassword(inputId, iconId) {
            const passwordInput = document.getElementById(inputId);
            const toggleIcon = document.getElementById(iconId);
            if (passwordInput.type === 'password') {
                passwordInput.type = 'text';
                toggleIcon.classList.remove('fa-eye');
                toggleIcon.classList.add('fa-eye-slash');
            } else {
                passwordInput.type = 'password';
                toggleIcon.classList.remove('fa-eye-slash');
                toggleIcon.classList.add('fa-eye');
            }
        }

        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('focus', function () {
                this.parentElement.style.transform = 'scale(1.02)';
            });
            input.addEventListener('blur', function () {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        document.getElementById('senha').addEventListener('input', function () {
            const senha = this.value;
            this.style.borderColor = senha.length >= 6 ? 'var(--verde-sucesso)' : (senha.length > 0 ? 'var(--vermelho-erro)' : 'rgba(96, 165, 250, 0.2)');
        });

        document.getElementById('confirmarSenha').addEventListener('input', function () {
            const senha = document.getElementById('senha').value;
            this.style.borderColor = (this.value === senha && this.value.length >= 6) ? 'var(--verde-sucesso)' : (this.value.length > 0 ? 'var(--vermelho-erro)' : 'rgba(96, 165, 250, 0.2)');
        });
    </script>
</body>

</html>
