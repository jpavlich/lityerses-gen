 package co.edu.javeriana.lityerses.generator.android.templates

import co.edu.javeriana.isml.generator.common.SimpleTemplate
import co.edu.javeriana.isml.isml.Controller
import co.edu.javeriana.isml.isml.Entity
import co.edu.javeriana.isml.isml.Enum
import co.edu.javeriana.isml.isml.Expression
import co.edu.javeriana.isml.isml.ForView
import co.edu.javeriana.isml.isml.IfView
import co.edu.javeriana.isml.isml.NamedViewBlock
import co.edu.javeriana.isml.isml.Page
import co.edu.javeriana.isml.isml.Reference
import co.edu.javeriana.isml.isml.ResourceReference
import co.edu.javeriana.isml.isml.VariableReference
import co.edu.javeriana.isml.isml.ViewInstance
import co.edu.javeriana.isml.isml.ViewStatement
import co.edu.javeriana.isml.scoping.IsmlModelNavigation
import co.edu.javeriana.isml.validation.TypeChecker
import com.google.inject.Inject
import java.util.HashMap
import java.util.LinkedHashMap
import java.util.Map
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.ecore.EObject
import org.eclipse.xtext.naming.IQualifiedNameProvider
import co.edu.javeriana.isml.isml.impl.ImportImpl
import co.edu.javeriana.isml.isml.Instance
import co.edu.javeriana.isml.isml.impl.ViewInstanceImpl

/**
 * Clase para generar paginas con elementos graficos del framework prime faces 5.1
 * autor: john.olarte@javeriana.edu.co
 * 
 * 
 */

class LitiersesPagesLayoutFragmentTemplate extends SimpleTemplate<Page> {
	@Inject extension TypeChecker
	@Inject extension IsmlModelNavigation	
	@Inject extension ExpressionTemplate
	@Inject extension IQualifiedNameProvider
	@Inject extension StatementTemplate
	int i;
	Map<ViewInstance,String> forms
	
	int j;

	override preprocess(Page e) {
		i = 1;
			
		forms=new HashMap
	}
	
	
/**
 * Metodo que retorna la plantilla para  paginas con elementos graficos del framework prime faces 
 * 
 */
	override def CharSequence template(Page page) '''
	<?xml version="1.0" encoding="utf-8"?>
	
	<android.support.design.widget.CoordinatorLayout
	    xmlns:android="http://schemas.android.com/apk/res/android"
	    xmlns:app="http://schemas.android.com/apk/res-auto"
	    android:layout_width="match_parent"
	    android:layout_height="match_parent">
	
	<LinearLayout
	        android:orientation="vertical"
	        android:layout_width="match_parent"
	        android:layout_height="match_parent"
	        android:weightSum="100">
	        
		«IF page.body != null»
			«widgetTemplate(page.body)»
		«ENDIF»	  
		
	    </LinearLayout>
	</android.support.design.widget.CoordinatorLayout>	          
	'''
	
	
	
	def dispatch CharSequence widgetTemplate(ViewInstance viewInstance) {
	
		switch (viewInstance.type.typeSpecification.typeSpecificationString) {
		
			case "Label": label(viewInstance)
			case "Text": inputText(viewInstance)
			case "Button": button(viewInstance)
			case "Form": form(viewInstance)
			case "Panel": panel(viewInstance)
			case "PanelGrid": panelGrid(viewInstance)		
			case "PanelButton": panelButton(viewInstance)
			case "DataTable": dataTable(viewInstance)
			case "Password": password(viewInstance)
			case "CheckBox": checkBox(viewInstance)
			case "Calendar": calendar(viewInstance)
			case "Link": link(viewInstance)
			case "ComboChooser": comboChooser(viewInstance)
			case "Spinner": spinner(viewInstance)
			case "PickList": pickList(viewInstance)
			case "OutputText": outputText(viewInstance)
			case "GMap": Map(viewInstance)
			case "RadioChooser": radioChooser(viewInstance)
			case "Image": image(viewInstance)
		    case "OrderList": orderList(viewInstance)
		    case "Media": Media(viewInstance)
		}
		
	}
	
