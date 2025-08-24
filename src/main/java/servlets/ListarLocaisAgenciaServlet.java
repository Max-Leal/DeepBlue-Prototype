package servlets;

import java.io.IOException;
import java.util.List;

import daos.LocalDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import models.Agencia;
import models.Local;

@WebServlet("/ListarLocaisServlet")
public class ListarLocaisAgenciaServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Agencia agenciaLogada = (Agencia) session.getAttribute("agenciaLogada");

        if (agenciaLogada == null) {
            response.sendRedirect("login-agencia.jsp");
            return;
        }

        Long idAgencia = agenciaLogada.getId();

        LocalDao localDao = new LocalDao();
        List<Local> locais = localDao.listarPorAgencia(idAgencia);

        request.setAttribute("locais", locais);
        request.getRequestDispatcher("painel-agencia.jsp").forward(request, response);
    }
}

