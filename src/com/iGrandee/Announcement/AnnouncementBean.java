package com.iGrandee.Announcement;

public class AnnouncementBean   
{
	public AnnouncementBean()  
    {
    }

    
  
	public String[] getAnnouncementid() {
		return announcementid;
	}
	public void setAnnouncementid(String[] announcementid) {
		this.announcementid = announcementid;
	}
	public String[] getAnnoucementdetails() {
		return annoucementdetails;
	}
	public void setAnnoucementdetails(String[] annoucementdetails) {
		this.annoucementdetails = annoucementdetails;
	}
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}
	public String getDateofcreation() {
		return dateofcreation;
	}
	public void setDateofcreation(String dateofcreation) {
		this.dateofcreation = dateofcreation;
	}
	public String getAnnouncementstatus() {
		return announcementstatus;
	}
	public void setAnnouncementstatus(String announcementstatus) {
		this.announcementstatus = announcementstatus;
	}
	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getannouncementidd() {
		return announcementidd;
	}
	public void setannouncementidd(String announcementidd) {
		this.announcementidd = announcementidd;
	}
	  private String[] announcementid= null;
	    private String[] annoucementdetails= null;
	    private String instituteid= null;
	    private String createdby= null;
	    private String ipaddress= null;
	    private String dateofcreation= null;
	    private String announcementstatus= null;
	    private String mode= null;
	    private String announcementidd= null;
}
