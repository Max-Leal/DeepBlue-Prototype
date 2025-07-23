<%@ page import="controllers.AgenciaController" %>
<%@ page import="models.Agencia" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	session.invalidate();
    request.setCharacterEncoding("UTF-8");

    String mensagem = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        if (email != null && senha != null) {
            AgenciaController agenciaControl = new AgenciaController();
            boolean loginValido = agenciaControl.loginAgencia(email, senha);

            if (loginValido) {
                Agencia agencia = agenciaControl.getAgenciaByEmail(email);

                HttpSession sessao = request.getSession();
                sessao.setAttribute("agenciaLogada", agencia);
                sessao.setAttribute("tipo", "agencia");

                response.sendRedirect("painel-agencia.jsp");
                return;
            } else {
                mensagem = "E-mail ou senha inválidos.";
            }
        } else {
            mensagem = "Preencha todos os campos.";
        }
    }
%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Login Agência - DeepBlue</title>
    <link rel="stylesheet" href="static/css/login-styles.css">
    <link rel="stylesheet" href="static/css/main-styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
</head>

<body>
    <div class="page-wrapper">
        <script src="static/js/header.js"></script>

        <div style="padding-top: 1.5%">
            <section class="hero">
                <div class="hero-login-container">
                    <h2 class="hero-login-title">Entrar na sua conta</h2>
                    <div class="btns">
                        <button id="usuario">Usuário</button>
                        <button id="agencia" class="active"
                            style="background: var(--azul-espuma); color: var(--azul-escuro); box-shadow: 0 2px 8px rgba(96,165,250,0.15); border: #3b82f6 1px solid;">Agência</button>
                    </div>

                    <% if (!mensagem.isEmpty()) { %>
                        <div style="color: red; font-weight: bold; text-align: center; margin-bottom: 10px;">
                            <%= mensagem %>
                        </div>
                    <% } %>

                    <form action="login-agencia.jsp" method="post" class="hero-login-form" autocomplete="off">
                        <div class="form-group">
                            <label for="email">E-mail</label>
                            <div class="input-wrapper">
                                <i class="fas fa-envelope input-icon"></i>
                                <input type="email" id="email" name="email" placeholder="Digite o e-mail da agência" required>
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
                        <a href="registrar-agencia.jsp">Registrar-se</a>
                    </div>
                    <div class="hero-login-password-reset">
                        <span>Esqueceu sua senha?</span>
                        <a href="recuperarSenha.html">Recuperar Senha</a>
                    </div>
                </div>
            </section>
        </div>

        <script src="static/js/footer.js"></script>
    </div>

    <script>

        function togglePassword() {
            const passwordInput = document.getElementById('senha');
            const toggleIcon = document.getElementById('toggleIcon');

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

        // Efeitos visuais
        document.querySelectorAll('input').forEach(input => {
            input.addEventListener('focus', function () {
                this.parentElement.style.transform = 'scale(1.02)';
            });

            input.addEventListener('blur', function () {
                this.parentElement.style.transform = 'scale(1)';
            });
        });

        // Validação em tempo real
        document.getElementById('senha').addEventListener('input', function () {
            const senha = this.value;
            if (senha.length >= 6) {
                this.style.borderColor = 'var(--verde-sucesso)';
            } else if (senha.length > 0) {
                this.style.borderColor = 'var(--vermelho-erro)';
            } else {
                this.style.borderColor = 'rgba(96, 165, 250, 0.2)';
            }
        });

        // Alternar entre usuário e agência
        document.getElementById('usuario').addEventListener('click', function () {
            window.location.href = 'login-usuario.jsp';
        });
    </script>
</body>
</html>
