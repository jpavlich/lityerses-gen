 package co.edu.javeriana.lityerses.generator.persistence.templates

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

class LityServiceGeneralTemplateService extends SimpleTemplate<Entity> {

	@Inject extension IQualifiedNameProvider
	@Inject extension IsmlModelNavigation
	@Inject extension TypeChecker

	override preprocess(Entity service) {
	}

	

	// TODO Implement hashCode and equals, based in the unique keys of the entity
	/*	@«constraint.type.typeSpecification.typeSpecificationString»(«FOR Expression ex : constraint.parameters SEPARATOR ","»«ex.toString.length»«ENDFOR»)*/
	override def CharSequence template(Entity entity) '''
		package ws.service;				
		
		import java.util.List;
		import javax.ejb.Stateless;
		import javax.persistence.EntityManager;
		import javax.persistence.PersistenceContext;
		import javax.ws.rs.Consumes;
		import javax.ws.rs.POST;
		import javax.ws.rs.Path;
		import javax.ws.rs.PathParam;
		import javax.ws.rs.Produces;
		import ws.«entity.name.toFirstUpper»;		
		«FOR entiti : getNeededImportsInMethods(entity).entrySet»
			import «entiti.value.fullyQualifiedName»; 
		«ENDFOR»
		
		@Stateless
		@Path("ws.persistence_«entity.name.toLowerCase»")
		public class Persistence_«entity.name.toFirstUpper»_ extends PersistenceFacade<«entity.name.toFirstUpper»> {
			@PersistenceContext(unitName = "webservicesPU")
			private EntityManager em;
			
			public Persistence_«entity.name.toFirstUpper»_(){
			        super(«entity.name.toFirstUpper».class);
			}
			
			@Override
			protected EntityManager getEntityManager() {
				return em;
			}
		}	
	'''

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
