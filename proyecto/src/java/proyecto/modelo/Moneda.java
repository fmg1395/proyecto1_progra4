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

public class Moneda implements Serializable {

    private String id;
    private float tipoCambio;
    private List<Cuenta> cuentasList;

    public Moneda() {
    }

    public Moneda(String id) {
        this.id = id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public float getTipoCambio() {
        return tipoCambio;
    }

    public void setTipoCambio(float tipoCambio) {
        this.tipoCambio = tipoCambio;
    }

    public List<Cuenta> getCuentasList() {
        return cuentasList;
    }

    public void setCuentasList(List<Cuenta> cuentasList) {
        this.cuentasList = cuentasList;
    }  
    
    @Override
    public boolean equals(Object o)
    {
        return this.id.equals(((Moneda)o).id);
    }
    
    
}
