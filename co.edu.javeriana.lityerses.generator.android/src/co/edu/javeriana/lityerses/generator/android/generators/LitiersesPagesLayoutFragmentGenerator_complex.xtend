package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import com.google.inject.Inject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import co.edu.javeriana.isml.isml.Page
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesPagesLayoutFragmentTemplate
import org.eclipse.xtext.generator.IFileSystemAccess
import co.edu.javeriana.isml.isml.ForView
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesPagesLayoutFragmentTemplate_complex
import org.eclipse.emf.ecore.EObject

class LitiersesPagesLayoutFragmentGenerator_complex extends SimpleGenerator<ForView> {

	@Inject extension IQualifiedNameProvider
	

	override getOutputConfigurationName() {
		LitiersesGenerator.LAYOUT
	}

	override protected getFileName(ForView e) {
		var current = EObject.cast(e)
		while (current != null && !(current instanceof Page)) {
			current = current.eContainer
		}	
		return (current as Page).name.toLowerCase+"_fragment_detail.xml"
	}

	override getTemplate() {
		return new LitiersesPagesLayoutFragmentTemplate_complex

	}

}
