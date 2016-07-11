	package controlador;
			
	import java.io.Serializable;
	import javax.inject.*;		
	import controlador.util.JsfUtil;
	import javax.enterprise.context.*;		
	import java.util.*;
	import javax.faces.application.FacesMessage;
	import javax.faces.context.FacesContext;
	import javax.faces.bean.ManagedBean;
	import javax.annotation.PostConstruct;
	import javax.ejb.EJB;
	import org.primefaces.model.map.MapModel;
	import org.primefaces.model.map.DefaultMapModel;
	import org.primefaces.model.map.LatLng;
	import org.primefaces.model.map.Marker;
	import co.edu.javeriana.sesion.Query;
	import co.edu.javeriana.sesion.Convert;
	
		
	
	
	
	
	
	
		
	
	
	import com.litierses.entities.services.Dieta__General__;
	import com.litierses.entities.*;
	
import controlador.interfaces.Servicio2;
co.edu.javeriana.isml.isml.impl.ParameterizedTypeImpl@d1accb












						
	

	
	/**
	 * This class represents a controller with name DietaManager2
	 */
	 
	@ManagedBean(name = "dietaManager2")
	@RequestScoped
	
	public class DietaManager2 implements Serializable {
		
		/**
		 * The serialVersionUID
		 */
		private static final long serialVersionUID = 1L;
		
		
			/**
			 * Injection for the component named Servicio2 
			 */
			@EJB
		
		private  Servicio2 servicio;
		
		
	    
		
		
			
		
				
	 @PostConstruct
	 public void init() {
	 	listAll();
																																									
																						    
	
			    
	  }
		
	
				/**
				 * Action method named deleteDieta
				 * @param dieta Parameter from type Dieta
				 *
				 * @return String value with some navigation outcome
				 */
		

				public String deleteDieta( Dieta dieta){

					try{
						
						
						getServicio().remove(dieta);
						
						return "";
					}catch (Exception e)	{
						JsfUtil.addSuccessMessage(ResourceBundle.getBundle("/Bundle").getString("DietaCreated"));
						
					} 
					return "";
					
				}
		
		
		
		
		
		/**
		 * Returns the instance for the servicio EJB
		 *
		 * @return current instance for servicio attribute
		 */
					public  Servicio2 getServicio(){
		return servicio;
		}
		/**
		 * Sets the value for the servicio EJB
		 * @param servicio The value to set
		 */
					public void setServicio( Servicio2  servicio){
		this.servicio=servicio;
		} 
	
	}
		
