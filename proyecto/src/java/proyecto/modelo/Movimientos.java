/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.modelo;

import java.io.Serializable;
import java.util.Date;

/**
 *
 * @author frank
 */

public class Movimientos implements Serializable {

    private Integer id;
    private Integer cuentaOrg;
    private int monto;
    private Date fecha;
    private String idDepos;
    private String nombreDepos;
    private String detalle;
    private Cuenta cuenta_des;

    public Movimientos() {
    }

    public Movimientos(Integer id) {
        this.id = id;
    }

    public Movimientos(Integer id, int monto, Date fecha, String idDepos) {
        this.id = id;
        this.monto = monto;
        this.fecha = fecha;
        this.idDepos = idDepos;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getCuentaOrg() {
        return cuentaOrg;
    }

    public void setCuentaOrg(Integer cuentaOrg) {
        this.cuentaOrg = cuentaOrg;
    }

    public int getMonto() {
        return monto;
    }

    public void setMonto(int monto) {
        this.monto = monto;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getIdDepos() {
        return idDepos;
    }

    public void setIdDepos(String idDepos) {
        this.idDepos = idDepos;
    }

    public String getNombreDepos() {
        return nombreDepos;
    }

    public void setNombreDepos(String nombreDepos) {
        this.nombreDepos = nombreDepos;
    }

    public String getDetalle() {
        return detalle;
    }

    public void setDetalle(String detalle) {
        this.detalle = detalle;
    }

    public Cuenta getCuentaDestino() {
        return cuenta_des;
    }

    public void setCuentasDestino(Cuenta cuentas) {
        this.cuenta_des = cuentas;
        this.cuenta_des.getMovimientosList().add(this);
    }  

    @Override
    public String toString() {
        return "proyecto.modelo.Movimientos[ id=" + id + " ]";
    }
    
}
