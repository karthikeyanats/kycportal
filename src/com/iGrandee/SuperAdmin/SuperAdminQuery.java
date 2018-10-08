package com.iGrandee.SuperAdmin;

import java.sql.Connection;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class SuperAdminQuery
{
	static Logger log = Logger.getLogger(SuperAdminQuery.class);
	public SuperAdminQuery()
	{
		common_data_object 		= new CommonDataAccess();
		connectionManager  	= new ConnectionManager();
		tcgenerationConnection	= null;
		select_query= "";
		datetime				= new DateTime();
	}
	
	
	/**
	 * This method is accessed jsp/SuperAdmin/AcademicYearInfo.jsp (prasanth)
	 * @param instituteid that can be used to get  AcademicYear with board count
      @return  ArrayList by which result can be printed on the screen
	 */
	public ArrayList listYearofSession(String instituteid)
	{
		log.info("invoking listYearofSession to list all year of session");
		ArrayList courseList = new ArrayList();
		String currdate = "";
		try
		{ 
			String query = "select sessionid,sessionname,sessionstatus,(select count(distinct a.boardid)  from board a,standardmedium b,standard c,standardschedule d where a.instituteid='"+instituteid+"' and a.boardstatus='A' and a.mediumid=b.mediumid and b.mediumstatus='A' and a.boardid=c.boardid and c.standardstatus='A' and c.standardid=d.standardid and d.stdschedulestatus='A' and d.sessionid=sessionid) as boardcount  from yearofsession where instituteid='"+instituteid+"' and (sessionstatus='A' or sessionstatus='R') order by sessionname;";
			courseList = common_data_object.getListMap(query);
		}catch(Exception e){log.error(e);}
		return courseList;
	}
	/**
	 * This method is accessed jsp/SuperAdmin/AcademicYearInfo.jsp (prasanth)
	 * @param instituteid that can be used to get  board list with Standards count
      @return  ArrayList by which result can be printed on the screen
	 */
	public ArrayList listBoard(String instituteid,String sessionid )
	{
		log.info("invoking listYearofSession to list all year of session");
		ArrayList courseList = new ArrayList();
		String currdate = "";
		try
		{
			String query = "select   distinct a.boardid,a.boardname,b.mediumid,b.mediumname,(select count(a1.standardscheduleid) from standardschedule a1,standard b1 where a1.stdschedulestatus='A' and a1.standardid=b1.standardid and b1.standardstatus='A' and b1.boardid=a.boardid and b1.instituteid=a.instituteid and a1.sessionid=d.sessionid) as standardcount from board a,standardmedium b,standard c,standardschedule d where a.instituteid='"+instituteid+"' and a.boardstatus='A' and a.mediumid=b.mediumid and b.mediumstatus='A' and a.boardid=c.boardid and c.standardstatus='A' and c.standardid=d.standardid and d.stdschedulestatus='A' and d.sessionid='"+sessionid+"' ";
			//System.out.println("query-->"+query);
			courseList = common_data_object.getListMap(query);
		}catch(Exception e){log.error(e);}
		return courseList;
	}
	/**
	 * This method is accessed kycportal/jsp/SuperAdmin/StandardInfo.jsp (prasanth)
	 * @param sessionid  that can be used to get standards  by  sessionid wise
	 * @param boardid  that can be used to get standards  by  boardid wise
	 * @param instituteid that can be used to get standards  by  instituteid wise
     * @return  ArrayList by which result can be printed on the screen
	 */
	public ArrayList listStandard(String sessionid,String boardid,String instituteid)
	{
		log.info("invoking listStandard To list Standards based on sessionid,boardid");
		ArrayList valueList = null;
		try
		{
			String qry = "select b.standardid,b.standardname,a.standardscheduleid,a.groupid,b.groupstatus,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid and d.groupstatus='A')  end as groupname from standardschedule a,standard b where a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A' and a.instituteid='"+instituteid+"' order by b.standardid,groupname";
			valueList = common_data_object.getListMap(qry);
			//System.out.println(qry);
		}
		catch(Exception e){
			log.error(e);
		}
			return valueList;

	}
	/**
	 *  this method is acessed from kycportal/jsp/SuperAdmin/StandardInfo.jsp
	 * @param sessionid that can be used to get exams count  by  sessionid wise
	 * @param standardscheduleid that can be used to get exams count  by  standardscheduleid wise
	 * @param instituteid that can be used to get exams  count by  instituteid wise
     * @return  ArrayList by which result can be printed on the screen
	 */
	public ArrayList examCountStandard(String instituteid,String sessionid,String standardscheduleid)
	{
		log.info("invoking listStandard To list Standards based on sessionid,boardid");
		ArrayList valueList = null;
		try
		{
			String qry = "select a.examnameid,a.examname from examname a,examallotment b,examschedule c where a.examnamestatus='A' and a.examnameid=b.examnameid and b.examallotmentstatus='A' and a.sessionid='"+sessionid+"' and a.instituteid='"+instituteid+"' and b.standardscheduleid='"+standardscheduleid+"' and b.examallotmentid=c.examallotmentid and c.exampublishstatus='R' and c.examschedulestatus='R' and c.markpublishstatus='R' group by a.examnameid";
			valueList = common_data_object.getListMap(qry);
			//System.out.println(qry);
		}
		catch(Exception e){
			log.error(e);
		}
			return valueList;

	}
	/**
	 *  this method is acessed from kycportal/jsp/SuperAdmin/ExamInfo.jsp
	 * @param sessionid that can be used to get exams  by  sessionid wise
	 * @param standardscheduleid that can be used to get exams  by  standardscheduleid wise
	 * @param instituteid that can be used to get exams  by  instituteid wise
     * @return  ArrayList by which result can be printed on the screen
	 */
	public ArrayList listExam(String sessionid,String standardscheduleid,String instituteid)
	{
		log.info("invoking listStandard To list Standards based on sessionid,boardid");
		ArrayList valueList = null;
		try
		{
			//String qry = "select b.standardid,b.standardname,a.standardscheduleid,a.groupid,b.groupstatus,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid and d.groupstatus='A')  end as groupname from standardschedule a,standard b where a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A' and a.instituteid='"+instituteid+"' order by b.standardid,groupname";
			String qry = "select a.examnameid,a.examname from examname a,examallotment b,examschedule c where a.examnamestatus='A' and a.examnameid=b.examnameid and b.examallotmentstatus='A' and a.sessionid='"+sessionid+"' and a.instituteid='"+instituteid+"' and b.standardscheduleid='"+standardscheduleid+"' and b.examallotmentid=c.examallotmentid and c.exampublishstatus='R' and c.examschedulestatus='R' and c.markpublishstatus='R' group by a.examnameid;";
			valueList = common_data_object.getListMap(qry);
			//System.out.println(qry);
		}
		catch(Exception e){
			log.error(e);
		}
			return valueList;

	}
	/**
	 * this method is acessed from kycportal/jsp/SuperAdmin/ExamStandardPass.jsp
	 * @param examnameid that can be used to get Standard Wise Pass Percentage by  examnameid wise
	 * @param standardscheduleid that can be used to get Standard Wise Pass Percentage by  standardscheduleid wise
     * @return  ArrayList by which result can be printed on the screen
	 */
	public ArrayList standardPassDetails(String examnameid,String standardscheduleid)
	{
	 		log.info("invoking standardPassDetails from com.iGrandee.Report.Reports");
		 
			ArrayList periodsList = null;
			try
			{
				//select_query  	= "select case when h.groupname is null then standardname else concat(standardname,' ',groupname) end as standardname, d.standardscheduleid, g.studentallocationid, (select count(subjectscheduleid) from subjectschedule where standardscheduleid=d.standardscheduleid and status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and (c1.examschedulestatus='A' or c1.examschedulestatus='R') and (c1.markpublishstatus='A' or c1.markpublishstatus='R') and a1.markstatus='A' and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and b1.theoryexternalmin<=a1.marktaken group by a1.studentallocationid)as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.examallotmentid=b.examallotmentid and (b.examschedulestatus='A' or b.examschedulestatus='R') and (b.markpublishstatus='A' or b.markpublishstatus='R') join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' left outer join standardgroup h on d.groupid=h.groupid group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,d.standardscheduleid";
				//select_query  	= "select case when h.groupname is null then standardname else concat(standardname,' ',groupname) end as standardname, d.standardscheduleid, g.studentallocationid, (select count(subjectscheduleid) from subjectschedule where standardscheduleid=d.standardscheduleid and status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and c1.examschedulestatus='R' and c1.markpublishstatus='R' and a1.markstatus='A' and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and cast(b1.theoryexternalmin as unsigned integer) <= cast(a1.marktaken as unsigned integer) group by a1.studentallocationid)as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.examallotmentid=b.examallotmentid and (b.examschedulestatus='R') and (b.markpublishstatus='R') join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' left outer join standardgroup h on d.groupid=h.groupid group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,d.standardscheduleid";
				select_query  	= "select case when h.groupname is null then standardname else concat(standardname,' ',groupname) end as standardname, d.standardscheduleid, g.studentallocationid, (select count(subjectscheduleid) from subjectschedule s1,subject s2 where s1.standardscheduleid=d.standardscheduleid and s1.subjectid=s2.subjectid and s2.subjectstatus='A' and s1.status='A' group by standardscheduleid) as totalsubject, (select count(exammarkid) from exammark a1,subjectschedule b1, examschedule c1,examallotment d1 where a1.studentallocationid=g.studentallocationid and d1.examnameid='"+examnameid+"' and d1.examallotmentid=c1.examallotmentid and a1.examscheduleid=c1.examscheduleid and c1.examschedulestatus='R' and c1.markpublishstatus='R' and a1.markstatus='A' and c1.subjectscheduleid=b1.subjectscheduleid and b1.status='A' and cast(b1.theoryexternalmin as unsigned integer) <= cast(a1.marktaken as unsigned integer) group by a1.studentallocationid)as passedsubject from examallotment a join examschedule b on a.examnameid='"+examnameid+"' and a.examallotmentstatus='A' and a.examallotmentid=b.examallotmentid and (b.examschedulestatus='R') and (b.markpublishstatus='R') join standardschedule d on a.standardscheduleid=d.standardscheduleid and d.standardscheduleid='"+standardscheduleid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid join sectionschedule f on d.standardscheduleid=f.standardscheduleid and f.sectionschedulestatus='A' join studentallocation g on f.sectionscheduleid=g.sectionscheduleid and g.studentallocationstatus='A' left outer join standardgroup h on d.groupid=h.groupid group by g.studentallocationid,a.examnameid,d.standardscheduleid order by a.examnameid,d.standardscheduleid";
				periodsList 	= common_data_object.getListMap(select_query);
				//System.out.print("select_query--ok>"+select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection tcgenerationConnection;
	 DateTime datetime;
}