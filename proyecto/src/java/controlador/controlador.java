package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import proyecto.modelo.Modelo;

/**
 *
 * @author frank
 */
public class controlador extends HttpServlet {

    public controlador() {
        this.modelo = new Modelo();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet controlador</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet controlador at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try (PrintWriter out = response.getWriter()) {
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet serevicios</title>");
            out.println("</head>");
            out.println("<body>");

            String usr = request.getParameter("logUsuario");
            String pass = request.getParameter("logPass");

            if (modelo.revisarCredenciales(usr, pass)) {
                out.println("<p>");
                out.println(String.format("USER: %s\nPASS: %s\n", usr, pass));
                out.println("</p>");
            } else {

                out.println("<p>");
                out.println(String.format("USER: %s\nPASS: %s\n", "USUARIO NO ENCONTRADO", "***"));
                out.println("</p>");
            }
            out.println("</body>");
            out.println("</html>");
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private Modelo modelo;
}
