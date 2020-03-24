/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.modelo;

import java.io.Serializable;
import java.util.List;

public class Usuario implements Serializable {

    private String id;
    private String nombre;
    private String clave;
    private String rol;
    private Integer telefono;
    private List<Cuentas> cuentasList;

    public Usuario() {
    }

    public Usuario(String id, String nombre, String clave, String rol) {
        this.id = id;
        this.nombre = nombre;
        this.clave = clave;
        this.rol = rol;
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

    public String getRol() {
        return rol;
    }

    public void setRol(String rol) {
        this.rol = rol;
    }

    public Integer getTelefono() {
        if(this.telefono != null)
            return telefono;
        else return null;
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

    @Override
    public String toString() {
        return "proyecto.modelo.Usuarios[ id=" + id + " ]";
    }

}
