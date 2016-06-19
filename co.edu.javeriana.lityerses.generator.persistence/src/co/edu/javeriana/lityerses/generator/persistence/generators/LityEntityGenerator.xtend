package co.edu.javeriana.lityerses.generator.persistence.generators

import co.edu.javeriana.lityerses.generator.persistence.LityPersistenceGenerator
import co.edu.javeriana.lityerses.generator.persistence.templates.LityEntityTemplate
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Entity
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider

class LityEntityGenerator extends SimpleGenerator<Entity> {
	@Inject extension IQualifiedNameProvider

	override getFileName(Entity e) {
		return e.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/" + e.name + ".java"
	}

	override getOutputConfigurationName() {
		LityPersistenceGenerator.ENTITIES
	}
	
	override getTemplate() {
		return new LityEntityTemplate

	}

}
