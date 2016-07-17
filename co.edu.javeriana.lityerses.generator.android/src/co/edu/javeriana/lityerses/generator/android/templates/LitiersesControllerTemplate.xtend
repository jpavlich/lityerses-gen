package co.edu.javeriana.lityerses.generator.android.templates

import co.edu.javeriana.isml.generator.common.SimpleTemplate
import co.edu.javeriana.isml.isml.ActionCall
import co.edu.javeriana.isml.isml.Controller
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.isml.isml.For
import co.edu.javeriana.isml.isml.ForView
import co.edu.javeriana.isml.isml.If
import co.edu.javeriana.isml.isml.Parameter
import co.edu.javeriana.isml.isml.ParameterizedType
import co.edu.javeriana.isml.isml.Primitive
import co.edu.javeriana.isml.isml.Return
import co.edu.javeriana.isml.isml.Show
import co.edu.javeriana.isml.isml.Type
import co.edu.javeriana.isml.isml.While
import co.edu.javeriana.isml.scoping.IsmlModelNavigation
import co.edu.javeriana.isml.validation.TypeChecker
import com.google.inject.Inject
import java.util.ArrayList
import java.util.HashMap
import java.util.Map
import java.util.Map.Entry
import org.eclipse.emf.common.util.EList
import org.eclipse.xtext.naming.IQualifiedNameProvider
import co.edu.javeriana.isml.isml.MethodStatement
import co.edu.javeriana.isml.isml.Instance
import co.edu.javeriana.isml.isml.NullValue

/**
 * Clase para la generación de controladores en la plataforma Java.
 * autor: john.olarte@javeriana.edu.co
 */

class LitiersesControllerTemplate extends SimpleTemplate<Controller> {

