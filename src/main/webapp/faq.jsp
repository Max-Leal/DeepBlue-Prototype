<%@ page import="models.Agencia"%>
<%@ page import="models.Usuario"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>FAQ</title>
    <link rel="stylesheet" href="static/css/main-styles.css">
    <link rel="stylesheet" href="static/css/faq-styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--azul-profundo) 0%, var(--azul-agua) 100%);
            min-height: 100vh;
            position: relative;
            display: flex;
            flex-direction: column;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 320'%3E%3Cpath fill='%23ffffff' fill-opacity='0.1' d='M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z'%3E%3C/path%3E%3C/svg%3E") bottom repeat-x;
            z-index: -1;
        }
    </style>
</head>

<body>
    <div class="page-wrapper">
    
    <%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
%>
<script>
    window.usuarioLogado = <%= usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null" %>;
    window.usuarioEmail = <%= usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null" %>;
    window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
    window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
</script>
        <script src="static/js/header.js"></script>
        <main>
            <h1 style="text-align:center; padding-top: 10%; color: white;">Perguntas Frequentes (FAQ)</h1>
            <div class="accordion">
                <div class="accordion-item">
                    <input type="checkbox" id="acc1">
                    <label for="acc1" class="accordion-header">
                        <span class="accordion-title">O que é a DeepBlue?</span>
                        <span class="accordion-icon">▼</span>
                    </label>
                    <div class="accordion-content">
                        <p>
                            A DeepBlue SC é uma plataforma que conecta turistas aventureiros, amantes da história e
                            da
                            natureza, às melhores agências de mergulho de Florianópolis. Nosso foco está na criação
                            de
                            experiências subaquáticas memoráveis em naufrágios históricos da região.
                        </p>
                    </div>
                </div>
                <div class="accordion-item">
                    <input type="checkbox" id="acc2">
                    <label for="acc2" class="accordion-header">
                        <span class="accordion-title">Que tipo de experiências a DeepBlue oferece?</span>
                        <span class="accordion-icon">▼</span>
                    </label>
                    <div class="accordion-content">
                        <p>
                            Oferecemos experiências com foco em:
                            Naufrágios históricos da Baía Norte e Sul de Florianópolis.
                            Ecoturismo subaquático com observação da fauna e flora marinha.
                            Expedições temáticas voltadas à arqueologia marinha e história local.
                        </p>

                    </div>
                </div>
                <div class="accordion-item">
                    <input type="checkbox" id="acc3">
                    <label for="acc3" class="accordion-header">
                        <span class="accordion-title">Como posso ter uma experiência com a DeepBlue?
                        </span>
                        <span class="accordion-icon">▼</span>
                    </label>
                    <div class="accordion-content">
                        <p>
                            Basta acessar nossa plataforma online e:
                            Procurar um local desejado.
                            Procurar agências que se relacionam com esse local.
                            Entrar em contato com essa agência via whatsapp, instagram ou até mesmo nosso próprio
                            chat.
                        </p>

                    </div>
                </div>
                <div class="accordion-item">
                    <input type="checkbox" id="acc4">
                    <label for="acc4" class="accordion-header">
                        <span class="accordion-title">Preciso pagar para usar o site?</span>
                        <span class="accordion-icon">▼</span>
                    </label>
                    <div class="accordion-content">
                        <p>
                            O acesso ao site e à maioria das funcionalidades é gratuito.
                        </p>

                    </div>
                </div>

                <div class="accordion-item">
                    <input type="checkbox" id="acc5">
                    <label for="acc5" class="accordion-header">
                        <span class="accordion-title">Qual a melhor época do ano para mergulhar em
                            Florianópolis?</span>
                        <span class="accordion-icon">▼</span>
                    </label>
                    <div class="accordion-content">
                        <p>
                            A temporada ideal vai de outubro a abril, quando a visibilidade subaquática é melhor e
                            as
                            águas estão mais quentes.
                        </p>

                    </div>
                </div>

                <div class="accordion-item">
                    <input type="checkbox" id="acc6">
                    <label for="acc6" class="accordion-header">
                        <span class="accordion-title">A DeepBlue é uma agência de mergulho?</span>
                        <span class="accordion-icon">▼</span>
                    </label>
                    <div class="accordion-content">
                        <p>
                            Não. Somos uma plataforma de conexão entre turistas e agências especializadas. Nosso
                            papel é
                            garantir que você encontre a experiência ideal com qualidade, excelência e compromisso
                            histórico.
                        </p>

                    </div>
                </div>

                <div class="accordion-item">
                    <input type="checkbox" id="acc7">
                    <label for="acc7" class="accordion-header">
                        <span class="accordion-title">Como posso tirar outras dúvidas ou falar com a equipe
                            DeepBlue?</span>
                        <span class="accordion-icon">▼</span>
                    </label>
                    <div class="accordion-content">
                        <p>
                            Você pode entrar em contato conosco pelo nosso formulário de atendimento no site, via
                            WhatsApp ou pelas redes sociais. Estamos sempre prontos para ajudar a planejar sua
                            próxima
                            aventura subaquática!
                        </p>

                    </div>
                </div>
            </div>
        </main>
        <div style="padding-bottom: 335px"></div>
        <script src="static/js/footer.js"></script>
    </div>
    <script src="static/js/whatsapp-widget.js"></script>
    <script>
        document.addEventListener('DOMContentLoaded', () => {
            const el = document.getElementById("informacoes-login");
            const usuario = localStorage.getItem("usuario");
            const agencia = localStorage.getItem("agencia");

            const dados = usuario ? JSON.parse(usuario) : agencia ? JSON.parse(agencia) : null;
            const nome = dados?.nome || dados?.nomeEmpresarial;
            const email = dados?.email;

            if (el && nome && email) {
                const div = document.createElement("div");
                div.className = "usuario-logado";

                ["Bem-vindo, " + nome, email].forEach(text => {
                    div.appendChild(document.createTextNode(text));
                    div.appendChild(document.createElement("br"));
                });

                const btn = document.createElement("button");
                btn.textContent = "Sair";
                btn.id = "logout-btn";
                btn.style.marginTop = "0.5rem";
                btn.onclick = () => {
                    localStorage.removeItem("usuario");
                    localStorage.removeItem("agencia");
                    location.reload();
                };

                div.appendChild(btn);
                el.replaceWith(div);
            }
        });



        function logout() {
            localStorage.removeItem("usuario");
            localStorage.removeItem("agencia");
            location.reload();
        }

        // Header scroll effect (igual ao index.html)
        window.addEventListener('scroll', () => {
            const header = document.getElementById('header');
            if (window.scrollY > 100) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });
        window.addEventListener('scroll', () => {
            const header = document.getElementById('header');
            if (window.scrollY > 100) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });

        document.getElementById('descubra-btn').addEventListener('click', (e) => {
            e.preventDefault();
            document.getElementById('valores').scrollIntoView({
                behavior: 'smooth'
            });
        });

        window.addEventListener('scroll', () => {
            const scrolled = window.pageYOffset;
            const heroImage = document.querySelector('.hero-image');
            const rate = scrolled * -0.5;
            heroImage.style.transform = `translateY(${rate}px)`;
        });

        const observerOptions = {
            threshold: 0.1,
            rootMargin: '0px 0px -50px 0px'
        };

        const observer = new IntersectionObserver((entries) => {
            entries.forEach(entry => {
                if (entry.isIntersecting) {
                    entry.target.classList.add('visible');
                }
            });
        }, observerOptions);

        document.querySelectorAll('.fade-in').forEach(el => {
            observer.observe(el);
        });

        function createParticles() {
            const particlesContainer = document.getElementById('particles');
            const particleCount = 50;

            for (let i = 0; i < particleCount; i++) {
                const particle = document.createElement('div');
                particle.className = 'particle';
                particle.style.left = Math.random() * 100 + '%';
                particle.style.animationDelay = Math.random() * 6 + 's';
                particle.style.animationDuration = (Math.random() * 4 + 4) + 's';
                particlesContainer.appendChild(particle);
            }
        }

        createParticles();

        document.querySelectorAll('.card').forEach(card => {
            card.addEventListener('mouseenter', () => {
                card.style.transform = 'translateY(-10px) scale(1.02)';
            });

            card.addEventListener('mouseleave', () => {
                card.style.transform = 'translateY(0) scale(1)';
            });
        });

        const ctaBtn = document.getElementById('descubra-btn');
        ctaBtn.addEventListener('mouseenter', () => {
            ctaBtn.style.transform = 'translateY(-3px) scale(1.05)';
        });

        ctaBtn.addEventListener('mouseleave', () => {
            ctaBtn.style.transform = 'translateY(0) scale(1)';
        });

        const isMobile = window.innerWidth <= 768;
        if (isMobile) {
            const nav = document.querySelector('nav');
            nav.style.display = 'none';
        }
    </script>
</body>

</html>