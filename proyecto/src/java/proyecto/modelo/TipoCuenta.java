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

public class TipoCuenta implements Serializable {

  
    private Integer id;
    private String descripcion;
   // private List<Intereses> interesesList;

    public TipoCuenta() {
    }

    public TipoCuenta(Integer id, String descripcion) {
        this.id = id;
        this.descripcion = descripcion;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

//    public List<Intereses> getInteresesList() {
//        return interesesList;
//    }
//
//    public void setInteresesList(List<Intereses> interesesList) {
//        this.interesesList = interesesList;
//    }


    @Override
    public String toString() {
        return "proyecto.modelo.TipoCuentas[ id=" + id + " ]";
    }
    
}
