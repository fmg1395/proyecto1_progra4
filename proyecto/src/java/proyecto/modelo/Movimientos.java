/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.modelo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
//import javax.validation.constraints.NotNull;
//import javax.validation.constraints.Size;

/**
 *
 * @author frank
 */

public class Movimientos implements Serializable {

    private static final long serialVersionUID = 1L;
    private Integer id;
    private Integer cuentaOrg;
    private int monto;
    private Date fecha;
    private String idDepos;
    private String nombreDepos;
    private String detalle;
    private Cuenta cuentas;

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

    public Cuenta getCuentas() {
        return cuentas;
    }

    public void setCuentas(Cuenta cuentas) {
        this.cuentas = cuentas;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Movimientos)) {
            return false;
        }
        Movimientos other = (Movimientos) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "proyecto.modelo.Movimientos[ id=" + id + " ]";
    }
    
}
