package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesFacesConfigXMLTemplate
import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Page
import java.util.List

class LitiersesFacesConfigXMLGenerator  extends SimpleGenerator<List<Page>>{

	override protected getFileName(List<Page> is) {		
		return "WEB-INF/faces-config.xml";
	}
	
	override protected getOutputConfigurationName() {
		LitiersesGenerator.PAGES
	}
	
	override getTemplate() {
		//return new LitiersesFacesConfigXMLTemplate
	}
		
}