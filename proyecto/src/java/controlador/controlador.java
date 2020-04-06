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
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String btnCuentaA = (String) request.getParameter("btnCuentaA");
        String btnVincular=(String) request.getParameter("btnVincular");
        String btnLogIn = (String) request.getParameter("btnLogIn");
        String btnCuenta = (String) request.getParameter("btnCuenta");
        String btnDepositar = (String) request.getParameter("btnDepositar");
        String btnCrearUsuario=(String)request.getParameter("crearUsuario");
        if (btnLogIn != null) {
            logIn(request, response);
        } else if (btnCuenta != null) {
            buscarCuenta(request, response);
        } else if (btnDepositar != null) {
            depositar(request, response);
        } else if (btnCuentaA != null) {
           buscarCuentaA(request,response);
        }
        else if(btnCrearUsuario!=null)
        {
            crearUsuario(request,response);
        }
        else if(btnVincular!=null)
        {
            try {
                vincularCuenta(request,response);
            } catch (SQLException ex) {
                Logger.getLogger(controlador.class.getName()).log(Level.SEVERE, null, ex);
            }
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
            request.setAttribute("usuario", null);
            request.setAttribute("valid", "wrong");
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        }
    }

    protected void buscarCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtCuenta = (String) request.getParameter("txtCuenta");
        List lista = modelo.recuperarCuentas(txtCuenta);
        if (lista.size() > 0) {
            request.setAttribute("cuentas", lista);
            RequestDispatcher dispatcher = request.getRequestDispatcher("/deposito.jsp");
            dispatcher.forward(request, response);
        } else {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/deposito.jsp");
            dispatcher.forward(request, response);
        }
    }

    protected void buscarCuentaA(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String txtCuenta = (String) request.getParameter("cedExistente");
        List lista = modelo.recuperarCuentas(txtCuenta);
        if(lista.size()>0)
        { request.setAttribute("cuentasA", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/aperturaCuenta.jsp");
        dispatcher.forward(request, response);
        }
        else
        {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/aperturaCuenta.jsp");
        dispatcher.forward(request, response);
        }
    }
    protected void vincularCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException{
        String txtCuenta=(String)request.getParameter("cedExistente");
        String nCuenta=Integer.toString(Modelo.cont);//Id incrementable
        String tipoMoneda=(String)request.getParameter("drone");
        String limiteTransferencias=(String) request.getParameter("transferencia");
        Usuario aux=DAO.obtenerInstancia().recuperarUsuario(txtCuenta);
        int id=Integer.parseInt(nCuenta)+1;
        int saldo=0;
        Cuenta c1=new Cuenta(id,aux,new Moneda(tipoMoneda),saldo);
        modelo.insertarCuenta(c1);
        Modelo.cont++;
        RequestDispatcher dispatcher=request.getRequestDispatcher("/procesoCorrecto.jsp");
        dispatcher.forward(request, response);
    }
    protected void depositar(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Float monto = Float.parseFloat(((String) request.getParameter("txtMonto")));
        int cuenta = Integer.parseInt((String) request.getParameter("txtCuentaDeposito"));

        List lista = modelo.getCuentas();
        for (int i = 0; i < lista.size(); i++) {
            if (cuenta == ((Cuenta) lista.get(i)).getId()) {
                modelo.realizarDeposito((Cuenta) lista.get(i), monto);
                RequestDispatcher dispatcher = request.getRequestDispatcher("/deposito.jsp");
                dispatcher.forward(request, response);
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private Modelo modelo;

    private void crearUsuario(HttpServletRequest request, HttpServletResponse response)   throws ServletException, IOException {
        String txtCuenta = (String) request.getParameter("cedExistente");
        List lista = modelo.recuperarCuentas(txtCuenta);
        if(lista.size()>0)
        { request.setAttribute("cuentasA", lista);
        RequestDispatcher dispatcher = request.getRequestDispatcher("/aperturaCuenta.jsp");
        dispatcher.forward(request, response);
        }
        else
        {
            RequestDispatcher dispatcher = request.getRequestDispatcher("/aperturaCuenta.jsp");
        dispatcher.forward(request, response);
        }
    }

}