	/**
	 * Método para generar elementos de tipo cajas de texto
	 * 
	 */
	def CharSequence outputText(ViewInstance part) '''

		<p:inputText id= "«part.id»" label=«part.parameters.get(0).writeExpression» value=«part.parameters.get(1).valueTemplate» disabled="true"/>
	'''
	
/**
 * 
 * Metodo para generar elementos de tipo picklist
 */
    def CharSequence pickList(ViewInstance part)'''
	<p:pickList id="«part.id»"
		itemLabel=«part.parameters.get(0).writeExpression» itemValue="#{pickValue}"
		value=«IF part.parameters.get(1) instanceof ResourceReference»«part.parameters.get(1).writeExpression»«ELSE»"#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}"«ENDIF»
		var="«part.containerController.name»"></p:pickList>
	''' 
	
	
	
	/**
	 * Metodo para generar elementos de tipo spinner
	 * 
	 */
	def CharSequence spinner(ViewInstance part)'''
		<p:spinner id="«part.id»" label=«part.parameters.get(0).writeExpression» title=«part.parameters.get(0).writeExpression» 
			value=«IF part.parameters.get(1) instanceof ResourceReference»«part.parameters.get(1).writeExpression»«ELSE»"#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}"«ENDIF»
			stepFactor="«part.parameters.get(2).writeExpression»" min="«part.parameters.get(3).writeExpression»" max="«part.parameters.get(4).writeExpression»" prefix=«part.parameters.get(5).writeExpression»/>
	'''
	
	/**
	 * Metodo para generar elementos de tipo imagen
	 * 
	 */
	def CharSequence image(ViewInstance part)'''
		<p:commandLink id="«part.id»" «IF part.actionCall!=null»action="#{«(part.actionCall.referencedElement.eContainer as Controller).name.toFirstLower».«part.actionCall.referencedElement.name»()}"«ENDIF»>
			<img id="«part.id»Image" src=«part.parameters.get(0).writeExpression»/>
		</p:commandLink>
	'''
/**
	 * Metodo para generar elementos de tipo calendar
	 * 
	 */
	def CharSequence calendar(ViewInstance part) '''
		 <p:calendar id= "«part.id»" label=«part.parameters.get(0).writeExpression» 
		 	value=«IF part.parameters.get(1) instanceof ResourceReference»«part.parameters.get(1).writeExpression»«ELSE»"#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}"«ENDIF» pattern=«part.parameters.get(3).writeExpression» 
		 	navigator="«part.parameters.get(4).writeExpression»" mode=«part.parameters.get(5).writeExpression» />
	'''
	

/**
	 * Metodo para generar elementos de tipo checkbox
	 * 
	 */
	def CharSequence checkBox(ViewInstance part) '''
		<p:selectBooleanCheckbox id= "«part.id»" label=«part.parameters.get(0).writeExpression» value="#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}"/>		
	'''
	
	/**
	 * Metodo para generar elementos de tipo link
	 * 
	 */
	def CharSequence link(ViewInstance part)'''
		<h:outputLink id="«part.id»"  value=«part.parameters.get(1).writeExpression»>
			<h:outputText value=«part.parameters.get(0).writeExpression» />
		</h:outputLink>
	'''
	
	
	/**
	 * Metodo para generar elementos de tipo comboChooser
	 * 
	 */
	def CharSequence comboChooser(ViewInstance part)'''
		«IF part.parameters.get(1).writeExpression instanceof Reference && (part.parameters.get(1).writeExpression as Reference).referencedElement.type.typeSpecification instanceof Entity»
		<h:entitySelectOneMenu id="«part.id»" label=«part.parameters.get(0).writeExpression» 
			valueList="#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}" value=«IF part.parameters.get(2) instanceof ResourceReference»«part.parameters.get(2).writeExpression»«ELSE»"#{«part.containerController.name.toFirstLower».«part.parameters.get(2).writeExpression»}"«ENDIF» noSelectionLabel=«part.parameters.get(3).writeExpression» labelSelection="#{_eachItem}"/>
		«ELSE»
		«IF part.parameters.get(1).writeExpression instanceof Reference && (part.parameters.get(1).writeExpression as Reference).referencedElement.type.typeSpecification instanceof Enum»
		<p:enumSelectOneMenu id="«part.id»" label=«part.parameters.get(0).writeExpression» 
			valueList="#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}" value=«IF part.parameters.get(2) instanceof ResourceReference»«part.parameters.get(2).writeExpression»«ELSE»"#{«part.containerController.name.toFirstLower».«part.parameters.get(2).writeExpression»}"«ENDIF» noSelectionLabel=«part.parameters.get(3).writeExpression» labelSelection="#{_eachItem}"
		«ELSE»
		<p:objectSelectOneMenu id="«part.id»" label=«part.parameters.get(0).writeExpression» 
			valueList="#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}" value=«IF part.parameters.get(2) instanceof ResourceReference»«part.parameters.get(2).writeExpression»«ELSE»"#{«part.containerController.name.toFirstLower».«part.parameters.get(2).writeExpression»}"«ENDIF» noSelectionLabel=«part.parameters.get(3).writeExpression» labelSelection="#{_eachItem}"/>
			«ENDIF»
		«ENDIF»
	'''
	
/**
	 * Metodo para generar elementos de tipo cajas de texto password
	 * 
	 */
	def CharSequence password(ViewInstance part) '''		
		<p:password  id= "«part.id»" label=«part.parameters.get(0).writeExpression» value=«IF part.parameters.get(1) instanceof ResourceReference»«part.parameters.get(1).writeExpression»«ELSE»"#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}"«ENDIF»/>
	'''
	/**
	 * Metodo para generar elementos de tipo label
	 * 
	 */
	
