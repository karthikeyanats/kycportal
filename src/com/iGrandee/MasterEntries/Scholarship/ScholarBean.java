package com.iGrandee.MasterEntries.Scholarship;

public class ScholarBean
{
	public  ScholarBean()
	{
	 scholarshipid="";
	 scholarshipname="";
	 scholarshipdescription="";
	 instituteid="";
	 ipaddress="";
	 createdby="";
	 dateofcreation="";
	 scholarshipstatus="";
	}
	public String getScholarshipid() {
		return scholarshipid;
	}
	public void setScholarshipid(String scholarshipid) {
		this.scholarshipid = scholarshipid;
	}
	public String getScholarshipname() {
		return scholarshipname;
	}
	public void setScholarshipname(String scholarshipname) {
		this.scholarshipname = scholarshipname;
	}
	public String getScholarshipdescription() {
		return scholarshipdescription;
	}
	public void setScholarshipdescription(String scholarshipdescription) {
		this.scholarshipdescription = scholarshipdescription;
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
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}
	public String getScholarshipstatus() {
		return scholarshipstatus;
	}
	public void setScholarshipstatus(String scholarshipstatus) {
		this.scholarshipstatus = scholarshipstatus;
	}
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	String scholarshipid;
	String scholarshipname;
	String scholarshipdescription;
	String createdby;
	String dateofcreation;
	String ipaddress;
	String scholarshipstatus;
	String instituteid;
		
}
