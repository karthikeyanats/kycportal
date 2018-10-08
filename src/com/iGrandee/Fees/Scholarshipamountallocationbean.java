package com.iGrandee.Fees;

public class Scholarshipamountallocationbean {
	
	public Scholarshipamountallocationbean(){}
	
	private String termfeesid=null;
	private String amount=null;
	private String standardscheduleid;
	private String scholarshipid;
	private String setAmountallocationstatus;
	private String createdby;
	private String scholarshipamountallocationid=null;
	/**
	 * @return the scholarshipamountallocationid
	 */
	public String getScholarshipamountallocationid() {
		return scholarshipamountallocationid;
	}
	/**
	 * @param scholarshipamountallocationid the scholarshipamountallocationid to set
	 */
	public void setScholarshipamountallocationid(
			String scholarshipamountallocationid) {
		this.scholarshipamountallocationid = scholarshipamountallocationid;
	}
	public String getSetAmountallocationstatus() {
		return setAmountallocationstatus;
	}
	public void setSetAmountallocationstatus(String setAmountallocationstatus) {
		this.setAmountallocationstatus = setAmountallocationstatus;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getTermfeesid() {
		return termfeesid;
	}
	public void setTermfeesid(String termfeesid) {
		this.termfeesid = termfeesid;
	}
	public String getAmount() {
		return amount;
	}
	public void setAmount(String amount) {
		this.amount = amount;
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
	
	
}