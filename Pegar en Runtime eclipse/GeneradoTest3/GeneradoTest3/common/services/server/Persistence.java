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
			//Sección para implementar el método
		}
	
	@GET
	@Path("remove")
	Produces({"application/json"})  
	public void remove(Long id){
			//Sección para implementar el método
		}
	
	@GET
	@Path("create")
	Produces({"application/json"})  
	public void create(T obj){
			//Sección para implementar el método
		}
	
	@GET
	@Path("findAll")
	Produces({"application/json"})  
	public Array<T> findAll(){
			//Sección para implementar el método
		}
	
	@GET
	@Path("findAllExcept")
	Produces({"application/json"})  
	public Array<T> findAllExcept(List<T> elementsToExclude){
			//Sección para implementar el método
		}
	
	@GET
	@Path("isPersistent")
	Produces({"application/json"})  
	public Boolean isPersistent(T obj){
			//Sección para implementar el método
		}
	
	@GET
	@Path("find")
	Produces({"application/json"})  
	public T find(Long id){
			//Sección para implementar el método
		}
	
	@GET
	@Path("save")
	Produces({"application/json"})  
	public void save(T obj){
			//Sección para implementar el método
		}
	
	@GET
	@Path("findRange")
	Produces({"application/json"})  
	public Array<T> findRange(Long rangeSize,Long from){
			//Sección para implementar el método
		}
	
	@GET
	@Path("count")
	Produces({"application/json"})  
	public Long count(){
			//Sección para implementar el método
		}
	
	@GET
	@Path("addToCollection")
	Produces({"application/json"})  
	public void addToCollection(Object container,List<T> collection,T obj){
			//Sección para implementar el método
		}
	
	@GET
	@Path("removeFromCollection")
	Produces({"application/json"})  
	public void removeFromCollection(Object container,List<T> collection,T obj){
			//Sección para implementar el método
		}
	
	@GET
	@Path("assignToAttribute")
	Produces({"application/json"})  
	public void assignToAttribute(Object container,String attribute,T obj){
			//Sección para implementar el método
		}
	
}	

	
