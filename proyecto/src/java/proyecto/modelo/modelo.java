
package proyecto.modelo;

/**
 *
 * @author frank
 */
public class modelo {

    public modelo() {
        cliente = null;
    }

    public Cliente getCliente() {
        return cliente;
    }

   
    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }
    
    
    
    
    private Cliente cliente;
}
