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
import co.edu.javeriana.isml.isml.impl.VariableReferenceImpl


class LitiersesPagesFragmentTemplate extends SimpleTemplate<Page> {
	@Inject extension TypeChecker
	@Inject extension IsmlModelNavigation	
	@Inject extension ExpressionTemplate
	@Inject extension IQualifiedNameProvider
	@Inject extension StatementTemplate
	int i;
	String actualizacionEditText;
	
	//Variables para  crear subclase por datatable
	ViewInstance table_subclass;
	String tableid;
	
	
	Map<ViewInstance,String> forms
	
	int j;

	override preprocess(Page e) {
		i = 1;
		actualizacionEditText="";
			
		forms=new HashMap
	}
	
	
/**
 * Metodo que retorna la plantilla para  paginas con elementos graficos del framework prime faces 
 * 
 */
	override def CharSequence template(Page page) '''	
	package «(page.eContainer.fullyQualifiedName)»;
	import android.os.Bundle;
	import android.support.v4.app.Fragment;
	import android.view.LayoutInflater;
	import android.view.View;
	import android.view.ViewGroup;
	import com.example.android.xyztouristattractions.R;
	import java.io.Serializable;
	«FOR imports : page.eContainer.eContents /*Se importan los imports de la pagina isml */»
			«IF imports.class == ImportImpl»
				import  «imports.cast(ImportImpl).importedPackage.name».*;
			«ENDIF»
	«ENDFOR»
	//Componentes graficos
	import android.widget.Button;                                       
	import android.widget.TextView;  
	import android.widget.EditText;
	//Imports para lista
	import android.widget.ListView;
	import java.util.ArrayList;
	import android.content.Context;
	import android.widget.BaseAdapter;
	
	public class «(page.name)»_Fragment extends Fragment {
		
		«FOR param : page.parameters»
			private static final String EXTRA_OBJECT_«(param.name).toUpperCase» = "«(page.name)»_object_«(param.name)»";
			private «IF param.type.collection»ArrayList<«(param.type.containedTypeSpecification.name)»>«ELSE»«(param.type.referencedElement.name)»«ENDIF» «(param.name)»;
		«ENDFOR»
		
	    public static «(page.name)»_Fragment createInstance(«FOR param : page.parameters SEPARATOR ','»«IF param.type.collection»ArrayList<«(param.type.containedTypeSpecification.name)»>«ELSE»«(param.type.referencedElement.name)»«ENDIF» «(param.name)»«ENDFOR») {
	        «(page.name)»_Fragment detailFragment = new «(page.name)»_Fragment();
	        Bundle bundle = new Bundle();
	        «FOR param : page.parameters»
	        	bundle.putSerializable(EXTRA_OBJECT_«(param.name).toUpperCase», (Serializable) «(param.name)»);
	        «ENDFOR»
	        detailFragment.setArguments(bundle);
	        return detailFragment;
	    } 
	    
	    public «(page.name)»_Fragment() {}
	    
	    @Override
	    public View onCreateView(LayoutInflater inflater, ViewGroup container,
	                                 Bundle savedInstanceState) {
	    	setHasOptionsMenu(true);
	        View view = inflater.inflate(R.layout.«(page.name).toLowerCase»_fragment, container, false);
	        «FOR param : page.parameters»
	        «(param.name)» = («IF param.type.collection»ArrayList<«(param.type.containedTypeSpecification.name)»>«ELSE»«(param.type.referencedElement.name)»«ENDIF») getArguments().getSerializable(EXTRA_OBJECT_«(param.name).toUpperCase»);
	        if («(param.name)» == null) { getActivity().finish();       return null;     }
	        «ENDFOR»
	    //elementos graficos    
	        «IF page.body != null»
	        	«widgetTemplate(page.body)»
	        «ENDIF»	
	    	return view;
	    }
	}
«IF table_subclass != null»
	«dataTable_newClass»
«ENDIF»
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
		TextView «idLabel» = (TextView) view.findViewById(R.id.«idLabel»);
		«IF part.actionCall==null»
		«idLabel».setText(«part.parameters.get(0).valueTemplateLity»);
		«ELSE»
		«idLabel».setText(«part.parameters.get(0).valueTemplateLity»+"");
		«ENDIF»
		
		'''
		
		
		
/**
	 * Metodo para generar elementos de tipo cajas de texto
	 * 
	 */
	def CharSequence inputText(ViewInstance part) 
	
