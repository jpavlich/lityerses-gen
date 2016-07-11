package ws.service;				

import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import ws.Dieta;		

@Stateless
@Path("ws.persistence_Dieta")
public class Persistence_Dieta_ extends PersistenceFacade<Dieta> {
	@PersistenceContext(unitName = "webservicesPU")
	private EntityManager em;
	
	public Persistence_Dieta_(){
	        super(Dieta.class);
	}
	
	@Override
	protected EntityManager getEntityManager() {
		return em;
	}
}	
