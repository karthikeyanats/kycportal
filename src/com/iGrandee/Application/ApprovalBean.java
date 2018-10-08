
package com.iGrandee.Application;




public class ApprovalBean
{
	public ApprovalBean()
	{

	}

	public String getStudentapprovalid() {
		return studentapprovalid;
	}
	public void setStudentapprovalid(String studentapprovalid) {
		this.studentapprovalid = studentapprovalid;
	}

	public String[] getRegistrationid() {
		return registrationid;
	}
	public void setRegistrationid(String[] registrationid) {
		this.registrationid = registrationid;
	}
	/*public String getRegistrationid() {
		return registrationid;
	}
	public void setRegistrationid(String registrationid) {
		this.registrationid = registrationid;
	}*/

	public long getStandardscheduleid() {
		return standardscheduleid;
	}
	public void setStandardscheduleid(long standardscheduleid) {
		this.standardscheduleid = standardscheduleid;
	}

	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}

	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}



	private String studentapprovalid;
	//private String registrationid;
	private String registrationid [];
	private long standardscheduleid;
	private String createdby;
	private String status;
	
	private String ipaddress;
	private String instituteid;
	
}