package com.iGrandee.Fees;




public class TermFeesBean
{
	public TermFeesBean()
	{
		termfeesid = null;
		termid = null;
		standardscheduleid = null;
		termfeesamount	= null;
		createdby	= null;
		dateofcreation = null;
		termfeesstatus = null;
	}
	

	public String getTermfeesid() {
		return termfeesid;
	}
	public void setTermfeesid(String termfeesid) {
		this.termfeesid = termfeesid;
	}
	public String getTermid() {
		return termid;
	}
	public void setTermid(String termid) {
		this.termid = termid;
	}
	public String getStandardscheduleid() {
		return standardscheduleid;
	}
	public void setStandardscheduleid(String standardscheduleid) {
		this.standardscheduleid = standardscheduleid;
	}
	public String getTermfeesamount() {
		return termfeesamount;
	}
	public void setTermfeesamount(String termfeesamount) {
		this.termfeesamount = termfeesamount;
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
	public String getTermfeesstatus() {
		return termfeesstatus;
	}
	public void setTermfeesstatus(String termfeesstatus) {
		this.termfeesstatus = termfeesstatus;
	}
	public String getDuedate() {
		return duedate;
	}
	public void setDuedate(String duedate) {
		this.duedate = duedate;
	}
	
	private String termfeesid;
	private String termid;
	private String standardscheduleid;
	private String termfeesamount;
	private String createdby;
	private String dateofcreation;
	private String termfeesstatus;
	private String duedate;
	
}