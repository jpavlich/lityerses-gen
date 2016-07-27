package co.edu.javeriana.lityerses.generator.persistence.templates


import co.edu.javeriana.isml.isml.Instance
import co.edu.javeriana.isml.isml.LiteralValue
import co.edu.javeriana.isml.isml.Parameter
import co.edu.javeriana.isml.isml.ParameterizedType

import co.edu.javeriana.isml.validation.TypeChecker
import com.google.inject.Inject
import co.edu.javeriana.isml.generator.common.SimpleTemplate
import co.edu.javeriana.isml.isml.Attribute
import co.edu.javeriana.isml.isml.Constraint
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.isml.isml.Enum
import co.edu.javeriana.isml.isml.Primitive
import co.edu.javeriana.isml.scoping.IsmlModelNavigation
import org.eclipse.xtext.naming.IQualifiedNameProvider

class LityServiceEntityTemplateServer extends SimpleTemplate<Entity> {
	@Inject extension TypeChecker
	/*Inyección de las clases auxiliares con metodos utilitarios*/
	@Inject extension IQualifiedNameProvider
	@Inject extension IsmlModelNavigation
	
	/*Metodo callback llamado previo a la ejecución del template*/
	override preprocess(Entity e) {
	
	}
	
	
	/*	Plantilla para generar entidades*/
	override def CharSequence template(Entity entity) '''
		package ws;
		«/*imports necesarios de libreria javax*/»
		«IF isDatePresent(entity)»
			import java.util.Date; 
		«ENDIF»
		import java.io.Serializable;
		import javax.persistence.Basic;
		import javax.persistence.Column;
		import javax.persistence.Entity;
		import javax.persistence.GeneratedValue;
		import javax.persistence.GenerationType;
		import javax.persistence.Id;
		import javax.persistence.NamedQueries;
		import javax.persistence.NamedQuery;
		import javax.persistence.Table;
		import javax.validation.constraints.Size;
		import javax.xml.bind.annotation.XmlRootElement;«
		/*Se imprimen los imports de las entidades padre */ »
		«FOR parent : entity.parents»
			«IF !parent.eContainer.eContainer.fullyQualifiedName.equals(entity.eContainer.fullyQualifiedName)»
				import «parent.typeSpecification.fullyQualifiedName»;
			«ENDIF»
		«ENDFOR»«
		/*se recorren e imprimen los tipos de datos necesarios */ »
		«FOR attribute : entity.attributes»
			«IF !(attribute.type.typeSpecification instanceof Primitive) || attribute.type.isCollection»
				«IF evaluateAttributeToImport(attribute,entity)»
					«IF attribute.type instanceof ParameterizedType»
					«IF !((attribute.type as ParameterizedType).typeParameters.get(0).typeSpecification instanceof Primitive)»
					import «(attribute.type as ParameterizedType).typeParameters.get(0).typeSpecification.fullyQualifiedName»;
					«ENDIF»
					«ELSE»
					import «attribute.type.typeSpecification.fullyQualifiedName»;
					«ENDIF»
				«ENDIF»
			«ENDIF»
		«ENDFOR»«
		/*Por medio de el metodo isArrayPresent se importa import java.util.List si hay listas presentes */ »		
		«IF entity.attributes.arrayPresent»
			import java.util.*;
		«ENDIF»«
		/*Se verfica si la entidad es padre*/ »
		«IF isParent(entity)»
			import javax.persistence.Inheritance;
			import javax.persistence.InheritanceType;
		«ENDIF»«
		/*Se verfica si la entidad es padre*/»
		«IF isParent(entity)»
		«ENDIF»
	
		«IF isSon(entity)»
		«ENDIF»
		@Entity
		@Table(name = "«entity.name.toLowerCase»")
		@XmlRootElement
		@NamedQueries({
			@NamedQuery(name = "«entity.name.toFirstUpper».findAll", query = "SELECT d FROM «entity.name.toFirstUpper» d"),
			@NamedQuery(name = "«entity.name.toFirstUpper».findById", query = "SELECT d FROM «entity.name.toFirstUpper» d WHERE d.id = :id"),
			«FOR Attribute attributes : entity.attributes SEPARATOR ','»«
				/*Se agregan las anotaciones segun los constaint definidos*/ »	
				«FOR constraint : attributes.constraints»			
						@«constraint.type.typeSpecification.typeSpecificationString.toFirstUpper»«constraint.parametersTemplate»
				«ENDFOR»
				«IF attributes.type.isCollection»
					private «getCollectionString(attributes.type as ParameterizedType)»<«(attributes.type as ParameterizedType).typeParameters.get(0).typeSpecification.typeSpecificationString»> «attributes.name»;
				«ELSE»
					@NamedQuery(name = "«entity.name.toFirstUpper».findBy«attributes.name.toFirstUpper»", query = "SELECT d FROM «entity.name.toFirstUpper» d WHERE d.«attributes.name.toLowerCase» = :«attributes.name.toLowerCase»")
				«ENDIF»
			«ENDFOR»
		})
		«/*Declaracion de la entidad, se agrega herencia y se implementa serializable*/ »
		public «IF entity.abstract»abstract«ENDIF» class «entity.name.toFirstUpper» «IF !entity.superTypes.empty»extends «entity.superTypes.get(0).typeSpecification.typeSpecificationString» «ENDIF»implements Serializable {
			«/*Se verifica si la entidad no tiene padres para generar el id*/ »
			private static final long serialVersionUID = 1L;
			
			«IF entity.parents.empty»
				@Id
				@GeneratedValue(strategy = GenerationType.IDENTITY)
				@Basic(optional = false)
				@Size(min = 1, max = 2147483647)
				@Column(name = "id")
				private String id;
			«ENDIF»«
			/*Se recorren los atributos de la entidad para verificar si son de tipo email, lista o tipos primitivos  */ »
			«FOR Attribute attributes : entity.attributes»«
				/*Se agregan las anotaciones segun los constaint definidos*/ »	
				«FOR constraint : attributes.constraints»			
						@«constraint.type.typeSpecification.typeSpecificationString.toFirstUpper»«constraint.parametersTemplate»
				«ENDFOR»
				«IF attributes.type.typeSpecification.typeSpecificationString.equalsIgnoreCase("email")»
					private String «attributes.name»;
				«ELSE»
					«IF attributes.type.isCollection»
					private «getCollectionString(attributes.type as ParameterizedType)»<«(attributes.type as ParameterizedType).typeParameters.get(0).typeSpecification.typeSpecificationString»> «attributes.name»;
					«ELSE»
					
					@Column(name = "«attributes.name»")
					private «attributes.type.typeSpecification.typeSpecificationString.toFirstUpper» «attributes.name»;
					«ENDIF»
				«ENDIF»
			«ENDFOR»
			«/*Constructor de la entidad */ »
			public «entity.name.toFirstUpper»(){
			}
			
			public «entity.name.toFirstUpper»(String id){
				this.id = id;
			}
			
			public String getId() {
				return id;
			}
	
			public void setId(String id) {
				this.id = id;
			}«
			/*Se recorren los atributos para verificar si existen relaciones 
			 * entre las entidades*/ »
			«FOR Attribute attribute : entity.attributes»				
				«attribute.associationAnnotation»«
				/*Se verifica el caso especial para los tipos email y se coloca como String en los metodos set y get*/ »
				«IF attribute.type.typeSpecification.typeSpecificationString.equalsIgnoreCase("email")»
					
					public String get«attribute.name.toFirstUpper»(){
						return «attribute.name»;
					}
					
					public void set«attribute.name.toFirstUpper»(String «attribute.name»){
						this.«attribute.name»=«attribute.name»;
					}				
				«ELSE»«
					/*Se agregan los metodos set y get a cada atributo de la entidad, verificando si son listas o tipos primitivos de datos */ »
					«IF attribute.type.isCollection»
							
							public «getCollectionString(attribute.type as ParameterizedType)»<«(attribute.type as ParameterizedType).typeParameters.get(0).typeSpecification.typeSpecificationString»> get«attribute.name.toFirstUpper»(){
								return «attribute.name»;
							}
							
							public void set«attribute.name.toFirstUpper»(«getCollectionString(attribute.type as ParameterizedType)»<«(attribute.type as ParameterizedType).typeParameters.get(0).typeSpecification.typeSpecificationString»> «attribute.name»){
								this.«attribute.name»=«attribute.name»;
							}
					«ELSE»  
							«IF attribute.type.typeSpecification instanceof Enum»@Enumerated«ENDIF»
							
							public «attribute.type.typeSpecification.typeSpecificationString.toFirstUpper» get«attribute.name.toFirstUpper»(){
								return «attribute.name»;
							}
							
							public void set«attribute.name.toFirstUpper»(«attribute.type.typeSpecification.typeSpecificationString.toFirstUpper» «attribute.name»){
								this.«attribute.name»=«attribute.name»;
							}
					«ENDIF»	
				«ENDIF»			
			«ENDFOR»
		«/*Se verifica que la entidad no tenga padres para encapsular el 
			 * id e incluir los metodos equals 
			 * y hashCode
			 */ »
			«IF entity.parents.empty»
			@Override
			public int hashCode() {
				int hash = 0;
				hash += (id != null ? id.hashCode() : 0);
				return hash;
			}
	
			@Override
			public boolean equals(Object object) {
				if (!(object instanceof «entity.name.toFirstUpper»)) {
					return false;
				}
				«entity.name.toFirstUpper» other = («entity.name.toFirstUpper») object;
				if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
					return false;
				}
				return true;
			}
	
			@Override
			public String toString() {
				return "ws.«entity.name.toFirstUpper»[ id=" + id + " ]";
			}
			«ENDIF»
		}
	'''
	
	
	
