package servlets;

import java.io.IOException;

import daos.UsuarioDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Usuario;

@WebServlet("/login-usuario")
public class LoginUsuarioServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String senha = request.getParameter("senha");

        UsuarioDao usuarioDAO = new UsuarioDao();
        Usuario usuario = usuarioDAO.autenticar(email, senha);

        if (usuario != null) {
            HttpSession session = request.getSession();
            session.setAttribute("usuarioLogado", usuario);
            session.setAttribute("tipo", "usuario");
            response.sendRedirect("home.jsp");
        } else {
            request.setAttribute("erroLogin", "E-mail ou senha inválidos.");
            request.getRequestDispatcher("login-usuario.jsp").forward(request, response);
        }
    }
}
