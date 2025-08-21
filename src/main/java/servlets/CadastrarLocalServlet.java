package servlets;

import java.io.IOException;

import Enums.Situacao;
import daos.LocalDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Local;

@WebServlet("/CadastrarLocalServlet")
public class CadastrarLocalServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

     
        String nome = request.getParameter("nome");
        String localidade = request.getParameter("localidade");
        String descricao = request.getParameter("descricao");
        String tipoEmbarcacao = request.getParameter("tipo_embarcacao");
        String anoStr = request.getParameter("ano_afundamento");
        String profundidadeStr = request.getParameter("profundidade");
        String situacao = request.getParameter("situacao");
        String latitude = request.getParameter("latitude");
        String longitude = request.getParameter("longitude");

      
        if(nome == null || nome.trim().isEmpty() ||
           localidade == null || localidade.trim().isEmpty() ||
           descricao == null || descricao.trim().isEmpty() ||
           tipoEmbarcacao == null || tipoEmbarcacao.trim().isEmpty() ||
           anoStr == null || anoStr.trim().isEmpty() ||
           profundidadeStr == null || profundidadeStr.trim().isEmpty() ||
           situacao == null || situacao.trim().isEmpty() ||
           latitude == null || latitude.trim().isEmpty() ||
           longitude == null || longitude.trim().isEmpty()) {

            request.setAttribute("erro", "Todos os campos são obrigatórios.");
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

           
            LocalDao.insert(local);
            
            response.sendRedirect("painel-agencia.jsp");

            request.setAttribute("mensagemSucesso", "Local cadastrado com sucesso!");
        } catch (NumberFormatException e) {
            request.setAttribute("erro", "Ano ou profundidade inválidos. Digite apenas números.");
        } catch (Exception e) {
            request.setAttribute("erro", "Erro ao cadastrar local: " + e.getMessage());
        }

        
        request.getRequestDispatcher("cadastrar-local.jsp").forward(request, response);
    }
}


