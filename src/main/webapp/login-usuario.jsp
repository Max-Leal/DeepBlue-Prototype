<%@ page import="controllers.UsuarioController" %>
<%@ page import="models.Usuario" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%

    request.setCharacterEncoding("UTF-8");

    String email = request.getParameter("email");
    String senha = request.getParameter("senha");
    String mensagem = "";

    if ("POST".equalsIgnoreCase(request.getMethod()) && email != null && senha != null) {
        UsuarioController userControl = new UsuarioController();
        boolean loginValido = userControl.loginUsuario(email, senha);

        if (loginValido) {
            Usuario usuario = userControl.getUsuarioByEmail(email);
            session.setAttribute("usuarioLogado", usuario);
            session.setAttribute("tipo", "usuario");
            response.sendRedirect("home.jsp");
            return;
        } else {
            mensagem = "E-mail ou senha inválidos.";
        }
    }
%>


<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Login Usuário - DeepBlue</title>
    <link rel="stylesheet" href="static/css/login-styles.css">
    <link rel="stylesheet" href="static/css/main-styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
</head>

<body>
    <div class="page-wrapper">
        <script src="static/js/header.js"></script>
        <section class="hero">
            <div class="hero-login-container">
                <h2 class="hero-login-title">Entrar na sua conta</h2>
  
                <div class="btns">
                    <button id="usuario" class="active"
                        style="background: var(--azul-espuma); color: var(--azul-escuro); box-shadow: 0 2px 8px rgba(96,165,250,0.15); border: #3b82f6 1px solid;">Usuário</button>
                    <button id="agencia">Agência</button>
                </div>
                
                <div class="type-login">
                	<p>Usuário</p>
                </div>

                <% if (!mensagem.isEmpty()) { %>
                    <div style="color: var(--vermelho-erro); margin: 1rem auto; text-align: center;">
                        <%= mensagem %>
                    </div>
                <% } %>

                <form action="login-usuario.jsp" method="post" class="hero-login-form">
                    <div class="form-group">
                        <label for="email">E-mail</label>
                        <div class="input-wrapper">
                            <i class="fas fa-envelope input-icon"></i>
                            <input type="email" id="email" name="email" placeholder="Digite seu e-mail" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="senha">Senha</label>
                        <div class="input-wrapper">
                            <i class="fas fa-lock input-icon"></i>
                            <input type="password" id="senha" name="senha" placeholder="Sua senha" required>
                            <button type="button" class="password-toggle" onclick="togglePassword()">
                                <i class="fas fa-eye" id="toggleIcon"></i>
                            </button>
                        </div>
                    </div>

                    <button type="submit" class="hero-login-btn">
                        <span>Entrar</span>
                    </button>
                </form>

                <div class="hero-login-register">
                    <span>Não tem uma conta?</span>
                    <a href="registrar-usuario.jsp">Registrar-se</a>
                </div>
                <div class="hero-login-password-reset">
                    <span>Esqueceu sua senha?</span>
                    <a href="recuperarSenha.html">Recuperar Senha</a>
                </div>
            </div>
        </section>
        <script src="static/js/footer.js"></script>
    </div>

<script>
    function togglePassword() {
        const input = document.getElementById('senha');
        const icon = document.getElementById('toggleIcon');
        if (input.type === 'password') {
            input.type = 'text';
            icon.classList.remove('fa-eye');
            icon.classList.add('fa-eye-slash');
        } else {
            input.type = 'password';
            icon.classList.remove('fa-eye-slash');
            icon.classList.add('fa-eye');
        }
    }

    document.getElementById('agencia').addEventListener('click', function () {
        window.location.href = 'login-agencia.jsp';
    });

    document.querySelectorAll('input').forEach(input => {
        input.addEventListener('focus', function () {
            this.parentElement.style.transform = 'scale(1.02)';
        });
        input.addEventListener('blur', function () {
            this.parentElement.style.transform = 'scale(1)';
        });
    });

    document.getElementById('email').addEventListener('input', function () {
        const email = this.value;
        const regex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        this.style.borderColor = regex.test(email) ? 'var(--verde-sucesso)' : (email ? 'var(--vermelho-erro)' : 'rgba(96, 165, 250, 0.2)');
    });

    document.getElementById('senha').addEventListener('input', function () {
        this.style.borderColor = this.value.length >= 6 ? 'var(--verde-sucesso)' : (this.value ? 'var(--vermelho-erro)' : 'rgba(96, 165, 250, 0.2)');
    });
</script>
</body>
</html>
