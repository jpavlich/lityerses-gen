package co.edu.javeriana.lityerses.generator.persistence.generators

import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.lityerses.generator.persistence.LityPersistenceGenerator
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import co.edu.javeriana.lityerses.generator.persistence.templates.LityEntityDatabaseTemplateServer
import java.util.List

class LityEntityDatabaseGeneratorServer extends SimpleGenerator<List<Entity>> {
	
	@Inject extension IQualifiedNameProvider

	override getOutputConfigurationName() {
		LityPersistenceGenerator.SCRIPT_SERVER
	}

	override protected getFileName(List<Entity> e) {
		//return e.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/"+ e.name +"__General__"+ ".java"
		return "script_entidades.sql"
	}

	override getTemplate() {
		return new LityEntityDatabaseTemplateServer

	}
	
}