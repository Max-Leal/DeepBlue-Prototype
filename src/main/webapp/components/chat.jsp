<%@ page import="models.Agencia, models.Usuario, models.Mensagem, Enums.TipoUsuario"%>
<%@ page
	import="controllers.AgenciaController, controllers.UsuarioController, controllers.MensagemController"%>
<%@ page import="java.util.List, java.util.ArrayList"%>
	
<%
Usuario usuarioLogado = (Usuario) session.getAttribute("usuarioLogado");
Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

Long idRemetente;
TipoUsuario tipoRemetente;
if (usuarioLogado == null) {
	idRemetente = agenciaLogada.getId();
	tipoRemetente = TipoUsuario.agencia;
} else {
	idRemetente = agenciaLogada.getId();
	tipoRemetente = TipoUsuario.usuario;
}


MensagemController mc = new MensagemController();

List<Mensagem> mensagens = mc.buscarConversas(idRemetente, tipoRemetente);
List<Mensagem> contatosAdicionados = new ArrayList<>();

%>
<div id="chat-widget">
	<div id="chat-header" onclick="toggleChat()">Mensagens</div>
	<div id="chat-contacts">
	<%
	for (Mensagem m : mensagens) {
		Mensagem contato = new Mensagem();
		contato.setDestinatarioId(m.getDestinatarioId());
		contato.setDestinatarioTipo(m.getDestinatarioTipo());
		
		if (!contatosAdicionados.contains(contato)) {%>
			<div id="contact">
			<span class="name-contact"><%=m.getRemetenteId() %></span> <!-- parei aqui -->
			</div>
			
			<%contatosAdicionados.add(contato);
		}


	}
	%>
	
	
	</div>
	<!--<div id="chat-body">
        
        <div id="chat-messages">
        </div><input type="text" id="chat-input" placeholder="Digite sua mensagem..." onkeypress="if(event.key==='Enter') sendMessage()"> 
    </div>  -->
</div>

<style>
#chat-widget {
	position: fixed;
	bottom: 10px;
	right: 20px;
	width: 300px;
	font-family: Arial, sans-serif;
}

#chat-header {
	background: #007bff;
	color: white;
	padding: 8px;
	cursor: pointer;
	border-radius: 8px 8px 0 0;
	text-align: center;
}

#chat-body {
	display: none;
	background: white;
	border: 1px solid #ccc;
	border-top: none;
	height: 300px;
	display: flex;
	flex-direction: column;
}

#chat-messages {
	flex: 1;
	padding: 8px;
	overflow-y: auto;
	font-size: 14px;
}

#chat-input {
	border: none;
	padding: 8px;
	border-top: 1px solid #ccc;
}
</style>

<script>
	function toggleChat() {
		const body = document.getElementById("chat-body");
		body.style.display = body.style.display === "none" ? "flex" : "none";
	}

	function sendMessage() {
		const input = document.getElementById("chat-input");
		const msg = input.value.trim();
		if (msg) {
			document.getElementById("chat-messages").innerHTML += `<div><b>Você:</b> ${msg}</div>`;
			input.value = "";
			// Aqui você pode fazer um fetch POST para enviar a mensagem pro servidor
		}
	}
</script>
