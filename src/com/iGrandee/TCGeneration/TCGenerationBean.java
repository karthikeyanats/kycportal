
package com.iGrandee.TCGeneration;




public class TCGenerationBean
{
	public TCGenerationBean()
	{

	}

	public long getStudentallocationid() {
		return studentallocationid;
	}
	public void setStudentallocationid(long studentallocationid) {
		this.studentallocationid = studentallocationid;
	}

	public long getTcissueid() {
		return tcissueid;
	}
	public void setTcissueid(long tcissueid) {
		this.tcissueid = tcissueid;
	}
	
	public String getReason() {
		return reason;
	}
	public void setReason(String reason) {
		this.reason = reason;
	}
	
	public String getTcissuedate() {
		return tcissuedate;
	}
	public void setTcissuedate(String tcissuedate) {
		this.tcissuedate = tcissuedate;
	}
	
	public long getCreatedby() {
		return createdby;
	}
	public void setCreatedby(long createdby) {
		this.createdby = createdby;
	}
	
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}

	public String getTcissuestatus() {
		return tcissuestatus;
	}
	public void setTcissuestatus(String tcissuestatus) {
		this.tcissuestatus = tcissuestatus;
	}
	
	private long studentallocationid;
	private long tcissueid;
	private String reason;
	private String tcissuedate;
	private long createdby;
	private String ipaddress;
	private String tcissuestatus;
	
 
		
}