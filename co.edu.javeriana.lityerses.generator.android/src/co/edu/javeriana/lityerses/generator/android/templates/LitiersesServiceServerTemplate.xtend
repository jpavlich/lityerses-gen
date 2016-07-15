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

class LitiersesServiceServerTemplate extends SimpleTemplate<Service> {

	@Inject extension IQualifiedNameProvider
	@Inject extension IsmlModelNavigation
	@Inject extension TypeChecker

	override def CharSequence template(Service service) '''
		package  ws.service;		
				
		import java.util.List;
		import javax.persistence.EntityManager;
		import javax.ws.rs.Consumes;
		import javax.ws.rs.POST;
		import javax.ws.rs.Path;
		import javax.ws.rs.Produces;

		«/*public abstract class «service.name.toFirstUpper»Facade«IF !service.genericTypeParameters.isEmpty»<«FOR param:service.genericTypeParameters SEPARATOR ','»«param.name»«ENDFOR»>«ENDIF» «IF !service.superTypes.empty»extends «service.superTypes.get(0).typeSpecification.name.toFirstUpper»«IF service.superTypes.get(0).typeSpecification instanceof Service»Impl«IF service.superTypes.get(0)instanceof ParameterizedType»<«FOR param: (service.superTypes.get(0)as ParameterizedType).typeParameters SEPARATOR ','»«param.writeType(true)»«ENDFOR»>«ENDIF»«ENDIF»«ENDIF» implements «service.name.toFirstUpper»«IF !service.genericTypeParameters.isEmpty»<«FOR param:service.genericTypeParameters SEPARATOR ','»«param.name»«ENDFOR»>«ENDIF»{*/» 
		public abstract class «service.name.toFirstUpper»Facade«IF !service.genericTypeParameters.isEmpty»<«FOR param:service.genericTypeParameters SEPARATOR ','»«param.name»«ENDFOR»>«ENDIF» «IF !service.superTypes.empty»extends «service.superTypes.get(0).typeSpecification.name.toFirstUpper»«IF service.superTypes.get(0).typeSpecification instanceof Service»Impl«IF service.superTypes.get(0)instanceof ParameterizedType»<«FOR param: (service.superTypes.get(0)as ParameterizedType).typeParameters SEPARATOR ','»«param.writeType(true)»«ENDFOR»>«ENDIF»«ENDIF»«ENDIF» {
			private Class<T> entityClass;
			
			public PersistenceFacade(Class<T> entityClass) {
			        this.entityClass = entityClass;
			    }
			
			protected abstract EntityManager getEntityManager();    
			
			«FOR feature : service.features»
				«IF feature instanceof Method»«
			/*VARIABLES: */
				val ParametroRetorno_tipoCompleto = (service.getReplacedType(feature.type).writeType(true)).replace("Array","ArrayList")»«
				val ParametroRetorno_tipo = (service.getReplacedType(feature.type).writeType(false)).replace("Array","ArrayList")»«
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
				@POST
				@Path("ws_«ParametroRetorno_tipo.toLowerCase»_«feature.name»_«ListaTipoParametrosEntrada_.toLowerCase»")
				«IF !(service.getReplacedType(feature.type).writeType(true)).equals("void")»
				@Produces({"application/json"})
				«ENDIF»
				«IF parametroEntrada==true»
				@Consumes({"application/json"})	
				«ENDIF»	
				public «(service.getReplacedType(feature.type).writeType(true)).replace("Array","List")» «feature.name»(«FOR parameter : feature.parameters SEPARATOR ','»«parameter.type.writeType(true)» «parameter.name.toFirstLower»«ENDFOR»){
				
					//Sección para implementar el método
					
					«IF !(service.getReplacedType(feature.type).writeType(true)).equals("void")»
					return null;
					«ENDIF»
					
				}
				
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
