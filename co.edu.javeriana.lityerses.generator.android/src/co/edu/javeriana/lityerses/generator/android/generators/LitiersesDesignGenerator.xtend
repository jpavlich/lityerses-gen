package co.edu.javeriana.lityerses.generator.android.generators

import co.edu.javeriana.lityerses.generator.android.LitiersesGenerator

import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Page
import java.util.List
import co.edu.javeriana.lityerses.generator.android.templates.LitiersesDesignTemplate

class LitiersesDesignGenerator  extends SimpleGenerator<List<Page>>{

	override protected getFileName(List<Page> is) {		
		return "template.xhtml";
	}
	
	override protected getOutputConfigurationName() {
		LitiersesGenerator.PAGES 
	}
	
	override getTemplate() {
		//return new LitiersesDesignTemplate
	}
		
}