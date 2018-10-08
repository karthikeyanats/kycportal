
package com.iGrandee.Prinicipal;

import java.io.Serializable;

public class PrinicipalBean   implements Serializable
{
private String dateofattendance=null;
private String studentallocationid []=null;
private String Studentattendancestatus []=null;
private String createdby=null;
private String ipaddress=null;
private String editstatus []=null;
private String attendanceid []=null;





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
}