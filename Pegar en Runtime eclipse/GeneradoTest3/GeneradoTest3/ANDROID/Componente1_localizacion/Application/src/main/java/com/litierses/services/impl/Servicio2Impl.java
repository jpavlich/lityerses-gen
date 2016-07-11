package com.litierses.services.impl;				

import java.util.*;
import android.os.AsyncTask;
import android.util.Log;
import java.io.Serializable;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.litierses.Utilidades.JSONParser;
import com.litierses.Utilidades.acceso_BD;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import java.lang.reflect.Type;
import java.util.concurrent.ExecutionException;
import com.litierses.services.interfaces.Servicio2;

public class Servicio2Impl<T>  implements Servicio2<T>,Serializable{

	public String urlWebservice;
	public Class<T> clazzTObject;
	
	public Servicio2Impl(Class<T> clazzTObject){
		this.clazzTObject=clazzTObject;
	}
	
	public Servicio2Impl(){
	}
		
	@Override
	public void remove(T obj){
		new ws_void_remove_t().execute(obj);
	}
	
	class ws_void_remove_t extends AsyncTask<T, Void,Void> {
		JSONParser jParser = new JSONParser();
		
		protected Void doInBackground(T... args) {
			String params = "";
			String url_servicio = urlWebservice+"ws.ws_void_remove_t/";
			JSONArray json_retorno = null;
			T parametro_entrada= (args[0]); 
			JSONObject jsonObject = new JSONObject();
			try {
				Gson gson = new Gson();
				jsonObject = new JSONObject (gson.toJson(parametro_entrada));
			} catch (JSONException e) {
				e.printStackTrace();
			}
			params = jsonObject.toString();
			Log.d("Sentencia:", "........................ws_void_remove_t,..params: " + params);
			Log.d("Sentencia", url_servicio);
			try {
				jParser.makeHttpRequest(url_servicio, "POST", params);
			} catch (Exception e) {
				Log.d("Error de conexion", "------------------ws_void_remove_t,ERROR DE CONEXION CON LA BASE DE DATOS --------------");
				e.printStackTrace();
			}
			return null;
		}		
	}
}	
