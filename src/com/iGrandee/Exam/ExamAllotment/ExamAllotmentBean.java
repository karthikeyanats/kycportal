package com.iGrandee.Exam.ExamAllotment;
import java.util.ArrayList;
public class ExamAllotmentBean
{
	public  ExamAllotmentBean()
	{
		examallotmentid="";
		examnameid="";
		standardscheduleid="";
		allotedby="";
		alloteddate="";
		examallotmentstatus="";
		
		
	}
	
	public String getExamallotmentid() {
		return examallotmentid;
	}
	public void setExamallotmentid(String examallotmentid) {
		this.examallotmentid = examallotmentid;
	}
	public String getExamnameid() {
		return examnameid;
	}
	public void setExamnameid(String examnameid) {
		this.examnameid = examnameid;
	}
	public String getStandardscheduleid() {
		return standardscheduleid;
	}
	public void setStandardscheduleid(String standardscheduleid) {
		this.standardscheduleid = standardscheduleid;
	}
	public String getAllotedby() {
		return allotedby;
	}
	public void setAllotedby(String allotedby) {
		this.allotedby = allotedby;
	}
	public String getAlloteddate() {
		return alloteddate;
	}
	public void setAlloteddate(String alloteddate) {
		this.alloteddate = alloteddate;
	}
	public String getExamallotmentstatus() {
		return examallotmentstatus;
	}
	public void setExamallotmentstatus(String examallotmentstatus) {
		this.examallotmentstatus = examallotmentstatus;
	}
	public String getSubjectscheduleid() {
		return subjectscheduleid;
	}

	public void setSubjectscheduleid(String subjectscheduleid) {
		this.subjectscheduleid = subjectscheduleid;
	}
	public String getInstituteid() {
		return instituteid;
	}

	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
	}
	public String getExamdate() {
		return examdate;
	}

	public void setExamdate(String examdate) {
		this.examdate = examdate;
	}
	public String getLastdate() {
		return lastdate;
	}

	public void setLastdate(String lastdate) {
		this.lastdate = lastdate;
	}
	
	public String getExamscheduleid() {
		return examscheduleid;
	}
	public void setExamscheduleid(String examscheduleid) {
		this.examscheduleid = examscheduleid;
	}
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}


	public String getPublishstatus() {
		return publishstatus;
	}
	public void setPublishstatus(String publishstatus) {
		this.publishstatus = publishstatus;
	}

	public String getSchedulestatus() {
		return schedulestatus;
	}
	public void setSchedulestatus(String schedulestatus) {
		this.schedulestatus = schedulestatus;
	}
	
	String examallotmentid;
	String examnameid;
	String standardscheduleid;
	String subjectscheduleid;
	String allotedby;
	String alloteddate;
	String examallotmentstatus;
	String instituteid;
	String examdate;
	String lastdate;
	
	String examscheduleid;
	String status;
	String publishstatus;
	String schedulestatus;
	
}
