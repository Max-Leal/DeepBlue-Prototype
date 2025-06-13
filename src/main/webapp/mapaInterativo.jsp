<%@ page import="java.util.List" %>
    <%@ page import="models.Passeio" %>
        <%@ page import="controllers.PasseioController" %>
            <% List<Passeio> passeios = PasseioController.listarPasseios();
                %>
                <!DOCTYPE html>
                <html lang="pt-br">

                <head>
                    <meta charset="UTF-8">
                    <title>Mapa Interativo - DeepBlue SC</title>
                    <link rel="stylesheet" href="static/css/main-styles.css">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
                        rel="stylesheet">
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
                        rel="stylesheet">
                    <style>
                        html,
                        body {
                            height: 100%;
                        }

                        body {
                            min-height: 100vh;
                            display: flex;
                            flex-direction: column;
                        }

                        main {
                            flex: 1 0 auto;
                        }

                        .footer {
                            margin-top: auto;
                        }

                        .mapa-container {
                            position: relative;
                            width: 100%;
                            max-width: 900px;
                            margin: 6rem auto 2rem auto;
                            overflow: hidden;
                            box-shadow: 0 4px 18px rgba(1, 32, 58, 0.09);
                            background: var(--azul-espuma, #f5f8fa);
                        }

                        .faixa-superior {
                            position: absolute;
                            top: -32px;
                            left: 0;
                            width: 100%;
                            height: 94px;
                            background: white;
                            z-index: 2;
                        }

                        .passeios-section {
                            max-width: 900px;
                            margin: 0 auto 2.5rem auto;
                            background: linear-gradient(135deg, var(--azul-espuma) 60%, var(--azul-claro) 100%);
                            border-radius: 18px;
                            box-shadow: 0 2px 12px rgba(1, 32, 58, 0.08);
                            padding: 2rem 1.5rem;
                            background: #f9fafb;
                            border: 1px solid #e0e7ef;
                        }

                        .passeios-title {
                            color: var(--azul-escuro);
                            font-size: 1.6rem;
                            margin-bottom: 1.2rem;
                            text-align: center;
                            letter-spacing: 1px;
                        }

                        .passeio {
                            min-height: 80px;
                            background: var(--azul-espuma);
                            border-radius: 12px;
                            padding: 1.2rem;
                            color: var(--azul-profundo);
                            font-size: 1.1rem;
                            box-shadow: 0 1px 6px rgba(59, 130, 246, 0.07);
                        }

                        .passeios-lista {
                            display: flex;
                            flex-direction: column;
                            gap: 1.2rem;
                        }

                        .passeio-card {
                            background: #fff;
                            border-radius: 10px;
                            box-shadow: 0 2px 8px rgba(59, 130, 246, 0.08);
                            padding: 1.2rem 1.5rem;
                            margin-bottom: 0.5rem;
                            transition: box-shadow 0.2s;
                            border-left: 6px solid var(--azul-escuro, #1e3a5c);
                        }

                        .passeio-card:hover {
                            box-shadow: 0 4px 16px rgba(59, 130, 246, 0.15);
                        }

                        .passeio-local {
                            font-size: 1.2rem;
                            color: var(--azul-escuro, #1e3a5c);
                            margin-bottom: 0.5rem;
                        }

                        .passeio-info {
                            font-size: 1rem;
                            color: #333;
                        }

                        .passeio-valor {
                            color: #0a7cff;
                            font-weight: bold;
                        }
                    </style>
                </head>

                <body>
                    <header class="header" id="header">
                        <div class="logo">DeepBlue SC</div>
                        <nav>
                            <a href="index.html"><i class="fas fa-home"></i> Início</a>
                            <a href="mapaInterativo.jsp"><i class="fas fa-map"></i> Mapa Interativo</a>
                            <a href="#"><i class="fas fa-map-marker-alt"></i> Locais</a>
                            <a href="#"><i class="fas fa-search"></i> Buscar Passeios</a>
                            <a href="#"><i class="fas fa-calendar"></i> Eventos</a>
                            <a href="login.html"><i class="fas fa-user"></i> Login/Cadastro</a>
                        </nav>
                    </header>
                    <main>
                        <div style="position: relative;">
                            <div class="faixa-superior"></div>
                            <section class="mapa-container">
                                <iframe
                                    src="https://www.google.com/maps/d/embed?mid=1pAEo6ynTJesX33jRAmTFr_NioVdMEvU&ehbc=2E312F"
                                    width="100%" height="480" allowfullscreen="" loading="lazy"
                                    referrerpolicy="no-referrer-when-downgrade" title="Mapa Interativo Google">
                                </iframe>
                            </section>
                        </div>
                        <div>
                            <section class="passeios-section">
                                <h2 class="passeios-title">Passeios</h2>
                                <div class="passeios-lista" id="passeios">
                                    <% for (Passeio p : passeios) { %>
                                        <div class="passeio-card">
                                            <div class="passeio-local"><strong>
                                                    <%= p.getLocal() %>
                                                </strong></div>
                                            <div class="passeio-info">
                                                Data: <%= p.getData() %> <br>
                                                    Duração: <%= p.getDuracao() %> <br>
                                                        Valor: <span class="passeio-valor">R$ <%= p.getValor() %></span>
                                                        <br>
                                                        Tipo: <%= p.getTipo() %> <br>
                                                            Situação: <%= p.getSituacao() %>
                                            </div>
                                        </div>
                                        <% } if (passeios.isEmpty()) { %>
                                            <div>Nenhum passeio cadastrado.</div>
                                            <% } %>
                                </div>
                            </section>
                        </div>
                    </main>
                    <footer class="footer">
                        <p>&copy; 2025 DeepBlue SC. Todos os direitos reservados.</p>
                    </footer>

                    <script>
                        // Header scroll effect
                        window.addEventListener('scroll', () => {
                            const header = document.getElementById('header');
                            if (window.scrollY > 100) {
                                header.classList.add('scrolled');
                            } else {
                                header.classList.remove('scrolled');
                            }
                        });
                    </script>
                </body>

                </html>