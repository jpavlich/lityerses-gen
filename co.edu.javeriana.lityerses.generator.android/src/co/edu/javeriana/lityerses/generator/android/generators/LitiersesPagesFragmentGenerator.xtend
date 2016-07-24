package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import co.edu.javeriana.isml.isml.Page
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesPagesTemplate
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesPagesFragmentTemplate

class LitiersesPagesFragmentGenerator extends SimpleGenerator<Page> {

	@Inject extension IQualifiedNameProvider

	override getOutputConfigurationName() {
		LitiersesGenerator.PAGES
	}

	override protected getFileName(Page e) {
		return e.eContainer?.fullyQualifiedName.toString("/").toLowerCase + "/" + e.name + "_Fragment.java"
	}

	override getTemplate() {
		return new LitiersesPagesFragmentTemplate

	}

}
