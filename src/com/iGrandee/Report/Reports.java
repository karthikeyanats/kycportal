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


public class Reports {
	
	static Logger log = Logger.getLogger(Reports.class);
	
	 public Reports() {
		 
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
				select_query  	= "select distinct a.examnameid,a.examname from examname a join examallotment b on a.sessionid='"+sessionid+"' and a.examnamestatus='A' and a.examnameid=b.examnameid and b.examallotmentstatus='A' join examschedule c on b.examallotmentid=c.examallotmentid and (c.examschedulestatus='A' or c.examschedulestatus='R') and (c.markpublishstatus='A' or c.markpublishstatus='R')";   
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
				//select_query  	= "select case when h.groupname is null then standardname else concat(standardname,' ',groupname) end as standardname, d.standardscheduleid, g.studentallocationid, (select count(subjectscheduleid) from subjectschedule where standardscheduleid=d.standardscheduleid and status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and (c1.examschedulestatus='A' or c1.examschedulestatus='R') and (c1.markpublishstatus='A' or c1.markpublishstatus='R') and a1.markstatus='A' and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and b1.theoryexternalmin<=a1.marktaken group by a1.studentallocationid)as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.examallotmentid=b.examallotmentid and (b.examschedulestatus='A' or b.examschedulestatus='R') and (b.markpublishstatus='A' or b.markpublishstatus='R') join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' left outer join standardgroup h on d.groupid=h.groupid group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,d.standardscheduleid";
				//select_query  	= "select case when h.groupname is null then standardname else concat(standardname,' ',groupname) end as standardname, d.standardscheduleid, g.studentallocationid, (select count(subjectscheduleid) from subjectschedule where standardscheduleid=d.standardscheduleid and status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and c1.examschedulestatus='R' and c1.markpublishstatus='R' and a1.markstatus='A' and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and cast(b1.theoryexternalmin as unsigned integer) <= cast(a1.marktaken as unsigned integer) group by a1.studentallocationid)as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.examallotmentid=b.examallotmentid and (b.examschedulestatus='R') and (b.markpublishstatus='R') join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' left outer join standardgroup h on d.groupid=h.groupid group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,d.standardscheduleid";
				select_query  	= "select case when h.groupname is null then standardname else concat(standardname,' ',groupname) end as standardname, d.standardscheduleid, g.studentallocationid, (select count(subjectscheduleid) from subjectschedule s1,subject s2 where s1.standardscheduleid=d.standardscheduleid and s1.subjectid=s2.subjectid and s2.subjectstatus='A' and s1.status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and c1.examschedulestatus='R' and c1.markpublishstatus='R' and a1.markstatus='A' and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and cast(b1.theoryexternalmin as unsigned integer) <= cast(a1.marktaken as unsigned integer) group by a1.studentallocationid)as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.examallotmentid=b.examallotmentid and (b.examschedulestatus='R') and (b.markpublishstatus='R') join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' left outer join standardgroup h on d.groupid=h.groupid group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,d.standardscheduleid";
				periodsList 	= common_data_object.getListMap(select_query);
				//System.out.print("select_query-->"+select_query);
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
				//select_query  	= "select sectionname,f.sectionscheduleid,g.studentallocationid, (select count(subjectscheduleid) from subjectschedule where standardscheduleid=d.standardscheduleid and status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and (c1.examschedulestatus='R') and (c1.markpublishstatus='R') and a1.markstatus='A' and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and cast(b1.theoryexternalmin as unsigned integer) <= cast(a1.marktaken as unsigned integer) group by a1.studentallocationid) as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.standardscheduleid='"+standardid+"' and a.examallotmentid=b.examallotmentid and (b.examschedulestatus='A' or b.examschedulestatus='R') and (b.markpublishstatus='A' or b.markpublishstatus='R') join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join section e on f.sectionid=e.sectionid and e.status='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,f.sectionscheduleid";
				select_query  	= "select sectionname,f.sectionscheduleid,g.studentallocationid, (select count(subjectscheduleid) from subjectschedule s1,subject s2 where s1.standardscheduleid=d.standardscheduleid and s1.subjectid=s2.subjectid and s2.subjectstatus='A' and s1.status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and (c1.examschedulestatus='R') and (c1.markpublishstatus='R') and a1.markstatus='A' and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and cast(b1.theoryexternalmin as unsigned integer) <= cast(a1.marktaken as unsigned integer) group by a1.studentallocationid) as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.standardscheduleid='"+standardid+"' and a.examallotmentid=b.examallotmentid and (b.examschedulestatus='A' or b.examschedulestatus='R') and (b.markpublishstatus='A' or b.markpublishstatus='R') join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join section e on f.sectionid=e.sectionid and e.status='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,f.sectionscheduleid";
				periodsList 	= common_data_object.getListMap(select_query);
				//System.out.print("select_query-->"+select_query);
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
				//select_query  	= "select subjectname,e.subjectscheduleid, (select count(studentallocationid) from studentallocation where sectionscheduleid='"+sectionid+"' and studentallocationstatus='A')as totalstudents, concat(firstname,' ',lastname)as staffname, (select count(exammarkid) from examallotment a1,examschedule b1,exammark c1, subjectschedule d1,studentallocation e1 where a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='A' or b1.examschedulestatus='R') and b1.examscheduleid=c1.examscheduleid and b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid=e.subjectscheduleid and d1.theoryexternalmin<=c1.marktaken and c1.markstatus='A' and (b1.markpublishstatus='A' or b1.markpublishstatus='R') and e1.sectionscheduleid='"+sectionid+"' and c1.studentallocationid=e1.studentallocationid and e1.studentallocationstatus='A' group by d1.subjectscheduleid) as passedcount from studentallocation g, sectionschedule f,standardschedule c,subjectschedule e, subjectallotment h, staffmaster i,login j,personmaster k,subject b where f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' and f.sectionscheduleid='"+sectionid+"' and c.standardscheduleid=f.standardscheduleid and c.standardscheduleid='"+standardid+"' and c.standardscheduleid=e.standardscheduleid and e.status='A' and e.subjectid=b.subjectid and b.subjectstatus='A' and e.subjectscheduleid=h.subjectscheduleid and h.subjectallotmentstatus='A' and h.staffid=i.staffid and i.userid=j.userid and j.personid=k.personid group by e.subjectscheduleid";
				select_query  	= "select subjectname,e.subjectscheduleid, (select count(studentallocationid) from studentallocation where sectionscheduleid='"+sectionid+"' and studentallocationstatus='A')as totalstudents, concat(firstname,' ',lastname)as staffname, (select count(exammarkid) from examallotment a1,examschedule b1,exammark c1, subjectschedule d1,studentallocation e1 where a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='R') and b1.examscheduleid=c1.examscheduleid and b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid=e.subjectscheduleid and cast(d1.theoryexternalmin as unsigned integer) <= cast(c1.marktaken as unsigned integer) and c1.markstatus='A' and (b1.markpublishstatus='A' or b1.markpublishstatus='R') and e1.sectionscheduleid='"+sectionid+"' and c1.studentallocationid=e1.studentallocationid and e1.studentallocationstatus='A' group by d1.subjectscheduleid) as passedcount from studentallocation g, sectionschedule f,standardschedule c,subjectschedule e, subjectallotment h, staffmaster i,login j,personmaster k,subject b where f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' and f.sectionscheduleid='"+sectionid+"' and c.standardscheduleid=f.standardscheduleid and c.standardscheduleid='"+standardid+"' and c.standardscheduleid=e.standardscheduleid and e.status='A' and e.subjectid=b.subjectid and b.subjectstatus='A' and e.subjectscheduleid=h.subjectscheduleid and h.subjectallotmentstatus='A' and h.staffid=i.staffid and i.userid=j.userid and j.personid=k.personid group by e.subjectscheduleid";
				periodsList 	= common_data_object.getListMap(select_query);
				//System.out.println("select_query====>"+select_query);
				
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportSectionSubject.jsp
	 */
	 
	public ArrayList sectionSubjectStaffDetails(String sectionid,String subjectscheduleid)
	{
	 		log.info("invoking sectionSubjectPassDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select concat(firstname,' ',lastname)as staffname from subjectallotment h, staffmaster i,login j,personmaster k where h.subjectscheduleid='"+subjectscheduleid+"' and sectionpublishid='"+sectionid+"' and h.subjectallotmentstatus='A' and h.staffid=i.staffid and i.userid=j.userid and j.personid=k.personid";
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
	 
	public ArrayList sectionSubjectStaffDetails(String subjectscheduleid)
	{
	 		log.info("invoking sectionSubjectPassDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select distinct concat(firstname,' ',lastname)as staffname,i.staffid from subjectallotment h, staffmaster i,login j,personmaster k where h.subjectscheduleid='"+subjectscheduleid+"' and h.subjectallotmentstatus='A' and h.staffid=i.staffid and i.userid=j.userid and j.personid=k.personid";
				System.out.println(select_query);
				periodsList 	= common_data_object.getListMap(select_query);
				
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	
	 /*
	  * This method is accessed from kycportal/jsp/Reports/ReportSubject.jsp
	  * This method is accessed from kycportal/jsp/SuperAdmin/SubjectInfo.jsp (prasanth)

	 */
	 
	public ArrayList standardSubjectPassDetails(String standardid,String examnameid)
	{
	 		log.info("invoking standardSubjectPassDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				//select_query  	= "select subjectname,e.subjectscheduleid, (select count(studentallocationid) from studentallocation a2, sectionschedule c2 where c2.standardscheduleid='"+standardid+"' and studentallocationstatus='A' and c2.sectionscheduleid=a2.sectionscheduleid and c2.sectionschedulestatus='A')as totalstudents, concat(firstname,' ',lastname)as staffname, (select count(exammarkid) from subjectschedule d1, studentallocation e1,sectionschedule f1,examallotment a1, examschedule b1,exammark c1 where f1.standardscheduleid='"+standardid+"' and f1.sectionschedulestatus='A' and f1.sectionscheduleid=e1.sectionscheduleid and e1.studentallocationstatus='A' and f1.standardscheduleid=d1.standardscheduleid and d1.subjectscheduleid=e.subjectscheduleid and d1.status='A' and f1.standardscheduleid=a1.standardscheduleid and a1.examnameid='"+examnameid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='A' or b1.examschedulestatus='R') and b1.subjectscheduleid=d1.subjectscheduleid and (b1.markpublishstatus='A' or b1.markpublishstatus='R') and b1.examscheduleid=c1.examscheduleid and d1.theoryexternalmin<=c1.marktaken and c1.markstatus='A' and c1.studentallocationid=e1.studentallocationid  group by d1.subjectscheduleid) as passedcount from studentallocation g, sectionschedule f,standardschedule c,subjectschedule e, subjectallotment h, staffmaster i,login j,personmaster k,subject b where f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' and c.standardscheduleid=f.standardscheduleid and c.standardscheduleid='"+standardid+"' and c.standardscheduleid=e.standardscheduleid and e.status='A' and e.subjectid=b.subjectid and b.subjectstatus='A' and e.subjectscheduleid=h.subjectscheduleid and h.subjectallotmentstatus='A' and h.staffid=i.staffid and i.userid=j.userid and j.personid=k.personid group by e.subjectscheduleid";
				select_query  	= "select subjectname,e.subjectscheduleid, (select count(studentallocationid) from studentallocation a2, sectionschedule c2 where c2.standardscheduleid='"+standardid+"' and studentallocationstatus='A' and c2.sectionscheduleid=a2.sectionscheduleid and c2.sectionschedulestatus='A')as totalstudents, concat(firstname,' ',lastname)as staffname, (select count(exammarkid) from subjectschedule d1, studentallocation e1,sectionschedule f1,examallotment a1, examschedule b1,exammark c1 where f1.standardscheduleid='"+standardid+"' and f1.sectionschedulestatus='A' and f1.sectionscheduleid=e1.sectionscheduleid and e1.studentallocationstatus='A' and f1.standardscheduleid=d1.standardscheduleid and d1.subjectscheduleid=e.subjectscheduleid and d1.status='A' and f1.standardscheduleid=a1.standardscheduleid and a1.examnameid='"+examnameid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='R') and b1.subjectscheduleid=d1.subjectscheduleid and (b1.markpublishstatus='R') and b1.examscheduleid=c1.examscheduleid and cast(d1.theoryexternalmin as unsigned integer) <= cast(c1.marktaken as unsigned integer) and c1.markstatus='A' and c1.studentallocationid=e1.studentallocationid  group by d1.subjectscheduleid) as passedcount from studentallocation g, sectionschedule f,standardschedule c,subjectschedule e, subjectallotment h, staffmaster i,login j,personmaster k,subject b where f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' and c.standardscheduleid=f.standardscheduleid and c.standardscheduleid='"+standardid+"' and c.standardscheduleid=e.standardscheduleid and e.status='A' and e.subjectid=b.subjectid and b.subjectstatus='A' and e.subjectscheduleid=h.subjectscheduleid and h.subjectallotmentstatus='A' and h.staffid=i.staffid and i.userid=j.userid and j.personid=k.personid group by e.subjectscheduleid";
				System.out.println(select_query);
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
				//select_query  	= "select concat(firstname,' ',lastname)as studentname,marktaken,d1.theoryexternalmax from examallotment a1,examschedule b1,exammark c1, subjectschedule d1,studentallocation e1,candidateregister f1,personmaster g1 where a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='A' or b1.examschedulestatus='R') and b1.examscheduleid=c1.examscheduleid and b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' and d1.theoryexternalmin<=c1.marktaken and c1.markstatus='A' and (b1.markpublishstatus='A' or b1.markpublishstatus='R') and e1.sectionscheduleid='"+sectionscheduleid+"' and c1.studentallocationid=e1.studentallocationid and e1.studentallocationstatus='A' and e1.candidateregisterid=f1.candidateregisterid and f1.personid=g1.personid and f1.candidateregisterstatus='A' and g1.status='A'";
				select_query  	= "select concat(firstname,' ',lastname)as studentname,marktaken,d1.theoryexternalmax from examallotment a1,examschedule b1,exammark c1, subjectschedule d1,studentallocation e1,candidateregister f1,personmaster g1 where a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='R') and b1.examscheduleid=c1.examscheduleid and b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' and cast(d1.theoryexternalmin as unsigned integer) <= cast(c1.marktaken as unsigned integer) and c1.markstatus='A' and (b1.markpublishstatus='R') and e1.sectionscheduleid='"+sectionscheduleid+"' and c1.studentallocationid=e1.studentallocationid and e1.studentallocationstatus='A' and e1.candidateregisterid=f1.candidateregisterid and f1.personid=g1.personid and f1.candidateregisterstatus='A' and g1.status='A'";
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
				//select_query  	= "select concat(firstname,' ',lastname)as studentname, marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='A' or b1.examschedulestatus='R') and (b1.markpublishstatus='A' or b1.markpublishstatus='R') join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule i1 on a1.standardscheduleid=i1.standardscheduleid and i1.sectionschedulestatus='A' join studentallocation e1 on e1.studentallocationstatus='A' and i1.sectionscheduleid=e1.sectionscheduleid join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and d1.theoryexternalmin<=c1.marktaken and c1.studentallocationid=e1.studentallocationid and c1.markstatus='A'";  
				select_query  	= "select concat(firstname,' ',lastname)as studentname, marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='R') and (b1.markpublishstatus='R') join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule i1 on a1.standardscheduleid=i1.standardscheduleid and i1.sectionschedulestatus='A' join studentallocation e1 on e1.studentallocationstatus='A' and i1.sectionscheduleid=e1.sectionscheduleid join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and cast(d1.theoryexternalmin as unsigned integer) <= cast(c1.marktaken as unsigned integer) and c1.studentallocationid=e1.studentallocationid and c1.markstatus='A'";
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
				//select_query  	= "select concat(firstname,' ',lastname)as studentname,case when marktaken is null then 'Not Yet Given' else marktaken end as marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='A' or b1.examschedulestatus='R') and (b1.markpublishstatus='A' or b1.markpublishstatus='R') join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join studentallocation e1 on e1.sectionscheduleid='"+sectionscheduleid+"' and e1.studentallocationstatus='A' join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and d1.theoryexternalmin>c1.marktaken and c1.markstatus='A' and c1.studentallocationid=e1.studentallocationid";
				select_query  	= "select concat(firstname,' ',lastname)as studentname,case when marktaken is null then 'Not Yet Given' else marktaken end as marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='R') and (b1.markpublishstatus='R') join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join studentallocation e1 on e1.sectionscheduleid='"+sectionscheduleid+"' and e1.studentallocationstatus='A' join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and cast(d1.theoryexternalmin as unsigned integer) > cast(c1.marktaken as unsigned integer) and c1.markstatus='A' and c1.studentallocationid=e1.studentallocationid";
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
				//select_query  	= "select concat(firstname,' ',lastname)as studentname, case when marktaken is null then 'Not Yet Given' else marktaken end as marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='A' or b1.examschedulestatus='R') and (b1.markpublishstatus='A' or b1.markpublishstatus='R') join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule i1 on a1.standardscheduleid=i1.standardscheduleid and i1.sectionschedulestatus='A' join studentallocation e1 on e1.studentallocationstatus='A' and i1.sectionscheduleid=e1.sectionscheduleid join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and d1.theoryexternalmin>c1.marktaken and c1.studentallocationid=e1.studentallocationid and c1.markstatus='A'";
				select_query  	= "select concat(firstname,' ',lastname)as studentname, case when marktaken is null then 'Not Yet Given' else marktaken end as marktaken, d1.theoryexternalmax  from examallotment a1 join examschedule b1 on a1.examnameid='"+examnameid+"' and a1.standardscheduleid='"+standardscheduleid+"' and a1.examallotmentstatus='A' and a1.examallotmentid=b1.examallotmentid and (b1.examschedulestatus='R') and (b1.markpublishstatus='R') join subjectschedule d1 on b1.subjectscheduleid=d1.subjectscheduleid and d1.status='A' and d1.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule i1 on a1.standardscheduleid=i1.standardscheduleid and i1.sectionschedulestatus='A' join studentallocation e1 on e1.studentallocationstatus='A' and i1.sectionscheduleid=e1.sectionscheduleid join candidateregister f1 on e1.candidateregisterid=f1.candidateregisterid and f1.candidateregisterstatus='A' join personmaster g1 on f1.personid=g1.personid and g1.status='A' join exammark c1 on b1.examscheduleid=c1.examscheduleid and cast(d1.theoryexternalmin as unsigned integer) > cast(c1.marktaken as unsigned integer) and c1.studentallocationid=e1.studentallocationid and c1.markstatus='A'";
				System.out.println(select_query);
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}	
	public ArrayList ArchivalAcademicYear(String instituteid)
	{
	 		log.info("invoking ArchivalAcademicYear from com.iGrandee.Report.Reports");
		 
			ArrayList List = null;
			try
			{
				select_query  	= "SELECT sessionname,sessionid,sessionstatus FROM yearofsession y where sessionstatus in ('R','A') and  instituteid='"+instituteid+"';";  
				List 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) 
			{ 
				log.error(exception);
			}
			return List;
	}
	
	/*
	 * Created by Subhash to get the consolidated Report 
	 * Accessed from jsp/Reports/ConsolidatedView.jsp
	 */
	public ArrayList consolidatedReport(String sessionid,String boardid,String instituteid)
	{
	 		log.info("invoking consolidatedReport from com.iGrandee.Report.Reports");
		 
			ArrayList List = null;
			try
			{
				//select_query  	= "select a.standardid,a.standardname,'-' as groupid,null as groupname,c.standardscheduleid,case when c.stdschedulestatus is null then 'No' else 'Yes' end as stdstatus,case when g.status is null then 'No' else 'Yes' end as substatus,case when g.status is null then 'No' else 'Get' end as lesstatus,case when h.feesschedulestatus is null then 'No' else 'Yes' end as feestatus,case when i.subjectallotmentstatus is null then 'No' else 'Yes' end as suballstatus,case when i.subjectallotmentstatus is null then 'No' else 'Get' end as timestatus from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' and a.groupstatus='No' and a.standardid not in (select standardid from standardschedule where sessionid='"+sessionid+"' and stdschedulestatus='T') left outer join standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' left outer join subjectschedule g on g.standardscheduleid=c.standardscheduleid and g.status='A' left outer join feesschedule h on h.standardscheduleid=c.standardscheduleid and h.feesschedulestatus='A' left outer join subjectallotment i on i.subjectscheduleid=g.subjectscheduleid and i.subjectallotmentstatus='A' union select a.standardid,a.standardname,d.groupid,d.groupname,c.standardscheduleid,case when c.stdschedulestatus is null then 'No' else 'Yes' end as stdstatus,case when g.status is null then 'No' else 'Yes' end as substatus,case when g.status is null then 'No' else 'Get' end as lesstatus,case when h.feesschedulestatus is null then 'No' else 'Yes' end as feestatus,case when i.subjectallotmentstatus is null then 'No' else 'Yes' end as suballstatus,case when i.subjectallotmentstatus is null then 'No' else 'Get' end as timestatus from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' and a.groupstatus='Yes' join standardgroup d on a.instituteid=d.instituteid and d.groupstatus='A' and d.groupid not in (select f.groupid from standardschedule e,standardgroup f where e.sessionid='"+sessionid+"' and a.standardid=e.standardid and e.stdschedulestatus='T' and f.groupid=e.groupid) left outer join standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' and d.groupid=c.groupid left outer join subjectschedule g on g.standardscheduleid=c.standardscheduleid and g.status='A' left outer join feesschedule h on h.standardscheduleid=c.standardscheduleid and h.feesschedulestatus='A' left outer join subjectallotment i on i.subjectscheduleid=g.subjectscheduleid and i.subjectallotmentstatus='A'";
				/*select_query  	= "select a.standardid,a.standardname,'-' as groupid,null as groupname," +
						"c.standardscheduleid,case when c.stdschedulestatus is null then 'No' else 'Yes' end as stdstatus," +
						"case when g.status is null then 'No' else 'Yes' end as substatus," +
						"case when g.status is null then 'No' else 'Get' end as lesstatus," +
						"case when h.feesschedulestatus is null then 'No' else 'Yes' end as feestatus," +
						"case when i.subjectallotmentstatus is null then 'No' else 'Yes' end as suballstatus," +
						"case when i.subjectallotmentstatus is null then 'No' else 'Get' end as timestatus " +
						"from standard a join institution b on a.instituteid='"+instituteid+"' and " +
						"a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and " +
						"b.status='A' and a.groupstatus='No' and a.standardid not in " +
						"(select standardid from standardschedule where sessionid='"+sessionid+"' and " +
						"stdschedulestatus='T') left outer join standardschedule c on a.standardid=c.standardid and " +
						"a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' " +
						"left outer join subjectschedule g on g.standardscheduleid=c.standardscheduleid and g.status='A' " +
						"left outer join feesschedule h on h.standardscheduleid=c.standardscheduleid and " +
						"h.feesschedulestatus='A' left outer join subjectallotment i on i.subjectscheduleid=g.subjectscheduleid " +
						"and i.subjectallotmentstatus='A' union select a.standardid,a.standardname,d.groupid,d.groupname,c.standardscheduleid," +
						"case when c.stdschedulestatus is null then 'No' else 'Yes' end as stdstatus," +
						"case when g.status is null then 'No' else 'Yes' end as substatus," +
						"case when g.status is null then 'No' else 'Get' end as lesstatus," +
						"case when h.feesschedulestatus is null then 'No' else 'Yes' end as feestatus," +
						"case when i.subjectallotmentstatus is null then 'No' else 'Yes' end as suballstatus," +
						"case when i.subjectallotmentstatus is null then 'No' else 'Get' end as timestatus " +
						"from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid " +
						"and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' and a.groupstatus='Yes' join " +
						"standardgroup d on a.instituteid=d.instituteid and d.groupstatus='A' and d.groupid not in " +
						"(select f.groupid from standardschedule e,standardgroup f where e.sessionid='"+sessionid+"' and " +
						"a.standardid=e.standardid and e.stdschedulestatus='T' and f.groupid=e.groupid) left outer join " +
						"standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and " +
						"c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' and d.groupid=c.groupid left outer join " +
						"subjectschedule g on g.standardscheduleid=c.standardscheduleid and g.status='A' left outer join " +
						"feesschedule h on h.standardscheduleid=c.standardscheduleid and h.feesschedulestatus='A' left outer join " +
						"subjectallotment i on i.subjectscheduleid=g.subjectscheduleid and i.subjectallotmentstatus='A'";*/
				select_query  	= "select a.standardid,a.standardname,'-' as groupid,null as groupname," +
				"c.standardscheduleid,case when c.stdschedulestatus is null then 'No' else 'Yes' end as stdstatus," +
				"case when g.status is null then 'No' else 'Yes' end as substatus," +
				"case when g.status is null then 'No' else 'Get' end as lesstatus," +
				"case when h.feesschedulestatus is null then 'No' else 'Yes' end as feestatus " +
				"from standard a join institution b on a.instituteid='"+instituteid+"' and " +
				"a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and " +
				"b.status='A' and a.groupstatus='No' and a.standardid not in " +
				"(select standardid from standardschedule where sessionid='"+sessionid+"' and " +
				"stdschedulestatus='T') left outer join standardschedule c on a.standardid=c.standardid and " +
				"a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' " +
				"left outer join subjectschedule g on g.standardscheduleid=c.standardscheduleid and g.status='A' " +
				"left outer join feesschedule h on h.standardscheduleid=c.standardscheduleid and " +
				"h.feesschedulestatus='A' union select a.standardid,a.standardname,d.groupid,d.groupname,c.standardscheduleid," +
				"case when c.stdschedulestatus is null then 'No' else 'Yes' end as stdstatus," +
				"case when g.status is null then 'No' else 'Yes' end as substatus," +
				"case when g.status is null then 'No' else 'Get' end as lesstatus," +
				"case when h.feesschedulestatus is null then 'No' else 'Yes' end as feestatus " +
				"from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid " +
				"and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' and a.groupstatus='Yes' join " +
				"standardgroup d on a.instituteid=d.instituteid and d.groupstatus='A' and d.groupid not in " +
				"(select f.groupid from standardschedule e,standardgroup f where e.sessionid='"+sessionid+"' and " +
				"a.standardid=e.standardid and e.stdschedulestatus='T' and f.groupid=e.groupid) left outer join " +
				"standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and " +
				"c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' and d.groupid=c.groupid left outer join " +
				"subjectschedule g on g.standardscheduleid=c.standardscheduleid and g.status='A' left outer join " +
				"feesschedule h on h.standardscheduleid=c.standardscheduleid and h.feesschedulestatus='A' order by standardid,groupid";
				
				List 	= common_data_object.getListMap(select_query);
				//System.out.print("select_query-->"+select_query);
				log.info("Query : "+select_query);
			}
			catch(Exception exception) 
			{ 
				log.error(exception);
			}
			return List;
	}
	
	/*
	 * Created by Subhash to get the whether the Lesson is Scheduled
	 * Accessed from jsp/Reports/ConsolidatedView.jsp
	 */
	public String getLessonSchedule(String standardscheduleid)
    {
		 String returnStr = null;
        try
        {
        	select_query = "select distinct case when c.status ='A' then 'Yes' else 'No' end as lesstatus from standardschedule a,subjectschedule b,lessonschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardscheduleid=b.standardscheduleid and b.subjectscheduleid=c.subjectscheduleid and a.stdschedulestatus='A' and b.status='A' and c.status='A'";
        	log.info(select_query);
        	returnStr = common_data_object.getString(select_query);

        	if(returnStr==null || returnStr.equals("null"))
        		returnStr = "No";
        	
        }catch(Exception e){log.error(e);}
        return returnStr;
    }

	/*
	 * Created by Subhash to get the whether the Subject is Allotted for partcular standard
	 * Accessed from jsp/Reports/ConsolidatedView.jsp
	 */
	public String getSubjectAllotStatus(String standardscheduleid)
    {
		 String returnStr = null;
        try
        {
        	select_query = "select distinct case when b.subjectallotmentstatus='A' then 'Yes' else 'No' end as suballstatus from subjectschedule a,subjectallotment b,standardschedule c where a.subjectscheduleid=b.subjectscheduleid and a.standardscheduleid=c.standardscheduleid and c.standardscheduleid='"+standardscheduleid+"' and a.status='A' and b.subjectallotmentstatus='A' and c.stdschedulestatus='A'";
        	log.info(select_query);
        	returnStr = common_data_object.getString(select_query);
        	
        	if(returnStr==null || returnStr.equals("null"))
        		returnStr = "No";
        
        }catch(Exception e){log.error(e);}
        return returnStr;
    }
	
	/*
	 * Created by Subhash to get the whether the TimeTable is Scheduled for partcular standard
	 * Accessed from jsp/Reports/ConsolidatedView.jsp
	 */
	public String getTimetableSchedule(String standardscheduleid)
    {
		 String returnStr = null;
        try
        {
        	select_query = "select distinct case when e.timetablestatus='A' then 'Yes' else 'No' end as timestatus  from standardschedule a,subjectschedule b,lessonschedule c,subjectallotment d,timetable e where a.standardscheduleid='"+standardscheduleid+"' and a.standardscheduleid=b.standardscheduleid and b.subjectscheduleid=c.subjectscheduleid and c.subjectscheduleid=d.subjectscheduleid and d.subjectallotmentid=e.subjectallotmentid and a.stdschedulestatus='A' and b.status='A' and c.status='A' and d.subjectallotmentstatus='A' and e.timetablestatus='A'";
        	log.info(select_query);
        	returnStr = common_data_object.getString(select_query);
        	
        	if(returnStr==null || returnStr.equals("null"))
        		returnStr = "No";
        
        }catch(Exception e){log.error(e);}
        return returnStr;
    }
	
	/*
	 * Created by Subhash to get the Amount Collected report for academic year
	 * Accessed from jsp/Reports/AmountCollectionView.jsp
	 */	
	public ArrayList getAmountCollection(String sessionid,String fromdate,String todate)
	{
	 		log.info("invoking getAmountCollection from com.iGrandee.Report.Reports");
		 
			ArrayList List = null;
			try
			{
				String fromDate = ((StringBuffer)datetime.getMySQLFormat(fromdate)).toString();
				String toDate = ((StringBuffer)datetime.getMySQLFormat(todate)).toString();

				//select_query  	= "SELECT AI,AD,FC FROM (SELECT SUM(cost) AS AI FROM applicationissue a1 where a1.sessionid='"+sessionid+"' and a1.status='A' and a1.dateofcreation between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59') as x,(SELECT SUM(registrationamount) AS AD FROM registration r1,standardschedule r2,applicationissue r3 where r2.standardscheduleid= r1.standardpublishid and r3.applicationid=r1.applicationid and r2.sessionid='"+sessionid+"' and r1.status='A' and r3.status='A' and r1.dateofcreation between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59') as y,(SELECT SUM(collectionamount) AS FC FROM feescollection f1,candidateregister f2,studentallocation f3,sectionschedule f4,standardschedule f5 where f1.studentapprovalid=f2.studentapprovalid and f2.candidateregisterid=f3.candidateregisterid and f3.studentallocationstatus in ('A','D','C') and f3.sectionscheduleid=f4.sectionscheduleid and f4.standardscheduleid=f5.standardscheduleid and f5.sessionid='"+sessionid+"' and f1.feescollectionstatus='A' and  f1.feescollectiondate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59') as z";
				select_query  	= "SELECT AI,AD,FC FROM (SELECT SUM(cost) AS AI FROM applicationissue a1 where a1.sessionid='"+sessionid+"' and a1.status='A' and a1.dateofcreation between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59') as x,(SELECT SUM(registrationamount) AS AD FROM registration r1,standardschedule r2,applicationissue r3 where r2.standardscheduleid= r1.standardpublishid and r3.applicationid=r1.applicationid and r2.sessionid='"+sessionid+"' and r1.status='A' and r3.status='A' and r1.dateofcreation between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59') as y,(SELECT SUM(collectionamount) AS FC from feescollection f1,termfees f2,standardschedule f3 where f1.termfeesid=f2.termfeesid and f2.standardscheduleid=f3.standardscheduleid and f1.feescollectionstatus='A' and f2.termfeesstatus='A' and f3.stdschedulestatus='A' and f3.sessionid='"+sessionid+"' and  f1.feescollectiondate between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59') as z";
				System.out.println(select_query);
				List 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) 
			{ 
				log.error(exception);
			}
			return List;
	}
	
	/**
	   * get Standard Name for community list creation (Access by subhash)
	   * This method is accessed from kycportal/jsp/Reports/Community/CommunityStdView.jsp
	   @param boardid that can be used to get standard name  from standard table by 
	   *
	   @param sessionid that can be used to get standard name  from standard table by 
	   *
	   @param instituteid that can be used to get standard name  from standard table by 
	   *
	   @param communityid that can be used to get communityid  from standard table by 
	   *	   
	   *@param communityname that can be used to get communityname  from standard table by 
	 	   
	   *@return the ArrayList by which result can be printed on the screen
	 */
		public ArrayList loadcommunitystandardwithstatus(String boardid,String sessionid,String instituteid,String status,String communityid,String communityname) {
		ArrayList arraylist = null;
		try {
			
			String communityQuery = "";
			String communityId[]=null;
			String communityName[]=null;
			
			 if(communityid != null)
			 {
				 communityId = communityid.split("^");
				 communityName = communityname.split("^");
					for(int j=0;j<(communityId.length-1);j++){
						communityQuery = communityQuery+"(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm,standardschedule stas,sectionschedule secs ,studentallocation sa,personmaster pm where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A' and pm.community='"+communityId[j+1]+"' and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as '"+communityName[j+1]+"'";
					}
			 }
			
			 select_query = "select a.groupid,a.standardid,a.standardscheduleid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount,"+communityQuery+" (select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and cm.exserviceman='Yes' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as exsercount ,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm, studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and cm.physicallyfit='Yes' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as phycount from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";
			log.info("===================>>>>>>>>>>>>"+select_query);   
			System.out.println("loadcommunitystandardwithstatus===================>>>>>>>>>>>>"+select_query);   
			arraylist = common_data_object.getListMap(select_query);
					
		} catch (Exception exception) { 
			log.info("Exception : "+exception);
		}
		return    arraylist;
	}
		
		public ArrayList loadcommunitystandardwithstatusnew(String boardid,String sessionid,String instituteid,String status,String communityid,String communityname) {
			ArrayList arraylist = null;
			try {
				
				String communityQuery = "";
				String communityId[]=null;
				String communityName[]=null;
				
				 if(communityid != null)
				 {
					 communityId = communityid.split("1X1");
					 communityName = communityname.split("1X1");
						for(int j=0;j<(communityId.length-1);j++){
							communityQuery = communityQuery+"(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm,standardschedule stas,sectionschedule secs ,studentallocation sa,personmaster pm where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A' and pm.community='"+communityId[j+1]+"' and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as '"+communityName[j+1]+"'";
						}
				 }
				System.out.println("communityQuery"+communityQuery);
				 select_query = "select a.groupid,a.standardid,a.standardscheduleid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount,"+communityQuery+" (select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and cm.exserviceman='Yes' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as exsercount ,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm, studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and cm.physicallyfit='Yes' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as phycount from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";
				log.info("===================>>>>>>>>>>>>"+select_query);   
				System.out.println("loadcommunitystandardwithstatus===================>>>>>>>>>>>>"+select_query);   
				arraylist = common_data_object.getListMap(select_query);
						
			} catch (Exception exception) { 
				log.info("Exception : "+exception);
			}
			return    arraylist;
		}

		/**
		   * get Standard Name for community list creation (Access by subhash)
		   * This method is accessed from kycportal/jsp/Reports/Community/CommunitySecView.jsp
		   @param boardid that can be used to get standard name  from standard table by 
		   *
		   @param sessionid that can be used to get standard name  from standard table by 
		   *
		   @param instituteid that can be used to get standard name  from standard table by 
		   *
		   @param communityid that can be used to get communityid  from standard table by 
		   *	   
		   *@param communityname that can be used to get communityname  from standard table by 
		 	   
		   *@return the ArrayList by which result can be printed on the screen
		 */		
		public ArrayList loadcommunitysectionforview(String standardscheduleid,String status,String communityid,String communityname) {
			ArrayList arraylist = null;
			try {
				String communityQuery = "";
				String communityId[]=null;
				String communityName[]=null;
				
				 if(communityid != null)
				 {
					 communityId = communityid.split("1X1");
					 communityName = communityname.split("1X1");
						for(int j=0;j<(communityId.length-1);j++){
							communityQuery = communityQuery+"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'   and sa.sectionscheduleid=a.sectionscheduleid and pm.community='"+communityId[j+1]+"' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as '"+communityName[j+1]+"',"; 
						}
				 }
				 
				 select_query = "select a.sectionscheduleid, b.sectionname," +
				 "(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid   and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount," +communityQuery+	
				 "(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'   and sa.sectionscheduleid=a.sectionscheduleid and cm.exserviceman='Yes' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as exsercount," +
							"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid  and cm.physicallyfit='Yes' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as phycount" +
									" from sectionschedule a	join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";				 
				/*select_query = "select a.sectionscheduleid, b.sectionname," +
						"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'   and sa.sectionscheduleid=a.sectionscheduleid and (pm.sex='Male'  or pm.sex='M' ) and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as malecount," +
								"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid  and (pm.sex='Female' or pm.sex='F') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as femalecount," +
										"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid   and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount" +
												" from sectionschedule a	join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";*/
				//log.info("==================fdgfgdfgfg=>>>>>>>>>>>>"+select_query);
				arraylist = common_data_object.getListMap(select_query);
				//log.info("==========>>>>>"+arraylist);
				//System.out.println("==================ww=>>>>>>>>>>>>"+select_query);
			} catch (Exception exception) { 
				exception.printStackTrace();
			}
			return    arraylist;
		}		

		/**
		   * get Standard Name for community list creation (Access by subhash)
		   * This method is accessed from kycportal/jsp/Reports/Community/CombCommunityStdWiseStudentView.jsp
		   * This method is accessed from kycportal/jsp/Reports/Community/CommunityStdWiseStudentView.jsp
		   * This method is accessed from kycportal/jsp/Reports/Religion/ReligionStdWiseStudentView.jsp
		   @param standardscheduleid that can be used to get standard name  from standard table by 
		   *
		   @param operation that can be used to get standard name  from standard table by 
		   *
		   @param status that can be used to get standard name  from standard table by 
		 	   
		   *@return the ArrayList by which result can be printed on the screen
		 */		
		public ArrayList loadstudentforcommunitywithstatus(String standardscheduleid,String operation,String status) {
			ArrayList arraylist = null;
			try { 
				
				select_query = "SELECT secs.sectionid,sec.sectionname,s.rollno,pm.middlename,pm.firstname,pm.lastname,s.sectionscheduleid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.emailid,(select x.smscontactno from personaddress x where x.personid=pm.personid and x.peraddstatus='A') as smscontactno,pm.imagepath FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s ,candidateregister cm,personmaster pm,sectionschedule secs ,standardschedule stas,section sec where secs.sectionid=sec.sectionid and  s.sectionscheduleid=secs.sectionscheduleid and cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')    and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid='"+standardscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A' and secs.sectionschedulestatus='A' and sec.status='A'   and  "+operation+" ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid order by secs.sectionid";

				log.info("==========>>>>>"+select_query);  
				System.out.println("loadstudentforcommunitywithstatus>>>"+select_query);

				arraylist = common_data_object.getListMap(select_query);
				log.info("==========>>>>>"+arraylist);       
							
			} catch (Exception exception) { 
			}
			return    arraylist;
		}

		/**
		   * get Standard Name for community list creation (Access by subhash)
		   * This method is accessed from kycportal/jsp/Reports/Community/CombCommunitySecWiseStudentView.jsp
		   * This method is accessed from kycportal/jsp/Reports/Community/CommunitySecWiseStudentView.jsp
		   * This method is accessed from kycportal/jsp/Reports/Religion/ReligionSecWiseStudentView.jsp
		   @param sectionscheduleid that can be used to get section name  from standard table by 
		   *
		   @param operation that can be used to get standard name  from standard table by 
		   *
		   @param status that can be used to get standard name  from standard table by 
		 	   
		   *@return the ArrayList by which result can be printed on the screen
		 */			
		public ArrayList loadstudentforcommunitysectionwithstatus(String sectionscheduleid,String operation,String status) {
			ArrayList arraylist = null;
			try { 

				select_query = "SELECT s.rollno,pm.middlename,pm.firstname,pm.lastname,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.emailid,(select x.smscontactno from personaddress x where x.personid=pm.personid and x.peraddstatus='A') as smscontactno,pm.imagepath FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')  and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and "+operation+" ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid";
				log.info("==========>>>>>"+select_query);
				arraylist = common_data_object.getListMap(select_query);
				log.info("==========>>>>>"+arraylist);       
				//System.out.println("==========>>>>>"+select_query);

			} catch (Exception exception) { 
			}
			return    arraylist;
		}

		/**
		   * get Standard Name for community list creation (Access by subhash)
		   * This method is accessed from kycportal/jsp/Reports/Community/CombCommunitySecWiseStudentView.jsp
		   * This method is accessed from kycportal/jsp/Reports/Community/CommunitySecWiseStudentView.jsp
		   * This method is accessed from kycportal/jsp/Reports/Religion/ReligionSecWiseStudentView.jsp
		   @param boardid that can be used to get section name  from standard table by 
		   *
		   @param sessionid that can be used to get standard name  from standard table by 
		   *
		   *
		   *@param instituteid that can be used to get standard name  from standard table by
		   *
		   *@param communityid that can be used to get standard name  from standard table by
		   *
		   @param status that can be used to get standard name  from standard table by 
		 	   
		   *@return the ArrayList by which result can be printed on the screen
		 */					
		public ArrayList loadcombcommunitystandardwithstatus(String boardid,String sessionid,String instituteid,String status,String communityid) {
			ArrayList arraylist = null;
			try {
				
	
				 select_query = "select a.groupid,a.standardid,a.standardscheduleid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and (cm.exserviceman='Yes' and pm.community='"+communityid+"') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as exsercount ,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm, studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and (cm.physicallyfit='Yes'  and pm.community='"+communityid+"') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as phycount,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm, studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and (cm.physicallyfit='Yes' and pm.community='"+communityid+"' and cm.exserviceman='Yes') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as bothcount from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";
				log.info("===================>>>>>>>>>>>>"+select_query);   
				//System.out.println("loadstandardwithstatus===================>>>>>>>>>>>>"+select_query);   
				arraylist = common_data_object.getListMap(select_query);
						
			} catch (Exception exception) { 
				log.info("Exception : "+exception);
			}
			return    arraylist;
		}

		/**
		   * get Standard Name for community list creation (Access by subhash)
		   * This method is accessed from kycportal/jsp/Reports/Community/CombCommunitySecView.jsp
		   @param boardid that can be used to get section name  from standard table by 
		   *
		   @param standardscheduleid that can be used to get standard name  from standard table by 
		   *
		   *@param communityid that can be used to get standard name  from standard table by
		   *
		   @param status that can be used to get standard name  from standard table by 
		 	   
		   *@return the ArrayList by which result can be printed on the screen
		 */			
		public ArrayList loadcombcommunitysectionforview(String standardscheduleid,String status,String communityid) {
			ArrayList arraylist = null;
			try {
				 
				 select_query = "select a.sectionscheduleid, b.sectionname," +
				 "(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid   and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount,"+	
				 "(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'   and sa.sectionscheduleid=a.sectionscheduleid and (cm.exserviceman='Yes' and pm.community='"+communityid+"') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as exsercount," +
							"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid  and (cm.physicallyfit='Yes' and pm.community='"+communityid+"') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as phycount," +
							"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid  and (cm.physicallyfit='Yes' and pm.community='"+communityid+"' and cm.exserviceman='Yes') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as bothcount" +
									" from sectionschedule a	join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";				 
				/*select_query = "select a.sectionscheduleid, b.sectionname," +
						"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'   and sa.sectionscheduleid=a.sectionscheduleid and (pm.sex='Male'  or pm.sex='M' ) and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as malecount," +
								"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid  and (pm.sex='Female' or pm.sex='F') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as femalecount," +
										"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid   and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount" +
												" from sectionschedule a	join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";*/
				//log.info("==================fdgfgdfgfg=>>>>>>>>>>>>"+select_query);
				arraylist = common_data_object.getListMap(select_query);
				//log.info("==========>>>>>"+arraylist);
				//System.out.println("==================aa=>>>>>>>>>>>>"+select_query);
			} catch (Exception exception) { 
				exception.printStackTrace();
			}
			return    arraylist;
		}				

		/**
		   * get Standard Name for religion list creation (Access by subhash)
		   * This method is accessed from kycportal/jsp/Reports/Religion/ReligionStdView.jsp
		   @param boardid that can be used to get standard name  from standard table by 
		   *
		   @param sessionid that can be used to get standard name  from standard table by 
		   *
		   @param instituteid that can be used to get standard name  from standard table by 
		   *
		   @param communityid that can be used to get communityid  from standard table by 
		   *	   
		   *@param communityname that can be used to get communityname  from standard table by 
		 	   
		   *@return the ArrayList by which result can be printed on the screen
		 */
			public ArrayList loadreligionstandardwithstatus(String boardid,String sessionid,String instituteid,String status,String religionid,String religionname) {
			ArrayList arraylist = null;
			try {
				
				String religionQuery = "";
				String religionId[]=null;
				String religionName[]=null;
				
				 if(religionid != null)
				 {
					 religionId = religionid.split("1X1");
					 religionName = religionname.split("1X1");
						for(int j=0;j<(religionId.length-1);j++){
							religionQuery = religionQuery+",(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm,standardschedule stas,sectionschedule secs ,studentallocation sa,personmaster pm where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A' and pm.religion='"+religionId[j+1]+"' and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as '"+religionName[j+1]+"'";
						}
				 }
				
				 select_query = "select a.groupid,a.standardid,a.standardscheduleid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount"+religionQuery+" from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";
				log.info("===================>>>>>>>>>>>>"+select_query);   
				System.out.println("loadstandardwithstatus===================>>>>>>>>>>>>"+select_query);   
				arraylist = common_data_object.getListMap(select_query);
						
			} catch (Exception exception) { 
				log.info("Exception : "+exception);
			}
			return    arraylist;
		}
			
			//select count(c.personid) from studentallocation a,candidateregister b,personmaster c 		where a.candidateregisterid=b.candidateregisterid and b.personid=c.personid  		and candidateregisterstatus='A' and studentallocationstatus in ('A','D') and c.religion='"+religion+"' and sectionscheduleid='"+sectionscheduleid+"'";

			/**
			   * get Standard Name for religion list creation (Access by subhash)
			   * This method is accessed from kycportal/jsp/Reports/Religion/ReligionStdView.jsp
			   @param standardscheduleid that can be used to get standard name  from standard table by 
			   *
			   @param religionid that can be used to get standard name  from standard table by 
			   *
			   @param religionname that can be used to get standard name  from standard table by 
			   *		 	   
			   *@return the ArrayList by which result can be printed on the screen
			 */			
			public ArrayList loadreligionsectionforview(String standardscheduleid,String status,String religionid,String religionname) {
				ArrayList arraylist = null;
				try {
					String religionQuery = "";
					String religionId[]=null;
					String religionName[]=null;
					
					 if(religionid != null)
					 {
						 religionId = religionid.split("1X1");
						 religionName = religionname.split("1X1");
							for(int j=0;j<(religionId.length-1);j++){
								religionQuery = religionQuery+",(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'   and sa.sectionscheduleid=a.sectionscheduleid and pm.religion='"+religionId[j+1]+"' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as '"+religionName[j+1]+"'"; 
							}
					 }
					 
					 select_query = "select a.sectionscheduleid, b.sectionname," +
					 "(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid   and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount" +religionQuery+
										" from sectionschedule a join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";				 
					//log.info("==================fdgfgdfgfg=>>>>>>>>>>>>"+select_query);
					arraylist = common_data_object.getListMap(select_query);
					//log.info("==========>>>>>"+arraylist);
					//System.out.println("==================ww=>>>>>>>>>>>>"+select_query);
				} catch (Exception exception) { 
					exception.printStackTrace();
				}
				return    arraylist;
			}	

			public ArrayList loadreligionstandard(String boardid,String sessionid,String instituteid,String status) {
				ArrayList arraylist = null;
				try {
					
					
					
					 select_query = "select c.religionid,a.groupid,a.standardid,a.standardscheduleid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname," +
			 		"(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm, " +
			 		"standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and " +
			 		"sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and " +
			 		"stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and " +
			 		"ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and " +
			 		"sap.studentapprovalid=cm.studentapprovalid and pm.religion=c.religionid) as totalcount,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg," +
			 		"studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' " +
			 		"and sa.studentallocationstatus in ('A')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount1 from standardschedule a	join standard b join religion c  " +
			 		"where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' and " +
			 		"a.instituteid=c.instituteid and a.stdschedulestatus='A' and c.relistatus='A' group by a.standardscheduleid,c.religionid order by " +
			 		"a.standardscheduleid,c.religionid asc";
					log.info("===================>>>>>>>>>>>>"+select_query);   
					System.out.println("loadstandardwithstatus==========ddd sdfsdfsdfsdfsdf=========>>>>>>>>>>>>"+select_query);   
					arraylist = common_data_object.getListMap(select_query);
							
				} catch (Exception exception) { 
					log.info("Exception : "+exception);
				}
				return    arraylist;
			}	
			
			public ArrayList getreligion(String instituteid) {
				ArrayList arraylist = null;
				try {
					
					
					
					 select_query = "select religionname,religionid from religion where instituteid='"+instituteid+"' and relistatus='A' order by religionid asc";
					log.info("===================>>>>>>>>>>>>"+select_query);   
					System.out.println("loadstandardwithstatus===================>>>>>>>>>>>>"+select_query);   
					arraylist = common_data_object.getListMap(select_query);
							
				} catch (Exception exception) { 
					log.info("Exception : "+exception);
				}
				return    arraylist;
			}	
			
			/**
			   * get Standard Name for community list creation (Access by selvakumar_v)
			   * This method is accessed from kycportal/jsp/Reports/Community/CommunityStdView.jsp
			   @param boardid that can be used to get standard name  from standard table by 
			   *
			   @param sessionid that can be used to get standard name  from standard table by 
			   *
			   @param instituteid that can be used to get standard name  from standard table by 
			   *
			   @param communityid that can be used to get communityid  from standard table by 
			   *	   
			   *@param communityname that can be used to get communityname  from standard table by 
			 	   
			   *@return the ArrayList by which result can be printed on the screen
			 */
				public ArrayList loadcommunitystandard(String boardid,String sessionid,String instituteid,String status) {
				ArrayList arraylist = null;
				try {
					
					String communityQuery = "";
					String communityId[]=null;
					String communityName[]=null;
					
					 select_query = "select c.communityid,a.groupid,a.standardid,a.standardscheduleid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as" +
					" groupname,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa" +
					",personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in " +
					"('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  " +
					"and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and " +
					"ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' " +
					"and sap.studentapprovalid=cm.studentapprovalid and pm.community=c.communityid) as totalcount,(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount1, (select count(cm.candidateregisterid) from  applicationissue ai, registration reg," +
					"studentapproval sap,candidateregister cm,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid" +
					" and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A' " +
					"and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  " +
					"and cm.exserviceman='Yes' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and" +
					" sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as exsercount ," +
					"(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm, studentallocation sa," +
					"personmaster pm,standardschedule stas,sectionschedule secs where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') " +
					" and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A' and sa.sectionscheduleid=secs.sectionscheduleid and " +
					"stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and cm.physicallyfit='Yes' and " +
					"ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and " +
					"sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as phycount from standardschedule a	" +
					"join standard b join community c  where a.standardid=b.standardid  and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and " +
					"a.instituteid='"+instituteid+"' and a.stdschedulestatus='A' and a.instituteid=c.instituteid and  c.commstatus='A' group by a.standardscheduleid," +
					"c.communityid order by a.standardid,a.groupid,c.communityid asc";
					log.info("===================>>>>>>>>>>>>"+select_query);   
					System.out.println("loadcommunitystandard===================>>>>>>>>>>>>"+select_query);   
					arraylist = common_data_object.getListMap(select_query);
							
				} catch (Exception exception) { 
					log.info("Exception : "+exception);
				}
				return    arraylist;
			}

			
	 CommonDataAccess common_data_object; 
	 String insert_query;
	 String select_query;
	 int 	return_value;
	 int[] returnvalue;
	 Connection connection;
	 DateTime datetime;

}
