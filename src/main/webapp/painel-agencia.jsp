<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="models.Agencia, java.util.*, models.Local, models.AgenciaLocal, daos.LocalDao, controllers.LocalController, controllers.AgenciaLocalController"%>

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
<link rel="stylesheet" href="static/css/painel-agencia-styles.css">
</head>

<body>
	<%
	String msg = (String) request.getAttribute("mensagemSucesso");
	%>
	<%
	if (msg != null) {
	%>
	<div>
		<%=msg%>
	</div>
	<%
	}
	%>

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
			LocalController lc = new LocalController();
			AgenciaLocalController alc = new AgenciaLocalController();
			
			List<AgenciaLocal> idsLocaisVinculados = alc.getLocaisPorAgencia(agenciaLogada.getId());
			List<Local> locaisVinculados = new ArrayList<>();
			
			for (AgenciaLocal al : idsLocaisVinculados) {
				locaisVinculados.add(lc.getLocalById(al.getIdLocal())); 
			}
			
			
			
			if (locaisVinculados != null && !locaisVinculados.isEmpty()) {
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
					for (Local l : locaisVinculados) {
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
				<p>Nenhum local vinculado no momento.</p>
			</div>
			<%
			}
			%>
			<div>
			<br>
				<a href="cadastrar-local.jsp" class="btn btn-primario"> <i
					class="fas fa-plus"></i> Cadastrar um novo local
				</a>
			</div>


		</div>

	</div>
	<jsp:include page="components/chat.jsp" />
</body>
</html>