/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.modelo;

import java.io.Serializable;

/**
 *
 * @author frank
 */

public class Intereses implements Serializable {

    private Double tasaInteres;
    private Moneda moneda;
    private TipoCuenta tipoCuentas;

    public Intereses() {
    }

    public Intereses(Double tasaInteres, Moneda moneda, TipoCuenta tipoCuentas) {
        this.tasaInteres = tasaInteres;
        this.moneda = moneda;
        this.tipoCuentas = tipoCuentas;
    }

      public Moneda getMoneda() {
        return moneda;
    }

    public void setMoneda(Moneda moneda) {
        this.moneda = moneda;
    }

    public Double getTasaInteres() {
        return tasaInteres;
    }

    public void setTasaInteres(Double tasaInteres) {
        this.tasaInteres = tasaInteres;
    }

    public TipoCuenta getTipoCuentas() {
        return tipoCuentas;
    }

    public void setTipoCuentas(TipoCuenta tipoCuentas) {
        this.tipoCuentas = tipoCuentas;
    }

    @Override
    public String toString() {
        return "proyecto.modelo.Intereses[ interesesPK=" + this.tasaInteres + " ]";
    }
    
}
