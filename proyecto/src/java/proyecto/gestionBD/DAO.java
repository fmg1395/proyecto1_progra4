package proyecto.gestionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import proyecto.modelo.Cliente;

/**
 *
 * @author frank
 */
public class DAO {

    private DAO() {

    }

    public static DAO obtenerInstancia() {
        if (instancia == null) {
            instancia = new DAO();
        }
        return instancia;
    }

    private Connection obtenerConexion() throws SQLException {
        return GestorBD.obtenerInstancia().obtenerConexion();
    }

    public boolean agregarCliente(Cliente c) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_AGREGAR)) {
            stm.clearParameters();
            stm.setString(1, c.getId());
            stm.setString(2, c.getNombre());
            stm.setString(3, c.getClave());
            stm.setInt(4, c.getTelefono());

            return stm.executeUpdate() == 1;
        }
    }

    private static DAO instancia = null;

    private static final String CMD_AGREGAR
            = "INSERT INTO clientes (id,nombre,clave,telefono) "
            + "VALUES (?,?,?,?); ";

    public static void main(String[] args) {
        Cliente c = new Cliente("99", "Marco", "mar123", 8978654);

        DAO prueba = DAO.obtenerInstancia();

        try {
            prueba.agregarCliente(c);
        } catch (SQLException ex) {
            System.err.printf("FALLO AGREGAR CLIENTE: %s", ex.getMessage());
        }

    }

}
