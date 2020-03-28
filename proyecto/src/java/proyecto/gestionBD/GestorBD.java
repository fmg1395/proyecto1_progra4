package proyecto.gestionBD;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

/**
 *
 * @author frank
 */
public class GestorBD {

    private GestorBD() {
        System.out.printf("Inicializando manejador BD: '%s'..%n", CLASE_MANEJADOR);
        try {
            Class.forName(CLASE_MANEJADOR).newInstance();
            this.config = new Properties();
            this.config.load(getClass().getResourceAsStream("configuracion.properties"));
            this.baseDatos = config.getProperty("base_datos");
            this.usuario = config.getProperty("usuario");
            this.clave = config.getProperty("clave");
            
        } catch (ClassNotFoundException
                | IllegalAccessException
                | InstantiationException
                |IOException ex) {
            System.err.printf("Excepción: '%s'%n", ex.getMessage());
        }
    }

    public static GestorBD obtenerInstancia() {
        if (instancia == null) {
            instancia = new GestorBD();
        }
        return instancia;
    }

    public Connection obtenerConexion()
            throws SQLException {
        Connection cnx;
        String URL_conexion
                = String.format(FORMATO_CONEXION, PROTOCOLO, URL_SERVIDOR, this.baseDatos);
        cnx = DriverManager.getConnection(URL_conexion, this.usuario, this.clave);
        return cnx;
    }

    private static final String CLASE_MANEJADOR = "com.mysql.cj.jdbc.Driver";
    private static final String FORMATO_CONEXION = "%s//%s:3306/%s"
            + "?useTimezone=true&serverTimezone=UTC&useSSL=false";
    private static final String PROTOCOLO = "jdbc:mysql:";
    private static final String URL_SERVIDOR = "localhost";
    
    private String baseDatos;
    private String usuario;
    private String clave;

    private Properties config;
    
    private static GestorBD instancia = null;

    public static void main(String[] args) {
        
        
        GestorBD ges = GestorBD.obtenerInstancia();
        
        try {
            ges.obtenerConexion();
        } catch (SQLException ex) {
            System.err.printf("Exception mysql: %s", ex.getMessage());
        }

    }

}
