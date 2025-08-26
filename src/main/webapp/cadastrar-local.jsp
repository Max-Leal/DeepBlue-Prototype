<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Agencia"%>
<%@ page import="java.util.List"%>
<%@ page import="models.Local"%>
<%@ page import="daos.LocalDao"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cadastro de Locais</title>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
:root {
    --azul-profundo: #01203a;
    --azul-escuro: #1e3a8a;
    --azul-medio: #3b82f6;
    --azul-agua: #60a5fa;
    --azul-claro: #93c5fd;
    --cinza-fundo: #f4f6f9;
    --cinza-texto: #374151;
    --erro: #dc2626;
    --sucesso: #16a34a;
}

/* Reset básico */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    background: var(--cinza-fundo);
    color: var(--cinza-texto);
    padding-top: 70px; /* altura do header */
}

/* Header fixo */
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background: var(--azul-profundo);
    color: white;
    padding: 1rem 2rem;
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-weight: 600;
    box-shadow: 0 3px 8px rgba(0,0,0,0.2);
    z-index: 1000;
}

/* Container central */
.container {
    max-width: 1000px;
    margin: 2rem auto;
    display: flex;
    flex-direction: column;
    gap: 2rem;
}

/* Card dados da agência */
.agencia-card {
    background: #fff;
    padding: 2rem;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    text-align: center;
}

.agencia-card p {
    margin-bottom: 0.5rem;
}

.agencia-card strong {
    color: var(--azul-escuro);
}

/* Botão editar e cadastrar */
.agencia-card button,
.cadastrar-btn {
    display: inline-block;
    margin-top: 1rem;
    padding: 0.8rem 2rem;
    border: none;
    border-radius: 50px;
    background: linear-gradient(45deg, var(--azul-medio), var(--azul-agua));
    color: white;
    font-weight: 600;
    cursor: pointer;
    text-align: center;
}

.agencia-card button:hover,
.cadastrar-btn:hover {
    transform: translateY(-3px); /* leve "elevação" */
    box-shadow: 0 8px 20px rgba(0,0,0,0.2);
    background: linear-gradient(45deg, var(--azul-agua), var(--azul-medio)); /* gradiente invertido */
}


/* Tabela locais */
.table-wrapper {
    background: #fff;
    padding: 2rem;
    border-radius: 16px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.08);
}

.table-wrapper h2 {
    text-align: center;
    margin-bottom: 1.5rem;
}

h2 {
    text-align: center;
    margin-bottom: 2.5rem;
}
.table-wrapper table {
    width: 70%;
    border-collapse: collapse;
    border-radius: 16px;
    overflow: hidden;
}

th, td {
    padding: 0.8rem 1rem;
    border-bottom: 1px solid #ddd;
    text-align: center;
}

th {
    background: var(--azul-profundo);
    color: white;
}

tr:nth-child(even) {
    background: #f9f9f9;
}

/* Mensagens */
.mensagem-erro,
.mensagem-sucesso {
    font-weight: bold;
    text-align: center;
    margin-bottom: 1rem;
}


</style>
</head>
<body>
<script src="static/js/header.js"></script>

<%
Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
if (agenciaLogada == null) {
    response.sendRedirect("login-agencia.jsp");
    return;
}

%>
<script>
window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
</script>

<% 
@SuppressWarnings("unchecked")
List<Local> locais = (List<Local>) request.getAttribute("locais");
if (locais == null) {
    LocalDao dao = new LocalDao();
    locais = dao.listarPorAgencia(agenciaLogada.getId());
    request.setAttribute("locais", locais);
}
%>

<% if(request.getAttribute("erro") != null) { %>
<p class="mensagem-erro"><%= request.getAttribute("erro") %></p>
<% } %>

<% if(request.getAttribute("mensagemSucesso") != null) { %>
<p class="mensagem-sucesso"><%= request.getAttribute("mensagemSucesso") %></p>
<% } %>

<div class="container">
    
    <div class="agencia-card">
    
        <h2>Seus Dados</h2>
        
        <p><strong>Nome:</strong> <%= agenciaLogada.getNomeEmpresarial() %></p>
        <p><strong>CNPJ:</strong> <%= agenciaLogada.getCnpj() %></p>
        <p><strong>Email:</strong> <%= agenciaLogada.getEmail() %></p>
        <p><strong>Situação:</strong> <%= agenciaLogada.getSituacao() %></p>
        <p><strong>Descrição:</strong> <%= agenciaLogada.getDescricao() %></p>
        <p><strong>CEP:</strong> <%= agenciaLogada.getCep() %></p>
        <p><strong>Telefone:</strong> <%= agenciaLogada.getTelefone() %></p>
        <p><strong>WhatsApp:</strong> <%= agenciaLogada.getWhatsapp() %></p>
        <p><strong>Instagram:</strong> <%= agenciaLogada.getInstagram() %></p>
        <button onclick="window.location.href='editar-agencia.jsp'">Editar Dados</button>
    </div>

    <!-- Tabela de Locais -->
    <div class="table-wrapper">
        <h2>Locais Cadastrados</h2>
        <% if(locais != null && !locais.isEmpty()) { %>
        <table>
            <tr>
                <th>Nome</th>
                <th>Localidade</th>
                <th>Descrição</th>
                <th>Tipo Embarcação</th>
                <th>Ano Afundamento</th>
                <th>Profundidade</th>
                <th>Latitude</th>
                <th>Longitude</th>
            </tr>
            <% for(Local l : locais) { %>
            <tr>
                <td><%= l.getNome() %></td>
                <td><%= l.getLocalidade() %></td>
                <td><%= l.getDescricao() %></td>
                <td><%= l.getTipoEmbarcacao() %></td>
                <td><%= l.getAnoAfundamento() %></td>
                <td><%= l.getProfundidade() %></td>
                <td><%= l.getLatitude() %></td>
                <td><%= l.getLongitude() %></td>
            </tr>
            <% } %>
        </table>
        <% } else { %>
        <p style="text-align:center;">Nenhum local cadastrado.</p>
        <% } %>
        <button class="cadastrar-btn" onclick="window.location.href='cadastrar-local.jsp'">Cadastrar Local</button>
    </div>
</div>

</body>
</html>
