package proyecto.gestionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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
                PreparedStatement stm = cnx.prepareStatement(CMD_AGREGAR_CLIENTE)) {
            stm.clearParameters();
            stm.setString(1, c.getId());
            stm.setString(2, c.getNombre());
            stm.setString(3, c.getClave());
            stm.setInt(4, c.getTelefono());

            return stm.executeUpdate() == 1;
        }
    }
    
    //Metodo devuelve a un cliente por medio
    //de su id
    public Cliente recuperarCliente(String id) throws SQLException
    {
        Cliente c = null;
        try(Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_CLIENTE))
        {
            stm.clearParameters();;
            stm.setString(1, id);
            
            try(ResultSet rs = stm.executeQuery())
            {
                if(rs.next())
                {
                    c = new Cliente(
                    rs.getString("id"),
                    rs.getString("nombre"),
                    rs.getString("clave"),
                    rs.getInt("telefono")
                    );
                }
            }
            
        }
        return c;
    }

    private static DAO instancia = null;

    private static final String CMD_AGREGAR_CLIENTE
            = "INSERT INTO clientes (id,nombre,clave,telefono) "
            + "VALUES (?,?,?,?); ";
    private static final String CMD_RECUPERAR_CLIENTE =
            "SELECT id,nombre,clave,telefono from clientes where id = ?;";

    public static void main(String[] args) {
        Cliente c = null;

        DAO prueba = DAO.obtenerInstancia();

        try {
            c = prueba.recuperarCliente("2");
            System.out.println();
        } catch (SQLException ex) {
            System.err.printf("FALLO AGREGAR CLIENTE: %s", ex.getMessage());
        }

    }

}
