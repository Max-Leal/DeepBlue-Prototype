package servlets;

import java.io.IOException;

import daos.AgenciaDao;
import daos.UsuarioDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Agencia;
import models.Usuario;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        UsuarioDao usuarioDAO = new UsuarioDao();
        AgenciaDao agenciaDAO = new AgenciaDao();

        Usuario usuario = usuarioDAO.autenticar(email, senha);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", usuario);
            session.setAttribute("tipo", "usuario");
            response.sendRedirect("home.jsp");
            return;
        }

        Agencia agencia = agenciaDAO.autenticar(email, senha);

        if (agencia != null) {
            HttpSession session = request.getSession();
            session.setAttribute("agenciaLogada", agencia);
            session.setAttribute("tipo", "agencia");
            response.sendRedirect("painel-agencia.jsp");
            return;
        }

        // Se não for nenhum dos dois
        request.setAttribute("erroLogin", "E-mail ou senha inválidos.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }
}
