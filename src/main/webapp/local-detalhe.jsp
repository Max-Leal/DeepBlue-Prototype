<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="models.Local, controllers.LocalController"%>
<%@ page
	import="models.AgenciaLocal, controllers.AgenciaLocalController"%>
<%@ page
	import="models.AvaliacaoLocal, controllers.AvaliacaoLocalController"%>
<%@ page import="controllers.AgenciaController"%>
<%@ page
	import="models.Agencia, models.Usuario, controllers.UsuarioController"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy HH:mm");

//----- LÓGICA DE MENSAGENS E PROCESSAMENTO DO FORMULÁRIO -----

String postMensagem = ""; // Mensagem de erro específica do POST
String flashMensagem = ""; // Mensagem de sucesso/status vinda do redirect

//1. Verifica por mensagens "flash" da sessão (após um redirect)
if (session.getAttribute("flashMensagem") != null) {
	flashMensagem = (String) session.getAttribute("flashMensagem");
	session.removeAttribute("flashMensagem"); // Limpa para não mostrar de novo
}

//2. Processa o formulário de avaliação (POST)
if ("POST".equalsIgnoreCase(request.getMethod())) {
	try {
		int escala = Integer.parseInt(request.getParameter("estrela"));
		String sugestao = request.getParameter("avaliacao");
		String localIdParam = request.getParameter("id");

		Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");

		if (usuarioLogado == null) {
	postMensagem = "Você precisa estar logado como usuário para avaliar.";
		} else if (sugestao == null || sugestao.trim().isEmpty()) {
	postMensagem = "Por favor, escreva uma sugestão.";
		} else if (localIdParam == null || localIdParam.trim().isEmpty()) {
	postMensagem = "ID do local inválido.";
		} else {
	Long localId = Long.parseLong(localIdParam);

	AvaliacaoLocal avaliacao = new AvaliacaoLocal();
	avaliacao.setEscala(escala);
	avaliacao.setTexto(sugestao);
	avaliacao.setIdUsuario(usuarioLogado.getId());
	avaliacao.setIdLocal(localId);

	AvaliacaoLocalController avController = new AvaliacaoLocalController();
	avController.adicionarAvaliacao(avaliacao);

	session.setAttribute("flashMensagem", "Avaliação enviada com sucesso!");
	response.sendRedirect("local-detalhe.jsp?id=" + localId); // redireciona para a mesma página
	return;
		}

	} catch (Exception e) {
		// Em caso de erro, a página será recarregada mostrando a mensagem de erro
		postMensagem = "Erro ao enviar avaliação: " + e.getMessage();
	}
}

List<AgenciaLocal> relacoes = new ArrayList<>();
Local local = null;

String idParam = request.getParameter("id");
if (idParam != null) {
	try {
		int id = Integer.parseInt(idParam);

		LocalController localController = new LocalController();
		local = localController.getLocalById(id);

		AgenciaLocalController agenciaLocalController = new AgenciaLocalController();
		relacoes = agenciaLocalController.getAgenciasPorLocal(id);

	} catch (NumberFormatException e) {
		out.println("<p>ID inválido!</p>");
	}

} else {
	out.println("<p>ID não fornecido!</p>");
}

double escalaLocal = 0;
List<AvaliacaoLocal> avaliacoes = new ArrayList<>();

if (local != null) {
	AvaliacaoLocalController avController = new AvaliacaoLocalController();
	avaliacoes = avController.getAvaliacoesPorLocal(local.getId());

	for (AvaliacaoLocal av : avaliacoes) {
		escalaLocal += av.getEscala();
	}

	if (!avaliacoes.isEmpty()) {
		escalaLocal = escalaLocal / avaliacoes.size();
	}
}

AgenciaController agenciaController = new AgenciaController();
%>

<!DOCTYPE html>
<html lang="pt-br">
<head>
<meta charset="UTF-8">
<title><%=(local != null) ? local.getNome() : "Local não encontrado"%></title>

<!-- Estilos principais -->
<link rel="stylesheet" href="static/css/main-styles.css">

<!-- Ícones FontAwesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">

<!-- Mapa Leaflet -->
<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />

<style>
section {
	margin-top: 2rem;
	margin-bottom: 2rem;
}

#mapa {
	width: 100%;
	height: 400px;
	border-radius: 20px;
	margin-top: 2rem;
	box-shadow: 0 10px 25px rgba(0, 0, 0, 0.1);
}

