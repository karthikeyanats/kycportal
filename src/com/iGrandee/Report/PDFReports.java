package com.iGrandee.Report;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;


public class PDFReports {
	
	static Logger log = Logger.getLogger(Reports.class);
	
	 public PDFReports() {
		 
	     common_data_object 	= new CommonDataAccess();
	     insert_query 			= null;
	     select_query 			= null;
	     return_value 			= 0;
	     connection				= null;
	     datetime				= new DateTime();
	 }
  

	 /*
	  * This method is accessed from kycportal/jsp/Reports/Reportanalysis.jsp
	  */
	 public ArrayList examDetails(String sessionid)
	 {
		 	log.info("invoking examDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select distinct a.examnameid,a.examname from examname a join examallotment b on a.sessionid='"+sessionid+"' and a.examnamestatus='A' and a.examnameid=b.examnameid and b.examallotmentstatus='A' join examschedule c on b.examallotmentid=c.examallotmentid and c.examschedulestatus='A' and c.markpublishstatus='A'";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	 }
	 
	 
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportStandard.jsp
	 */
	 
	public ArrayList standardPassDetails(String examnameid)
	{
	 		log.info("invoking standardPassDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select case when h.groupname is null then standardname else concat(standardname,' ',groupname) end as standardname,d.standardscheduleid, g.studentallocationid, (select count(subjectscheduleid) from subjectschedule where standardscheduleid=d.standardscheduleid and status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and c1.examschedulestatus='A' and c1.markpublishstatus='A' and a1.markstatus='A'  and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and b1.theoryexternalmin<=a1.marktaken group by a1.studentallocationid)as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.examallotmentid=b.examallotmentid and b.examschedulestatus='A' and b.markpublishstatus='A' join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' left outer join standardgroup h on d.groupid=h.groupid group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,d.standardscheduleid";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportSection.jsp
	 */
	 
	public ArrayList sectionPassDetails(String examnameid,String standardid)
	{
	 		log.info("invoking sectionPassDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select sectionname,f.sectionscheduleid,g.studentallocationid, (select count(subjectscheduleid) from subjectschedule where standardscheduleid=d.standardscheduleid and status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and c1.examschedulestatus='A' and c1.markpublishstatus='A' and a1.markstatus='A'  and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and b1.theoryexternalmin<=a1.marktaken group by a1.studentallocationid) as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.standardscheduleid='"+standardid+"' and a.examallotmentid=b.examallotmentid and b.examschedulestatus='A' and b.markpublishstatus='A' join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join section e on f.sectionid=e.sectionid and e.status='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,f.sectionscheduleid";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportSectionSubject.jsp
	 */
	 
	public ArrayList sectionSubjectPassDetails(String sectionid,String standardid,String examnameid)
	{
	 		log.info("invoking sectionSubjectPassDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select subjectname,e.subjectscheduleid, (select count(studentallocationid) from studentallocation where sectionscheduleid='"+sectionid+"' and studentallocationstatus='A')as totalstudents, concat(firstname,' ',lastname)as staffname, (select count(exammarkid) from examallotment a1,examschedule b1,exammark c1, subjectschedule d1,studentallocation e1 where a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and b1.examschedulestatus='A' and b1.examscheduleid=c1.examscheduleid and b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid=e.subjectscheduleid and d1.theoryexternalmin<=c1.marktaken and c1.markstatus='A' and b1.markpublishstatus='A' and e1.sectionscheduleid='"+sectionid+"' and c1.studentallocationid=e1.studentallocationid and e1.studentallocationstatus='A' group by d1.subjectscheduleid) as passedcount from studentallocation g, sectionschedule f,standardschedule c,subjectschedule e, subjectallotment h, staffmaster i,login j,personmaster k,subject b where f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' and f.sectionscheduleid='"+sectionid+"' and c.standardscheduleid=f.standardscheduleid and c.standardscheduleid='"+standardid+"' and c.standardscheduleid=e.standardscheduleid and e.status='A' and e.subjectid=b.subjectid and b.subjectstatus='A' and e.subjectscheduleid=h.subjectscheduleid and h.subjectallotmentstatus='A' and h.staffid=i.staffid and i.userid=j.userid and j.personid=k.personid group by e.subjectscheduleid";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportSubject.jsp
	 */
	 
	public ArrayList standardSubjectPassDetails(String standardid,String examnameid)
	{
	 		log.info("invoking standardSubjectPassDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select subjectname,e.subjectscheduleid, (select count(studentallocationid) from studentallocation a2, sectionschedule c2 where c2.standardscheduleid='"+standardid+"' and studentallocationstatus='A' and c2.sectionscheduleid=a2.sectionscheduleid and c2.sectionschedulestatus='A')as totalstudents, concat(firstname,' ',lastname)as staffname, (select count(exammarkid) from subjectschedule d1, studentallocation e1,sectionschedule f1,examallotment a1, examschedule b1,exammark c1 where f1.standardscheduleid='"+standardid+"' and f1.sectionschedulestatus='A' and f1.sectionscheduleid=e1.sectionscheduleid and e1.studentallocationstatus='A' and f1.standardscheduleid=d1.standardscheduleid and d1.subjectscheduleid=e.subjectscheduleid and d1.status='A' and f1.standardscheduleid=a1.standardscheduleid and a1.examnameid='"+examnameid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and b1.examschedulestatus='A' and b1.subjectscheduleid=d1.subjectscheduleid and b1.markpublishstatus='A' and b1.examscheduleid=c1.examscheduleid and d1.theoryexternalmin<=c1.marktaken and c1.markstatus='A' and c1.studentallocationid=e1.studentallocationid  group by d1.subjectscheduleid) as passedcount from studentallocation g, sectionschedule f,standardschedule c,subjectschedule e, subjectallotment h, staffmaster i,login j,personmaster k,subject b where f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' and c.standardscheduleid=f.standardscheduleid and c.standardscheduleid='"+standardid+"' and c.standardscheduleid=e.standardscheduleid and e.status='A' and e.subjectid=b.subjectid and b.subjectstatus='A' and e.subjectscheduleid=h.subjectscheduleid and h.subjectallotmentstatus='A' and h.staffid=i.staffid and i.userid=j.userid and j.personid=k.personid group by e.subjectscheduleid";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}
	
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportStudentList.jsp
	 */
	 
	public ArrayList passedStudentList(String examnameid,String standardscheduleid,String sectionscheduleid,String subjectscheduleid)
	{
	 		log.info("invoking passedStudentList from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select concat(firstname,' ',lastname)as studentname,marktaken,d1.theoryexternalmax from examallotment a1,examschedule b1,exammark c1, subjectschedule d1,studentallocation e1,candidateregister f1,personmaster g1 where a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and b1.examschedulestatus='A' and b1.examscheduleid=c1.examscheduleid and b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' and d1.theoryexternalmin<=c1.marktaken and c1.markstatus='A' and b1.markpublishstatus='A' and e1.sectionscheduleid='"+sectionscheduleid+"' and c1.studentallocationid=e1.studentallocationid and e1.studentallocationstatus='A' and e1.candidateregisterid=f1.candidateregisterid and f1.personid=g1.personid and f1.candidateregisterstatus='A' and g1.status='A'";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportSubjectStudentList.jsp
	 */
	 
	public ArrayList passedSubjectStudentList(String examnameid,String standardscheduleid,String subjectscheduleid)
	{
	 		log.info("invoking passedSubjectStudentList from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select concat(firstname,' ',lastname)as studentname, marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and b1.examschedulestatus='A' and b1.markpublishstatus='A' join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule i1 on a1.standardscheduleid=i1.standardscheduleid and i1.sectionschedulestatus='A' join studentallocation e1 on e1.studentallocationstatus='A' and i1.sectionscheduleid=e1.sectionscheduleid join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and d1.theoryexternalmin<=c1.marktaken and c1.studentallocationid=e1.studentallocationid and c1.markstatus='A'";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportStudentList.jsp
	 */
	 
	public ArrayList failedStudentList(String examnameid,String standardscheduleid,String sectionscheduleid,String subjectscheduleid)
	{
	 		log.info("invoking failedStudentList from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select concat(firstname,' ',lastname)as studentname,case when marktaken is null then 'Not Yet Given' else marktaken end as marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and b1.examschedulestatus='A' and b1.markpublishstatus='A' join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join studentallocation e1 on e1.sectionscheduleid='"+sectionscheduleid+"' and e1.studentallocationstatus='A' join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and d1.theoryexternalmin>c1.marktaken and c1.markstatus='A' and c1.studentallocationid=e1.studentallocationid";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportStudentList.jsp
	 */
	 
	public ArrayList failedSubjectStudentList(String examnameid,String standardscheduleid,String subjectscheduleid)
	{
	 		log.info("invoking failedSubjectStudentList from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select concat(firstname,' ',lastname)as studentname, case when marktaken is null then 'Not Yet Given' else marktaken end as marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and b1.examschedulestatus='A' and b1.markpublishstatus='A' join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule i1 on a1.standardscheduleid=i1.standardscheduleid and i1.sectionschedulestatus='A' join studentallocation e1 on e1.studentallocationstatus='A' and i1.sectionscheduleid=e1.sectionscheduleid join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and d1.theoryexternalmin>c1.marktaken and c1.studentallocationid=e1.studentallocationid and c1.markstatus='A'";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	
 

	 CommonDataAccess common_data_object; 
	 String insert_query;
	 String select_query;
	 int 	return_value;
	 int[] returnvalue;
	 Connection connection;
	 DateTime datetime;

}
