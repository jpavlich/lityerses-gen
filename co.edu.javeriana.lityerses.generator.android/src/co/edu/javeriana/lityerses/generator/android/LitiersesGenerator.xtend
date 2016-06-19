package co.edu.javeriana.lityerses.generator.android

import co.edu.javeriana.isml.generator.common.GeneratorSuite
import co.edu.javeriana.isml.generator.common.OutputConfiguration
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesControllerGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesDesignGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesFacesConfigXMLGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesPagesGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesServiceImplementationGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesServiceInterfaceGenerator

class LitiersesGenerator extends GeneratorSuite{
	
    @OutputConfiguration
	public static final String PAGES = "pages";

	@OutputConfiguration
	public static final String BACKING_BEANS = "backing.beans"

	@OutputConfiguration
	public static final String SERVICE_INTERFACE = "service.interface"
	
	@OutputConfiguration
	public static final String SERVICE_IMPL = "service.impl"
		

	override getGenerators() {
		#{			
			new LitiersesControllerGenerator,
			new LitiersesPagesGenerator,
			new LitiersesFacesConfigXMLGenerator,
			new LitiersesServiceInterfaceGenerator,
			new LitiersesServiceImplementationGenerator,			
			new LitiersesDesignGenerator
		}
	}
	
}