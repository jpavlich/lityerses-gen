package co.edu.javeriana.lityerses.generator.persistence.generators

import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.lityerses.generator.persistence.LityPersistenceGenerator
import co.edu.javeriana.lityerses.generator.persistence.templates.LityServiceGeneralTemplate
import co.edu.javeriana.isml.isml.Attribute
import org.eclipse.xtext.generator.IFileSystemAccess
import co.edu.javeriana.isml.isml.Type
import co.edu.javeriana.isml.isml.impl.PackageImpl
import co.edu.javeriana.isml.isml.impl.ServiceImpl

class LityServiceGeneralGenerator extends SimpleGenerator<Attribute> {
	
	override getOutputConfigurationName() {
		LityPersistenceGenerator.SERVICE_GENERAL
	}

	override protected getFileName(Attribute servicio_entity) {
		var servicio = servicio_entity.type.referencedElement
		for (param : servicio_entity.type.eContents){
			var entidad_parametro = ((param as Type).referencedElement)
			return (entidad_parametro.eContainer as PackageImpl).name.replace(".","/").toLowerCase + "/"+ "services" +"/" + entidad_parametro.name +"__"+servicio.name.toFirstUpper+"__"+ ".java"
		}
	}

	override getTemplate() {
		return new LityServiceGeneralTemplate

	}
	
	override execute(Attribute element, IFileSystemAccess fsa) {
		if(active) {
			//Sólo si el controlador invoca un servicio
			if(element.type.referencedElement instanceof ServiceImpl){
				val elementT = element as Attribute
				fsa.generateFile(elementT.fileName, fullOutputConfigurationName, getTemplate().toText(elementT)
				)
				System.err.println("Generated " + element.class.name + " with " + getClass().simpleName)
			}
		}
	}
	
	
}