 package co.edu.javeriana.lityerses.generator.android.templates

import co.edu.javeriana.isml.generator.common.SimpleTemplate
import co.edu.javeriana.isml.isml.Action
import co.edu.javeriana.isml.isml.Controller
import co.edu.javeriana.isml.isml.Instance
import co.edu.javeriana.isml.isml.Page
import co.edu.javeriana.isml.isml.Show
import co.edu.javeriana.isml.scoping.IsmlModelNavigation
import com.google.inject.Inject
import java.util.HashMap
import java.util.List
import java.util.Map
import org.eclipse.emf.common.util.BasicEList
import org.eclipse.emf.common.util.EList
import org.eclipse.xtext.naming.IQualifiedNameProvider
import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.isml.isml.InformationSystem
import co.edu.javeriana.isml.isml.ViewInstance
import java.util.ArrayList

class LitiersesAndroidManifestTemplate extends SimpleTemplate<List<Controller>> {

	/*Inyección de las clases auxiliares con metodos utilitarios*/
	@Inject extension IsmlModelNavigation
	@Inject extension IQualifiedNameProvider
	
	Page page_inicio;
	List<Page> lista_paginas = new ArrayList<Page>()

	override preprocess(List<Controller> totalControllers) {
		
		//Busqueda de la pagina principal
		for (controller : totalControllers){
			for (method : controller.actions){
				if(method.name.equals("pagina_principal")){
					for (showline : method.showStatements){
						for (viewinstance : showline.eContents){
							if (viewinstance instanceof ViewInstance){
								page_inicio = (viewinstance as ViewInstance).type.referencedElement as Page
							}
						}
					}
				}
			}
		}
		
		//Lista de las paginas contenidas en los controladores
		for (controller : totalControllers){
			for (page : controller.controlledPages){
				if (!lista_paginas.contains(page) && !page.name.equals("AnyPage")){
					lista_paginas.add(page)
				}
			}	
		}		
	}
/**
 * Método que retorna una plantilla para el archivo faces-config que recibe como parámetro la lista de paginas.
 * 
 */
	override def CharSequence template(List<Controller> totalControllers) '''
		<?xml version="1.0" encoding="utf-8"?>
		
		<manifest xmlns:android="http://schemas.android.com/apk/res/android"
		    xmlns:tools="http://schemas.android.com/tools"
		    package="com.example.android.xyztouristattractions">
		
		    <uses-permission android:name="android.permission.INTERNET" />
		    <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
		    <uses-permission android:name="android.permission.WAKE_LOCK" />
		    <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" tools:node="remove" />
		    <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" tools:node="remove" />
		
		    <application
		        android:allowBackup="true"
		        android:icon="@mipmap/ic_launcher"
		        android:label="@string/app_name"
		        android:theme="@style/XYZAppTheme"
		        android:fullBackupContent="true">
		
		        <meta-data
		            android:name="com.google.android.geo.API_KEY"
		            android:value="AIzaSyAgU2dQt8hme554kXIiu64QFYN8ArBBf3M" />
		            
				«FOR p : lista_paginas»
					«IF p.equals(page_inicio)»
						<activity
						    android:name="«p?.eContainer?.fullyQualifiedName.toString(".")».«p.name»_Activity"
						    android:label="@string/app_name" >
						
						    <intent-filter>
						        <action android:name="android.intent.action.MAIN" />
						        <category android:name="android.intent.category.LAUNCHER" />
						    </intent-filter>
						</activity>
						
					«ELSE»
						«IF p.controller != null && !getShowActions(p).empty»	
							<activity
							    android:name="«p?.eContainer?.fullyQualifiedName.toString(".")».«p.name»_Activity"
							    android:label="@string/app_name"
							    android:theme="@style/XYZAppTheme.Detail"
							    android:parentActivityName="«page_inicio?.eContainer?.fullyQualifiedName.toString(".")».«page_inicio.name»_Activity" />
							    
						«ENDIF»
					«ENDIF»
				«ENDFOR»
		        <receiver android:name="com.litierses.Utilidades.UtilityReceiver" />
		
		        <service android:name="com.litierses.Utilidades.UtilityService" />
		
		        <meta-data android:name="com.google.android.gms.version"
		            android:value="@integer/google_play_services_version" />
		
		        <meta-data
		            android:name="com.example.android.xyztouristattractions.config.GlideConfiguration"
		            android:value="GlideModule"/>
		
		    </application>
		
		</manifest>
	'''

/**
	 * Este método obtiene las acciones que contienen statements de tipo Show de un Controlador dado
	 */
	def EList<Action> getShowActions(Controller controller) {
		var EList<Action> actions = new BasicEList
		for (action : controller.actions) {
			if (action.showStatements.toList.size >0)  {
				actions.add(action)
			}
		}
		return actions
	}
	def Map<String, String> getUniqueActions(Iterable<Show> showStmnts) {
		var Map<String, String> uniqueActions = new HashMap
		for (stmnt : showStmnts) {
			var String key = "goTo" + ((stmnt.expression as Instance).type.typeSpecification as Page).name
			if (!uniqueActions.containsKey(key)) {
				var String value = ((stmnt.expression as Instance).type.typeSpecification as Page).eContainer.
					fullyQualifiedName.toString("/") + "/" + ((stmnt.expression as Instance).type.typeSpecification as Page).name +
					".xhtml"
				uniqueActions.put(key, value);
			}
		}
		return uniqueActions;
	}

	
	


}