	def boolean evaluateAttributeToImport(Attribute attribute, Entity entity){
		var boolean needImport=false;
		if(!attribute.type.isCollection){
			needImport=!attribute.type.typeSpecification.eContainer.fullyQualifiedName.equals(entity.eContainer.fullyQualifiedName)
		} else {
			needImport=!(attribute.type as ParameterizedType).typeParameters.get(0).typeSpecification.eContainer.fullyQualifiedName.equals(entity.eContainer.fullyQualifiedName)
		}
		return needImport
	}
	
	def boolean isDatePresent(Entity entity){
		var boolean hasDate=false
		for(attr:entity.attributes){
			if(attr.type.typeSpecification instanceof Primitive && attr.type.typeSpecification.typeSpecificationString.equalsIgnoreCase("Date")){
				hasDate=true
			}
		}
		return hasDate
	}

	def CharSequence getParametersTemplate(Instance constraint) '''
		«IF !constraint.parameters.empty»
		(«FOR Parameter parameter : setParametersValue(
			(constraint.type.typeSpecification as Constraint).parameters, constraint.parameters) SEPARATOR ","»
			«parameter.name»=«IF parameter.type.typeSpecification.typeSpecificationString.equalsIgnoreCase("string")»"«(parameter.
			value as LiteralValue).literal»"«ELSE»«(parameter.
			value as LiteralValue).literal»«ENDIF»«ENDFOR»)
		 «ENDIF»	
	'''

 
	
	
}
