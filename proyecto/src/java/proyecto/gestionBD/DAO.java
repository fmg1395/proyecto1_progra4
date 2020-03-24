package proyecto.gestionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import proyecto.modelo.Usuario;

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

    public boolean agregarUsuario(Usuario usr) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_AGREGAR_USUARIO)) {
            stm.clearParameters();
            stm.setString(1, usr.getId());
            stm.setString(2, usr.getNombre());
            stm.setString(3, usr.getClave());
            stm.setInt(4, usr.getTelefono());
            stm.setString(5,usr.getRol());

            return stm.executeUpdate() == 1;
        }
    }
    
    //Metodo devuelve a un cliente por medio
    //de su id
    public Usuario recuperarUsuario(String id) throws SQLException
    {
        Usuario usr = null;
        try(Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_USUARIO))
        {
            stm.clearParameters();
            stm.setString(1, id);
            
            try(ResultSet rs = stm.executeQuery())
            {
                if(rs.next())
                {
                    usr = new Usuario(
                    rs.getString("id"),
                    rs.getString("nombre"),
                    rs.getString("clave"),
                    rs.getString("rol")
                    );
                    
                    if(rs.getInt("telefono")!= 0)
                    {
                        usr.setTelefono(rs.getInt("telefono"));
                    }
                    
                }
            }
            
        }
        return usr;
    }

    private static DAO instancia = null;

    private static final String CMD_AGREGAR_USUARIO
            = "INSERT INTO clientes (id,nombre,clave,telefono,rol) "
            + "VALUES (?,?,?,?,?); ";
    private static final String CMD_RECUPERAR_USUARIO =
            "SELECT id,nombre,clave,telefono from clientes where id = ?;";

    public static void main(String[] args) {
        Usuario c = null;

        DAO prueba = DAO.obtenerInstancia();

        try {
            c = prueba.recuperarUsuario("2");
            System.out.println();
        } catch (SQLException ex) {
            System.err.printf("FALLO AGREGAR CLIENTE: %s", ex.getMessage());
        }

    }

}
