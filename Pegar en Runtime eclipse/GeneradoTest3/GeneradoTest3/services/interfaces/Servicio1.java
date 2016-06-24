package services.interfaces;		


import java.util.*;
import javax.ejb.Local;

/**
 * This interface represents the local instance for the Servicio1Bean EJB 
 */
@Local
public interface Servicio1<T> {
	
	/**
	 * This method executes the proper actions for remove
	 * @param obj Parameter from type T
	 */
	public void remove(T obj);
}	

	