.detalhes-container {
	margin-top: 120px;
	padding: 3rem 2rem;
	max-width: 1000px;
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

/* Estilo para os cards de agência */
.agencias-lista {
	display: flex;
	flex-wrap: wrap;
	gap: 1.5rem;
	margin-top: 1rem;
}

.agencia-card {
	background: white;
	border-radius: 12px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
	padding: 1.5rem;
	width: calc(50% - 1.5rem);
	box-sizing: border-box;
	transition: box-shadow 0.3s ease;
}

.agencia-card:hover {
	box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
}

.agencia-nome {
	font-size: 1.3rem;
	font-weight: 700;
	color: var(--azul-escuro);
	margin-bottom: 0.5rem;
}

.agencia-info {
	font-size: 1rem;
	color: var(--cinza-medio);
	margin-bottom: 0.3rem;
}

.agencia-link {
	margin-top: 1rem;
	display: inline-block;
	background: var(--azul-escuro);
	color: white;
	padding: 0.4rem 1rem;
	border-radius: 6px;
	text-decoration: none;
	font-weight: 600;
	transition: background-color 0.2s ease;
}

.agencia-link:hover {
	background: var(--azul-claro);
	color: #222;
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
	.agencia-card {
		width: 100%;
	}
}
</style>
</head>
<body>

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
		if (local != null) {
		%>
		<h1><%=local.getNome()%></h1>
		<h3>
			<%
			for (int i = 1; i <= 5; i++) {
			%>
			<%
			if (i <= escalaLocal) {
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
			<strong>Localidade:</strong>
			<%=local.getLocalidade()%></p>
		<p>
			<strong>Descrição:</strong>
			<%=local.getDescricao()%></p>
		<p>
			<strong>Situação:</strong>
			
			<%
			String situacaoLocal;
			if (local.getSituacao().toString().toLowerCase().replace("_", " ").equals("disponivel")) {
					situacaoLocal = "Disponível";
				} else {
					situacaoLocal = "Indisponível";
				}
			%>
			<%=situacaoLocal%></p>

		<!-- Listar agências relacionadas -->
		<section>
			<h2>Agências que operam neste local</h2>
			<%
			if (relacoes != null && !relacoes.isEmpty()) {
			%>
			<div class="agencias-lista">
				<%
				for (AgenciaLocal relacao : relacoes) {
					Agencia agencia = agenciaController.getAgenciaById(relacao.getIdAgencia());
					if (agencia != null) {
				%>
				<div class="agencia-card">
					<div class="agencia-nome"><%=agencia.getNomeEmpresarial()%></div>
					<div class="agencia-info">
						<strong>Email:</strong>
						<%=agencia.getEmail()%></div>
					<div class="agencia-info">
						<strong>Serviço oferecido:</strong>
						<%=relacao.getTipoAtividade()%></div>
					<a class="agencia-link"
						href="agencia-detalhe.jsp?id=<%=agencia.getId()%>">Ver
						Detalhes</a>
				</div>
				<%
				} else {
				%>
				<div class="agencia-card">
					<p>
						Agência com ID
						<%=relacao.getIdAgencia()%>
						não encontrada.
					</p>
				</div>
				<%
				}
				}
				%>
			</div>
			<%
			} else {
			%>
			<p>Nenhuma agência cadastrada para este local.</p>
			<%
			}
			%>
		</section>

		<!-- Mapa Leaflet -->
		<div id="mapa"></div>

		<section>
			<h2>Avaliar este Local</h2>

			<%
			if (!flashMensagem.isEmpty()) {
			%>
			<div
				style="background-color: #d4edda; color: #155724; border: 1px solid #c3e6cb; padding: 1rem; margin-bottom: 1rem; border-radius: 8px;">
				<%=flashMensagem%>
			</div>
			<%
			}
			%>

			<%
			if (!postMensagem.isEmpty()) {
			%>
			<div
				style="background-color: #f8d7da; color: #721c24; border: 1px solid #f5c6cb; padding: 1rem; margin-bottom: 1rem; border-radius: 8px;">
				<%=postMensagem%>
			</div>
			<%
			}
			%>

			<form class="avaliacoes-form" method="post"
				action="local-detalhe.jsp?id=<%=local.getId()%>">
				<input type="hidden" name="id" value="<%=local.getId()%>">

				<div class="stars">
					<input type="radio" id="estrela5" name="estrela" value="5" required /><label
						for="estrela5">&#9733;</label> <input type="radio" id="estrela4"
						name="estrela" value="4" /><label for="estrela4">&#9733;</label>
					<input type="radio" id="estrela3" name="estrela" value="3" /><label
						for="estrela3">&#9733;</label> <input type="radio" id="estrela2"
						name="estrela" value="2" /><label for="estrela2">&#9733;</label>
					<input type="radio" id="estrela1" name="estrela" value="1" /><label
						for="estrela1">&#9733;</label>
				</div>

				<textarea name="avaliacao" placeholder="Digite sua avaliação..."
					required></textarea>
				<button type="submit">Enviar Avaliação</button>
			</form>
		</section>
		<section>
			<h2>Avaliações dos Usuários</h2>

			<div class="avaliacoes-lista">
				<%
				if (avaliacoes != null && !avaliacoes.isEmpty()) {
					UsuarioController userController = new UsuarioController();
					for (AvaliacaoLocal av : avaliacoes) {
						Usuario user = userController.getUsuarioById(av.getIdUsuario());
						if (user != null) {
				%>
				<div class="avaliacao">
					<strong><%=user.getNome()%></strong> <span><%=av.getDataComentario().format(formatter)%></span>

					<%
					for (int i = 1; i <= 5; i++) {
					%>
					<%
					if (i <= av.getEscala()) {
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

					<p><%=av.getTexto()%></p>
				</div>
				<%
				}
				}
				} else {
				%>
				<p>Nenhuma avaliação foi feita para este local até o momento.</p>
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

        const lat = parseFloat("<%=local.getLatitude()%>");
        const lng = parseFloat("<%=local.getLongitude()%>");
        const map = L.map('mapa').setView([lat, lng], 13);

        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            maxZoom: 18
        }).addTo(map);

        L.marker([lat, lng])
            .addTo(map)
            .bindPopup("<%=local.getNome()%>")
            .openPopup();
    </script>

		<%
		} else {
		%>
		<h1>Local não encontrado</h1>
		<p>Verifique se o ID está correto na URL.</p>
		<%
		}
		%>
	</main>

	<footer class="footer"> &copy; 2025 DeepBlue. Todos os
		direitos reservados. </footer>

</body>
</html>
