package com.iGrandee.Library.MasterEntries.Access;

import com.iGrandee.Library.MasterEntries.Access.AccessBean;

public class AccessBean
{
	 public AccessBean()
	 {
	 }
	
	
	public static String getAccessid() {
		return accessid;
	}
	public static void setAccessid(String accessid) {
		AccessBean.accessid = accessid;
	}
	
	public static String getRenewdays() {
		return renewdays;
	}
	public static void setRenewdays(String renewdays) {
		AccessBean.renewdays = renewdays;
	}
	public static String getReturndays() {
		return returndays;
	}
	public static void setReturndays(String returndays) {
		AccessBean.returndays = returndays;
	}
	public static String getRenewcount() {
		return renewcount;
	}
	public static void setRenewcount(String renewcount) {
		AccessBean.renewcount = renewcount;
	}
	public static String getFineperday() {
		return fineperday;
	}
	public static void setFineperday(String fineperday) {
		AccessBean.fineperday = fineperday;
	}
	public static String getNoofbooks() {
		return noofbooks;
	}
	public static void setNoofbooks(String noofbooks) {
		AccessBean.noofbooks = noofbooks;
	}
	public static String getInstituteid() {
		return instituteid;
	}
	public static void setInstituteid(String instituteid) {
		AccessBean.instituteid = instituteid;
	}
	public static String getCreatedby() {
		return createdby;
	}
	public static void setCreatedby(String createdby) {
		AccessBean.createdby = createdby;
	}
	public static String getDateofcreation() {
		return dateofcreation;
	}
	public static void setDateofcreation(String dateofcreation) {
		AccessBean.dateofcreation = dateofcreation;
	}
	public static String getAccessstatus() {
		return accessstatus;
	}
	public static void setAccessstatus(String accessstatus) {
		AccessBean.accessstatus = accessstatus;
	}
	public static String getAccesslogid() {
		return accesslogid;
	}
	public static void setAccesslogid(String accesslogid) {
		AccessBean.accesslogid = accesslogid;
	}
	public static String getLogstatus() {
		return logstatus;
	}
	public static void setLogstatus(String logstatus) {
		AccessBean.logstatus = logstatus;
	}
	public static String getAccesslogstatus() {
		return accesslogstatus;
	}
	public static void setAccesslogstatus(String accesslogstatus) {
		AccessBean.accesslogstatus = accesslogstatus;
	}
	public static String getRoleid() {
		return roleid;
	}


	public static void setRoleid(String roleid) {
		AccessBean.roleid = roleid;
	}
	
	public static String getUsercategory() {
		return usercategory;
	}
	public static void setUsercategory(String usercategory) {
		AccessBean.usercategory = usercategory;
	}
	
	 private static String accessid = null;
	 private static String roleid = null;
	 private static String renewdays = null;
	 private static String returndays = null;
	 private static String renewcount = null;
	 private static String fineperday = null;
	 private static String noofbooks = null;
	 private static String instituteid = null;
	 private static String createdby = null;
	 private static String dateofcreation = null;
	 private static String accessstatus = null;
	 
	 private static String accesslogid = null;
	 private static String logstatus = null;
	 private static String accesslogstatus = null;
	 private static String usercategory = null;

	
	

}