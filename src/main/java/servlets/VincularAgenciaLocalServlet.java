package servlets;

import java.io.IOException;

import controllers.AgenciaLocalController;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Agencia;
import models.AgenciaLocal;

@WebServlet("/vincularAgenciaLocal")
public class VincularAgenciaLocalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

        // 1. VERIFICAÇÃO DE SEGURANÇA: Se não há agência logada, não faz nada e redireciona para o login.
        if (agenciaLogada == null) {
            response.sendRedirect("login-agencia.jsp"); // ou sua página de login
            return;
        }

        try {
            // 2. COLETA DOS DADOS
            // Pega o ID da agência da sessão (provavelmente é Long)
            // Supondo que o método se chama getId() e retorna Long
            Long idAgenciaLong = agenciaLogada.getId(); 

            // Pega os dados que vieram do formulário via POST
            String idLocalStr = request.getParameter("idLocal");
            String tipoAtividade = request.getParameter("tipoAtividade");

            // Validação simples para garantir que os dados não são nulos
            if (idLocalStr == null || idLocalStr.trim().isEmpty() || tipoAtividade == null || tipoAtividade.trim().isEmpty()) {
                session.setAttribute("mensagemErro", "Todos os campos são obrigatórios para criar o vínculo.");
                response.sendRedirect("sua-pagina-de-formulario.jsp"); // Redireciona de volta para o form
                return;
            }

            // 3. CONVERSÃO E PREPARAÇÃO DOS DADOS
            // Converte os IDs para o tipo int, que é o esperado pelo seu model AgenciaLocal
            int idLocal = Integer.parseInt(idLocalStr);
            int idAgencia = idAgenciaLong.intValue(); // Convertendo Long para int

            // 4. CRIAÇÃO DO VÍNCULO
            // Cria uma instância do model
            AgenciaLocal novoVinculo = new AgenciaLocal();
            novoVinculo.setIdAgencia(idAgencia);
            novoVinculo.setIdLocal(idLocal);
            novoVinculo.setTipoAtividade(tipoAtividade);

            // Usa o controller para salvar os dados
            AgenciaLocalController controller = new AgenciaLocalController();
            controller.adicionar(novoVinculo);

            // 5. FEEDBACK E REDIRECIONAMENTO
            // Coloca uma mensagem de sucesso na sessão para ser exibida na próxima página
            session.setAttribute("mensagemSucesso", "Vínculo com o local criado com sucesso!");
            
            // Redireciona o usuário para a página de locais vinculados ou painel
            response.sendRedirect("vincular-local.jsp"); // <-- MUDE AQUI para sua página de destino

        } catch (NumberFormatException e) {
            // Erro se o idLocal não for um número válido
            session.setAttribute("mensagemErro", "Ocorreu um erro: ID do local inválido.");
            response.sendRedirect("vincular-local.jsp"); // <-- MUDE AQUI
            e.printStackTrace();
        } catch (Exception e) {
            // Erro genérico para problemas no banco de dados, etc.
            session.setAttribute("mensagemErro", "Ocorreu um erro inesperado ao tentar criar o vínculo.");
            response.sendRedirect("vincular-local.jsp"); // <-- MUDE AQUI
            e.printStackTrace();
        }
    }
}