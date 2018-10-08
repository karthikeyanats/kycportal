package com.iGrandee.MasterEntries.Lesson;



public class LessonBean
{
	public LessonBean()
	{
		 lessonid = null;
		 lessonname = null;
		 description = null;
		 subjectid	= null;
		 createdby	= null;
		 lessoncreationdate = null;
		 lessonstatus = null;
	}
	
	
	public String getLessonid() {
		return lessonid;
	}
	public void setLessonid(String lessonid) {
		this.lessonid = lessonid;
	}
	public String getLessonname() {
		return lessonname;
	}
	public void setLessonname(String lessonname) {
		this.lessonname = lessonname;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getSubjectid() {
		return subjectid;
	}
	public void setSubjectid(String subjectid) {
		this.subjectid = subjectid;
	}
	public String getCreatedby() {
		return createdby;
	}
	public void setCreatedby(String createdby) {
		this.createdby = createdby;
	}
	public String getLessoncreationdate() {
		return lessoncreationdate;
	}
	public void setLessoncreationdate(String lessoncreationdate) {
		this.lessoncreationdate = lessoncreationdate;
	}
	public String getLessonstatus() {
		return lessonstatus;
	}
	public void setLessonstatus(String lessonstatus) {
		this.lessonstatus = lessonstatus;
	}
	

	String lessonid = null;
	String lessonname = null;
	String description = null;
	String subjectid	= null;
	String createdby	= null;
	String lessoncreationdate = null;
	String lessonstatus = null;
   
}