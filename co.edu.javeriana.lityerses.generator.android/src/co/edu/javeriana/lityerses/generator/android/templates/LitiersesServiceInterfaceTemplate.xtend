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
 * Clase que genera la interfaz del servicio
 * autor:john.olarte@javeriana.edu.co
 */
class LitiersesServiceInterfaceTemplate extends SimpleTemplate<Service> {

	@Inject extension IQualifiedNameProvider
	@Inject extension IsmlModelNavigation
	@Inject extension TypeChecker

/**
 * Metodo que retorna la plantilla de la interfaz del servicio
 * 
 */ 
	override def CharSequence template(Service service) '''
		package «service.eContainer?.fullyQualifiedName.toLowerCase».interfaces;		
		
		«FOR entity : getNeededImportsInMethods(service).entrySet»
			import «entity.value.fullyQualifiedName»;
		«ENDFOR»
		«FOR parent : service.superTypes»
			«FOR entity : getNeededImportsInMethods(parent.typeSpecification).entrySet»
				import «entity.value.fullyQualifiedName»;
			«ENDFOR»
		«ENDFOR»
		import java.util.*;
		«FOR superType:service.superTypes»
		import «superType.typeSpecification.fullyQualifiedName»;
		«ENDFOR»
		
		public interface «service.name.toFirstUpper»«IF !service.genericTypeParameters.empty»<«FOR param:service.genericTypeParameters SEPARATOR ','»«param.name»«ENDFOR»>«ENDIF» «IF !service.superTypes.empty»extends «service.superTypes.get(0).typeSpecification.typeSpecificationString.toFirstUpper»«IF service.superTypes.get(0)instanceof ParameterizedType»<«FOR param: (service.superTypes.get(0)as ParameterizedType).typeParameters SEPARATOR ','»«param.writeType(true)»«ENDFOR»>«ENDIF»«ENDIF»{
			
			«FOR feature : service.features»
				«IF feature instanceof Method»
					«var tipo_retorno = (service.getReplacedType(feature.type).writeType(true)).replace("Array","ArrayList")»
					«for (var i=0; i<1;i++) { /*tipo de dato de retorno */
						if (service.getReplacedType(feature.type) instanceof Entity || (service.getReplacedType(feature.type).collection)) 
							{tipo_retorno = tipo_retorno}
						else
						{tipo_retorno = tipo_retorno.toLowerCase}
					} 
					»
					public «tipo_retorno» «feature.name»(«FOR parameter : feature.parameters SEPARATOR ','»«parameter.type.writeType(true)» «parameter.name.toFirstLower»«ENDFOR»);
				«ELSE»
					«IF feature instanceof Attribute»
						public «service.getReplacedType(feature.type).writeType(true)» get«feature.name.toFirstUpper»();
						
						public void set«feature.name.toFirstUpper»(«service.getReplacedType(feature.type).writeType(true)» «feature.name.toFirstLower»);
					«ENDIF»
				«ENDIF»				
			«ENDFOR»	
		}	
		
	'''
 /**
  * 
  *
  *  Metodo que obtiene las dependencias necesarias de los servicios 
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