	//Inyección de clases utilitarias
	@Inject extension IQualifiedNameProvider
	@Inject extension IsmlModelNavigation
	@Inject extension TypeChecker
	@Inject extension ExpressionTemplate
	@Inject extension StatementTemplate
	var EList<Entity> controllerEntities
	var Entity entityToList
	var Map<String, Type> neededAttributes = new HashMap

	
	/**
	 * Metodo para precargar los atributos y dependencias necesarias
	 * para el controlador
	 *
	 */
	override preprocess(Controller controller) {

	}
	
	


/**
 * 
 * Metodo que retorna la plantilla del controlador generado
 * 
 */
	override def CharSequence template(
		Controller controller
	) '''
				package «controller.eContainer.fullyQualifiedName»;
						
				import android.app.Activity;
				
				«FOR entity : getNeededImportsInActions(controller).entrySet»
					«IF  entity.value.class.simpleName=="EntityImpl" && entity.value.typeSpecificationString != "Query" && entity.value.typeSpecificationString != "Convert"»
					import «entity.value.eContainer.fullyQualifiedName».services.«entity.value.name»__General__;
					import «entity.value.eContainer.fullyQualifiedName».«entity.value.name»;
					«ENDIF»
					«IF  entity.value.class.simpleName=="PageImpl" && entity.value.typeSpecificationString != "Query" && entity.value.typeSpecificationString != "Convert"»
					import «entity.value.eContainer.fullyQualifiedName».«entity.value.name»_Activity;
					«ENDIF»
				«ENDFOR»
				import java.util.ArrayList;
				
				public class «controller.name.toFirstUpper» {
					
					«FOR method : controller.actions /* Se declaran los metodos relacionados como acciones del controlador*/»
									public static void «method.name»(Activity activity«FOR param : method.parameters SEPARATOR ','»«IF param.type.collection» ,ArrayList <«param.type.containedTypeSpecification.name»>  «param.name.toFirstLower»«ELSE» , «param.type.typeSpecification.typeSpecificationString.toFirstUpper» «param.name.toFirstLower»«ENDIF»«ENDFOR»){
										«writeStatements(method.body)»	
									}
								«ENDFOR»
									
									«/* Se los metodos set y get para los atributos declarados respectivamente*/»
									«FOR attr : neededAttributes.entrySet»
										«IF attr.value.isCollection»
											/**
											 * Returns the current value for the attribute «attr.key»
											 *
											 * @return current instance for «attr.key.toFirstLower» attribute
											 */
											public «getCollectionString(attr.value as ParameterizedType)»<«(attr.value as ParameterizedType).typeParameters.get(0).typeSpecification.typeSpecificationString»> get«attr.key.toFirstUpper»(){						
												return «attr.key.toFirstLower»;
											}
											
											/**
											 * Sets the value for the attribute «attr.key»
											 * @param «attr.key.toFirstLower» The value to set
											 */
											public void set«attr.key.toFirstUpper»(«getCollectionString(attr.value as ParameterizedType)»<«(attr.value as ParameterizedType).typeParameters.get(0).typeSpecification.typeSpecificationString»> «attr.key.toFirstLower»){
												this.«attr.key.toFirstLower»=«attr.key.toFirstLower»;
											}
										«ELSE»
											/**
											 * Returns the current value for the attribute «attr.key»
											 * @return current instance for «attr.key.toFirstLower» attribute
											 */
											public «attr.value.typeSpecification.typeSpecificationString.toFirstUpper» get«attr.key.toFirstUpper»(){
												return «attr.key.toFirstLower»;
											}
											
											/**
											 * Sets the value for the attribute «attr.key»
											 * @param «attr.key.toFirstLower» The value to set
											 */
											public void set«attr.key.toFirstUpper»(«attr.value.typeSpecification.typeSpecificationString.toFirstUpper» «attr.key.toFirstLower»){
												this.«attr.key.toFirstLower»=«attr.key.toFirstLower»;
											}
										«ENDIF»
									«ENDFOR»
					«FOR service : controller.services»
						public «IF service.type.typeSpecification.typeSpecificationString == "Persistence"» static «FOR param: (service.type as ParameterizedType).typeParameters SEPARATOR ','»«param.writeType(true)»«ENDFOR»«'__General__'»«ELSE» «service.type.typeSpecification.typeSpecificationString.toFirstUpper»«ENDIF» «IF service.name != null»get«service.name.toFirstUpper»«ELSE»get«service.type.typeSpecification.
							name.toFirstUpper»«ENDIF»(){
							«IF service.type.typeSpecification.typeSpecificationString == "Persistence"» 
							return new «FOR param: (service.type as ParameterizedType).typeParameters SEPARATOR ','»«param.writeType(true)»«ENDFOR»«'__General__'»();
							«ELSE»
							return «IF service.name != null»«service.name.toFirstLower»«ELSE»«service.name.toFirstLower»«ENDIF»;
							«ENDIF»
						}
						«IF service.type.typeSpecification.typeSpecificationString != "Persistence"»
							public void «IF service.name != null»set«service.name.toFirstUpper»«ELSE»set«service.
						name.toFirstUpper»«ENDIF»(«IF service.type.typeSpecification.typeSpecificationString == "Persistence"» «FOR param: (service.type as ParameterizedType).typeParameters SEPARATOR ','»«param.writeType(true)»«ENDFOR»«'__General__'»«ELSE» «service.type.typeSpecification.typeSpecificationString.toFirstUpper»«ENDIF»  «IF service.name != null»«service.name.toFirstLower»«ELSE»set«service.
						name.toFirstLower»«ENDIF»){
							this.«IF service.name != null»«service.name.toFirstLower»«ELSE»«service.
						name.toFirstLower»«ENDIF»=«IF service.name != null»«service.name.toFirstLower»«ELSE»«service.
						name.toFirstLower»«ENDIF»;
							} 
						«ENDIF»
					«ENDFOR»
				
				}
		'''
		
	
	/**
	 *
	 * Metodo para obtener los parametros y su tipo de especificacion 
	 */
	def Entry<String, Type> obtainAttribute(Parameter parameter) {
		for (entry : neededAttributes.entrySet) {
			if (entry.value.typeSpecification.typeSpecificationString.equalsIgnoreCase(
				parameter.type.typeSpecification.typeSpecificationString)) {
				return entry
			}
		}
		return null
	}

	
	/**
	 * 
	 * Método para obtener sentencias de return de una acción del controlador
	 */
	def boolean actionRequiresReturnSentence(EList<?> body) {
		var boolean requires = true
		if (body != null) {
			for (stmnt : body) {
				if (stmnt instanceof Show || stmnt instanceof ActionCall || stmnt instanceof Return) {
					requires = false
				} else if (stmnt instanceof If) {
					requires = actionRequiresReturnSentence(stmnt.body)
					if (stmnt.elseBody != null) {
						requires = actionRequiresReturnSentence(stmnt.elseBody)
					}
				} else if (stmnt instanceof While) {
					requires = actionRequiresReturnSentence(stmnt.body)
				} else if (stmnt instanceof For) {
					requires = actionRequiresReturnSentence(stmnt.body)
				}
			}
		}

		return requires;
	}

}
