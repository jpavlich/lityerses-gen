package co.edu.javeriana.lityerses.generator.persistence

import co.edu.javeriana.isml.generator.common.GeneratorSuite
import co.edu.javeriana.isml.generator.common.OutputConfiguration
import co.edu.javeriana.lityerses.generator.persistence.generators.LityEntityGenerator
import co.edu.javeriana.lityerses.generator.persistence.generators.LityPersistenceXmlGenerator
import co.edu.javeriana.lityerses.generator.persistence.generators.LityResourceBundleGenerator
import co.edu.javeriana.lityerses.generator.persistence.generators.LityServiceGeneralGenerator
import co.edu.javeriana.lityerses.generator.persistence.generators.LityServiceGeneralGeneratorServer

/**
 * Generates code from your model files on save.
 * 
 * see http://www.eclipse.org/Xtext/documentation.html#TutorialCodeGeneration
 */
class LityPersistenceGenerator extends GeneratorSuite {
	
	
	@OutputConfiguration	
	public static final String RESOURCE_BUNDLE="resource.bundle"
	
	@OutputConfiguration
	public static final String ENTITIES = "entities";

	@OutputConfiguration
	public static final String SERVICE_GENERAL = "service.general"

	@OutputConfiguration
	public static final String PERSISTENCE_XML = "persistencexml"
	
	@OutputConfiguration
	public static final String SERVICE_SERVER = "service.server"
		

	override getGenerators() {
		#{
			new LityEntityGenerator,			
			new LityResourceBundleGenerator,
			new LityServiceGeneralGenerator,
			new LityServiceGeneralGeneratorServer,
			new LityPersistenceXmlGenerator
		}
	}

}
