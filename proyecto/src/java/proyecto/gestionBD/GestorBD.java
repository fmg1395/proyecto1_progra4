/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.gestionBD;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author frank
 */
public class GestorBD {

    private GestorBD() throws IOException {
        System.out.printf("Inicializando manejador BD: '%s'..%n", CLASE_MANEJADOR);
        try {
            Class.forName(CLASE_MANEJADOR).newInstance();
            prop.load(getClass().getResourceAsStream(ARCHIVO_CONFIGURACION));
        } catch (ClassNotFoundException
                | IllegalAccessException
                | InstantiationException ex) {
            System.err.printf("Excepción: '%s'%n", ex.getMessage());
        }
    }

    public static GestorBD obtenerInstancia() throws IOException {
        if (instancia == null) {
            instancia = new GestorBD();
        }
        return instancia;
    }

    public Connection obtenerConexion()
            throws SQLException {
        Connection cnx;
        String baseDatos = prop.getProperty("base_datos");
        String usuario = prop.getProperty("usuario");
        String clave = prop.getProperty("clave");

        String URL_conexion
                = String.format(FORMATO_CONEXION, PROTOCOLO, URL_SERVIDOR, baseDatos);
        cnx = DriverManager.getConnection(URL_conexion, usuario, clave);
        return cnx;
    }
    

    private static final String CLASE_MANEJADOR = "com.mysql.cj.jdbc.Driver";
    private static final String FORMATO_CONEXION = "%s//%s:3306/%s"
            + "?useTimezone=true&serverTimezone=UTC";
    private static final String PROTOCOLO = "jdbc:mysql:";
    private static final String URL_SERVIDOR = "localhost";
    private static final String ARCHIVO_CONFIGURACION = "configuracion.properties";
    private static GestorBD instancia = null;
    private Properties prop = new Properties();

    public static void main(String[] args) 
    {
        try {
            GestorBD conexion = GestorBD.obtenerInstancia();
            conexion.obtenerConexion();
        } catch (IOException ex) {
            Logger.getLogger(GestorBD.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(GestorBD.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }

}
