package  ws.service;		
		
import java.util.List;
import javax.ejb.Stateless;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

@Stateless
@Path("ws.Persistence")

public class Persistence {
	
	@GET
	@Path("remove")
	Produces({"application/json"})  
	public void remove(T obj){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("remove")
	Produces({"application/json"})  
	public void remove(Long id){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("create")
	Produces({"application/json"})  
	public void create(T obj){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("findAll")
	Produces({"application/json"})  
	public Array<T> findAll(){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("findAllExcept")
	Produces({"application/json"})  
	public Array<T> findAllExcept(List<T> elementsToExclude){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("isPersistent")
	Produces({"application/json"})  
	public Boolean isPersistent(T obj){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("find")
	Produces({"application/json"})  
	public T find(Long id){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("save")
	Produces({"application/json"})  
	public void save(T obj){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("findRange")
	Produces({"application/json"})  
	public Array<T> findRange(Long rangeSize,Long from){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("count")
	Produces({"application/json"})  
	public Long count(){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("addToCollection")
	Produces({"application/json"})  
	public void addToCollection(Object container,List<T> collection,T obj){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("removeFromCollection")
	Produces({"application/json"})  
	public void removeFromCollection(Object container,List<T> collection,T obj){
			//Secci�n para implementar el m�todo
		}
	
	@GET
	@Path("assignToAttribute")
	Produces({"application/json"})  
	public void assignToAttribute(Object container,String attribute,T obj){
			//Secci�n para implementar el m�todo
		}
	
}	

	
