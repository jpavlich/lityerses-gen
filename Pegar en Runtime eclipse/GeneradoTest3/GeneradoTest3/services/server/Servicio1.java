package  ws.service;		
		
import java.util.List;
import javax.ejb.Stateless;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;

@Stateless
@Path("ws.Servicio1")

public class Servicio1 {
	
	@GET
	@Path("remove")
	Produces({"application/json"})  
	public void remove(T obj){
			//Sección para implementar el método
		}
	
}	

	
