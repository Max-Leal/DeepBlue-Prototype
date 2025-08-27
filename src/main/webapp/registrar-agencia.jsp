<%@ page import="models.Agencia" %>
<%@ page import="controllers.AgenciaController" %>
<%@ page import="Enums.Situacao" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	session.invalidate();
    request.setCharacterEncoding("UTF-8");

    String mensagem = "";

    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nomeEmpresarial = request.getParameter("nome_empresarial");
        String cnpj = request.getParameter("cnpj");
        String cep = request.getParameter("cep");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        String situacaoStr = request.getParameter("situacao");

        if (nomeEmpresarial != null && cnpj != null && cep != null && email != null && senha != null && situacaoStr != null) {
            try {
                Situacao situacao = Situacao.valueOf(situacaoStr.toUpperCase());

                Agencia agencia = new Agencia();
                agencia.setNomeEmpresarial(nomeEmpresarial.trim());
                agencia.setCnpj(cnpj.trim());
                agencia.setCep(cep.trim());
                agencia.setEmail(email.trim());
                agencia.setSenhaHash(senha.trim());
                agencia.setSituacao(situacao);

                // Campos extras como null
                agencia.setDescricao(null);
                agencia.setTelefone(null);
                agencia.setWhatsapp(null);
                agencia.setInstagram(null);

                if (nomeEmpresarial.isEmpty() || cnpj.isEmpty() || email.isEmpty() || senha.isEmpty() || cep.isEmpty()) {
                    mensagem = "Preencha todos os campos obrigatórios.";
                    throw new Exception(mensagem);
                }

                AgenciaController agenciaControl = new AgenciaController();
                agenciaControl.registerAgencia(agencia);

                response.sendRedirect("login-agencia.jsp");
                return;

            } catch (Exception e) {
                mensagem = "Erro ao cadastrar agência: " + e.getMessage();
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
    <title>Registrar Agência - DeepBlue</title>
    <link rel="stylesheet" href="static/css/login-styles.css">
    <link rel="stylesheet" href="static/css/main-styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
</head>

<body>
    <div class="page-wrapper">
        <script src="static/js/header.js"></script>

        <div style="padding-top: 4.5%">
            <section class="hero">
                <div class="hero-login-container">
                    <h2 class="hero-login-title">Registrar Agência</h2>

                    <% if (!mensagem.isEmpty()) { %>
                        <div style="color: red; font-weight: bold; text-align: center; margin-bottom: 10px;">
                            <%= mensagem %>
                        </div>
                    <% } %>

                    <form method="post" class="hero-login-form" autocomplete="off">
                        <div class="form-group">
                            <label for="nomeAgencia">Nome da Agência</label>
                            <div class="input-wrapper">
                                <i class="fas fa-building input-icon"></i>
                                <input type="text" id="nomeAgencia" name="nome_empresarial" placeholder="Nome da Agência" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="cnpj">CNPJ</label>
                            <div class="input-wrapper">
                                <i class="fas fa-id-card input-icon"></i>
                                <input type="text" id="cnpj" name="cnpj" placeholder="XX.XXX.XXX/0001-XX" required>
                            </div>
                        </div>

                        <div class="form-group">
                            <label for="cep">CEP</label>
                            <div class="input-wrapper">
                                <i class="fas fa-map-marker-alt input-icon"></i>
                                <input type="text" id="cep" name="cep" placeholder="Digite o CEP da agência" required>
                            </div>
                        </div>

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

                        <input type="hidden" name="situacao" value="DISPONIVEL">

                        <button type="submit" class="hero-login-btn">
                            <span>Registrar</span>
                        </button>
                    </form>

                    <div class="hero-login-register">
                        <span>Já tem uma conta?</span>
                        <a href="login-agencia.jsp">Entrar</a>
                    </div>
                </div>
            </section>
        </div>
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
