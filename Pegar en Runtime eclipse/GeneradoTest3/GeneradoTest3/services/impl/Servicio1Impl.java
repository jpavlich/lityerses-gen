package services.impl;				

	
import java.util.*;
import java.io.Serializable;
import javax.ejb.Stateless;
import services.interfaces.Servicio1;



/**
 * This class represents an EJB named Servicio1Impl
 */
@Stateless
public class Servicio1Impl<T>  implements Servicio1<T>,Serializable{

	/**
	 * Class Object represented by "T" class parameter
	 */
	private Class<T> clazzTObject;
	
	
	/**
	 * Service default constructor for Generic types
	 *
	 * @param clazzTObject It's the generic clazz for 'T' generic parameter 
	 */
	public Servicio1Imp(Class<T> clazzTObject){
		this.clazzTObject=clazzTObject;
	}
	
	/**
	 * Service default constructor
	 */
	public Servicio1Impl(){
	}
	
	/**
	 * This method executes the proper actions for remove
	 * @param obj Parameter from type T
	 */
	@Override
	public void remove(T obj){
	}
}	

	
