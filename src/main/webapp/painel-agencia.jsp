<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="models.Agencia, java.util.List, models.Local, daos.LocalDao"%>
<!DOCTYPE html>
<html lang="pt-br">

<head>
<meta charset="UTF-8">
<title>Painel Agência - Seus Dados e Locais</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

<style>
/* Paleta de Cores e Variáveis Globais */
:root {
	--azul-profundo: #01203a;
	--azul-escuro: #1e3a8a;
	--azul-medio: #3b82f6;
	--azul-agua: #60a5fa;
	--azul-claro: #EBF3FF; /* Cor mais suave para fundos e hovers */
	--cinza-fundo: #f4f6f9;
	--cinza-borda: #e5e7eb;
	--cinza-texto: #374151;
	--branco: #ffffff;
	--sombra-leve: 0 4px 12px rgba(0, 0, 0, 0.06);
	--sombra-media: 0 8px 30px rgba(0, 0, 0, 0.1);
	--raio-borda: 12px;
}

/* Estilos Base */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

html {
	scroll-behavior: smooth;
}

body {
	font-family: 'Poppins', sans-serif;
	background-color: var(--cinza-fundo);
	color: var(--cinza-texto);
	line-height: 1.6;
	-webkit-font-smoothing: antialiased;
	-moz-osx-font-smoothing: grayscale;
}

/* Container Principal */
.page-wrapper {
	
	margin: 2rem auto;
	padding: 2rem;
	display: flex;
	flex-direction: column;
	gap: 2.5rem;
}

/* Títulos */
h1, h2 {
	color: var(--azul-profundo);
	font-weight: 700;
}

h1 {
	font-size: 2.2rem;
	text-align: center;
	margin-bottom: 0.5rem;
}

h2 {
	font-size: 1.8rem;
	padding-bottom: 0.8rem;
	border-bottom: 2px solid var(--azul-medio);
	margin-bottom: 1.5rem;
}

/* Card de Informações da Agência */
.info-card {
	background: var(--branco);
	border-radius: var(--raio-borda);
	padding: 2rem;
	box-shadow: var(--sombra-leve);
	transition: box-shadow 0.3s ease;
	margin-top: 12.5%;
}

.info-card:hover {
	box-shadow: var(--sombra-media);
}

.info-grid {
	display: grid;
	grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
	gap: 1.5rem;
}

.info-item {
	display: flex;
	flex-direction: column;
}

.info-item strong {
	font-weight: 600;
	color: var(--azul-escuro);
	font-size: 0.9rem;
	margin-bottom: 0.2rem;
}

.info-item span {
	font-size: 1rem;
}

/* Botões */
.btn {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 0.75rem;
	padding: 0.8rem 1.8rem;
	border: none;
	border-radius: 50px;
	font-weight: 600;
	font-size: 1rem;
	cursor: pointer;
	text-decoration: none;
	transition: all 0.3s ease;
}

.btn-primario {

	background: linear-gradient(45deg, var(--azul-medio), var(--azul-escuro));
	color: white;
	box-shadow: 0 4px 10px rgba(59, 130, 246, 0.25);
	margin: 20px;
	
}


.btn-primario:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(59, 130, 246, 0.35);
}

.card-actions {
	margin-top: 2rem;
	text-align: right;
}

/* Container da Tabela */
.table-container {
	background-color: var(--branco);
	border-radius: var(--raio-borda);
	box-shadow: var(--sombra-leve);
	padding: 2rem;
	overflow-x: auto;
	/* Garante que a tabela não quebre o layout em telas menores */
}

.table-header {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1.5rem;
	flex-wrap: wrap;
	gap: 1rem;
}

.table-header h2 {
	margin: 0;
	border: none;
}

/* Tabela */
.data-table {
	width: 100%;
	border-collapse: collapse;
	border-spacing: 0;
}

.data-table th, .data-table td {
	padding: 1rem;
	text-align: left;
	vertical-align: middle;
	border-bottom: 1px solid var(--cinza-borda);
}