	def CharSequence label(ViewInstance part) '''
		«var idLabel=part.id »
		<TextView
		    android:id="@+id/«idLabel»"
		    android:layout_width="match_parent"
		    android:layout_height="wrap_content"
		    android:padding="@dimen/small_margin"
		    android:maxLines="1"
		    style="?android:textAppearanceSmall"
		    android:text="" />
		'''
		
/**
	 * Metodo para generar elementos de tipo cajas de texto
	 * 
	 */
	def CharSequence inputText(ViewInstance part) '''
	«var idLabel=part.id »
	<EditText
		android:id="@+id/«idLabel»"
		android:layout_width="match_parent"
		android:layout_height="wrap_content"
		android:padding="@dimen/small_margin"
		android:maxLines="1"
		style="?android:textAppearanceSmall"
		android:text=""
		android:hint=«part.parameters.get(0).writeExpression» />
	'''
		 
		/**
	 * Metodo para generar elementos de tipo boton
	 * 
	 */
	def CharSequence button(ViewInstance part) '''
	«var buttonid=part.id»
	<Button
			android:layout_width="wrap_content"
			android:layout_height="wrap_content"
			android:text=«part.parameters.get(0).writeExpression»
			android:id="@+id/«buttonid»" />
	'''	
	
	/**
	 * Metodo para actualizar los elementos de un form
	 * 
	 */
	def CharSequence updateTemplate(ViewInstance part){
		var EObject tmp=part
		while(tmp!=null){
			if (tmp!=null && tmp instanceof ViewInstance && (tmp as ViewInstance).type.typeSpecification.typeSpecificationString.equals("Form")){
				return ":"+forms.get(tmp as ViewInstance)
			}
			tmp=tmp.eContainer
		}
	}
	/**
	 * Metodo para generar los elementos de un form
	 * 
	 */
	
	def CharSequence form(ViewInstance viewInstance) '''
		«val id=viewInstance.id»
		«FOR partBlock : viewInstance.getBody»
		«widgetTemplate(partBlock)»
		«ENDFOR»
	'''
/**
	 * Metodo para generar elementos graficos de tipo mapa
	 * 
	 */
	def CharSequence Map(ViewInstance part) '''

		
		<p:gmap id= "«part.id»" center=«part.parameters.get(0).writeExpression» zoom=«part.parameters.get(1).writeExpression» type=«part.parameters.get(2).writeExpression» 
		model= "#{«part.containerController.name.toFirstLower».«part.parameters.get(3).writeExpression»}"
		style="width:100%;height:400px" />		
	'''

/**
	 * Metodo para generar elementos graficos de tipo media
	 * 
	 */
	def CharSequence Media(ViewInstance part) '''

		
		<p:media id= "«part.id»" value=«part.parameters.get(0).writeExpression» width=«part.parameters.get(1).writeExpression» height=«part.parameters.get(2).writeExpression» 
		player="flash" />		
	'''


	
/**
	 * Metodo para generar elementos graficos de tipo radio button
	 * 
	 */
	
