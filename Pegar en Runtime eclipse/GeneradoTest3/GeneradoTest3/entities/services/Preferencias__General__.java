package entities.services;		



import java.util.*;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;	
import javax.persistence.PersistenceContext;
import co.edu.javeriana.sesion.Persistence;
import entities.Preferencias;

	
@Stateless
public class Preferencias__General__ extends Persistence<Preferencias>{
	    @PersistenceContext(unitName = "co.edu.javeriana.javemovil_javemovil-web_war_1.0-SNAPSHOTPU")
    			private EntityManager em;

	    @Override
	    public EntityManager getEntityManager() {
	        return em;
	    }
	
	    public Preferencias__General__() {
	        super(Preferencias.class);
	    }
	
}	

	
