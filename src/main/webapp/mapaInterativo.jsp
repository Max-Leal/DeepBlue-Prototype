<%@ page import="controllers.LocalController"%>
<%@ page import="models.Local"%>
<%@ page import="java.util.*"%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <title>Mapa Interativo - DeepBlue SC</title>
    <link rel="stylesheet" href="static/css/main-styles.css">
    <link rel="stylesheet" href="static/css/mapa-styles.css">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
        rel="stylesheet">
    <link rel="stylesheet"
        href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"
        crossorigin="" />
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"
        crossorigin=""></script>
</head>

<body>
    <header class="header" id="header">
        <div class="logo">DeepBlue SC</div>
        <nav>
            <a href="index.html"><i class="fas fa-home"></i> Início</a>
            <a href="mapaInterativo.jsp"><i class="fas fa-map"></i> Mapa Interativo</a>
            <a href="#"><i class="fas fa-map-marker-alt"></i> Locais</a>
            <a href="#"><i class="fas fa-search"></i> Agências</a>
            <a href="login-usuario.html"><i class="fas fa-user"></i> Login/Cadastro</a>
        </nav>
    </header>
    <main>
        <div style="position: relative;">
            <div class="faixa-superior"></div>
            <section class="mapa-container">
                <div id="map"></div>
            </section>
        </div>
        <div>
            <section class="locais-section">
                <h2 class="locais-title">Locais</h2>
                <div class="locais-lista" id="locais">

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

    <%
        LocalController lController = new LocalController();
        List<Local> lista = lController.listaLocais();
    %>
        // Centralize o mapa no primeiro local, se houver
        <% if (lista != null && !lista.isEmpty()) { %>
            var map = L.map('map').setView([<%= lista.get(0).getLatitude() %>, <%= lista.get(0).getLongitude() %>], 9);
        <% } else { %>
            var map = L.map('map').setView([0, 0], 2);
        <% } %>
        L.tileLayer('https://tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution : '&copy; <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
        }).addTo(map);

        // Adicione os marcadores dinamicamente
        <% for (Local local : lista) { %>
            L.marker([<%= local.getLatitude() %>, <%= local.getLongitude() %>])
                .addTo(map)
                .bindPopup('<b><%= local.getNome() %></b><br><%= local.getDescricao() %>');
        <% } %>
        
    </script>
</body>

</html>