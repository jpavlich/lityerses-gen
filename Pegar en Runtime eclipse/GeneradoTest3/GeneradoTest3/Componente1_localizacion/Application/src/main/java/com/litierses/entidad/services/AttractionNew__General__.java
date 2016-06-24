package com.litierses.entidad.services;		



import java.util.*;
import javax.ejb.Local;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;	
import javax.persistence.PersistenceContext;
import co.edu.javeriana.sesion.Persistence;
import com.litierses.entidad.AttractionNew;

	
@Stateless
public class AttractionNew__General__ extends Persistence<AttractionNew>{
	    @PersistenceContext(unitName = "co.edu.javeriana.javemovil_javemovil-web_war_1.0-SNAPSHOTPU")
    			private EntityManager em;

	    @Override
	    protected EntityManager getEntityManager() {
	        return em;
	    }
	
	    public AttractionNew__General__() {
	        super(AttractionNew.class);
	    }
	
}	

	
