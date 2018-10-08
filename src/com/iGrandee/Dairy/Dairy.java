package com.iGrandee.Dairy;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;


public class Dairy {
	
	static Logger log = Logger.getLogger(Dairy.class);


 public Dairy() {
	 
     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
     datetime				= new DateTime();
 }
 
 
 /*
  * This method is accessed from kycportal/jsp/Assignment/DairyView.jsp
 */
 
 public ArrayList loadDairy(String subjectscheduleid,String sectionscheduleid)
 {
	 	log.info("invoking loadDairy from com.iGrandee.Dairy.Dairy");

 		ArrayList periodsList = null;
 		try
 		{
 		
 			select_query  	= "SELECT studentdiaryid,subject,workdetails, date_format(dairysubmissiondate,'%d-%b-%Y')as dairysubmissiondate, date_format(dairydate,'%d-%b-%Y')as dairydate FROM studentdiary where subjectscheduleid='"+subjectscheduleid+"' and sectionscheduleid='"+sectionscheduleid+"' and studentdiarystatus='A'"; 
 			
 			periodsList 	= common_data_object.getListMap(select_query);
 			//System.out.println("select_query ===>"+select_query);

 		}
 		catch(Exception exception) { 
 			
 			log.error(exception);

 		}
 		return periodsList;
 } 
 
 /*
  * This method is accessed from kycportal/jsp/Assignment/DairyView.jsp
 */
 
 public ArrayList loadDairywitSubmitted(String subjectscheduleid,String sectionscheduleid)
 {
	 	log.info("invoking loadDairywitSubmitted from com.iGrandee.Dairy.Dairy");

 		ArrayList periodsList = null;
 		try
 		{
 			select_query  	= "SELECT studentdiaryid,subject,workdetails, date_format(dairysubmissiondate,'%d-%b-%Y')as dairysubmissiondate, date_format(dairydate,'%d-%b-%Y')as dairydate, (select count(studentdiaryreplyid) from diaryreply where studentdiaryid=a.studentdiaryid) as submitted FROM studentdiary a where a.subjectscheduleid='"+subjectscheduleid+"' and a.sectionscheduleid='"+sectionscheduleid+"' and a.studentdiarystatus='A'"; 
 			periodsList 	= common_data_object.getListMap(select_query);
 		}
 		catch(Exception exception) { 
 			
 			log.error(exception);

 		}
 		return periodsList;
 } 
 
 /*
  * This method is accessed from kycportal/jsp/Dairy/DairyView.jsp
 */
 public ArrayList loadDairySingle(String dairyid)
 {
	 	log.info("invoking loadDairySingle from com.iGrandee.Dairy.Dairy");

 		ArrayList periodsList = null;
 		try
 		{
 			select_query  	= "SELECT studentdiaryid,subject,workdetails,date_format(dairysubmissiondate,'%d-%b-%Y')as dairysubmissiondate,date_format(dairydate,'%d-%b-%Y')as dairydate,case when (select studentdiaryreplyid from diaryreply where studentdiaryid=a.studentdiaryid and dairyreplystatus='A' group by studentdiaryid) is null then 'Not Submitted' else 'Submitted' end as status FROM studentdiary a where a.studentdiaryid='"+dairyid+"'"; 
 			periodsList 	= common_data_object.getListMap(select_query); 
 		}
 		catch(Exception exception) { 
 			
 			log.error(exception);

 		}
 		return periodsList;
 }  
 
 
 
 /*
  * This method is accessed from kycportal/jsp/Student/Dairyview.jsp
 */
 public ArrayList loadDairyStudent(String sectionid,String studentid)
 {
	 	log.info("invoking loadDairyStudent from com.iGrandee.Dairy.Dairy");

 		ArrayList periodsList = null;
 		try
 		{
 			select_query  	= "select g.studentdiaryid,subjectname,c.subjectscheduleid,e.lessonscheduleid, g.subject,g.workdetails,lessonname, date_format(g.studentdiarycreateiondate,'%d-%b-%Y') as studentdiarycreateiondate, date_format(g.dairysubmissiondate,'%d-%b-%Y') as dairysubmissiondate, h.studentdiaryremarks,date_format(h.studentreplydate,'%d-%b-%Y') as studentreplydate, h.staffdiaryremarks, date_format(h.staffdiaryreplydate,'%d-%b-%Y') as staffdiaryreplydate, date_format(h.parentdate,'%d-%b-%Y') as parentdate, h.parentremarks, concat(k.firstname,' ',k.lastname) as staffname, e.lessonscheduleid, case when dairysubmissiondate>=curDate() then 'Available' else 'Not Available' end as status from sectionschedule a join standardschedule b on a.sectionscheduleid='"+sectionid+"' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join lessonschedule e on c.subjectscheduleid=e.subjectscheduleid and e.status='A' join lesson f on e.lessonid=f.lessonid and f.lessonstatus='A' join studentdiary g on g.lessonscheduleid=e.lessonscheduleid and g.studentdiarystatus='A' left outer join diaryreply h on g.studentdiaryid=h.studentdiaryid and h.studentid='"+studentid+"' left outer join login j on j.userid=g.createdby and j.loginstatus='A' left outer join personmaster k on j.personid=k.personid order by e.lessonscheduleid,g.dairysubmissiondate desc"; 
 			periodsList 	= common_data_object.getListMap(select_query); 
 		}
 		catch(Exception exception) { 
 			
 			log.error(exception);

 		}
 		return periodsList;
 }  
 
