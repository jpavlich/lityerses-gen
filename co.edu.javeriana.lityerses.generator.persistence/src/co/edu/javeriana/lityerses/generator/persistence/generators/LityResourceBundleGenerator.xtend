package co.edu.javeriana.lityerses.generator.persistence.generators

import co.edu.javeriana.lityerses.generator.persistence.LityPersistenceGenerator
import co.edu.javeriana.lityerses.generator.persistence.templates.ResourceBundleTemplate
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.ResourceBundle
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider

class LityResourceBundleGenerator extends SimpleGenerator<ResourceBundle> {
	@Inject extension IQualifiedNameProvider

	override getFileName(ResourceBundle rs) {
				return rs.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/" +rs.name + ".properties"
				
					}

	override getOutputConfigurationName() {
		//LityPersistenceGenerator.RESOURCE_BUNDLE
	}
	
	override getTemplate() {
		return new ResourceBundleTemplate
	}

}
