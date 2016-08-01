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
import java.util.List

class LityEntityDatabaseTemplateServer extends SimpleTemplate<List<Entity>> {
	@Inject extension TypeChecker
	/*Inyección de las clases auxiliares con metodos utilitarios*/
	@Inject extension IQualifiedNameProvider
	@Inject extension IsmlModelNavigation
	
	/*Metodo callback llamado previo a la ejecución del template*/
	override preprocess(List<Entity> e) {
	
	}
	
	
	/*	Plantilla para generar entidades*/
	override def CharSequence template(List<Entity> list_entity) '''
	--Este script crea las tablas correspondientes a las entidades expresadas en el modelo ISML
	--Script para ejecutar en la base de datos Postgres
	«FOR entity : list_entity»
	
	/***********************************************************************/
	--ENTIDAD «entity.name.toUpperCase»
	/***********************************************************************/
	CREATE SEQUENCE SEC_«entity.name.toUpperCase»
		INCREMENT 1
		MINVALUE 1
		MAXVALUE 9223372036854775807
		START 1
		CACHE 1;
	
	CREATE TABLE «entity.name.toUpperCase»
	(
		id text NOT NULL DEFAULT nextval('SEC_«entity.name.toUpperCase»'::regclass),
		«FOR Attribute attributes : entity.attributes»
			«IF attributes.type.isCollection»
	  			--CREAR TABLA ASOCIADA PARA «attributes.name»
			«ELSE»
				«attributes.name» text,
			«ENDIF»
	  	«ENDFOR»
	  	
		CONSTRAINT id_«entity.name.toLowerCase»_key PRIMARY KEY (id)
	)
	WITH (
	  OIDS=FALSE
	);	
	«ENDFOR»
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
