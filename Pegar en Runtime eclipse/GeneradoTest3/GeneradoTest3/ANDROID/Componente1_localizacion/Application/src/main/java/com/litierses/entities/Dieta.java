	package com.litierses.entities;
	
	import java.io.Serializable;

	public  class Dieta implements Serializable {
		
		private Long id = null;
		private String nombre;
		private String desayuno;
		private String almuerzo;
		private String cena;
		private String merienda;
		
		public Dieta(){
		}

		public Dieta(String nombre,String desayuno,String almuerzo,String cena,String merienda){
			setNombre(nombre);
			setDesayuno(desayuno);
			setAlmuerzo(almuerzo);
			setCena(cena);
			setMerienda(merienda);
		}
		
		public String getNombre(){
			return nombre;
		}
		
		public void setNombre(String nombre){
			this.nombre=nombre;
		}
		
		public String getDesayuno(){
			return desayuno;
		}
		
		public void setDesayuno(String desayuno){
			this.desayuno=desayuno;
		}
		
		public String getAlmuerzo(){
			return almuerzo;
		}
		
		public void setAlmuerzo(String almuerzo){
			this.almuerzo=almuerzo;
		}
		
		public String getCena(){
			return cena;
		}
		
		public void setCena(String cena){
			this.cena=cena;
		}
		
		public String getMerienda(){
			return merienda;
		}
		
		public void setMerienda(String merienda){
			this.merienda=merienda;
		}
	
		public Long getId() {
			return id;
		}
			
		public void setId(final Long id) {
			this.id = id;
		}
		
		@Override
		public boolean equals(Object obj) {
			if (this == obj) {
				return true;
			}
			if (obj == null) {
				return false;
			}
			if (!(obj instanceof Dieta)) {
				return false;
			}
			final Dieta other = (Dieta) obj;
			if (id == null) {
				if (other.id != null) {
					return false;
				}
			} else if (!id.equals(other.id)) {
				return false;
			}
			return true;
		}
		
		@Override
		public int hashCode() {
			int hash = 0;
			hash += (id != null ? id.hashCode() : 0);
			return hash;
		}	

		@Override
			public String toString() {
    				return "com.litierses.entities.Dieta [ id=" + id + " ]";
		}
			
	}
