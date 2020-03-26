package proyecto.gestionBD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import proyecto.modelo.Cuenta;
import proyecto.modelo.Moneda;
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
            //stm.setInt(4, usr.getTelefono());
            stm.setString(5, usr.getRol());

            if (usr.getTelefono() != null) {
                stm.setInt(4, usr.getTelefono());
            } else {
                stm.setNull(4, Types.INTEGER);
            }

            return stm.executeUpdate() == 1;
        }
    }

    //Se crea una nueva cuenta pasando
    //un objeto cuenta el cual previamente
    //necesitaria tener un Usuario y
    //Una moneda
    public boolean crearCuenta(Cuenta c) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_CREAR_CUENTA)) {
            stm.clearParameters();
            stm.setString(1, c.getUsuarios().getId());
            stm.setString(2, c.getMoneda().getId());
            stm.setFloat(3, c.getMonto());
            return stm.executeUpdate() == 1;
        }
    }

    
    //Recupera todas las cuentas del cliente
    //por medio de su ID
    public List recuperarCuentas(String id) throws SQLException {

        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_CUENTA)) {
            List lista = new ArrayList<>();
            
            Cuenta c = null;
            stm.clearParameters();
            stm.setString(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Usuario usr = this.recuperarUsuario(rs.getString("cliente"));
                    Moneda moneda = this.recuperarMoneda(rs.getString("moneda"));
                    
                    c = new Cuenta(
                            rs.getInt("id"),
                            usr,
                            moneda,
                            rs.getFloat("monto")
                    );
                    
                    lista.add(c);
                }
            }
            return lista;
        }
    }
    
    public Moneda recuperarMoneda(String id) throws SQLException {
        Moneda m = null;
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_MONEDA)) {
            stm.clearParameters();
            stm.setString(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    m = new Moneda(rs.getString("id"));

                    float cambio = rs.getFloat("tipo_cambio");

                    if (cambio != 0) {
                        m.setTipoCambio(cambio);
                    } else {
                        m.setTipoCambio(0);
                    }
                }
            }
        }
        return m;
    }

    //Metodo devuelve a un cliente por medio
    //de su id
    public Usuario recuperarUsuario(String id) throws SQLException {
        Usuario usr = null;
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_USUARIO)) {
            stm.clearParameters();
            stm.setString(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    usr = new Usuario(
                            rs.getString("id"),
                            rs.getString("nombre"),
                            rs.getString("clave"),
                            rs.getString("rol")
                    );

                    if (rs.getInt("telefono") != 0) {
                        usr.setTelefono(rs.getInt("telefono"));
                    }

                }
            }

        }
        return usr;
    }

    private static DAO instancia = null;

    private static final String CMD_AGREGAR_USUARIO
            = "INSERT INTO usuarios (id,nombre,clave,telefono,rol) "
            + "VALUES (?,?,?,?,?); ";
    private static final String CMD_RECUPERAR_USUARIO
            = "SELECT id,nombre,clave,telefono,rol from usuarios where id = ?;";
    private static final String CMD_CREAR_CUENTA
            = "INSERT INTO cuentas (cliente,moneda,monto) "
            + "VALUES (?,?,?);";
    private static final String CMD_RECUPERAR_MONEDA
            = "SELECT id, tipo_cambio from moneda where id = ?;";
    private static final String CMD_RECUPERAR_CUENTA
            = "SELECT id, cliente, moneda, monto From cuentas where cliente = ?;";
    
    public static void main(String[] args) {
        Usuario c = new Usuario("998161237", "Edgar Silva", "ES@05", "CLI");

        DAO prueba = DAO.obtenerInstancia();

        try {
            //prueba.agregarUsuario(c);
            Usuario u = DAO.obtenerInstancia().recuperarUsuario("116050901");
//            Moneda m = prueba.recuperarMoneda("EUR");
//            Cuenta cuenta = new Cuenta();
//            cuenta.setUsuarios(u);
//            cuenta.setMoneda(m);
//            cuenta.setMonto(300);
            
//            prueba.crearCuenta(cuenta);
           
           List cl = prueba.recuperarCuentas("116050901");

            System.out.println();
        } catch (SQLException ex) {
            System.err.printf("FALLO Recuperar CLIENTE: %s", ex.getMessage());
        }

    }

}
