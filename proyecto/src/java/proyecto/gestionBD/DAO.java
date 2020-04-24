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
import proyecto.modelo.Movimientos;
import proyecto.modelo.TipoCuenta;
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
            stm.setInt(4, c.getTipoCuenta().getId());
            stm.setInt(5, c.getLimiteTransferencias());
            return stm.executeUpdate() == 1;
        }
    }

    public boolean crearUsuario(Usuario u) throws SQLException {
        try (
                Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_AGREGAR_USUARIO)) {
            stm.clearParameters();
            stm.setString(1, u.getId());
            stm.setString(2, u.getNombre());//nombre,clave,telefono,rol
            stm.setString(3, u.getClave());
            stm.setInt(4, u.getTelefono());
            stm.setString(5, u.getRol());
            return stm.executeUpdate() == 1;
        }
    }

    //Recupera todas las cuentas del cliente
    //por medio de su ID
    public List recuperarCuentas(String id) throws SQLException {

        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_CUENTAS)) {
            List lista = new ArrayList<>();

            Cuenta c = null;
            stm.clearParameters();
            stm.setString(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    Usuario usr = this.recuperarUsuario(rs.getString("cliente"));
                    Moneda moneda = this.recuperarMoneda(rs.getString("moneda"));
                    TipoCuenta tipo = this.recuperarTipoCuenta(rs.getInt("tipo_cuenta"));
                    c = new Cuenta(
                            rs.getInt("id"),
                            tipo,
                            usr,
                            moneda,
                            rs.getFloat("monto")
                    );
                    List mov = this.recuperarMovimientos(c.getId());
                    if (mov != null) {
                        c.setMovimientosList(mov);
                    }
                    lista.add(c);
                }
            }
            return lista;
        }
    }

    public TipoCuenta recuperarTipoCuenta(int id) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_TIPOCUENTA)) {
            TipoCuenta t = null;
            stm.clearParameters();
            stm.setInt(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    t = new TipoCuenta(
                            rs.getInt("id"),
                            rs.getString("descripcion")
                    );
                    return t;
                }
                return null;
            }
        }
    }

    //Recupera cuenta por su ID
    //sin necesidad de usuario
    public Cuenta recuperarCuenta(int id) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_CUENTA)) {
            Cuenta c = null;
            stm.clearParameters();
            stm.setInt(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    Usuario usr = this.recuperarUsuario(rs.getString("cliente"));
                    Moneda moneda = this.recuperarMoneda(rs.getString("moneda"));
                    TipoCuenta tipo = this.recuperarTipoCuenta(rs.getInt("tipo_cuenta"));
                    c = new Cuenta(
                            rs.getInt("id"),
                            tipo,
                            usr,
                            moneda,
                            rs.getFloat("monto")
                    );
                    List mov = this.recuperarMovimientos(id);
                    if (mov != null) {
                        c.setMovimientosList(mov);
                    }
                    return c;
                }
            }
            return null;
        }
    }

    //Arreglar query para optener todos los movimientos
    //tanto retiros como depositos y transacciones
    public List<Movimientos> recuperarMovimientos(int id) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_RECUPERAR_MOVIMIENTO)) {
            List<Movimientos> lista = new ArrayList<>();
            Movimientos m = null;
            stm.clearParameters();
            stm.setInt(1, id);

            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    m = new Movimientos(
                            rs.getInt("id"),
                            rs.getInt("monto"),
                            rs.getDate("fecha"),
                            rs.getString("id_depos"),
                            rs.getInt("cuenta_des")
                    );

                    String detalle = rs.getString("detalle");
                    String nomDep = rs.getString("nombre_depos");
                    Integer id_origen = rs.getInt("cuenta_org");
                    if (detalle != null) {
                        m.setDetalle(detalle);
                    }
                    if (nomDep != null) {
                        m.setNombreDepos(nomDep);
                    }
                    if (id_origen != null) {
                        m.setCuentaOrg(id_origen);
                    }

                    lista.add(m);
                }
                return lista;
            }
        }
    }

    public boolean ingresarMovimiento(Movimientos m, Cuenta c) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_AGREGAR_MOVIMIENTO)) {
            stm.clearParameters();

            stm.setInt(2, m.getCuentaDestino());
            stm.setFloat(3, m.getMonto());
            stm.setDate(4, m.getSQLFecha());
            stm.setString(5, m.getIdDepos());

            if (m.getCuentaOrg() != null) {
                stm.setInt(1, m.getCuentaOrg());
            } else {
                stm.setNull(1, Types.INTEGER);
            }
            if (!m.getNombreDepos().isEmpty()) {
                stm.setString(6, m.getNombreDepos());
            } else {
                stm.setNull(6, Types.VARCHAR);
            }
            if (!m.getDetalle().isEmpty()) {
                stm.setString(7, m.getDetalle());
            } else {
                stm.setNull(7, Types.VARCHAR);
            }

            if (actualizarMonto(c)) {
                return stm.executeUpdate() == 1;
            }
            return false;
        }
    }

    //Actualiza el monto de una cuenta
    public boolean actualizarMonto(Cuenta c) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_ACTUALIZAR_MONTO)) {
            stm.clearParameters();
            stm.setFloat(1, c.getMonto());
            stm.setInt(2, c.getId());
            return stm.executeUpdate() == 1;
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

    public int cantidadCuentas() throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_CANTIDAD_CUENTAS)) {
            stm.clearParameters();
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt("count(*)");
                }
            }
        }
        return -1;
    }

    public boolean acreditacion(float valor, String moneda) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_BATCH)) {
            stm.clearParameters();
            stm.setFloat(1, valor / 100);
            stm.setString(2, moneda);

            return stm.executeUpdate() == 1;
        }
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

    //De acuerdo a la cuenta devuelve
    // el porcentaje que corresponde a la tasa de interes
    //que la cuenta tiene asociada
    public double buscarTasaInteres(Cuenta c) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_TASA_INTERES)) {
            stm.clearParameters();
            stm.setInt(1, c.getTipoCuenta().getId());
            stm.setString(2, c.getMoneda().getId());

            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("tasa_interes");
                }
            }
        }
        return -1;
    }

    public List cuentasVinculadas(Cuenta c) throws SQLException {
        try (Connection cnx = obtenerConexion();
                PreparedStatement stm = cnx.prepareStatement(CMD_CUENTAS_VINCULADAS)) {
            List vinculadas = new ArrayList<>();
            stm.clearParameters();
            stm.setInt(1, c.getId());
            try (ResultSet rs = stm.executeQuery()) {
                while (rs.next()) {
                    vinculadas.add(this.recuperarCuenta(rs.getInt("id_c2")));
                }
                return vinculadas;
            }
        }
    }
    
    //Metodo permite registrar en la base de datos
    //que dos cuentas estan vinculadas 
    //para poder hacer transacciones entre ellas de forma rapida
    
    public boolean vincularCuentas()
    {
        return true;
    }

    private static DAO instancia = null;

    private static final String CMD_AGREGAR_USUARIO
            = "INSERT INTO usuarios (id,nombre,clave,telefono,rol) "
            + "VALUES (?,?,?,?,?); ";
    private static final String CMD_BATCH
            = "UPDATE cuentas SET monto=monto+monto*? WHERE moneda=?;";
    private static final String CMD_RECUPERAR_USUARIO
            = "SELECT id,nombre,clave,telefono,rol FROM usuarios WHERE id = ?;";
    private static final String CMD_CREAR_CUENTA
            = "INSERT INTO cuentas (cliente,moneda,monto,tipo_cuenta,limite_transferencias) "
            + "VALUES (?,?,?,?,?);";
    private static final String CMD_RECUPERAR_MONEDA
            = "SELECT id, tipo_cambio FROM moneda WHERE id = ?;";
    private static final String CMD_RECUPERAR_CUENTAS
            = "SELECT id, cliente, moneda, monto,tipo_cuenta FROM cuentas where cliente = ?;";
    private static final String CMD_CANTIDAD_CUENTAS
            = "SELECT COUNT(*) FROM CUENTAS;";
    private static final String CMD_DEPOSITO
            = "UPDATE cuentas SET monto = ? WHERE id = ?;";
    private static final String CMD_RECUPERAR_MOVIMIENTO
            = "SELECT id, cuenta_org, cuenta_des, monto, fecha, id_depos, nombre_depos, detalle"
            + " FROM movimientos WHERE cuenta_des = ?;";
    private static final String CMD_RECUPERAR_CUENTA
            = "SELECT id, cliente, moneda, monto,tipo_cuenta FROM cuentas WHERE id = ?;";
    private static final String CMD_AGREGAR_MOVIMIENTO
            = "INSERT INTO movimientos (cuenta_org, cuenta_des, monto, fecha, id_depos,"
            + "nombre_depos, detalle) VALUES (?,?,?,?,?,?,?);";
    private static final String CMD_ACTUALIZAR_MONTO
            = "UPDATE cuentas SET monto = ? where id = ?;";
    private static final String CMD_RECUPERAR_TIPOCUENTA
            = "SELECT id, descripcion FROM tipo_cuentas where id = ?;";
    private static final String CMD_TASA_INTERES
            = "SELECT tasa_interes FROM intereses where tipo_cuenta = ? and moneda = ?;";
    private static final String CMD_CUENTAS_VINCULADAS
            = "SELECT id_c2 from vinculadas where id_c1 = ?";

    public static void main(String[] args) {
        //Usuario c = new Usuario("998161237", "Edgar Silva", "ES@05", "CLI");

        DAO prueba = DAO.obtenerInstancia();

        try {
            Cuenta cuenta = prueba.recuperarCuenta(1);
            List lista = prueba.cuentasVinculadas(cuenta);

            System.out.println();
        } catch (SQLException ex) {
            System.err.printf("FALLO Recuperar CLIENTE: %s", ex.getMessage());
        }

    }

}
