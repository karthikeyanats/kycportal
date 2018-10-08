package com.iGrandee.Exam;
import java.util.ArrayList;
public class ExamnameBean
{
	public  ExamnameBean()
	{
		examnameid="";
		examname="";
		sessionid="";
		examnamestatus="";
		instituteid="";
		createdby="";
		dateofcreation="";
		remarks="";
		
		
	}
	public String getExamnameid() {
		return examnameid;
	}
	public void setExamnameid(String examnameid) {
		this.examnameid = examnameid;
	}
	public String getExamname() {
		return examname;
	}
	public void setExamname(String examname) {
		this.examname = examname;
	}
	public String getSessionid() {
		return sessionid;
	}
	public void setSessionid(String sessionid) {
		this.sessionid = sessionid;
	}
	public String getExamnamestatus() {
		return examnamestatus;
	}
	public void setExamnamestatus(String examnamestatus) {
		this.examnamestatus = examnamestatus;
	}
	public String getInstituteid() {
		return instituteid;
	}
	public void setInstituteid(String instituteid) {
		this.instituteid = instituteid;
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
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	String examnameid;
	String examname="";
	String sessionid="";
	String examnamestatus="";
	String instituteid="";
	String createdby="";
	String dateofcreation="";
	String remarks="";
	String gradename="";
	String gradestatus="";

	String rangefrom="";
	String rangeto="";
	String gradeid="";

	public String getGradename() {
		return gradename;
	}
	public void setGradename(String gradename) {
		this.gradename = gradename;
	}
	public String getRangefrom() {
		return rangefrom;
	}
	public void setRangefrom(String rangefrom) {
		this.rangefrom = rangefrom;
	}
	public String getRangeto() {
		return rangeto;
	}
	public void setRangeto(String rangeto) {
		this.rangeto = rangeto;
	}
	public String getGradeid() {
		return gradeid;
	}
	public void setGradeid(String gradeid) {
		this.gradeid = gradeid;
	}
	public String getGradestatus() {
		return gradestatus;
	}
	public void setGradestatus(String gradestatus) {
		this.gradestatus = gradestatus;
	}
}