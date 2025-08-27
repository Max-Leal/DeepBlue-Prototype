<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page
	import="models.Agencia, models.Usuario, models.AgenciaLocal, models.Local,  models.AvaliacaoAgencia"%>
<%@ page import="Enums.Situacao"%>
<%@ page
	import="controllers.AgenciaLocalController,  controllers.AgenciaController, controllers.LocalController, controllers.AvaliacaoAgenciaController, controllers.UsuarioController"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

// ----- LÓGICA DE MENSAGENS E PROCESSAMENTO DO FORMULÁRIO -----

String postMensagem = ""; // Mensagem de erro específica do POST
String flashMensagem = ""; // Mensagem de sucesso/status vinda do redirect

// 1. Verifica por mensagens "flash" da sessão (após um redirect)
if (session.getAttribute("flashMensagem") != null) {
	flashMensagem = (String) session.getAttribute("flashMensagem");
	session.removeAttribute("flashMensagem"); // Limpa para não mostrar de novo
}

// 2. Processa o formulário de avaliação (POST)
if ("POST".equalsIgnoreCase(request.getMethod())) {
	try {
		int escala = Integer.parseInt(request.getParameter("estrela"));
		String sugestao = request.getParameter("avaliacao");
		String agenciaIdParam = request.getParameter("id"); // O 'id' virá de um input hidden

		Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

		if (usuarioLogado == null) {
	postMensagem = "Você precisa estar logado como usuário para avaliar.";
		} else if (sugestao == null || sugestao.trim().isEmpty()) {
	postMensagem = "Por favor, escreva uma sugestão.";
		} else if (agenciaIdParam == null || agenciaIdParam.trim().isEmpty()) {
	postMensagem = "ID da agência inválido.";
		} else {
	Long agenciaId = Long.parseLong(agenciaIdParam);

	AvaliacaoAgencia avaliacao = new AvaliacaoAgencia();
	avaliacao.setEscala(escala);
	avaliacao.setSugestao(sugestao);
	avaliacao.setUsuarioId(usuarioLogado.getId());
	avaliacao.setAgenciaId(agenciaId);

	AvaliacaoAgenciaController avController = new AvaliacaoAgenciaController();
	avController.registrarAvaliacao(avaliacao);

	// **A CORREÇÃO PRINCIPAL:** Salva a mensagem na sessão antes de redirecionar
	session.setAttribute("flashMensagem", "Avaliação enviada com sucesso!");
	response.sendRedirect("agencia-detalhe.jsp?id=" + agenciaId);
	return; // Importante para parar a execução da página aqui
		}
	} catch (Exception e) {
		// Em caso de erro, a página será recarregada mostrando a mensagem de erro
		postMensagem = "Erro ao enviar avaliação: " + e.getMessage();
	}
}

// ----- LÓGICA PARA CARREGAR DADOS DA PÁGINA (GET) -----

String idParam = request.getParameter("id");
Agencia agencia = null;
List<AgenciaLocal> locaisRelacionados = new ArrayList<>();
List<AvaliacaoAgencia> avaliacoes = new ArrayList<>();
LocalController localController = new LocalController();
UsuarioController userController = new UsuarioController();

if (idParam != null) {
	try {
		int id = Integer.parseInt(idParam);
		AgenciaController controller = new AgenciaController();
		agencia = controller.getAgenciaById(id);

		if (agencia != null) {
	AgenciaLocalController alController = new AgenciaLocalController();
	locaisRelacionados = alController.getLocaisPorAgencia(agencia.getId());

	AvaliacaoAgenciaController avController = new AvaliacaoAgenciaController();
	avaliacoes = avController.getAvaliacoesPorAgencia(agencia.getId());
		}
	} catch (NumberFormatException e) {
	}
}

//Lógica para fazer a média de estrelas:
double escalaAgencia = 0;
for (AvaliacaoAgencia av : avaliacoes) {
	escalaAgencia += av.getEscala();
}

escalaAgencia = escalaAgencia / avaliacoes.size();
%>



<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title><%=(agencia != null) ? agencia.getNomeEmpresarial() : "Agência não encontrada"%></title>

<link rel="stylesheet" href="static/css/main-styles.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<style>
.agency-contact-container {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 1rem; /* Adiciona um espaço antes das estrelas */
}

.agency-name {
	margin: 0;
	font-size: 2.5rem; /* Mantém o tamanho original do seu H1 */
	color: var(--azul-escuro);
}

.chat-button {
	padding: 10px 18px;
	font-size: 1em;
	font-weight: bold;
	color: white;
	background-color: var(--azul-escuro); /* Usa a cor do seu tema */
	border: none;
	border-radius: 8px;
	cursor: pointer;
	transition: background-color 0.3s ease;
	white-space: nowrap; /* Impede que o texto quebre linha */
}

