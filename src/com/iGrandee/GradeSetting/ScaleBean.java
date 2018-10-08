package com.iGrandee.GradeSetting;

public class ScaleBean
{
	public ScaleBean()
    {
    }
	
	 public String getScaleid() {
		return scaleid;
	}
	public void setScaleid(String scaleid) {
		this.scaleid = scaleid;
	}
	public String getScalename() {
		return scalename;
	}
	public void setScalename(String scalename) {
		this.scalename = scalename;
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
	public String getScalestatus() {
		return scalestatus;
	}
	public void setScalestatus(String scalestatus) {
		this.scalestatus = scalestatus;
	}
	public String[] getScalename_Array() {
		return scalename_Array;
	}

	public void setScalename_Array(String[] scalename_Array) {
		this.scalename_Array = scalename_Array;
	}
	
	public String getBoardid() {
		return boardid;
	}
	public void setBoardid(String boardid) {
		this.boardid = boardid;
	}
	
	public String getInstituteid() {
		return instituteid;
	}

	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
		private String scaleid= null;
	    private String scalename= null;
	    private String createdby= null;
	    private String dateofcreation= null;
	    private String scalestatus= null;
	    public String[] scalename_Array= null;
		private String instituteid= null;
		private String boardid= null;

		

	 
}