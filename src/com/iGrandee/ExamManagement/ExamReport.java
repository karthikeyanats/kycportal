package com.iGrandee.ExamManagement;

import java.sql.Connection;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;

public class ExamReport
{
	static Logger log = Logger.getLogger(ExamReport.class);
	public ExamReport() {
		
		 
	     common_data_object 	= new CommonDataAccess();
	     insert_query 			= null;
	     select_query 			= null;
	     return_value 			= 0;
	     connection				= null;
	     datetime				= new DateTime();
	 }
	
	
	public ArrayList loadTemplatesWithDetails(String subjectid,String standardscheduleid,String sessionid)
	{
		log.info("Invoking loadTemplatesWithDetails(String subjectid,String standardscheduleid,String sessionid) from  com.iGrandee.ExamManagement.ExamReport");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select a.qsid,a.examname,b.feetype,(select count(a1.onlineexamsubscriptionid) from onlinexamsubscription a1, studentapproval b1 where a1.qsid=a.qsid and a1.subscribedby=b1.studentapprovalid and b1.standardscheduleid='"+standardscheduleid+"') as requestedusers, (select count(distinct a1.studentid) from onlineanswers a1,studentallocation b1, studentapproval c1 where a1.qsid=a.qsid and a1.studentid=b1.studentallocationid and b1.candidateregisterid=c1.registrationid and c1.standardscheduleid='"+standardscheduleid+"') as attendedusers,(select count(distinct a1.studentid) from onlineanswers a1, studentallocation b1,studentapproval c1 where a1.qsid=a.qsid and a1.studentid=b1.studentallocationid and b1.candidateregisterid=c1.registrationid and c1.standardscheduleid='"+standardscheduleid+"' and a1.dateofcreation  between DATE_ADD(current_timestamp, INTERVAL -10 MINUTE) and current_timestamp) as ontimeusers from questionsheetmaster a,onlineexam b where a.subjectid='"+subjectid+"' and a.qsid=b.qsid and a.questionsheetstatus='A' and a.sessionid='"+sessionid+"' and b.onlineexamstatus='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
				System.out.println("============>>>>>>"+select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
				}
			return academicList;
	 }
	public ArrayList loadExamAttendCountDetails(String subjectid,String standardscheduleid,String sessionid,String qsid)
	{
		log.info("Invoking loadTemplatesWithDetails(String subjectid,String standardscheduleid,String sessionid) from  com.iGrandee.ExamManagement.ExamReport");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select a.qsid,a.examname,b.feetype, (select count(a1.onlineexamsubscriptionid) from onlinexamsubscription a1, studentapproval b1 where a1.qsid=a.qsid and a1.subscribedby=b1.studentapprovalid and b1.standardscheduleid='"+standardscheduleid+"') as requestedusers, (select count(distinct a1.studentid) from onlineanswers a1,studentallocation b1, studentapproval c1 where a1.qsid=a.qsid and a1.studentid=b1.studentallocationid and b1.candidateregisterid=c1.registrationid and c1.standardscheduleid='"+standardscheduleid+"') as attendedusers,(select count(distinct a1.studentid) from onlineanswers a1, studentallocation b1,studentapproval c1 where a1.qsid=a.qsid and a1.studentid=b1.studentallocationid and b1.candidateregisterid=c1.registrationid and c1.standardscheduleid='"+standardscheduleid+"' and a1.dateofcreation like date_format(current_timestamp,'%Y-%m-%d %h%')) as ontimeusers from questionsheetmaster a,onlineexam b where a.subjectid='"+subjectid+"' and a.qsid=b.qsid and a.qsid='"+qsid+"' and a.questionsheetstatus='A' and a.sessionid='"+sessionid+"' and b.onlineexamstatus='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	public ArrayList loadTemplatesWithAttended(String subjectid,String standardscheduleid)
	{
		log.info("Invoking loadTemplatesWithAttended(String subjectid,String standardscheduleid) from  com.iGrandee.ExamManagement.ExamReport");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select a.qsid,a.examname,b.feetype,(select count(distinct a1.studentid) from onlineanswers a1,studentallocation b1,sectionschedule c1 where a1.qsid=a.qsid and a1.studentid=b1.studentallocationid and b1.sectionscheduleid=c1.sectionscheduleid and c1.standardscheduleid='"+standardscheduleid+"') as attendedusers from questionsheetmaster a,onlineexam b where a.subjectid='"+subjectid+"' and a.qsid=b.qsid and a.questionsheetstatus='A' and b.onlineexamstatus='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	public ArrayList examDetailsAttended(String qsid,String standardscheduleid)
	{
		log.info("Invoking examDetailsAttended(String qsid,String standardscheduleid) from  com.iGrandee.ExamManagement.ExamReport");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select c.studentallocationid,concat(d.firstname,' ', case when d.middlename is null or d.middlename='' then '' else d.middlename end,' ', d.lastname)as studentname,d.imagepath,d.emailid,d.mobilenumber,(select certificateissueid from certificateissue where qsid='"+qsid+"' and studentid=c.studentallocationid group by studentid,qsid) as certificateid, case when c.rollno is null or c.rollno='' then 'Not Yet Genearted' else c.rollno end as rollno from studentapproval a,login b,studentallocation c,personmaster d where a.standardscheduleid='"+standardscheduleid+"' and a.registrationid=b.userid and b.userid=c.candidateregisterid and b.personid=d.personid and c.studentallocationid in (select studentid from onlineanswers where qsid='"+qsid+"')"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		
	
	public ArrayList examDetailsOnTime(String qsid,String standardscheduleid)
	{
		log.info("Invoking examDetailsOnTime(String qsid,String standardscheduleid) from  com.iGrandee.ExamManagement.ExamReport");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select c.studentallocationid,concat(d.firstname,' ', case when d.middlename is null or d.middlename='' then '' else d.middlename end,' ', d.lastname)as studentname,d.imagepath,d.emailid,d.mobilenumber,(select certificateissueid from certificateissue where qsid='"+qsid+"' and studentid=c.studentallocationid group by studentid,qsid) as certificateid, case when c.rollno is null or c.rollno='' then 'Not Yet Genearted' else c.rollno end as rollno from studentapproval a,login b,studentallocation c,personmaster d where a.standardscheduleid='"+standardscheduleid+"' and a.registrationid=b.userid and b.userid=c.candidateregisterid and b.personid=d.personid and c.studentallocationid in (select studentid from onlineanswers where qsid='"+qsid+"'  and dateofcreation between DATE_ADD(current_timestamp, INTERVAL -10 MINUTE) and current_timestamp)"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	
	public String getIssueDescription(String qsid,String studentid)
	{
		log.info("Invoking getIssueDescription(String qsid,String studentid) from  com.iGrandee.ExamManagement.ExamReport");
		String academicList = null;
			try
			{
				select_query  	= "SELECT description FROM certificateissue where studentid='"+studentid+"' and qsid='"+qsid+"' and certificateissuestatus='A'"; 
				academicList 	= common_data_object.getString(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		
	

	public ArrayList examDetailsRequested(String qsid,String standardscheduleid)
	{
		log.info("Invoking examDetailsRequested(String qsid,String standardscheduleid) from  com.iGrandee.ExamManagement.ExamReport");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select c.studentallocationid,concat(d.firstname,' ', case when d.middlename is null or d.middlename='' then '' else d.middlename end,' ', d.lastname)as studentname,d.imagepath,d.emailid,d.mobilenumber, case when c.rollno is null or c.rollno='' then 'Not Yet Genearted' else c.rollno end as rollno,date_format(e.dateofsubscription,'%d-%b-%Y') as dateofsubscription from studentapproval a,login b,studentallocation c,personmaster d, onlinexamsubscription e where a.standardscheduleid='"+standardscheduleid+"' and a.registrationid=b.userid and b.userid=c.candidateregisterid and b.personid=d.personid and c.studentallocationid=e.subscribedby and e.qsid='"+qsid+"'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		

	
	public String standardScheduleId(String standardid,String sessionid)
	{
		log.info("Invoking standardScheduleId(String standardid,String sessionid) from  com.iGrandee.ExamManagement.ExamReport");
		String standardscheduleid = null;
		try
		{
			select_query  		= "select standardscheduleid from standardschedule where sessionid='"+sessionid+"' and standardid='"+standardid+"'"; 
			standardscheduleid 	= common_data_object.getString(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return standardscheduleid;
	}

CommonDataAccess common_data_object;
String insert_query;
String select_query; 
int 	return_value;
int[] returnvalue;
Connection connection;
DateTime datetime;
}