package com.litierses.Controladores;

import android.app.Activity;

import com.litierses.entities.Dieta;
import com.litierses.entities.services.Dieta__General__;
import com.litierses.Paginas.DietaList_Activity;
import com.litierses.Paginas.EditDieta_Activity;
import com.litierses.Paginas.ViewDieta_Activity;

import java.util.HashMap;
import java.util.ArrayList;

public class DietaManager {
    public static void listAll(Activity activity)
    {
        ArrayList<Dieta> dietas = new Dieta__General__().findAll();
        DietaList_Activity.launch(activity, dietas );
    }
    public static void listDieta ( ArrayList<Dieta> dietaList, Activity activity)
    {
        DietaList_Activity.launch(activity, dietaList);
    }
    public static void viewDieta (Activity activity, Dieta dieta)
    {
        ViewDieta_Activity.launch(activity, dieta);
    }
    public static void editDieta (Activity activity, Dieta dieta)
    {
        EditDieta_Activity.launch(activity, dieta);
    }
    public static void createDieta (Activity activity, Dieta dieta)
    {
        EditDieta_Activity.launch(activity, dieta);
    }
    public static void saveDieta(Activity activity, Dieta dieta)
    {
        //if(Dieta_General_.isPersistent(dieta)){
           // new Dieta_General_().save(dieta);
       // } else {
            new Dieta__General__().create(dieta);
       // }
        listAll(activity);
    }

    public static void deleteDieta(Activity activity, Dieta dieta)
    {
        new Dieta__General__().remove(dieta);
        listAll(activity);
    }

}
