<%@ page
	import="models.Agencia, models.Usuario, models.Mensagem, Enums.TipoUsuario"%>
<%@ page
	import="controllers.AgenciaController, controllers.UsuarioController, controllers.MensagemController"%>
<%@ page
	import="java.util.List, java.util.Set, java.util.HashSet, java.util.Map, java.util.HashMap, java.util.ArrayList"%>
<%@ page import="java.time.LocalDateTime"%>
<%@ page import="java.time.format.DateTimeFormatter"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.GsonBuilder"%>
<%@ page import="utils.LocalDateTimeAdapter"%>

<%
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

Long idUsuarioLogado = null;
TipoUsuario tipoUsuarioLogado = null;
boolean logado = false;

if (usuarioLogado == null) {
	if (agenciaLogada != null) {
		idUsuarioLogado = agenciaLogada.getId();
		tipoUsuarioLogado = TipoUsuario.agencia;
		logado = true;
	}
} else {
	idUsuarioLogado = usuarioLogado.getId();
	tipoUsuarioLogado = TipoUsuario.usuario;
	logado = true;
}

if (logado) {
	MensagemController mc = new MensagemController();
	UsuarioController uc = new UsuarioController();
	AgenciaController ac = new AgenciaController();

	List<Mensagem> ultimasMensagens = mc.buscarConversas(idUsuarioLogado, tipoUsuarioLogado);
	List<Mensagem> todasAsMensagens = mc.buscarTodasAsMensagensDoUsuario(idUsuarioLogado, tipoUsuarioLogado);
	Map<String, List<Mensagem>> conversasMap = new HashMap<>();

	for (Mensagem msg : todasAsMensagens) {
		String chaveConversa;
		// A lógica aqui para agrupar mensagens está correta, não precisa mudar.
		if (!msg.getRemetenteId().equals(idUsuarioLogado) || !msg.getRemetenteTipo().equals(tipoUsuarioLogado)) {
			chaveConversa = msg.getRemetenteTipo().toString() + "-" + msg.getRemetenteId().toString();
		} else {
			chaveConversa = msg.getDestinatarioTipo().toString() + "-" + msg.getDestinatarioId().toString();
		}
		conversasMap.computeIfAbsent(chaveConversa, k -> new ArrayList<>()).add(msg);
	}

	Gson gson = new GsonBuilder().registerTypeAdapter(LocalDateTime.class, new LocalDateTimeAdapter()).create();
	String conversasJson = gson.toJson(conversasMap);
	Set<String> conversasProcessadas = new HashSet<>();
%>
<div id="chat-widget">
	<div id="chat-header" onclick="toggleContacts()">Mensagens</div>
	<div id="chat-contacts">
		<%
		for (Mensagem m : ultimasMensagens) {
			
			// ===========================================================================
			// AQUI ESTÁ A CORREÇÃO PRINCIPAL
			// ===========================================================================
			Long idContato = null;
			TipoUsuario tipoContato = null;

			// CONDIÇÃO CORRIGIDA: Verifica se o remetente da mensagem é EXATAMENTE o usuário logado (mesmo ID E mesmo TIPO)
			if (m.getRemetenteId().equals(idUsuarioLogado) && m.getRemetenteTipo().equals(tipoUsuarioLogado)) {
			    // Se fui eu que enviei a última mensagem, o contato é o destinatário
			    idContato = m.getDestinatarioId();
			    tipoContato = m.getDestinatarioTipo();
			} else {
			    // Se a última mensagem foi recebida, o contato é o remetente
			    idContato = m.getRemetenteId();
			    tipoContato = m.getRemetenteTipo();
			}
			// ===========================================================================
			// FIM DA CORREÇÃO
			// ===========================================================================

			String chaveConversa = tipoContato.toString() + "-" + idContato.toString();

			if (!conversasProcessadas.contains(chaveConversa)) {
				String nomeContato = "Contato desconhecido";
				if (tipoContato.equals(TipoUsuario.usuario)) {
					Usuario usuario = uc.getUsuarioById(idContato);
					if (usuario != null)
						nomeContato = usuario.getNome();
				} else if (tipoContato.equals(TipoUsuario.agencia)) {
					Agencia agencia = ac.getAgenciaById(idContato.intValue());
					if (agencia != null)
						nomeContato = agencia.getNomeEmpresarial();
				}
		%>
		<div class="contact"
			onclick="abrirChat('<%=chaveConversa%>', '<%=nomeContato%>')"
			data-chave="<%=chaveConversa%>" data-nome="<%=nomeContato%>">
			<span class="name-contact"><%=nomeContato%></span> <span
				class="time-contact"><%=m.getDataEnvio().format(formatter)%></span>
		</div>
		<%
		conversasProcessadas.add(chaveConversa);
		}
		}
		%>
	</div>

	<div id="chat-body">
		<div id="chat-body-header">
			<span id="chat-contact-name"></span> <span id="close-chat"
				onclick="toggleChat()">X</span>
		</div>
		<div id="chat-messages"></div>
		<div id="chat-input-container">
			<input type="text" id="chat-input"
				placeholder="Digite sua mensagem..."
				onkeypress="if(event.key==='Enter') sendMessage()">
		</div>
	</div>
</div>

<style>
/* SEU CSS AQUI (sem alterações) */
#chat-widget {
	position: fixed;
	bottom: 10px;
	right: 20px;
	width: 320px;
	font-family: Arial, sans-serif;
	border-radius: 8px;
	box-shadow: 0 4px 12px rgba(0, 0, 0, 0.15);
	overflow: hidden;
}
#chat-header {
	background: #007bff;
	color: white;
	padding: 12px;
	cursor: pointer;
	text-align: center;
	font-weight: bold;
}
#chat-contacts {
	background-color: white;
	max-height: 400px;
	overflow-y: auto;
}
.contact {
	padding: 12px;
	border-bottom: 1px solid #f0f0f0;
	cursor: pointer;
	display: flex;
	justify-content: space-between;
	align-items: center;
}
.contact:hover {
	background-color: #f9f9f9;
}
.name-contact {
	font-weight: bold;
	color: #333;
}
.time-contact {
	font-size: 0.75em;
	color: #999;
}
#chat-body {
	display: none;
	height: 400px;
	background: white;
	flex-direction: column;
}
#chat-body-header {
	background: #f1f1f1;
	padding: 10px;
	font-weight: bold;
	display: flex;
	justify-content: space-between;
	align-items: center;
	border-bottom: 1px solid #ddd;
}
#close-chat {
	cursor: pointer;
	padding: 0 5px;
	font-size: 1.2em;
	color: #888;
}
#chat-messages {
	flex: 1;
	padding: 10px;
	overflow-y: auto;
	font-size: 14px;
	background-color: #f9f9f9;
	display: flex;
	flex-direction: column;
}
.message {
	padding: 8px 12px;
	border-radius: 18px;
	margin-bottom: 8px;
	max-width: 75%;
	line-height: 1.4;
}
.sent {
	background-color: #007bff;
	color: white;
	align-self: flex-end;
	border-bottom-right-radius: 4px;
}
.received {
	background-color: #e9e9eb;
	color: black;
	align-self: flex-start;
	border-bottom-left-radius: 4px;
}
#chat-input-container {
	border-top: 1px solid #ccc;
}
#chat-input {
	border: none;
	padding: 12px;
	width: 100%;
	box-sizing: border-box;
}
#chat-input:focus {
	outline: none;
}
</style>

