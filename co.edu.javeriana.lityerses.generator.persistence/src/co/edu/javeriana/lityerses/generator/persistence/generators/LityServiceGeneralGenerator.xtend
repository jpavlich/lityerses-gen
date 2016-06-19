package co.edu.javeriana.lityerses.generator.persistence.generators

import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.lityerses.generator.persistence.LityPersistenceGenerator
import co.edu.javeriana.lityerses.generator.persistence.templates.LityServiceGeneralTemplate
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider

class LityServiceGeneralGenerator extends SimpleGenerator<Entity> {
	
	@Inject extension IQualifiedNameProvider

	override getOutputConfigurationName() {
		LityPersistenceGenerator.SERVICE_GENERAL
	}

	override protected getFileName(Entity e) {
		return e.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/"+ "services" +"/" + e.name +"__General__"+ ".java"
	}

	override getTemplate() {
		return new LityServiceGeneralTemplate

	}
	
}