	def CharSequence radioChooser(ViewInstance part) '''
		<p:selectOneRadio id="«part.id»" label=«part.parameters.get(0).writeExpression»  value=«IF part.parameters.get(2) instanceof ResourceReference»«part.parameters.get(2).writeExpression»«ELSE»"#{«part.containerController.name.toFirstLower».«part.parameters.get(2).writeExpression»}"«ENDIF»
		valueList="#{«part.containerController.name.toFirstLower».«part.parameters.get(1).writeExpression»}"/> 
	'''
	
	/**
	 * Metodo para generar elementos graficos de tipo panel
	 * 
	 */
	
	def CharSequence panel(ViewInstance viewInstance) '''
	 <p:draggable for="«viewInstance.thisId»" />
	 <p:panel id= "«viewInstance.id»" >
		«FOR partBlock : viewInstance.body»
			«widgetTemplate(partBlock)»
		«ENDFOR»
	</p:panel>	
	
	'''
	
	/**
	 * Metodo para generar elementos graficos como panel grid
	 * 
	 */
	
	def CharSequence panelGrid(ViewInstance viewInstance) '''
 	<p:draggable for="«viewInstance.thisId»" />
	 <p:panelGrid id= "«viewInstance.id»" columns=«viewInstance.parameters.get(0).writeExpression»>
		«FOR partBlock : viewInstance.body»
			«widgetTemplate(partBlock)»
		«ENDFOR»
	</p:panelGrid>	
	
	'''
	/**
	 * Metodo para generar elementos graficos de tipo pannel button
	 * 
	 */
	
	def CharSequence panelButton(ViewInstance viewAttribute) '''
	'''
	
/**
	 * Metodo para generar elementos graficos de tipo orderlist
	 * 
	 */

	def CharSequence orderList(ViewInstance orderList) '''
		
		
		<p:orderList id= "«orderList.id»" value="#{«orderList.containerController.name.toFirstLower».«orderList.forViewInBody?.collection.referencedElement.name»}" 
		var=var="«orderList.forViewInBody.variable.name»" controlsLocation="none" itemLabel="#{city.almuerzo}" itemValue="#{city.almuerzo}" />
	'''

/**
	 * Metodo para generar elementos graficos de tipo data table
	 * 
	 */
	
	def CharSequence dataTable(ViewInstance table) '''
		«var tableid = table.id»
		<ListView
		        android:layout_width="match_parent"
		        android:layout_height="wrap_content"
		        android:id="@+id/«tableid»"
		        android:layout_gravity="center_horizontal" />
		
		«»
	'''
	
	
	/**
	 * Metodo para obtener las columnas de un datatable
	 * 
	 */
	
	def getColumnsDataTable(ViewInstance table) {
		val columns = new LinkedHashMap<ViewStatement, ViewStatement>
		val header = table.body.get(0) as NamedViewBlock
		val forView = table.body.get(1).cast(NamedViewBlock).body.get(0) as ForView
		for (i : 0 ..< header.body.size) {
			columns.put(header.body.get(i), forView.body.get(i))
			
		}
		return columns
	}

	/**
	 * Metodo para obtener el id de un componente
	 * 
	 */
	
	def getId(ViewInstance part){
		if(part.name!= null){
			return part.name
		}else{
			return part.view.name.toFirstLower + i++;
		}		
	}
	
	/**
	 * Metodo para asignar las columnas de un componente
	 * 
	 */
	
	def getThisId(ViewInstance part){
			j = 0;
		if(part.name!= null){
			return part.name
		}else{
			j =i;
			return part.view.name.toFirstLower+j;
		}		
	}
	
		/**
	 * Metodo para obtner las partes de cada componente de tipo block
	 * 
	 */
	
	def dispatch CharSequence widgetTemplate(EList<ViewStatement> partBlock)'''
		«IF partBlock != null»
			«FOR part : partBlock»
				
				«widgetTemplate(part)»		
				
			«ENDFOR»
		«ENDIF»
			
	'''
	
		/**
	 * Metodo para obtener asignar valores a los componentes 
	 * 
	 */
	
	def CharSequence valueTemplate(Expression expression){		
		if(expression instanceof Reference){
			if (expression instanceof ResourceReference){
				return expression.writeExpression
			}else if(expression instanceof VariableReference){
				if (expression.referencedElement.findAncestor(ForView) != null){ 
				 	return "\""+"#{"+expression.writeExpression+"}"+"\""
				} else {
					return "\""+"#{"+expression.containerController.name.toFirstLower+"."+expression.writeExpression+"}"+"\""
				}				
			}
		} else{
			return expression.writeExpression
		}
	}	
}
