package proyecto.modelo;

import java.util.Date;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import proyecto.gestionBD.DAO;

/**
 *
 * @author frank
 */
public class Modelo {

    public static int cont = 0;

    public Modelo() {
        this.cliente = null;
        this.cajero = null;
        this.ultimoRol = "Null";
        this.cuentas = new ArrayList<>();
    }

    public void insertarCuenta(Cuenta c) throws SQLException {
        DAO cnx = DAO.obtenerInstancia();
        cnx.crearCuenta(c);
    }

    public void insertarUsuario(Usuario u) throws SQLException {
        DAO cnx = DAO.obtenerInstancia();
        cnx.crearUsuario(u);
    }
    public void acreditacion(float n, String p) throws SQLException
    {
        DAO cnx=DAO.obtenerInstancia();
        cnx.acreditacion(n, p);
    }
    
    //Devuelve tasa de interes de la cuenta
    //Depende del tipo de cuenta y de la moneda
    public double recuperarTasaInteres(Cuenta c) throws SQLException
    {
        DAO cnx = DAO.obtenerInstancia();
        return cnx.buscarTasaInteres(c);
    }

    public void recuperarUsuario(String id) {
        DAO cnx = DAO.obtenerInstancia();

        try {
            Usuario usr = cnx.recuperarUsuario(id);

            if (usr != null && usr.getRol().equals("CAJ")) {
                this.setCajero(usr);
                this.setUltimoRol(usr.getRol());
            }

            if (usr != null && usr.getRol().equals("CLI")) {
                this.setCliente(usr);
                this.setUltimoRol(usr.getRol());
            }

        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar usuario, %s", ex.getMessage());
            this.setCliente(null);
            this.setCajero(null);
        }
    }

    public boolean realizarDeposito(Cuenta c, float monto, String nomDepos, String idDepos, String detalle) {

        Movimientos m;
        DAO cnx = DAO.obtenerInstancia();

        try {
            if (monto > 0) {
                m = new Movimientos(0, monto, new Date(), idDepos, c.getId());
                if (!detalle.isEmpty()) {
                    m.setDetalle(detalle);
                }
                if(!nomDepos.isEmpty())
                    m.setNombreDepos(nomDepos);
                
                c.setMonto(c.getMonto()+monto);
                return cnx.ingresarMovimiento(m,c);
            }

        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar usuario, %s", ex.getMessage());
            return false;
        }
        return false;
    }

    public Usuario getCliente() {
        return cliente;
    }

    public void setCliente(Usuario cliente) {
        this.cliente = cliente;
    }

    public Usuario getCajero() {
        return cajero;
    }

    public void setCajero(Usuario cajero) {
        this.cajero = cajero;
    }

    public String getUltimoRol() {
        return ultimoRol;
    }

    public void setUltimoRol(String ultimoRol) {
        this.ultimoRol = ultimoRol;
    }

    public List<Cuenta> getCuentas() {
        return cuentas;
    }

    public void setCuentas(List<Cuenta> cuentas) {
        this.cuentas = cuentas;
    }

    public static int cantidadCuentas() {
        DAO cnx = DAO.obtenerInstancia();

        try {
            int cantidad = cnx.cantidadCuentas();
            return cantidad;
        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar cantidad de cuentas, %s", ex.getMessage());
            return -1;
        }
    }

    //Recupera todas las cuentas del cliente
    //se utiliza la cedula para buscar las
    //cuentas
    public List recuperarCuentas(String id) {
        try {
            DAO cnx = DAO.obtenerInstancia();
            List cuentas = cnx.recuperarCuentas(id);
            this.setCuentas(cuentas);
            return cuentas;
        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar cuentas, %s", ex.getMessage());
        }
        return null;
    }
   public List recuperarMovimientos(int cuenta) throws SQLException{
      try{ DAO cnx=DAO.obtenerInstancia();
       List movimientos=cnx.recuperarMovimientos(cuenta);
      return movimientos;
   }
    catch(SQLException ex){
        System.err.printf("Exception Model: recuperar movimientos,%s",ex.getMessage());
    }  
      return null;
   }
    //Recupera solo una cuenta por
    //medio de su ID
    public Cuenta recuperaCuenta(int id) {
        DAO cnx = DAO.obtenerInstancia();
        try {
            Cuenta c = cnx.recuperarCuenta(id);
            this.getCuentas().add(c);
            return c;
        } catch (SQLException ex) {
            System.err.printf("Exception Model: recuperar cuenta, %s", ex.getMessage());
        }
        return null;
    }
    
    public void limpiarUsuario() {
        this.setCliente(null);
        this.setCajero(null);
        this.setCuentas(null);
        this.setUltimoRol(null);
    }

    public boolean idDuplicada(String id) {
        recuperarUsuario(id);
        if (this.getCliente() != null || this.getCajero() != null) {
            return true;
        } else {
            return false;
        }
    }

    public boolean revisarCredenciales(String id, String clave) {
        recuperarUsuario(id);
        if (this.getCliente() != null) {
            return this.getCliente().getClave().equals(clave);
        }

        if (this.getCajero() != null) {
            return this.getCajero().getClave().equals(clave);
        }

        return false;
    }

    public List recuperarVinculadas() throws SQLException {
        DAO cnx=DAO.obtenerInstancia();
        List lista=null,listaVinculadas=new ArrayList<>();
           lista=cnx.recuperarVinculadas();//recuperamos tabla vinculadas
         
           for(int i=0;i<this.getCuentas().size();i++)
         {
             for(int j=0;j<lista.size();j++)
             {
                if(((Vinculacion)lista.get(j)).getId_c1()==this.getCuentas().get(i).getId())
                {
                    listaVinculadas.add(lista.get(j));
                }
             }
         }
    
            return listaVinculadas;}
    //ultimoRol va a tener el ultimo roll
    //que ingresó credenciales
    private String ultimoRol;

    private Usuario cliente;
    private Usuario cajero;
    private List<Cuenta> cuentas;

}
