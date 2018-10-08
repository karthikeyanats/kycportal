
package com.iGrandee.Fees;


public class FeesScheduleBean
{
	public FeesScheduleBean()
	{
		feesscheduleid = null;
		feesheadid = null;
		standardscheduleid = null;
		feesscheduleamount	= null;
		dateofcreation	= null;
		createdby = null;
		feesschedulestatus = null;
	}
	
	
	public String getFeesscheduleid() {
		return feesscheduleid;
	}
	public void setFeesscheduleid(String feesscheduleid) {
		this.feesscheduleid = feesscheduleid;
	}
	public String getFeesheadid() {
		return feesheadid;
	}
	public void setFeesheadid(String feesheadid) {
		this.feesheadid = feesheadid;
	}
	public String getStandardscheduleid() {
		return standardscheduleid;
	}
	public void setStandardscheduleid(String standardscheduleid) {
		this.standardscheduleid = standardscheduleid;
	}
	public String getFeesscheduleamount() {
		return feesscheduleamount;
	}
	public void setFeesscheduleamount(String feesscheduleamount) {
		this.feesscheduleamount = feesscheduleamount;
	}
	public String getDateofcreation() {
		return dateofcreation;
	}
	public void setDateofcreation(String dateofcreation) {
		this.dateofcreation = dateofcreation;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getFeesschedulestatus() {
		return feesschedulestatus;
	}
	public void setFeesschedulestatus(String feesschedulestatus) {
		this.feesschedulestatus = feesschedulestatus;
	}
	
	String feesscheduleid;
	String feesheadid;
	String standardscheduleid;
	String feesscheduleamount;
	String dateofcreation;
	String createdby;
	String feesschedulestatus;
}