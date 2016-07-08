package co.edu.javeriana.lityerses.generator.persistence.generators

import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.lityerses.generator.persistence.LityPersistenceGenerator
import co.edu.javeriana.lityerses.generator.persistence.templates.LityServiceGeneralTemplateService
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider

class LityServiceGeneralGeneratorServer extends SimpleGenerator<Entity> {
	
	@Inject extension IQualifiedNameProvider

	override getOutputConfigurationName() {
		LityPersistenceGenerator.SERVICE_SERVER
	}

	override protected getFileName(Entity e) {
		//return e.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/"+ e.name +"__General__"+ ".java"
		return "Persistence_"+e.name +"_"+ ".java"
	}

	override getTemplate() {
		return new LityServiceGeneralTemplateService

	}
	
}