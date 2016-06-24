package common.services.impl;				

	
import java.util.*;
import java.io.Serializable;
import javax.ejb.Stateless;
import common.services.interfaces.Persistence;



/**
 * This class represents an EJB named PersistenceImpl
 */
@Stateless
public class PersistenceImpl<T>  implements Persistence<T>,Serializable{

	/**
	 * Class Object represented by "T" class parameter
	 */
	private Class<T> clazzTObject;
	
	
	/**
	 * Service default constructor for Generic types
	 *
	 * @param clazzTObject It's the generic clazz for 'T' generic parameter 
	 */
	public PersistenceImp(Class<T> clazzTObject){
		this.clazzTObject=clazzTObject;
	}
	
	/**
	 * Service default constructor
	 */
	public PersistenceImpl(){
	}
	
	/**
	 * This method executes the proper actions for remove
	 * @param obj Parameter from type T
	 */
	@Override
	public void remove(T obj){
	}
	/**
	 * This method executes the proper actions for remove
	 * @param id Parameter from type Integer
	 */
	@Override
	public void remove(Long id){
	}
	/**
	 * This method executes the proper actions for create
	 * @param obj Parameter from type T
	 */
	@Override
	public void create(T obj){
	}
	/**
	 * This method executes the proper actions for findAll
	 * @return Some Array<T> object
	 */
	@Override
	public Array<T> findAll(){
		return null;
	}
	/**
	 * This method executes the proper actions for findAllExcept
	 * @param elementsToExclude Parameter from type Collection
	 * @return Some Array<T> object
	 */
	@Override
	public Array<T> findAllExcept(List<T> elementsToExclude){
		return null;
	}
	/**
	 * This method executes the proper actions for isPersistent
	 * @param obj Parameter from type T
	 * @return Some Boolean object
	 */
	@Override
	public Boolean isPersistent(T obj){
		return null;
	}
	/**
	 * This method executes the proper actions for find
	 * @param id Parameter from type Integer
	 * @return Some T object
	 */
	@Override
	public T find(Long id){
		return null;
	}
	/**
	 * This method executes the proper actions for save
	 * @param obj Parameter from type T
	 */
	@Override
	public void save(T obj){
	}
	/**
	 * This method executes the proper actions for findRange
	 * @param rangeSize Parameter from type Integer
	 * @param from Parameter from type Integer
	 * @return Some Array<T> object
	 */
	@Override
	public Array<T> findRange(Long rangeSize,Long from){
		return null;
	}
	/**
	 * This method executes the proper actions for count
	 * @return Some Long object
	 */
	@Override
	public Long count(){
		return null;
	}
	/**
	 * This method executes the proper actions for addToCollection
	 * @param container Parameter from type Any
	 * @param collection Parameter from type Collection
	 * @param obj Parameter from type T
	 */
	@Override
	public void addToCollection(Object container,List<T> collection,T obj){
	}
	/**
	 * This method executes the proper actions for removeFromCollection
	 * @param container Parameter from type Any
	 * @param collection Parameter from type Collection
	 * @param obj Parameter from type T
	 */
	@Override
	public void removeFromCollection(Object container,List<T> collection,T obj){
	}
	/**
	 * This method executes the proper actions for assignToAttribute
	 * @param container Parameter from type Any
	 * @param attribute Parameter from type String
	 * @param obj Parameter from type T
	 */
	@Override
	public void assignToAttribute(Object container,String attribute,T obj){
	}
}	

	
