package com.litierses.Servicios;

import android.support.annotation.NonNull;

import com.litierses.Entidades.Dieta;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.ListIterator;

public class Simulacion_BD {

    public static ArrayList <Dieta> consultarDietas_BD()
    {
        ArrayList <Dieta> retorno = new ArrayList<Dieta>() ;


        retorno.add(0,new Dieta("Dieta1","Desayuno","Almuerzo","Cena","Merienda",1));
        retorno.add(1,new Dieta("Dieta2","Desayuno","Almuerzo","Cena","Merienda",2));
        retorno.add(2,new Dieta("Dieta3","Desayuno","Almuerzo","Cena","Merienda",3));
        retorno.add(3,new Dieta("Dieta4","Desayuno","Almuerzo","Cena","Merienda",4));
        retorno.add(4,new Dieta("Dieta5","Desayuno","Almuerzo","Cena","Merienda",5));
        retorno.add(5,new Dieta("Dieta6","Desayuno","Almuerzo","Cena","Merienda",6));
        retorno.add(6,new Dieta("Dieta7","Desayuno","Almuerzo","Cena","Merienda",7));
        retorno.add(7,new Dieta("Dieta8","Desayuno","Almuerzo","Cena","Merienda",8));
        retorno.add(8,new Dieta("Dieta9","Desayuno","Almuerzo","Cena","Merienda",9));
        retorno.add(9,new Dieta("Dieta10","Desayuno","Almuerzo","Cena","Merienda",10));
        retorno.add(10,new Dieta("Dieta11","Desayuno","Almuerzo","Cena","Merienda",11));


        return retorno;
    }
}
