package com.iGrandee.Fees;

public class Allotmentbean {
	
	public Allotmentbean(){
		
		standardscheduleid=null;
		scholarshipid="";
		amount=null;
		createdby="";
		dateofcreation="";
		amountallocationstatus="";
	}

	 
	String standardscheduleid=null;
	String termfeesid=null;
	public String getTermfeesid() {
		return termfeesid;
	}
	public void setTermfeesid(String termfeesid) {
		this.termfeesid = termfeesid;
	}
	public String getStandardscheduleid() {
		return standardscheduleid;
	}
	public void setStandardscheduleid(String standardscheduleid) {
		this.standardscheduleid = standardscheduleid;
	}
	public String getScholarshipid() {
		return scholarshipid;
	}
	public void setScholarshipid(String scholarshipid) {
		this.scholarshipid = scholarshipid;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
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
	public String getAmountallocationstatus() {
		return amountallocationstatus;
	}
	public void setAmountallocationstatus(String amountallocationstatus) {
		this.amountallocationstatus = amountallocationstatus;
	}


	String scholarshipid=null;
	String amount=null;
	String createdby=null;
	String dateofcreation=null;
	String amountallocationstatus=null;
	String scholarshipamountallocationid;
	public String getScholarshipamountallocationid() {
		return scholarshipamountallocationid;
	}
	public void setScholarshipamountallocationid(
			String scholarshipamountallocationid) {
		this.scholarshipamountallocationid = scholarshipamountallocationid;
	}
}
