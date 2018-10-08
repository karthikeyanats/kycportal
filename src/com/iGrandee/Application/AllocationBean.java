
package com.iGrandee.Application;




public class AllocationBean
{
	public AllocationBean()
	{

	}

	public String getStudentallocationid() {
		return studentallocationid;
	}
	public void setStudentallocationid(String studentallocationid) {
		this.studentallocationid = studentallocationid;
	}

	public String[] getCandidateregisterid() {
		return candidateregisterid;
	}
	public void setCandidateregisterid(String[] candidateregisterid) {
		this.candidateregisterid = candidateregisterid;
	}
	/*public String getCandidateregisterid() {
		return candidateregisterid;
	}
	public void setCandidateregisterid(String candidateregisterid) {
		this.candidateregisterid = candidateregisterid;
	}*/

	public long getSectionscheduleid() {
		return sectionscheduleid;
	}
	public void setSectionscheduleid(long sectionscheduleid) {
		this.sectionscheduleid = sectionscheduleid;
	}

	public String getRollno() {
		return rollno;
	}
	public void setRollno(String rollno) {
		this.rollno = rollno;
	}

	public String getStudentcurrentstatus() {
		return studentcurrentstatus;
	}
	public void setStudentcurrentstatus(String studentcurrentstatus) {
		this.studentcurrentstatus = studentcurrentstatus;
	}

	public String getStudentallocationstatus() {
		return studentallocationstatus;
	}
	public void setStudentallocationstatus(String studentallocationstatus) {
		this.studentallocationstatus = studentallocationstatus;
	}

	public String getRegistrationnumber() {
		return registrationnumber;
	}
	public void setRegistrationnumber(String registrationnumber) {
		this.registrationnumber = registrationnumber;
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
	
	public long getStandardscheduleid() {
		return standardscheduleid;
	}
	public void setStandardscheduleid(long standardscheduleid) {
		this.standardscheduleid = standardscheduleid;
	}	
	
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}

	private String studentallocationid;
	//private String candidateregisterid;
	private String candidateregisterid [];
	private long sectionscheduleid;
	private String rollno;
	private String studentcurrentstatus;
	private long standardscheduleid;
	private String createdby;
	private String ipaddress;
	private String instituteid;
	private String studentallocationstatus;
	private String registrationnumber;
	
}