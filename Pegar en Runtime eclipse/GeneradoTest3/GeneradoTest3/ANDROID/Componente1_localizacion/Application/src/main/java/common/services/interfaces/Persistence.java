package common.services.interfaces;		

import java.util.*;

public interface Persistence<T> {
	
	public ArrayList<T> findAll();

	public void create(T obj);

	public void remove(T obj);

	public void save(T obj);

}	

