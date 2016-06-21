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
		/*
		var Map<String, Object> neededData = controller.getNeededAttributes
		controllerEntities = neededData.get("controllerEntities") as EList<Entity>
		entityToList = neededData.get("entityToList") as Entity
		neededAttributes = neededData.get("neededAttributes") as Map<String, Type>
		val controlledPages = controller.controlledPages
		val forViews = new ArrayList<ForView>()
		for (p : controlledPages) {
			forViews.addAll(p.eAllContents.filter(ForView).toIterable)

		}

		for (p : forViews) {

			val key = p.variable.name
			val value = p.variable.type
			println(key + "->" + value)
			neededAttributes.put(key, value)

		}
	*/
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
				
		import java.io.Serializable;
		import javax.inject.*;		
		import «controller.eContainer.fullyQualifiedName».util.JsfUtil;
		import javax.enterprise.context.*;		
		import java.util.*;
		import javax.faces.application.FacesMessage;
		import javax.faces.context.FacesContext;
		import javax.faces.bean.ManagedBean;
		import javax.annotation.PostConstruct;
		import javax.ejb.EJB;
		import org.primefaces.model.map.MapModel;
		import org.primefaces.model.map.DefaultMapModel;
		import org.primefaces.model.map.LatLng;
		import org.primefaces.model.map.Marker;
		import co.edu.javeriana.sesion.Query;
		import co.edu.javeriana.sesion.Convert;
		
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
