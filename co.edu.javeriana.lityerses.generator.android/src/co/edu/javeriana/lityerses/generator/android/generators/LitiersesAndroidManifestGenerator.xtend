package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Page
import java.util.List
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesAndroidManifestTemplate
import co.edu.javeriana.isml.isml.Controller

class LitiersesAndroidManifestGenerator  extends SimpleGenerator<List<Controller>>{

	override protected getFileName(List<Controller> is) {		
		return "AndroidManifest.xml";
	}
	
	override protected getOutputConfigurationName() {
		LitiersesGenerator.MANIFEST
	}
	
	override getTemplate() {
		return new LitiersesAndroidManifestTemplate
	}
		
}