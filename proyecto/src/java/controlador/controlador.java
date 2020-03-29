package controlador;

import java.io.IOException;
import javax.servlet.RequestDispatcher;
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

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String usr = request.getParameter("logUsuario");
        String pass = request.getParameter("logPass");

        boolean verificacion = modelo.revisarCredenciales(usr, pass);

        if (verificacion) {

            switch (modelo.getUltimoRol()) {
                case "CLI":
                    request.getSession().setAttribute("usuario", modelo.getCliente());
                    request.getSession().setAttribute("rol",modelo.getUltimoRol());
                    break;
                case "CAJ":
                    request.getSession().setAttribute("cajero", modelo.getCliente());
                    request.getSession().setAttribute("rol",modelo.getUltimoRol());
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("/sesion.jsp");
            dispatcher.forward(request, response);

        } else {
            request.setAttribute("usuario", null);
            request.setAttribute("valid", "wrong");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
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
