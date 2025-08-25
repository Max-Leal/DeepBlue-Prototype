<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="models.Agencia" %>
<%@ page import="Enums.Situacao" %>
<%@ page import="java.util.List" %>
<%@ page import="models.Local" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Editar Dados Agência</title>
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

		input[type="checkbox"] {
			display: none;
		}
		
    .page-wrapper {
    max-width: 1100px;
    margin: 2rem auto;
    padding: 2rem;
    background: #fff;
    border-radius: 16px;
    box-shadow: 0 4px 16px rgba(0,0,0,0.08);
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
<%
    Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
    if (agenciaLogada == null) {
        response.sendRedirect("index.html");
        return;
    }
%>

<script>
    window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
    window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
    </script>
    
    <script src="static/js/header.js"></script>

<section style="max-width: 700px; margin: 40px auto; background: #fff; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1);">
    <h2 style="text-align:center; margin-bottom: 20px;">Editar Dados da Agência</h2>
    <form action="EditarAgenciaServlet" method="post" autocomplete="off">
        <input type="hidden" name="id" value="<%= agenciaLogada.getId() %>">

        <div class="form-group">
            <label for="nomeEmpresarial">Nome Empresarial:</label>
            <input type="text" id="nomeEmpresarial" name="nomeEmpresarial" class="input-padrao" value="<%= agenciaLogada.getNomeEmpresarial() %>" required>
        </div>
        <div class="form-group">
            <label for="cnpj">CNPJ:</label>
            <input type="text" id="cnpj" name="cnpj" class="input-padrao" value="<%= agenciaLogada.getCnpj() %>" required>
        </div>
        <div class="form-group">
            <label for="email">Email:</label>
            <input type="email" id="email" name="email" class="input-padrao" value="<%= agenciaLogada.getEmail() %>" required>
        </div>
        <div class="form-group">
            <label for="senha">Senha:</label>
            <input type="password" id="senha" name="senha" class="input-padrao" value="<%= agenciaLogada.getSenha() %>" required>
        </div>
        <div class="form-group">
            <label for="situacao">Situação da Agência:</label>
            <select id="situacao" name="situacao" class="select-padrao" required>
              <option value="INDISPONIVEL" <%= "INDISPONIVEL".equals(agenciaLogada.getSituacao().toString()) ? "selected" : "" %>>INDISPONÍVEL</option>
<option value="DISPONIVEL" <%= "DISPONIVEL".equals(agenciaLogada.getSituacao().toString()) ? "selected" : "" %>>DISPONÍVEL</option>

            </select>
        </div>
        <div class="form-group">
            <label for="descricao">Descrição:</label>
            <input type="text" id="descricao" name="descricao" class="input-padrao" value="<%= agenciaLogada.getDescricao() %>">
        </div>
        <div class="form-group">
            <label for="cep">CEP:</label>
            <input type="text" id="cep" name="cep" class="input-padrao" value="<%= agenciaLogada.getCep() %>">
        </div>
        <div class="form-group">
            <label for="telefone">Telefone:</label>
            <input type="text" id="telefone" name="telefone" class="input-padrao" value="<%= agenciaLogada.getTelefone() %>">
        </div>
        <div class="form-group">
            <label for="whatsapp">Whatsapp:</label>
            <input type="text" id="whatsapp" name="whatsapp" class="input-padrao" value="<%= agenciaLogada.getWhatsapp() %>">
        </div>
        <div class="form-group">
            <label for="instagram">Instagram:</label>
            <input type="text" id="instagram" name="instagram" class="input-padrao" value="<%= agenciaLogada.getInstagram() %>">
        </div>
        <div style="text-align: center; margin-top: 1.5rem;">
            <button type="submit" class="btn-primario">Salvar Alterações</button>
        </div>
    </form>
</section>

		<!--<footer class="footer">
			<p>&copy; 2025 DeepBlue. Todos os direitos reservados.</p>
		</footer>-->
	
             
</body>
</html>