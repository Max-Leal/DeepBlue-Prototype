package servlets;

import java.io.IOException;

import daos.AgenciaDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Agencia;

@WebServlet("/login-agencia")
public class LoginAgenciaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        AgenciaDao agenciaDAO = new AgenciaDao();
        Agencia agencia = agenciaDAO.autenticar(email, senha);

        if (agencia != null) {
            HttpSession session = request.getSession();
            session.setAttribute("agenciaLogada", agencia);
            session.setAttribute("tipo", "agencia");

            // redireciona para o servlet de listagem
            response.sendRedirect(request.getContextPath() + "/ListarLocaisServlet");
        } else {
            request.setAttribute("erroLogin", "E-mail ou senha inválidos.");
            request.getRequestDispatcher("login-agencia.jsp").forward(request, response);
        }
    }
}
