package com.iGrandee.MasterEntries.Community;

import java.util.ArrayList;
public class CommunityBean
{
	public  CommunityBean()
	{
				
		 communityid="";
		 communityname="";
		 communitydescription="";
		 instituteid="";
		 dateofcreation="";
		commstatus="";
	}
	
	
	public String getCommunityid() {
		return communityid;
	}
	public void setCommunityid(String communityid) {
		this.communityid = communityid;
	}
	public String getCommunityname() {
		return communityname;
	}
	public void setCommunityname(String communityname) {
		this.communityname = communityname;
	}
	public String getCommunitydescription() {
		return communitydescription;
	}
	public void setCommunitydescription(String communitydescription) {
		this.communitydescription = communitydescription;
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
	public String getCommstatus() {
		return commstatus;
	}
	public void setCommstatus(String commstatus) {
		this.commstatus = commstatus;
	}
	public String getCreatedby() {
		return createdby;
	}


	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	String communityid;
	String communityname;
	String communitydescription;
	String instituteid;
	String dateofcreation;
	String commstatus;
	String createdby;
	
}