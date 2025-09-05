<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ page import="models.Agencia, 
                 models.Local, 
                 models.AgenciaLocal, 
                 controllers.LocalController,
                 controllers.AgenciaLocalController,
                 java.util.List,
                 java.util.Set,
                 java.util.stream.Collectors" %>

<%-- ==================================================================================== --%>
<%-- PARTE 1: LÓGICA PARA PROCESSAR A AÇÃO DE VINCULAR --%>
<%-- ==================================================================================== --%>
<%
    // Pega a agência logada da sessão
    Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

    // Pega o parâmetro da URL que indica qual local deve ser vinculado
    String localParaVincularIdStr = request.getParameter("vincularLocalId");
    String mensagemSucesso = null;

    // Se o parâmetro existir e a agência estiver logada...
    if (localParaVincularIdStr != null && !localParaVincularIdStr.isEmpty() && agenciaLogada != null) {
        try {
            // Converte os IDs
            Long idLocal = Long.parseLong(localParaVincularIdStr);
            Long idAgencia = agenciaLogada.getId();

            // Cria o objeto de vínculo
            AgenciaLocal novoVinculo = new AgenciaLocal();
            novoVinculo.setIdAgencia(idAgencia);
            novoVinculo.setIdLocal(idLocal);

            // Usa o controller para salvar no banco
            AgenciaLocalController alc = new AgenciaLocalController();
            alc.adicionar(novoVinculo);

            // Define uma mensagem de sucesso para ser exibida
            // Usamos a sessão para que a mensagem persista após o redirect
            session.setAttribute("mensagemSucesso", "Vínculo com o local realizado com sucesso!");
            
            // REDIRECIONA para a mesma página SEM o parâmetro na URL.
            // Isso evita que o vínculo seja criado novamente se o usuário atualizar a página (Padrão Post-Redirect-Get)
            response.sendRedirect("vincular-local.jsp");
            return; // Impede o resto da página de ser processada nesta requisição

        } catch (NumberFormatException e) {
            // Tratar erro se o ID não for um número válido (opcional)
            System.err.println("ID de local inválido: " + localParaVincularIdStr);
        } catch (Exception e) {
            // Tratar outros possíveis erros de banco de dados (opcional)
            e.printStackTrace();
        }
    }

    // Pega a mensagem de sucesso da sessão (se houver) e depois a remove
    if (session.getAttribute("mensagemSucesso") != null) {
        mensagemSucesso = (String) session.getAttribute("mensagemSucesso");
        session.removeAttribute("mensagemSucesso");
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
    <link rel="stylesheet" href="static/css/painel-agencia-styles.css">
    
    <style>
        /* Estilos adicionais para feedback visual */
        .alert {
            padding: 15px;
            margin-bottom: 20px;
            border: 1px solid transparent;
            border-radius: 4px;
        }
        .alert-success {
            color: #155724;
            background-color: #d4edda;
            border-color: #c3e6cb;
        }
        .btn-vincular { background-color: #28a745; color: white; }
        .btn-vincular:hover { background-color: #218838; }
        .status-vinculado { color: #28a745; font-weight: bold; }
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
            
            <%-- ==================================================================================== --%>
            <%-- PARTE 2: EXIBIÇÃO DA MENSAGEM DE SUCESSO --%>
            <%-- ==================================================================================== --%>
            <% if (mensagemSucesso != null) { %>
                <div class="alert alert-success">
                    <%= mensagemSucesso %>
                </div>
            <% } %>

            <%
            LocalController lc = new LocalController();
            List<Local> todosLocais = lc.listaLocais();

            // Pega a lista de locais JÁ VINCULADOS a esta agência para saber o que mostrar na tabela
            AgenciaLocalController alc = new AgenciaLocalController();
            Set<Long> idsLocaisVinculados = null;
            if (agenciaLogada != null) {
                List<AgenciaLocal> vinculosExistentes = alc.getLocaisPorAgencia(agenciaLogada.getId());
                // Converte a lista para um Set de IDs para busca rápida (muito mais eficiente)
                idsLocaisVinculados = vinculosExistentes.stream()
                                                        .map(AgenciaLocal::getIdLocal) // Supondo que o método se chame getIdLocal()
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
                        <%-- PARTE 3: LÓGICA CONDICIONAL PARA MOSTRAR BOTÃO OU STATUS --%>
                        <%-- ==================================================================================== --%>
                        <% if (idsLocaisVinculados != null && idsLocaisVinculados.contains(l.getId())) { %>
                            <td data-label="Status"><span class="status-vinculado"><i class="fas fa-check-circle"></i> Vinculado</span></td>
                            <td data-label="Ação">
                                </td>
                        <% } else { %>
                            <td data-label="Status">Disponível</td>
                            <td data-label="Ação">
                                <a href="vincular-local.jsp?vincularLocalId=<%= l.getId() %>" class="btn btn-vincular">
                                    <i class="fas fa-link"></i> Vincular
                                a>
                            </td>
                        <% } %>
                    </tr>
                    <% } %>
                </tbody>
            </table>
            <% } else { %>
            <div class="no-data-message">
                <p>Nenhum local disponível para vínculo no momento.</p>
            </div>
            <% } %>

             <div style="margin-top: 20px;">
                <a href="cadastrar-local.jsp" class="btn btn-primario"> 
                    <i class="fas fa-plus"></i> Cadastrar um Novo Local
                </a>
            </div>
        </div>
    </div>
    <jsp:include page="components/chat.jsp" />
</body>
</html>