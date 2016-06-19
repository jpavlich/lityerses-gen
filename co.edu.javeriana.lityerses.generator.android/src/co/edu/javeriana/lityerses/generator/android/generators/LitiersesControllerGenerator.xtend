package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesControllerTemplate
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Controller
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider

class LitiersesControllerGenerator extends SimpleGenerator<Controller> {
	@Inject extension IQualifiedNameProvider

	override getFileName(Controller e) {
		return e.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/" + e.name + ".java"
	}

	override getOutputConfigurationName() {
		LitiersesGenerator.BACKING_BEANS
	}
	
	override getTemplate() {
		return new LitiersesControllerTemplate
	}

}
