package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesServiceServerTemplate
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Service
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider

class LitiersesServiceServerGenerator extends SimpleGenerator<Service> {
	@Inject extension IQualifiedNameProvider

	override getFileName(Service e) {
		return e.name.toFirstUpper + "Facade.java"
	}

	override getOutputConfigurationName() {
		LitiersesGenerator.SERVICE_SERVER
	}
	
	override getTemplate() {
		return new LitiersesServiceServerTemplate
	}

}