.data-table thead th {
	background-color: var(--azul-profundo);
	color: var(--branco);
	font-weight: 600;
	font-size: 0.9rem;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

/* Estilo para cantos arredondados do cabeçalho */
.data-table thead th:first-child {
	border-top-left-radius: 8px;
}

.data-table thead th:last-child {
	border-top-right-radius: 8px;
}

.data-table tbody tr {
	transition: background-color 0.2s ease;
}

/* Efeito Zebra-striping */
.data-table tbody tr:nth-child(even) {
	background-color: var(--cinza-fundo);
}

.data-table tbody tr:hover {
	background-color: var(--azul-claro);
}

.data-table tbody tr:last-child td {
	border-bottom: none;
}

.no-data-message {
	text-align: center;
	padding: 2rem;
	font-style: italic;
	color: #6c757d;
}

/* Responsividade */
@media ( max-width : 768px) {
	.page-wrapper {
		padding: 1rem;
		margin: 1rem auto;
	}
	h1 {
		font-size: 1.8rem;
	}
	h2 {
		font-size: 1.5rem;
	}
	.info-card, .table-container {
		padding: 1.5rem;
	}
	.info-grid {
		grid-template-columns: 1fr; /* Coluna única em telas menores */
		gap: 1rem;
	}
	.card-actions {
		text-align: center;
	}

	/* Transforma a tabela em lista de cards */
	.data-table thead {
		display: none;
	}
	.data-table, .data-table tbody, .data-table tr, .data-table td {
		display: block;
		width: 100%;
	}
	.data-table tr {
		margin-bottom: 1rem;
		border: 1px solid var(--cinza-borda);
		border-radius: var(--raio-borda);
		padding: 1rem;
	}
	.data-table td {
		display: flex;
		justify-content: space-between;
		align-items: center;
		border: none;
		padding: 0.6rem 0;
	}
	.data-table td::before {
		content: attr(data-label);
		font-weight: 600;
		color: var(--azul-escuro);
		padding-right: 1rem;
	}
}
.mensagem-sucesso{
        background: #16a34a;
        color: white;
        padding: 12px;
        border-radius: 8px;
        margin-bottom: 15px;
        text-align: center;
        font-weight: bold;
        }
</style>
</head>

<body>
<% String msg = (String) request.getAttribute("mensagemSucesso"); %>
<% if (msg != null) { %>
    <div>
        <%= msg %>
    </div>
<% } %>

<script>
    const msgDiv = document.getElementById("mensagem-sucesso");
    if (msgDiv) {
        setTimeout(() => {
            msgDiv.style.display = "none";
        }, 3000);
    }
</script>

	<%
	Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
	%>
	<script>
		window.agenciaLogada =
	<%=agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null"%>
		;
		window.agenciaEmail =
	<%=agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null"%>
		;
	</script>

	<script src="static/js/header.js"></script>
	<div class="page-wrapper">

		<section class="info-card">
			<h2>
				<i class="fas fa-building"></i> Seus Dados
			</h2>
			<div class="info-grid">
				<div class="info-item">
					<strong>Nome Empresarial:</strong> <span>${sessionScope.agenciaLogada.nomeEmpresarial}</span>
				</div>
				<div class="info-item">
					<strong>CNPJ:</strong> <span>${sessionScope.agenciaLogada.cnpj}</span>
				</div>
				<div class="info-item">
					<strong>Email:</strong> <span>${sessionScope.agenciaLogada.email}</span>
				</div>
				<div class="info-item">
					<strong>Situação:</strong> <span>${sessionScope.agenciaLogada.situacao}</span>
				</div>
				<div class="info-item">
					<strong>CEP:</strong> <span>${sessionScope.agenciaLogada.cep}</span>
				</div>
				<div class="info-item">
					<strong>Telefone:</strong> <span>${sessionScope.agenciaLogada.telefone}</span>
				</div>
				<div class="info-item">
					<strong>WhatsApp:</strong> <span>${sessionScope.agenciaLogada.whatsapp}</span>
				</div>
				<div class="info-item">
					<strong>Instagram:</strong> <span>${sessionScope.agenciaLogada.instagram}</span>
				</div>
				<div class="info-item" style="grid-column: 1/-1;">
					<strong>Descrição:</strong> <span>${sessionScope.agenciaLogada.descricao}</span>
				</div>
			</div>
			<div class="card-actions">
				<a href="editar-agencia.jsp" class="btn btn-primario"> <i
					class="fas fa-pencil-alt"></i> Editar Dados
				</a>
			</div>
		</section>

		<div class="table-container">
			<div class="table-header">
				<h2>
					<i class="fas fa-map-marker-alt"></i> Locais Vinculados
				</h2>
				<a href="vincular-local.jsp" class="btn btn-primario"> <i
					class="fas fa-plus"></i> Vincular-se a um local
				</a>
				
				
			</div>

			<%
    @SuppressWarnings("unchecked")
    List<Local> locais = (List<Local>) request.getAttribute("locais");
    if (locais == null) {
        LocalDao dao = new LocalDao();
        locais = dao.getLista();
        request.setAttribute("locais", locais);
    }

    if (locais != null && !locais.isEmpty()) {
%>

			<table class="data-table">
				<thead>
					<tr>
						<th>Nome</th>
						<th>Localidade</th>
						<th>Embarcação</th>
						<th>Profundidade</th>
						<th>Latitude</th>
						<th>Longitude</th>
					</tr>
				</thead>
				<tbody>
					<%
					for (Local l : locais) {
					%>
					<tr>
						<td data-label="Nome"><%=l.getNome()%></td>
						<td data-label="Localidade"><%=l.getLocalidade()%></td>
						<td data-label="Embarcação"><%=l.getTipoEmbarcacao()%> (<%=l.getAnoAfundamento()%>)</td>
						<td data-label="Profundidade"><%=l.getProfundidade()%>m</td>
						<td data-label="Latitude"><%=l.getLatitude()%></td>
						<td data-label="Longitude"><%=l.getLongitude()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			
			<%
			} else {
			%>
			<div class="no-data-message">
				<p>Nenhum local vínculado no momento.</p>
			</div>
			<%
			}
			%>
			<div>
			<a href="cadastrar-local.jsp" class="btn btn-primario"> <i
					class="fas fa-plus"></i> Cadastrar um novo local
				</a>
				</div>
			
			
		</div>

	</div>
	<jsp:include page="components/chat.jsp" />
</body>
</html>