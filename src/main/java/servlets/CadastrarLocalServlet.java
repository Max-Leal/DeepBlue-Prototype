package servlets;

import java.io.IOException;

import Enums.Situacao;
import daos.LocalDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Agencia;
import models.Local;

@WebServlet("/CadastrarLocalServlet")
public class CadastrarLocalServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

        if (agenciaLogada == null) {
            response.sendRedirect("login-agencia.jsp");
            return;
        }

        long idAgencia = agenciaLogada.getId();

        
        String nome = request.getParameter("nome");
        String localidade = request.getParameter("localidade");
        String descricao = request.getParameter("descricao");
        String tipoEmbarcacao = request.getParameter("tipo_embarcacao");
        String anoStr = request.getParameter("ano_afundamento");
        String profundidadeStr = request.getParameter("profundidade");
        String situacao = request.getParameter("situacao");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");

        // Validação básica
        if(nome == null || nome.trim().isEmpty() ||
           localidade == null || localidade.trim().isEmpty() ||
           descricao == null || descricao.trim().isEmpty() ||
           anoStr == null || anoStr.trim().isEmpty() ||
           profundidadeStr == null || profundidadeStr.trim().isEmpty() ||
           situacao == null || situacao.trim().isEmpty() ||
           latitude == null || latitude.trim().isEmpty() ||
           longitude == null || longitude.trim().isEmpty()) {

            request.setAttribute("erro", "Preencha todos os campos necessários.");
            request.getRequestDispatcher("cadastrar-local.jsp").forward(request, response);
            return;
        }

        try {
            
            int anoAfundamento = Integer.parseInt(anoStr);
            double profundidade = Double.parseDouble(profundidadeStr);

            
            Local local = new Local();
            local.setNome(nome);
            local.setLocalidade(localidade);
            local.setDescricao(descricao);
            local.setTipoEmbarcacao(tipoEmbarcacao);
            local.setAnoAfundamento(anoAfundamento);
            local.setProfundidade(profundidade);
            local.setSituacao(Situacao.valueOf(situacao.toUpperCase()));
            local.setLatitude(latitude);
            local.setLongitude(longitude);

            
            LocalDao localDao = new LocalDao();
            int idLocal = localDao.inserirERetornarId(local);

          
            localDao.vincularAgenciaLocal((long)idLocal, idAgencia);

          
            response.sendRedirect("ListarLocaisServlet?msg=localCadastrado");

        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Ano de afundamento ou profundidade inválidos.");
            request.getRequestDispatcher("cadastrar-local.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("erro", "Erro ao cadastrar local: " + e.getMessage());
            request.getRequestDispatcher("cadastrar-local.jsp").forward(request, response);
        }
    }
}



    



