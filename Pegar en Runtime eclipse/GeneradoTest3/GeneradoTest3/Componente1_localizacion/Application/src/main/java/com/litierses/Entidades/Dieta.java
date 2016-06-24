package com.litierses.Entidades;

import java.io.Serializable;

public class Dieta implements Serializable {

    private static final long serialVersionUID = 1L;

    public String nombre;
    public String desayuno;
    public String almuerzo;
    public String cena;
    public String merienda;
    public int patologia;

    public Dieta() {}

    public Dieta(String nombre,String desayuno, String almuerzo, String cena, String merienda, int patologia) {
        this.nombre = nombre;
        this.desayuno = desayuno;
        this.almuerzo = almuerzo;
        this.cena = cena;
        this.merienda = merienda;
        this.patologia = patologia;

    }
    @Override
    public int hashCode () {
        return  patologia;
    }
    @Override
    public boolean equals(Object o) {
        if(o.hashCode() == this.hashCode()) {
            return true;
        }
         return false;
    }
}