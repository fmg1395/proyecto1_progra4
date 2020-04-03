package proyecto.modelo;

import java.sql.SQLException;
import java.util.List;
import proyecto.gestionBD.DAO;

/**
 *
 * @author frank
 */
public class Modelo {

    public static int cont = 0;

    public Modelo() {
        cliente = null;
        cajero = null;
        this.ultimoRol = "Null";
    }

    public void recuperarUsuario(String id) {
        DAO cnx = DAO.obtenerInstancia();

        try {
            Usuario usr = cnx.recuperarUsuario(id);

            if (usr != null && usr.getRol().equals("CAJ")) {
                this.setCajero(usr);
                this.setUltimoRol(usr.getRol());
            }

            if (usr != null && usr.getRol().equals("CLI")) {
                this.setCliente(usr);
                this.setUltimoRol(usr.getRol());
            }

        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar usuario, %s", ex.getMessage());
            this.setCliente(null);
            this.setCajero(null);
        }
    }

    public boolean realizarDeposito(Cuenta c,float monto) {
        try 
        {
            DAO cnx = DAO.obtenerInstancia();
            if(monto>0)
            {
                c.setMonto(c.getMonto()+monto);
                cnx.realizarDeposito(c);
                return true;
            }
            return false;
        } catch (SQLException ex) 
        {
            System.err.printf("Exception Model: recuperar cantidad de cuentas, %s", ex.getMessage());
            return false;
        }
    }

    public Usuario getCliente() {
        return cliente;
    }

    public void setCliente(Usuario cliente) {
        this.cliente = cliente;
    }

    public Usuario getCajero() {
        return cajero;
    }

    public void setCajero(Usuario cajero) {
        this.cajero = cajero;
    }

    public String getUltimoRol() {
        return ultimoRol;
    }

    public void setUltimoRol(String ultimoRol) {
        this.ultimoRol = ultimoRol;
    }

    public static int cantidadCuentas() {
        DAO cnx = DAO.obtenerInstancia();

        try {
            int cantidad = cnx.cantidadCuentas();
            return cantidad;
        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar cantidad de cuentas, %s", ex.getMessage());
            return -1;
        }
    }

    public List recuperarCuentas(String id) {
        try {
            DAO cnx = DAO.obtenerInstancia();
            List cuentas = cnx.recuperarCuentas(id);
            return cuentas;
        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar cuentas, %s", ex.getMessage());
        }
        return null;
    }

    public void limpiarCliente() {
        this.setCliente(null);
    }

    public boolean revisarCredenciales(String id, String clave) {
        recuperarUsuario(id);
        if (this.getCliente() != null) {
            return this.getCliente().getClave().equals(clave);
        }

        if (this.getCajero() != null) {
            return this.getCajero().getClave().equals(clave);
        }

        return false;
    }

    //ultimoRol va a tener el ultimo roll
    //que ingresó credenciales
    private String ultimoRol;

    private Usuario cliente;
    private Usuario cajero;
}
