package co.edu.javeriana.lityerses.generator.android

import co.edu.javeriana.isml.generator.common.GeneratorSuite
import co.edu.javeriana.isml.generator.common.OutputConfiguration
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesControllerGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesDesignGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesFacesConfigXMLGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesPagesGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesServiceImplementationGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesServiceInterfaceGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesServiceServerGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesPagesFragmentGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesPagesLayoutGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesPagesLayoutFragmentGenerator
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesPagesLayoutFragmentGenerator_complex
import co.edu.javeriana.lityerses.generator.android.generators.LitiersesAndroidManifestGenerator
import co.edu.javeriana.isml.isml.Controller

class LitiersesGenerator extends GeneratorSuite{
	
    @OutputConfiguration
	public static final String PAGES = "pages";
	
	@OutputConfiguration
	public static final String LAYOUT = "layout";

	@OutputConfiguration
	public static final String BACKING_BEANS = "backing.beans"

	@OutputConfiguration
	public static final String SERVICE_INTERFACE = "service.interface"
	
	@OutputConfiguration
	public static final String SERVICE_IMPL = "service.impl"
	
	@OutputConfiguration
	public static final String SERVICE_SERVER = "service.server"
	
	@OutputConfiguration
	public static final String MANIFEST = "manifest"
	
		

	override getGenerators() {
		#{			
			new LitiersesControllerGenerator,
			new LitiersesPagesGenerator,
			new LitiersesPagesFragmentGenerator,
			//new LitiersesFacesConfigXMLGenerator,
			new LitiersesServiceInterfaceGenerator,
			new LitiersesServiceImplementationGenerator,			
			//new LitiersesDesignGenerator,
			new LitiersesServiceServerGenerator,
			new LitiersesPagesLayoutGenerator,
			new LitiersesPagesLayoutFragmentGenerator,
			new LitiersesPagesLayoutFragmentGenerator_complex,
			new LitiersesAndroidManifestGenerator
		}
	}
	
}