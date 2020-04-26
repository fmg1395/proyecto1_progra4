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
    private Usuario usuario;
    private TipoCuenta tipoCuenta;
    private List<Movimientos> movimientosList;
    private Integer limiteTransferencias;

    public Cuenta() {
    }

    public Cuenta(Usuario usuario,TipoCuenta tipoCuenta, Moneda moneda, float monto,int limite) {
        this.usuario = usuario;
        this.moneda = moneda;
        this.monto = monto;
        this.tipoCuenta=tipoCuenta;
        limiteTransferencias=limite;
    }
    
    public Cuenta(Integer id,TipoCuenta tipoCuenta,Usuario usuario, Moneda moneda, float monto) {
        this.id = id;
        this.usuario = usuario;
        this.moneda = moneda;
        this.monto = monto;
        this.tipoCuenta = tipoCuenta;
    }

  
    public TipoCuenta getTipoCuenta() {
        return tipoCuenta;
    }

   
    public void setTipoCuenta(TipoCuenta tipoCuenta) {
        this.tipoCuenta = tipoCuenta;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getLimiteTransferencias() {
        return limiteTransferencias;
    }

    public void setLimiteTransferencias(Integer limiteTransferencias) {
        this.limiteTransferencias = limiteTransferencias;
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
        return usuario;
    }

    public void setUsuarios(Usuario usuarios) {
        this.usuario = usuarios;
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
