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

    private Integer id;//
    private Integer cuentaOrg; //
    private float monto; //
    private Date fecha; //
    private String idDepos; //
    private String nombreDepos; //
    private String detalle; //
    private Integer cuenta_des; //
    
    // (cuenta_org, cuenta_des, monto, fecha, id_depos, nombre_depos, detalle)

    public Movimientos() {
    }

    public Movimientos(Integer id, float monto, Date fecha, String idDepos, Integer dest) {
        this.id = id;
        this.monto = monto;
        this.fecha = fecha;
        this.idDepos = idDepos;
        this.cuenta_des = dest;
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

    public float getMonto() {
        return monto;
    }

    public void setMonto(float monto) {
        this.monto = monto;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }
    
    public java.sql.Date getSQLFecha()
    {
        return new java.sql.Date(getFecha().getTime());
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

    public Integer getCuentaDestino() {
        return cuenta_des;
    }

    public void setCuentasDestino(Integer cuentas) {
        this.cuenta_des = cuentas;
    }  

    @Override
    public String toString() {
        return "proyecto.modelo.Movimientos[ id=" + id + " ]";
    }
    
}
