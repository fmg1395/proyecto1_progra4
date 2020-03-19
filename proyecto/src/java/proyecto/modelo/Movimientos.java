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

/**
 *
 * @author frank
 */
@Entity
@Table(name = "movimientos")
@NamedQueries({
    @NamedQuery(name = "Movimientos.findAll", query = "SELECT m FROM Movimientos m")})
public class Movimientos implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "cuenta_org")
    private Integer cuentaOrg;
    @Basic(optional = false)
    @Column(name = "monto")
    private int monto;
    @Basic(optional = false)
    @Column(name = "fecha")
    @Temporal(TemporalType.DATE)
    private Date fecha;
    @Basic(optional = false)
    @Column(name = "id_depos")
    private String idDepos;
    @Column(name = "nombre_depos")
    private String nombreDepos;
    @JoinColumn(name = "cuenta_des", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Cuentas cuentas;

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

    public Cuentas getCuentas() {
        return cuentas;
    }

    public void setCuentas(Cuentas cuentas) {
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
