
package com.iGrandee.Attendance;

import java.io.Serializable;

public class AttendanceBean   implements Serializable
{
private String dateofattendance=null;
private String studentallocationid []=null;
private String Studentattendancestatus []=null;
private String createdby=null;
private String usercategory=null;
private String ipaddress=null;
private String editstatus []=null;
private String attendanceid []=null;
private String delstudentallocationid =null;
private String delStudentattendancestatus=null;
private String deleditstatus =null;
private String delattendanceid = null;
private String   resultnames   = null;
private String   resultids   = null;

public String getDateofattendance() {
	return dateofattendance;
}

public void setDateofattendance(String dateofattendance) {
	this.dateofattendance = dateofattendance;
}

public String [] getStudentallocationid() {
	return studentallocationid;
}

public void setStudentallocationid(String studentallocationid []) {
	this.studentallocationid = studentallocationid;
}

public String [] getStudentattendancestatus() {
	return Studentattendancestatus;
}

public void setStudentattendancestatus(String studentattendancestatus []) {
	Studentattendancestatus = studentattendancestatus;
}

public String getCreatedby() {
	return createdby;
}

public void setCreatedby(String createdby) {
	this.createdby = createdby;
}

public String getIpaddress() {
	return ipaddress;
}

public void setIpaddress(String ipaddress) {
	this.ipaddress = ipaddress;
}

public String [] getEditstatus() {
	return editstatus;
}

public void setEditstatus(String editstatus []) {
	this.editstatus = editstatus;
}

public String[] getAttendanceid() {
	return attendanceid;
}

public void setAttendanceid(String[] attendanceid) {
	this.attendanceid = attendanceid;
}

public String getDelstudentallocationid() {
	return delstudentallocationid;
}

public void setDelstudentallocationid(String delstudentallocationid) {
	this.delstudentallocationid = delstudentallocationid;
}

public String getDelStudentattendancestatus() {
	return delStudentattendancestatus;
}

public void setDelStudentattendancestatus(String delStudentattendancestatus) {
	this.delStudentattendancestatus = delStudentattendancestatus;
}

public String getDeleditstatus() {
	return deleditstatus;
}

public void setDeleditstatus(String deleditstatus) {
	this.deleditstatus = deleditstatus;
}

public String getDelattendanceid() {
	return delattendanceid;
}

public void setDelattendanceid(String delattendanceid) {
	this.delattendanceid = delattendanceid;
}

public String getResultnames() {
	return resultnames;
}

public void setResultnames(String resultnames) {
	this.resultnames = resultnames;
}

public String getResultids() {
	return resultids;
}

public void setResultids(String resultids) {
	this.resultids = resultids;
}

public String getUsercategory() {
	return usercategory;
}

public void setUsercategory(String usercategory) {
	this.usercategory = usercategory;
}
}