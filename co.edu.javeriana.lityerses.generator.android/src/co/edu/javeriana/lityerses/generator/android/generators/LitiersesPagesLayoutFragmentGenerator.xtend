package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import co.edu.javeriana.isml.isml.Page
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesPagesLayoutFragmentTemplate

class LitiersesPagesLayoutFragmentGenerator extends SimpleGenerator<Page> {

	@Inject extension IQualifiedNameProvider

	override getOutputConfigurationName() {
		LitiersesGenerator.LAYOUT
	}

	override protected getFileName(Page e) {
		return e.name.toLowerCase + "_fragment.xml"
	}

	override getTemplate() {
		return new LitiersesPagesLayoutFragmentTemplate

	}

}
