/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.modelo;

import java.io.Serializable;
import java.util.List;

/**
 *
 * @author frank
 */

public class Cuenta implements Serializable {

    private Integer id;
    private float monto;
    private List<Cuenta> cuentasList;
    private List<Cuenta> cuentasList1;
    private Moneda moneda;
    private Usuario usuarios;
    private List<Movimientos> movimientosList;

    public Cuenta() {
    }

    public Cuenta(Integer id, Usuario usuario, Moneda moneda, float monto) {
        this.id = id;
        this.usuarios = usuario;
        this.moneda = moneda;
        this.monto = monto;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public float getMonto() {
        return monto;
    }

    public void setMonto(float monto) {
        this.monto = monto;
    }

    public List<Cuenta> getCuentasList() {
        return cuentasList;
    }

    public void setCuentasList(List<Cuenta> cuentasList) {
        this.cuentasList = cuentasList;
    }

    public List<Cuenta> getCuentasList1() {
        return cuentasList1;
    }

    public void setCuentasList1(List<Cuenta> cuentasList1) {
        this.cuentasList1 = cuentasList1;
    }

    public Moneda getMoneda() {
        return moneda;
    }

    public void setMoneda(Moneda moneda) {
        this.moneda = moneda;
    }

    public Usuario getUsuarios() {
        return usuarios;
    }

    public void setUsuarios(Usuario usuarios) {
        this.usuarios = usuarios;
    }

    public List<Movimientos> getMovimientosList() {
        return movimientosList;
    }

    public void setMovimientosList(List<Movimientos> movimientosList) {
        this.movimientosList = movimientosList;
    }

    @Override
    public String toString() {
        return "proyecto.modelo.Cuentas[ id=" + id + " ]";
    }
    
}
