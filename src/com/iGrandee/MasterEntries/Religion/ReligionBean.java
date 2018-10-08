package com.iGrandee.MasterEntries.Religion;

import java.util.ArrayList;
public class ReligionBean
{
	public  ReligionBean()
	{
		 religionid="";
		 religionname="";
		 religiondescription="";
		 instituteid="";
		 dateofcreation="";
		 relistatus="";
	}
	 	public String getReligionid() {
		return religionid;
	}
	public void setReligionid(String religionid) {
		this.religionid = religionid;
	}
	public String getReligionname() {
		return religionname;
	}
	public void setReligionname(String religionname) {
		this.religionname = religionname;
	}
	public String getReligiondescription() {
		return religiondescription;
	}
	public void setReligiondescription(String religiondescription) {
		this.religiondescription = religiondescription;
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
	public String getRelistatus() {
		return relistatus;
	}
	public void setRelistatus(String relistatus) {
		this.relistatus = relistatus;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	 String religionid;
	 String religionname;
	 String religiondescription;
	 String instituteid;
	 String dateofcreation;
	 String relistatus;
	 String createdby;
	
	 
}