	'''
	 	«var idLabel=part.id »
	 	final EditText «idLabel» = (EditText) view.findViewById(R.id.«idLabel»);
	 	«IF part.actionCall==null»
	 		«idLabel».setText(«part.parameters.get(1).valueTemplateLity»);
	 		«/*String para los botones*/for (var i=0; i<1;i++){if (1==1){
	 			{actualizacionEditText = actualizacionEditText+"\n"+part.parameters.get(1).valueTemplateLity_SET+"("+idLabel+".getText()+\"\");"}
	 		}}»
	 	«ELSE»
	 		«idLabel».setText(«part.parameters.get(1).valueTemplateLity»);
	 	«ENDIF»
	'''
		 
		/**
	 * Metodo para generar elementos de tipo boton
	 * 
	 */
	def CharSequence button(ViewInstance part) '''
	«var buttonid=part.id»
	Button «buttonid» = (Button)view.findViewById(R.id.«buttonid»);
	«IF (part.eContainer instanceof ForView)»«buttonid».setTag(position);«ENDIF»
	«buttonid».setOnClickListener(new View.OnClickListener() {
	    @Override
	    public void onClick(View v) {
	    	«IF !part.actionCall.parameters.empty»
	    		«actualizacionEditText»
	    	«ENDIF»
	    	«IF !(part.eContainer instanceof ForView)»
	    		«part.containerController.name».«part.actionCall?.action?.name»(getActivity()«FOR param:part.actionCall.parameters»,«IF param instanceof VariableReference && (param as VariableReference).referencedElement.eContainer instanceof Page»«/*(part.findAncestor(Page)as Page).controller.name.toFirstLower*/»«ENDIF»«writeExpression(param)»«ENDFOR»);
	    	«ELSE»
	    		«part.containerController.name».«part.actionCall?.action?.name»(getActivity()«
    		IF part.eContainer instanceof ForView»«
    	    	FOR contenido:part.eContainer.eContents»«
					IF contenido instanceof VariableReference», «
						(contenido as VariableReference).referencedElement.name».get(Integer.parseInt(v.getTag()+""));«
					ENDIF»«
				ENDFOR»«
    		ENDIF»
	    	«ENDIF»
	    }
	});
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
		«forms.put(viewInstance,id)»
		{// Form id: «id»
				«FOR partBlock : viewInstance.getBody»
				«widgetTemplate(partBlock)»
				«ENDFOR»
		}
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
		«for  (var i=0; i<1;i++) {tableid = table.id;table_subclass = table;}»
		ListView «tableid» = (ListView) view.findViewById(R.id.«table.containerPage.name.toLowerCase»_fragment_detail);
		Adapter«tableid.toFirstUpper» mAdapter«tableid.toFirstUpper» = new Adapter«tableid.toFirstUpper»(getActivity()«
				FOR contenido:table.forViewInBody.eContents»«
					IF contenido instanceof VariableReference», «
					(contenido as VariableReference).referencedElement.name»«
					ENDIF»«
				ENDFOR
			»);	
		«tableid».setAdapter(mAdapter«tableid.toFirstUpper»);
		'''
		

