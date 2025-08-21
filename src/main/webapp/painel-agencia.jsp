<%@ page import="models.Agencia" %>
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

	<style>
		:root {
			--azul-profundo: #01203a;
			--azul-escuro: #1e3a8a;
			--azul-medio: #3b82f6;
			--azul-agua: #60a5fa;
			--azul-claro: #93c5fd;
		}

		body {
			font-family: 'Poppins', sans-serif;
			margin: 0;
			padding: 0;
			background-color: #f4f6f9;
		}

		.accordion-wrapper {
			margin-top: 120px;
		}

		.accordion {
			max-width: 700px;
			margin: 40px auto;
			background-color: #fff;
			border-radius: 8px;
			box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
		}

		.accordion-item {
			border-bottom: 1px solid #ddd;
		}

		input[type="checkbox"] {
			display: none;
		}

		.accordion-header {
			display: flex;
			justify-content: space-between;
			align-items: center;
			padding: 15px 20px;
			cursor: pointer;
			background-color: #f8f9fa;
			transition: background-color 0.3s ease;
		}

		.accordion-header:hover {
			background-color: #e9ecef;
		}

		.accordion-title {
			font-size: 16px;
			color: #212529;
		}

		.accordion-icon {
			transition: transform 0.3s ease;
			font-size: 18px;
		}

		input[type="checkbox"]:checked+label .accordion-icon {
			transform: rotate(180deg);
		}

		.accordion-content {
			max-height: 0;
			overflow: hidden;
			background-color: white;
			padding: 0 20px;
			transition: max-height 0.4s ease, padding 0.4s ease;
		}

		input[type="checkbox"]:checked~.accordion-content {
			max-height: 1000px;
			padding: 20px;
		}

		.form-group {
			margin-bottom: 1.5rem;
			display: flex;
			flex-direction: column;
		}

		.input-padrao,
		.select-padrao {
			padding: 0.6rem 1rem;
			border: 1px solid var(--azul-claro);
			border-radius: 8px;
			font-size: 1rem;
			outline: none;
			transition: 0.3s;
			font-family: 'Poppins', sans-serif;
		}

		.input-padrao:focus,
		.select-padrao:focus {
			border-color: var(--azul-medio);
			box-shadow: 0 0 5px rgba(59, 130, 246, 0.3);
		}

		.btn-primario {
			background: linear-gradient(45deg, var(--azul-medio), var(--azul-agua));
			color: white;
			border: none;
			padding: 0.8rem 2rem;
			border-radius: 30px;
			font-weight: 600;
			cursor: pointer;
			transition: background 0.3s ease;
			font-size: 1rem;
		}

		.btn-primario:hover {
			background: linear-gradient(45deg, var(--azul-claro), var(--azul-medio));
		}

		/* Garante checkbox visível e com tamanho padrão */
		input[type="checkbox"] {
			appearance: auto !important;
			-webkit-appearance: checkbox !important;
			width: 1rem;
			height: 1rem;
			margin-right: 0.5rem;
			vertical-align: middle;
		}
	</style>
</head>

<body>

	<script src="static/js/header.js"></script>
	<%

    Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
%>
<script>
    window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
    window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
</script>
	
       
				<div class="accordion-item">
					<input type="checkbox" id="formToggle"> <label for="formToggle" class="accordion-header"> <span
							class="accordion-title"><i class="fas fa-plus-circle"></i>
							Cadastrar Novo Local</span> <span class="accordion-icon">▼</span>
					</label>
					<div class="accordion-content">
						<form action="painel-adicionar-local.jsp" method="post" autocomplete="off"
							style="max-width: 600px; margin: auto;">
							<div class="form-group">
								<label for="localidade"><i class="fas fa-location-dot"></i>
									Localidade:</label> <input type="text" id="localidade" name="localidade"
									class="input-padrao" required>
							</div>

							<div class="form-group">
								<label for="situacao"><i class="fas fa-flag"></i>
									Situação:</label> <select id="situacao" name="situacao" class="select-padrao"
									required>
									<option value="INDISPONÍVEL" selected>INDISPONÍVEL</option>
									<option value="DISPONÍVEL">DISPONÍVEL</option>
								</select>
							</div>

							<div class="form-group">
								<label for="nome"><i class="fas fa-map-marker-alt"></i>
									Nome do Local:</label> <input type="text" id="nome" name="nome" class="input-padrao"
									required>
							</div>

							<div class="form-group">
								<label for="descricao"><i class="fas fa-align-left"></i>
									Descrição:</label>
								<textarea id="descricao" name="descricao" rows="2" class="input-padrao"
									required></textarea>
							</div>

							<div class="form-group">
								<label for="latitude"><i class="fas fa-arrows-alt-v"></i>
									Latitude:</label> <input type="text" id="latitude" name="latitude"
									class="input-padrao" required>
							</div>

							<div class="form-group">
								<label for="longitude"><i class="fas fa-arrows-alt-h"></i>
									Longitude:</label> <input type="text" id="longitude" name="longitude"
									class="input-padrao" required>
							</div>

							<div class="form-group">
								<label><i class="fas fa-water"></i> Serviços oferecidos:</label>
								<div
									style="display: flex; gap: 1.5rem; flex-wrap: wrap; padding-left: 0.3rem; align-items: center;">
									<label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
										<input type="checkbox" id="oferecePasseio" name="oferecePasseio">
										Passeio
									</label>
									<label style="display: flex; align-items: center; gap: 0.5rem; cursor: pointer;">
										<input type="checkbox" id="ofereceMergulho" name="ofereceMergulho">
										Mergulho
									</label>
								</div>
							</div>


							<input type="hidden" id="idAgencia" name="idAgencia">
		

							<div style="text-align: center;">
								<button type="submit" class="btn-primario">
									<i class="fas fa-plus"></i> Cadastrar Local
								</button>
							</div>
						</form>
					</div>
				</div>

         <h1>Seus Dados</h1>

      <p><strong>Nome:</strong> ${sessionScope.agenciaLogada.nomeEmpresarial}</p>
      <p><strong>CNPJ:</strong> ${sessionScope.agenciaLogada.cnpj}</p>
      <p><strong>Email:</strong> ${sessionScope.agenciaLogada.email}</p>
      <p><strong>Senha:</strong> ${sessionScope.agenciaLogada.senha}</p>
      <p><strong>Situação:</strong> ${sessionScope.agenciaLogada.situacao}</p>
      <p><strong>Descrição:</strong> ${sessionScope.agenciaLogada.descricao}</p>
      <p><strong>CEP:</strong> ${sessionScope.agenciaLogada.cep}</p>
      <p><strong>Telefone:</strong> ${sessionScope.agenciaLogada.telefone}</p>
      <p><strong>WhatsApp:</strong> ${sessionScope.agenciaLogada.whatsapp}</p>
      <p><strong>Instagram:</strong> ${sessionScope.agenciaLogada.instagram}</p>
      <button onclick="window.location.href='editar-agencia.jsp'" class="btn-primario">Editar Dados</button>
      
      <div>
      <button onclick="window.location.href='cadastrar-local.jsp'" class="btn-primario">Cadastrar Local</button>
       </div>

		
		<!--<footer class="footer">
			<p>&copy; 2025 DeepBlue. Todos os direitos reservados.</p>
		</footer>-->
	


</body>

</html>