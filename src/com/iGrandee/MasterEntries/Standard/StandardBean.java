package com.iGrandee.MasterEntries.Standard;




// Referenced classes of package com.iGrandee.Common:
//            CommonDataAccess

public class StandardBean
{
	public  StandardBean()
	{
		standardid="";
		standardname="";
		description="";
		instituteid="";
		groupstatus="";
		createdby="";
		dateofcreation="";
		ipaddress="";
		standardstatus="";
		boardid="";
	}
	
	
	public String getStandardid() {
		return standardid;
	}
	public void setStandardid(String standardid) {
		this.standardid = standardid;
	}
	public String getStandardname() {
		return standardname;
	}
	public void setStandardname(String standardname) {
		this.standardname = standardname;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	public String getGroupstatus() {
		return groupstatus;
	}
	public void setGroupstatus(String groupstatus) {
		this.groupstatus = groupstatus;
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
	public String getStandardstatus() {
		return standardstatus;
	}
	public void setStandardstatus(String standardstatus) {
		this.standardstatus = standardstatus;
	}
	public String getBoardid() {
		return boardid;
	}
	public void setBoardid(String boardid) {
		this.boardid = boardid;
	}
	String standardid;
	String standardname;
	String description;
	String instituteid;
	String groupstatus;
	String createdby;
	String dateofcreation;
	String ipaddress;
	String standardstatus;
	String boardid;
}