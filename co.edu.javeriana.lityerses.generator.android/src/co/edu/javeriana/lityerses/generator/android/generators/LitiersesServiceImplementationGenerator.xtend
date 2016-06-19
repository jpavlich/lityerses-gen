package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesServiceImplementationTemplate
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Service
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider

class LitiersesServiceImplementationGenerator extends SimpleGenerator<Service> {
	@Inject extension IQualifiedNameProvider

	override getFileName(Service e) {
		return e.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/"+ "impl" +"/" +e.name.toFirstUpper +"Impl"+ ".java"
	}

	override getOutputConfigurationName() {
		LitiersesGenerator.SERVICE_IMPL
	}
	
	override getTemplate() {
		return new LitiersesServiceImplementationTemplate
	}

}
