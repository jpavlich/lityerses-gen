 package co.edu.javeriana.lityerses.generator.android.templates

import co.edu.javeriana.isml.generator.common.SimpleTemplate
import co.edu.javeriana.isml.isml.Attribute
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.isml.isml.GenericTypeSpecification
import co.edu.javeriana.isml.isml.Method
import co.edu.javeriana.isml.isml.ParameterizedType
import co.edu.javeriana.isml.isml.Primitive
import co.edu.javeriana.isml.isml.Service
import co.edu.javeriana.isml.isml.TypeSpecification
import co.edu.javeriana.isml.scoping.IsmlModelNavigation
import co.edu.javeriana.isml.validation.TypeChecker
import com.google.inject.Inject
import java.util.HashMap
import java.util.Map
import org.eclipse.xtext.naming.IQualifiedNameProvider
import org.eclipse.xtext.naming.QualifiedName

/**
 * Clase que retorna la implementación del servicio 
 * autor: john.olarte@javeriana.edu.co
 */

class LitiersesServiceImplementationTemplate extends SimpleTemplate<Service> {

	@Inject extension IQualifiedNameProvider
	@Inject extension IsmlModelNavigation
	@Inject extension TypeChecker
	
	boolean parametroEntrada

	/**
	 * Metodo que retorna la implementación de los servicios
	 * 
	 */
	override def CharSequence template(Service service) '''
		package «service.eContainer?.fullyQualifiedName.toLowerCase».impl;				

		«FOR entity : getNeededImportsInMethods(service).entrySet»
			import «entity.value.fullyQualifiedName»;
		«ENDFOR»
		«FOR parent : service.superTypes»
			«FOR entity : getNeededImportsInMethods(parent.typeSpecification).entrySet»
				import «entity.value.fullyQualifiedName»;
			«ENDFOR»
		«ENDFOR»
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
		«FOR superType:service.superTypes»
		import «superType.typeSpecification.fullyQualifiedName»Impl;
		«ENDFOR»
		import «service.eContainer?.fullyQualifiedName.toLowerCase».interfaces.«service.name.toFirstUpper»;
		
		public class «service.name.toFirstUpper»Impl«IF !service.genericTypeParameters.isEmpty»<«FOR param:service.genericTypeParameters SEPARATOR ','»«param.name»«ENDFOR»>«ENDIF» «IF !service.superTypes.empty»extends «service.superTypes.get(0).typeSpecification.name.toFirstUpper»«IF service.superTypes.get(0).typeSpecification instanceof Service»Impl«IF service.superTypes.get(0)instanceof ParameterizedType»<«FOR param: (service.superTypes.get(0)as ParameterizedType).typeParameters SEPARATOR ','»«param.writeType(true)»«ENDFOR»>«ENDIF»«ENDIF»«ENDIF» implements «service.name.toFirstUpper»«IF !service.genericTypeParameters.isEmpty»<«FOR param:service.genericTypeParameters SEPARATOR ','»«param.name»«ENDFOR»>«ENDIF»,Serializable{
		
			public String urlWebservice;
			«FOR gen:service.genericTypeParameters»
				public Class<«gen.name»> clazz«gen.name»Object;
			«ENDFOR»
			«FOR type : service.superTypes»	
				«FOR attr : type.typeSpecification.features»
					«IF attr instanceof Attribute»
						private «attr.type.writeType(true)» «attr.name.toFirstLower»;
					«ENDIF»
				«ENDFOR»
			«ENDFOR»
			«FOR attr : service.features»
				«IF attr instanceof Attribute»
					private «attr.type.writeType(true)» «attr.name.toFirstLower»;
				«ENDIF»
			«ENDFOR»
			
			«IF !service.genericTypeParameters.isEmpty»
			 «FOR gen:service.genericTypeParameters»
			«ENDFOR»
			public «service.name.toFirstUpper»Impl(«FOR gen:service.genericTypeParameters SEPARATOR ','»Class<«gen.name»> clazz«gen.name»Object«ENDFOR»){
				«FOR gen:service.genericTypeParameters»				
				this.clazz«gen.name»Object=clazz«gen.name»Object;
				«ENDFOR»
			}
			«ENDIF»
			
			public «service.name.toFirstUpper»Impl(){
				«FOR superType:service.superTypes»
				«IF superType instanceof ParameterizedType»
				super(«FOR param:superType.typeParameters SEPARATOR ','»«param.writeType(true)».class«ENDFOR»);
				«ENDIF»
				«ENDFOR»
			}
			«FOR feature : service.features»
				«IF feature instanceof Method»«
				/*VARIABLES: */
					var ParametroRetorno_tipoCompleto = (service.getReplacedType(feature.type).writeType(true)).replace("Array","ArrayList")»«
					var ParametroRetorno_tipo = (service.getReplacedType(feature.type).writeType(false)).replace("Array","ArrayList")»«
					var Retorno_tipo_simple = false»«
					var inicializacion = ""»«
					var ListaTipoParametrosEntrada = ''»«
					var ListaTipoParametrosEntrada_ = ''»«
					var ListaNombreParametrosEntrada = ''»«
					var ListaParametrosEntrada = ''»«
					var parametroEntrada = false»«
						»«var tempInicio=true  »«
						»«for (parameter : feature.parameters) {
							if (!tempInicio==true){
								ListaTipoParametrosEntrada=ListaTipoParametrosEntrada+','
								ListaTipoParametrosEntrada_=ListaTipoParametrosEntrada_+','
								ListaNombreParametrosEntrada =ListaNombreParametrosEntrada+','
								ListaParametrosEntrada =ListaParametrosEntrada+','
								
							}
							else{
								tempInicio=false
							}
							parametroEntrada = true
							ListaTipoParametrosEntrada=ListaTipoParametrosEntrada+parameter.type.writeType(true)
							ListaTipoParametrosEntrada_=ListaTipoParametrosEntrada_+parameter.type.writeType(true)
							ListaNombreParametrosEntrada=ListaNombreParametrosEntrada+parameter.name.toFirstLower
							ListaParametrosEntrada=ListaParametrosEntrada+parameter.type.writeType(true)+' '+parameter.name.toFirstLower
								
						}»«for (var i=0; i<1;i++){if (parametroEntrada==false){
							ListaTipoParametrosEntrada = 'Void'
							ListaTipoParametrosEntrada_ = 'Void'}}»«
				/*VARIABLES: */
					»
					
				@Override
				«for (var i=0; i<1;i++) { /*tipo de dato de retorno */
					//if (service.getReplacedType(feature.type) instanceof Entity || (service.getReplacedType(feature.type).collection)) 
					if (ParametroRetorno_tipoCompleto.equals("Boolean")||ParametroRetorno_tipoCompleto.equals("String")||ParametroRetorno_tipoCompleto.equals("Long")||ParametroRetorno_tipoCompleto.equals("Int"))
					{
						Retorno_tipo_simple = true
						ParametroRetorno_tipoCompleto = ParametroRetorno_tipoCompleto.toLowerCase
						ParametroRetorno_tipo = ParametroRetorno_tipo.toLowerCase
						switch (ParametroRetorno_tipo) {
							case "int": inicializacion = "0"
							case "boolean": inicializacion = "false"
							case "long": inicializacion = "0"
							case "string": inicializacion = "" 
						}
						
						switch (ParametroRetorno_tipo) {
							case "int": ParametroRetorno_tipoCompleto = "Integer"
							case "boolean": ParametroRetorno_tipoCompleto = "Boolean"
							case "long": ParametroRetorno_tipoCompleto = "Long"
							case "string": ParametroRetorno_tipoCompleto = "String" 
						}
						
						
					}
				} 
				»
				«IF Retorno_tipo_simple == true»
				public «ParametroRetorno_tipo» «feature.name»(«ListaParametrosEntrada»){
				«ELSE»
				public «ParametroRetorno_tipoCompleto» «feature.name»(«ListaParametrosEntrada»){
				«ENDIF»	
				«IF !feature.body.empty»
				«ENDIF»
					«IF !feature.type.typeSpecification.name.equalsIgnoreCase("Void")»
						«IF Retorno_tipo_simple == true»
							«ParametroRetorno_tipo» retorno = «inicializacion»;
						«ELSE»
							«ParametroRetorno_tipoCompleto» retorno = new «ParametroRetorno_tipo»();	
						«ENDIF»
						try{
							retorno = («ParametroRetorno_tipo») new ws_«ParametroRetorno_tipo.toLowerCase»_«feature.name»_«ListaTipoParametrosEntrada_.toLowerCase»().execute(«ListaNombreParametrosEntrada»).get();
						} catch (InterruptedException e) {
							e.printStackTrace();
						} catch (ExecutionException e) {
							e.printStackTrace();
						}	
						return retorno;
					«ELSE»
						new ws_«ParametroRetorno_tipo.toLowerCase»_«feature.name»_«ListaTipoParametrosEntrada_.toLowerCase»().execute(«ListaNombreParametrosEntrada»);
					«ENDIF»«
		/*Clase Asincrona */»
				}
				
				class ws_«ParametroRetorno_tipo.toLowerCase»_«feature.name»_«ListaTipoParametrosEntrada_.toLowerCase» extends AsyncTask<«ListaTipoParametrosEntrada», Void,«ParametroRetorno_tipoCompleto.toFirstUpper»> {
					JSONParser jParser = new JSONParser();
					
					protected «ParametroRetorno_tipoCompleto.toFirstUpper» doInBackground(«ListaTipoParametrosEntrada»... args) {
						String params = "";
						String url_servicio = urlWebservice+"ws_«ParametroRetorno_tipo.toLowerCase»_«feature.name»_«ListaTipoParametrosEntrada_.toLowerCase»/";
						Log.d("Sentencia", url_servicio);
						JSONArray json_retorno = null;
						«//SI HAY PARAMETROS DE ENTRADA
						IF parametroEntrada==true»
						«ListaTipoParametrosEntrada_» parametro_entrada= (args[0]); 
						JSONObject jsonObject = new JSONObject();
						try {
							Gson gson = new Gson();
							jsonObject = new JSONObject (gson.toJson(parametro_entrada));
						} catch (JSONException e) {
							e.printStackTrace();
						}
						params = jsonObject.toString();
						Log.d("Sentencia:", "........................ws_«ParametroRetorno_tipo.toLowerCase»_«feature.name»_«ListaTipoParametrosEntrada_.toLowerCase»,..params: " + params);
						«ENDIF»
						«// SI HAY PARAMETROS PARA RETORNAR
						IF !ParametroRetorno_tipo.equals("void")»
							«IF Retorno_tipo_simple == true»
								«ParametroRetorno_tipo» retorno = «inicializacion»;
							«ELSE»
								«ParametroRetorno_tipoCompleto» retorno = new «ParametroRetorno_tipo»();
							«ENDIF»	
						«ENDIF»
						try {
							«IF ParametroRetorno_tipo.equals("void")»	
							jParser.makeHttpRequest(url_servicio, "POST", params);
							«ELSE»
								«IF Retorno_tipo_simple == false»
									json_retorno = jParser.makeHttpRequest(url_servicio, "POST", params);
									Log.d("Retorno : ", json_retorno.toString());
									for (int i = 0; i < json_retorno.length(); i++) {
										JSONObject c = json_retorno.getJSONObject(i);
										Gson gson = new Gson();
										Type retornoType = (Type) clazzTObject;
										T objeto = gson.fromJson(c.toString(),retornoType);
										retorno.add(objeto);
									}
								«ELSE»
									retorno = «ParametroRetorno_tipoCompleto».parse«ParametroRetorno_tipoCompleto»(jParser.makeHttpRequest_TextPlain(url_servicio, "POST", params));
									Log.d("Retorno : ", retorno+"");
								«ENDIF»	
							«ENDIF»
						} catch (Exception e) {
							Log.d("Error de conexion", "------------------ws_«ParametroRetorno_tipo.toLowerCase»_«feature.name»_«ListaTipoParametrosEntrada_.toLowerCase»,ERROR DE CONEXION CON LA BASE DE DATOS --------------");
							e.printStackTrace();
						}
						«// SI NO HAY PARAMETROS PARA RETORNAR
						IF ParametroRetorno_tipo.equals("void")»
						return null;
						«ELSE»
						return retorno;
						«ENDIF»
					}		
				}
				«ELSE»
					«IF feature instanceof Attribute»
						@Override						
						public «(service.getReplacedType(feature.type).writeType(true)).replace("Array","ArrayList")» get«feature.name.toFirstUpper»(){
							return «feature.name.toFirstLower»;
						}
						
						@Override
						public void set«feature.name.toFirstUpper»(«(service.getReplacedType(feature.type).writeType(true)).replace("Array","ArrayList")» «feature.name.toFirstLower»){
							this.«feature.name.toFirstLower»=«feature.name.toFirstLower»;
						}
					«ENDIF»
				«ENDIF»
			«ENDFOR»		
		}	
	'''
/**
 * 

 * 
 */
	def Map<QualifiedName,TypeSpecification> getNeededImportsInMethods(TypeSpecification service) {
		var Map<QualifiedName,TypeSpecification> imports = new HashMap
		for (feature : service.features) {
			if (!feature.type.isCollection) {
				if (feature.type != null && !feature.type.typeSpecification.eContainer.fullyQualifiedName.equals(
					service.eContainer.fullyQualifiedName)) {
					if (!(feature.type.typeSpecification instanceof Primitive)) {
						if (!(feature.type.typeSpecification instanceof GenericTypeSpecification)){
							if(!imports.containsKey(feature.type.typeSpecification.fullyQualifiedName)){
								imports.put(feature.type.typeSpecification.fullyQualifiedName,feature.type.typeSpecification)					
							}						
						}
					}
				}			
			}else {
				if (feature.type instanceof ParameterizedType) {
					if (feature.type != null && !(feature.type as ParameterizedType).typeParameters.get(0).
						typeSpecification.eContainer.fullyQualifiedName.equals(service.eContainer.fullyQualifiedName)) {
						if (!((feature.type as ParameterizedType).typeParameters.get(0).typeSpecification instanceof Primitive)) {
							if (!((feature.type as ParameterizedType).typeParameters.get(0).typeSpecification instanceof GenericTypeSpecification)){
								if(!imports.containsKey((feature.type as ParameterizedType).typeParameters.get(0).typeSpecification.fullyQualifiedName)){
									imports.put((feature.type as ParameterizedType).typeParameters.get(0).typeSpecification.fullyQualifiedName,
										(feature.type as ParameterizedType).typeParameters.get(0).typeSpecification)
									
								}							
							}
						}
					}
				}
			}
			if (feature instanceof Method) {				
				for (param : feature.parameters) {					
					if (!param.type.isCollection) {
						if (!param.type.typeSpecification.eContainer.fullyQualifiedName.equals(
							service.eContainer.fullyQualifiedName)) {
							if (!(param.type.typeSpecification instanceof Primitive)) {
								if (!(param.type.typeSpecification instanceof GenericTypeSpecification)) {
									if(!imports.containsKey(param.type.typeSpecification.fullyQualifiedName)){
										imports.put(param.type.typeSpecification.fullyQualifiedName,param.type.typeSpecification)							
									}								
								}
							}
						}						
					} else {
						if (param.type instanceof ParameterizedType) {
							if (!(param.type as ParameterizedType).typeParameters.get(0).typeSpecification.eContainer.
								fullyQualifiedName.equals(service.eContainer.fullyQualifiedName)) {
								if (!((param.type as ParameterizedType).typeParameters.get(0).typeSpecification instanceof Primitive)) {
									if (!((param.type as ParameterizedType).typeParameters.get(0).typeSpecification instanceof GenericTypeSpecification)) {
										if(!imports.containsKey((param.type as ParameterizedType).typeParameters.get(0).typeSpecification.fullyQualifiedName)){
											imports.put((param.type as ParameterizedType).typeParameters.get(0).typeSpecification.fullyQualifiedName,
												(param.type as ParameterizedType).typeParameters.get(0).typeSpecification as Entity)											
										}									
									}
								}
							}
						}
					}									
				}
				if(feature.body!=null){
					for(stmnt:feature.body){
						isNeededImportInBody(stmnt.eAllContents.toList,imports,service)
					}				
				}
			}
		}
		return imports
	}
	
	
	
	
}
