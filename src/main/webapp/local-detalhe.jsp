<%@ page import="models.Local, controllers.LocalController" %>
<%
  String idParam = request.getParameter("id");
  Local local = null;

  if (idParam != null) {
      try {
          int id = Integer.parseInt(idParam);
          LocalController controller = new LocalController();
          local = controller.getLocalById(id);
      } catch (NumberFormatException e) {
          out.println("<p>ID inválido!</p>");
      }
  } else {
      out.println("<p>ID não fornecido!</p>");
  }
%>

<html>
<head>
  <title>Detalhe do Local</title>
  <script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
  <link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css"/>
</head>
<body>
<% if (local != null) { %>
  <h1><%= local.getNome() %></h1>
  <p><strong>Localidade:</strong> <%= local.getLocalidade() %></p>
  <p><strong>Descrição:</strong> <%= local.getDescricao() %></p>
  <p><strong>Situação:</strong> <%= local.getSituacao() %></p>
  <div id="mapa" style="height: 400px;"></div>

  <script>
    const lat = parseFloat("<%= local.getLatitude() %>");
    const lng = parseFloat("<%= local.getLongitude() %>");
    const map = L.map('mapa').setView([lat, lng], 13);
    L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
      maxZoom: 18
    }).addTo(map);
    L.marker([lat, lng]).addTo(map)
      .bindPopup("<%= local.getNome() %>")
      .openPopup();
  </script>
<% } %>
</body>
</html>
