package proyecto.modelo;

import java.sql.SQLException;
import java.util.List;
import proyecto.gestionBD.DAO;

/**
 *
 * @author frank
 */
public class Modelo {
public static int cont=0;

    public Modelo() {
        usuario = null;
    }

    public Usuario getUsuario() {
        return usuario;
    }

    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }

    public void recuperarUsuario(String id) {
        DAO cnx = DAO.obtenerInstancia();

        try {
            Usuario usr = cnx.recuperarUsuario(id);
            this.setUsuario(usr);
        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar usuario, %s", ex.getMessage());
            this.usuario = null;
        }
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
    
    

    public boolean revisarCredenciales(String id, String clave) {
        recuperarUsuario(id);
        if (this.usuario == null) {
            return false;
        }
        return this.usuario.getClave().equals(clave);
    }

    private Usuario usuario;
}
