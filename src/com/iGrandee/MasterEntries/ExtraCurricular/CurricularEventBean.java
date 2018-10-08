package com.iGrandee.MasterEntries.ExtraCurricular;

public class CurricularEventBean
{
	public CurricularEventBean()
    {
    }
	

	
	

	public String getCurriculareventid() {
		return curriculareventid;
	}
	public void setCurriculareventid(String curriculareventid) {
		this.curriculareventid = curriculareventid;
	}
	public String getExtracurricularcategoryid() {
		return extracurricularcategoryid;
	}
	public void setExtracurricularcategoryid(String extracurricularcategoryid) {
		this.extracurricularcategoryid = extracurricularcategoryid;
	}
	public String[] getEventdate() {
		return eventdate;
	}
	public void setEventdate(String[] eventdate) {
		this.eventdate = eventdate;
	}
	public String[] getCurriculareventname() {
		return curriculareventname;
	}
	public void setCurriculareventname(String[] curriculareventname) {
		this.curriculareventname = curriculareventname;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
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
	public String getEventstatus() {
		return eventstatus;
	}
	public void setEventstatus(String eventstatus) {
		this.eventstatus = eventstatus;
	}
	public String[] getVenu() {
		return venu;
	}
	public void setVenu(String[] venu) {
		this.venu = venu;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	
	
	public String []getStudentallocationid() {
		return studentallocationid;
	}
	public void setStudentallocationid (String []studentallocationid) {
		this.studentallocationid = studentallocationid;
	}
	public String getIpaddress() {
		return ipaddress;
	}
	public void setIpaddress(String ipaddress) {
		this.ipaddress = ipaddress;
	}

	public String getExtracurricularactivityid() {
		return extracurricularactivityid;
	}

	public void setExtracurricularactivityid(String extracurricularactivityid) {
		this.extracurricularactivityid = extracurricularactivityid;
	}

	private String curriculareventid= null;
	public String getEventparticipantsid() {
		return eventparticipantsid;
	}





	public void setEventparticipantsid(String eventparticipantsid) {
		this.eventparticipantsid = eventparticipantsid;
	}

	private String eventparticipantsid= null;

	
	private String extracurricularcategoryid= null;
	private String extracurricularactivityid= null;

	 private String[] eventdate= null;
	private String[] curriculareventname= null;
	private String description= null;
	private String createdby= null;
	private String dateofcreation= null;
	private String eventstatus= null;
	private String[] venu= null;
	private String  sessionid = null;
	private String  studentallocationid []= null;
	private String  ipaddress = null;
	private String  awarddetails []= null;
	public String[] getAwarddetails() {
		return awarddetails;
	}





	public void setAwarddetails(String[] awarddetails) {
		this.awarddetails = awarddetails;
	}

	
}