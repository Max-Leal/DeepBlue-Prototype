<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="models.Agencia, 
                 models.Local, 
                 models.AgenciaLocal, 
                 controllers.LocalController,
                 controllers.AgenciaLocalController,
                 java.util.List,
                 java.util.Set,
                 java.util.stream.Collectors" %>

<%
    // Pega a agência logada da sessão
    Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

    // LÓGICA PARA EXIBIR MENSAGENS DE SUCESSO/ERRO VINDAS DO SERVLET
    String mensagemSucesso = null;
    if (session.getAttribute("mensagemSucesso") != null) {
        mensagemSucesso = (String) session.getAttribute("mensagemSucesso");
        session.removeAttribute("mensagemSucesso");
    }
    
    String mensagemErro = null;
    if (session.getAttribute("mensagemErro") != null) {
        mensagemErro = (String) session.getAttribute("mensagemErro");
        session.removeAttribute("mensagemErro");
    }
%>
<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <title>Vincular local - DeepBlue</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="static/css/painel-agencia-styles.css"> <style>
        .alert { padding: 15px; margin-bottom: 20px; border: 1px solid transparent; border-radius: 4px; }
        .alert-success { color: #155724; background-color: #d4edda; border-color: #c3e6cb; }
        .alert-danger { color: #721c24; background-color: #f8d7da; border-color: #f5c6cb; }
        .btn-vincular { background-color: #28a745; color: white; border: none; padding: 8px 12px; border-radius: 5px; cursor: pointer; }
        .btn-vincular:hover { background-color: #218838; }
        .status-vinculado { color: #28a745; font-weight: bold; }
        .form-group { margin-bottom: 1.5rem; }
        .form-group label { display: block; font-weight: 600; margin-bottom: 0.5rem; color: #01203a; }
        .input-padrao { width: 100%; padding: 0.75rem 1rem; border: 1px solid #d1d5db; border-radius: 8px; font-size: 1rem; }
    </style>
</head>
<body>
    <script>
        window.agenciaLogada = <%= agenciaLogada != null ? "\"" + agenciaLogada.getNomeEmpresarial() + "\"" : "null" %>;
        window.agenciaEmail = <%= agenciaLogada != null ? "\"" + agenciaLogada.getEmail() + "\"" : "null" %>;
    </script>
    <script src="static/js/header.js"></script>

    <div class="page-wrapper">
        <div class="table-container">
            <div class="table-header">
                <h2><i class="fas fa-map-marker-alt"></i> Vincular-se a um Local</h2>
            </div>
            
            <%-- Exibição de mensagens --%>
            <% if (mensagemSucesso != null) { %>
                <div class="alert alert-success"><%= mensagemSucesso %></div>
            <% } %>
            <% if (mensagemErro != null) { %>
                <div class="alert alert-danger"><%= mensagemErro %></div>
            <% } %>

            <%-- ==================================================================================== --%>
            <%-- PARTE 1: CAMPO PARA INSERIR O TIPO DE SERVIÇO --%>
            <%-- ==================================================================================== --%>
            <div class="form-group">
                <label for="tipoAtividadeInput">1. Informe o tipo de serviço oferecido neste local:</label>
                <input type="text" id="tipoAtividadeInput" name="tipoAtividade" class="input-padrao" 
                       placeholder="Ex: Mergulho com cilindro, Passeio de escuna, Pesca esportiva..." required>
            </div>

            <p style="font-weight: 600; color: #01203a; margin-bottom: 1rem;">2. Escolha um local para se vincular:</p>

            <%
            LocalController lc = new LocalController();
            List<Local> todosLocais = lc.listaLocais();

            AgenciaLocalController alc = new AgenciaLocalController();
            Set<Integer> idsLocaisVinculados = null; // MUDANÇA: Usando Integer para corresponder ao Model
            if (agenciaLogada != null) {
                // Supondo que getLocaisPorAgencia receba um Long
                List<AgenciaLocal> vinculosExistentes = alc.getLocaisPorAgencia(agenciaLogada.getId());
                idsLocaisVinculados = vinculosExistentes.stream()
                                                        .map(AgenciaLocal::getIdLocal) // Agora retorna int
                                                        .collect(Collectors.toSet());
            }

            if (todosLocais != null && !todosLocais.isEmpty()) {
            %>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Nome</th>
                        <th>Localidade</th>
                        <th>Embarcação</th>
                        <th>Profundidade</th>
                        <th>Status</th>
                        <th>Ação</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Local l : todosLocais) { %>
                    <tr>
                        <td data-label="Nome"><%= l.getNome() %></td>
                        <td data-label="Localidade"><%= l.getLocalidade() %></td>
                        <td data-label="Embarcação"><%= l.getTipoEmbarcacao() %> (<%= l.getAnoAfundamento() %>)</td>
                        <td data-label="Profundidade"><%= l.getProfundidade() %>m</td>
                        
                        <%-- ==================================================================================== --%>
                        <%-- PARTE 2: LÓGICA COM FORMULÁRIO EM CADA LINHA --%>
                        <%-- ==================================================================================== --%>
                        <% if (idsLocaisVinculados != null && idsLocaisVinculados.contains(l.getId().intValue())) { // MUDANÇA: convertendo Long para int na comparação %>
                            <td data-label="Status"><span class="status-vinculado"><i class="fas fa-check-circle"></i> Vinculado</span></td>
                            <td data-label="Ação">
                                </td>
                        <% } else { %>
                            <td data-label="Status">Disponível</td>
                            <td data-label="Ação">
                                <form action="${pageContext.request.contextPath}/vincularAgenciaLocal" method="post" class="form-vincular">
                                    <input type="hidden" name="idLocal" value="<%= l.getId() %>">
                                    
                                    <button type="submit" class="btn btn-vincular">
                                        <i class="fas fa-link"></i> Vincular
                                    </button>
                                </form>
                            </td>
                        <% } %>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
            <div class="no-data-message"><p>Nenhum local disponível para vínculo no momento.</p></div>
            <% } %>

             <div style="margin-top: 20px;">
                <a href="cadastrar-local.jsp" class="btn btn-primario"> 
                    <i class="fas fa-plus"></i> Cadastrar um Novo Local
                </a>
            </div>
        </div>
    </div>
    <jsp:include page="components/chat.jsp" />

    <%-- ==================================================================================== --%>
    <%-- PARTE 3: JAVASCRIPT PARA UNIR OS DADOS --%>
    <%-- ==================================================================================== --%>
    <script>
        // Pega todos os formulários de vínculo da página
        const vincularForms = document.querySelectorAll('.form-vincular');
        
        // Pega o campo de texto principal onde o serviço é digitado
        const tipoAtividadeInput = document.getElementById('tipoAtividadeInput');

        // Adiciona um 'escutador' para o evento de submit em CADA formulário
        vincularForms.forEach(form => {
            form.addEventListener('submit', function(event) {
                // 1. Impede o envio imediato do formulário
                event.preventDefault();

                // 2. Pega o texto do campo de serviço e remove espaços em branco
                const atividade = tipoAtividadeInput.value.trim();

                // 3. Validação: Verifica se o campo de serviço foi preenchido
                if (atividade === '') {
                    alert('Por favor, preencha o tipo de serviço antes de se vincular a um local.');
                    tipoAtividadeInput.focus(); // Coloca o cursor no campo para facilitar
                    return; // Para a execução
                }

                // 4. Cria um novo campo <input> oculto dinamicamente
                const hiddenInput = document.createElement('input');
                hiddenInput.type = 'hidden';
                hiddenInput.name = 'tipoAtividade'; // O 'name' deve ser o mesmo que o Servlet espera
                hiddenInput.value = atividade;

                // 5. Adiciona o novo campo oculto ao formulário que foi clicado
                this.appendChild(hiddenInput);

                // 6. Agora, envia o formulário com os dois dados (idLocal e tipoAtividade)
                this.submit();
            });
        });
    </script>
</body>
</html>