
package proyecto.modelo;

import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import proyecto.gestionBD.DAO;

/**
 *
 * @author frank
 */
public class Modelo {

    public Modelo() {
        usuario = null;
    }

    public Usuario getUsuario() {
        return usuario;
    }

   
    public void setUsuario(Usuario usuario) {
        this.usuario = usuario;
    }
    
    public void recuperarUsuario(String id)
    {
        DAO cnx = DAO.obtenerInstancia();
        
        try {
            Usuario usr = cnx.recuperarUsuario(id);
            this.setUsuario(usr);
        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar usuario, %s",ex.getMessage());
            this.usuario = null;
        }
    }
    
    public boolean revisarCredenciales(String id, String clave)
    {
        recuperarUsuario(id);
        if(this.usuario==null)
            return false;
        return this.usuario.getClave().equals(clave);
    }
    
    
    
    
    private Usuario usuario;
}
