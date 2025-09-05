package servlets;
import java.io.IOException;

import Enums.Situacao;
import daos.AgenciaDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Agencia;

@WebServlet("/EditarAgenciaServlet")
public class EditarAgenciaServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        Long id = Long.parseLong(request.getParameter("id"));
        String nome = request.getParameter("nomeEmpresarial");
        String cnpj = request.getParameter("cnpj");
        String email = request.getParameter("email");
        String senha = request.getParameter("senha");
        Situacao situacao = Situacao.valueOf(request.getParameter("situacao").toUpperCase());
        String descricao = request.getParameter("descricao");
        String cep = request.getParameter("cep");
        String telefone = request.getParameter("telefone");
        String whatsapp = request.getParameter("whatsapp");
        String instagram = request.getParameter("instagram");

        
        Agencia agenciaAlterada = new Agencia();
        agenciaAlterada.setId(id);
        agenciaAlterada.setNomeEmpresarial(nome);
        agenciaAlterada.setCnpj(cnpj);
        agenciaAlterada.setEmail(email);
        agenciaAlterada.setSenhaHash(senha);
        agenciaAlterada.setSituacao(situacao);
        agenciaAlterada.setDescricao(descricao);
        agenciaAlterada.setCep(cep);
        agenciaAlterada.setTelefone(telefone);
        agenciaAlterada.setWhatsapp(whatsapp);
        agenciaAlterada.setInstagram(instagram);

        
        AgenciaDao.update(id, agenciaAlterada);

       
        HttpSession sessao = request.getSession();
        sessao.setAttribute("agenciaLogada", agenciaAlterada);

        
        response.sendRedirect("painel-agencia.jsp");
    }
}

