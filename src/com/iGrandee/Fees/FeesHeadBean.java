
package com.iGrandee.Fees;




public class FeesHeadBean
{
	public FeesHeadBean()
	{
		feesheadid = null;
		feesheadname = null;
		createdby = null;
		instituteid	= null;
		dateofcreation	= null;
		feesheadstatus = null;
		feesoperation = null;
	}
	
	public String getFeesheadname() {
		return feesheadname;
	}
	public void setFeesheadname(String feesheadname) {
		this.feesheadname = feesheadname;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	public String getDateofcreation() {
		return dateofcreation;
	}
	public void setDateofcreation(String dateofcreation) {
		this.dateofcreation = dateofcreation;
	}
	public String getFeesheadstatus() {
		return feesheadstatus;
	}
	public void setFeesheadstatus(String feesheadstatus) {
		this.feesheadstatus = feesheadstatus;
	}
	public String getFeesoperation() {
		return feesoperation;
	}
	public void setFeesoperation(String feesoperation) {
		this.feesoperation = feesoperation;
	}
	public String getFeesheadid() {
		return feesheadid;
	}

	public void setFeesheadid(String feesheadid) {
		this.feesheadid = feesheadid;
	}
	
	
	
	
	String feesoperation;
	String feesheadid;
	String feesheadname;
	String createdby;
	String instituteid;
	String dateofcreation;
	String feesheadstatus;
	
	
}