package com.iGrandee.PhotoGallery;

public class PhotoGalleryBean
{
    public PhotoGalleryBean()
    {
    }
   
    
	public static String getEventphotogalleryid() {
		return eventphotogalleryid;
	}
	public static void setEventphotogalleryid(String eventphotogalleryid) {
		PhotoGalleryBean.eventphotogalleryid = eventphotogalleryid;
	}

	public static String getExtracurricularcurriculareventid() {
		return extracurricularcurriculareventid;
	}
	public static void setExtracurricularcurriculareventid(String extracurricularcurriculareventid) {
		PhotoGalleryBean.extracurricularcurriculareventid = extracurricularcurriculareventid;
	}
	
	
	public static String  getcaption() {
		return Caption;
	}
	public static void setcaption(String Caption) {
		PhotoGalleryBean.Caption = Caption;
	}
	
	
	public static String [] getCaption() {
		return caption;
	}
	public static void setCaption(String [] caption) {
		PhotoGalleryBean.caption = caption;
	}
	public static String [] getGallerypath() {
		return gallerypath;
	}
	public static void setGallerypath(String [] gallerypath) {
		PhotoGalleryBean.gallerypath = gallerypath;
	}
	
	public static String getgallerypath() {
		return Gallerypath;
	}
	public static void setGallerypath(String  Gallerypath) {
		PhotoGalleryBean.Gallerypath = Gallerypath;
	}
	
	
	public static String  getDateofcreation() {
		return dateofcreation;
	}
	public static void setDateofcreation(String dateofcreation) {
		PhotoGalleryBean.dateofcreation = dateofcreation;
	}
	public static String getCreatedby() {
		return createdby;
	}
	public static void setCreatedby(String createdby) {
		PhotoGalleryBean.createdby = createdby;
	}
	public static String getSessionid() {
		return sessionid;
	}
	public static void setSessionid(String sessionid) {
		PhotoGalleryBean.sessionid = sessionid;
	}
	public static String getGallerystatus() {
		return gallerystatus;
	}
	public static void setGallerystatus(String gallerystatus) {
		PhotoGalleryBean.gallerystatus = gallerystatus;
	}
	public static String[] getPhotoname() {
		return photoname;
	}
	public static void setPhotoname(String[] photoname) {
		PhotoGalleryBean.photoname = photoname;
	} 

	

	private static String eventphotogalleryid = null;
    private static String extracurricularcurriculareventid = null;
    private static String [] caption = null;
    private static String [] gallerypath = null;
    private static String  Gallerypath = null;
    private static String  Caption = null;
    private static String dateofcreation = null;
    private static String createdby = null;
    private static String sessionid = null;
    private static String gallerystatus = null; 
    private static String [] photoname = null;
	
  
}



    