	 /*
	  * This method is accessed from kycportal/jsp/Student/Dairyview.jsp
	 */
	 public ArrayList loadDairyStudentLatest(String sectionid,String studentid)
	 {
		 	log.info("invoking loadDairyStudentLatest(String sectionid,String studentid) from com.iGrandee.Dairy.Dairy");
	
	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select g.studentdiaryid,g.subject,concat(d.subjectname,'-',d.subjectcode) as subjectname,date_format(g.studentdiarycreateiondate,'%d-%b-%Y') as creationdate  from sectionschedule a join  standardschedule b on a.sectionscheduleid='"+sectionid+"'  and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A'  and b.stdschedulestatus='A' join subjectschedule c  on b.standardscheduleid=c.standardscheduleid and c.status='A'  join subject d on c.subjectid=d.subjectid and d.subjectstatus='A'  join lessonschedule e on c.subjectscheduleid=e.subjectscheduleid  and e.status='A' join studentdiary g on g.lessonscheduleid=e.lessonscheduleid and a.sectionscheduleid=g.sectionscheduleid and g.studentdiarystatus='A' and curDate() <= g.dairysubmissiondate and g.studentdiaryid not in (select studentdiaryid from  diaryreply where studentid='"+studentid+"' and  g.studentdiaryid=studentdiaryid)  order by g.studentdiarycreateiondate desc"; 
	 			periodsList 	= common_data_object.getListMap(select_query); 
	 			
	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	
	 		}
	 		return periodsList;
	 }  
	 
		 /*
		  * This method is accessed from kycportal/jsp/Student/Dairyview.jsp
		 */
		 public ArrayList loadDairyStudentSubject(String sectionid,String studentid)
		 {
			 	log.info("invoking loadDairyStudentSubject(String sectionid,String studentid) from com.iGrandee.Dairy.Dairy");
		
		 		ArrayList periodsList = null;
		 		try
		 		{
		 			select_query  	= "select c.subjectscheduleid,g.studentdiaryid,g.subject,concat(d.subjectname,'-',d.subjectcode) as subjectname, date_format(g.studentdiarycreateiondate,'%d-%b-%Y') as creationdate, date_format(g.dairysubmissiondate,'%d-%b-%Y') as dairysubmissiondate, case when f.middlename='-' or f.middlename='' or f.middlename is null then concat(f.prefix,f.firstname,' ',f.lastname) else concat(f.firstname,' ',f.middlename,' ',f.lastname) end as staffname, e.userid,(select count(studentdiaryid) from studentdiary where a.sectionscheduleid=sectionscheduleid and g.createdby=createdby and g.subjectscheduleid=subjectscheduleid and curDate() = dairydate group by createdby,subjectscheduleid, sectionscheduleid) as diarycount, case when (select staffdiaryremarks from diaryreply where studentdiaryid=g.studentdiaryid and studentid='"+studentid+"') is null then 'Not Yet Evaluated.' else (select concat('Evaluated On : ',date_format(staffdiaryreplydate,'%d-%b-%Y')) from diaryreply where studentdiaryid=g.studentdiaryid and studentid='"+studentid+"') end as remarkdate from sectionschedule a join  standardschedule b on a.sectionscheduleid='"+sectionid+"' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A'  join studentdiary g on g.subjectscheduleid=c.subjectscheduleid and a.sectionscheduleid=g.sectionscheduleid and g.studentdiarystatus='A' and curDate() = g.dairydate join login e on g.createdby=e.userid and e.loginstatus='A' join personmaster f on e.personid=f.personid and f.status='A' order by c.subjectscheduleid,e.userid desc"; 
		 			periodsList 	= common_data_object.getListMap(select_query); 
		 		}
		 		catch(Exception exception) { 
		 			
		 			log.error(exception);
		
		 		}
		 		return periodsList;
		 } 
		 
		 /*
		  * This method is accessed from kycportal/jsp/Student/MonthDairyView.jsp
		 */
		 public ArrayList loadDairyStudentSubjectDay(String sectionid,String studentid,String date)
		 {
			 	log.info("invoking loadDairyStudentSubjectDay(String sectionid,String studentid) from com.iGrandee.Dairy.Dairy");
		
		 		ArrayList periodsList = null;
		 		try
		 		{
		 			select_query  	= "select c.subjectscheduleid,g.studentdiaryid,g.subject,concat(d.subjectname,'-',d.subjectcode) as subjectname, date_format(g.studentdiarycreateiondate,'%d-%b-%Y') as creationdate, date_format(g.dairysubmissiondate,'%d-%b-%Y') as dairysubmissiondate, case when f.middlename='-' or f.middlename='' or f.middlename is null then concat(f.prefix,f.firstname,' ',f.lastname) else concat(f.firstname,' ',f.middlename,' ',f.lastname) end as staffname, e.userid,(select count(studentdiaryid) from studentdiary where a.sectionscheduleid=sectionscheduleid and g.createdby=createdby and g.subjectscheduleid=subjectscheduleid and dairydate='"+date+"' group by createdby,subjectscheduleid, sectionscheduleid) as diarycount, case when (select staffdiaryremarks from diaryreply where studentdiaryid=g.studentdiaryid and studentid='"+studentid+"') is null then 'Not Given' else (select date_format(staffdiaryreplydate,'%d-%b-%Y') from diaryreply where studentdiaryid=g.studentdiaryid and studentid='"+studentid+"') end as remarkdate from sectionschedule a join  standardschedule b on a.sectionscheduleid='"+sectionid+"' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A'  join studentdiary g on g.subjectscheduleid=c.subjectscheduleid and a.sectionscheduleid=g.sectionscheduleid and g.studentdiarystatus='A' and g.dairydate='"+date+"' join login e on g.createdby=e.userid and e.loginstatus='A' join personmaster f on e.personid=f.personid and f.status='A' order by c.subjectscheduleid,e.userid desc"; 
		 			periodsList 	= common_data_object.getListMap(select_query); 
		 		}
		 		catch(Exception exception) { 
		 			
		 			log.error(exception);
		
		 		}
		 		return periodsList;
		 }  
		 
		 
		 /**
		  * This method is used to get the diart details for a month and for a section
		  * This method is accessed from kycportal/jsp/Student/DiaryMonth.jsp
		 */
		 public ArrayList loadDairyStudentSubject(String sectionid,String currentmonth,String currentyear)
		 {
			 	log.info("invoking loadDairyStudentSubject(String sectionid,String currentmonth,String currentyear) from com.iGrandee.Dairy.Dairy");
		
		 		ArrayList periodsList = null;
		 		try
		 		{
		 			select_query  	= "select g.dairydate as cdairydate,DAYNAME(g.dairydate) as dayname,date_format(g.dairydate,'%d-%b-%Y') as dairydate, count(g.studentdiaryid) as totaldiary from sectionschedule a join  standardschedule b on a.sectionscheduleid='"+sectionid+"' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join studentdiary g on g.subjectscheduleid=c.subjectscheduleid  and a.sectionscheduleid=g.sectionscheduleid and g.studentdiarystatus='A' and MONTHNAME(g.dairydate) = '"+currentmonth+"' and YEAR(g.dairydate)='"+currentyear+"' group by g.dairydate desc"; 
		 			periodsList 	= common_data_object.getListMap(select_query); 
		 		}
		 		catch(Exception exception) { 
		 			
		 			log.error(exception);
		
		 		}
		 		return periodsList;
		 }  		 
		 
		 
		 /**
		  * This method used to return the current,previous,next month and year for calendar
		  * This method is accessed from kycportal/jsp/Student/DiaryMonth.jsp
		 */
		 
		 public ArrayList loadMonthandYear(int index)
		 {
			 	log.info("invoking loadMonthandYear(int index) from com.iGrandee.Dairy.Dairy");
		
		 		ArrayList periodsList = null;
		 		try
		 		{
		 			select_query  	= "select MONTHNAME(DATE_ADD(curdate(),INTERVAL "+(index-1)+" MONTH)) as previousmonth,YEAR(DATE_ADD(curdate(),INTERVAL "+(index-1)+" MONTH)) as previousyear, MONTHNAME(DATE_ADD(curdate(),INTERVAL "+index+" MONTH)) as currentmonth, YEAR(DATE_ADD(curdate(),INTERVAL "+index+" MONTH)) as currentyear, MONTHNAME(DATE_ADD(curdate(),INTERVAL "+(index+1)+" MONTH))as nextmonth, YEAR(DATE_ADD(curdate(),INTERVAL "+(index+1)+" MONTH))as nextyear"; 
		 			periodsList 	= common_data_object.getListMap(select_query); 
		 		}
		 		catch(Exception exception) { 
		 			
		 			log.error(exception);
		
		 		}
		 		return periodsList;
		 }  		 
		 
	 
	 
	 /*
	  * This method is accessed from kycportal/jsp/Student/Dairyview.jsp
	 */
	 public ArrayList toDayDetails()
	 {
		 	log.info("invoking dayDetails() from com.iGrandee.Dairy.Dairy");
	
	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select DAYNAME(curDate()) as dayname,DATE_FORMAT(curDate(),'%d-%b-%Y') as date"; 
	 			periodsList 	= common_data_object.getListMap(select_query); 
	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	
	 		}
	 		return periodsList;
	 }  	 
	 
	 /*
	  * This method is accessed from kycportal/jsp/Student/Dairyexisting.jsp
	 */
	 public ArrayList loadDairyStudentExisting(String sectionid,String studentid)
	 {
		 	log.info("invoking loadDairyStudentExisting(String sectionid,String studentid) from com.iGrandee.Dairy.Dairy");
	
	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select g.studentdiaryid,g.subject,concat(d.subjectname,'-',d.subjectcode) as subjectname, date_format(g.studentdiarycreateiondate,'%d-%b-%Y') as creationdate,'Submitted' as status from sectionschedule a join  standardschedule b on a.sectionscheduleid='"+sectionid+"' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c  on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join lessonschedule e on c.subjectscheduleid=e.subjectscheduleid and e.status='A' join studentdiary g on g.lessonscheduleid=e.lessonscheduleid and g.studentdiarystatus='A' and a.sectionscheduleid=g.sectionscheduleid  and curDate() <= g.dairysubmissiondate  and g.studentdiaryid in (select studentdiaryid from diaryreply where studentid='"+studentid+"' and  g.studentdiaryid=studentdiaryid) union select g.studentdiaryid,g.subject,concat(d.subjectname,'-',d.subjectcode) as subjectname, date_format(g.studentdiarycreateiondate,'%d-%b-%Y') as creationdate,case when (select studentdiaryremarks from diaryreply where studentid='"+studentid+"' and  g.studentdiaryid=studentdiaryid) is null then '<font color=red>Not Submitted</font>' else 'Submitted' end as status from sectionschedule a join  standardschedule b on a.sectionscheduleid='"+sectionid+"' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c  on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join lessonschedule e on c.subjectscheduleid=e.subjectscheduleid and e.status='A' join studentdiary g on g.lessonscheduleid=e.lessonscheduleid and g.studentdiarystatus='A'  and curDate() > g.dairysubmissiondate and g.studentdiaryid order by creationdate desc";  
	 			periodsList 	= common_data_object.getListMap(select_query); 
	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	
	 		}
	 		return periodsList;
	 }  	 
 
 
	 /*
	  * This method is accessed from kycportal/jsp/Student/DairyProcess.jsp
	 */
	 public ArrayList loadDairySingleStudent(String dairyid,String studentid)
	 {
		 	log.info("invoking loadDairySingleStudent from com.iGrandee.Dairy.Dairy");
	
	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select g.studentdiaryid,concat(subjectname,'-',subjectcode) as subjectname,c.subjectscheduleid,g.subject,g.workdetails,date_format(g.studentdiarycreateiondate,'%d-%b-%Y %I:%i%p') as studentdiarycreateiondate, date_format(g.dairysubmissiondate,'%d-%b-%Y %I:%i%p') as dairysubmissiondate, h.studentdiaryremarks,date_format(h.studentreplydate,'%d-%b-%Y %I:%i%p') as studentreplydate, concat(k.firstname,' ',k.lastname) as staffname,h.staffdiaryremarks, date_format(h.staffdiaryreplydate,'%d-%b-%Y %r') as staffdiaryreplydate,date_format(h.parentdate,'%d-%b-%Y') as parentdate,h.parentremarks from studentdiary g join login j on g.studentdiaryid ='"+dairyid+"' and j.userid=g.createdby and j.loginstatus='A' join personmaster k on j.personid=k.personid join subjectschedule c  on g.subjectscheduleid=c.subjectscheduleid and c.status='A' join subject d  on c.subjectid=d.subjectid and d.subjectstatus='A'  left outer join diaryreply h  on g.studentdiaryid=h.studentdiaryid and h.studentid='"+studentid+"'"; 
	 			periodsList 	= common_data_object.getListMap(select_query); 
	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	 		}
	 		return periodsList;
	 }  
	 
	 /*
	  * This method is accessed from kycportal/jsp/Student/DairyProcess.jsp
	 */
	 public ArrayList loadDairySingleStudentSubject(String dairyid,String studentid)
	 {
		 	log.info("invoking loadDairySingleStudentSubject from com.iGrandee.Dairy.Dairy");
	
	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select g.studentdiaryid,concat(subjectname,'-',subjectcode) as subjectname,c.subjectscheduleid, g.subject,g.workdetails, date_format(g.studentdiarycreateiondate,'%d-%b-%Y') as studentdiarycreateiondate, date_format(g.dairysubmissiondate,'%d-%b-%Y') as dairysubmissiondate,staffdiaryremarks,date_format(h.staffdiaryreplydate,'%d-%b-%Y %I:%i %p') as staffdiaryreplydate , date_format(h.parentdate,'%d-%b-%Y %I:%i %p') as parentdate ,h.parentremarks , h.studentdiaryremarks,date_format(h.studentreplydate,'%d-%b-%Y %I:%i %p') as studentreplydate, case when k.middlename='-' or k.middlename='' or k.middlename is null then concat(k.prefix,k.firstname,' ',k.lastname) else concat(k.firstname,' ',k.middlename,' ',k.lastname) end as staffname,h.staffdiaryremarks, date_format(h.staffdiaryreplydate,'%d-%b-%Y  %I:%i %p') as staffdiaryreplydate, date_format(h.parentdate,'%d-%b-%Y %I:%i %p') as parentdate,h.parentremarks from studentdiary g join login j on g.studentdiaryid ='"+dairyid+"' and j.userid=g.createdby and j.loginstatus='A' join personmaster k on j.personid=k.personid join subjectschedule c on g.subjectscheduleid=c.subjectscheduleid and c.status='A' join subject d  on c.subjectid=d.subjectid and d.subjectstatus='A'  left outer join diaryreply h on g.studentdiaryid=h.studentdiaryid and h.studentid='"+studentid+"'"; 
	 			periodsList 	= common_data_object.getListMap(select_query); 
	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	 		}
	 		return periodsList;
	 }  	 
	 
 
	 /*
	  * This method is accessed from kycportal/jsp/Dairy/TrackDairy.jsp
	 */
	 public ArrayList loadDairySubmitted(String dairyid)
	 {
		 	log.info("invoking loadDairySubmitted from com.iGrandee.Dairy.Dairy");
	
	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select g.studentdiaryid,c.studentallocationid as studentid,h.staffdiaryremarks, h.parentremarks,h.studentdiaryremarks,date_format(h.studentreplydate,'%d-%b-%Y %I:%i%p') as studentreplydate, date_format(h.staffdiaryreplydate,'%d-%b-%Y %I:%i%p') as staffdiaryreplydate, date_format(h.parentdate,'%d-%b-%Y %I:%i%p') as parentdate, concat(e.firstname,' ',e.lastname) as studentname from studentdiary g join login j on g.studentdiaryid ='"+dairyid+"' and j.userid=g.createdby and j.loginstatus='A' join  studentallocation c on g.sectionscheduleid=c.sectionscheduleid and  c.studentallocationstatus='A' join  candidateregister d on c.candidateregisterid=d.candidateregisterid join  personmaster e on d.personid=e.personid and d.candidateregisterstatus='A' left outer join diaryreply h  on g.studentdiaryid=h.studentdiaryid and c.studentallocationid=h.studentid"; 
	 			periodsList 	= common_data_object.getListMap(select_query); 
	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	 		}
	 		return periodsList;
	 }   
	 
	 /*
	  * This method is accessed from kycportal/jsp/Dairy/TrackDairyQuick.jsp
	 */
	 public ArrayList loadDairyOnlySubmitted(String dairyid)
	 {
		 	log.info("invoking loadDairyOnlySubmitted from com.iGrandee.Dairy.Dairy");
	
	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select g.studentdiaryid,c.studentallocationid as studentid,h.studentdiaryreplyid,h.staffdiaryremarks, h.parentremarks,h.studentdiaryremarks,date_format(h.studentreplydate,'%d-%b-%Y %I:%i%p') as studentreplydate, date_format(h.staffdiaryreplydate,'%d-%b-%Y %I:%i%p') as staffdiaryreplydate, date_format(h.parentdate,'%d-%b-%Y %I:%i%p') as parentdate, concat(e.firstname,' ',e.lastname) as studentname from studentdiary g join login j on g.studentdiaryid ='"+dairyid+"' and j.userid=g.createdby and j.loginstatus='A' join  studentallocation c on g.sectionscheduleid=c.sectionscheduleid and  c.studentallocationstatus='A' join  candidateregister d on c.candidateregisterid=d.candidateregisterid join  personmaster e on d.personid=e.personid and d.candidateregisterstatus='A' join diaryreply h  on g.studentdiaryid=h.studentdiaryid and c.studentallocationid=h.studentid"; 
	 			periodsList 	= common_data_object.getListMap(select_query); 
	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	 		}
	 		return periodsList;
	 }   	
	 
	 
	 /**
	  * This method used to insert the diary details through the DairyBean
	  * @param bean
	  * @return greater than 0 for success and 0 for failure
	  * @throws SQLException
	  * @throws Exception
	  */
	 
	 
	 public int dairyInsert(DairyBean bean)throws SQLException,Exception {
		 
		 	String subject				= bean.getSubject();
		 	String description			= bean.getWorkdetails();
		 	String ipaddress			= bean.getIpaddress();
		 	String userid				= bean.getCreatedby();
		 	String subjectscheduleid	= bean.getSubjectscheduleid();
		 	String sectionsceheduleid	= bean.getSectionscheduleid();
		 	String dairydate			= bean.getDairydate();
		 	String enddate				= bean.getDairysubmissiondate();
			
		 	log.info("invoking dairyInsert from com.iGrandee.Dairy.Dairy");

			connection 						= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			PreparedStatement workstate 	= null;
			PreparedStatement idstate 		= null;
			ResultSet idrs 					= null;
			long questionid					= 0l;

			try {
				
			
				workstate		= connection.prepareStatement("insert into studentdiary(studentdiaryid, subject, workdetails, subjectscheduleid, ipaddress, createdby, studentdiarystatus, sectionscheduleid, dairysubmissiondate, dairydate)values(?,?,?,?,?,?,?,?,?,?)");
				idstate			= connection.prepareStatement("select max(studentdiaryid) from studentdiary");
				idrs			= idstate.executeQuery();
				
				if(idrs.next())
					questionid	= idrs.getLong(1);
				
				questionid++;
											
				workstate.setLong(1,questionid);
				workstate.setString(2, subject);
				workstate.setString(3,description);
				workstate.setString(4,subjectscheduleid);
				workstate.setString(5,ipaddress);
				workstate.setString(6,userid);
				workstate.setString(7,"A");
				workstate.setString(8,sectionsceheduleid);
				workstate.setString(9,datetime.getMySQLFormatHifen(enddate).toString());
				workstate.setString(10,datetime.getMySQLFormatHifen(dairydate).toString());


				return_value	= workstate.executeUpdate();
						
				connection.commit();

			}
			catch(SQLException sqlexception) { 
				
				if(connection != null)
					connection.rollback();
				return_value = 0;
				
				log.error(sqlexception);
				
			}
			finally {
				
			if(workstate != null)
				workstate.close();
			
			if(idrs != null)
				idrs.close();
			
			if(idstate != null)
				idstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		return return_value;
		}	 
	 
	 
  
public int dairyInsert(String subject,String description,String ipaddress,String userid,String subjectscheduleid,String sectionsceheduleid,String dairydate,String enddate)throws SQLException,Exception {
	
 	log.info("invoking dairyInsert from com.iGrandee.Dairy.Dairy");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	PreparedStatement workstate 	= null;
	PreparedStatement idstate 		= null;
	ResultSet idrs 					= null;
	long questionid					= 0l;

	try {
		
	
		workstate		= connection.prepareStatement("insert into studentdiary(studentdiaryid, subject, workdetails, subjectscheduleid, ipaddress, createdby, studentdiarystatus, sectionscheduleid, dairysubmissiondate, dairydate)values(?,?,?,?,?,?,?,?,?,?)");
		idstate			= connection.prepareStatement("select max(studentdiaryid) from studentdiary");
		idrs			= idstate.executeQuery();
		
		if(idrs.next())
			questionid	= idrs.getLong(1);
		
		questionid++;
									
		workstate.setLong(1,questionid);
		workstate.setString(2, subject);
		workstate.setString(3,description);
		workstate.setString(4,subjectscheduleid);
		workstate.setString(5,ipaddress);
		workstate.setString(6,userid);
		workstate.setString(7,"A");
		workstate.setString(8,sectionsceheduleid);
		workstate.setString(9,datetime.getMySQLFormatHifen(enddate).toString());
		workstate.setString(10,datetime.getMySQLFormatHifen(dairydate).toString());


		return_value	= workstate.executeUpdate();
				
		connection.commit();

	}
	catch(SQLException sqlexception) { 
		
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
		log.error(sqlexception);
		
	}
	finally {
		
	if(workstate != null)
		workstate.close();
	
	if(idrs != null)
		idrs.close();
	
	if(idstate != null)
		idstate.close();
	
	ConnectionManager.closeConnection(connection);
}
return return_value;
}

/**
 * This method is accessed from kycportal/jsp/Diary/DairySubmit.jsp
 * Diary details send by sms    in Staff login  - prasanth
 @param  secScheduleId  that can be used to get student names and mobilenos from personmaster 
 *
 @return the ArrayList by  result can be send to mobile phones
*/
public ArrayList DiarySmsforstudentParent(String secScheduleId,String instituteid)
{
	log.info("invoking displayAllocatedDetails To list allocated students based on sectionscheduleid after allocating section");
	ArrayList valueList = null;
	String select_query = "";
	try
	{
		//select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,i.mobilenumber,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on c.instituteid='"+instituteid+"' and c.sessionstatus='A'  join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' order by rollgenerationstatus,rollno,applicantname";
		select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,pa.smscontactno,g.studentallocationid, f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation, a.applicantname as applicationname,a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on c.instituteid='"+instituteid+"' and c.sessionstatus='A'  join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' join personaddress pa on pa.personid=i.personid and pa.peraddstatus='A' order by applicantname;";

		valueList=common_data_object.getListMap(select_query);
		//System.out.println("student details "+select_query );
	}
	catch(Exception e)
	{
		log.error(e);
	}
	return valueList;
}

	/**
	 * This method is used to update the individual diary details through DiayBean
	 * @param bean
	 * @return 0 for failure and greater than 0 for success.
	 * @throws SQLException
	 * @throws Exception
	 */

	public int dairyUpdate(DairyBean bean)throws SQLException,Exception {
		
		
		String subject		= bean.getSubject();
		String description	= bean.getWorkdetails();
		String dairyid		= bean.getStudentdiaryid();
		String dairydate	= bean.getDairydate();
		String enddate		= bean.getDairysubmissiondate();
		
	 	log.info("invoking dairyUpdate from com.iGrandee.Dairy.Dairy");
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
	
		try {
			
			workstate		= connection.prepareStatement("update studentdiary set subject=?, workdetails=?,dairysubmissiondate=?,dairydate=? where studentdiaryid=?");
			workstate.setString(1, subject);
			workstate.setString(2,description);
			workstate.setString(3,datetime.getMySQLFormatHifen(enddate).toString());
			workstate.setString(4,datetime.getMySQLFormatHifen(dairydate).toString());
			workstate.setString(5,dairyid);
	
			return_value	= workstate.executeUpdate();
			connection.commit();
		}
		catch(SQLException sqlexception) { 
			
			log.error(sqlexception);
			if(connection != null)
				connection.rollback();
			return_value = 0;
		
			
		}
		finally {
			
		if(workstate != null)
			workstate.close();
		
		ConnectionManager.closeConnection(connection);
	}
	return return_value;
	}


public int dairyUpdate(String subject,String description,String dairyid,String dairydate,String enddate)throws SQLException,Exception {
	
 	log.info("invoking dairyUpdate from com.iGrandee.Dairy.Dairy");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	PreparedStatement workstate 	= null;

	try {
		
		workstate		= connection.prepareStatement("update studentdiary set subject=?, workdetails=?,dairysubmissiondate=?,dairydate=? where studentdiaryid=?");
		workstate.setString(1, subject);
		workstate.setString(2,description);
		workstate.setString(3,datetime.getMySQLFormatHifen(enddate).toString());
		workstate.setString(4,datetime.getMySQLFormatHifen(dairydate).toString());
		workstate.setString(5,dairyid);

		return_value	= workstate.executeUpdate();
		connection.commit();
	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
	
		
	}
	finally {
		
	if(workstate != null)
		workstate.close();
	
	ConnectionManager.closeConnection(connection);
}
return return_value;
}

	/**
	 * This method used to delete the diary details through DairyBean
	 * @param bean
	 * @return 0 for failure and greater than 0 for success , 1000 for when student(s) submitted diary. 
	 * @throws SQLException
	 * @throws Exception
	 */

	public int dairyDelete(DairyBean bean)throws SQLException,Exception {
		
		String dairyid	=	bean.getStudentdiaryid();
		log.info("invoking dairyDelete from com.iGrandee.Dairy.Dairy");
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		PreparedStatement checkstate 	= null;
		ResultSet checkrs 				= null;
		
	
		try {
	
			
			
			
			checkstate		= connection.prepareStatement("select studentdiaryid from diaryreply where studentdiaryid=?");
			checkstate.setString(1,dairyid);
			checkrs			= checkstate.executeQuery();
			
			if(!checkrs.next()){
			
				workstate		= connection.prepareStatement("update studentdiary set studentdiarystatus=? where studentdiaryid=?");
				workstate.setString(2, dairyid);
				workstate.setString(1,"D");
				return_value	= workstate.executeUpdate();
			}
			else
				return_value	= 1000;
			connection.commit();
		}
		catch(SQLException sqlexception) { 
			
			log.error(sqlexception);
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			
		}
		finally {
			
		if(workstate != null)
			workstate.close();
		
		ConnectionManager.closeConnection(connection);
	}
	return return_value;
	}



	public int dairyDelete(String dairyid)throws SQLException,Exception {
		
	 	log.info("invoking dairyDelete from com.iGrandee.Dairy.Dairy");
	
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		PreparedStatement checkstate 	= null;
		ResultSet checkrs 				= null;
		
	
		try {
	
			
			
			
			checkstate		= connection.prepareStatement("select studentdiaryid from diaryreply where studentdiaryid=?");
			checkstate.setString(1,dairyid);
			checkrs			= checkstate.executeQuery();
			
			if(!checkrs.next()){
			
				workstate		= connection.prepareStatement("update studentdiary set studentdiarystatus=? where studentdiaryid=?");
				workstate.setString(2, dairyid);
				workstate.setString(1,"D");
				return_value	= workstate.executeUpdate();
			}
			else
				return_value	= 1000;
			connection.commit();
		}
		catch(SQLException sqlexception) { 
			
			log.error(sqlexception);
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			
		}
		finally {
			
		if(workstate != null)
			workstate.close();
		
		ConnectionManager.closeConnection(connection);
	}
	return return_value;
	}

	/**
	 * This method is used to insert and update the diary reply remarks through the DairyReplyBean
	 * @param bean
	 * @return 0 for failure greater than 0 for success.
	 * @throws SQLException
	 */

	public int insertDairyStudent(DairyReplyBean bean)throws SQLException
	{
		
		String dairyid		= bean.getStudentdiaryid();
		String studentid	= bean.getStudentid(); 
		String ipaddress	= bean.getStudentreplyipaddress();
		String remarks		= bean.getStudentdiaryremarks();
		
	 	log.info("invoking insertDairyStudent from com.iGrandee.Dairy.Dairy");
	
		PreparedStatement assignstmt 	= null;
	
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
	
	
	
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
	
		long  assignmentracktid			= 0l;
	
		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");
	
			sqlquery 		= "select studentdiaryreplyid from diaryreply where studentid=? and studentdiaryid=?";
	
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,studentid);
			checkstmt.setString(2,dairyid);
	
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				assignmentracktid	= checkrs.getLong(1);
	
	
				sqlquery		= "update diaryreply set studentdiaryremarks=?,studentreplydate=? where studentdiaryreplyid=?";
				assignstmt		= connection.prepareStatement(sqlquery);
				assignstmt.setString(1,remarks);
				assignstmt.setString(2,temptime);
				assignstmt.setLong(3,assignmentracktid);
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
			else{
	
				sqlquery	= "select max(studentdiaryreplyid) from diaryreply";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					assignmentracktid	= idrs.getLong(1);
				}
				assignmentracktid ++;
	
				sqlquery			= "insert into diaryreply(studentdiaryreplyid, studentdiaryid, studentid, studentdiaryremarks, studentreplydate, studentreplyipaddress,dairyreplystatus,replythrough) values(?,?,?,?,?,?,?,?)";
				assignstmt			= connection.prepareStatement(sqlquery);
	
				assignstmt.setLong(1,assignmentracktid);
				assignstmt.setString(2,dairyid);
				assignstmt.setString(3,studentid);
				assignstmt.setString(4,remarks);
				assignstmt.setString(5,temptime);
				assignstmt.setString(6,ipaddress);
				assignstmt.setString(7,"A");
				assignstmt.setString(8,"Web");
				///System.out.println("insertDairyStudent>>>"+assignstmt);
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
	
			connection.commit();
		}
		catch(Exception exception) {
			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
		}
		finally{
	
			if(checkrs != null)
				checkrs.close();
	
			if(checkstmt != null)
				checkstmt.close();
	
			if(idrs != null)
				idrs.close();
	
			if(idstmt != null)
				idstmt.close();
	
			if(assignstmt != null)
				assignstmt.close();
	
	
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	
	}
	
	

	public int insertDairyStudent(String dairyid,String studentid,String ipaddress,String remarks)throws SQLException
	{
	
	 	log.info("invoking insertDairyStudent from com.iGrandee.Dairy.Dairy");
	
		PreparedStatement assignstmt 	= null;
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
	
	
	
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
	
		long  assignmentracktid			= 0l;
	
		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");
	
			sqlquery 		= "select studentdiaryreplyid from diaryreply where studentid=? and studentdiaryid=?";
	
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,studentid);
			checkstmt.setString(2,dairyid);
	
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				assignmentracktid	= checkrs.getLong(1);
	
	
				sqlquery		= "update diaryreply set studentdiaryremarks=?,studentreplydate=? where studentdiaryreplyid=?";
				assignstmt		= connection.prepareStatement(sqlquery);
				assignstmt.setString(1,remarks);
				assignstmt.setString(2,temptime);
				assignstmt.setLong(3,assignmentracktid);
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
			else{
	
				sqlquery	= "select max(studentdiaryreplyid) from diaryreply";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					assignmentracktid	= idrs.getLong(1);
				}
				assignmentracktid ++;
	
				sqlquery			= "insert into diaryreply(studentdiaryreplyid, studentdiaryid, studentid, studentdiaryremarks, studentreplydate, studentreplyipaddress,dairyreplystatus,replythrough) values(?,?,?,?,?,?,?,?)";
				assignstmt			= connection.prepareStatement(sqlquery);
	
				assignstmt.setLong(1,assignmentracktid);
				assignstmt.setString(2,dairyid);
				assignstmt.setString(3,studentid);
				assignstmt.setString(4,remarks);
				assignstmt.setString(5,temptime);
				assignstmt.setString(6,ipaddress);
				assignstmt.setString(7,"A");
				assignstmt.setString(8,"Web");
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
	
			connection.commit();
		}
		catch(Exception exception) {
			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
		}
		finally{
	
			if(checkrs != null)
				checkrs.close();
	
			if(checkstmt != null)
				checkstmt.close();
	
			if(idrs != null)
				idrs.close();
	
			if(idstmt != null)
				idstmt.close();
	
			if(assignstmt != null)
				assignstmt.close();
	
	
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	
	}

	/**
	 * This method is used to update the staff remarks through the DairyReplyBean
	 * @param bean
	 * @return 0 for failure and greater than 0 for success.
	 * @throws SQLException
	 */

	public int insertDairyFacultyRemarks(DairyReplyBean bean)throws SQLException
	{
		
		String dairyid[]	= bean.getStudentdiaryreplyids();
		String[] remarks	= bean.getStaffdiaryremarkss();
	 	log.info("invoking insertDairyFacultyRemarks from com.iGrandee.Dairy.Dairy");
		PreparedStatement assignstmt 	= null;
		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");
	
			sqlquery		= "update diaryreply set staffdiaryremarks=?, staffdiaryreplydate=? where studentdiaryreplyid=?";
			assignstmt		= connection.prepareStatement(sqlquery);
	
			
			if(dairyid != null && dairyid.length > 0){
				for(int y=0;y<dairyid.length;y++){
					
					if(remarks[y] != null && !remarks[y].equals("")){
						
						assignstmt.setString(1,remarks[y]);
						assignstmt.setString(2,temptime);
						assignstmt.setString(3,dairyid[y]);
						assignstmt.addBatch();
						
					}
				}
			}
			
			int temp[]	= assignstmt.executeBatch();
			
			if(temp != null && temp.length>0)
				for(int t=0;t<temp.length;t++)
					returnvalue 		+= temp[t];
			
			connection.commit();
		}
		catch(Exception exception) {
			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
		}
		finally{
	
			if(assignstmt != null)
				assignstmt.close();
	
	
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	
	}


	public int insertDairyFacultyRemarks(String dairyid[],String[] studentid,String[] remarks)throws SQLException
	{
	 	log.info("invoking insertDairyFacultyRemarks from com.iGrandee.Dairy.Dairy");
		PreparedStatement assignstmt 	= null;
		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");
	
			sqlquery		= "update diaryreply set staffdiaryremarks=?, staffdiaryreplydate=? where studentdiaryreplyid=?";
			assignstmt		= connection.prepareStatement(sqlquery);
	
			
			if(studentid != null && studentid.length > 0){
				for(int y=0;y<studentid.length;y++){
					
					if(remarks[y] != null && !remarks[y].equals("")){
						
						assignstmt.setString(1,remarks[y]);
						assignstmt.setString(2,temptime);
						assignstmt.setString(3,dairyid[y]);
						assignstmt.addBatch();
						
					}
				}
			}
			
			int temp[]	= assignstmt.executeBatch();
			
			if(temp != null && temp.length>0)
				for(int t=0;t<temp.length;t++)
					returnvalue 		+= temp[t];
			
			connection.commit();
		}
		catch(Exception exception) {
			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
		}
		finally{
	
			if(assignstmt != null)
				assignstmt.close();
	
	
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	
	}

	public int insertDairyFaculty(String dairyid,String studentid,String remarks)throws SQLException
	{
	
	 	log.info("invoking insertDairyFaculty from com.iGrandee.Dairy.Dairy");
	
		PreparedStatement assignstmt 	= null;
	
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
	
	
	
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
	
		long  assignmentracktid			= 0l;
	
		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");
	
			sqlquery 		= "select studentdiaryreplyid from diaryreply where studentid=? and studentdiaryid=?";
	
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,studentid);
			checkstmt.setString(2,dairyid);
	
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				assignmentracktid	= checkrs.getLong(1);
	
	
				sqlquery		= "update diaryreply set staffdiaryremarks=?, staffdiaryreplydate=? where studentdiaryreplyid=?";
				assignstmt		= connection.prepareStatement(sqlquery);
				assignstmt.setString(1,remarks);
				assignstmt.setString(2,temptime);
				assignstmt.setLong(3,assignmentracktid);
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
			else{
	
				sqlquery	= "select max(studentdiaryreplyid) from diaryreply";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					assignmentracktid	= idrs.getLong(1);
				}
				assignmentracktid ++;
	
				sqlquery			= "insert into diaryreply(studentdiaryreplyid, studentdiaryid, studentid, staffdiaryremarks, staffdiaryreplydate, dairyreplystatus) values(?,?,?,?,?,?)";
				assignstmt			= connection.prepareStatement(sqlquery);
	
				assignstmt.setLong(1,assignmentracktid);
				assignstmt.setString(2,dairyid);
				assignstmt.setString(3,studentid);
				assignstmt.setString(4,remarks);
				assignstmt.setString(5,temptime);
				assignstmt.setString(6,"A");
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
	
			connection.commit();
		}
		catch(Exception exception) {
			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
		}
		finally{
	
			if(checkrs != null)
				checkrs.close();
	
			if(checkstmt != null)
				checkstmt.close();
	
			if(idrs != null)
				idrs.close();
	
			if(idstmt != null)
				idstmt.close();
	
			if(assignstmt != null)
				assignstmt.close();
	
	
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	
	}
	
	
	/**
	 * This method is used to insert or update the diary remarks through DairyReplyBean
	 * @param bean
	 * @return 0 for failure, greater than 0 for success
	 * @throws SQLException
	 */
	public int insertDairyFaculty(DairyReplyBean bean)throws SQLException
	{
		
		String dairyid		= bean.getStudentdiaryid();
		String studentid	= bean.getStudentid();
		String remarks		= bean.getStaffdiaryremarks();
	
	 	log.info("invoking insertDairyFaculty from com.iGrandee.Dairy.Dairy");
	
		PreparedStatement assignstmt 	= null;
	
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
	
	
	
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
	
		long  assignmentracktid			= 0l;
	
		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");
	
			sqlquery 		= "select studentdiaryreplyid from diaryreply where studentid=? and studentdiaryid=?";
	
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,studentid);
			checkstmt.setString(2,dairyid);
	
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				assignmentracktid	= checkrs.getLong(1);
	
	
				sqlquery		= "update diaryreply set staffdiaryremarks=?, staffdiaryreplydate=? where studentdiaryreplyid=?";
				assignstmt		= connection.prepareStatement(sqlquery);
				assignstmt.setString(1,remarks);
				assignstmt.setString(2,temptime);
				assignstmt.setLong(3,assignmentracktid);
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
			else{
	
				sqlquery	= "select max(studentdiaryreplyid) from diaryreply";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					assignmentracktid	= idrs.getLong(1);
				}
				assignmentracktid ++;
	
				sqlquery			= "insert into diaryreply(studentdiaryreplyid, studentdiaryid, studentid, staffdiaryremarks, staffdiaryreplydate, dairyreplystatus) values(?,?,?,?,?,?)";
				assignstmt			= connection.prepareStatement(sqlquery);
	
				assignstmt.setLong(1,assignmentracktid);
				assignstmt.setString(2,dairyid);
				assignstmt.setString(3,studentid);
				assignstmt.setString(4,remarks);
				assignstmt.setString(5,temptime);
				assignstmt.setString(6,"A");
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
	
			connection.commit();
		}
		catch(Exception exception) {
			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
		}
		finally{
	
			if(checkrs != null)
				checkrs.close();
	
			if(checkstmt != null)
				checkstmt.close();
	
			if(idrs != null)
				idrs.close();
	
			if(idstmt != null)
				idstmt.close();
	
			if(assignstmt != null)
				assignstmt.close();
	
	
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	
	}



	public int insertDairyParent(String dairyid,String studentid,String remarks)throws SQLException
	{
	 	log.info("invoking insertDairyParent from com.iGrandee.Dairy.Dairy");
	
	
		PreparedStatement assignstmt 	= null;
	
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
	
	
	
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
	
		long  assignmentracktid			= 0l;
	
		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");
	
			sqlquery 		= "select studentdiaryreplyid from diaryreply where studentid=? and studentdiaryid=?";
	
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,studentid);
			checkstmt.setString(2,dairyid);
	
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				assignmentracktid	= checkrs.getLong(1);
	
	
				sqlquery		= "update diaryreply set parentremarks=?, parentdate=? where studentdiaryreplyid=?";
				assignstmt		= connection.prepareStatement(sqlquery);
				assignstmt.setString(1,remarks);
				assignstmt.setString(2,temptime);
				assignstmt.setLong(3,assignmentracktid);
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
			else{
	
				sqlquery	= "select max(studentdiaryreplyid) from diaryreply";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					assignmentracktid	= idrs.getLong(1);
				}
				assignmentracktid ++;
	
				sqlquery			= "insert into diaryreply(studentdiaryreplyid, studentdiaryid, studentid, parentremarks, parentdate, dairyreplystatus) values(?,?,?,?,?,?)";
				assignstmt			= connection.prepareStatement(sqlquery);
	
				assignstmt.setLong(1,assignmentracktid);
				assignstmt.setString(2,dairyid);
				assignstmt.setString(3,studentid);
				assignstmt.setString(4,remarks);
				assignstmt.setString(5,temptime);
				assignstmt.setString(6,"A");
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
	
			connection.commit();
		}
		catch(Exception exception) {
			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
		}
		finally{
	
			if(checkrs != null)
				checkrs.close();
	
			if(checkstmt != null)
				checkstmt.close();
	
			if(idrs != null)
				idrs.close();
	
			if(idstmt != null)
				idstmt.close();
	
			if(assignstmt != null)
				assignstmt.close();
	
	
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	
	}

	/**
	 * This method used to insert or update the parent remarks through the DairyReplyBean
	 * @param bean
	 * @return 0 for failure and greater than 0 for success.
	 * @throws SQLException
	 */
	
	public int insertDairyParent(DairyReplyBean bean)throws SQLException
	{
		
		
		String dairyid		= bean.getStudentdiaryid();
		String studentid	= bean.getStudentid();
		String remarks		= bean.getParentremarks();
		
	 	log.info("invoking insertDairyParent(bean) from com.iGrandee.Dairy.Dairy");
	
		PreparedStatement assignstmt 	= null;
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
		long  assignmentracktid			= 0l;
		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");
	
			sqlquery 		= "select studentdiaryreplyid from diaryreply where studentid=? and studentdiaryid=?";
	
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,studentid);
			checkstmt.setString(2,dairyid);
	
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				assignmentracktid	= checkrs.getLong(1);
	
	
				sqlquery		= "update diaryreply set parentremarks=?, parentdate=? where studentdiaryreplyid=?";
				assignstmt		= connection.prepareStatement(sqlquery);
				assignstmt.setString(1,remarks);
				assignstmt.setString(2,temptime);
				assignstmt.setLong(3,assignmentracktid);
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
			else{
	
				sqlquery	= "select max(studentdiaryreplyid) from diaryreply";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					assignmentracktid	= idrs.getLong(1);
				}
				assignmentracktid ++;
	
				sqlquery			= "insert into diaryreply(studentdiaryreplyid, studentdiaryid, studentid, parentremarks, parentdate, dairyreplystatus) values(?,?,?,?,?,?)";
				assignstmt			= connection.prepareStatement(sqlquery);
	
				assignstmt.setLong(1,assignmentracktid);
				assignstmt.setString(2,dairyid);
				assignstmt.setString(3,studentid);
				assignstmt.setString(4,remarks);
				assignstmt.setString(5,temptime);
				assignstmt.setString(6,"A");
	
				returnvalue 		+= assignstmt.executeUpdate();
	
			}
	
			connection.commit();
		}
		catch(Exception exception) {
			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
		}
		finally{
	
			if(checkrs != null)
				checkrs.close();
	
			if(checkstmt != null)
				checkstmt.close();
	
			if(idrs != null)
				idrs.close();
	
			if(idstmt != null)
				idstmt.close();
	
			if(assignstmt != null)
				assignstmt.close();
	
	
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	
	}




 CommonDataAccess common_data_object; 
 String insert_query;
 String select_query;
 int 	return_value;
 int[] returnvalue;
 Connection connection;
 DateTime datetime;

}
