package com.litierses.Entidades.services;

import android.content.Context;
import android.os.AsyncTask;
import android.util.Log;
import com.litierses.Entidades.Dieta;
import com.litierses.Utilidades.acceso_BD;
import com.litierses.Utilidades.JSONParser;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.util.ArrayList;
import java.util.List;


public class Dieta_General_  {

    static ArrayList<Dieta> dieta_static = new ArrayList();
    static boolean accediendo_bd=false;

    public ArrayList<Dieta> findAll (Context context)
    {
        accediendo_bd = true;
        new bd_findAll().execute();
        while (accediendo_bd == true) { }
        return dieta_static;
    }

    public static boolean isPersistent (Dieta dieta)
    {
        return dieta_static.contains(dieta);
    }

    public void save (Dieta dieta)
    {
        //dieta_static.set(dieta_static.indexOf(dieta),dieta);
        new bd_update().execute(dieta);
    }

    public void create (Dieta dieta) {
        //dieta_static.add(dieta);
        new bd_create().execute(dieta);

    }
    public void remove (Dieta dieta)
    {
        //dieta_static.remove(dieta);
        new bd_delete().execute(dieta);
    }

    class bd_findAll extends AsyncTask<String, String, String> {
        String TAG_SUCCESS = "success";
        JSONParser jParser = new JSONParser();
        JSONArray products = null;
        String url_servicio = acceso_BD.server+"ws.dieta/";           //nombre del servicio a consumir

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        protected String doInBackground(String... args) {
            String params = "";
            JSONArray json = jParser.makeHttpRequest(url_servicio, "GET", params);
            try {
                Log.d("All Products: ", json.toString());
                //int success = json.getInt(TAG_SUCCESS);
                //if (success == 1) {

                    products = json; //json.getJSONArray("dieta");             //Nombre de la tabla
                    dieta_static=new ArrayList();
                    for (int i = 0; i < products.length(); i++) {
                        JSONObject c = products.getJSONObject(i);
                        String id = c.getString("id");                      //Nombre de los campos
                        int nm_id = Integer.parseInt(id);
                        String nombre = c.getString("nombre");                //Nombre de los campos
                        String desayuno = c.getString("desayuno");                //Nombre de los campos
                        String almuerzo = c.getString("almuerzo");                //Nombre de los campos
                        String cena = c.getString("cena");                //Nombre de los campos
                        String merienda = c.getString("merienda");                //Nombre de los campos

                        dieta_static.add(new Dieta(nombre,desayuno,almuerzo,cena,merienda,nm_id));    // Cargue de objetos
                    }
                //}
                accediendo_bd = false;
            } catch (Exception e) {
                e.printStackTrace();
                Log.d("Error de conexión", "------------------ERROR DE CONEXIÓN CON LA BASE DE DATOS --------------");
                accediendo_bd = false;
            }
            return null;
        }
    }

    class bd_create extends AsyncTask<Dieta, Dieta, String> {
        String TAG_SUCCESS = "success";
        JSONParser jParser = new JSONParser();
        JSONArray products = null;

        protected String doInBackground(Dieta... args) {
            Dieta create_dieta= (args[0]);
            String params = "";
            String url_servicio = acceso_BD.server+"ws.dieta/";           //nombre del servicio a consumir

            JSONObject jsonObject = new JSONObject();
            try {
                jsonObject.put("almuerzo", create_dieta.almuerzo);
                jsonObject.put("cena", create_dieta.cena);
                jsonObject.put("desayuno", create_dieta.desayuno);
                jsonObject.put("id", create_dieta.patologia+"");
                jsonObject.put("merienda", create_dieta.merienda);
                jsonObject.put("nombre", create_dieta.nombre);

            } catch (JSONException e) {
                e.printStackTrace();
            }
            params = jsonObject.toString();
            Log.d("Sentencia bd_create:", "..........................params: "+params);
            Log.d("Sentencia bd_create", url_servicio);
            try {
                jParser.makeHttpRequest(url_servicio, "POST", params);
            } catch (Exception e) {
                Log.d("Error de conexión", "------------------ERROR DE CONEXIÓN CON LA BASE DE DATOS --------------");
                e.printStackTrace();
            }
            return null;
        }
    }

    class bd_delete extends AsyncTask<Dieta, Dieta, String> {
        String TAG_SUCCESS = "success";
        JSONParser jParser = new JSONParser();
        JSONArray products = null;

        protected String doInBackground(Dieta... args) {
            Dieta delete_dieta= (args[0]);
            String params = "";
            String url_servicio = acceso_BD.server+"ws.dieta/";           //nombre del servicio a consumir
            String parametros = ""+delete_dieta.patologia+"";
            parametros=parametros.replace(" ","%20");
            url_servicio=url_servicio+parametros;
            Log.d("Sentencia bd_delete", url_servicio);
            try {
                JSONArray json = jParser.makeHttpRequest(url_servicio, "DELETE", params);
            } catch (Exception e) {
                e.printStackTrace();
                Log.d("Error de conexión", "------------------ERROR DE CONEXIÓN CON LA BASE DE DATOS --------------");
            }
            return null;
        }
    }

    class bd_update extends AsyncTask<Dieta, Dieta, String> {
        String TAG_SUCCESS = "success";
        JSONParser jParser = new JSONParser();
        JSONArray products = null;

        protected String doInBackground(Dieta... args) {
            Dieta create_dieta= (args[0]);
            String params = "";
            String url_servicio = acceso_BD.server+"ws.dieta/";           //nombre del servicio a consumir
            String parametros = create_dieta.patologia+"";                  // id de la entidad
            parametros=parametros.replace(" ","%20");
            url_servicio=url_servicio+parametros;
            Log.d("Sentencia bd_update", url_servicio);
            JSONObject jsonObject = new JSONObject();
            try {
                jsonObject.put("almuerzo", create_dieta.almuerzo);
                jsonObject.put("cena", create_dieta.cena);
                jsonObject.put("desayuno", create_dieta.desayuno);
                jsonObject.put("id", create_dieta.patologia+"");
                jsonObject.put("merienda", create_dieta.merienda);
                jsonObject.put("nombre", create_dieta.nombre);

            } catch (JSONException e) {
                e.printStackTrace();
            }
            params = jsonObject.toString();
            Log.d("Sentencia bd_update:", "..........................params: "+params);
            try {
                jParser.makeHttpRequest(url_servicio, "PUT", params);
            } catch (Exception e) {
                e.printStackTrace();
                Log.d("Error de conexión", "------------------ERROR DE CONEXIÓN CON LA BASE DE DATOS --------------");
            }
            return null;
        }
    }

}