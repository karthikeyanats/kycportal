package com.iGrandee.Exam.ExamAllotment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class ExamAllotmentQuery {
	static Logger log = Logger.getLogger(ExamAllotmentQuery.class);

	public ExamAllotmentQuery() {

		common_data_object = new CommonDataAccess();
		insert_query = null;
		select_query = null;
		return_value = 0;
		connection = null;
	}

	public ArrayList loadAcademicYear(String instituteid) {
		log.info("Invoking loadAcademicYear() for Load the Academic Session");
		ArrayList academicList = null;
		try {
			select_query = "SELECT sessionid,sessionname FROM yearofsession where instituteid='"
					+ instituteid
					+ "' and (sessionstatus='A' or sessionstatus='R')";
			academicList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	public ArrayList loadAcademicYearMarkPublished(String instituteid) {
		log
				.info("Invoking loadAcademicYearMarkPublished(String instituteid) for Load the Academic Session");
		ArrayList academicList = null;
		try {
			select_query = "SELECT distinct sessionid,sessionname FROM yearofsession where instituteid='"
					+ instituteid
					+ "' and (sessionstatus='A' or sessionstatus='R') and sessionid in (select a.sessionid from examname a,examallotment b, examschedule c where a.instituteid='"
					+ instituteid
					+ "' and a.examnamestatus='A' and a.examnameid=b.examnameid and b.examallotmentstatus='A' and b.examallotmentid=c.examallotmentid and c.exampublishstatus='R' and c.markpublishstatus='R' and c.examschedulestatus='R')";
			academicList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	/**
	 * This method is accessed from kycportal/jsp/Reports/ExamViewpreview.jsp
	 * 
	 * @param instituteid
	 *            that can be used to get all yearofsession from yearofsession table
	 *            by instituteid wise;
	 * 
	 * @return ArrayList by which result can be printed on the screen ( created by
	 *         _prasanth)
	 */
	public ArrayList loadRKYear(String instituteid) {
		log.info("Invoking loadAcademicYear() for Load the Academic Session");
		ArrayList academicList = null;
		try {
			select_query = "SELECT sessionid,sessionname FROM yearofsession where instituteid='"
					+ instituteid + "' and sessionstatus='R'";
			academicList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	public ArrayList loadScheduledStandardSubjects(String standardscheduleid) {
		log
				.info("Invoking loadScheduledStandardSubjects() for Load the Scheduled Subjects based on standard scheduleid");
		ArrayList periodsList = null;
		try {
			select_query = "select b.subjectname,a.subjectscheduleid,a.subjectid from subjectschedule a,subject b where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.standardscheduleid='"
					+ standardscheduleid + "'";
			log.info(select_query);
			periodsList = common_data_object.getListMap(select_query);

		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	public int loadmarkenteredcountforexampublish(String examscheduleid) {
		log
				.info("Invoking loadScheduledStandardSubjects() for Load the Scheduled Subjects based on standard scheduleid");
		String count = null;
		try {
			select_query = "select count(*) from exammark where examscheduleid='"
					+ examscheduleid + "' and markstatus='A'";
			log.info(select_query);
			count = common_data_object.getSingleColumn(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		int result = 0;

		if (count != null && !count.equals("null")) {
			result = Integer.parseInt(count);
		}
		return result;
	}

	public ArrayList loadScheduledStandardSubjectsforexammark(
			String standardscheduleid, String examnameid) {
		log
				.info("Invoking loadScheduledStandardSubjects() for Load the Scheduled Subjects based on standard scheduleid");
		ArrayList periodsList = null;
		try {
			select_query = "select b.subjectname,a.subjectscheduleid,a.subjectid,c.examscheduleid,c.examallotmentid from subjectschedule a,subject b,examschedule c,examallotment d where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"
					+ standardscheduleid
					+ "' and d.examnameid='"
					+ examnameid
					+ "' and c.examallotmentid=d.examallotmentid";
			log.info(select_query);
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	public ArrayList loadScheduledStandardSubjectsforexam(
			String standardscheduleid, String examnameid) {
		log
				.info("Invoking loadScheduledStandardSubjects() for Load the Scheduled Subjects based on standard scheduleid");
		ArrayList periodsList = null;
		try {
			// select_query="select a.subjectscheduleid as
			// examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y')
			// as
			// examdate,a.examtimein,a.examtimeout,b.examallotmentid,a.examschedulestatus
			// from examallotment b join subjectschedule c on
			// b.standardscheduleid='"+standardscheduleid+"' and
			// b.examnameid='"+examnameid+"' and
			// b.standardscheduleid=c.standardscheduleid and
			// b.examallotmentstatus='A' and c.status='A' join subject d on
			// c.subjectid=d.subjectid and d.subjectstatus='A' left outer join
			// examschedule a on c.subjectscheduleid=a.subjectscheduleid and
			// (a.examschedulestatus='A' or a.examschedulestatus='P' or
			// a.examschedulestatus='R') and (a.markpublishstatus='R' or
			// a.markpublishstatus='P') and
			// b.examallotmentid=a.examallotmentid";
			select_query = "select a.subjectscheduleid as examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y') as examdate,a.examtimein,REPLACE(TIME_FORMAT(a.examtimein,'%r'),':00 ',' ') as examtimeinampm,a.examtimeout,a.examtype,REPLACE(TIME_FORMAT(a.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(a.examtimeout,a.examtimein),1,5) AS duration,b.examallotmentid,a.examschedulestatus from examallotment b join subjectschedule c on b.standardscheduleid='"
					+ standardscheduleid
					+ "' and b.examnameid='"
					+ examnameid
					+ "' and b.standardscheduleid=c.standardscheduleid and b.examallotmentstatus='A' and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' left outer join examschedule a on c.subjectscheduleid=a.subjectscheduleid and (a.examschedulestatus='A' or a.examschedulestatus='P' or a.examschedulestatus='R')  and (a.markpublishstatus='R' or a.markpublishstatus='P') and b.examallotmentid=a.examallotmentid";
			log.info(select_query);
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	public ArrayList loadScheduledStandardSubjectsforexampublish(
			String standardscheduleid, String examnameid) {
		log
				.info("Invoking loadScheduledStandardSubjects() for Load the Scheduled Subjects based on standard scheduleid");
		ArrayList periodsList = null;
		try {
			select_query = "select a.examscheduleid,a.subjectscheduleid as examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y') as examdate,a.examtimein,REPLACE(TIME_FORMAT(a.examtimein,'%r'),':00 ',' ') as examtimeinampm,a.examtimeout,REPLACE(TIME_FORMAT(a.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(a.examtimeout,a.examtimein),1,5) AS duration,b.examallotmentid,a.examschedulestatus,a.exampublishstatus,a.examtype from examallotment b join subjectschedule c on b.standardscheduleid='"
					+ standardscheduleid
					+ "' and b.examnameid='"
					+ examnameid
					+ "' and b.standardscheduleid=c.standardscheduleid and b.examallotmentstatus='A' and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join examschedule a on c.subjectscheduleid=a.subjectscheduleid  and b.examallotmentid=a.examallotmentid and (a.markpublishstatus='P' or a.markpublishstatus='R') and (a.examschedulestatus='P' or a.examschedulestatus='A' or a.examschedulestatus='R') order by a.subjectscheduleid";
			// select_query="select a.examscheduleid,a.subjectscheduleid as
			// examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y')
			// as
			// examdate,a.examtimein,a.examtimeout,b.examallotmentid,a.examschedulestatus
			// from examallotment b join subjectschedule c on
			// b.standardscheduleid='"+standardscheduleid+"' and
			// b.examnameid='"+examnameid+"' and
			// b.standardscheduleid=c.standardscheduleid and
			// b.examallotmentstatus='A' and c.status='A' join subject d on
			// c.subjectid=d.subjectid and d.subjectstatus='A' join examschedule
			// a on c.subjectscheduleid=a.subjectscheduleid and
			// b.examallotmentid=a.examallotmentid and a.exampublishstatus='A'
			// and a.markpublishstatus='P' and (a.examschedulestatus='P' or
			// a.examschedulestatus='A') order by a.subjectscheduleid";
			log.info(select_query);
			//System.out.println(select_query);
			periodsList = common_data_object.getListMap(select_query);

		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}
	
	
	public ArrayList listSections(String standardscheduleid) {
		
		ArrayList valueList = null;
		try {
			String select_query = "select sectionscheduleid,sectionname from sectionschedule a,section b where standardscheduleid='"+standardscheduleid+"' and sectionschedulestatus='A' and a.sectionid=b.sectionid and b.status='A'";
			valueList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception e) {
		}
		return valueList;

	}
	public ArrayList listStandard(String sessionid, String boardid) {
		log
				.info("Invoking listStandard() for list the standard based on te sessionid and boardid");
		ArrayList valueList = null;
		try {
			String select_query = "select b.standardid,b.standardname,a.standardscheduleid,a.groupid,b.groupstatus,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid)  end as groupname from standardschedule a,standard b where a.sessionid='"
					+ sessionid
					+ "' and b.boardid='"
					+ boardid
					+ "' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A'  order by b.standardid,a.groupid";
			valueList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception e) {
		}
		return valueList;

	}

	public ArrayList listStandardMarkPublished(String sessionid,
			String boardid, String examnameid) {
		log
				.info("Invoking listStandardMarkPublished(String sessionid,String boardid,String examnameid) for list the standard based on te sessionid and boardid");
		ArrayList valueList = null;
		try {
			String select_query = "select distinct e1.standardscheduleid,case when e1.groupid is null then d1.standardname else concat(d1.standardname,'-',(select groupname from standardgroup where e1.groupid=groupid)) end as standardname from examallotment b1, examschedule c1,standard d1,standardschedule e1 where e1.sessionid='"
					+ sessionid
					+ "' and b1.examnameid='"
					+ examnameid
					+ "' and b1.examallotmentstatus='A' and b1.examallotmentid=c1.examallotmentid and c1.exampublishstatus='R' and c1.markpublishstatus='R' and c1.examschedulestatus='R' and d1.standardid=e1.standardid and d1.boardid='"
					+ boardid
					+ "' and d1.standardstatus='A' and e1.stdschedulestatus='A' and e1.standardscheduleid=b1.standardscheduleid";
			valueList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception e) {
		}
		return valueList;

	}

	public String LoadStandardMaxMark(String standardscheduleid) {
		log.info("Invoking LoadStandardMaxMark to load  totalmark of standard");
		String total = null;
		try {
			String select_query = "select sum(a.theoryexternalmax)	from subjectschedule a,subject b where a.standardscheduleid='"
					+ standardscheduleid
					+ "'	and a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A'";
			total = common_data_object.getSingleColumn(select_query);
			log.info(select_query);
		} catch (Exception e) {
		}
		return total;

	}

	public ArrayList LoadStudentMarkList(String studentallocationid,
			String examallotmentid, String status) {
		log
				.info("Invoking LoadStudentMarkList() for list the student marklist");
		ArrayList valueList = null;
		try {
			// String qry = "select
			// d.subjectname,d.subjectcode,c.theoryinternalmin,c.theoryinternalmax,c.theoryexternalmin,c.theoryexternalmax,a.marktaken,a.staffremarks,a.comboremarks
			// from exammark a,examschedule b,subjectschedule c,subject
			// d,examallotment e where
			// a.studentallocationid='"+studentallocationid+"' and
			// e.examallotmentid=b.examallotmentid and e.examnameid='"+examnameid+"'
			// and a.markstatus='A' and b.examscheduleid=a.examscheduleid and
			// b.examschedulestatus='A' and b.subjectscheduleid=c.subjectscheduleid
			// and c.subjectid=d.subjectid and d.subjectstatus='A' and c.status='A'
			// order by d.subjectcode";
			String qry = "select d.subjectname,d.subjectcode,c.theoryinternalmin,c.theoryinternalmax,c.theoryexternalmin,c.theoryexternalmax,a.marktaken,a.staffremarks,a.comboremarks  from exammark a,examschedule b,subjectschedule c,subject d,examallotment e  where a.studentallocationid='"
					+ studentallocationid
					+ "' and e.examallotmentid=b.examallotmentid and e.examallotmentid='"
					+ examallotmentid
					+ "' and a.markstatus='A' and b.examscheduleid=a.examscheduleid and b.examschedulestatus='R' and b.subjectscheduleid=c.subjectscheduleid and c.subjectid=d.subjectid and d.subjectstatus='A' and c.status='A' order by d.subjectcode";
			valueList = common_data_object.getListMap(qry);
			log.info(qry);
		} catch (Exception e) {
		}
		return valueList;

	}

	/**
	 * Created by subhash to load the exam mark after it is published Accessed from
	 * jsp/Exam/ExamMark/ExammarkforStudent.jsp Accessed from
	 * jsp/Principal/ExammarkforPrincipal.jsp
	 * 
	 * @param Passing
	 *            studentallocationid,examnameid
	 * @return ArrayList by which result can be printed on the screen
	 */

	public ArrayList LoadStudentMarkList(String studentallocationid,
			String examnameid) {
		log
				.info("Invoking LoadStudentMarkList() for list the student marklist");
		ArrayList valueList = null;
		try {
			// String qry = "select
			// d.subjectname,d.subjectcode,c.theoryinternalmin,c.theoryinternalmax,c.theoryexternalmin,c.theoryexternalmax,a.marktaken,a.staffremarks,a.comboremarks
			// from exammark a,examschedule b,subjectschedule c,subject
			// d,examallotment e where
			// a.studentallocationid='"+studentallocationid+"' and
			// e.examallotmentid=b.examallotmentid and e.examnameid='"+examnameid+"'
			// and a.markstatus='A' and b.examscheduleid=a.examscheduleid and
			// (b.examschedulestatus='A' or b.examschedulestatus='R') and
			// b.subjectscheduleid=c.subjectscheduleid and c.subjectid=d.subjectid
			// and d.subjectstatus='A' and c.status='A' order by d.subjectcode";
			String qry = "select d.subjectname,d.subjectcode,c.theoryinternalmin,c.theoryinternalmax,c.theoryexternalmin,c.theoryexternalmax,a.marktaken,a.staffremarks,(select f.remarkstatusname from facultyremarksstatus f where f.fremarkstatusid = a.comboremarks and f.remarkstatus='A') as comboremarks  from exammark a,examschedule b,subjectschedule c,subject d,examallotment e  where a.studentallocationid='"
					+ studentallocationid
					+ "' and e.examallotmentid=b.examallotmentid and e.examnameid='"
					+ examnameid
					+ "' and a.markstatus='A' and b.examscheduleid=a.examscheduleid and b.examschedulestatus='R' and b.subjectscheduleid=c.subjectscheduleid and c.subjectid=d.subjectid and d.subjectstatus='A' and c.status='A' order by d.subjectcode";
			// System.out.print("qry-->"+qry);
			valueList = common_data_object.getListMap(qry);
			log.info(qry);
		} catch (Exception e) {
		}
		return valueList;

	}

	public ArrayList listStandardforexam(String sessionid, String boardid,
			String examnameid) {
		log.info("Invoking listStandardforexam() for list the standard");

		ArrayList valueList = null;
		try {
			String select_query = "select distinct b.standardid,b.standardname,a.standardscheduleid,a.groupid,b.groupstatus,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid)  end as groupname from standardschedule a,standard b,examallotment c where a.sessionid='"
					+ sessionid
					+ "' and b.boardid='"
					+ boardid
					+ "' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A' and a.standardscheduleid=c.standardscheduleid and examnameid='"
					+ examnameid + "' order by b.standardid,a.groupid";
			valueList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return valueList;

	}

	public ArrayList checksubjectschedulestatus(String subjectscheduleid) {
		log
				.info("Invoking loadScheduledSubjects() for Load loadsubschedulestatus");
		ArrayList periodsList = null;
		try {
			select_query = "select a.subjectscheduleid,b.examdate from subjectschedule a,examschedule b where a.subjectscheduleid=b.subjectscheduleid and examschedulestatus='A' and a.subjectscheduleid='"
					+ subjectscheduleid + "'";
			periodsList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	/**
	 * This method is accessed from kycportal/jsp/Reports/ExamViewpreview.jsp
	 * 
	 * @param instituteid
	 *            that can be used to get all BoardList from standardmedium, table
	 *            by instituteid, sessionid,boardid wise;
	 * 
	 * @return ArrayList by which result can be printed on the screen ( accessed by
	 *         _prasanth)
	 */
	public ArrayList LoadBoardList(String instituteid) {
		ArrayList boardList = new ArrayList();
		try {
			select_query = "select a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b where a.mediumid=b.mediumid and a.instituteid='"
					+ instituteid
					+ "' and a.boardstatus='A' and b.mediumstatus='A' order by a.boardid,b.mediumid";
			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from kycportal/jsp/Reports/ExamViewpreview.jsp
	 * 
	 * @param instituteid
	 *            that can be used to get all BoardList from standardmedium,
	 *            table by instituteid, sessionid,boardid wise;
	 * 
	 * @return ArrayList by which result can be printed on the screen ( accessed
	 *         by _prasanth)
	 */
	public ArrayList loadBoardListMarkPublished(String instituteid,
			String sessionid) {
		ArrayList boardList = null;
		try {
			select_query = "select distinct a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b, standard c,standardschedule d where a.mediumid=b.mediumid and a.instituteid='"
					+ instituteid
					+ "' and a.boardstatus='A' and b.mediumstatus='A' and c.boardid=a.boardid and c.standardstatus='A' and c.standardid=d.standardid and d.standardscheduleid in (select b1.standardscheduleid from examname a1,examallotment b1, examschedule c1 where a1.sessionid='"
					+ sessionid
					+ "' and a1.examnamestatus='A' and a1.examnameid=b1.examnameid and b1.examallotmentstatus='A' and b1.examallotmentid=c1.examallotmentid and c1.exampublishstatus='R' and c1.markpublishstatus='R' and c1.examschedulestatus='R')";
			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	public ArrayList LoadsectionwiseStudentList(String sectionscheduleid) {
		ArrayList boardList = new ArrayList();
		try {
			select_query = "select a.studentallocationid,a.rollno,concat(c.firstname,' ', c.middlename,' ', c.lastname) as studentname from studentallocation a,candidateregister b,personmaster c where a.sectionscheduleid='"
					+ sectionscheduleid
					+ "' and a.candidateregisterid=b.candidateregisterid and b.personid=c.personid and a.rollno is not null and a.studentallocationstatus not in ('T','X')";
			boardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	public ArrayList LoadsectionwiseStudentListformark(
			String subjectscheduleid, String examscheduleid,
			String sectionscheduleid) {
		ArrayList boardList = new ArrayList();
		try {
			// select_query = "select case when middlename='-' or middlename='' or
			// middlename is null then concat(prefix,firstname,' ',lastname) else
			// concat(prefix,firstname,' ',middlename,' ',lastname) end as
			// studentname,b.rollno,a.marktaken,a.staffremarks,(select
			// f.remarkstatusname from facultyremarksstatus f where
			// f.fremarkstatusid = a.comboremarks and f.remarkstatus='A') as
			// comboremarks,a.exammarkid,a.studentallocationid,b.studentallocationid
			// as studallocid,c.examscheduleid from candidateregister d,personmaster
			// e,exammark a join examschedule c on c.examscheduleid=a.examscheduleid
			// and subjectscheduleid='"+subjectscheduleid+"' and
			// a.examscheduleid='"+examscheduleid+"' and a.markstatus='A' right
			// outer join studentallocation b on
			// a.studentallocationid=b.studentallocationid where
			// sectionscheduleid='"+sectionscheduleid+"' and
			// studentallocationstatus='A' and
			// d.candidateregisterid=b.candidateregisterid and d.personid=e.personid
			// and d.candidateregisterstatus='A' order by rollno";
			select_query = "select case when middlename='-' or middlename='' or middlename  is null then concat(prefix,firstname,' ',lastname) else concat(prefix,firstname,' ',middlename,' ',lastname) end as  studentname,b.rollno,a.marktaken,a.staffremarks,(select f.remarkstatusname from facultyremarksstatus f where f.fremarkstatusid = a.comboremarks and f.remarkstatus='A') as comboremarks,a.exammarkid,a.studentallocationid,b.studentallocationid as studallocid,c.examscheduleid,(select concat(c1.prefix,' ',c1.firstname,' ',case when c1.middlename is null or c1.middlename='' then '' else c1.middlename end,c1.lastname) from login a1, staffmaster b1,personmaster c1 where a1.userid=a.createdby and a1.userid=b1.userid and c1.personid=a1.personid) as staffname,a.createdby from candidateregister d,personmaster e,exammark a join examschedule c on c.examscheduleid=a.examscheduleid and  subjectscheduleid='"
					+ subjectscheduleid
					+ "' and a.examscheduleid='"
					+ examscheduleid
					+ "' and a.markstatus='A' right outer join studentallocation b on a.studentallocationid=b.studentallocationid where sectionscheduleid='"
					+ sectionscheduleid
					+ "' and studentallocationstatus='A' and d.candidateregisterid=b.candidateregisterid and d.personid=e.personid and d.candidateregisterstatus='A' order by rollno";

			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
			// System.out.println("select_query-->"+select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	public ArrayList LoadAllotedExamnameList(String sessionid) {
		log
				.info("Invoking LoadAllotedExamnameList() for Loading the alloted ExamnameList");
		ArrayList boardList = new ArrayList();
		try {
			select_query = "select distinct b.examnameid,b.examname from examallotment a,examname b where a.examnameid=b.examnameid and b.sessionid='"
					+ sessionid + "'";
			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	public ArrayList loadExamNameMarkPublished(String sessionid, String boardid) {
		log
				.info("Invoking loadExamNameMarkPublished(String sessionid,String boardid) for Loading the alloted ExamnameList");
		ArrayList boardList = new ArrayList();
		try {
			select_query = "select distinct a1.examnameid,a1.examname from examname a1,examallotment b1, examschedule c1,standard d1,standardschedule e1 where a1.sessionid='"
					+ sessionid
					+ "' and a1.examnamestatus='A' and a1.examnameid=b1.examnameid and b1.examallotmentstatus='A' and b1.examallotmentid=c1.examallotmentid and c1.exampublishstatus='R' and c1.markpublishstatus='R' and c1.examschedulestatus='R' and a1.sessionid=e1.sessionid and d1.standardid=e1.standardid and d1.boardid='"
					+ boardid
					+ "' and d1.standardstatus='A' and e1.stdschedulestatus='A'  and e1.standardscheduleid=b1.standardscheduleid";
			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	public ArrayList LoadExamnameListforStudent(String standardscheduleid) {
		log
				.info("Invoking LoadExamnameListforStudent() for Loading the alloted ExamnameList for students");
		ArrayList boardList = new ArrayList();
		try {
			select_query = "select a.examname,a.examnameid from examname a,examallotment b where a.examnameid=b.examnameid and b.standardscheduleid ='"
					+ standardscheduleid + "'";
			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	// modified by subhash for archived sessionstatus R
	public ArrayList LoadExamnameList(String sessionid) {
		log
				.info("Invoking LoadExamnameList() for Loading the alloted ExamnameList for students");
		ArrayList boardList = new ArrayList();
		try {
			select_query = "select a.examnameid,a.examname,b.sessionid from examname a, yearofsession b where a.sessionid=b.sessionid and a.instituteid=b.instituteid and  a.sessionid='"
					+ sessionid
					+ "' and a.examnamestatus='A' and (b.sessionstatus='A' or b.sessionstatus='R')";
			// select_query = "select
			// c.examallotmentid,a.examnameid,a.examname,b.sessionid from
			// examname a, yearofsession b,examallotment c where
			// a.sessionid=b.sessionid and a.instituteid=b.instituteid and
			// c.examnameid=a.examnameid and c.examallotmentstatus='A' and
			// a.sessionid='"+sessionid+"' and a.examnamestatus='A'
			// and(b.sessionstatus='A' or b.sessionstatus='R')";

			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	// prasanth need to be add in examlist archival -
	public ArrayList LoadExamnameListarchive(String sessionid) {
		log
				.info("Invoking LoadExamnameList() for Loading the alloted ExamnameList for students");
		ArrayList boardList = new ArrayList();
		try {

			select_query = "select c.examallotmentid,a.examnameid,a.examname,b.sessionid from examname a, yearofsession b,examallotment c where a.sessionid=b.sessionid and a.instituteid=b.instituteid and c.examnameid=a.examnameid and c.examallotmentstatus='A' and a.sessionid='"
					+ sessionid
					+ "' and a.examnamestatus='A' and(b.sessionstatus='A' or b.sessionstatus='R')";

			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from kycportal/jsp/principal/ExamView.jsp
	 * 
	 * @param sessionid
	 *            that can be used to get all exam names from examname table by
	 *            sessionid wise;
	 * 
	 * @return ArrayList by which result can be printed on the screen ( accessed by
	 *         _prasanth)
	 */
	public ArrayList LoadExamnameList_pdf(String sessionid) {
		log
				.info("Invoking LoadExamnameList() for Loading the alloted ExamnameList for students");
		ArrayList boardList = new ArrayList();
		try {
			// select_query = "select a.examnameid,a.examname,b.sessionid from
			// examname a, yearofsession b where a.sessionid=b.sessionid and
			// a.instituteid=b.instituteid and a.sessionid='"+sessionid+"' and
			// a.examnamestatus='A' and (b.sessionstatus='A' or
			// b.sessionstatus='R')";
			select_query = "select c.examallotmentid,a.examnameid,a.examname,b.sessionid from examname a, yearofsession b,examallotment c where a.sessionid=b.sessionid and a.instituteid=b.instituteid and c.examnameid=a.examnameid and c.examallotmentstatus='A' and a.sessionid='"
					+ sessionid
					+ "' and a.examnamestatus='A' and(b.sessionstatus='A' or b.sessionstatus='R')";

			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from com/igrandee/Reports/ExamDetailspdf.java
	 * 
	 * @param instituteid,
	 *            sessionid,boardid that can be used to get all exam details from
	 *            examname table by instituteid, sessionid,boardid wise;
	 * 
	 * @return ArrayList by which result can be printed on the screen _prasanth
	 */

	public ArrayList LoadExamnameListRK(String instituteid, String sessionid,
			String boardid) {
		ArrayList boardList = new ArrayList();
		try {

			select_query = "select distinct a.examnameid,a.examname,b.sessionid from examname a, yearofsession b,standardschedule c, standard d where a.sessionid=b.sessionid and c.sessionid=b.sessionid and c.standardid=d.standardid and a.instituteid=b.instituteid and  a.sessionid='"
					+ sessionid
					+ "' and d.boardid='"
					+ boardid
					+ "'  and a.examnamestatus='A' and  b.sessionstatus='R' and c.stdschedulestatus='A' and d.standardstatus='A'";

			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from com/igrandee/Reports/ExamDetailspdfstdwise.java
	 * 
	 * @param instituteid,
	 *            sessionid,boardid,standardscheduleid that can be used to get all
	 *            exam details from examname table by instituteid,
	 *            sessionid,boardid,standardscheduleid wise;
	 * 
	 * @return ArrayList by which result can be printed on the screen _prasanth
	 */
	public ArrayList LoadExamnameListRKbystdwise(String instituteid,
			String sessionid, String boardid) {
		ArrayList boardList = new ArrayList();
		try {
			// select_query = "select b.standardscheduleid,a.standardname,
			// c.examallotmentid,d.examnameid,d.examname,
			// g.subjectname,e.examtimein,e.examtimeout,e.examdate,date_format(e.examdate,'%d-%m-%Y')
			// as examdate from standard a,standardschedule b,examallotment
			// c,examname d,examschedule e, subjectschedule f,subject g where
			// a.boardid='"+boardid+"' and b.sessionid='"+sessionid+"' and
			// a.standardid=b.standardid and a.standardstatus='A' and
			// b.stdschedulestatus='A' and b.standardscheduleid=c.standardscheduleid
			// and c.examallotmentstatus='A' and c.examnameid=d.examnameid and
			// d.examnamestatus='A' and c.examallotmentid=e.examallotmentid and
			// e.examschedulestatus='R' and e.subjectscheduleid=f.subjectscheduleid
			// and f.status='A' and f.subjectid=g.subjectid and g.subjectstatus='A'
			// order by b.standardscheduleid,d.examnameid;";
			select_query = "select b.standardscheduleid,a.standardname, c.examallotmentid,d.examnameid,d.examname, g.subjectname,e.examtimein,REPLACE(TIME_FORMAT(e.examtimein,'%r'),':00 ',' ') as examtimeinampm,e.examtimeout,REPLACE(TIME_FORMAT(e.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(e.examtimeout,e.examtimein),1,5) AS duration,e.examdate,date_format(e.examdate,'%d-%m-%Y') as examdate,e.examtype from standard a,standardschedule b,examallotment c,examname d,examschedule e, subjectschedule f,subject g where a.boardid='"
					+ boardid
					+ "' and b.sessionid='"
					+ sessionid
					+ "' and a.standardid=b.standardid and a.standardstatus='A' and b.stdschedulestatus='A'  and b.standardscheduleid=c.standardscheduleid and c.examallotmentstatus='A' and c.examnameid=d.examnameid and d.examnamestatus='A' and c.examallotmentid=e.examallotmentid and e.examschedulestatus='R' and e.subjectscheduleid=f.subjectscheduleid and f.status='A' and f.subjectid=g.subjectid and g.subjectstatus='A' order by b.standardscheduleid,d.examnameid";
			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
			// System.out.println("=========>>>>>>>>>>>>>>."+select_query);

		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from com/igrandee/Reports/ExamDetailspdf.java
	 * 
	 * @param instituteid,
	 *            sessionid,boardid that can be used to get all exam details from
	 *            examname table by instituteid, sessionid,boardid wise;
	 * 
	 * @return ArrayList by which result can be printed on the screen _prasanth
	 */

	public ArrayList LoadExamnameListRKbystandard(String instituteid,
			String sessionid, String boardid, String reg_standardid) {
		ArrayList boardList = new ArrayList();
		try {
			select_query = " select distinct e.examallotmentid,a.examnameid,a.examname,b.sessionid from examname a,  yearofsession b,standard c,board d ,examallotment e,standardschedule f where a.sessionid=b.sessionid and f.standardid=c.standardid and  a.instituteid=b.instituteid and  a.instituteid='"
					+ instituteid
					+ "' and b.sessionid='"
					+ sessionid
					+ "' and c.boardid='"
					+ boardid
					+ "' and e.examnameid=a.examnameid and c.standardstatus='A' and f.stdschedulestatus='A'  and c.boardid=d.boardid and a.examnamestatus='A' and b.sessionstatus='R' and a.instituteid=c.instituteid and d.boardstatus='A' and e.examallotmentstatus='A'";
			boardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from com/igrandee/Reports/Reports/ExamDetailspdf.java
	 * 
	 * @param examallotmentid
	 *            that can be used to get all exam Subject details from examname
	 *            table by examallotmentid wise;
	 * 
	 * @return ArrayList by which result can be printed on the screen _prasanth
	 */

	public ArrayList LoadExamSubjectList(String examid, String sessionid) {
		log
				.info("Invoking LoadAllotedExamnameList() for Loading the alloted ExamnameList");
		ArrayList boardList = new ArrayList();
		try {
			// select_query = "SELECT
			// sts.standardscheduleid,date_format(es.examdate,'%d-%b-%Y') as
			// examdate, es.examtimein, es.examtimeout, (select groupname from
			// standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as
			// groupname ,st.standardname,sub.subjectname FROM examschedule es join
			// subjectschedule ss on es.subjectscheduleid=ss.subjectscheduleid and
			// ss.status='A' and exampublishstatus='R' and markpublishstatus='R' and
			// examschedulestatus='R' join standardschedule sts on
			// sts.standardscheduleid=ss.standardscheduleid and
			// stdschedulestatus='A' and sts.sessionid='"+sessionid+"' join
			// examallotment e on es.examallotmentid=e.examallotmentid and
			// examnameid='"+examid+"' and examallotmentstatus='A' join standard st
			// on st.standardid=sts.standardid and st.standardstatus='A' join
			// subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'";
			select_query = "SELECT sts.standardscheduleid,date_format(es.examdate,'%d-%b-%Y') as examdate, es.examtimein, REPLACE(TIME_FORMAT(es.examtimein,'%r'),':00 ',' ') as examtimeinampm,es.examtimeout,es.examtype,REPLACE(TIME_FORMAT(es.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(es.examtimeout,es.examtimein),1,5) AS duration, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and exampublishstatus='R' and  markpublishstatus='R' and examschedulestatus='R' join standardschedule sts on sts.standardscheduleid=ss.standardscheduleid and stdschedulestatus='A' and sts.sessionid='"
					+ sessionid
					+ "' join examallotment e on es.examallotmentid=e.examallotmentid and  examnameid='"
					+ examid
					+ "' and examallotmentstatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'";
			boardList = common_data_object.getListMap(select_query);
			log.info("Exam name QUERY::>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from
	 * com/igrandee/Reports/Reports/ExamDetailspdfstdwise.java
	 * 
	 * @param examallotmentid
	 *            that can be used to get all exam Subject details from examname
	 *            table by examallotmentid,standardscheduleid wise;
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all exam Subject details from examname
	 *            table by examallotmentid,standardscheduleid wise;
	 */
	public ArrayList LoadExamSubjectListstdwise(String examallotmentid,
			String standardscheduleid) {
		log
				.info("Invoking LoadAllotedExamnameList() for Loading the alloted ExamnameList");
		ArrayList boardList = new ArrayList();
		try {
			select_query = "SELECT sts.standardscheduleid,date_format(es.examdate,'%d-%m-%Y') as examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and es.examallotmentid='"
					+ examallotmentid
					+ "' and exampublishstatus='A' and  markpublishstatus='A' and examschedulestatus='A' join standardschedule sts on sts.standardscheduleid=ss.standardscheduleid and sts.standardscheduleid='"
					+ standardscheduleid
					+ "' and stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join examallotment sty on sty.examallotmentid=es.examallotmentid and sty.examallotmentstatus='A' order by sts.standardscheduleid";
			boardList = common_data_object.getListMap(select_query);
			log.info("Exam name QUERY::>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	public ArrayList loadgroupedStandards(String boardid, String sessionid) {
		log
				.info("Invoking loadgroupedStandards() for Loading the Boardwise Grouped standards");
		ArrayList groupedStandardList = null;
		try {
			select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname  from standardschedule a,standard b where a.standardid=b.standardid  and b.boardid='"
					+ boardid
					+ "' and b.standardstatus='A' and a.stdschedulestatus='A' and a.sessionid='"
					+ sessionid + "' order by a.standardid ";
			groupedStandardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return groupedStandardList;
	}

	/*
	 * Created By Kumaran ramu For Standard Topper and Weaker List
	 */

	public ArrayList standardTopperWeekerList(String standardid, String examid,
			String status, String number) {
		log
				.info("Invoking standardTopperWeekerList() for Loading Topper Weeker List");
		ArrayList groupedStandardList = null;
		try {
			select_query = "select count(b.studentallocationid) as totalstudents, concat(firstname,' ',lastname) as studentname, case when b.rollno is null then 'Not Yet Generated' else b.rollno end as rollno, sum(marktaken) as totalmark, b.studentallocationid from sectionschedule a join studentallocation b on a.standardscheduleid='"
					+ standardid
					+ "' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus in ('A','D') join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"
					+ examid
					+ "' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.exampublishstatus='R' and f.markpublishstatus='R' and f.examschedulestatus='R' join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid group by b.studentallocationid order by totalmark "
					+ status;
			groupedStandardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	public String studentsCount(String standardid) {
		log
				.info("Invoking studentsCount(String standardid) for Loading Topper Weeker List");
		String count = null;
		try {
			select_query = "select count(b.studentallocationid) as totalstudents from sectionschedule a join studentallocation b on a.standardscheduleid='"
					+ standardid
					+ "' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus='A'";
			count = common_data_object.getString(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return count;
	}

	public String studentsCount(String standardscheduleid, String examnameid) {
		log
				.info("Invoking studentsCount(String standardid,String exmscheduleid) for Loading Topper Weeker List");
		String count = null;
		try {
			select_query = "select count(distinct h.studentallocationid) as totalstudents from standardschedule a join sectionschedule b on a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A' and b.sectionschedulestatus='A' join studentallocation c on b.standardscheduleid='"
					+ standardscheduleid
					+ "' and c.sectionscheduleid=b.sectionscheduleid and c.studentallocationstatus='A' join subjectschedule d on d.standardscheduleid=a.standardscheduleid join examname e on e.sessionid=a.sessionid and e.examnamestatus='A' and e.examnameid='"
					+ examnameid
					+ "' join examallotment f on f.examnameid=e.examnameid and f.examallotmentstatus='A' join examschedule g on g.examallotmentid=f.examallotmentid and g.examschedulestatus='R' join exammark h on h.examscheduleid=g.examscheduleid and h.studentallocationid=c.studentallocationid and h.markstatus='A'";
			count = common_data_object.getString(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return count;
	}

	/*
	 * Created By Kumaran ramu For Standard Topper and Weaker List
	 */

	public String getGradeSystem(String sessionid, String mark) {
		log.info("Invoking getGradeSystem() for Loading Topper Weeker List");
		String grade = null;
		try {
			select_query = "select gradename from gradesystem where sessionid='"
					+ sessionid
					+ "' and gradesystemstatus='A' and ("
					+ mark
					+ " between rangefrom and rangeto)";
			grade = common_data_object.getString(select_query);
			log.info("======>>>>>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return grade;
	}

	/*
	 * Created By Kumaran ramu For Subject Topper and Weaker List
	 */

	public ArrayList subjectTopperWeekerList(String standardid, String examid,
			String status, String number, String subjectid) {
		log
				.info("Invoking standardTopperWeekerList() for Loading Topper Weeker List");
		ArrayList groupedStandardList = null;
		try {
			// select_query = "select concat(firstname,' ',lastname) as
			// studentname,case when b.rollno is null then 'Not Yet Generated'
			// else b.rollno end as rollno,sum(marktaken) as totalmark,
			// b.studentallocationid from sectionschedule a join
			// studentallocation b on a.standardscheduleid='"+standardid+"' and
			// a.sectionscheduleid=b.sectionscheduleid and
			// a.sectionschedulestatus='A' and b.studentallocationstatus='A'
			// join candidateregister c on
			// b.candidateregisterid=c.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster d on
			// c.personid=d.personid and d.status='A' join examallotment e on
			// e.examnameid='"+examid+"' and
			// a.standardscheduleid=e.standardscheduleid and
			// e.examallotmentstatus='A' join examschedule f on
			// e.examallotmentid=f.examallotmentid and f.exampublishstatus='R'
			// and f.markpublishstatus='R' and f.examschedulestatus='R' and
			// f.subjectscheduleid='"+subjectid+"' left outer join exammark g on
			// f.examscheduleid=g.examscheduleid and g.markstatus='A' and
			// b.studentallocationid=g.studentallocationid group by
			// b.studentallocationid order by totalmark "+status;
			select_query = "select concat(firstname,' ',lastname) as studentname,case when b.rollno is null then 'Not Yet Generated' else b.rollno end as rollno,sum(marktaken) as totalmark, b.studentallocationid from sectionschedule a join studentallocation b on a.standardscheduleid='"
					+ standardid
					+ "' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus='A' join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"
					+ examid
					+ "' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.exampublishstatus='R' and f.markpublishstatus='R' and f.examschedulestatus='R'  and f.subjectscheduleid='"
					+ subjectid
					+ "' join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid group by b.studentallocationid order by totalmark "
					+ status;
			groupedStandardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	/**
	 * Created By prasanth For Subject Topper and Weaker List
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all subject Topper WeekerList Multisubject
	 *            from examname table ;
	 * 
	 * @param examnameid
	 *            that can be used to get all subject Topper WeekerList Multisubject
	 *            from examname table ;
	 * 
	 * @param status
	 *            which measured topprtlist or weakerlist ;
	 * 
	 * @param number
	 *            that is used to list how much number of students should be display ;
	 * 
	 * @param subjectid
	 *            that can be used to get all subject Topper WeekerList Multisubject
	 *            from examname table ;
	 * 
	 */
	public ArrayList subjectTopperWeekerListMultisubject(
			String standardscheduleid, String examnameid, String status,
			String number, String subjectid) {
		log
				.info("Invoking standardTopperWeekerList() for Loading Topper Weeker List");
		ArrayList groupedStandardList = null;
		try {
			// select_query = "select
			// ss.subjectscheduleid,s.subjectname,g.marktaken,concat(firstname,'
			// ',lastname) as studentname,case when b.rollno is null then 'Not
			// Yet Generated' else b.rollno end as rollno, b.studentallocationid
			// from sectionschedule a join studentallocation b on
			// a.standardscheduleid='"+standardid+"' and
			// a.sectionscheduleid=b.sectionscheduleid and
			// a.sectionschedulestatus='A' and b.studentallocationstatus='A'
			// join candidateregister c on
			// b.candidateregisterid=c.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster d on
			// c.personid=d.personid and d.status='A' join examallotment e on
			// e.examnameid='"+examid+"' and
			// a.standardscheduleid=e.standardscheduleid and
			// e.examallotmentstatus='A' join examschedule f on
			// e.examallotmentid=f.examallotmentid and f.examschedulestatus='A'
			// left outer join exammark g on f.examscheduleid=g.examscheduleid
			// and g.markstatus='A' and
			// b.studentallocationid=g.studentallocationid join subjectschedule
			// ss on ss.status='A' and ss.subjectscheduleid in ('"+subjectid+"')
			// join subject s on s.subjectid=ss.subjectid order by
			// ss.subjectscheduleid,marktaken desc;";
			select_query = "SELECT distinct  concat(firstname,' ',lastname) as studentname,sa.rollno,sub.subjectname,em.marktaken, imagepath,ea.examnameid,ss.subjectscheduleid,en.examname FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and ea.examnameid='"
					+ examnameid
					+ "' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and ss.subjectscheduleid in ('"
					+ subjectid
					+ "') and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')  and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A'   join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'   left outer join  exammark em on em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c  on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and en.examnamestatus='A' order by ss.subjectscheduleid,em.marktaken "
					+ status + " ";

			groupedStandardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	/**
	 * Created By prasanth For Subject Topper and Weaker List
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all subject Topper WeekerList Multisubject
	 *            from examname table ;
	 * 
	 * @param examnameid
	 *            that can be used to get all subject Topper WeekerList Multisubject
	 *            from examname table ;
	 * 
	 * @param status
	 *            which measured topprtlist or weakerlist ;
	 * 
	 * @param number
	 *            that is used to list how much number of students should be display ;
	 * 
	 * @param subjectid
	 *            that can be used to get all subject Topper WeekerList Multisubject
	 *            from examname table ;
	 * 
	 */
	public ArrayList subjectTopperWeekerListMultisubjectIndividual(
			String standardscheduleid, String examnameid, String status,
			String number, String subjectid) {
		log
				.info("Invoking standardTopperWeekerList() for Loading Topper Weeker List");
		ArrayList groupedStandardList = null;
		try {
			// select_query = "SELECT distinct concat(firstname,' ',lastname) as
			// studentname,sa.rollno,sec.sectionname,sub.subjectname,em.marktaken,sa.studentallocationid,
			// imagepath,ea.examnameid,ss.subjectscheduleid,en.examname FROM
			// examschedule es join examallotment ea on
			// ea.standardscheduleid='"+standardscheduleid+"' and
			// ea.examnameid='"+examnameid+"' and examallotmentstatus='A' join
			// subjectschedule ss on es.subjectscheduleid=ss.subjectscheduleid
			// and ss.status='A' and ss.subjectscheduleid ='"+subjectid+"' and
			// es.examallotmentid=ea.examallotmentid and exampublishstatus in
			// ('A','R') and markpublishstatus in ('R','P') and
			// examschedulestatus in ('A','R') join standardschedule sts on
			// sts.standardscheduleid='"+standardscheduleid+"' and
			// sts.stdschedulestatus='A' join standard st on
			// st.standardid=sts.standardid and st.standardstatus='A' join
			// studentallocation sa on sa.studentallocationstatus='A' join
			// subject sub on sub.subjectid=ss.subjectid and
			// sub.subjectstatus='A' left outer join exammark em on
			// em.studentallocationid=sa.studentallocationid and
			// em.examscheduleid=es.examscheduleid and em.markstatus='A' join
			// candidateregister c on
			// c.candidateregisterid=sa.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster pm on
			// pm.personid=c.personid and pm.status='A' join examname en on
			// en.examnameid=ea.examnameid and en.examnamestatus='A' join
			// sectionschedule se on se.sectionscheduleid=sa.sectionscheduleid
			// and se.sectionschedulestatus='A' join section sec on
			// sec.status='A' and sec.sectionid=se.sectionid order by
			// em.marktaken "+status+" limit 0,"+number;
			select_query = "SELECT distinct  concat(firstname,' ',lastname) as studentname,sa.rollno,sec.sectionname,sub.subjectname,em.marktaken,sum(em.marktaken) as total,sa.studentallocationid, imagepath,ea.examnameid,ss.subjectscheduleid,en.examname FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and ea.examnameid='"
					+ examnameid
					+ "' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and ss.subjectscheduleid ='"
					+ subjectid
					+ "' and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A'   join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'   left outer join  exammark em on em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c  on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and en.examnamestatus='A' join sectionschedule se on se.sectionscheduleid=sa.sectionscheduleid and se.sectionschedulestatus='A' join section sec on sec.status='A' and sec.sectionid=se.sectionid group by sa.studentallocationid order by total "
					+ status + " limit 0," + number;

			// System.out.println("select_query"+select_query);
			groupedStandardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	/**
	 * Created By Maruthu For Subject mark range Wise student List
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all Subject mark rangeList from examname
	 *            table ;
	 * 
	 * @param examnameid
	 *            that can be used to get all Subject mark range list from examname
	 *            table ;
	 * 
	 * @param subjectid
	 *            that can be used to get all subject Topper WeekerList Multisubject
	 *            from examname table ;
	 * 
	 * @param from
	 *            that is used to list students above the given range ;
	 * 
	 * @param to
	 *            that is used to list students below the given range ;
	 * 
	 */
	public ArrayList subjectWiseStudentList(String standardscheduleid,
			String examnameid, String subjectid, String from, String to) {
		log.info("Invoking subjectWiseStudentList() for Loading Student List");
		ArrayList studList = null;
		try {
			connection = ConnectionManager.getKycConnection();
			select_query = "CREATE OR REPLACE view studentlist as  SELECT distinct  concat(firstname,' ',lastname) as studentname,sa.rollno,sec.sectionname,sub.subjectname,em.marktaken,sa.studentallocationid, ea.examnameid,ss.subjectscheduleid,en.examname FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and ea.examnameid='"
					+ examnameid
					+ "' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and ss.subjectscheduleid ='"
					+ subjectid
					+ "' and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A'   join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'   left outer join  exammark em on em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c  on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and en.examnamestatus='A' join sectionschedule se on se.sectionscheduleid=sa.sectionscheduleid and se.sectionschedulestatus='A' join section sec on sec.status='A' and sec.sectionid=se.sectionid group by sa.studentallocationid order by marktaken ";
			Statement stmt1 = connection.createStatement();
			stmt1.executeUpdate(select_query);
			String select_querynew = "select *,'"
					+ from
					+ " to "
					+ to
					+ "' as markrange  from studentlist where marktaken between "
					+ from + " and " + to;
			studList = common_data_object.getListMap(select_querynew);
			Statement stmt = connection.createStatement();
			stmt.executeUpdate("DROP VIEW IF EXISTS `kycportal`.`studentlist`");
			try {
				if (stmt1 != null)
					stmt1.close();
				/*
				 * if(stmt!=null) stmt.close();
				 */
				if (connection != null)
					connection.close();
			} catch (RuntimeException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} catch (Exception exception) {
			exception.printStackTrace();
			log.error("",exception);
		}
		return studList;
	}

	/**
	 * Created By prasanth For Subject Topper and Weaker List
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all subject Topper WeekerList Multisubject
	 *            from examname table ;
	 * 
	 * @param studentallocationid
	 *            that can be used to get all Multisubject subject Details from
	 *            examname,exammark table ;
	 * 
	 * @param examnameid
	 *            that can be used to get all examnames from examname table ;
	 * 
	 */
	public ArrayList getMarkDetailsForsinglestud(String standardscheduleid,
			String studentallocationid, String examnameid) {
		log
				.info("Invoking standardTopperWeekerList() for Loading Topper Weeker List");
		ArrayList groupedStandardList = null;
		try {
			select_query = "SELECT distinct  concat(firstname,' ',lastname) as studentname,sa.rollno,sec.sectionname,sub.subjectname,st.standardname,em.marktaken,sa.studentallocationid, imagepath,ea.examnameid,ss.subjectscheduleid,en.examname FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and ea.examnameid='"
					+ examnameid
					+ "' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A' and sa.studentallocationid='"
					+ studentallocationid
					+ "'   join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'   left outer join  exammark em on em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c  on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and en.examnamestatus='A' join sectionschedule se on se.sectionscheduleid=sa.sectionscheduleid and se.sectionschedulestatus='A' join section sec on sec.status='A' and sec.sectionid=se.sectionid ";
			groupedStandardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	/*
	 * Created By Kumaran ramu For Subject Scheduled
	 */

	public ArrayList subjectsScheduled(String standardid) {
		log.info("Invoking subjectsScheduled() for Loading Scheduled Subjects");
		ArrayList groupedStandardList = null;
		try {
			select_query = "select a.subjectscheduleid,subjectname,a.theoryexternalmax from subjectschedule a,subject b where a.standardscheduleid='"
					+ standardid
					+ "' and a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A'";
			groupedStandardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	public ArrayList loadgroupedStandardsforexamallotment(String examnameid,
			String sessionid, String boardid) {
		log
				.info("Invoking loadgroupedStandardsforexamallotment() for Loading the Boardwise Grouped standards");
		ArrayList groupedStandardList = null;
		try {
			select_query = "select c.boardid,b.standardscheduleid,c.standardid,a.standardscheduleid  as examstandschid,c.standardname,(select groupname from standardgroup x where x.groupid=b.groupid) as groupname,a.examallotmentid from standard c,examname x1 join examallotment a on  x1.examnameid=a.examnameid and a.examnameid='"
					+ examnameid
					+ "' right outer join standardschedule b on a.standardscheduleid=b.standardscheduleid where b.sessionid='"
					+ sessionid
					+ "' and c.standardid=b.standardid and c.boardid='"
					+ boardid + "' order by c.standardid";
			groupedStandardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return groupedStandardList;
	}

	public int insertExamAllotment(String examnameid, String[] chkBoxId,
			String allotedby, String instituteid) throws SQLException,
			Exception {
		log
				.info("Invoking insertExamAllotment() for inserting the exam allotment");
		connection = ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);

		PreparedStatement examallot = null;
		PreparedStatement allotid = null;
		ResultSet allotrs = null;
		long examallotmentid = 0l;

		String curTime = DateTime.showTime("MySqlWithTime");

		try {

			allotid = connection
					.prepareStatement("select max(examallotmentid) from examallotment");
			allotrs = allotid.executeQuery();

			if (allotrs.next())
				examallotmentid = allotrs.getLong(1);
			examallotmentid++;

			examallot = connection
					.prepareStatement("insert into examallotment(examallotmentid,examnameid,standardscheduleid,allotedby,alloteddate,examallotmentstatus)values(?,?,?,?,?,?)");

			if (chkBoxId != null && chkBoxId.length > 0) {

				for (int j = 0; j < chkBoxId.length; j++) {
					String[] standardscheduleid = chkBoxId[j].split("@");
					examallot.setLong(1, examallotmentid);
					examallot.setString(2, examnameid);
					examallot.setString(3, standardscheduleid[0]);
					examallot.setString(4, allotedby);
					examallot.setString(5, curTime);
					examallot.setString(6, "A");
					return_value += examallot.executeUpdate();
					examallotmentid++;
				}
			}

			int temp[] = null;
			temp = examallot.executeBatch();
			if (temp != null && temp.length > 0)
				for (int y = 0; y < temp.length; y++)
					return_value += temp[y];
			connection.commit();
		} catch (SQLException sqlexception) {

			sqlexception.printStackTrace();
			if (connection != null)
				connection.rollback();
			return_value = 0;

		}

		finally {

			if (allotrs != null)
				allotrs.close();

			if (allotid != null)
				allotid.close();

			if (examallot != null)
				examallot.close();

			if (connection != null)
				connection.close();

		}
		return return_value;
	}

	public int scheduleExams(String[] checkstandard, String examallotmentid,
			String allotedby, String instituteid, String[] starts,
			String[] starttime, String[] endtime, String[] examtype)
			throws SQLException, Exception {
		log.info("Invoking scheduleExams() for inserting the exam schedule");
		connection = ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);

		PreparedStatement examschprepare = null;
		PreparedStatement allotid = null;
		ResultSet allotrs = null;
		DateTime datetime = new DateTime();
		long createdby = 0L;
		long examscheduleid = 0l;

		String curTime = DateTime.showTime("MySqlWithTime");

		try {

			allotid = connection
					.prepareStatement("select max(examscheduleid) from examschedule");
			allotrs = allotid.executeQuery();

			if (allotrs.next())
				examscheduleid = allotrs.getLong(1);
			examscheduleid++;

			examschprepare = connection
					.prepareStatement("insert into examschedule(examscheduleid, examallotmentid, subjectscheduleid, examdate, createdby, scheduledatecreation, exampublishstatus, markpublishstatus, examschedulestatus, examtimein, examtimeout,examtype)values(?,?,?,?,?,?,?,?,?,?,?,?)");

			if (checkstandard != null && checkstandard.length > 0) {

				for (int j = 0; j < checkstandard.length; j++) {
					String[] subjectscheduleid = checkstandard[j].split("@");
					// System.out.print("subsched1"+subjectscheduleid[1]);
					examschprepare.setLong(1, examscheduleid);
					examschprepare
							.setLong(2, Integer.parseInt(examallotmentid));
					examschprepare.setLong(3, Integer
							.parseInt(subjectscheduleid[0]));
					examschprepare.setString(4, datetime.getMySQLFormat(
							starts[j]).toString());
					examschprepare.setString(5, allotedby);
					examschprepare.setString(6, DateTime
							.showTime("MySqlWithTime"));
					examschprepare.setString(7, "A");
					examschprepare.setString(8, "P");
					examschprepare.setString(9, "P");
					examschprepare.setString(10, starttime[Integer
							.parseInt(subjectscheduleid[1])]);
					examschprepare.setString(11, endtime[Integer
							.parseInt(subjectscheduleid[1])]);
					examschprepare.setString(12, examtype[Integer
							.parseInt(subjectscheduleid[1])]);
					return_value += examschprepare.executeUpdate();
					examscheduleid++;
					connection.commit();
				}

			}

		} catch (Exception exception) {
			log.error(exception);
			exception.printStackTrace();
			if (connection != null)
				connection.rollback();
			return_value = 0;

		}

		finally {

			if (allotrs != null)
				allotrs.close();

			if (allotid != null)
				allotid.close();

			if (examschprepare != null)
				examschprepare.close();

			if (connection != null)
				connection.close();

		}
		return return_value;
	}

	public int updatePublishExam(String[] checkstandard, String[] exmallotid)
			throws Exception {
		log.info("invoking updatePublishExam for  updatePublishExam");

		int result = 0;
		PreparedStatement exampublishprepared = null;

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			select_query = "update examschedule set examschedulestatus=? where subjectscheduleid=? and examallotmentid=?";
			if (checkstandard != null && checkstandard.length > 0) {
				for (int j = 0; j < checkstandard.length; j++) {
					exampublishprepared = connection
							.prepareStatement(select_query);
					exampublishprepared.setString(1, "A");
					exampublishprepared.setString(2, checkstandard[j]);
					exampublishprepared.setString(3, exmallotid[j]);
					result += exampublishprepared.executeUpdate();

				}

			}
			connection.commit();

		} catch (SQLException e) {

			log.error(e);
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {

			if (exampublishprepared != null)
				exampublishprepared.close();

			if (connection != null)
				connection.close();
		}
		return result;
	}

	public int insertExammark(String examschid, String[] chkBoxId,
			String[] markTaken, String createdby, String ipaddress)
			throws Exception {
		log.info("Invoking insertExamMark() for inserting the exam mark entry");
		PreparedStatement markentry = null;
		ResultSet allotrs = null;
		PreparedStatement appidStmt = null;

		long exammarkid = 0l;
		String curTime = DateTime.showTime("MySqlWithTime");

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			appidStmt = connection
					.prepareStatement("select max(exammarkid) from exammark");
			allotrs = appidStmt.executeQuery();

			if (allotrs.next())
				exammarkid = allotrs.getLong(1);
			exammarkid++;
			markentry = connection
					.prepareStatement("insert into exammark(exammarkid, examscheduleid, studentallocationid, marktaken, markcreateddate, createdby, ipadress, markstatus)values(?,?,?,?,?,?,?,?)");
			if (chkBoxId != null && chkBoxId.length > 0) {
				for (int j = 0; j < chkBoxId.length; j++) {
					String[] studentallocationid = chkBoxId[j].split("@");
					markentry.setLong(1, exammarkid);
					markentry.setString(2, examschid);
					markentry.setString(3, studentallocationid[0]);
					markentry.setString(4, markTaken[j]);
					markentry.setString(5, curTime);
					markentry.setString(6, createdby);
					markentry.setString(7, ipaddress);
					markentry.setString(8, "A");
					markentry.addBatch();
					exammarkid++;
				}

			}
			int temp[] = null;
			temp = markentry.executeBatch();
			if (temp != null && temp.length > 0)
				for (int y = 0; y < temp.length; y++)
					return_value += temp[y];

			connection.commit();
		} catch (Exception exception) {

			log.error(exception);
			if (connection != null)
				connection.rollback();
			return_value = 0;
		} finally {
			if (allotrs != null)
				allotrs.close();

			if (appidStmt != null)
				appidStmt.close();

			if (markentry != null)
				markentry.close();

			if (connection != null)
				connection.close();

		}
		return return_value;
	}

	/*
	 * Created subjectExamScheduled By Subhash For listing scheduled Exams based on
	 * standardid accessed from ExamMarkResult.jsp
	 */

	public ArrayList subjectExamScheduled(String standardid) {
		log
				.info("Invoking subjectExamScheduled() for Loading Scheduled Subjects");
		ArrayList groupedStandardList = null;
		try {
			select_query = "select a.subjectscheduleid,subjectname from subjectschedule a,subject b,examschedule c where a.standardscheduleid='"
					+ standardid
					+ "' and a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and c.subjectscheduleid=a.subjectscheduleid and c.examschedulestatus='R'";
			groupedStandardList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	/*
	 * Created standardMarkListToSMS By Subhash For sending SMS based on standard
	 * and exam accessed from markSendSMS.jsp
	 */

	public ArrayList standardMarkListToSMS(String standardid, String examid) {
		log
				.info("Invoking standardMarkListToSMS() for Loading Student List to send SMS");
		ArrayList groupedStandardList = null;
		try {
			// select_query = "select concat(firstname,' ',lastname) as
			// studentname,b.rollno,g.marktaken,b.studentallocationid,(select
			// h.subjectname from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid) as subjectname,(select
			// h.subjectcode from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid) as subjectcode,(select
			// sum(marktaken) from exammark a1,examschedule b1,examallotment c1
			// where a1.studentallocationid=b.studentallocationid and
			// a1.examscheduleid=b1.examscheduleid and
			// b1.examallotmentid=c1.examallotmentid and
			// c1.examnameid='"+examid+"' and b1.examschedulestatus='R') as
			// totalmark from sectionschedule a join studentallocation b on
			// a.standardscheduleid='"+standardid+"' and
			// a.sectionscheduleid=b.sectionscheduleid and
			// a.sectionschedulestatus='A' and b.studentallocationstatus='A'
			// join candidateregister c on
			// b.candidateregisterid=c.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster d on
			// c.personid=d.personid and d.status='A' join examallotment e on
			// e.examnameid='"+examid+"' and
			// a.standardscheduleid=e.standardscheduleid and
			// e.examallotmentstatus='A' join examschedule f on
			// e.examallotmentid=f.examallotmentid and f.examschedulestatus='R'
			// left outer join exammark g on f.examscheduleid=g.examscheduleid
			// and g.markstatus='A' and
			// b.studentallocationid=g.studentallocationid order by
			// totalmark,rollno,subjectcode";
			// select_query = "select concat(firstname,' ',lastname) as
			// studentname,b.rollno,g.marktaken,b.studentallocationid,(select
			// h.subjectname from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A'
			// and i.status='A') as subjectname,(select h.subjectcode from
			// subject h,subjectschedule i where h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A'
			// and i.status='A') as subjectcode,(select i.theoryexternalmax from
			// subject h,subjectschedule i where h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A'
			// and i.status='A') as theoryexternalmax,(select
			// i.theoryexternalmin from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A'
			// and i.status='A') as theoryexternalmin,(select sum(marktaken)
			// from exammark a1,examschedule b1,examallotment c1 where
			// a1.studentallocationid=b.studentallocationid and
			// a1.examscheduleid=b1.examscheduleid and
			// b1.examallotmentid=c1.examallotmentid and
			// c1.examnameid='"+examid+"' and b1.examschedulestatus='R') as
			// totalmark from sectionschedule a join studentallocation b on
			// a.standardscheduleid='"+standardid+"' and
			// a.sectionscheduleid=b.sectionscheduleid and
			// a.sectionschedulestatus='A' and b.studentallocationstatus
			// in('A','D') join candidateregister c on
			// b.candidateregisterid=c.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster d on
			// c.personid=d.personid and d.status='A' join examallotment e on
			// e.examnameid='"+examid+"' and
			// a.standardscheduleid=e.standardscheduleid and
			// e.examallotmentstatus='A' join examschedule f on
			// e.examallotmentid=f.examallotmentid and f.examschedulestatus='R'
			// left outer join exammark g on f.examscheduleid=g.examscheduleid
			// and g.markstatus='A' and
			// b.studentallocationid=g.studentallocationid order by totalmark
			// ,rollno,subjectcode";
		/*	select_query = "select concat(firstname,' ',lastname) as studentname,b.rollno,g.marktaken,b.studentallocationid,(select h.subjectname from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as subjectname,(select h.subjectcode from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as subjectcode,(select i.theoryexternalmax from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as theoryexternalmax,(select i.theoryexternalmin from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as theoryexternalmin,(select sum(marktaken) from exammark a1,examschedule b1,examallotment c1 where a1.studentallocationid=b.studentallocationid and a1.examscheduleid=b1.examscheduleid and b1.examallotmentid=c1.examallotmentid and c1.examnameid='"
					+ examid
					+ "'  and b1.examschedulestatus='R') as totalmark from sectionschedule a join studentallocation b on a.standardscheduleid='"
					+ standardid
					+ "' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus in('A','D') join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"
					+ examid
					+ "' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.examschedulestatus='R' left outer join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid order by totalmark desc,rollno,subjectcode";*/
			// System.out.println("select_query============>>>>>>>>>>>>>>>"+select_query);
			 
			 select_query = "select sec.sectionname,sec.sectionid,concat(firstname,' ',lastname) as studentname,b.rollno,g.marktaken, b.studentallocationid,(select h.subjectname" +
			 		" from subject h,subjectschedule i where  h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and " +
			 		"h.subjectstatus='A' and i.status='A')  as subjectname," +
			 		"(select h.subjectcode from subject h,subjectschedule i where  h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A')  as subjectcode," +
			 		"(select i.theoryexternalmax from subject h,subjectschedule i where  h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A')  as theoryexternalmax," +
			 		"(select i.theoryexternalmin from subject h,subjectschedule i  where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as theoryexternalmin," +
			 		"(select sum(marktaken) from exammark a1,examschedule b1,examallotment c1 where a1.studentallocationid=b.studentallocationid and a1.examscheduleid=b1.examscheduleid and b1.examallotmentid=c1.examallotmentid and" +
			 		" c1.examnameid='"+examid+"'    and b1.examschedulestatus='R') as totalmark  from sectionschedule a  join studentallocation b  on a.standardscheduleid='"+standardid+"' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' " +
			 				" and b.studentallocationstatus in('A','D')  join section sec on a.sectionid=sec.sectionid and sec.status='A' join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' " +
			 				" join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"+examid+"'  and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A'" +
			 						" join examschedule f  on e.examallotmentid=f.examallotmentid and f.examschedulestatus='R' left outer join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid  order by totalmark desc,rollno,subjectcode";
			groupedStandardList = common_data_object.getListMap(select_query);
			// System.out.println("select_query-->"+select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}
	
	public ArrayList standardMarkListToSMSNew(String standardid, String examid,String sectionscheduleid) {
		log
				.info("Invoking standardMarkListToSMS() for Loading Student List to send SMS");
		ArrayList groupedStandardList = null;
		try {
			// select_query = "select concat(firstname,' ',lastname) as
			// studentname,b.rollno,g.marktaken,b.studentallocationid,(select
			// h.subjectname from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid) as subjectname,(select
			// h.subjectcode from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid) as subjectcode,(select
			// sum(marktaken) from exammark a1,examschedule b1,examallotment c1
			// where a1.studentallocationid=b.studentallocationid and
			// a1.examscheduleid=b1.examscheduleid and
			// b1.examallotmentid=c1.examallotmentid and
			// c1.examnameid='"+examid+"' and b1.examschedulestatus='R') as
			// totalmark from sectionschedule a join studentallocation b on
			// a.standardscheduleid='"+standardid+"' and
			// a.sectionscheduleid=b.sectionscheduleid and
			// a.sectionschedulestatus='A' and b.studentallocationstatus='A'
			// join candidateregister c on
			// b.candidateregisterid=c.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster d on
			// c.personid=d.personid and d.status='A' join examallotment e on
			// e.examnameid='"+examid+"' and
			// a.standardscheduleid=e.standardscheduleid and
			// e.examallotmentstatus='A' join examschedule f on
			// e.examallotmentid=f.examallotmentid and f.examschedulestatus='R'
			// left outer join exammark g on f.examscheduleid=g.examscheduleid
			// and g.markstatus='A' and
			// b.studentallocationid=g.studentallocationid order by
			// totalmark,rollno,subjectcode";
			// select_query = "select concat(firstname,' ',lastname) as
			// studentname,b.rollno,g.marktaken,b.studentallocationid,(select
			// h.subjectname from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A'
			// and i.status='A') as subjectname,(select h.subjectcode from
			// subject h,subjectschedule i where h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A'
			// and i.status='A') as subjectcode,(select i.theoryexternalmax from
			// subject h,subjectschedule i where h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A'
			// and i.status='A') as theoryexternalmax,(select
			// i.theoryexternalmin from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A'
			// and i.status='A') as theoryexternalmin,(select sum(marktaken)
			// from exammark a1,examschedule b1,examallotment c1 where
			// a1.studentallocationid=b.studentallocationid and
			// a1.examscheduleid=b1.examscheduleid and
			// b1.examallotmentid=c1.examallotmentid and
			// c1.examnameid='"+examid+"' and b1.examschedulestatus='R') as
			// totalmark from sectionschedule a join studentallocation b on
			// a.standardscheduleid='"+standardid+"' and
			// a.sectionscheduleid=b.sectionscheduleid and
			// a.sectionschedulestatus='A' and b.studentallocationstatus
			// in('A','D') join candidateregister c on
			// b.candidateregisterid=c.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster d on
			// c.personid=d.personid and d.status='A' join examallotment e on
			// e.examnameid='"+examid+"' and
			// a.standardscheduleid=e.standardscheduleid and
			// e.examallotmentstatus='A' join examschedule f on
			// e.examallotmentid=f.examallotmentid and f.examschedulestatus='R'
			// left outer join exammark g on f.examscheduleid=g.examscheduleid
			// and g.markstatus='A' and
			// b.studentallocationid=g.studentallocationid order by totalmark
			// ,rollno,subjectcode";
			select_query = "select concat(firstname,' ',lastname) as studentname,b.rollno,g.marktaken,b.studentallocationid,(select h.subjectname from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as subjectname,(select h.subjectcode from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as subjectcode,(select i.theoryexternalmax from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as theoryexternalmax,(select i.theoryexternalmin from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid and h.subjectstatus='A' and i.status='A') as theoryexternalmin,(select sum(marktaken) from exammark a1,examschedule b1,examallotment c1 where a1.studentallocationid=b.studentallocationid and a1.examscheduleid=b1.examscheduleid and b1.examallotmentid=c1.examallotmentid and c1.examnameid='"
					+ examid
					+ "'  and b1.examschedulestatus='R') as totalmark from sectionschedule a join studentallocation b on a.standardscheduleid='"
					+ standardid
					+ "' and a.sectionscheduleid='"+sectionscheduleid+"' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus in('A','D') join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"
					+ examid
					+ "' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.examschedulestatus='R' left outer join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid order by totalmark desc,rollno,subjectcode";
			// System.out.println("select_query============>>>>>>>>>>>>>>>"+select_query);
			groupedStandardList = common_data_object.getListMap(select_query);
			// System.out.println("select_query-->"+select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	/*
	 * Created insertMarkStaff By Subhash for inserting the exam mark entry by staff
	 * Accessed from markEntryStaffSubmit.jsp
	 */

	public int insertMarkStaff(String examschid, String[] chkBoxId,
			String[] markTaken, String[] staffRemarks, String[] comboRemarks,
			String createdby, String ipaddress) throws Exception {
		log
				.info("Invoking insertMarkStaff() for inserting the exam mark entry by staff");

		PreparedStatement markentry = null;
		ResultSet allotrs = null;

		PreparedStatement appidStmt = null;

		long exammarkid = 0l;

		String curTime = DateTime.showTime("MySqlWithTime");

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			appidStmt = connection
					.prepareStatement("select max(exammarkid) from exammark");
			allotrs = appidStmt.executeQuery();

			if (allotrs.next())
				exammarkid = allotrs.getLong(1);
			exammarkid++;
			markentry = connection
					.prepareStatement("insert into exammark(exammarkid, examscheduleid, studentallocationid, marktaken, markcreateddate, createdby, ipadress, markstatus, staffremarks, comboremarks)values(?,?,?,?,?,?,?,?,?,?)");
			if (chkBoxId != null && chkBoxId.length > 0) {
				for (int j = 0; j < chkBoxId.length; j++) {
					String[] studentallocationid = chkBoxId[j].split("@");
					markentry.setLong(1, exammarkid);
					markentry.setString(2, examschid);
					markentry.setString(3, studentallocationid[0]);
					markentry.setString(4, markTaken[Integer
							.parseInt(studentallocationid[1]) - 1]);
					markentry.setString(5, curTime);
					markentry.setString(6, createdby);
					markentry.setString(7, ipaddress);
					markentry.setString(8, "A");
					markentry.setString(9, staffRemarks[Integer
							.parseInt(studentallocationid[1]) - 1]);
					markentry.setString(10, comboRemarks[Integer
							.parseInt(studentallocationid[1]) - 1]);
					markentry.addBatch();
					exammarkid++;
				}

			}
			int temp[] = null;
			temp = markentry.executeBatch();
			if (temp != null && temp.length > 0)
				for (int y = 0; y < temp.length; y++)
					return_value += temp[y];

			connection.commit();
		} catch (SQLException sqlexception) {

			log.error(sqlexception);

			sqlexception.printStackTrace();
			if (connection != null)
				connection.rollback();
			return_value = 0;

		}

		finally {

			if (allotrs != null)
				allotrs.close();

			if (appidStmt != null)
				appidStmt.close();

			if (markentry != null)
				markentry.close();

			if (connection != null)
				connection.close();

		}
		return return_value;
	}

	/*
	 * Created insertMarkStaff By Subhash for inserting the exam mark entry by staff
	 * Accessed from markEntryStaffSubmit.jsp
	 */

	public int updateMarkStaff(String examschid, String[] chkBoxId,
			String[] markTaken, String[] staffRemarks, String[] comboRemarks,
			String createdby, String ipaddress) throws Exception {
		log
				.info("Invoking updateMarkStaff() for updating the exam mark entered by staff");

		PreparedStatement markentry = null;
		long exammarkid = 0l;
		String curTime = DateTime.showTime("MySqlWithTime");

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			markentry = connection
					.prepareStatement("update exammark set marktaken=?,markcreateddate=?,createdby=?,ipadress=?,staffremarks=?,comboremarks=? where exammarkid=?");
			if (chkBoxId != null && chkBoxId.length > 0) {

				for (int j = 0; j < chkBoxId.length; j++) {
					String[] studentallocationid = chkBoxId[j].split("@");
					String examMarkPos = studentallocationid[1];
					int examMarkPosition = Integer.parseInt(examMarkPos);

					markentry.setString(1, markTaken[examMarkPosition - 1]);
					markentry.setString(2, curTime);
					markentry.setString(3, createdby);
					markentry.setString(4, ipaddress);
					markentry.setString(5, staffRemarks[examMarkPosition - 1]);
					markentry.setString(6, comboRemarks[examMarkPosition - 1]);
					markentry.setString(7, studentallocationid[2]);
					markentry.addBatch();
					exammarkid++;
				}

			}
			int temp[] = null;
			temp = markentry.executeBatch();
			if (temp != null && temp.length > 0)
				for (int y = 0; y < temp.length; y++)
					return_value += temp[y];

			connection.commit();
		} catch (Exception exception) {

			log.error(exception);
			if (connection != null)
				connection.rollback();
			return_value = 0;

		} finally {

			if (markentry != null)
				markentry.close();

			if (connection != null)
				connection.close();

		}
		return return_value;
	}

	// To display the allotted Exam to generate PDF - Subhash
	// Accessed from jsp/PDFReports/ExamReportPdf.jsp
	public ArrayList allotedExamforPDF(String sessionid, String boardid,
			String instituteid) {
		log
				.info("Invoking allotedExamforPDF() for Loading Exam List to generate PDF");
		ArrayList groupedStandardList = null;
		try {
			// select_query = "select concat(firstname,' ',lastname) as
			// studentname,b.rollno,g.marktaken,b.studentallocationid,(select
			// h.subjectname from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid) as
			// subjectname,(select h.subjectcode from subject
			// h,subjectschedule i where h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid) as
			// subjectcode,(select sum(marktaken) from exammark
			// a1,examschedule b1,examallotment c1 where
			// a1.studentallocationid=b.studentallocationid and
			// a1.examscheduleid=b1.examscheduleid and
			// b1.examallotmentid=c1.examallotmentid and
			// c1.examnameid='"+examid+"') as totalmark from sectionschedule
			// a join studentallocation b on
			// a.standardscheduleid='"+standardid+"' and
			// a.sectionscheduleid=b.sectionscheduleid and
			// a.sectionschedulestatus='A' and b.studentallocationstatus='A'
			// join candidateregister c on
			// b.candidateregisterid=c.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster d on
			// c.personid=d.personid and d.status='A' join examallotment e
			// on e.examnameid='"+examid+"' and
			// a.standardscheduleid=e.standardscheduleid and
			// e.examallotmentstatus='A' join examschedule f on
			// e.examallotmentid=f.examallotmentid and
			// f.examschedulestatus='A' left outer join exammark g on
			// f.examscheduleid=g.examscheduleid and g.markstatus='A' and
			// b.studentallocationid=g.studentallocationid order by
			// totalmark,rollno,subjectcode";
			select_query = "select distinct b.examallotmentid,b.standardscheduleid,a.examnameid,a.examname,(select a1.standardname from standard a1,standardschedule b1 where a1.standardid=b1.standardid and b1.standardscheduleid=b.standardscheduleid and a1.boardid='"
					+ boardid
					+ "') as standardname,(select e1.groupname from standardschedule d1,standardgroup e1 where d1.standardscheduleid=b.standardscheduleid and e1.groupid=d1.groupid) as groupname from examname a,examallotment b,examschedule c where a.examnameid=b.examnameid and b.examallotmentid=c.examallotmentid and a.sessionid='"
					+ sessionid
					+ "' and a.instituteid='"
					+ instituteid
					+ "' and a.examnamestatus='A' and b.examallotmentstatus='A' and c.examschedulestatus='R' and c.exampublishstatus='R' and c.markpublishstatus='R' order by b.standardscheduleid,standardname";
			groupedStandardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	// To display the allotted Exam to generate PDF - Subhash
	// Accessed from com/iGrandee/PDFReport/ExamReportPDF.java
	public ArrayList examMarkforPDF(String standardscheduleid,
			String examallotmentid) {
		log
				.info("Invoking examMarkforPDF() for Loading Mark List to generate PDF");
		ArrayList groupedStandardList = null;
		try {
			// select_query = "select concat(firstname,' ',lastname) as
			// studentname,b.rollno,g.marktaken,b.studentallocationid,(select
			// h.subjectname from subject h,subjectschedule i where
			// h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid) as
			// subjectname,(select h.subjectcode from subject
			// h,subjectschedule i where h.subjectid=i.subjectid and
			// i.subjectscheduleid=f.subjectscheduleid) as
			// subjectcode,(select sum(marktaken) from exammark
			// a1,examschedule b1,examallotment c1 where
			// a1.studentallocationid=b.studentallocationid and
			// a1.examscheduleid=b1.examscheduleid and
			// b1.examallotmentid=c1.examallotmentid and
			// c1.examallotmentid='"+examallotmentid+"') as
			// totalmark,(select examname from examname d1 where
			// d1.examnameid=e.examnameid and d1.examnamestatus='A') as
			// examname,(select e1.sectionname from section
			// e1,sectionschedule f1 where f1.sectionid=e1.sectionid and
			// f1.sectionscheduleid=a.sectionscheduleid) as sectionname from
			// sectionschedule a from sectionschedule a join
			// studentallocation b on
			// a.standardscheduleid='"+standardscheduleid+"' and
			// a.sectionscheduleid=b.sectionscheduleid and
			// a.sectionschedulestatus='A' and b.studentallocationstatus='A'
			// join candidateregister c on
			// b.candidateregisterid=c.candidateregisterid and
			// c.candidateregisterstatus='A' join personmaster d on
			// c.personid=d.personid and d.status='A' join examallotment e
			// on e.examallotmentid='"+examallotmentid+"' and
			// a.standardscheduleid=e.standardscheduleid and
			// e.examallotmentstatus='A' join examschedule f on
			// e.examallotmentid=f.examallotmentid and
			// f.examschedulestatus='A' left outer join exammark g on
			// f.examscheduleid=g.examscheduleid and g.markstatus='A' and
			// b.studentallocationid=g.studentallocationid order by
			// rollno,subjectcode";
			select_query = "select concat(firstname,' ',lastname) as studentname,b.rollno,g.marktaken,b.studentallocationid,(select h.subjectname from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid) as subjectname,(select h.subjectcode from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid) as subjectcode,(select sum(marktaken) from exammark a1,examschedule b1,examallotment c1 where a1.studentallocationid=b.studentallocationid and a1.examscheduleid=b1.examscheduleid and b1.examallotmentid=c1.examallotmentid and c1.examallotmentid='"
					+ examallotmentid
					+ "') as totalmark,(select examname from examname d1 where d1.examnameid=e.examnameid and d1.examnamestatus='A') as examname,(select e1.sectionname from section e1,sectionschedule f1 where f1.sectionid=e1.sectionid and f1.sectionscheduleid=a.sectionscheduleid) as sectionname,(select i.theoryexternalmin from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid) as theoryexternalmin from sectionschedule a join studentallocation b on a.standardscheduleid='"
					+ standardscheduleid
					+ "' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and (b.studentallocationstatus='A' or b.studentallocationstatus='D' or b.studentallocationstatus='C') join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examallotmentid='"
					+ examallotmentid
					+ "' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.examschedulestatus='R' left outer join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid order by rollno,subjectcode,sectionname";
			// System.out.println("Mark PDF select_query"+select_query);
			groupedStandardList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return groupedStandardList;
	}

	public ArrayList loadScheduledExamToUpdate(String standardscheduleid,
			String examnameid) {
		log
				.info("Invoking loadScheduledStandardSubjects() for Load the Scheduled Subjects based on standard scheduleid");
		ArrayList periodsList = null;
		try {
			// select_query="select a.examscheduleid,a.subjectscheduleid as
			// examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y')
			// as
			// examdate,a.examtimein,a.examtimeout,b.examallotmentid,a.examschedulestatus
			// from examallotment b join subjectschedule c on
			// b.standardscheduleid='"+standardscheduleid+"' and
			// b.examnameid='"+examnameid+"' and
			// b.standardscheduleid=c.standardscheduleid and
			// b.examallotmentstatus='A' and c.status='A' join subject d on
			// c.subjectid=d.subjectid and d.subjectstatus='A' left outer
			// join examschedule a on
			// c.subjectscheduleid=a.subjectscheduleid and
			// (a.examschedulestatus='A' or a.examschedulestatus='P') and
			// (a.markpublishstatus='A' or a.markpublishstatus='P') and
			// b.examallotmentid=a.examallotmentid";
			select_query = "select a.examscheduleid,a.subjectscheduleid as examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y') as examdate,a.examtimein,REPLACE(TIME_FORMAT(a.examtimein,'%r'),':00 ',' ') as examtimeinampm,a.examtimeout,a.examtype,REPLACE(TIME_FORMAT(a.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(a.examtimeout,a.examtimein),1,5) AS duration,b.examallotmentid,a.examschedulestatus,a.examtype from examallotment b join subjectschedule c on b.standardscheduleid='"
					+ standardscheduleid
					+ "' and b.examnameid='"
					+ examnameid
					+ "' and b.standardscheduleid=c.standardscheduleid and b.examallotmentstatus='A' and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' left outer join examschedule a on c.subjectscheduleid=a.subjectscheduleid and (a.examschedulestatus='A' or a.examschedulestatus='P')  and (a.markpublishstatus='A' or a.markpublishstatus='P') and  b.examallotmentid=a.examallotmentid";
			// System.out.print("select_query--"+select_query);
			log.info(select_query);
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	/*
	 * Created by subhash to load scheduled exam to update Accessed from
	 * ExamScheduleUpdate.jsp
	 */
	public ArrayList loadScheduledExamUpdate(String standardscheduleid,
			String examnameid, String status) {
		log
				.info("Invoking loadScheduledExam() for Load the Scheduled Subjects based on standard scheduleid");
		ArrayList periodsList = null;
		try {
			// select_query="select a.subjectscheduleid as
			// examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y')
			// as examdate,a.examtimein,a.examtimeout,b.examallotmentid from
			// examallotment b join subjectschedule c on
			// b.standardscheduleid='"+standardscheduleid+"' and
			// b.examnameid='"+examnameid+"' and
			// b.standardscheduleid=c.standardscheduleid and
			// b.examallotmentstatus='A' and c.status='A' join subject d on
			// c.subjectid=d.subjectid and d.subjectstatus='A' left outer
			// join examschedule a on
			// c.subjectscheduleid=a.subjectscheduleid and
			// a.examschedulestatus='P' and
			// b.examallotmentid=a.examallotmentid";
			select_query = "select a.examscheduleid,a.subjectscheduleid as examsubscheduleid,c.subjectscheduleid,d.subjectname,d.subjectid,d.standardid,date_format(examdate,'%d-%b-%Y') as examdate,a.examtimein,REPLACE(TIME_FORMAT(a.examtimein,'%r'),':00 ',' ') as examtimeinampm,a.examtimeout,REPLACE(TIME_FORMAT(a.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(a.examtimeout,a.examtimein),1,5) AS duration,a.examtype,b.examallotmentid from examallotment b join subjectschedule c on b.standardscheduleid='"
					+ standardscheduleid
					+ "' and b.examnameid='"
					+ examnameid
					+ "' and b.standardscheduleid=c.standardscheduleid and b.examallotmentstatus='A' and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join examschedule a on c.subjectscheduleid=a.subjectscheduleid and a.exampublishstatus='A' and (a.markpublishstatus='A' or a.markpublishstatus='P') and a.examschedulestatus='"
					+ status + "' and b.examallotmentid=a.examallotmentid";
			log.info(select_query);
			// System.out.println("up select_query-->"+select_query);
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return periodsList;
	}

	/*
	 * Created by subhash to update the scheduled exam Accessed from
	 * ExamScheduleUpdateSubmit.jsp
	 */
	public int UpdateScheduleExams(String[] checkstandard,
			String examallotmentid, String allotedby, String instituteid,
			String[] starts, String[] starttime, String[] endtime,
			String[] examtype) throws SQLException, Exception {
		log.info("invoking UpdateScheduleExams for  updating Schedule Exams");
		DateTime datetime = new DateTime();
		int result = 0;
		PreparedStatement examschprepare = null;
		String examSchedId[] = null;

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			select_query = "update examschedule set examdate=?,examtimein=?,examtimeout=?,createdby=?,scheduledatecreation=?,examtype=? where examscheduleid=? and exampublishstatus=? and markpublishstatus=? and examschedulestatus=?";
			// System.out.println("checkstandard.length-->"+checkstandard.length);
			if (checkstandard != null && checkstandard.length > 0) {

				for (int j = 0; j < checkstandard.length; j++) {
					// System.out.println(datetime.getMySQLFormat(starts[j]).toString());
					// System.out.println(allotedby);
					// System.out.println(DateTime.showTime("MySqlWithTime"));
					// System.out.println(Integer.parseInt(checkstandard[j]));
					examSchedId = checkstandard[j].split("@");
					String examscheduleID = examSchedId[0];
					String examschedPos = examSchedId[1];
					int examschedPosition = Integer.parseInt(examschedPos);

					/*
					 * System.out.println(examschedPosition+"---"+examscheduleID+"--"+datetime.getMySQLFormat(starts[examschedPosition]).toString());
					 * //System.out.println(starttime[examschedPosition]);
					 * //System.out.println(endtime[examschedPosition]);
					 */
					// examschprepare.setLong(1,examscheduleid);
					// examschprepare.setLong(2,
					// Integer.parseInt(examallotmentid));
					examschprepare = connection.prepareStatement(select_query);
					examschprepare.setString(1, datetime.getMySQLFormat(
							starts[examschedPosition]).toString());
					examschprepare.setString(2, starttime[examschedPosition]);
					examschprepare.setString(3, endtime[examschedPosition]);
					examschprepare.setString(4, allotedby);
					examschprepare.setString(5, DateTime
							.showTime("MySqlWithTime"));
					examschprepare.setString(6, examtype[examschedPosition]);
					examschprepare.setLong(7, Integer.parseInt(examscheduleID));
					examschprepare.setString(8, "A");
					examschprepare.setString(9, "P");
					examschprepare.setString(10, "P");
					// examschprepare.setString(5, allotedby);
					// examschprepare.setString(6,
					// DateTime.showTime("MySqlWithTime"));

					// examschprepare.setString(10,starttime[j] );
					// examschprepare.setLong(3,
					// Integer.parseInt(checkstandard[j]));
					// examschprepare.setString(11,endtime[j] );
					result += examschprepare.executeUpdate();
					// examscheduleid++;

				}

			}

			connection.commit();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error(e);
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {

			if (examschprepare != null)
				examschprepare.close();

			if (connection != null)
				connection.close();
		}
		return result;
	}

	/*
	 * Created by subhash to update the scheduled exam Accessed from
	 * ExamScheduleUpdateSubmit.jsp
	 */
	public int TrashScheduleExams(String[] checkstandard,
			String examallotmentid, String allotedby, String instituteid,
			String[] starts, String[] starttime, String[] endtime)
			throws SQLException, Exception {
		log.info("invoking TrashScheduleExams for  updating Schedule Exams");
		DateTime datetime = new DateTime();
		int result = 0;
		PreparedStatement examschprepare = null;
		String examSchedId[] = null;

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			select_query = "update examschedule set examschedulestatus=?,createdby=?,scheduledatecreation=? where examscheduleid=? and exampublishstatus=? and markpublishstatus=? and examschedulestatus=?";
			// System.out.println("checkstandard.length-->"+checkstandard.length);
			if (checkstandard != null && checkstandard.length > 0) {

				for (int j = 0; j < checkstandard.length; j++) {
					/*
					 * System.out.println(datetime.getMySQLFormat(starts[j]).toString());
					 * System.out.println(starttime[j]);
					 * System.out.println(endtime[j]);
					 * System.out.println(allotedby);
					 * System.out.println(DateTime.showTime("MySqlWithTime"));
					 */
					// System.out.println(Integer.parseInt(checkstandard[j]));
					examSchedId = checkstandard[j].split("@");
					String examscheduleID = examSchedId[0];
					String examschedPos = examSchedId[1];
					int examschedPosition = Integer.parseInt(examschedPos);

					// System.out.println(examschedPosition+"---"+examscheduleID);
					// examschprepare.setLong(1,examscheduleid);
					// examschprepare.setLong(2,
					// Integer.parseInt(examallotmentid));
					examschprepare = connection.prepareStatement(select_query);
					examschprepare.setString(1, "T");
					// examschprepare.setString(2,starttime[examschedPosition]);
					// examschprepare.setString(3,endtime[examschedPosition]);
					examschprepare.setString(2, allotedby);
					examschprepare.setString(3, DateTime
							.showTime("MySqlWithTime"));
					examschprepare.setLong(4, Integer.parseInt(examscheduleID));
					examschprepare.setString(5, "A");
					examschprepare.setString(6, "P");
					examschprepare.setString(7, "P");
					// examschprepare.setString(5, allotedby);
					// examschprepare.setString(6,
					// DateTime.showTime("MySqlWithTime"));

					// examschprepare.setString(10,starttime[j] );
					// examschprepare.setLong(3,
					// Integer.parseInt(checkstandard[j]));
					// examschprepare.setString(11,endtime[j] );
					result += examschprepare.executeUpdate();
					// examscheduleid++;

				}

			}

			connection.commit();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error(e);
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {

			if (examschprepare != null)
				examschprepare.close();

			if (connection != null)
				connection.close();
		}
		return result;
	}

	/*
	 * Created by subhash to change the status of the scheduled exam Accessed
	 * from ExamScheduleStatusSubmit.jsp
	 */
	public int statusChangeScheduleExams(String[] checkstandard,
			String allotedby, String instituteid, String status)
			throws SQLException, Exception {
		log
				.info("invoking statusChangeScheduleExams for  changing the status of Schedule Exams");
		//DateTime datetime = new DateTime();
		int result = 0;
		PreparedStatement examschprepare = null;
		String examSchedId[] = null;

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			select_query = "update examschedule set examschedulestatus=?,createdby=?,scheduledatecreation=? where examscheduleid=?";
			// System.out.println("checkstandard.length-->"+checkstandard.length);
			if (checkstandard != null && checkstandard.length > 0) {

				for (int j = 0; j < checkstandard.length; j++) {
					/*
					 * System.out.println(datetime.getMySQLFormat(starts[j]).toString());
					 * System.out.println(starttime[j]);
					 * System.out.println(endtime[j]);
					 * System.out.println(allotedby);
					 * System.out.println(DateTime.showTime("MySqlWithTime"));
					 */
					// System.out.println(Integer.parseInt(checkstandard[j]));
					examSchedId = checkstandard[j].split("@");
					String examscheduleID = examSchedId[0];
					String examschedPos = examSchedId[1];
					int examschedPosition = Integer.parseInt(examschedPos);

					// System.out.println(examschedPosition+"---"+examscheduleID);
					// examschprepare.setLong(1,examscheduleid);
					// examschprepare.setLong(2,
					// Integer.parseInt(examallotmentid));
					examschprepare = connection.prepareStatement(select_query);
					examschprepare.setString(1, status);
					// examschprepare.setString(2,starttime[examschedPosition]);
					// examschprepare.setString(3,endtime[examschedPosition]);
					examschprepare.setString(2, allotedby);
					examschprepare.setString(3, DateTime
							.showTime("MySqlWithTime"));
					examschprepare.setLong(4, Integer.parseInt(examscheduleID));
					// examschprepare.setString(5,"A" );
					// examschprepare.setString(6,"P");
					// examschprepare.setString(7,"P");
					// examschprepare.setString(5, allotedby);
					// examschprepare.setString(6,
					// DateTime.showTime("MySqlWithTime"));

					// examschprepare.setString(10,starttime[j] );
					// examschprepare.setLong(3,
					// Integer.parseInt(checkstandard[j]));
					// examschprepare.setString(11,endtime[j] );
					result += examschprepare.executeUpdate();
					// examscheduleid++;

				}

			}

			connection.commit();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error(e);
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {

			if (examschprepare != null)
				examschprepare.close();

			if (connection != null)
				connection.close();
		}
		return result;
	}

	/*
	 * Created by subhash to change the status(Restore P or Delete D) the
	 * scheduled exam Accessed from ExamScheduleResDelSubmit.jsp
	 */
	public int updateStatusScheduleExams(ExamAllotmentBean examAllotmentBean)
			throws SQLException, Exception {
		log
				.info("invoking updateStatusScheduleExams for Restore P or Delete D of Schedule Exams");
		DateTime datetime = new DateTime();
		int result = 0;
		PreparedStatement examschprepare = null;
		String examSchedId[] = null;

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			select_query = "update examschedule set examschedulestatus=?,createdby=?,scheduledatecreation=? where examscheduleid=? and exampublishstatus=? and markpublishstatus=?";
			examschprepare = connection.prepareStatement(select_query);
			examschprepare.setString(1, examAllotmentBean.getStatus());
			examschprepare.setString(2, examAllotmentBean.getAllotedby());
			examschprepare.setString(3, DateTime.showTime("MySqlWithTime"));
			examschprepare.setString(4, examAllotmentBean.getExamscheduleid());
			examschprepare.setString(5, "A");
			examschprepare.setString(6, "P");
			result += examschprepare.executeUpdate();
			connection.commit();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error(e);
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {

			if (examschprepare != null)
				examschprepare.close();

			if (connection != null)
				connection.close();
		}
		return result;
	}

	/*
	 * Created by subhash to change the status(Restore P or Delete D) of the
	 * published exam Accessed from ExamScheduleResDelSubmit.jsp
	 */
	public int updateStatusPublishExams(ExamAllotmentBean examAllotmentBean)
			throws SQLException, Exception {
		log
				.info("invoking updateStatusScheduleExams for Restore P or Delete D of Schedule Exams");
		DateTime datetime = new DateTime();
		int result = 0;
		PreparedStatement examschprepare = null;
		String examSchedId[] = null;

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			select_query = "update examschedule set exampublishstatus=?,examschedulestatus=?,createdby=?,scheduledatecreation=? where examscheduleid=?";
			examschprepare = connection.prepareStatement(select_query);
			examschprepare.setString(1, examAllotmentBean.getPublishstatus());
			examschprepare.setString(2, examAllotmentBean.getSchedulestatus());
			examschprepare.setString(3, examAllotmentBean.getAllotedby());
			examschprepare.setString(4, DateTime.showTime("MySqlWithTime"));
			examschprepare.setString(5, examAllotmentBean.getExamscheduleid());
			result += examschprepare.executeUpdate();
			connection.commit();

		} catch (SQLException e) {
			e.printStackTrace();
			log.error(e);
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {

			if (examschprepare != null)
				examschprepare.close();

			if (connection != null)
				connection.close();
		}
		return result;
	}

	/*
	 * Created By Subhash For changing the status of the published exam By
	 * passing examscheduleid
	 */
	public int updateStatusForExamPublish(String[] checkstandard,
			String[] exmallotid) throws Exception {
		log.info("invoking updatePublishExam for  updatePublishExam");

		int result = 0;
		PreparedStatement exampublishprepared = null;

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			select_query = "update examschedule set examschedulestatus=? where examscheduleid=? and examallotmentid=?";
			if (checkstandard != null && checkstandard.length > 0) {
				for (int j = 0; j < checkstandard.length; j++) {
					exampublishprepared = connection
							.prepareStatement(select_query);
					exampublishprepared.setString(1, "A");
					exampublishprepared.setString(2, checkstandard[j]);
					exampublishprepared.setString(3, exmallotid[j]);
					result += exampublishprepared.executeUpdate();

				}

			}
			connection.commit();

		} catch (SQLException e) {

			log.error(e);
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {

			if (exampublishprepared != null)
				exampublishprepared.close();

			if (connection != null)
				connection.close();
		}
		return result;
	}

	/*
	 * Created By Subhash For changing the status of the published exam By
	 * passing examscheduleid
	 */
	public int updateStatusForExamPublish(String[] checkstandard,
			String[] exmallotid, String publishstatus, String schedulestatus)
			throws Exception {
		log
				.info("invoking updatePublishExam(String examscheduleid,String exmallotid,String examschedulestatus) for  updatePublishExam");

		int result = 0;
		PreparedStatement exampublishprepared = null;

		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			select_query = "update examschedule set exampublishstatus=? where examscheduleid=? and examallotmentid=?";
			if (checkstandard != null && checkstandard.length > 0) {
				for (int j = 0; j < checkstandard.length; j++) {
					exampublishprepared = connection
							.prepareStatement(select_query);
					exampublishprepared.setString(1, publishstatus);
					// exampublishprepared.setString(2,"A");
					exampublishprepared.setString(2, checkstandard[j]);
					exampublishprepared.setString(3, exmallotid[j]);
					result += exampublishprepared.executeUpdate();

				}

			}
			connection.commit();

		} catch (SQLException e) {

			log.error(e);
			e.printStackTrace();
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {

			if (exampublishprepared != null)
				exampublishprepared.close();

			if (connection != null)
				connection.close();
		}
		return result;
	}

	/*
	 * Created By Subhash For getting hours and minutes between two times in
	 * hh:mm format By passing starttime and endtime in 24 hr format
	 */

	public String getHourMin(String starttime, String endtime) {
		log.info("Invoking getHourMin() for getting Hours and Minutes");
		String hhmm = null;
		try {
			select_query = "select CONCAT(LPAD(HOUR(TIMEDIFF('" + starttime
					+ "','" + endtime
					+ "')),2,'0'), ':',LPAD(MINUTE(TIMEDIFF('" + starttime
					+ "','" + endtime + "')),2,'0'))";
			hhmm = common_data_object.getString(select_query);
			log.info("======>>>>>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return hhmm;
	}

	CommonDataAccess common_data_object;
	String insert_query;
	String select_query;
	int return_value;
	int[] returnvalue;
	Connection connection;
	ExamAllotmentBean examallotmentBean;
}
