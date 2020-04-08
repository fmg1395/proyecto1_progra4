package controlador;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import proyecto.gestionBD.DAO;
import proyecto.modelo.Cuenta;
import proyecto.modelo.Modelo;
import proyecto.modelo.Moneda;
import proyecto.modelo.Usuario;

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

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String btnCuentaA = (String) request.getParameter("btnCuentaA");
        String btnVincular = (String) request.getParameter("btnVincular");
        String btnLogIn = (String) request.getParameter("btnLogIn");
        String btnCuenta = (String) request.getParameter("btnCuenta");
        String btnDepositar = (String) request.getParameter("btnDepositar");
        String btnCrearUsuario = (String) request.getParameter("crearUsuario");
        String btnCuentaRetiro = (String) request.getParameter("btnCuentaRetiro");
        String btnLogOut = (String) request.getParameter("btnLogOut");
        if (btnLogIn != null) {
            logIn(request, response);
        } else if (btnLogOut != null) {
            logOut(request, response);
        } else if (btnCuenta != null) {
            buscarCuenta(request, response, btnCuenta);
        } else if (btnDepositar != null) {
            depositar(request, response);
        } else if (btnCuentaA != null) {
            buscarCuentaA(request, response);
        } else if (btnCrearUsuario != null) {
            try {
                crearUsuario(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(controlador.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (btnVincular != null) {
            try {
                vincularCuenta(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(controlador.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (btnCuentaRetiro != null) {
            buscarCuenta(request, response, btnCuentaRetiro);
        }
    }

    protected void logIn(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usr = request.getParameter("logUsuario");
        String pass = request.getParameter("logPass");
        boolean verificacion = modelo.revisarCredenciales(usr, pass);

        if (verificacion) {

            switch (modelo.getUltimoRol()) {
                case "CLI":
                    request.getSession().setAttribute("usuario", modelo.getCliente());
                    request.getSession().setAttribute("rol", modelo.getUltimoRol());
                    break;
                case "CAJ":
                    request.getSession().setAttribute("cajero", modelo.getCajero());
                    request.getSession().setAttribute("rol", modelo.getUltimoRol());
            }
            RequestDispatcher dispatcher = request.getRequestDispatcher("/sesion.jsp");
            dispatcher.forward(request, response);

        } else {
            request.setAttribute("validacion", false);
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    private void logOut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        switch (modelo.getUltimoRol()) {
            case "CLI":
                session.removeAttribute("usuario");
                session.removeAttribute("rol");
                break;
            case "CAJ":
                session.removeAttribute("cajero");
                session.removeAttribute("rol");
        }
        session.invalidate();
        RequestDispatcher dispatcher = request.getRequestDispatcher("/index.jsp");
        dispatcher.forward(request, response);
    }

    protected void buscarCuenta(HttpServletRequest request, HttpServletResponse response, String boton)
            throws ServletException, IOException {

        String txtCuenta = (String) request.getParameter("txtCuenta");
        List lista = modelo.recuperarCuentas(txtCuenta);
        if (lista.size() > 0) {
            request.setAttribute("cuentas", lista);
        }
        if (boton.equals("btnCuenta")) {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/deposito.jsp");
            dispatcher.forward(request, response);
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/retiro.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void buscarCuentaA(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtCuenta = (String) request.getParameter("cedExistente");
        List lista = modelo.recuperarCuentas(txtCuenta);
        if (lista.size() > 0) {
            request.setAttribute("cuentasA", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/aperturaCuenta.jsp");
            dispatcher.forward(request, response);
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/aperturaCuenta.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void vincularCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        String txtCuenta = (String) request.getParameter("cedExistente");
        String nCuenta = Integer.toString(Modelo.cont);//Id incrementable
        String tipoMoneda = (String) request.getParameter("drone");
        String limiteTransferencias = (String) request.getParameter("transferencia");
        Usuario aux = DAO.obtenerInstancia().recuperarUsuario(txtCuenta);
        int id = Integer.parseInt(nCuenta) + 1;
        int saldo = 0;
        Cuenta c1 = new Cuenta(id, aux, new Moneda(tipoMoneda), saldo);
        modelo.insertarCuenta(c1);
        Modelo.cont++;
        RequestDispatcher dispatcher = request.getRequestDispatcher("/procesoCorrecto.jsp");
        dispatcher.forward(request, response);
    }

    private void crearUsuario(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {

        String txtCuenta = (String) request.getParameter("cedNueva");
        String nCuenta = Integer.toString(Modelo.cont);//Id incrementable
        String tipoMoneda = (String) request.getParameter("drone");
        String limiteTransferencias = (String) request.getParameter("transferencia");
        String nombre = (String) request.getParameter("nomN");
        String telefono = (String) request.getParameter("celT");
        String pass = (String) request.getParameter("passN");
        boolean verificacion = modelo.idDuplicada(txtCuenta);
        if (!verificacion) {
            Usuario aux = new Usuario(txtCuenta, nombre, pass, "CLI", Integer.parseInt(telefono));
            int id = Integer.parseInt(nCuenta) + 1;
            int saldo = 0;
            Cuenta c1 = new Cuenta(id, aux, new Moneda(tipoMoneda), saldo);
            modelo.insertarUsuario(aux);
            modelo.insertarCuenta(c1);
            Modelo.cont++;
            RequestDispatcher dispatcher = request.getRequestDispatcher("/procesoCorrecto.jsp");
            dispatcher.forward(request, response);
        } else {
            request.setAttribute("validacion", false);
            request.getRequestDispatcher("/aperturaCuenta.jsp").forward(request, response);
        }
    }

    protected void depositar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Float monto = Float.parseFloat(((String) request.getParameter("txtMonto")));
        int cuenta = Integer.parseInt((String) request.getParameter("txtCuentaDeposito"));

        List lista = modelo.getCuentas();
        for (int i = 0; i < lista.size(); i++) {
            if (cuenta == ((Cuenta) lista.get(i)).getId()) {
                modelo.realizarDeposito((Cuenta) lista.get(i), monto);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/procesoCorrecto.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private Modelo modelo;

}
