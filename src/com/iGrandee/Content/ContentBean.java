
package com.iGrandee.Content;

import java.io.Serializable;

public class ContentBean   implements Serializable
{
private String filepath []=null;
private String filename []=null;
private String notes []=null;
private String slidename []=null;
private String sfilepath =null;
private String sfilename =null;
private String snotes =null; 
private String sslidename =null;
private String lessonid  =null;
private String subjectid  =null;
private String createdby =null;
private String sessionid  =null;
private String cmscontentid  =null;
private String cmscontentidforallocation  []=null;
private String lessonscheduleid  =null;
private String editstatus  =null;
private String cmscontentscheduleid  =null;  
private String title []       	 			=null;

public String[] getTitle() {
	return title;
}
public void setTitle(String[] title) {
	this.title = title;
}
public String[] getSource() {
	return source;
}
public void setSource(String[] source) {
	this.source = source;
}
public String[] getPresentername() {
	return presentername;
}
public void setPresentername(String[] presentername) {
	this.presentername = presentername;
}
public String[] getInstitutename() {
	return institutename;
}
public void setInstitutename(String[] institutename) {
	this.institutename = institutename;
}
public String[] getReferenceurl() {
	return referenceurl;
}
public void setReferenceurl(String[] referenceurl) {
	this.referenceurl = referenceurl;
}
public String[] getLicensedby() {
	return licensedby;
}
public void setLicensedby(String[] licensedby) {
	this.licensedby = licensedby;
}
public String[] getDescription() {
	return description;
}
public void setDescription(String[] description) {
	this.description = description;
}
public String getCmsmetainfoid() {
	return cmsmetainfoid;
}
public void setCmsmetainfoid(String cmsmetainfoid) {
	this.cmsmetainfoid = cmsmetainfoid;
}
private String source []       	 			=null;
private String presentername []       	 	=null;
private String institutename []       	 	=null;
private String referenceurl []       	 	=null;
private String licensedby []       	 		=null;
private String description []       	 	=null;

private String cmsmetainfoid  =null;


private String cmscontentstatus  =null;


public String[] getFilepath() {
	return filepath;
}
public void setFilepath(String[] filepath) {
	this.filepath = filepath;
}
public String[] getFilename() {
	return filename;
}
public void setFilename(String[] filename) {
	this.filename = filename;
}
public String[] getNotes() {
	return notes;
}
public void setNotes(String[] notes) {
	this.notes = notes;
}
public String[] getSlidename() {
	return slidename;
}
public void setSlidename(String[] slidename) {
	this.slidename = slidename;
}
public String getLessonid() {
	return lessonid;
}
public void setLessonid(String lessonid) {
	this.lessonid = lessonid;
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
public String getSessionid() {
	return sessionid;
}
public void setSessionid(String sessionid) {
	this.sessionid = sessionid;
}
public String getSfilepath() {
	return sfilepath;
}
public void setSfilepath(String sfilepath) {
	this.sfilepath = sfilepath;
}
public String getSfilename() {
	return sfilename;
}
public void setSfilename(String sfilename) {
	this.sfilename = sfilename;
}
public String getSnotes() {
	return snotes;
}
public void setSnotes(String snotes) {
	this.snotes = snotes;
}
public String getSslidename() {
	return sslidename;
}
public void setSslidename(String sslidename) {
	this.sslidename = sslidename;
}
public String getCmscontentid() {
	return cmscontentid;
}
public void setCmscontentid(String cmscontentid) {
	this.cmscontentid = cmscontentid;
}
public String getCmscontentstatus() {
	return cmscontentstatus;
}
public void setCmscontentstatus(String cmscontentstatus) {
	this.cmscontentstatus = cmscontentstatus;
}
public String[] getCmscontentidforallocation() {
	return cmscontentidforallocation;
}
public void setCmscontentidforallocation(String[] cmscontentidforallocation) {
	this.cmscontentidforallocation = cmscontentidforallocation;
}
public String getLessonscheduleid() {
	return lessonscheduleid;
}
public void setLessonscheduleid(String lessonscheduleid) {
	this.lessonscheduleid = lessonscheduleid;
}
public String getEditstatus() {
	return editstatus;
}
public void setEditstatus(String editstatus) {
	this.editstatus = editstatus;
}
public String getCmscontentscheduleid() {
	return cmscontentscheduleid;
}
public void setCmscontentscheduleid(String cmscontentscheduleid) {
	this.cmscontentscheduleid = cmscontentscheduleid;
}

}