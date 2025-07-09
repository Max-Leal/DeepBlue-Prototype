<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="models.Agencia, controllers.AgenciaController" %>
<%@ page import="Enums.Situacao" %>
<%@ page import="controllers.AgenciaLocalController, models.AgenciaLocal, models.Local, controllers.LocalController" %>
<%@ page import="java.util.List, java.util.ArrayList" %>

<%
    String idParam = request.getParameter("id");
    Agencia agencia = null;
    List<AgenciaLocal> locaisRelacionados = new ArrayList<>();
    LocalController localController = new LocalController();

    if (idParam != null) {
        try {
            int id = Integer.parseInt(idParam);
            AgenciaController controller = new AgenciaController();
            agencia = controller.getAgenciaById(id);

            if (agencia != null) {
                AgenciaLocalController alController = new AgenciaLocalController();
                locaisRelacionados = alController.getLocaisPorAgencia(agencia.getId().intValue());
            }
        } catch (NumberFormatException e) {
            out.println("<p>ID inválido!</p>");
        }
    } else {
        out.println("<p>ID não fornecido!</p>");
    }
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title><%= (agencia != null) ? agencia.getNomeEmpresarial() : "Agência não encontrada" %></title>

    <link rel="stylesheet" href="static/css/main-styles.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

    <style>
        .detalhes-container {
            margin-top: 120px;
            padding: 3rem 2rem;
            max-width: 800px;
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

        /* Estilos para lista de locais */
        .locais-lista {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            margin-top: 2rem;
        }

        .local-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.1);
            padding: 1.5rem;
            width: calc(50% - 1.5rem);
            box-sizing: border-box;
            transition: box-shadow 0.3s ease;
        }

        .local-card:hover {
            box-shadow: 0 8px 20px rgba(0,0,0,0.15);
        }

        .local-card h3 {
            color: var(--azul-escuro);
            margin-bottom: 0.5rem;
        }

        .local-card p {
            color: var(--cinza-medio);
            margin-bottom: 0.3rem;
        }

        @media (max-width: 600px) {
            .local-card {
                width: 100%;
            }
        }
    </style>
</head>
<body>

<header class="header" id="header">
    <div class="logo">DeepBlue</div>
    <nav>
        <a href="index.html"><i class="fas fa-home"></i> Início</a>
        <a href="mapaInterativo.jsp"><i class="fas fa-map"></i> Mapa Interativo</a>
        <a href="locais.jsp"><i class="fas fa-map-marker-alt"></i> Locais</a>
        <a href="agencias.jsp"><i class="fas fa-search"></i> Agências</a>
        <a href="faq.html"><i class="fas fa-comments"></i> FAQ</a>
        <a href="login-usuario.html" id="informacoes-login"><i class="fas fa-user"></i> Login/Cadastro</a>
    </nav>
</header>

<main class="detalhes-container">
<% if (agencia != null) { %>
    <h1><%= agencia.getNomeEmpresarial() %></h1>
    <p><strong>CNPJ:</strong> <%= agencia.getCnpj() %></p>
    <p><strong>Email:</strong> <%= agencia.getEmail() %></p>
    <p><strong>Situação:</strong> <%= agencia.getSituacao().toString().toLowerCase().replace("_", " ") %></p>

    <section>
        <h2>Locais onde esta agência opera</h2>
        <% if (locaisRelacionados != null && !locaisRelacionados.isEmpty()) { %>
            <div class="locais-lista">
            <% for (AgenciaLocal al : locaisRelacionados) {
                   Local local = localController.getLocalById(al.getIdLocal());
                   if (local != null) {
            %>
                <div class="local-card">
                    <h3><a href="local-detalhe.jsp?id=<%= local.getId() %>"><%= local.getNome() %></a></h3>
                    <p><strong>Localidade:</strong> <%= local.getLocalidade() %></p>
                    <p><strong>Situação:</strong> <%= local.getSituacao().toString().toLowerCase().replace("_", " ") %></p>
                    <p><strong>Oferece Mergulho:</strong> <%= al.isOfereceMergulho() ? "Sim" : "Não" %></p>
                    <p><strong>Oferece Passeio:</strong> <%= al.isOferecePasseio() ? "Sim" : "Não" %></p>
                </div>
            <%   } else { %>
                <p>Local com ID <%= al.getIdLocal() %> não encontrado.</p>
            <%   } 
               } %>
            </div>
        <% } else { %>
            <p>Esta agência não opera em nenhum local cadastrado.</p>
        <% } %>
    </section>

<% } else { %>
    <h1>Agência não encontrada</h1>
    <p>Verifique se o ID está correto na URL.</p>
<% } %>
</main>

<footer class="footer">
    &copy; 2025 DeepBlue. Todos os direitos reservados.
</footer>

</body>
</html>
