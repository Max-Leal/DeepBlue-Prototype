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
	<link rel="stylesheet" href="static/css/main-styles.css">
	<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<style>
:root {
	--azul-profundo: #01203a;
	--azul-escuro: #1e3a8a;
	--azul-medio: #3b82f6;
	--azul-agua: #60a5fa;
	--cinza-fundo: #f4f6f9;
	--cinza-borda: #d1d5db;
	--cinza-texto: #374151;
	--branco: #ffffff;
	--sombra-leve: 0 4px BRL12px rgba(0, 0, 0, 0.06);
	--raio-borda: 12px;
}

/* Estilos Base */
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	background-color: var(--cinza-fundo);
	color: var(--cinza-texto);
	display: flex;
	justify-content: center;
	align-items: center;
	min-height: 100vh;
	padding: 2rem 1rem;
	margin:30px;
}

/* Container do Formulário */
.form-container {
	width: 100%;
	max-width: 800px;
	background: var(--branco);
	padding: 2.5rem;
	border-radius: var(--raio-borda);
	box-shadow: var(--sombra-leve);
	margin-top: 10%;
}

.form-header {
	text-align: center;
	margin-bottom: 2rem;
}

.form-header h2 {
	font-size: 1.8rem;
	color: var(--azul-profundo);
	font-weight: 700;
	display: inline-flex;
	align-items: center;
	gap: 0.8rem;
}

/* Layout em Grade para os Campos */
.form-grid {
	display: grid;
	grid-template-columns: repeat(2, 1fr);
	gap: 1.5rem;
}

.form-group {
	display: flex;
	flex-direction: column;
	gap: 0.5rem;
}

/* Classe para campos que ocupam a largura total */
.form-group.full-width {
	grid-column: 1/-1;
}

label {
	font-weight: 600;
	font-size: 0.9rem;
	color: var(--azul-escuro);
}

.input-padrao, .select-padrao, textarea.input-padrao {
	width: 100%;
	padding: 0.75rem 1rem;
	border: 1px solid var(--cinza-borda);
	border-radius: 8px;
	font-size: 1rem;
	font-family: 'Poppins', sans-serif;
	transition: border-color 0.3s, box-shadow 0.3s;
}

.input-padrao:focus, .select-padrao:focus {
	outline: none;
	border-color: var(--azul-medio);
	box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.2);
}

textarea.input-padrao {
	min-height: 80px;
	resize: vertical;
}

/* Botão */
.form-actions {
	text-align: center;
	margin-top: 2rem;
}

.btn {
	border: none;
	padding: 0.8rem 2rem;
	border-radius: 30px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	font-size: 1rem;
	text-decoration: none;
	text-align: center;
}

.btn-primario {
	display: inline-flex;
	align-items: center;
	justify-content: center;
	gap: 0.75rem;
	background: linear-gradient(45deg, var(--azul-medio), var(--azul-escuro));
	color: white;
	border: none;
	padding: 0.9rem 2.2rem;
	border-radius: 50px;
	font-weight: 600;
	cursor: pointer;
	transition: all 0.3s ease;
	font-size: 1.05rem;
	box-shadow: 0 4px 10px rgba(59, 130, 246, 0.25);
}

.btn-primario:hover {
	transform: translateY(-3px);
	box-shadow: 0 6px 15px rgba(59, 130, 246, 0.35);
}

.btn-secundario {
	background-color: transparent;
	color: var(--azul-medio);
	border: 2px solid var(--azul-medio);
}

.btn-secundario:hover {
	background-color: var(--azul-medio);
	color: white;
}

/* Responsividade */
@media ( max-width : 768px) {
	.form-grid {
		grid-template-columns: 1fr; /* Coluna única */
	}
	.form-container {
		padding: 1.5rem;
	}
}
</style>
</head>
<body>

 <div class="page-wrapper">
<%
Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
%>
	<script>
window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
</script>

  <script src="static/js/header.js"></script>

    <main class="form-container">
		<div class="form-header">
			<h2>
				<i class="fas fa-plus"></i> Cadastrar novo local
			</h2>
		</div>

		<form action="CadastrarLocalServlet" method="post" autocomplete="off">
			

			<div class="form-grid">
				<div class="form-group full-width">
					<label for="nome">Nome:</label> <input
						type="text" id="nome" name="nome"
						class="input-padrao"required>
				</div>

				<div class="form-group full-width">
					<label for="localidade">Localidade:</label> <input type="text" id="localidade"
						name="localidade" class="input-padrao" required>
				</div>

				<div class="form-group">
					<label for="descricao">Descrição:</label> <input type="text" id="descricao"
						name="descricao" class="input-padrao"required>
				</div>

				<div class="form-group">
					<label for="TipoEmbarcacao">Tipo de Embarcação:</label> <input type="text" id="TipoEmbarcacao"
						name="TipoEmbarcacao" class="input-padrao" required>
				</div>

				<div class="form-group">
					<label for="anoAfundamento">Ano de Afundamento:</label> <input type="number" id="anoAfundamento"
						name="anoAfundamento" class="input-padrao">
				</div>
				<div class="form-group">
					<label for="profundidade">Profundidade (m):</label> <input type="number" id="profundidade"
						name="profundidade" class="input-padrao">
				</div>

				<div class="form-group">
				
					 <label for="situacao">Situação:</label>
					 <select id="situacao" name="situacao" class="input-padrao"required>
               <option value="">Selecione</option>
                <option value="DISPONIVEL">Disponível</option>
                 <option value="INDIPONIVEL">Indisponível</option>
                 </select>
				</div>

				<div class="form-group">
					<label for="latitude">Latitude:</label> <input type="text"
						id="latitude" name="latitude" class="input-padrao">
				</div>

				<div class="form-group">
					<label for="longitude">Longitude:</label> <input type="text"
						id="longitude" name="longitude" class="input-padrao">
				</div>
			<div class="form-actions">
			    <a href="painel-agencia.jsp" class="btn btn-secundario">Cancelar</a>
				<button type="submit" class="btn-primario">
					<i class="fas fa-plus"></i> Cadastrar
				</button>
			</div>
		</div>
	</form>
 </main>
</div>
			



</body>
</html>
