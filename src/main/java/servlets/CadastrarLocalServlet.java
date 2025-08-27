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

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

        if (agenciaLogada == null) {
            response.sendRedirect("login-agencia.jsp");
            return;
        } else {

        try {
            String nome = request.getParameter("nome");
            String localidade = request.getParameter("localidade");
            String descricao = request.getParameter("descricao");
            String tipoEmbarcacao = request.getParameter("tipoEmbarcacao");

            
            Integer anoAfundamento = null;
            try {
                String anoStr = request.getParameter("anoAfundamento");
                if (anoStr != null && !anoStr.isEmpty()) {
                    anoAfundamento = Integer.parseInt(anoStr);
                }
            } catch (NumberFormatException e) {
                anoAfundamento = null;
            }

            
            Double profundidade = null;
            try {
                String profStr = request.getParameter("profundidade");
                if (profStr != null && !profStr.isEmpty()) {
                    profundidade = Double.parseDouble(profStr);
                }
            } catch (NumberFormatException e) {
                profundidade = null;
            }

            
            Situacao situacao = null;
            try {
                String situacaoStr = request.getParameter("situacao");
                if (situacaoStr != null && !situacaoStr.isEmpty()) {
                    situacao = Situacao.valueOf(situacaoStr.toUpperCase());
                }
            } catch (IllegalArgumentException e) {
                situacao = null;
            }

            String latitude = request.getParameter("latitude");
            String longitude = request.getParameter("longitude");

           
            Local local = new Local();
            local.setNome(nome);
            local.setLocalidade(localidade);
            local.setDescricao(descricao);
            local.setTipoEmbarcacao(tipoEmbarcacao);
            local.setAnoAfundamento(anoAfundamento);
            local.setProfundidade(profundidade);
            local.setSituacao(situacao);
            local.setLatitude(latitude);
            local.setLongitude(longitude);

            
         
            LocalDao.insert(local);

            
            request.setAttribute("mensagemSucesso", "Local cadastrado com sucesso!"); 
            request.getRequestDispatcher("painel-agencia.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("painel-agencia.jsp");
        }
    }
    }
}




    



