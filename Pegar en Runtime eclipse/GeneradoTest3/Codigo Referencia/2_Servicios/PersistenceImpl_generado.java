package common.services.impl;				
	
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
import common.services.interfaces.Persistence;

public class PersistenceImpl<T>  implements Persistence<T>,Serializable{

	private Class<T> clazzTObject;
	
	public PersistenceImpl(Class<T> clazzTObject){
		this.clazzTObject=clazzTObject;
	}
	
	public PersistenceImpl(){
	}	

	@Override
	public ArrayList<T> findAll(){
		ArrayList<T> retorno = new ArrayList();
		try {
			retorno = (ArrayList) new ws_arraylist_findAll_void().execute().get();
		} catch (InterruptedException e) {
			e.printStackTrace();
		} catch (ExecutionException e) {
			e.printStackTrace();
		}
		return retorno;
	}
	
	class ws_arraylist_findAll_void extends AsyncTask<Void, Void, ArrayList<T>> {
		JSONParser jParser = new JSONParser();

		protected ArrayList<T> doInBackground(Void... args) { 
			String params = "";
			String url_servicio = acceso_BD.server+"ws.ws_arraylist_findAll_void/";
			JSONArray json_retorno = null;
			ArrayList<T> retorno = new ArrayList();

			try {
				json_retorno = jParser.makeHttpRequest(url_servicio, "POST", params);
				Log.d("Retorno : ", json_retorno.toString());
				for (int i = 0; i < json_retorno.length(); i++) {
					JSONObject c = json_retorno.getJSONObject(i);
					Gson gson = new Gson();
					Type collectionType = new TypeToken<PersistenceImpl<T>>(){}.getType();
					T objeto = gson.fromJson(c.toString(), collectionType);
					retorno.add(objeto);
				}
			} catch (Exception e) {
			Log.d("Error de conexion", "------------------ws_arraylist_findAll_void,ERROR DE CONEXION CON LA BASE DE DATOS --------------");
				e.printStackTrace();
			}
			return retorno;
		}
	}	

	@Override
	public void create(T obj){
		new ws_void_create_t().execute(obj);
	}
	
	class ws_void_create_t extends AsyncTask<T, Void, Void> {
		JSONParser jParser = new JSONParser();

		protected Void doInBackground(T... args) { 
			String params = "";
			String url_servicio = acceso_BD.server+"ws.ws_void_create_t/";
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
			Log.d("Sentencia:", "........................ws_void_create_t,..params: " + params);
			Log.d("Sentencia", url_servicio);
			try {
				jParser.makeHttpRequest(url_servicio, "POST", params);
			} catch (Exception e) {
			Log.d("Error de conexion", "------------------ws_void_create_t,ERROR DE CONEXION CON LA BASE DE DATOS --------------");
				e.printStackTrace();
			}
			return null;
		}
	}	

	@Override
	public void remove(T obj){
		new ws_Void_remove_T().execute(obj);
	}
	class ws_Void_remove_T extends AsyncTask<T, Void, Void> {
		JSONParser jParser = new JSONParser();

		protected Void doInBackground(T... args) { 
			String params = "";
			String url_servicio = acceso_BD.server+"ws.ws_Void_remove_T/";
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
			Log.d("Sentencia:", "........................ws_remove_T,..params: " + params);
			Log.d("Sentencia", url_servicio);
			try {
				jParser.makeHttpRequest(url_servicio, "POST", params);
			} catch (Exception e) {
			Log.d("Error de conexi󮢬 "------------------ws_remove_T,ERROR DE CONEXIԎ CON LA BASE DE DATOS --------------");
				e.printStackTrace();
			}
			return null;
		}
	}	

	@Override
	public void save(T obj){
		new ws_Void_save_T().execute(obj);
	}
	class ws_Void_save_T extends AsyncTask<T, Void, Void> {
		JSONParser jParser = new JSONParser();

		protected Void doInBackground(T... args) { 
			String params = "";
			String url_servicio = acceso_BD.server+"ws.ws_Void_save_T/";
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
			Log.d("Sentencia:", "........................ws_save_T,..params: " + params);
			Log.d("Sentencia", url_servicio);
			try {
				jParser.makeHttpRequest(url_servicio, "POST", params);
			} catch (Exception e) {
			Log.d("Error de conexi󮢬 "------------------ws_save_T,ERROR DE CONEXIԎ CON LA BASE DE DATOS --------------");
				e.printStackTrace();
			}
			return null;
		}
	}}	

	
