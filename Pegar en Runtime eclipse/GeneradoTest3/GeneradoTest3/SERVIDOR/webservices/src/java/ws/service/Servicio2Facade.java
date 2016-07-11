package  ws.service;		
		
import java.util.List;
import javax.persistence.EntityManager;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

 
public abstract class Servicio2Facade<T>  {
	private Class<T> entityClass;
	
	public PersistenceFacade(Class<T> entityClass) {
	        this.entityClass = entityClass;
	    }
	
	protected abstract EntityManager getEntityManager();    
	
	@POST
	@Path("ws_void_remove_t")
	@Consumes({"application/json"})	
	public void remove(T obj){
		//Sección para implementar el método
		
	}
	
}	

	