.chat-button:hover {
	background-color: var(--azul-medio); /* Usa a cor do seu tema */
}

section {
	margin-top: 2rem;
	margin-bottom: 2rem;
}

.detalhes-container {
	margin-top: 120px;
	padding: 3rem 2rem;
	max-width: 800px;
	margin-left: auto;
	margin-right: auto;
	background: var(--cinza-claro);
	border-radius: 20px;
	box-shadow: 0 15px 40px rgba(0, 0, 0, 0.08);
}

.detalhes-container h1 {
	font-size: 2.5rem;
	color: var(--azul-escuro);
	margin-bottom: 1rem;
}

.detalhes-container p {
	font-size: 1.1rem;
	margin-bottom: 0.8rem;
	color: var(--cinza-medio);
}

/* Estilos para lista de locais */
.locais-lista {
	display: flex;
	flex-wrap: wrap;
	gap: 1.5rem;
	margin-top: 2rem;
}

.local-card {
	background: white;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	padding: 1.5rem;
	width: calc(50% - 1.5rem);
	box-sizing: border-box;
	transition: box-shadow 0.3s ease;
}

.local-card:hover {
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.local-card h3 {
	color: var(--azul-escuro);
	margin-bottom: 0.5rem;
}

.local-card p {
	color: var(--cinza-medio);
	margin-bottom: 0.3rem;
}

.avaliacoes-form {
	margin-top: 2rem;
}

.avaliacoes-form textarea {
	width: 100%;
	height: 100px;
	padding: 12px;
	border-radius: 8px;
	border: 1px solid #ccc;
	font-size: 1rem;
	resize: vertical;
}

.avaliacoes-form button {
	margin-top: 10px;
	padding: 10px 20px;
	background-color: var(--azul-escuro);
	color: #fff;
	border: none;
	border-radius: 6px;
	cursor: pointer;
	transition: background-color 0.3s ease;
}

.avaliacoes-form button:hover {
	background-color: var(--azul-medio);
}

/* Lista de avaliações */
.avaliacoes-lista {
	margin-top: 2rem;
}

.avaliacao {
	background-color: #f5f5f5;
	border-radius: 10px;
	padding: 1rem;
	margin-bottom: 1rem;
	box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
}

.avaliacao strong {
	color: var(--azul-escuro);
	font-size: 1rem;
}

.avaliacao span {
	font-size: 0.9rem;
	color: var(--cinza-medio);
	margin-left: 10px;
}

.avaliacao p {
	margin-top: 0.5rem;
	font-size: 1rem;
	color: #333;
}

.stars {
	direction: rtl;
	unicode-bidi: bidi-override;
	font-size: 2em;
	display: inline-flex;
}

.stars input {
	display: none;
}

.stars label {
	color: #ccc;
	cursor: pointer;
}

.stars input:checked ~ label, .stars label:hover, .stars label:hover ~
	label {
	color: gold;
}

@media ( max-width : 600px) {
	.local-card {
		width: 100%;
	}
}
</style>
</head>
<body>
	<div class="page-wrapper">
		<%
		Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
		Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");
		%>
		<script>
    window.usuarioLogado = <%=usuarioLogado != null ? "\"" + usuarioLogado.getNome() + "\"" : "null"%>;
    window.usuarioEmail = <%=usuarioLogado != null ? "\"" + usuarioLogado.getEmail() + "\"" : "null"%>;
    window.agenciaLogada = <%=agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null"%>;
    window.agenciaEmail = <%=agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null"%>;
</script>

		<script src="static/js/header.js"></script>

		<main class="detalhes-container">
			<%
			if (agencia != null) {
			%>
			<div class="agency-contact-container">
				<h1 class="agency-name"><%=agencia.getNomeEmpresarial()%></h1>
				<button class="chat-button"
					data-chave="agencia-<%=agencia.getId()%>"
					data-nome="<%=agencia.getNomeEmpresarial()%>"
					onclick="iniciarChatComAgencia(this)">Iniciar Conversa</button>
			</div>

			<h3 style="margin: 0px; margin-bottom: 10px">

				<%
				for (int i = 1; i <= 5; i++) {
				%>
				<%
				if (i <= escalaAgencia) {
				%>
				<span style="color: gold;">&#9733;</span>
				<%
				} else {
				%>
				<span style="color: #ccc;">&#9733;</span>
				<%
				}
				%>
				<%
				}
				%>
			</h3>
			<p>
				<strong>CNPJ:</strong>
				<%=agencia.getCnpj()%></p>
			<p>
				<strong>Email:</strong>
				<%=agencia.getEmail()%></p>
			<p>
				<strong>Situação:</strong>
				<%
				String disponibilidadeAgencia;
				if (agencia.getSituacao().toString().toLowerCase().replace("_", " ").equals("disponivel")) {
					disponibilidadeAgencia = "Disponível";
				} else {
					disponibilidadeAgencia = "Indisponível";
				}
				%>
				<%=disponibilidadeAgencia%></p>

			<section>
				<h2>Locais onde esta agência opera</h2>
				<%
				if (locaisRelacionados != null && !locaisRelacionados.isEmpty()) {
				%>
				<div class="locais-lista">
					<%
					String disponibilidadeLocal;
					for (AgenciaLocal al : locaisRelacionados) {
						Local local = localController.getLocalById(al.getIdLocal());
						if (local != null) {
					%>
					<div class="local-card">
						<h3>
							<a href="local-detalhe.jsp?id=<%=local.getId()%>"><%=local.getNome()%></a>
						</h3>
						<p>
							<strong>Localidade:</strong>
							<%=local.getLocalidade()%></p>
						<p>
							<strong>Situação:</strong>
							<%
							if (local.getSituacao().toString().toLowerCase().replace("_", " ").equals("disponivel")) {
								disponibilidadeLocal = "Disponível";
							} else {
								disponibilidadeLocal = "Indisponível";
							}
							%>
							<%=disponibilidadeLocal%></p>
						<p>
							<strong>Servico oferecido:</strong>
							<%=al.getTipoAtividade()%></p>

					</div>
					<%
					} else {
					%>
					<p>
						Local com ID
						<%=al.getIdLocal()%>
						não encontrado.
					</p>
					<%
					}
					}
					%>
				</div>
				<%
				} else {
				%>
				<p>Esta agência não opera em nenhum local cadastrado.</p>
				<%
				}
				%>
			</section>

			<%
			} else {
			%>
			<h1>Agência não encontrada</h1>
			<p>Verifique se o ID está correto na URL.</p>
			<%
			}
			%>

			<section>
				<h2>Avaliações</h2>


				<%
				if (!flashMensagem.isEmpty()) {
				%>
				<div
					style="padding: 1rem; margin-bottom: 1rem; border-radius: 8px; background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb;">
					<%=flashMensagem%>
				</div>
				<%
				}
				%>
				<%
				if (!postMensagem.isEmpty()) {
				%>
				<div
					style="padding: 1rem; margin-bottom: 1rem; border-radius: 8px; background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb;">
					<%=postMensagem%>
				</div>
				<%
				}
				%>


				<form class="avaliacoes-form" method="post"
					action="agencia-detalhe.jsp?id=<%=agencia.getId()%>">
					<input type="hidden" name="id" value="<%=agencia.getId()%>">

					<div class="stars">
						<input type="radio" id="estrela5" name="estrela" value="5"
							required /><label for="estrela5">&#9733;</label> <input
							type="radio" id="estrela4" name="estrela" value="4" /><label
							for="estrela4">&#9733;</label> <input type="radio" id="estrela3"
							name="estrela" value="3" /><label for="estrela3">&#9733;</label>
						<input type="radio" id="estrela2" name="estrela" value="2" /><label
							for="estrela2">&#9733;</label> <input type="radio" id="estrela1"
							name="estrela" value="1" /><label for="estrela1">&#9733;</label>
					</div>
					<textarea name="avaliacao" placeholder="Digite sua avaliação..."
						required></textarea>
					<button type="submit">Enviar Avaliação</button>
				</form>

				<div class="avaliacoes-lista">

					<%
					if (avaliacoes != null && !avaliacoes.isEmpty()) {

						for (AvaliacaoAgencia av : avaliacoes) {

							Usuario user = userController.getUsuarioById(av.getUsuarioId());
							if (user != null) {
					%>


					<div class="avaliacao">
						<strong><%=user.getNome()%></strong> <span><%=av.getDataAvaliacao().format(formatter)%></span>
						<%
						int nota = av.getEscala();
						%>
						<%
						for (int i = 1; i <= 5; i++) {
						%>
						<%
						if (i <= nota) {
						%>
						<span style="color: gold;">&#9733;</span>
						<%
						} else {
						%>
						<span style="color: #ccc;">&#9733;</span>
						<%
						}
						%>
						<%
						}
						%>

						<p><%=av.getSugestao()%></p>
					</div>
					<%
					}
					}
					} else {
					%>
					<p>Nenhuma avaliação foi feita para essa agência no momento</p>
					<%
					}
					%>
				</div>

			</section>

		</main>

		<script src="static/js/footer.js"></script>
	</div>

	<script type="text/javascript"> document.addEventListener('DOMContentLoaded', () => {
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