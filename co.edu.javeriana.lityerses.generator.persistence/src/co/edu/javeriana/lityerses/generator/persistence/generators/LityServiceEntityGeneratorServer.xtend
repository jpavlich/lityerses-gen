package co.edu.javeriana.lityerses.generator.persistence.generators

import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.lityerses.generator.persistence.LityPersistenceGenerator
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import co.edu.javeriana.lityerses.generator.persistence.templates.LityServiceEntityTemplateServer

class LityServiceEntityGeneratorServer extends SimpleGenerator<Entity> {
	
	@Inject extension IQualifiedNameProvider

	override getOutputConfigurationName() {
		LityPersistenceGenerator.ENTITY_SERVER
	}

	override protected getFileName(Entity e) {
		//return e.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/"+ e.name +"__General__"+ ".java"
		return e.name+".java"
	}

	override getTemplate() {
		return new LityServiceEntityTemplateServer

	}
	
}