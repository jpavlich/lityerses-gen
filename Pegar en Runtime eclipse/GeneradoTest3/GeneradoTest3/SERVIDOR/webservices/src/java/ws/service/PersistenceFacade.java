package  ws.service;		
		
import java.util.List;
import javax.persistence.EntityManager;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

 
public abstract class PersistenceFacade<T>  {
	private Class<T> entityClass;
	
	public PersistenceFacade(Class<T> entityClass) {
	        this.entityClass = entityClass;
	    }
	
	protected abstract EntityManager getEntityManager();    
	
	@POST
	@Path("ws_arraylist_findAll_void")
	@Produces({"application/json"})
	public List<T> findAll(){
		//Secci�n para implementar el m�todo
		
	}
	
	@POST
	@Path("ws_void_create_t")
	@Consumes({"application/json"})	
	public void create(T obj){
		//Secci�n para implementar el m�todo
		
	}
	
	@POST
	@Path("ws_void_remove_t")
	@Consumes({"application/json"})	
	public void remove(T obj){
		//Secci�n para implementar el m�todo
		
	}
	
	@POST
	@Path("ws_void_save_t")
	@Consumes({"application/json"})	
	public void save(T obj){
		//Secci�n para implementar el m�todo
		
	}
	
}	

	