<script>
	// SEU JAVASCRIPT AQUI (sem alterações, a correção anterior já está aqui)
	let chaveConversaAtiva = null;
	const idUsuarioLogadoJS = <%=idUsuarioLogado%>;
	const tipoUsuarioLogadoJS = '<%= tipoUsuarioLogado.toString() %>';
	const todasAsConversas = JSON.parse('<%=conversasJson.replace("'", "\\'")%>');
	
	const contactsList = document.getElementById("chat-contacts");
	const chatBody = document.getElementById("chat-body");

	function toggleContacts() {
		contactsList.style.display = contactsList.style.display === "none" ? "block" : "none";
	}

	function toggleChat() {
		chatBody.style.display = chatBody.style.display === "none" ? "flex" : "none";
		contactsList.style.display = 'block'; 
	}

	function abrirChat(chave, nome) {
	    chaveConversaAtiva = chave;
	    const contactsList = document.getElementById("chat-contacts");
	    const chatBody = document.getElementById("chat-body");
	    contactsList.style.display = 'none';
	    chatBody.style.display = 'flex';
	    document.getElementById('chat-contact-name').innerText = nome;
	    const messagesContainer = document.getElementById('chat-messages');
	    messagesContainer.innerHTML = ''; 
	    const mensagens = todasAsConversas[chave] || [];
	    
	    mensagens.forEach(msg => {
	        const messageDiv = document.createElement('div');
	        messageDiv.classList.add('message');
	        if (msg.remetenteId === idUsuarioLogadoJS && msg.remetenteTipo === tipoUsuarioLogadoJS) {
	            messageDiv.classList.add('sent');
	        } else {
	            messageDiv.classList.add('received');
	        }
	        messageDiv.innerText = msg.conteudo;
	        messagesContainer.appendChild(messageDiv);
	    });
	    
	    messagesContainer.scrollTop = messagesContainer.scrollHeight;
	}

	async function sendMessage() {
		const input = document.getElementById("chat-input");
		const conteudoMensagem = input.value.trim();
		if (!conteudoMensagem || !chaveConversaAtiva) {
			return; 
		}
		const dadosMensagem = {
			conteudo: conteudoMensagem,
			chaveDestinatario: chaveConversaAtiva 
		};
		input.value = "";
		try {
			const response = await fetch('components/enviarMensagem.jsp', {
				method: 'POST',
				headers: {
					'Content-Type': 'application/json',
				},
				body: JSON.stringify(dadosMensagem)
			});
			if (!response.ok) {
				throw new Error('Falha ao enviar mensagem. Status: ' + response.status);
			}
			const mensagemSalva = await response.json();
			const messagesContainer = document.getElementById("chat-messages");
			const messageDiv = document.createElement('div');
			messageDiv.classList.add('message', 'sent');
			messageDiv.innerText = mensagemSalva.conteudo;
			messagesContainer.appendChild(messageDiv);
			messagesContainer.scrollTop = messagesContainer.scrollHeight;
		} catch (error) {
			console.error('Erro ao enviar mensagem:', error);
		}
	}
	
	function iniciarChatComAgencia(botaoElemento) {
	    const chave = botaoElemento.dataset.chave;
	    const nome = botaoElemento.dataset.nome;
	    abrirChat(chave, nome);
	}
</script>
<%
}
%>