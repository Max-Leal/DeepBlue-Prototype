<%@ page import="models.Agencia" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Local" %>
<%@ page import="daos.LocalDao" %>
<!DOCTYPE html>
<html lang="pt-br">

<head>
	<meta charset="UTF-8">
	<title>Painel Agência - Cadastrar Locais</title>
	<link rel="stylesheet" href="static/css/main-styles.css">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
		rel="stylesheet">
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<head>

	<style>
	:root {
    --azul-profundo: #01203a;
    --azul-escuro: #1e3a8a;
    --azul-medio: #3b82f6;
    --azul-agua: #60a5fa;
    --azul-claro: #93c5fd;
    --cinza-fundo: #f4f6f9;
    --cinza-claro: #e5e7eb;
    --cinza-texto: #374151;
}


* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Poppins', sans-serif;
    background-color: var(--cinza-fundo);
    color: var(--cinza-texto);
    line-height: 1.6;
}


.page-wrapper {
    max-width: 1100px;
    margin: 2rem auto;
    padding: 2rem;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
}

p {
    margin: 0.3rem 0;
}


h1{
    color: var(--azul-profundo);
    margin-bottom: 1rem;
    text-align: center;
}



.btn-primario {
    background: linear-gradient(45deg, var(--azul-medio), var(--azul-agua));
    color: white;
    border: none;
    padding: 0.8rem 2rem;
    border-radius: 50px;
    font-weight: 600;
    cursor: pointer;
    transition: all 0.3s ease;
    font-size: 1.05rem;
    box-shadow: 0 3px 6px rgba(59,130,246,0.2);
    display: flex;
    text-align: center;
    gap: 1.5rem;
    margin-top: 2rem;
    margin-bottom: 2rem;
}

.btn-primario:hover {
    transform: translateY(-2px);
    background: linear-gradient(45deg, var(--azul-claro), var(--azul-medio));
    box-shadow: 0 5px 12px rgba(59,130,246,0.3);
}



table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 1.5rem;
    border-radius: 12px;
    overflow: hidden;
    box-shadow: 0 3px 10px rgba(0,0,0,0.05);
}

table th {
    background-color: var(--azul-profundo);
    color: #fff;
    text-align: left;
    padding: 0.9rem;
    font-weight: 600;
    font-size: 0.95rem;
}

table td {
    padding: 0.9rem;
    border-bottom: 1px solid var(--cinza-claro);
    font-size: 0.9rem;
}

table tr:hover td {
    background-color: var(--azul-claro);
    color: #fff;
    transition: 0.2s;
}


.page-wrapper > p strong {
    color: var(--azul-medio);
}

@media (max-width: 768px) {
    .page-wrapper {
        padding: 1rem;
    }

    table, thead, tbody, th, td, tr {
        display: block;
    }

    table tr {
        margin-bottom: 1rem;
        border: 1px solid var(--cinza-claro);
        border-radius: 12px;
        padding: 0.8rem;
        background: #fff;
    }

    table td {
        border: none;
        display: flex;
        justify-content: space-between;
        padding: 0.5rem 0;
    }

    table td::before {
        content: attr(data-label);
        font-weight: 600;
        color: var(--azul-escuro);
    }
}
header {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    background: var(--azul-profundo);
    color: white;
    z-index: 1000;
    height: 100px; 
    display: flex;
    align-items: center;
    padding: 0 2rem;
}

.page-wrapper {
    padding-top: 90px; 
}
	</style>
</head>

<body>

	
	<%

    Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
	
%>
<script>
    window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
    window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
    </script>
    
    <script src="static/js/header.js"></script>


	<div class="page-wrapper">
         <h1>Seus Dados</h1>

      <p><strong>Nome:</strong> ${sessionScope.agenciaLogada.nomeEmpresarial}</p>
      <p><strong>CNPJ:</strong> ${sessionScope.agenciaLogada.cnpj}</p>
      <p><strong>Email:</strong> ${sessionScope.agenciaLogada.email}</p>
      <p><strong>Situação:</strong> ${sessionScope.agenciaLogada.situacao}</p>
      <p><strong>Descrição:</strong> ${sessionScope.agenciaLogada.descricao}</p>
      <p><strong>CEP:</strong> ${sessionScope.agenciaLogada.cep}</p>
      <p><strong>Telefone:</strong> ${sessionScope.agenciaLogada.telefone}</p>
      <p><strong>WhatsApp:</strong> ${sessionScope.agenciaLogada.whatsapp}</p>
      <p><strong>Instagram:</strong> ${sessionScope.agenciaLogada.instagram}</p>
      <button onclick="window.location.href='editar-agencia.jsp'" class="btn-primario">Editar Dados</button>
      
      
       
   <%
    @SuppressWarnings("unchecked")
    List<Local> locais = (List<Local>) request.getAttribute("locais");
    if (locais == null) {
        LocalDao dao = new LocalDao();
        locais = dao.listarPorAgencia(agenciaLogada.getId());
        request.setAttribute("locais", locais);
    }
%>

<h1>Locais cadastrados</h1>

<%
    if (locais != null && !locais.isEmpty()) {
%>
    <table border="1">
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
    <%
        for (Local l : locais) {
    %>
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
    <%
        }
    %>
    </table>
<%
    } else {
%>
    <p>Nenhum local cadastrado.</p>
<%
    }
%>		
       <div>
      <button onclick="window.location.href='cadastrar-local.jsp'" class="btn-primario">Cadastrar Local</button>
       </div>
       </div>
       
		<!--<footer class="footer">
			<p>&copy; 2025 DeepBlue. Todos os direitos reservados.</p>
		</footer>-->
	


</body>

</html>