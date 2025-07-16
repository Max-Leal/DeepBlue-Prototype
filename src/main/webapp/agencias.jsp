<%@ page import="controllers.AgenciaController"%>
<%@ page import="models.Agencia"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title>DeepBlue - Turismo Náutico em Santa Catarina</title>
<link rel="stylesheet" href="static/css/crud-styles.css">
<link rel="stylesheet" href="static/css/main-styles.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css"
	rel="stylesheet">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap"
	rel="stylesheet">

</head>
<body>
		<script src="static/js/header.js"></script>
		<section class="crud-section" id="agencias">
			<h1 class="crud-titulo">Agências Cadastradas</h1>
			<div class="crud-lista">
				<%
				AgenciaController aController = new AgenciaController();
				List<Agencia> agencias = aController.listaAgencias();
				if (agencias != null && !agencias.isEmpty()) {
					for (Agencia agencia : agencias) {
				%>
				<div class="crud-card">
					<div class="crud-nome"><%=agencia.getNomeEmpresarial()%></div>
					<div class="crud-info">
						<b>CNPJ:</b>
						<%=agencia.getCnpj()%><br> <b>Email:</b>
						<%=agencia.getEmail()%><br> <b>Situação:</b>
						<%=agencia.getSituacao()%>
					</div>

					<!-- Botão para ver detalhes -->
					<div style="margin-top: 1rem;">
						<a href="agencia-detalhe.jsp?id=<%=agencia.getId()%>"
							class="cta-btn">Ver Detalhes</a>
					</div>
				</div>

				<%
				}
				} else {
				%>
				<p>Nenhuma agência cadastrada no momento.</p>
				<%
				}
				%>
			</div>
		</section>

	<script>
	 document.addEventListener('DOMContentLoaded', () => {
		  const el = document.getElementById("informacoes-login");
		  const usuario = localStorage.getItem("usuario");
		  const agencia = localStorage.getItem("agencia");

		  const dados = usuario ? JSON.parse(usuario) : agencia ? JSON.parse(agencia) : null;
		  const nome = dados?.nome || dados?.nomeEmpresarial;
		  const email = dados?.email;

		  if (el && nome && email) {
		    const div = document.createElement("div");
		    div.className = "usuario-logado";

		    ["Bem-vindo, " + nome, email].forEach(text => {
		      div.appendChild(document.createTextNode(text));
		      div.appendChild(document.createElement("br"));
		    });

		    const btn = document.createElement("button");
		    btn.textContent = "Sair";
		    btn.id = "logout-btn";
		    btn.style.marginTop = "0.5rem";
		    btn.onclick = () => {
		      localStorage.removeItem("usuario");
		      localStorage.removeItem("agencia");
		      location.reload();
		    };

		    div.appendChild(btn);
		    el.replaceWith(div);
		  }
		});



		function logout() {
		  localStorage.removeItem("usuario");
		  localStorage.removeItem("agencia");
		  location.reload();
		}
  	
        // Header scroll effect
        window.addEventListener('scroll', () => {
            const header = document.getElementById('header');
            if (window.scrollY > 100) {
                header.classList.add('scrolled');
            } else {
                header.classList.remove('scrolled');
            }
        });
    </script>
</body>
</html>