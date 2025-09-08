<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="models.Agencia"%>
<%@ page import="Enums.Situacao"%>
<%@ page import="java.util.List"%>
<%@ page import="models.Local"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>Editar Dados da Agência</title>
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
	padding: 0.8rem 2.5rem;
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
	<%
	Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
	if (agenciaLogada == null) {
		response.sendRedirect("index.html");
		return;
	}
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
	<main class="form-container">
		<div class="form-header">
			<h2>
				<i class="fas fa-edit"></i> Editar Dados da Agência
			</h2>
		</div>

		<form action="EditarAgenciaServlet" method="post" autocomplete="off">
			<input type="hidden" name="id" value="<%=agenciaLogada.getId()%>">

			<div class="form-grid">
				<div class="form-group full-width">
					<label for="nomeEmpresarial">Nome Empresarial:</label> <input
						type="text" id="nomeEmpresarial" name="nomeEmpresarial"
						class="input-padrao"
						value="<%=agenciaLogada.getNomeEmpresarial()%>" required>
				</div>

				<div class="form-group full-width">
					<label for="cnpj">CNPJ:</label> <input type="text" id="cnpj"
						name="cnpj" class="input-padrao"
						value="<%=agenciaLogada.getCnpj()%>" required>
				</div>

				<div class="form-group">
					<label for="email">Email:</label> <input type="email" id="email"
						name="email" class="input-padrao"
						value="<%=agenciaLogada.getEmail()%>" required>
				</div>

				<div class="form-group">
					<label for="senha">Senha:</label> <input type="password" id="senha"
						name="senha" class="input-padrao"
						placeholder="Digite uma nova senha para alterar" required>
				</div>

				<div class="form-group">
					<label for="cep">CEP:</label> <input type="text" id="cep"
						name="cep" class="input-padrao"
						value="<%=agenciaLogada.getCep()%>">
				</div>

				<div class="form-group">
					<label for="situacao">Situação da Agência:</label> <select
						id="situacao" name="situacao" class="select-padrao" required>
						<option value="INDISPONIVEL"
							<%="INDISPONIVEL".equals(agenciaLogada.getSituacao().toString()) ? "selected" : ""%>>INDISPONÍVEL</option>
						<option value="DISPONIVEL"
							<%="DISPONIVEL".equals(agenciaLogada.getSituacao().toString()) ? "selected" : ""%>>DISPONÍVEL</option>
					</select>
				</div>

				<div class="form-group">
					<label for="telefone">Telefone:</label> <input type="text"
						id="telefone" name="telefone" class="input-padrao"
						value="<%=agenciaLogada.getTelefone()%>">
				</div>

				<div class="form-group">
					<label for="whatsapp">WhatsApp:</label> <input type="text"
						id="whatsapp" name="whatsapp" class="input-padrao"
						value="<%=agenciaLogada.getWhatsapp()%>">
				</div>

				<div class="form-group full-width">
					<label for="instagram">Instagram:</label> <input
						type="text" id="instagram" name="instagram" class="input-padrao"
						value="<%=agenciaLogada.getInstagram()%>">
				</div>

				<div class="form-group full-width">
					<label for="descricao">Descrição:</label>
					<textarea id="descricao" name="descricao" class="input-padrao"><%=agenciaLogada.getDescricao()%></textarea>
				</div>
			</div>

			<div class="form-actions">
			    <a href="painel-agencia.jsp" class="btn btn-secundario">Cancelar</a>
				<button type="submit" class="btn-primario">
					<i class="fas fa-save"></i> Salvar Alterações
				</button>
			</div>
		</form>
	</main>

</body>
</html>