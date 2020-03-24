
package proyecto.modelo;

/**
 *
 * @author frank
 */
public class modelo {

    public modelo() {
        usuario = null;
    }

    public Usuario getCliente() {
        return usuario;
    }

   
    public void setCliente(Usuario usuario) {
        this.usuario = usuario;
    }
    
    
    
    
    private Usuario usuario;
}
