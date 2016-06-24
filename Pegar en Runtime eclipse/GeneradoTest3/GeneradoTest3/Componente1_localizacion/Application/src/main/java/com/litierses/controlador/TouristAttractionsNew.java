package com.litierses.controlador;
		
import com.litierses.controlador.util.JsfUtil;

import com.litierses.entidad.AttractionNew;

public class TouristAttractionsNew {
	private  AttractionNew__General__ persistence;
	private List <AttractionNew>attractionList;
	private AttractionNew attraction=new AttractionNew();


	
	
	public List<AttractionNew> getAttractionList(){						
		return attractionList;
	}

	public void setAttractionList(List<AttractionNew> attractionList){
		this.attractionList=attractionList;
	}

	public AttractionNew getAttraction(){
		return attraction;
	}
	
	public void setAttraction(AttractionNew attraction){
		this.attraction=attraction;
	}

	/**
	 * Returns the instance for the persistence EJB
	 *
	 * @return current instance for persistence attribute
	 */
			public  AttractionNew__General__ getPersistence(){
	return persistence;
	}
	/**
	 * Sets the value for the persistence EJB
	 * @param persistence The value to set
	 */
			public void setPersistence( AttractionNew__General__  persistence){
	this.persistence=persistence;
	} 

}
