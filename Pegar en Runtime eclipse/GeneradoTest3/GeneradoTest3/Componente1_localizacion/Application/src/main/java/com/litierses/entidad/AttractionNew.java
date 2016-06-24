	package com.litierses.entidad;

		public  class AttractionNew  {

		public String name;
		public String description;
		public String longDescription;
		public String imageUrl;
		public String secondaryImageUrl;
		public String location;
		public String city;
		public String image;
		public String secondaryImage;
		public String distance;
		
		public AttractionNew(){ }
		
		public AttractionNew(String name,String description,String longDescription,String imageUrl,String secondaryImageUrl,String location,String city,String image,String secondaryImage,String distance){
			setName(name);
			setDescription(description);
			setLongDescription(longDescription);
			setImageUrl(imageUrl);
			setSecondaryImageUrl(secondaryImageUrl);
			setLocation(location);
			setCity(city);
			setImage(image);
			setSecondaryImage(secondaryImage);
			setDistance(distance);
		}
		public String getName()	{return name;}
		public void setName(String name)	{this.name=name;}
		
		public String getDescription()	{return description;}
		public void setDescription(String description)	{this.description=description;}
		
		public String getLongDescription()	{return longDescription;}
		public void setLongDescription(String longDescription)	{this.longDescription=longDescription;}
		
		public String getImageUrl()	{return imageUrl;}
		public void setImageUrl(String imageUrl)	{this.imageUrl=imageUrl;}
		
		public String getSecondaryImageUrl()	{return secondaryImageUrl;}
		public void setSecondaryImageUrl(String secondaryImageUrl)	{this.secondaryImageUrl=secondaryImageUrl;}
		
		public String getLocation()	{return location;}
		public void setLocation(String location)	{this.location=location;}
		
		public String getCity()	{return city;}
		public void setCity(String city)	{this.city=city;}
		
		public String getImage()	{return image;}
		public void setImage(String image)	{this.image=image;}
		
		public String getSecondaryImage()	{return secondaryImage;}
		public void setSecondaryImage(String secondaryImage)	{this.secondaryImage=secondaryImage;}
		
		public String getDistance()	{return distance;}
		public void setDistance(String distance)	{this.distance=distance;}
		
		}