	def CharSequence dataTable_newClass () '''
	/*****************************************************************************************************
	    CLASE PARA «tableid.toUpperCase» «/*table_subclass*/»
	*****************************************************************************************************/
	«var variableTipo = ""»
	«var variablenombre = ""»
	class Adapter«tableid.toFirstUpper» extends BaseAdapter {
		
		«FOR contenido:table_subclass.forViewInBody.eContents»
			«IF contenido instanceof VariableReference»
				«FOR param : table_subclass.containerPage.parameters»
					public «IF param.type.collection»ArrayList<«(param.type.containedTypeSpecification.name)»>«ELSE»«(param.type.referencedElement.name)»«ENDIF» «(contenido as VariableReference).referencedElement.name»;
					«for  (var i=0; i<1;i++) {
						variableTipo = "ArrayList<"+(param.type.containedTypeSpecification.name)+">";
						variablenombre = (contenido as VariableReference).referencedElement.name;
					}»
				«ENDFOR»
			«ENDIF»
		«ENDFOR»
		private Context mContext;
		
		public Adapter«tableid.toFirstUpper» (Context context, «variableTipo» «variablenombre») {
			super();
			mContext = context;
			this.«variablenombre» = «variablenombre»;                      
		}
		
		@Override
		public int getCount() {
		return «variablenombre» == null ? 0 : «variablenombre».size();
		}
		
	    @Override
	    public Object getItem(int position) {
	    	return «variablenombre».get(position);
	    }
	    
		@Override
		public long getItemId(int position) {       return position;  }
		
		@Override
		public View getView(  int position, View convertView, ViewGroup parent) {
		    View view = convertView;
		    LayoutInflater inflater = LayoutInflater.from(mContext);
		    view = inflater.inflate(R.layout.«(table_subclass.containerPage.name).toLowerCase»_fragment_detail, null);  
		    «table_subclass.forViewInBody.variable.type.referencedElement.name» «table_subclass.forViewInBody.variable.name» = «variablenombre».get(position); 
		    //*************** INICIALIZACIÒN DE COMPONENTES GRÀFICOS
		    «FOR pair : table_subclass.getColumnsDataTable.entrySet»
			«val viewInstance = pair.key as ViewInstance»
					«/*ENCABEZADOS DEL TABLE widgetTemplate(viewInstance)*/»
					«widgetTemplate(pair.value)»
		    «ENDFOR»
		    //***********************************
		    return view;
		}    
	}
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
	
	def CharSequence valueTemplateLity(Expression expression){		
		if(expression instanceof Reference){
			if (expression instanceof ResourceReference){
				return expression.writeExpression
			}else if(expression instanceof VariableReference){
				if (expression.referencedElement.findAncestor(ForView) != null){ 
				 	//return ""+expression.writeExpression+""
				 	var retorno =(expression as VariableReference).referencedElement.name+"";
						for (cont : (expression).eContents)
						{
							 if(cont instanceof VariableReference){
							 	retorno=retorno+".get"+((cont as VariableReference).referencedElement.name).toFirstUpper+"()+\"\"";
							 }
							 else
							 {
							 	retorno=retorno+"-valueTemplateLity no controlado1-";
							 }
						}
						return retorno;	
				} else {					
					{
						var retorno =(expression as VariableReference).referencedElement.name+"";
						for (cont : (expression).eContents)
						{
							 if(cont instanceof VariableReference){
							 	retorno=retorno+".get"+((cont as VariableReference).referencedElement.name).toFirstUpper+"()+\"\"";
							 }
							 else
							 {
							 	retorno=retorno+"-valueTemplateLity no controlado1-";
							 }
						}
						return retorno;	
					}	
				}				
			}
		} else{
			return expression.writeExpression
		}
	}
	
	def CharSequence valueTemplateLity_SET(Expression expression){		
		if(expression instanceof Reference){
			if (expression instanceof ResourceReference){
				return expression.writeExpression
			}else if(expression instanceof VariableReference){
				if (expression.referencedElement.findAncestor(ForView) != null){ 
				 	return "\""+"#{"+expression.writeExpression+"}"+"\""
				} else {					
					{
						var retorno =(expression as VariableReference).referencedElement.name+"";
						for (cont : (expression).eContents)
						{
							 if(cont instanceof VariableReference){
							 	retorno=retorno+".set"+((cont as VariableReference).referencedElement.name).toFirstUpper;
							 }
							 else
							 {
							 	retorno=retorno+"-valueTemplateLity no controlado1-";
							 }
						}
						return retorno;	
					}	
				}				
			}
		} else{
			return expression.writeExpression
		}
	}
	
	
	
	
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
