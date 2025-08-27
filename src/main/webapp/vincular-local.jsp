<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page
	import="models.Agencia, java.util.List, models.Local, daos.LocalDao, controllers.LocalController"%>

<!DOCTYPE html>
<html lang="pt-br">

<head>
<meta charset="UTF-8">
<title>Vincular local - DeepBlue</title>
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

			List<Local> locais = lc.listaLocais();

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