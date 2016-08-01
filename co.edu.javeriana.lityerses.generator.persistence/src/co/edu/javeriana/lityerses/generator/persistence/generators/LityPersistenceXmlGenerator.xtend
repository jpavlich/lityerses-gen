package co.edu.javeriana.lityerses.generator.persistence.generators

import co.edu.javeriana.isml.generator.common.SimpleGenerator
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.lityerses.generator.persistence.LityPersistenceGenerator
import co.edu.javeriana.lityerses.generator.persistence.templates.LityPersistenceXmlTemplate
import java.util.List

class LityPersistenceXmlGenerator  extends SimpleGenerator<List<Entity>>{

	override protected getFileName(List<Entity> is) {		
		return "persistence.xml";
	}
	
	override protected getOutputConfigurationName() {
		//LityPersistenceGenerator.PERSISTENCE_XML
	}
	
	override getTemplate() {
		return new LityPersistenceXmlTemplate
	}
		
}