/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package proyecto.modelo;

/**
 *
 * @author Kike
 */
public class Vinculacion {
    private int id_c1;
    private int id_c2;

    public Vinculacion(int id_c1, int id_c2) {
        this.id_c1 = id_c1;
        this.id_c2 = id_c2;
    }

    public int getId_c1() {
        return id_c1;
    }

    public void setId_c1(int id_c1) {
        this.id_c1 = id_c1;
    }

    public int getId_c2() {
        return id_c2;
    }

    public void setId_c2(int id_c2) {
        this.id_c2 = id_c2;
    }
    
}
