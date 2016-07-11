package com.litierses.entities.services;		

import com.litierses.entities.Dieta;
import common.services.impl.PersistenceImpl;
import com.litierses.Utilidades.acceso_BD;

public class Dieta__General__ extends PersistenceImpl<Dieta>{
	
	public Dieta__General__(){
	        clazzTObject = Dieta.class;
	        urlWebservice = acceso_BD.server+"ws.persistence_Dieta/";
	    }
}	
