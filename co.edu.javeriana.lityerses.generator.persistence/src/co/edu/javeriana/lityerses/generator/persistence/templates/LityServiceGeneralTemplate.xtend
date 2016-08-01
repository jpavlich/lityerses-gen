 package co.edu.javeriana.lityerses.generator.persistence.templates

import co.edu.javeriana.isml.generator.common.SimpleTemplate
import co.edu.javeriana.isml.isml.Attribute
import co.edu.javeriana.isml.isml.Type
import co.edu.javeriana.isml.isml.impl.PackageImpl
import org.eclipse.xtext.naming.IQualifiedNameProvider
import javax.inject.Inject
import co.edu.javeriana.isml.isml.impl.EntityImpl
import co.edu.javeriana.isml.isml.impl.ControllerImpl

class LityServiceGeneralTemplate extends SimpleTemplate<Attribute> {
	 
	@Inject extension IQualifiedNameProvider
	 
	override preprocess(Attribute servicio_entity) {	
	}

	
	override def CharSequence template(Attribute servicio_entity) '''
		
		«var servicio = servicio_entity.type.referencedElement»
		«FOR param : servicio_entity.type.eContents»
			«var entidad_parametro = ((param as Type).referencedElement)»
			package «(entidad_parametro.eContainer as PackageImpl).name.toLowerCase».services;		

			import «(entidad_parametro.eContainer as PackageImpl).name.toLowerCase».«entidad_parametro.name.toFirstUpper»;
			import «(servicio.eContainer as PackageImpl).name.toLowerCase».impl.«servicio.name.toFirstUpper»Impl;
			import com.litierses.Utilidades.acceso_BD;
			
			public class «entidad_parametro.name.toFirstUpper»__«servicio.name.toFirstUpper»__ extends «servicio.name.toFirstUpper»Impl<«entidad_parametro.name.toFirstUpper»>{
				
				public «entidad_parametro.name.toFirstUpper»__«servicio.name.toFirstUpper»__(){
				        clazzTObject = «entidad_parametro.name.toFirstUpper».class;
				        urlWebservice = acceso_BD.server+"ws.«servicio.name.toLowerCase»_«entidad_parametro.name.toLowerCase»/";
				    }
			}	
		«ENDFOR»
	'''

}
