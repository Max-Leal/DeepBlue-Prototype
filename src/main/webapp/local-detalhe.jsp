<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="models.Local, controllers.LocalController" %>
<%@ page import="models.AgenciaLocal, controllers.AgenciaLocalController" %>
<%@ page import="controllers.AgenciaController" %>
<%@ page import="models.Agencia" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%
    List<AgenciaLocal> relacoes = new ArrayList<>();
    Local local = null;

    String idParam = request.getParameter("id");
    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);

            LocalController localController = new LocalController();
            local = localController.getLocalById(id);

            AgenciaLocalController agenciaLocalController = new AgenciaLocalController();
            relacoes = agenciaLocalController.getAgenciasPorLocal(id);

        } catch (NumberFormatException e) {
            out.println("<p>ID inválido!</p>");
        }
    } else {
        out.println("<p>ID não fornecido!</p>");
    }

    AgenciaController agenciaController = new AgenciaController();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title><%= (local != null) ? local.getNome() : "Local não encontrado" %></title>

    <!-- Estilos principais -->
    <link rel="stylesheet" href="static/css/main-styles.css">

    <!-- Ícones FontAwesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <!-- Mapa Leaflet -->
    <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
    <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

    <style>
        #mapa {
            width: 100%;
            height: 400px;
            border-radius: 20px;
            margin-top: 2rem;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
        }

        .detalhes-container {
            margin-top: 120px;
            padding: 3rem 2rem;
            max-width: 1000px;
            margin-left: auto;
            margin-right: auto;
            background: var(--cinza-claro);
            border-radius: 20px;
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
        }

        .detalhes-container h1 {
            font-size: 2.5rem;
            color: var(--azul-escuro);
            margin-bottom: 1rem;
        }

        .detalhes-container p {
            font-size: 1.1rem;
            margin-bottom: 0.8rem;
            color: var(--cinza-medio);
        }

        /* Estilo para os cards de agência */
        .agencias-lista {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            margin-top: 1rem;
        }

        .agencia-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 1.5rem;
            width: calc(50% - 1.5rem);
            box-sizing: border-box;
            transition: box-shadow 0.3s ease;
        }
        .agencia-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .agencia-nome {
            font-size: 1.3rem;
            font-weight: 700;
            color: var(--azul-escuro);
            margin-bottom: 0.5rem;
        }

        .agencia-info {
            font-size: 1rem;
            color: var(--cinza-medio);
            margin-bottom: 0.3rem;
        }

        .agencia-link {
            margin-top: 1rem;
            display: inline-block;
            background: var(--azul-escuro);
            color: white;
            padding: 0.4rem 1rem;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            transition: background-color 0.2s ease;
        }

        .agencia-link:hover {
            background: var(--azul-claro);
            color: #222;
        }

        @media (max-width: 600px) {
            .agencia-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<script src="static/js/header.js"></script>

<main class="detalhes-container">
<% if (local != null) { %>
    <h1><%= local.getNome() %></h1>
    <p><strong>Localidade:</strong> <%= local.getLocalidade() %></p>
    <p><strong>Descrição:</strong> <%= local.getDescricao() %></p>
    <p><strong>Situação:</strong> <%= local.getSituacao() %></p>

    <!-- Listar agências relacionadas -->
    <section>
        <h2>Agências que operam neste local</h2>
        <% if (relacoes != null && !relacoes.isEmpty()) { %>
            <div class="agencias-lista">
            <% for (AgenciaLocal relacao : relacoes) {
                   Agencia agencia = agenciaController.getAgenciaById(relacao.getIdAgencia());
                   if (agencia != null) {
            %>
                <div class="agencia-card">
                    <div class="agencia-nome"><%= agencia.getNomeEmpresarial() %></div>
                    <div class="agencia-info"><strong>Email:</strong> <%= agencia.getEmail() %></div>
                    <div class="agencia-info"><strong>Oferece Mergulho:</strong> <%= relacao.isOfereceMergulho() ? "Sim" : "Não" %></div>
                    <div class="agencia-info"><strong>Oferece Passeio:</strong> <%= relacao.isOferecePasseio() ? "Sim" : "Não" %></div>
                    <a class="agencia-link" href="agencia-detalhe.jsp?id=<%= agencia.getId() %>">Ver Detalhes</a>
                </div>
            <%   } else { %>
                <div class="agencia-card">
                    <p>Agência com ID <%= relacao.getIdAgencia() %> não encontrada.</p>
                </div>
            <%   }
               }
            %>
            </div>
        <% } else { %>
            <p>Nenhuma agência cadastrada para este local.</p>
        <% } %>
    </section>

    <!-- Mapa Leaflet -->
    <div id="mapa"></div>

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

        const lat = parseFloat("<%= local.getLatitude() %>");
        const lng = parseFloat("<%= local.getLongitude() %>");
        const map = L.map('mapa').setView([lat, lng], 13);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 18
        }).addTo(map);

        L.marker([lat, lng])
            .addTo(map)
            .bindPopup("<%= local.getNome() %>")
            .openPopup();
    </script>

<% } else { %>
    <h1>Local não encontrado</h1>
    <p>Verifique se o ID está correto na URL.</p>
<% } %>
</main>

<footer class="footer">
    &copy; 2025 DeepBlue. Todos os direitos reservados.
</footer>

</body>
</html>
