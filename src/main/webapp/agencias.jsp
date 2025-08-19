<%@ page import="controllers.AgenciaController"%>
<%@ page import="models.Agencia"%>
<%@ page import="models.Usuario"%>
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
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--azul-profundo) 0%, var(--azul-agua) 100%);
            min-height: 100vh;
            position: relative;
            display: flex;
            flex-direction: column;
        }

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 1440 320'%3E%3Cpath fill='%23ffffff' fill-opacity='0.1' d='M0,96L48,112C96,128,192,160,288,160C384,160,480,128,576,112C672,96,768,96,864,112C960,128,1056,160,1152,160C1248,160,1344,128,1392,112L1440,96L1440,320L1392,320C1344,320,1248,320,1152,320C1056,320,960,320,864,320C768,320,672,320,576,320C480,320,384,320,288,320C192,320,96,320,48,320L0,320Z'%3E%3C/path%3E%3C/svg%3E") bottom repeat-x;
            z-index: -1;
        }
    </style>
</head>
<body>
		
<%
    Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
    Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
%>
<script>
    window.usuarioLogado = <%= usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null" %>;
    window.usuarioEmail = <%= usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null" %>;
    window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
    window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
</script>

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
    <jsp:include page="components/chat.jsp" />
</body>
</html>