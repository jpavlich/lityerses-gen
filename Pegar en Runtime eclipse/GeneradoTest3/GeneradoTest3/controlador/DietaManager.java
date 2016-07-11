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
	
	
	import pages.services.ViewDieta__General__;
	import pages.*;
	
	
	import pages.services.DietaList__General__;
	import pages.*;
	
	
	import pages.services.EditDieta__General__;
	import pages.*;
	
						
	

	
	/**
	 * This class represents a controller with name DietaManager
	 */
	 
	@ManagedBean(name = "dietaManager")
	@RequestScoped
	
	public class DietaManager implements Serializable {
		
		/**
		 * The serialVersionUID
		 */
		private static final long serialVersionUID = 1L;
		
		
			/**
			 * Injection for the component named Persistence 
			 */
			@EJB
		
		private  Dieta__General__ persistence;
		
		
	    
		
		
			
		
				
	 @PostConstruct
	 public void init() {
	 	listAll();
																																									
																						    
	
			    
	  }
		
	
				/**
				 * Action method named listAll
				 *
				 * @return String value with some navigation outcome
				 */
		

				public String listAll(){

					try{
						
						this.dietas=getPersistence().findAll();
						return "goToDietaList";		
						
					}catch (Exception e)	{
						JsfUtil.addSuccessMessage(ResourceBundle.getBundle("/Bundle").getString("DietaCreated"));
						
					} 
					return "";
					
				}
				/**
				 * Action method named listDieta
				 * @param dietaList Parameter from type Collection
				 *
				 * @return String value with some navigation outcome
				 */
		

				public String listDieta( List  dietaList){

					try{
						
						
						this.dietas=dietaList;
						return "goToDietaList";		
						
					}catch (Exception e)	{
						JsfUtil.addSuccessMessage(ResourceBundle.getBundle("/Bundle").getString("DietaCreated"));
						
					} 
					return "";
					
				}
				/**
				 * Action method named viewDieta
				 * @param dieta Parameter from type Dieta
				 *
				 * @return String value with some navigation outcome
				 */
		

				public String viewDieta( Dieta dieta){

					try{
						
						
						;
						return "goToViewDieta";		
						
					}catch (Exception e)	{
						JsfUtil.addSuccessMessage(ResourceBundle.getBundle("/Bundle").getString("DietaCreated"));
						
					} 
					return "";
					
				}
				/**
				 * Action method named editDieta
				 * @param dieta Parameter from type Dieta
				 *
				 * @return String value with some navigation outcome
				 */
		

				public String editDieta( Dieta dieta){

					try{
						
						
						;
						return "goToEditDieta";		
						
					}catch (Exception e)	{
						JsfUtil.addSuccessMessage(ResourceBundle.getBundle("/Bundle").getString("DietaCreated"));
						
					} 
					return "";
					
				}
				/**
				 * Action method named createDieta
				 *
				 * @return String value with some navigation outcome
				 */
		

				public String createDieta(){

					try{
						
						this.dieta=new Dieta();
						return "goToEditDieta";		
						
					}catch (Exception e)	{
						JsfUtil.addSuccessMessage(ResourceBundle.getBundle("/Bundle").getString("DietaCreated"));
						
					} 
					return "";
					
				}
				/**
				 * Action method named saveDieta
				 * @param dieta Parameter from type Dieta
				 *
				 * @return String value with some navigation outcome
				 */
		

				public String saveDieta( Dieta dieta){

					try{
						
						
						if(1L == 1L){
							getPersistence().save(dieta);
							
						} else {
								getPersistence().create(dieta);
								
						}	
						return listAll();
						
					}catch (Exception e)	{
						JsfUtil.addSuccessMessage(ResourceBundle.getBundle("/Bundle").getString("DietaCreated"));
						
					} 
					return "";
					
				}
				/**
				 * Action method named deleteDieta
				 * @param dieta Parameter from type Dieta
				 *
				 * @return String value with some navigation outcome
				 */
		

				public String deleteDieta( Dieta dieta){

					try{
						
						
						getPersistence().remove(dieta);
						return listAll();
						
					}catch (Exception e)	{
						JsfUtil.addSuccessMessage(ResourceBundle.getBundle("/Bundle").getString("DietaCreated"));
						
					} 
					return "";
					
				}
		
		
		
		
		
		/**
		 * Returns the instance for the persistence EJB
		 *
		 * @return current instance for persistence attribute
		 */
					public  Dieta__General__ getPersistence(){
		return persistence;
		}
		/**
		 * Sets the value for the persistence EJB
		 * @param persistence The value to set
		 */
					public void setPersistence( Dieta__General__  persistence){
		this.persistence=persistence;
		} 
	
	}
		
