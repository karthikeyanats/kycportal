package com.iGrandee.Schedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;


public class Schedule {
	
	static Logger log = Logger.getLogger(Schedule.class);
	
 public Schedule() {
	 
     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
     datetime				= new DateTime();
 }
  

 /*
   * This method is accessed from kycportal/jsp/Schedule/StandardSchedule.jsp
  */
 public ArrayList sessionDetails(String instituteid)
 {
	 	log.info("invoking sessionDetails from com.iGrandee.Schedule.Schedule");
	 
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"+instituteid+"' and (sessionstatus='A' or sessionstatus='R' or sessionstatus='N')"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return periodsList;
 }
 
 /*
  * This method is accessed from kycportal/jsp/Schedule/StandardSchedule.jsp
 */
public ArrayList boardDetails(String instituteid)
{
 		log.info("invoking boardDetails from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select boardname,boardid,b.mediumname from board a,standardmedium b where a.instituteid='"+instituteid+"' and a.boardstatus='A' and a.mediumid=b.mediumid and b.mediumstatus='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
			//System.out.println(exception);
		}
		return periodsList;
} 
 
 
 /*
  * This method is accessed from kycportal/jsp/Schedule/StandardSchedule.jsp
 */
public ArrayList standardDetails(String instituteid,String sessionid,String boardid)
{
 	log.info("invoking standardDetails from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.standardid,a.standardname,a.groupstatus, date_format(c.startdate,'%d-%b-%Y') as startdate, date_format(c.enddate,'%d-%b-%Y') as enddate, c.standardscheduleid,'-' as groupid,null as groupname, case when c.noofseats is null then '0' else c.noofseats end as noofseats from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' and a.groupstatus='No' and a.standardid not in (select standardid from standardschedule where sessionid='"+sessionid+"' and stdschedulestatus='T') left outer join standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' union select a.standardid,a.standardname,a.groupstatus,date_format(c.startdate,'%d-%b-%Y') as startdate, date_format(c.enddate,'%d-%b-%Y') as enddate, c.standardscheduleid,d.groupid,d.groupname, case when c.noofseats is null then '0' else c.noofseats end as noofseats from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' and a.groupstatus='Yes' join standardgroup d on a.instituteid=d.instituteid and d.groupstatus='A' and d.groupid not in (select f.groupid from standardschedule e,standardgroup f where e.sessionid='"+sessionid+"' and a.standardid=e.standardid and e.stdschedulestatus='T' and f.groupid=e.groupid) left outer join standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' and d.groupid=c.groupid order by groupstatus,standardid,startdate";  
			periodsList 	= common_data_object.getListMap(select_query);
			
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Schedule/TrashedStandard.jsp
*/
public ArrayList standardTrashedDetails(String instituteid,String sessionid,String boardid)
{
 	log.info("invoking standardTrashedDetails from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.standardid,a.standardname,c.standardscheduleid,c.groupid,groupname, a.groupstatus from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' join standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='T' left outer join standardgroup d on a.instituteid=d.instituteid and d.groupstatus='A' and d.groupid=c.groupid";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Schedule/StandardSchedule.jsp
*/
public ArrayList groupDetailsPublished(String sessionid,String standardid,String instituteid)
{
 	log.info("invoking groupDetailsPublished from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.groupid,a.groupname,date_format(c.startdate,'%d-%b-%Y') as startdate,date_format(c.enddate,'%d-%b-%Y') as enddate, c.standardscheduleid from standardgroup a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and b.status='A' and a.groupstatus='A' left outer join standardschedule c on c.standardid='"+standardid+"' and a.groupid=c.groupid and a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' group by a.groupid";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}



public String loadAllocatedStudents(String standardscheduleid)
{
 	log.info("invoking viewDetails from com.iGrandee.Schedule.Schedule");

		String noofstudent = null;
		try
		{
			select_query  	= "select count(*)  as noofstudent from studentallocation a,sectionschedule b where a.studentallocationstatus='A' and a.sectionscheduleid=b.sectionscheduleid and b.sectionschedulestatus='A' and b.standardscheduleid='"+standardscheduleid+"'";  
			noofstudent 	= common_data_object.getString(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return noofstudent;
}

/*
 * This method is accessed from kycportal/jsp/Schedule/ViewPublished.jsp
*/
public ArrayList viewDetails(String standardscheduleid)
{
 	log.info("invoking viewDetails from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.standardid,a.standardname,a.groupstatus,date_format(b.startdate,'%d-%b-%Y')as startdate,date_format(b.enddate,'%d-%b-%Y')as enddate,date_format(b.applicationlastdate,'%d-%b-%Y')as applicationlastdate,c.groupname,b.eligibility,b.noofseats from standard a join standardschedule b on a.instituteid=b.instituteid and b.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and a.standardstatus='A' and b.stdschedulestatus='A' left outer join standardgroup c on a.instituteid=c.instituteid and b.groupid=c.groupid and c.groupstatus='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/ViewSubjects.jsp
*/
public ArrayList viewSubjects(String standardscheduleid)
{
 	log.info("invoking viewSubjects from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.subjectname,b.subjectcode,b.description,b.subjectid,null as subjectscheduleid, 'No' as status from standardschedule a,subject b where a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and b.subjectstatus='A' and b.subjectid not in (select subjectid from subjectschedule where standardscheduleid='"+standardscheduleid+"' and subjectid=b.subjectid and status<>'X') union select b.subjectname,b.subjectcode,b.description,b.subjectid,c.subjectscheduleid, 'Yes' as status from standardschedule a,subject b,subjectschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and b.subjectstatus='A' and b.subjectid=c.subjectid and a.standardscheduleid=c.standardscheduleid and c.status='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return periodsList;
}

	
	/**
	 * Method used to get list subject scheduled for the standard with marks details
	 * @param standardscheduleid from standardschedule
	 * This method is accessed from kycportal/jsp/Schedule/MarkScheduleCheck.jsp
	*/
	public ArrayList viewSubjectsMarks(String standardscheduleid)
	{
	 	log.info("invoking viewSubjectsMarks(String standardscheduleid) from com.iGrandee.Schedule.Schedule");
	
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select b.subjectname,b.subjectcode,b.description,b.subjectid,c.subjectscheduleid, case when c.theoryinternalmin is null then '' else c.theoryinternalmin end as theoryinternalmin, case when c.theoryinternalmax is null then '' else c.theoryinternalmax end as theoryinternalmax, case when c.theoryexternalmin is null then '' else c.theoryexternalmin end as theoryexternalmin , case when c.theoryexternalmax is null then '' else c.theoryexternalmax end as theoryexternalmax, case when c.practicalinternalmin is null then '' else c.practicalinternalmin end as practicalinternalmin, case when c.practicalinternalmax is null then '' else c.practicalinternalmax end as practicalinternalmax, case when c.practicalexternalmin is null then '' else c.practicalexternalmin end as practicalexternalmin, case when c.practicalexternalmax is null then '' else c.practicalexternalmax end as practicalexternalmax, case when c.projectinternalmin is null then '' else c.projectinternalmin end as projectinternalmin, case when c.projectinternalmax is null then '' else c.projectinternalmax end as projectinternalmax, case when c.projectexternalmin is null then '' else c.projectexternalmin end as projectexternalmin, case when c.projectexternalmax is null then '' else c.projectexternalmax end as projectexternalmax, case when c.credithours is null then '' else c.credithours end as credithours from standardschedule a,subject b,subjectschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and b.subjectstatus='A' and b.subjectid=c.subjectid and a.standardscheduleid=c.standardscheduleid and c.status='A'";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}
	
	/**
	 * Method used to get list subject scheduled for the standard with marks details
	 * @param standardscheduleid from standardschedule
	 * This method is accessed from kycportal/jsp/Schedule/ImportMarkScheduleSubject.jsp
	*/
	public ArrayList viewSubjectsMarksSubjects(String standardscheduleid)
	{
	 	log.info("invoking viewSubjectsMarks(String standardscheduleid) from com.iGrandee.Schedule.Schedule");
	
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select b.subjectname,b.subjectcode,b.description,b.subjectid,c.subjectscheduleid, case when b.theoryinternalmin is null then '' else b.theoryinternalmin end as theoryinternalmin, case when b.theoryinternalmax is null then '' else b.theoryinternalmax end as theoryinternalmax, case when b.theoryexternalmin is null then '' else b.theoryexternalmin end as theoryexternalmin , case when b.theoryexternalmax is null then '' else b.theoryexternalmax end as theoryexternalmax, case when b.practicalinternalmin is null then '' else b.practicalinternalmin end as practicalinternalmin, case when b.practicalinternalmax is null then '' else b.practicalinternalmax end as practicalinternalmax, case when b.practicalexternalmin is null then '' else b.practicalexternalmin end as practicalexternalmin, case when b.practicalexternalmax is null then '' else b.practicalexternalmax end as practicalexternalmax, case when b.projectinternalmin is null then '' else b.projectinternalmin end as projectinternalmin, case when b.projectinternalmax is null then '' else b.projectinternalmax end as projectinternalmax, case when b.projectexternalmin is null then '' else b.projectexternalmin end as projectexternalmin, case when b.projectexternalmax is null then '' else b.projectexternalmax end as projectexternalmax, case when b.credithours is null then '' else b.credithours end as credithours from standardschedule a,subject b,subjectschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and b.subjectstatus='A' and b.subjectid=c.subjectid and a.standardscheduleid=c.standardscheduleid and c.status='A'";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	
	
	/**
	 * Method used to get list subject scheduled for the standard with marks details for previous session
	 * @param standardscheduleid from standardschedule
	 * @param standardid from standard
	 * @param sessionid from yearofsession
	 * This method is accessed from kycportal/jsp/Schedule/MarkScheduleCheck.jsp
	*/
	public ArrayList viewSubjectsMarksPrevious(String standardscheduleid,String standardid,String sessionid)
	{
	 	log.info("invoking viewSubjectsMarksPrevious(String standardscheduleid,String standardid,String sessionid) from com.iGrandee.Schedule.Schedule");
	
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select b.subjectname,b.subjectcode,b.description,b.subjectid,c.subjectscheduleid, case when d.theoryinternalmin is null then '' else d.theoryinternalmin end as theoryinternalmin, case when d.theoryinternalmax is null then '' else d.theoryinternalmax end as theoryinternalmax, case when d.theoryexternalmin is null then '' else d.theoryexternalmin end as theoryexternalmin , case when d.theoryexternalmax is null then '' else d.theoryexternalmax end as theoryexternalmax, case when d.practicalinternalmin is null then '' else d.practicalinternalmin end as practicalinternalmin, case when d.practicalinternalmax is null then '' else d.practicalinternalmax end as practicalinternalmax, case when d.practicalexternalmin is null then '' else d.practicalexternalmin end as practicalexternalmin, case when d.practicalexternalmax is null then '' else d.practicalexternalmax end as practicalexternalmax, case when d.projectinternalmin is null then '' else d.projectinternalmin end as projectinternalmin, case when d.projectinternalmax is null then '' else d.projectinternalmax end as projectinternalmax, case when d.projectexternalmin is null then '' else d.projectexternalmin end as projectexternalmin, case when d.projectexternalmax is null then '' else d.projectexternalmax end as projectexternalmax, case when d.credithours is null then '' else d.credithours end as credithours from standardschedule a join subject b on a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and b.subjectstatus='A' join subjectschedule c on b.subjectid=c.subjectid and a.standardscheduleid=c.standardscheduleid and c.status='A' left outer join subjectschedule d on c.subjectid=d.subjectid and d.status='A' and d.subjectscheduleid in (select a1.subjectscheduleid from subjectschedule a1,standardschedule b1 where b1.sessionid='"+sessionid+"' and b1.standardid='"+standardid+"' and a1.standardscheduleid=b1.standardscheduleid and a1.status='A')";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	
	/**
	 * Method used to get list sessions except current session in which the purticular standard is scheduled
	 * This method is accessed from kycportal/jsp/Schedule/ImportMarkSchedule.jsp
	 * @param standardid from standard
	 * @param sessionid from yearofsession
	*/
	public ArrayList viewSessionMarks(String standardid,String sessionid)
	{
	 	log.info("invoking viewSubjectsMarks(String standardscheduleid) from com.iGrandee.Schedule.Schedule");
	
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select distinct a.sessionid,a.sessionname from yearofsession a,standardschedule b where b.standardid='"+standardid+"' and a.sessionid=b.sessionid and b.sessionid<>'"+sessionid+"' and (a.sessionstatus='A' or a.sessionstatus='R')";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	

/*
 * This method is accessed from kycportal/jsp/Schedule/EditSubjectScheduled.jsp
*/
public ArrayList viewSubjectsScheduledDetail(String subjectscheduleid)
{
 	log.info("invoking viewSubjects from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax, practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours from subjectschedule where subjectscheduleid='"+subjectscheduleid+"'";   
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/StandardTrashPreview.jsp
*/
public ArrayList viewSubjectsScheduled(String standardscheduleid)
{
 	log.info("invoking viewSubjectsScheduled from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.subjectname,b.subjectcode,b.description,b.subjectid,c.subjectscheduleid  from standardschedule a,subject b,subjectschedule c where  a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid  and b.subjectstatus='A' and b.subjectid=c.subjectid and  a.standardscheduleid=c.standardscheduleid and c.status='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Schedule/TrashSubjectPreview.jsp
*/
public ArrayList viewLessonScheduled(String subjectscheduleid)
{
 	log.info("invoking viewLessonScheduled from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.lessonname,b.lessondescription from lessonschedule a,lesson b where a.subjectscheduleid='"+subjectscheduleid+"' and a.lessonid=b.lessonid and b.lessonstatus='A' and a.status='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Schedule/TrashSubjectPreview.jsp
*/
public ArrayList viewSectionandStaff(String subjectscheduleid)
{
 	log.info("invoking viewSectionandStaff from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT sectionname,concat(firstname,' ',lastname) as staffname FROM subjectallotment a,sectionschedule b,section c, staffmaster d,login e,personmaster f where a.subjectscheduleid='"+subjectscheduleid+"' and a.subjectallotmentstatus='A' and a.sectionpublishid=b.sectionscheduleid and b.sectionschedulestatus='A' and b.sectionid=c.sectionid and c.status='A' and a.staffid=d.staffid and d.staffstatus='A' and d.userid=e.userid and e.loginstatus='A' and e.personid=f.personid and f.status='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/TrashSectionPreview.jsp
*/
public ArrayList viewSubjectandStaff(String sectionscheduleid)
{
 	log.info("invoking viewSubjectandStaff from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT subjectname,concat(firstname,' ',lastname) as staffname FROM subjectallotment a, subjectschedule b,subject c, staffmaster d,login e,personmaster f where a.sectionpublishid='"+sectionscheduleid+"' and a.subjectallotmentstatus='A' and a.subjectscheduleid=b.subjectscheduleid and b.status='A' and b.subjectid=c.subjectid and c.subjectstatus='A' and a.staffid=d.staffid and d.staffstatus='A' and d.userid=e.userid and e.loginstatus='A' and e.personid=f.personid and f.status='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Schedule/TrashSectionPreview.jsp
*/
public ArrayList viewSectionStudents(String sectionscheduleid)
{
 	log.info("invoking viewSectionStudents from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select concat(firstname,' ',lastname) as studentname from studentallocation a,candidateregister b,personmaster c where a.sectionscheduleid='"+sectionscheduleid+"' and a.studentallocationstatus='A' and a.candidateregisterid=b.candidateregisterid and b.candidateregisterstatus='A' and b.personid=c.personid and c.status='A'";   
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/ViewLessons.jsp
*/
public ArrayList viewLessons(String subjectscheduleid)
{
 	log.info("invoking viewLessons from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.lessonname,b.lessondescription,b.lessonid,null as lessonscheduleid, 'No' as status from subjectschedule a,lesson b where a.subjectscheduleid='"+subjectscheduleid+"' and a.subjectid=b.subjectid and b.lessonstatus='A' and b.lessonid not in (select lessonid from lessonschedule where subjectscheduleid='"+subjectscheduleid+"' and lessonid=b.lessonid and status<>'X') union select b.lessonname,b.lessondescription, b.lessonid,c.lessonscheduleid, 'Yes' as status from subjectschedule a, lesson b,lessonschedule c where a.subjectscheduleid='"+subjectscheduleid+"' and a.subjectid=b.subjectid and b.lessonstatus='A' and b.lessonid=c.lessonid and a.subjectscheduleid=c.subjectscheduleid and c.status='A'";  
			log.info(select_query);
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/DeActivatedLessons.jsp
*/
public ArrayList viewLessonsDeactive(String subjectscheduleid)
{
 	log.info("invoking viewLessonsDeactive from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.lessonname,b.lessondescription, b.lessonid,c.lessonscheduleid, 'Yes' as status from subjectschedule a, lesson b,lessonschedule c where a.subjectscheduleid='"+subjectscheduleid+"' and a.subjectid=b.subjectid and b.lessonstatus='A' and b.lessonid=c.lessonid and a.subjectscheduleid=c.subjectscheduleid and c.status='T'";   
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}



/*
 * This method is accessed from kycportal/jsp/Schedule/ViewSections.jsp 
 * modified by kumaran date:11th july 2011 [instituteid inclusion]
*/
public ArrayList viewSections(String standardscheduleid,String instituteid)
{
 	log.info("invoking viewSections from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query	= "select b.sectionname,b.description,b.sectionid,null as sectionscheduleid, 'No' as status from section b where b.status='A' and b.instituteid='"+instituteid+"' and b.sectionid  not in (select a1.sectionid from sectionschedule a1,section b1  where standardscheduleid='"+standardscheduleid+"' and a1.sectionid=b1.sectionid and b1.instituteid='"+instituteid+"' and a1.sectionschedulestatus<>'X') union select b.sectionname,b.description,b.sectionid, c.sectionscheduleid,'Yes' as status from standardschedule a,section b,sectionschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardscheduleid=c.standardscheduleid and b.status='A' and b.sectionid=c.sectionid and a.instituteid='"+instituteid+"' and c.sectionschedulestatus='A'";
			periodsList 	= common_data_object.getListMap(select_query);
			
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/StandardTrashPreview.jsp
*/
public ArrayList viewSectionsScheduled(String standardscheduleid)
{
 	log.info("invoking viewSectionsScheduled from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.sectionname,b.description,b.sectionid,c.sectionscheduleid from standardschedule a,section b,sectionschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardscheduleid=c.standardscheduleid and b.status='A'  and b.sectionid=c.sectionid and c.sectionschedulestatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/DeActivatedSubjects.jsp
*/
public ArrayList viewDeActiveSubjects(String standardscheduleid)
{
 	log.info("invoking viewDeActiveSubjects from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.subjectname,b.subjectcode,b.description,b.subjectid,c.subjectscheduleid from standardschedule a,subject b,subjectschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and b.subjectstatus='A' and b.subjectid=c.subjectid and a.standardscheduleid=c.standardscheduleid and c.status='T'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/DeActivatedSections.jsp
*/
public ArrayList viewDeActiveSecctionss(String standardscheduleid)
{
 	log.info("invoking viewDeActiveSecctionss from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.sectionname,b.description,b.sectionid,c.sectionscheduleid from standardschedule a,section b,sectionschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardscheduleid=c.standardscheduleid and b.status='A' and b.sectionid=c.sectionid and c.sectionschedulestatus='T'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Schedule/LessonTrashPreview.jsp
*/
public ArrayList viewAssignmentTopics(String lessonscheduleid)
{
 	log.info("invoking viewAssignmentTopics from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT questionname FROM assignemntquestion  where lessonscheduleid='"+lessonscheduleid+"' and status='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Schedule/LessonTrashPreview.jsp
*/
public ArrayList viewDiaryDetails(String lessonscheduleid)
{
 	log.info("invoking viewDiaryDetails from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT subject,workdetails FROM studentdiary where lessonscheduleid='"+lessonscheduleid+"' and studentdiarystatus='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

	/*
	 * This method is accessed from kycportal/jsp/Schedule/LessonTrashPreview.jsp
	*/
public ArrayList viewWorkDoneDetails(String lessonscheduleid)
{
 	log.info("invoking viewWorkDoneDetails from com.iGrandee.Schedule.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT workdonedetails FROM wrokdoneregister where lessonscheduleid='"+lessonscheduleid+"' and workdonestatus='A'";  
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

	/**
	 * This method is used for inserting the standard schedule details from the java bean.It is accessed 
	 * from jsp/Schedule/PublishStandard.jsp
	 * @param bean
	 * @return int  value contains the result of the schedule.
	 * @throws SQLException
	 * @throws Exception
	 */


public int publishStandards(ScheduleBean bean)throws SQLException,Exception {
	
	
 	log.info("invoking publishStandards(ScheduleBean bean) from com.iGrandee.Schedule.Schedule");

	
	String[] standards		= bean.getStandardids();
	String[] groups			= bean.getGroupids();
	String[] starts			= bean.getStartdates();
	String[] ends			= bean.getEnddates();
	
	String[] noofseats 		= bean.getNoofseatss();
	
	String lastdate			= bean.getLastdate();
	String sessionid		= bean.getSessionid();
	String instituteid		= bean.getInstituteid();
	String userid 			= bean.getUserid();
	String ipaddress		= bean.getIpaddress();
	

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	
	
	PreparedStatement sessons	 	= null;
	PreparedStatement sessons1	 	= null;

	
	PreparedStatement stdschedule 	= null;
	PreparedStatement stdid		 	= null;
	ResultSet stdrs		 			= null;
	
	PreparedStatement secschedule 	= null;
	PreparedStatement secid		 	= null;
	ResultSet secrs		 			= null;
	
	PreparedStatement sections	 	= null;
	ResultSet sectionrs	 			= null;
	
	PreparedStatement subschedule 	= null;
	PreparedStatement subid 		= null;
	ResultSet subrs		 			= null;
	
	PreparedStatement subjects	 	= null;
	ResultSet subjectsrs	 		= null;
	
	
	PreparedStatement lesschedule 	= null;
	PreparedStatement lesid 		= null;
	ResultSet lesrs		 			= null;
	
	PreparedStatement lessons	 	= null;
	ResultSet lessonrs	 			= null;
	
	
	long standardid					= 0l;
	long sectionid					= 0l;
	long subjectid					= 0l;
	long lessonid					= 0l;
	
	int[] result					= null;
	
	String curTime					= DateTime.showTime("MySqlWithTime");

	try {
		
		sessons				= connection.prepareStatement("update yearofsession set sessionstatus=? where sessionid=? and instituteid=?");
		sessons.setString(1, "A");
		sessons.setString(2, sessionid);
		sessons.setString(3, instituteid);
		return_value 		+= sessons.executeUpdate();
		
		
		sessons1			= connection.prepareStatement("update yearofsession set sessionstatus=? where sessionid<>? and instituteid=? and sessionstatus=?");
		sessons1.setString(1, "R");
		sessons1.setString(2, sessionid);
		sessons1.setString(3, instituteid);
		sessons1.setString(4, "A");
		return_value 		+= sessons1.executeUpdate();
		
		
		sections			= connection.prepareStatement("select sectionid from section where instituteid=? and status=?");
		subjects			= connection.prepareStatement("select subjectid, theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax, practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours from subject where standardid=? and subjectstatus=?");
		lessons				= connection.prepareStatement("select lessonid  from lesson  where subjectid=? and lessonstatus=?");
			
		stdid				= connection.prepareStatement("select max(standardscheduleid) from standardschedule");
		stdrs				= stdid.executeQuery();
		
		if(stdrs.next())
			standardid	 	= stdrs.getLong(1);
		standardid++;
		
		stdschedule			= connection.prepareStatement("insert into standardschedule(standardscheduleid, standardid, groupid, eligibility, noofseats, startdate, enddate, applicationlastdate, createdby, instituteid, ipaddress, stdschedulestatus, sessionid) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
		
		
		
		secid				= connection.prepareStatement("select max(sectionscheduleid) from sectionschedule");
		secrs				= secid.executeQuery();
		
		if(secrs.next())
			sectionid	 	= secrs.getLong(1);
		
		sectionid++;	
		
		secschedule			= connection.prepareStatement("insert into sectionschedule(sectionscheduleid, standardscheduleid, sectionid, createdby, dateofcreation, sectionschedulestatus) values(?,?,?,?,?,?)");
		
		subid				= connection.prepareStatement("select max(subjectscheduleid) from subjectschedule");
		subrs				= subid.executeQuery();
		
		if(subrs.next())
			subjectid	 	= subrs.getLong(1);
		
		subjectid++;	
		
		subschedule			= connection.prepareStatement("insert into subjectschedule(subjectscheduleid, subjectid, standardscheduleid, createdby, dateofcreation, status, theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax, practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		
		
		lesid				= connection.prepareStatement("select max(lessonscheduleid) from lessonschedule");
		lesrs				= lesid.executeQuery();
		
		if(lesrs.next())
			lessonid	 	= lesrs.getLong(1);
		
		lessonid++;	
		
		lesschedule			= connection.prepareStatement("insert into lessonschedule(lessonscheduleid, lessonid, subjectscheduleid, createdby, dateofcreation, status)values(?,?,?,?,?,?)");
		
		

		
		if(standards != null && standards.length>0){
			for(int y=0;y<standards.length;y++){
				
				stdschedule.setLong(1, standardid);
				stdschedule.setString(2, standards[y]);
				if(groups[y] != null && groups[y].equals("-"))
					stdschedule.setString(3, null);
				else
					stdschedule.setString(3, groups[y]);
				stdschedule.setString(4, "-");
				//stdschedule.setString(5, "0");
				stdschedule.setString(5, noofseats[y]);
				stdschedule.setString(6, datetime.getMySQLFormat(starts[y]).toString());
				stdschedule.setString(7, datetime.getMySQLFormat(ends[y]).toString());
				stdschedule.setString(8, datetime.getMySQLFormat(lastdate).toString());
				stdschedule.setString(9, userid);
				stdschedule.setString(10, instituteid);
				stdschedule.setString(11, ipaddress);
				stdschedule.setString(12, "A");
				stdschedule.setString(13, sessionid);
				System.out.println("stdschedule"+stdschedule);
				stdschedule.addBatch();
				
				sections.setString(1,instituteid);
				sections.setString(2,"A");
				sectionrs			= sections.executeQuery();

				
				while(sectionrs.next()){
			
					secschedule.setLong(1, sectionid);
					secschedule.setLong(2, standardid);
					secschedule.setString(3, sectionrs.getString(1));
					secschedule.setString(4, userid);
					secschedule.setString(5, curTime);
					secschedule.setString(6, "A");
					secschedule.addBatch();
					sectionid++;
				}
	
				
				if(sectionrs != null)
					sectionrs.close();
				
				subjects.setString(1, standards[y]);
				subjects.setString(2, "A");
				subjectsrs	= subjects.executeQuery();
				
				
				while(subjectsrs.next()){
					
					subschedule.setLong(1, subjectid);
					subschedule.setString(2, subjectsrs.getString(1));
					subschedule.setLong(3, standardid);
					subschedule.setString(4, userid);
					subschedule.setString(5, curTime);
					subschedule.setString(6, "A");
					
					subschedule.setString(7, subjectsrs.getString(2));
					subschedule.setString(8, subjectsrs.getString(3));
					subschedule.setString(9, subjectsrs.getString(4));
					subschedule.setString(10, subjectsrs.getString(5));
					subschedule.setString(11, subjectsrs.getString(6));
					subschedule.setString(12, subjectsrs.getString(7));
					subschedule.setString(13, subjectsrs.getString(8));
					subschedule.setString(14, subjectsrs.getString(9));
					subschedule.setString(15, subjectsrs.getString(10));
					subschedule.setString(16, subjectsrs.getString(11));
					subschedule.setString(17, subjectsrs.getString(12));
					subschedule.setString(18, subjectsrs.getString(13));
					subschedule.setString(19, subjectsrs.getString(14));
					subschedule.addBatch();
					
					lessons.setString(1, subjectsrs.getString(1));
					lessons.setString(2, "A");
					lessonrs	= lessons.executeQuery();
					
					while(lessonrs.next()){
						
						lesschedule.setLong(1, lessonid);
						lesschedule.setString(2, lessonrs.getString(1));
						lesschedule.setLong(3, subjectid);
						lesschedule.setString(4, userid);
						lesschedule.setString(5, curTime);
						lesschedule.setString(6, "A");
						lesschedule.addBatch();
						
						lessonid++;
						
					}
					
					if(lessonrs != null)
						lessonrs.close();
					
					subjectid++;
				}
				standardid++;
				
				if(subjectsrs != null)
					subjectsrs.close();
			}
		}
		
		
		result		= 	stdschedule.executeBatch();
		
		if(result != null)
		for(int y=0;y<result.length;y++)
			return_value += result[y];
		
		result		= 	secschedule.executeBatch();
		
		if(result != null)
		for(int y=0;y<result.length;y++)
			return_value += result[y];
		
		result		= 	subschedule.executeBatch();
		
		if(result != null)
		for(int y=0;y<result.length;y++)
			return_value += result[y];
		
		result		= 	lesschedule.executeBatch();
		
		if(result != null)
		for(int y=0;y<result.length;y++)
			return_value += result[y];		

		
		connection.commit();
	
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		sqlexception.printStackTrace();
		if(connection != null)
			connection.rollback();
		return_value = 0;
	}
	finally {
		
		if(sessons != null)
			sessons.close();
		
		if(sessons1 != null)
			sessons1.close();
	
		if(stdrs != null)
			stdrs.close();
		
		if(stdid != null)
			stdid.close();
		
		if(stdschedule != null)
			stdschedule.close();	
		
		if(lesrs != null)
			lesrs.close();
		
		if(lesid != null)
			lesid.close();
		
		if(lesschedule != null)
			lesschedule.close();		
		
		
		if(secrs != null)
			secrs.close();
		
		if(secid != null)
			secid.close();
		
		if(secschedule != null)
			secschedule.close();	
		
		if(subrs != null)
			subrs.close();
		
		if(subid != null)
			subid.close();
		
		if(subschedule != null)
			subschedule.close();	
		
		if(subjectsrs != null)
			subjectsrs.close();
	
		if(subjects != null)
			subjects.close();
		
		if(sections != null)
			sections.close();
		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
}




	public int publishStandards(String[] standards,String[] groups,String[] starts,String[] ends,String lastdate,String sessionid,String instituteid,String userid, String ipaddress)throws SQLException,Exception {
		
	 	log.info("invoking publishStandards from com.iGrandee.Schedule.Schedule");
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		
		PreparedStatement sessons	 	= null;
		PreparedStatement sessons1	 	= null;
	
		
		PreparedStatement stdschedule 	= null;
		PreparedStatement stdid		 	= null;
		ResultSet stdrs		 			= null;
		
		PreparedStatement secschedule 	= null;
		PreparedStatement secid		 	= null;
		ResultSet secrs		 			= null;
		
		PreparedStatement sections	 	= null;
		ResultSet sectionrs	 			= null;
		
		PreparedStatement subschedule 	= null;
		PreparedStatement subid 		= null;
		ResultSet subrs		 			= null;
		
		PreparedStatement subjects	 	= null;
		ResultSet subjectsrs	 		= null;
		
		
		PreparedStatement lesschedule 	= null;
		PreparedStatement lesid 		= null;
		ResultSet lesrs		 			= null;
		
		PreparedStatement lessons	 	= null;
		ResultSet lessonrs	 			= null;
		
		
		long standardid					= 0l;
		long sectionid					= 0l;
		long subjectid					= 0l;
		long lessonid					= 0l;
		
		int[] result					= null;
		
		String curTime					= DateTime.showTime("MySqlWithTime");
	
		try {
			
			sessons				= connection.prepareStatement("update yearofsession set sessionstatus=? where sessionid=? and instituteid=?");
			sessons.setString(1, "A");
			sessons.setString(2, sessionid);
			sessons.setString(3, instituteid);
			return_value 		+= sessons.executeUpdate();
			
			
			sessons1			= connection.prepareStatement("update yearofsession set sessionstatus=? where sessionid<>? and instituteid=? and sessionstatus=?");
			sessons1.setString(1, "R");
			sessons1.setString(2, sessionid);
			sessons1.setString(3, instituteid);
			sessons1.setString(4, "A");
			return_value 		+= sessons1.executeUpdate();
			
			
			sections			= connection.prepareStatement("select sectionid from section where instituteid=? and status=?");
			subjects			= connection.prepareStatement("select subjectid, theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax, practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours from subject where standardid=? and subjectstatus=?");
			lessons				= connection.prepareStatement("select lessonid  from lesson  where subjectid=? and lessonstatus=?");
				
			stdid				= connection.prepareStatement("select max(standardscheduleid) from standardschedule");
			stdrs				= stdid.executeQuery();
			
			if(stdrs.next())
				standardid	 	= stdrs.getLong(1);
			standardid++;
			
			stdschedule			= connection.prepareStatement("insert into standardschedule(standardscheduleid, standardid, groupid, eligibility, noofseats, startdate, enddate, applicationlastdate, createdby, instituteid, ipaddress, stdschedulestatus, sessionid) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			
			
			secid				= connection.prepareStatement("select max(sectionscheduleid) from sectionschedule");
			secrs				= secid.executeQuery();
			
			if(secrs.next())
				sectionid	 	= secrs.getLong(1);
			
			sectionid++;	
			
			secschedule			= connection.prepareStatement("insert into sectionschedule(sectionscheduleid, standardscheduleid, sectionid, createdby, dateofcreation, sectionschedulestatus) values(?,?,?,?,?,?)");
			
			subid				= connection.prepareStatement("select max(subjectscheduleid) from subjectschedule");
			subrs				= subid.executeQuery();
			
			if(subrs.next())
				subjectid	 	= subrs.getLong(1);
			
			subjectid++;	
			
			subschedule			= connection.prepareStatement("insert into subjectschedule(subjectscheduleid, subjectid, standardscheduleid, createdby, dateofcreation, status, theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax, practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			
			
			lesid				= connection.prepareStatement("select max(lessonscheduleid) from lessonschedule");
			lesrs				= lesid.executeQuery();
			
			if(lesrs.next())
				lessonid	 	= lesrs.getLong(1);
			
			lessonid++;	
			
			lesschedule			= connection.prepareStatement("insert into lessonschedule(lessonscheduleid, lessonid, subjectscheduleid, createdby, dateofcreation, status)values(?,?,?,?,?,?)");
			
			
	
			
			if(standards != null && standards.length>0){
				for(int y=0;y<standards.length;y++){
					
					stdschedule.setLong(1, standardid);
					stdschedule.setString(2, standards[y]);
					if(groups[y] != null && groups[y].equals("-"))
						stdschedule.setString(3, null);
					else
						stdschedule.setString(3, groups[y]);
					stdschedule.setString(4, "-");
					stdschedule.setString(5, "0");
					stdschedule.setString(6, datetime.getMySQLFormat(starts[y]).toString());
					stdschedule.setString(7, datetime.getMySQLFormat(ends[y]).toString());
					stdschedule.setString(8, datetime.getMySQLFormat(lastdate).toString());
					stdschedule.setString(9, userid);
					stdschedule.setString(10, instituteid);
					stdschedule.setString(11, ipaddress);
					stdschedule.setString(12, "A");
					stdschedule.setString(13, sessionid);
					stdschedule.addBatch();
					
					sections.setString(1,instituteid);
					sections.setString(2,"A");
					sectionrs			= sections.executeQuery();
	
					
					while(sectionrs.next()){
				
						secschedule.setLong(1, sectionid);
						secschedule.setLong(2, standardid);
						secschedule.setString(3, sectionrs.getString(1));
						secschedule.setString(4, userid);
						secschedule.setString(5, curTime);
						secschedule.setString(6, "A");
						secschedule.addBatch();
						sectionid++;
					}
		
					
					if(sectionrs != null)
						sectionrs.close();
					
					subjects.setString(1, standards[y]);
					subjects.setString(2, "A");
					subjectsrs	= subjects.executeQuery();
					
					
					while(subjectsrs.next()){
						
						subschedule.setLong(1, subjectid);
						subschedule.setString(2, subjectsrs.getString(1));
						subschedule.setLong(3, standardid);
						subschedule.setString(4, userid);
						subschedule.setString(5, curTime);
						subschedule.setString(6, "A");
						
						subschedule.setString(7, subjectsrs.getString(2));
						subschedule.setString(8, subjectsrs.getString(3));
						subschedule.setString(9, subjectsrs.getString(4));
						subschedule.setString(10, subjectsrs.getString(5));
						subschedule.setString(11, subjectsrs.getString(6));
						subschedule.setString(12, subjectsrs.getString(7));
						subschedule.setString(13, subjectsrs.getString(8));
						subschedule.setString(14, subjectsrs.getString(9));
						subschedule.setString(15, subjectsrs.getString(10));
						subschedule.setString(16, subjectsrs.getString(11));
						subschedule.setString(17, subjectsrs.getString(12));
						subschedule.setString(18, subjectsrs.getString(13));
						subschedule.setString(19, subjectsrs.getString(14));
						subschedule.addBatch();
						
						lessons.setString(1, subjectsrs.getString(1));
						lessons.setString(2, "A");
						lessonrs	= lessons.executeQuery();
						
						while(lessonrs.next()){
							
							lesschedule.setLong(1, lessonid);
							lesschedule.setString(2, lessonrs.getString(1));
							lesschedule.setLong(3, subjectid);
							lesschedule.setString(4, userid);
							lesschedule.setString(5, curTime);
							lesschedule.setString(6, "A");
							lesschedule.addBatch();
							
							lessonid++;
							
						}
						
						if(lessonrs != null)
							lessonrs.close();
						
						subjectid++;
					}
					standardid++;
					
					if(subjectsrs != null)
						subjectsrs.close();
				}
			}
			
			
			result		= 	stdschedule.executeBatch();
			
			if(result != null)
			for(int y=0;y<result.length;y++)
				return_value += result[y];
			
			result		= 	secschedule.executeBatch();
			
			if(result != null)
			for(int y=0;y<result.length;y++)
				return_value += result[y];
			
			result		= 	subschedule.executeBatch();
			
			if(result != null)
			for(int y=0;y<result.length;y++)
				return_value += result[y];
			
			result		= 	lesschedule.executeBatch();
			
			if(result != null)
			for(int y=0;y<result.length;y++)
				return_value += result[y];		
	
		connection.commit();
		
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		sqlexception.printStackTrace();
		if(connection != null)
			connection.rollback();
		return_value = 0;
	}
	
	
	finally {
		
		if(sessons != null)
			sessons.close();
		
		if(sessons1 != null)
			sessons1.close();
	
		if(stdrs != null)
			stdrs.close();
		
		if(stdid != null)
			stdid.close();
		
		if(stdschedule != null)
			stdschedule.close();	
		
		if(lesrs != null)
			lesrs.close();
		
		if(lesid != null)
			lesid.close();
		
		if(lesschedule != null)
			lesschedule.close();		
		
		
		if(secrs != null)
			secrs.close();
		
		if(secid != null)
			secid.close();
		
		if(secschedule != null)
			secschedule.close();	
		
		if(subrs != null)
			subrs.close();
		
		if(subid != null)
			subid.close();
		
		if(subschedule != null)
			subschedule.close();	
		
		if(subjectsrs != null)
			subjectsrs.close();
	
		if(subjects != null)
			subjects.close();
		
		if(sections != null)
			sections.close();
		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
}


public int updateSubjects(String subjectscheduleid,String seats[],String credithours)throws SQLException,Exception {
	
 	log.info("invoking updateSUbjects from com.iGrandee.Schedule.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	
	PreparedStatement stdschedule 	= null;

	try {
		
		stdschedule			= connection.prepareStatement("update subjectschedule set theoryinternalmin=?, theoryinternalmax=?, theoryexternalmin=?, theoryexternalmax=?, practicalinternalmin=?, practicalinternalmax=?, practicalexternalmin=?, practicalexternalmax=?, projectinternalmin=?, projectinternalmax=?, projectexternalmin=?, projectexternalmax=?,credithours=? where subjectscheduleid=?");
				
		stdschedule.setString(1, seats[0]);
		stdschedule.setString(2, seats[1]);
		stdschedule.setString(3, seats[2]);
		stdschedule.setString(4, seats[3]);
		stdschedule.setString(5, seats[4]);
		stdschedule.setString(6, seats[5]);
		stdschedule.setString(7, seats[6]);
		stdschedule.setString(8, seats[7]);
		stdschedule.setString(9, seats[8]);
		stdschedule.setString(10, seats[9]);
		stdschedule.setString(11, seats[10]);
		stdschedule.setString(12, seats[11]);
		stdschedule.setString(13, credithours);
		stdschedule.setString(14, subjectscheduleid);

		return_value		= 	stdschedule.executeUpdate();
		
		connection.commit();
		
}
catch(SQLException sqlexception) { 
	
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
	log.error(sqlexception);
	
}


finally {
	
	if(stdschedule != null)
		stdschedule.close();
	
	if(connection != null)
		connection.close();
	
}
return return_value;
}

	/**
	 * This method is used to update the standard schedule details through the details in java bean. It is 
	 * accessed from jsp/Schedule/UpdateSchedule.jsp
	 * @param bean
	 * @return int value 0 for failuire and 1 for success.
	 * @throws SQLException
	 * @throws Exception
	 */


	public int updateStandards(ScheduleBean bean)throws SQLException,Exception {
		
	 	log.info("invoking updateStandards(ScheduleBean bean) from com.iGrandee.Schedule.Schedule");
	 	
	 	String standardscheduleid	= bean.getStandardscheduleid();
	 	String seats				= bean.getNoofseats();
	 	String eligibility			= bean.getEligibility();
	 	String startdate			= bean.getStartdate();
	 	String enddate				= bean.getEnddate();
	 	String lastdate				= bean.getLastdate();
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement stdschedule 	= null;
	
		try {
			
			stdschedule			= connection.prepareStatement("update standardschedule set eligibility=?, noofseats=?, startdate=?, enddate=?, applicationlastdate=?  where standardscheduleid=?");
					
			stdschedule.setString(1, eligibility);
			stdschedule.setString(2, seats);
			stdschedule.setString(3, datetime.getMySQLFormat(startdate).toString());
			stdschedule.setString(4, datetime.getMySQLFormat(enddate).toString());
			stdschedule.setString(5, datetime.getMySQLFormat(lastdate).toString());
			stdschedule.setString(6, standardscheduleid);
		
	
			return_value		= 	stdschedule.executeUpdate();
			
			connection.commit();
			
		}
		catch(SQLException sqlexception) { 
			
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			log.error(sqlexception);
			
		}
		
		
		finally {
			
			if(stdschedule != null)
				stdschedule.close();
			
			if(connection != null)
				connection.close();
			
		}
		return return_value;
	}


	public int updateStandards(String standardscheduleid,String seats,String eligibility,String startdate,String enddate,String lastdate)throws SQLException,Exception {
		
	 	log.info("invoking updateStandards from com.iGrandee.Schedule.Schedule");
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement stdschedule 	= null;
	
		try {
			
			stdschedule			= connection.prepareStatement("update standardschedule set eligibility=?, noofseats=?, startdate=?, enddate=?, applicationlastdate=?  where standardscheduleid=?");
					
			stdschedule.setString(1, eligibility);
			stdschedule.setString(2, seats);
			stdschedule.setString(3, datetime.getMySQLFormat(startdate).toString());
			stdschedule.setString(4, datetime.getMySQLFormat(enddate).toString());
			stdschedule.setString(5, datetime.getMySQLFormat(lastdate).toString());
			stdschedule.setString(6, standardscheduleid);
		
	
			return_value		= 	stdschedule.executeUpdate();
			
			connection.commit();
			
		}
		catch(SQLException sqlexception) { 
			
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			log.error(sqlexception);
			
		}
		
		
		finally {
			
			if(stdschedule != null)
				stdschedule.close();
			
			if(connection != null)
				connection.close();
			
		}
		return return_value;
	}

	public int markScheduleMultiple(ScheduleBean bean)throws SQLException,Exception {
		
	 	log.info("invoking markScheduleMultiple from com.iGrandee.Schedule.Schedule");
	 	
	 	
	 	String[] subjectsheduleid		= bean.getSubjectscheduleids();
	 	String[] theoryinternalmin		= bean.getTheoryinternalmin();
	 	String[] theoryinternalmax		= bean.getTheoryinternalmax();
	 	String[] theoryexternalmin		= bean.getTheoryexternalmin();
	 	String[] theoryexternalmax		= bean.getTheoryexternalmax();
	 	String[] practicalinternalmin	= bean.getPracticalinternalmin();
	 	String[] practicalinternalmax	= bean.getPracticalinternalmax();
	 	String[] practicalexternalmin	= bean.getPracticalexternalmin();
	 	String[] practicalexternalmax	= bean.getPracticalexternalmax();
	 	String[] projectinternalmin		= bean.getProjectinternalmin();
	 	String[] projectinternalmax		= bean.getProjectinternalmax();
	 	String[] projectexternalmin		= bean.getProjectexternalmin();
	 	String[] projectexternalmax		= bean.getProjectexternalmax();
	 	String[] credithours	 		= bean.getCredithours();
	 	
	 	

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement subschedule 	= null;

		try {
			

			
			subschedule			= connection.prepareStatement("update subjectschedule set theoryinternalmin=?, theoryinternalmax=?, theoryexternalmin=?, theoryexternalmax=?,practicalinternalmin=?, practicalinternalmax=?, practicalexternalmin=?, practicalexternalmax=?, projectinternalmin=?, projectinternalmax=?,projectexternalmin=?, projectexternalmax=?,credithours=? where subjectscheduleid=?");
			
			
			if(subjectsheduleid != null && subjectsheduleid.length>0){
				
				for(int y=0;y<subjectsheduleid.length;y++){
					
					subschedule.setString(1, theoryinternalmin[y]);
					subschedule.setString(2, theoryinternalmax[y]);
					subschedule.setString(3, theoryexternalmin[y]);
					subschedule.setString(4, theoryexternalmax[y]);
					subschedule.setString(5, practicalinternalmin[y]);
					subschedule.setString(6, practicalinternalmax[y]);
					subschedule.setString(7, practicalexternalmin[y]);
					subschedule.setString(8, practicalexternalmax[y]);
					subschedule.setString(9,  projectexternalmin[y]);
					subschedule.setString(10, projectexternalmax[y]);
					subschedule.setString(11, projectexternalmin[y]);
					subschedule.setString(12, projectexternalmax[y]);
					//subschedule.setString(13, credithours[y]);
					subschedule.setString(13, "0");
					subschedule.setString(14, subjectsheduleid[y]);
					subschedule.addBatch();
				}
			}
			
			int temp[]		= subschedule.executeBatch();
			
			if(temp != null && temp.length>0)
				for(int y=0;y<temp.length;y++)
					return_value += temp[y];
		
			
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
		
	}


	finally {
		
		
		if(subschedule != null)
			subschedule.close();	

		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
	}
	

public int markScheduleMultiple(String[] subjectsheduleid,String[] theoryinternalmin, String[] theoryinternalmax, String[] theoryexternalmin,String[] theoryexternalmax,String[] practicalinternalmin,String[] practicalinternalmax,String[] practicalexternalmin,String[] practicalexternalmax,String[] projectinternalmin,String[] projectinternalmax, String[] projectexternalmin,String[] projectexternalmax,String[] credithours)throws SQLException,Exception {
	
 	log.info("invoking markScheduleMultiple from com.iGrandee.Schedule.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	
	PreparedStatement subschedule 	= null;

	try {
		

		
		subschedule			= connection.prepareStatement("update subjectschedule set theoryinternalmin=?, theoryinternalmax=?, theoryexternalmin=?, theoryexternalmax=?,practicalinternalmin=?, practicalinternalmax=?, practicalexternalmin=?, practicalexternalmax=?, projectinternalmin=?, projectinternalmax=?,projectexternalmin=?, projectexternalmax=?,credithours=? where subjectscheduleid=?");
		
		
		if(subjectsheduleid != null && subjectsheduleid.length>0){
			
			for(int y=0;y<subjectsheduleid.length;y++){
				
				subschedule.setString(1, theoryinternalmin[y]);
				subschedule.setString(2, theoryinternalmax[y]);
				subschedule.setString(3, theoryexternalmin[y]);
				subschedule.setString(4, theoryexternalmax[y]);
				subschedule.setString(5, practicalinternalmin[y]);
				subschedule.setString(6, practicalinternalmax[y]);
				subschedule.setString(7, projectinternalmin[y]);
				subschedule.setString(8, projectinternalmax[y]);
				subschedule.setString(9, projectexternalmin[y]);
				subschedule.setString(10, projectexternalmax[y]);
				subschedule.setString(11, projectexternalmin[y]);
				subschedule.setString(12, projectexternalmax[y]);
				//subschedule.setString(13, credithours[y]);
				subschedule.setString(13, "0");
				subschedule.setString(14, subjectsheduleid[y]);
				subschedule.addBatch();
			}
		}
		
		int temp[]		= subschedule.executeBatch();
		
		if(temp != null && temp.length>0)
			for(int y=0;y<temp.length;y++)
				return_value += temp[y];
	
		
		connection.commit();
}
catch(SQLException sqlexception) { 
	
	log.error(sqlexception);
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
	
}


finally {
	
	
	if(subschedule != null)
		subschedule.close();	

	
	if(connection != null)
		connection.close();
	
}
return return_value;
}


public int addSchedules(String  standardsheduleid,String subjectids,String createdby)throws SQLException,Exception {
	
 	log.info("invoking addSchedules from com.iGrandee.Schedule.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	
	PreparedStatement subschedule 	= null;
	PreparedStatement subid 		= null;
	ResultSet subrs		 			= null;
	
	PreparedStatement internalstmt 	= null;
	ResultSet internalrs 			= null;


	long subjectid					= 0l;

	
	String curTime					= DateTime.showTime("MySqlWithTime");

	try {
		

		subid				= connection.prepareStatement("select max(subjectscheduleid) from subjectschedule");
		subrs				= subid.executeQuery();
		
		if(subrs.next())
			subjectid	 	= subrs.getLong(1);
		
		subjectid++;	
		
		subschedule			= connection.prepareStatement("insert into subjectschedule(subjectscheduleid, subjectid, standardscheduleid, createdby, dateofcreation, status,theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax,practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		

					
		subschedule.setLong(1, subjectid);
		subschedule.setString(2, subjectids);
		subschedule.setString(3, standardsheduleid);
		subschedule.setString(4, createdby);
		subschedule.setString(5, curTime);
		subschedule.setString(6, "A");
		
		
		internalstmt		= connection.prepareStatement("select theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax,practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours from subject where subjectid=?"); 
		internalstmt.setString(1,subjectids);
		internalrs			= internalstmt.executeQuery();
		
		if(internalrs.next()){
		
			subschedule.setString(7, internalrs.getString(1));
			subschedule.setString(8, internalrs.getString(2));
			subschedule.setString(9, internalrs.getString(3));
			subschedule.setString(10, internalrs.getString(4));
			subschedule.setString(11, internalrs.getString(5));
			subschedule.setString(12, internalrs.getString(6));
			subschedule.setString(13, internalrs.getString(7));
			subschedule.setString(14, internalrs.getString(8));
			subschedule.setString(15, internalrs.getString(9));
			subschedule.setString(16, internalrs.getString(10));
			subschedule.setString(17, internalrs.getString(11));
			subschedule.setString(18, internalrs.getString(12));
			subschedule.setString(19, internalrs.getString(13));
		}
	
		return_value += subschedule.executeUpdate();
		connection.commit();
}
catch(SQLException sqlexception) { 
	
	log.error(sqlexception);
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
	
}


finally {
	
	
	if(subrs != null)
		subrs.close();
	
	if(subid != null)
		subid.close();
	
	if(subschedule != null)
		subschedule.close();	

	
	if(connection != null)
		connection.close();
	
}
return return_value;
}

/**
 * This methos is used for schedule the subjects through java bean. It is accessed from 
 * jap/Schedule/UpdateSubjects.jsp
 * @param bean
 * @return 0 for failuire and greater than 0 for success
 * @throws SQLException
 * @throws Exception
 */

public int addSchedules(ScheduleBean bean)throws SQLException,Exception {
	
 	log.info("invoking addSchedules(ScheduleBean bean) from com.iGrandee.Schedule.Schedule");
 	
 	String  standardsheduleid	= bean.getStandardscheduleid();
 	String subjectids			= bean.getSubjectid();
 	String createdby			= bean.getUserid();

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	
	PreparedStatement subschedule 	= null;
	PreparedStatement subid 		= null;
	ResultSet subrs		 			= null;
	
	PreparedStatement internalstmt 	= null;
	ResultSet internalrs 			= null;


	long subjectid					= 0l;

	
	String curTime					= DateTime.showTime("MySqlWithTime");

	try {
		

		subid				= connection.prepareStatement("select max(subjectscheduleid) from subjectschedule");
		subrs				= subid.executeQuery();
		
		if(subrs.next())
			subjectid	 	= subrs.getLong(1);
		
		subjectid++;	
		
		subschedule			= connection.prepareStatement("insert into subjectschedule(subjectscheduleid, subjectid, standardscheduleid, createdby, dateofcreation, status,theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax,practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours)values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		

					
		subschedule.setLong(1, subjectid);
		subschedule.setString(2, subjectids);
		subschedule.setString(3, standardsheduleid);
		subschedule.setString(4, createdby);
		subschedule.setString(5, curTime);
		subschedule.setString(6, "A");
		
		
		internalstmt		= connection.prepareStatement("select theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax,practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax,credithours from subject where subjectid=?"); 
		internalstmt.setString(1,subjectids);
		internalrs			= internalstmt.executeQuery();
		
		if(internalrs.next()){
		
			subschedule.setString(7, internalrs.getString(1));
			subschedule.setString(8, internalrs.getString(2));
			subschedule.setString(9, internalrs.getString(3));
			subschedule.setString(10, internalrs.getString(4));
			subschedule.setString(11, internalrs.getString(5));
			subschedule.setString(12, internalrs.getString(6));
			subschedule.setString(13, internalrs.getString(7));
			subschedule.setString(14, internalrs.getString(8));
			subschedule.setString(15, internalrs.getString(9));
			subschedule.setString(16, internalrs.getString(10));
			subschedule.setString(17, internalrs.getString(11));
			subschedule.setString(18, internalrs.getString(12));
			subschedule.setString(19, internalrs.getString(13));
		}
	
		return_value += subschedule.executeUpdate();
		connection.commit();
}
catch(SQLException sqlexception) { 
	
	log.error(sqlexception);
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
	
}


finally {
	
	
	if(subrs != null)
		subrs.close();
	
	if(subid != null)
		subid.close();
	
	if(subschedule != null)
		subschedule.close();	

	
	if(connection != null)
		connection.close();
	
}
return return_value;
}

/**
 * This method is used to update the subjectschedule status through the java bean. It is accessed from
 * jsp/Schedule/UpdateSubjects.jsp
 * @param bean
 * @return 0 for failuire of updation greater than zero for success.
 * @throws SQLException
 * @throws Exception
 */

public int updateSchedules(ScheduleBean bean)throws SQLException,Exception {
	
 	log.info("invoking updateSchedules(ScheduleBean bean) from com.iGrandee.Schedule.Schedule");
 	
 	String subjectscheduleid	= bean.getSubjectscheduletid();
 	String status				= bean.getStatus();

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	
	PreparedStatement subschedule 	= null;
	
	

	try {
		
	
		subschedule			= connection.prepareStatement("update subjectschedule set status=? where subjectscheduleid=?");
		

					
		subschedule.setString(1, status);
		subschedule.setString(2, subjectscheduleid);
		
		return_value += subschedule.executeUpdate();
		connection.commit();
}
catch(SQLException sqlexception) { 
	
	log.error(sqlexception);
	if(connection != null)
		connection.rollback();
	return_value = 0;
}


finally {
	
	
	if(subschedule != null)
		subschedule.close();	

	
	if(connection != null)
		connection.close();
	
}
return return_value;
}

public int updateSchedules(String subjectscheduleid,String status)throws SQLException,Exception {
	
 	log.info("invoking updateSchedules from com.iGrandee.Schedule.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	
	PreparedStatement subschedule 	= null;
	
	

	try {
		
	
		subschedule			= connection.prepareStatement("update subjectschedule set status=? where subjectscheduleid=?");
		

					
		subschedule.setString(1, status);
		subschedule.setString(2, subjectscheduleid);
		
		return_value += subschedule.executeUpdate();
		connection.commit();
}
catch(SQLException sqlexception) { 
	
	log.error(sqlexception);
	if(connection != null)
		connection.rollback();
	return_value = 0;
}


finally {
	
	
	if(subschedule != null)
		subschedule.close();	

	
	if(connection != null)
		connection.close();
	
}
return return_value;
}


	public int updateStandardScheduled(String subjectscheduleid,String status)throws SQLException,Exception {
		
	 	log.info("invoking updateStandardScheduled from com.iGrandee.Schedule.Schedule");
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement subschedule 	= null;
		
		try {
			
		
			subschedule			= connection.prepareStatement("update standardschedule set stdschedulestatus=? where standardscheduleid=?");
			
	
						
			subschedule.setString(1, status);
			subschedule.setString(2, subjectscheduleid);
			
			return_value += subschedule.executeUpdate();
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
		
	}
	
	
	finally {
		
		
		if(subschedule != null)
			subschedule.close();	
	
		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
	}
	
	
	/**
	 * This is used for updating the status of the standard schedule using java bean. It is accessed from
	 * jsp/Schedule/StandardTrashSubmit.jsp 
	 * @param bean
	 * @return int 0 for failed and 1 for success.
	 * @throws SQLException
	 * @throws Exception
	 */
	
	public int updateStandardScheduled(ScheduleBean bean)throws SQLException,Exception {
		
	 	log.info("invoking updateStandardScheduled(ScheduleBean bean) from com.iGrandee.Schedule.Schedule");
	 	
	 	String subjectscheduleid	= bean.getStandardscheduleid();
	 	String status				= bean.getStatus();
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement subschedule 	= null;
		
		try {
			
		
			subschedule			= connection.prepareStatement("update standardschedule set stdschedulestatus=? where standardscheduleid=?");
			
	
						
			subschedule.setString(1, status);
			subschedule.setString(2, subjectscheduleid);
			
			return_value += subschedule.executeUpdate();
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
		
	}
	
	
	finally {
		
		
		if(subschedule != null)
			subschedule.close();	
	
		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
	}	
	
	/**
	 * This method used for schedule the lessons through the java bean.
	 * @param bean
	 * @return 0 for failuire, greater than zero for success.
	 * @throws SQLException
	 * @throws Exception
	 */
	
	public int addLessons(ScheduleBean bean)throws SQLException,Exception {
		
	 	log.info("invoking addLessons from com.iGrandee.Schedule.Schedule");
	 	
	 	
	 	String  subjectsheduleid	= bean.getSubjectscheduletid();
	 	String lessons				= bean.getLessonid();
	 	String createdby			= bean.getUserid();

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement subschedule 	= null;
		PreparedStatement subid 		= null;
		ResultSet subrs		 			= null;
		long lessonid					= 0l;
		String curTime					= DateTime.showTime("MySqlWithTime");

		try {
			
			subid				= connection.prepareStatement("select max(lessonscheduleid) from lessonschedule");
			subrs				= subid.executeQuery();
			
			if(subrs.next())
				lessonid	 	= subrs.getLong(1);
			
			lessonid++;	
			
			subschedule			= connection.prepareStatement("insert into lessonschedule(lessonscheduleid, lessonid, subjectscheduleid, createdby, dateofcreation, status)values(?,?,?,?,?,?)");
			

						
			subschedule.setLong(1, lessonid);
			subschedule.setString(2, lessons);
			subschedule.setString(3, subjectsheduleid);
			subschedule.setString(4, createdby);
			subschedule.setString(5, curTime);
			subschedule.setString(6, "A");
			
			return_value += subschedule.executeUpdate();
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
		
	}


	finally {
		
		
		if(subrs != null)
			subrs.close();
		
		if(subid != null)
			subid.close();
		
		if(subschedule != null)
			subschedule.close();	

		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
	}



public int addLessons(String  subjectsheduleid,String lessons,String createdby)throws SQLException,Exception {
	
 	log.info("invoking addLessons from com.iGrandee.Schedule.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	
	PreparedStatement subschedule 	= null;
	PreparedStatement subid 		= null;
	ResultSet subrs		 			= null;
	long lessonid					= 0l;
	String curTime					= DateTime.showTime("MySqlWithTime");

	try {
		
		subid				= connection.prepareStatement("select max(lessonscheduleid) from lessonschedule");
		subrs				= subid.executeQuery();
		
		if(subrs.next())
			lessonid	 	= subrs.getLong(1);
		
		lessonid++;	
		
		subschedule			= connection.prepareStatement("insert into lessonschedule(lessonscheduleid, lessonid, subjectscheduleid, createdby, dateofcreation, status)values(?,?,?,?,?,?)");
		

					
		subschedule.setLong(1, lessonid);
		subschedule.setString(2, lessons);
		subschedule.setString(3, subjectsheduleid);
		subschedule.setString(4, createdby);
		subschedule.setString(5, curTime);
		subschedule.setString(6, "A");
		
		return_value += subschedule.executeUpdate();
		connection.commit();
}
catch(SQLException sqlexception) { 
	
	log.error(sqlexception);
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
	
}


finally {
	
	
	if(subrs != null)
		subrs.close();
	
	if(subid != null)
		subid.close();
	
	if(subschedule != null)
		subschedule.close();	

	
	if(connection != null)
		connection.close();
	
}
return return_value;
}



public int updateLessons(String lessonscheduleid,String status)throws SQLException,Exception {
	
 	log.info("invoking updateLessons from com.iGrandee.Schedule.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	PreparedStatement subschedule 	= null;

	try {
		
		subschedule			= connection.prepareStatement("update lessonschedule set status=? where lessonscheduleid=?");
		subschedule.setString(1, status);
		subschedule.setString(2, lessonscheduleid);
		return_value += subschedule.executeUpdate();
		connection.commit();
}
catch(SQLException sqlexception) { 
	
	log.error(sqlexception);
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
}


finally {
	
	
	if(subschedule != null)
		subschedule.close();	

	
	if(connection != null)
		connection.close();
	
}
return return_value;
}


	/**
	 * This method used to update the status of the lesson schedule through the java bean. It is accessed from 
	 * jap/Schedule/UpdateLesson.jsp
	 * @param bean
	 * @return 0 for failuire , greater than 0 for success.
	 * @throws SQLException
	 * @throws Exception
	 */
		
	public int updateLessons(ScheduleBean bean)throws SQLException,Exception {
		
	 	log.info("invoking updateLessons from com.iGrandee.Schedule.Schedule");
	 	
	 	String lessonscheduleid		= bean.getLessonscheduletid();
	 	String status				= bean.getStatus();
	 	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement subschedule 	= null;
	
		try {
			
			subschedule			= connection.prepareStatement("update lessonschedule set status=? where lessonscheduleid=?");
			subschedule.setString(1, status);
			subschedule.setString(2, lessonscheduleid);
			return_value += subschedule.executeUpdate();
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
	}
	
	
	finally {
		
		
		if(subschedule != null)
			subschedule.close();	
	
		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
	}

	public int addSections(ScheduleBean bean)throws SQLException,Exception {
		
	 	log.info("invoking addSections from com.iGrandee.Schedule.Schedule");
	 	
	 	String standardsheduleid	= bean.getStandardscheduleid();
	 	String sectionids			= bean.getSectionid();
	 	String createdby	 		= bean.getUserid();

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement subschedule 	= null;
		PreparedStatement subid 		= null;
		ResultSet subrs		 			= null;
		long subjectid					= 0l;
		String curTime					= DateTime.showTime("MySqlWithTime");

		try {
			

			subid				= connection.prepareStatement("select max(sectionscheduleid) from sectionschedule");
			subrs				= subid.executeQuery();
			
			if(subrs.next())
				subjectid	 	= subrs.getLong(1);
			
			subjectid++;	
			
			subschedule			= connection.prepareStatement("insert into sectionschedule(sectionscheduleid, standardscheduleid, sectionid, createdby, dateofcreation, sectionschedulestatus)values(?,?,?,?,?,?)");
			

						
			subschedule.setLong(1, subjectid);
			subschedule.setString(2, standardsheduleid);
			subschedule.setString(3, sectionids);
			subschedule.setString(4, createdby);
			subschedule.setString(5, curTime);
			subschedule.setString(6, "A");
			
			return_value += subschedule.executeUpdate();
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
	}


	finally {
		
		
		if(subrs != null)
			subrs.close();
		
		if(subid != null)
			subid.close();
		
		if(subschedule != null)
			subschedule.close();	

		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
	}


	public int addSections(String  standardsheduleid,String sectionids,String createdby)throws SQLException,Exception {
		
	 	log.info("invoking addSections from com.iGrandee.Schedule.Schedule");
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		PreparedStatement subschedule 	= null;
		PreparedStatement subid 		= null;
		ResultSet subrs		 			= null;
		long subjectid					= 0l;
		String curTime					= DateTime.showTime("MySqlWithTime");
	
		try {
			
	
			subid				= connection.prepareStatement("select max(sectionscheduleid) from sectionschedule");
			subrs				= subid.executeQuery();
			
			if(subrs.next())
				subjectid	 	= subrs.getLong(1);
			
			subjectid++;	
			
			subschedule			= connection.prepareStatement("insert into sectionschedule(sectionscheduleid, standardscheduleid, sectionid, createdby, dateofcreation, sectionschedulestatus)values(?,?,?,?,?,?)");
			
	
						
			subschedule.setLong(1, subjectid);
			subschedule.setString(2, standardsheduleid);
			subschedule.setString(3, sectionids);
			subschedule.setString(4, createdby);
			subschedule.setString(5, curTime);
			subschedule.setString(6, "A");
			
			return_value += subschedule.executeUpdate();
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
	}
	
	
	finally {
		
		
		if(subrs != null)
			subrs.close();
		
		if(subid != null)
			subid.close();
		
		if(subschedule != null)
			subschedule.close();	
	
		
		if(connection != null)
			connection.close();
		
	}
	return return_value;
	}


	public int updateSections(String subjectscheduleid,String status)throws SQLException,Exception {
		
	 	log.info("invoking updateSections from com.iGrandee.Schedule.Schedule");

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement subschedule 	= null;
		try {

			subschedule			= connection.prepareStatement("update sectionschedule set sectionschedulestatus=? where sectionscheduleid=?");
			subschedule.setString(1, status);
			subschedule.setString(2, subjectscheduleid);
			
			return_value += subschedule.executeUpdate();
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
		
	}
	finally {

		if(subschedule != null)
			subschedule.close();	
		
		if(connection != null)
			connection.close();
	}
	return return_value;
	}
	
	public int updateSections(ScheduleBean bean)throws SQLException,Exception {
		
	 	log.info("invoking updateSections from com.iGrandee.Schedule.Schedule");
	 	
	 	String subjectscheduleid	= bean.getSectionscheduletid();
	 	String status	 			= bean.getStatus();

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement subschedule 	= null;
		try {

			subschedule			= connection.prepareStatement("update sectionschedule set sectionschedulestatus=? where sectionscheduleid=?");
			subschedule.setString(1, status);
			subschedule.setString(2, subjectscheduleid);
			
			return_value += subschedule.executeUpdate();
			connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
		
	}
	finally {

		if(subschedule != null)
			subschedule.close();	
		
		if(connection != null)
			connection.close();
	}
	return return_value;
	}	









 CommonDataAccess common_data_object; 
 String insert_query;
 String select_query;
 int 	return_value;
 int[] returnvalue;
 Connection connection;
 DateTime datetime;

}
