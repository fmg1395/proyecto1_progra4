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

public class Cliente implements Serializable {

    private static final long serialVersionUID = 1L;
   
    private String id;
    private String nombre;
    private String clave;
    private Integer telefono; 
    private List<Cuentas> cuentasList;

    public Cliente() {
        this("0","John Doe","jd123",0);
    }


    public Cliente(String id, String nombre, String clave,int telefono) {
        this.id = id;
        this.nombre = nombre;
        this.clave = clave;
        this.telefono = telefono;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    public Integer getTelefono() {
        return telefono;
    }

    public void setTelefono(Integer telefono) {
        this.telefono = telefono;
    }

    public List<Cuentas> getCuentasList() {
        return cuentasList;
    }

    public void setCuentasList(List<Cuentas> cuentasList) {
        this.cuentasList = cuentasList;
    }
    
    public Object[] toArray() {
        return new Object[]{
            id,
            nombre,
            clave,
            telefono,
        };
    }

    @Override
    public String toString() {
        String s = String.format("[ %s, %s, %s]",this.id,this.nombre,this.clave);
        return s;
    }
    
}
