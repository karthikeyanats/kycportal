package com.iGrandee.StaffList;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Registration.StudentRegistrationQuery;


public class StaffEntry {
	static Logger log = Logger.getLogger(StaffEntry.class);

 public StaffEntry() {
	 
     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
     datetime				= new DateTime();
 }
  

 /**
     * This method is accessed from kycportal/jsp/StaffList/StaffListForstudLogin.jsp
     * get all details about staff for student     - prasanth
     @param sectionscheduleid that can be used to get stafflist that can be printed on the screen
     *
     @return  ArrayList by which result can be printed on the screen
*/
 
public ArrayList ListstaffDetailsForStudent(String sectionscheduleid)
{
	 	log.info("invoking get all details about staff for student from com.iGrandee.StaffList.StaffEntry");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select case when middlename='-' or middlename='' or middlename  is null then concat(prefix,f.firstname,' ',f.lastname) else concat(prefix,f.firstname,' ',f.middlename,' ',f.lastname) end as uname,f.mobilenumber,f.emailid,f.imagepath,f.qualification, g.subjectname,a.staffid,b.staffcategoryid,a.subjectscheduleid,d.standardscheduleid, e.personid,h.subjectypename from subjectallotment a,staffmaster b,staffcategory c,login e,personmaster f,subjectschedule d, subject g left outer join subjecttype h on g.subjecttypeid=h.subjecttypeid and h.subjecttypestatus='A' where a.sectionpublishid='"+sectionscheduleid+"' and a.subjectallotmentstatus='A' and b.staffid=a.staffid and b.staffstatus='A'  and c.staffcategoryid=b.staffcategoryid and c.staffcategorystatus='A' and e.userid=b.userid and e.loginstatus='A' and f.personid=e.personid and f.status='A' and d.subjectscheduleid=a.subjectscheduleid and d.status='A' and g.subjectid=d.subjectid and g.subjectstatus='A'"; 
		log.info(select_query);
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}/**
 * This method is accessed from kycportal/jsp/StaffList/StudentSyllabus.jsp
 * ListSyllabusForStudent        - prasanth
 * @param standardscheduleid that can be used to get syllabus details and it can be printed on the screen
 * 
 @return  ArrayList by which result can be printed on the screen
*/
public ArrayList ListSyllabusForStudent(String standardscheduleid)
{
	 	log.info("ListSyllabusForStudent from com.iGrandee.StaffList.StaffEntry");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select c.subjectid,b.subjectscheduleid,c.subjectname,c.subjectcode,d.subjectypename,b.theoryinternalmin,b.theoryinternalmax, b.theoryexternalmin,b.theoryexternalmax from standardschedule a, subjectschedule b ,subject c,subjecttype d where a.standardscheduleid='"+standardscheduleid+"' and a.stdschedulestatus='A' and a.standardscheduleid=b.standardscheduleid and b.status='A' and b.subjectid=c.subjectid and c.subjectstatus='A' and d.subjecttypeid=c.subjecttypeid and d.subjecttypestatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
			
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}
/**
 * This method is accessed from kycportal/jsp/StaffList/StudentSyllabus.jsp
 *list all  ListLessionForStudent        - prasanth
 * @param subjectid that can be used to get lesson details and it can be printed on the screen
 * 
 @return  ArrayList by which result can be printed on the screen
*/
public ArrayList ListLessionForStudent(String subjectid)
{
	 	log.info("invoking ListLessionForStudent from com.iGrandee.StaffList.StaffEntry");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select lessonname,lessondescription from lesson where subjectid='"+subjectid+"' and lessonstatus='A';"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}
/**
 * return class teacher list based on the sectionscheduleid
  * @param sectionscheduleid
 * @return
 */

public ArrayList showClassTeacher(String sectionscheduleid)
{
	 	log.info("invoking show class teacher from com.iGrandee.StaffList.StaffEntry.showClassTeacher");

		ArrayList classTeacherList = null;
		try
		{
			select_query  	= "SELECT d.prefix,d.qualification,d.firstname,d.middlename,d.lastname,d.sex,d.landlinenumber, d.mobilenumber,d.emailid,d.imagepath,e.departmentname,f.rolename FROM classcounselor a,staffmaster b,login c,personmaster d,department e,role f where a.staffid=b.staffid and b.userid=c.userid and c.personid=d.personid and e.departmentid=b.departmentid and f.roleid=b.roleid and a.counselorstatus='A' and staffstatus='A' and c.loginstatus='A' and d.status='A' and e.status='A' and f.status='A' and a.sectionscheduleid='"+sectionscheduleid+"'"; 
			
			log.info(select_query);
			classTeacherList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return classTeacherList;
}


 CommonDataAccess common_data_object; 
 String insert_query;
 String select_query;
 int 	return_value;
 int[] returnvalue;
 Connection connection;
 DateTime datetime;

}
