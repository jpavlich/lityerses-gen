package ws.service;

import java.util.List;
import javax.persistence.EntityManager;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;

public abstract class PersistenceFacade<T> {
    private Class<T> entityClass;

    public PersistenceFacade(Class<T> entityClass) {
        this.entityClass = entityClass;
    }

    protected abstract EntityManager getEntityManager();
	
	@POST
	@Path("findall")
	@Produces({"application/json"})
	public List<T> findAll() {
        javax.persistence.criteria.CriteriaQuery cq = getEntityManager().getCriteriaBuilder().createQuery();
        cq.select(cq.from(entityClass));
        return getEntityManager().createQuery(cq).getResultList();
    }  
	
	@POST
	@Path("create")
	@Consumes({"application/json"})	
    public void create(T entity) {
        getEntityManager().persist(entity);
    }
	
	@POST
	@Path("remove")
	@Consumes({"application/json"})	
	public void remove(T entity) {
        getEntityManager().remove(getEntityManager().merge(entity));
    }
	
	@POST
	@Path("save")
	@Consumes({"application/json"})	
    public void save(T entity) {
        getEntityManager().merge(entity);
    }
      
}
