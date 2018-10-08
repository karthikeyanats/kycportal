package com.iGrandee.TimeTable.PeriodTime;

public class WorkAllotmentBean {
	
	public WorkAllotmentBean(){
		
	}
	
	
	public String[] getStaffids() {
		return staffids;
	}
	public void setStaffids(String[] staffids) {
		this.staffids = staffids;
	}
	public String[] getNoofhours() {
		return noofhours;
	}
	public void setNoofhours(String[] noofhours) {
		this.noofhours = noofhours;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
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
	public String getWorkallotmenstatus() {
		return workallotmenstatus;
	}
	public void setWorkallotmenstatus(String workallotmenstatus) {
		this.workallotmenstatus = workallotmenstatus;
	}
	
	
	private String staffids[]			= null; 
	private String noofhours[]			= null; 
	private String sessionid			= null; 
	private String createdby			= null; 
	private String ipaddress			= null; 
	private String workallotmenstatus	= null;

}
