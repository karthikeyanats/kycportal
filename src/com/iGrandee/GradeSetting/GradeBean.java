package com.iGrandee.GradeSetting;

public class GradeBean
{
	public GradeBean()
    {
    }
	
	 public String getGradeid() {
		return gradeid;
	}
	public void setGradeid(String gradeid) {
		this.gradeid = gradeid;
	}
	
	public String getGradename() {
		return gradename;
	}
	public void setGradename(String gradename) {
		this.gradename = gradename;
	}
	
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	
	public String getDateofcreation() {
		return dateofcreation;
	}
	public void setDateofcreation(String dateofcreation) {
		this.dateofcreation = dateofcreation;
	}
	
	public String getGradestatus() {
		return gradestatus;
	}
	public void setGradestatus(String gradestatus) {
		this.gradestatus = gradestatus;
	}
	
	public String[] getGradename_Array() {
		return gradename_Array;
	}
	public void setGradename_Array(String[] gradename_Array) {
		this.gradename_Array = gradename_Array;
	}
	
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	
	public String getScaleid() {
		return scaleid;
	}
	public void setScaleid(String scaleid) {
		this.scaleid = scaleid;
	}
	
		private String gradeid= null;
	    private String gradename= null;
	    private String createdby= null;
	    private String dateofcreation= null;
	    private String gradestatus= null;
	    private String instituteid= null;
	    private String scaleid= null;
	    private String[] gradename_Array= null;

}