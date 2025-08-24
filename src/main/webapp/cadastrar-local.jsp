<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro  de Locais</title>
 <style>
        .sucesso { color: green; font-weight: bold; }
        .erro { color: red; font-weight: bold; }
    </style>
</head>
<body>

<% if (request.getAttribute("mensagemSucesso") != null) { %>
    <p class="sucesso"><%= request.getAttribute("mensagemSucesso") %></p>
<% } %>

<% if (request.getAttribute("erro") != null) { %>
    <p class="erro"><%= request.getAttribute("erro") %></p>
<% } %>

<form action="CadastrarLocalServlet" method="post">
    <label>Nome:</label>
    <input type="text" name="nome" value="<%= request.getParameter("nome") != null ? request.getParameter("nome") : "" %>" required><br>
    <label>Localidade:</label>
    <input type="text" name="localidade" value="<%= request.getParameter("localidade") != null ? request.getParameter("localidade") : "" %>" required><br>
    <label>Descrição:</label>
    <textarea name="descricao" required><%= request.getParameter("descricao") != null ? request.getParameter("descricao") : "" %></textarea><br>
    <label>Tipo de Embarcação:</label>
    <input type="text" name="tipo_embarcacao" value="<%= request.getParameter("tipo_embarcacao") != null ? request.getParameter("tipo_embarcacao") : "" %>" required><br>
    <label>Ano de Afundamento:</label>
    <input type="number" name="ano_afundamento" value="<%= request.getParameter("ano_afundamento") != null ? request.getParameter("ano_afundamento") : "" %>" required><br>
    <label>Profundidade:</label>
    <input type="number" step="0.01" name="profundidade" value="<%= request.getParameter("profundidade") != null ? request.getParameter("profundidade") : "" %>" required><br>

    <label>Situação:</label>
    <select name="situacao" required>
        <option value="">Selecione</option>
        <option value="DISPONIVEL" <%= "DISPONIVEL".equalsIgnoreCase(request.getParameter("situacao")) ? "selected" : "" %>>Disponível</option>
        <option value="INDISPONIVEL" <%= "INDISPONIVEL".equalsIgnoreCase(request.getParameter("situacao")) ? "selected" : "" %>>Indisponível</option>
    </select><br>

    <label>Latitude:</label>
    <input type="text" name="latitude" value="<%= request.getParameter("latitude") != null ? request.getParameter("latitude") : "" %>" required><br>
    <label>Longitude:</label>
    <input type="text" name="longitude" value="<%= request.getParameter("longitude") != null ? request.getParameter("longitude") : "" %>" required><br>
    <button type="submit">Cadastrar</button>
</form>

</body>
</html>