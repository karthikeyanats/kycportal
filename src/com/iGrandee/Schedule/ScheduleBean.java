package com.iGrandee.Schedule;

public class ScheduleBean {
	
	public ScheduleBean(){
		
		
	}
	

	public String[] getStandardids() {
		return standardids;
	}
	public void setStandardids(String[] standardids) {
		this.standardids = standardids;
	}
	public String[] getGroupids() {
		return groupids;
	}
	public void setGroupids(String[] groupids) {
		this.groupids = groupids;
	}
	public String[] getStartdates() {
		return startdates;
	}
	public void setStartdates(String[] startdates) {
		this.startdates = startdates;
	}
	public String[] getEnddates() {
		return enddates;
	}
	public void setEnddates(String[] enddates) {
		this.enddates = enddates;
	}
	public String getLastdate() {
		return lastdate;
	}
	public void setLastdate(String lastdate) {
		this.lastdate = lastdate;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}
	public String getStandardscheduleid() {
		return standardscheduleid;
	}
	public void setStandardscheduleid(String standardscheduleid) {
		this.standardscheduleid = standardscheduleid;
	}
	public String getNoofseats() {
		return noofseats;
	}
	public void setNoofseats(String noofseats) {
		this.noofseats = noofseats;
	}
	public String getEligibility() {
		return eligibility;
	}
	public void setEligibility(String eligibility) {
		this.eligibility = eligibility;
	}
	public String getStartdate() {
		return startdate;
	}
	public void setStartdate(String startdate) {
		this.startdate = startdate;
	}
	public String getEnddate() {
		return enddate;
	}
	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}	
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}	
	public String getSubjectscheduletid() {
		return subjectscheduletid;
	}
	public void setSubjectscheduletid(String subjectscheduletid) {
		this.subjectscheduletid = subjectscheduletid;
	}
	public String getLessonid() {
		return lessonid;
	}
	public void setLessonid(String lessonid) {
		this.lessonid = lessonid;
	}
	public String getLessonscheduletid() {
		return lessonscheduletid;
	}
	public void setLessonscheduletid(String lessonscheduletid) {
		this.lessonscheduletid = lessonscheduletid;
	}	
	public String[] getNoofseatss() {
		return noofseatss;
	}
	public void setNoofseatss(String[] noofseatss) {
		this.noofseatss = noofseatss;
	}


	
	
	
	private String standardids[]		= null;
	private String groupids[]			= null;
	private String startdates[]			= null;
	private String enddates[]			= null;
	private String noofseatss[]			= null;
	private String lastdate				= null;
	private String sessionid			= null;
	private String instituteid			= null;
	private String userid				= null;
	private String ipaddress			= null;
	private String standardscheduleid	= null;
	private String noofseats			= null;
	private String eligibility			= null;
	private String startdate			= null;
	private String enddate				= null;
	private String status				= null;
	private String subjectid			= null;
	private String subjectscheduletid	= null;
	private String lessonid				= null;
	private String lessonscheduletid	= null;
	private String sectionid			= null;
	private String sectionscheduletid	= null;
	
	
	private String[] subjectscheduleids	= null;
	private String[] theoryinternalmin	= null;
	private String[] theoryinternalmax	= null;
	private String[] theoryexternalmin	= null;
	private String[] theoryexternalmax	= null;
	private String[] practicalinternalmin	= null;
	private String[] practicalinternalmax	= null;
	private String[] practicalexternalmin	= null;
	private String[] practicalexternalmax	= null;
	private String[] projectinternalmin	= null;
	private String[] projectinternalmax	= null;
	private String[] projectexternalmin	= null;
	private String[] projectexternalmax	= null;
	private String[] credithours		= null;
	
	
	public String[] getSubjectscheduleids() {
		return subjectscheduleids;
	}


	public void setSubjectscheduleids(String[] subjectscheduleids) {
		this.subjectscheduleids = subjectscheduleids;
	}


	public String[] getTheoryinternalmin() {
		return theoryinternalmin;
	}


	public void setTheoryinternalmin(String[] theoryinternalmin) {
		this.theoryinternalmin = theoryinternalmin;
	}


	public String[] getTheoryinternalmax() {
		return theoryinternalmax;
	}


	public void setTheoryinternalmax(String[] theoryinternalmax) {
		this.theoryinternalmax = theoryinternalmax;
	}


	public String[] getTheoryexternalmin() {
		return theoryexternalmin;
	}


	public void setTheoryexternalmin(String[] theoryexternalmin) {
		this.theoryexternalmin = theoryexternalmin;
	}


	public String[] getTheoryexternalmax() {
		return theoryexternalmax;
	}


	public void setTheoryexternalmax(String[] theoryexternalmax) {
		this.theoryexternalmax = theoryexternalmax;
	}


	public String[] getPracticalinternalmin() {
		return practicalinternalmin;
	}


	public void setPracticalinternalmin(String[] practicalinternalmin) {
		this.practicalinternalmin = practicalinternalmin;
	}


	public String[] getPracticalinternalmax() {
		return practicalinternalmax;
	}


	public void setPracticalinternalmax(String[] practicalinternalmax) {
		this.practicalinternalmax = practicalinternalmax;
	}


	public String[] getPracticalexternalmin() {
		return practicalexternalmin;
	}


	public void setPracticalexternalmin(String[] practicalexternalmin) {
		this.practicalexternalmin = practicalexternalmin;
	}


	public String[] getPracticalexternalmax() {
		return practicalexternalmax;
	}


	public void setPracticalexternalmax(String[] practicalexternalmax) {
		this.practicalexternalmax = practicalexternalmax;
	}


	public String[] getProjectinternalmin() {
		return projectinternalmin;
	}


	public void setProjectinternalmin(String[] projectinternalmin) {
		this.projectinternalmin = projectinternalmin;
	}


	public String[] getProjectinternalmax() {
		return projectinternalmax;
	}


	public void setProjectinternalmax(String[] projectinternalmax) {
		this.projectinternalmax = projectinternalmax;
	}


	public String[] getProjectexternalmin() {
		return projectexternalmin;
	}


	public void setProjectexternalmin(String[] projectexternalmin) {
		this.projectexternalmin = projectexternalmin;
	}


	public String[] getProjectexternalmax() {
		return projectexternalmax;
	}


	public void setProjectexternalmax(String[] projectexternalmax) {
		this.projectexternalmax = projectexternalmax;
	}


	public String[] getCredithours() {
		return credithours;
	}


	public void setCredithours(String[] credithours) {
		this.credithours = credithours;
	}


	public String getSectionid() {
		return sectionid;
	}


	public void setSectionid(String sectionid) {
		this.sectionid = sectionid;
	}


	public String getSectionscheduletid() {
		return sectionscheduletid;
	}


	public void setSectionscheduletid(String sectionscheduletid) {
		this.sectionscheduletid = sectionscheduletid;
	}
	
	
	




}
