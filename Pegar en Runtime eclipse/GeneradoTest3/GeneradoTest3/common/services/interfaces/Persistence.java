package common.services.interfaces;		


import java.util.*;
import javax.ejb.Local;

/**
 * This interface represents the local instance for the PersistenceBean EJB 
 */
@Local
public interface Persistence<T> {
	
	/**
	 * This method executes the proper actions for remove
	 * @param obj Parameter from type T
	 */
	public void remove(T obj);
	/**
	 * This method executes the proper actions for remove
	 * @param id Parameter from type Integer
	 */
	public void remove(Long id);
	/**
	 * This method executes the proper actions for create
	 * @param obj Parameter from type T
	 */
	public void create(T obj);
	/**
	 * This method executes the proper actions for findAll
	 * @return Some Array<T> object
	 */
	public Array<T> findAll();
	/**
	 * This method executes the proper actions for findAllExcept
	 * @param elementsToExclude Parameter from type Collection
	 * @return Some Array<T> object
	 */
	public Array<T> findAllExcept(List<T> elementsToExclude);
	/**
	 * This method executes the proper actions for isPersistent
	 * @param obj Parameter from type T
	 * @return Some Boolean object
	 */
	public Boolean isPersistent(T obj);
	/**
	 * This method executes the proper actions for find
	 * @param id Parameter from type Integer
	 * @return Some T object
	 */
	public T find(Long id);
	/**
	 * This method executes the proper actions for save
	 * @param obj Parameter from type T
	 */
	public void save(T obj);
	/**
	 * This method executes the proper actions for findRange
	 * @param rangeSize Parameter from type Integer
	 * @param from Parameter from type Integer
	 * @return Some Array<T> object
	 */
	public Array<T> findRange(Long rangeSize,Long from);
	/**
	 * This method executes the proper actions for count
	 * @return Some Long object
	 */
	public Long count();
	/**
	 * This method executes the proper actions for addToCollection
	 * @param container Parameter from type Any
	 * @param collection Parameter from type Collection
	 * @param obj Parameter from type T
	 */
	public void addToCollection(Object container,List<T> collection,T obj);
	/**
	 * This method executes the proper actions for removeFromCollection
	 * @param container Parameter from type Any
	 * @param collection Parameter from type Collection
	 * @param obj Parameter from type T
	 */
	public void removeFromCollection(Object container,List<T> collection,T obj);
	/**
	 * This method executes the proper actions for assignToAttribute
	 * @param container Parameter from type Any
	 * @param attribute Parameter from type String
	 * @param obj Parameter from type T
	 */
	public void assignToAttribute(Object container,String attribute,T obj);
}	

	
