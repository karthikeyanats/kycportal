package com.iGrandee.Exam;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class ExamnameEntry {
	static Logger log = Logger.getLogger(ExamnameEntry.class);

	public ExamnameEntry() {

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
					+ instituteid + "' and sessionstatus='A'";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	public ArrayList checkDuplicateExamname(String examnames, String instituteid) {
		log
				.info("Invoking checkDuplicateExamname() for checking Duplicate Exam Name ");
		ArrayList list = null;

		try {
			select_query = "select examnameid,examname from examname where examname='"
					+ examnames + "' and instituteid='" + instituteid + "'";
			list = common_data_object.getListMap(select_query);
			log.info(select_query);

		} catch (Exception exception) {
			log.error(exception);
		} finally {

		}
		return list;
	}

	public ArrayList listExamname(String sessionid, String instituteid) {
		log.info("Invoking listExamname() for Exam Name List");
		ArrayList academicList = null;
		try {

			select_query = "SELECT examnameid, examname, sessionid,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as dateofcreation,createdby,remarks FROM examname where instituteid='"
					+ instituteid
					+ "' and sessionid='"
					+ sessionid
					+ "' and examnamestatus='A' ";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadExamnameList(String sessionid) {
		log.info("Invoking listExamname() for Exam Name List");
		ArrayList academicList = null;
		try {

			select_query = "SELECT examnameid, examname, sessionid,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as dateofcreation,createdby,remarks FROM examname where sessionid='"
					+ sessionid + "' and examnamestatus='A' ";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);

		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadExamnameforstaff(String userid, String sessionid,
			String boardid, String standardscheduleid) {
		log.info("Invoking listExamname() for Exam Name List");
		ArrayList academicList = null;
		try {

			select_query = "     select distinct en.examname,d.standardscheduleid,e.standardname,en.examnameid,ea.examallotmentid "
					+ "	from staffmaster a 	join subjectallotment b on a.userid='"
					+ userid
					+ "' and a.staffid=b.staffid and a.staffstatus='A' "
					+ "	and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid "
					+ "	and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and c.standardscheduleid='"
					+ standardscheduleid
					+ "' "
					+ "	and d.sessionid='"
					+ sessionid
					+ "' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid "
					+ "	and e.boardid='"
					+ boardid
					+ "' and e.standardstatus='A' 	join examallotment ea  on  ea.standardscheduleid=d.standardscheduleid "
					+ "	join examname en on en.examnameid=ea.examnameid and  en.examnamestatus='A' 	and  ea.examallotmentstatus='A' "
					+ "	join examschedule es on es.examallotmentid=ea.examallotmentid and es.exampublishstatus in ('A','R') "
					+ "	and es.markpublishstatus in ('P','R') and es.examschedulestatus in ('A','R');";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);

		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	public ArrayList newStandardSubjectSchedule(String standardscheduleid) {
		ArrayList boardList = new ArrayList();
		try {
			select_query = "select a.subjectscheduleid,b.subjectname from subjectschedule a,subject b where a.standardscheduleid='"
					+ standardscheduleid
					+ "' and a.subjectid=b.subjectid and b.subjectstatus='A' and a.status='A' order by subjectscheduleid asc;";
			boardList = common_data_object.getListMap(select_query);
			System.out
					.println("=======newStandardSubjectSchedule>>>>>>>>>>>>>>>>>>>>>>>>>>"
							+ select_query);

			// log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/Exam/ExamSchedule/ProgressReport.jsp display class pass
	 * Percentage - prasanth
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all pass Percentage from exammark
	 *            table
	 * 
	 * @param examnameid
	 *            that can be used to get all exam names details from examname
	 *            table
	 * 
	 * @param sectionscheduleid
	 *            that can be used to get class pass percentage from exam
	 *            marktable
	 * 
	 * @return the ArrayList by which result can be printed on the screen
	 */
	public String loadSectionwisePassPresentageView(String examnameid,
			String standardscheduleid, String sectionscheduleid) {
		String boardList = "";
		try {
			select_query = "SELECT (((select count(em.studentallocationid) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid  and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"
					+ sectionscheduleid
					+ "' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"
					+ examnameid
					+ "'  and en.examnamestatus='A' and em.marktaken > ss.theoryexternalmin)/  count(em.studentallocationid))* 100) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid  and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"
					+ sectionscheduleid
					+ "' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"
					+ examnameid
					+ "' and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";
			boardList = common_data_object.getString(select_query);
			log.info("Exam name QUERY::>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);

		}
		return boardList;
	}

	public ArrayList LoadScheduledExamList(String examnameid, String userid) {
		log.info("Invoking LoadScheduledExamList() based on the staff");
		ArrayList academicList = null;
		try {
			// select_query = "select distinct
			// h.standardname,h.standardid,f.subjectname,DATE_FORMAT(examdate,
			// '%d-%b-%Y') as examdate,b.examtimein,b.examtimeout from
			// examallotment a,examschedule b,subjectallotment c,staffmaster
			// d,subjectschedule e, subject f,standardschedule g,standard h
			// where a.examnameid='"+examnameid+"' and
			// a.examallotmentid=b.examallotmentid and
			// e.subjectscheduleid=b.subjectscheduleid and
			// f.subjectid=e.subjectid and
			// g.standardscheduleid=e.standardscheduleid and
			// h.standardid=g.standardid and
			// c.subjectscheduleid=b.subjectscheduleid and d.staffid=c.staffid
			// and d.userid='"+userid+"'";
			select_query = "select distinct h.standardname,(select groupname from standardgroup where groupid=g.groupid) as groupname,h.standardid,f.subjectname,DATE_FORMAT(examdate, '%d-%b-%Y') as examdate,b.examtimein,REPLACE(TIME_FORMAT(b.examtimein,'%r'),':00 ',' ') as examtimeinampm,b.examtimeout,REPLACE(TIME_FORMAT(b.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(b.examtimeout,b.examtimein),1,5) AS duration from examallotment a,examschedule b,subjectallotment c,staffmaster d,subjectschedule e, subject f,standardschedule g,standard h where a.examnameid='"
					+ examnameid
					+ "' and a.examallotmentid=b.examallotmentid and e.subjectscheduleid=b.subjectscheduleid and f.subjectid=e.subjectid  and g.standardscheduleid=e.standardscheduleid   and h.standardid=g.standardid and c.subjectscheduleid=b.subjectscheduleid and d.staffid=c.staffid and d.userid='"
					+ userid + "'";
			// System.out.print("select_query-->"+select_query);
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadScheduledExamListforstandard(String examnameid,
			String userid, String standardscheduleid) {
		log.info("Invoking LoadScheduledExamList() based on the staff");
		ArrayList academicList = null;
		try {
			// select_query = "select distinct
			// h.standardname,h.standardid,f.subjectname,DATE_FORMAT(examdate,
			// '%d-%b-%Y') as examdate,b.examtimein,b.examtimeout from
			// examallotment a,examschedule b,subjectallotment c,staffmaster
			// d,subjectschedule e, subject f,standardschedule g,standard h
			// where a.examnameid='"+examnameid+"' and
			// a.examallotmentid=b.examallotmentid and
			// e.subjectscheduleid=b.subjectscheduleid and
			// f.subjectid=e.subjectid and
			// g.standardscheduleid=e.standardscheduleid and
			// h.standardid=g.standardid and
			// c.subjectscheduleid=b.subjectscheduleid and d.staffid=c.staffid
			// and d.userid='"+userid+"'";
			select_query = "select distinct h.standardname,(select groupname from standardgroup where groupid=g.groupid) as groupname,h.standardid,f.subjectname,DATE_FORMAT(examdate, '%d-%b-%Y') as examdate,b.examtimein,REPLACE(TIME_FORMAT(b.examtimein,'%r'),':00 ',' ') as examtimeinampm,b.examtimeout,REPLACE(TIME_FORMAT(b.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(b.examtimeout,b.examtimein),1,5) AS duration,b.examtype from examallotment a,examschedule b,subjectallotment c,staffmaster d,subjectschedule e, subject f,standardschedule g,standard h where a.examnameid='"
					+ examnameid
					+ "' and a.examallotmentid=b.examallotmentid and e.subjectscheduleid=b.subjectscheduleid and f.subjectid=e.subjectid  and g.standardscheduleid=e.standardscheduleid  and e.standardscheduleid='"
					+ standardscheduleid
					+ "'  and h.standardid=g.standardid and c.subjectscheduleid=b.subjectscheduleid and b.exampublishstatus in ('A','R') and b.markpublishstatus in ('P','R') and b.examschedulestatus in ('A','R') and d.staffid=c.staffid and d.userid='"
					+ userid + "'";
			// System.out.print("select_query-->"+select_query);
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadGradeList(String sessionid) {
		log.info("Invoking LoadScheduledExamList() based on the staff");
		ArrayList academicList = null;
		try {
			select_query = "select gradesystemid, gradename, cast(rangefrom as signed) as rangefrom, rangeto FROM gradesystem where gradesystemstatus='A' and sessionid='"
					+ sessionid + "' order by rangefrom asc";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadGradeForgradeId(String sessionid, String gradeid) {
		log.info("Invoking LoadScheduledExamList() based on the staff");
		ArrayList academicList = null;
		try {
			select_query = "select gradesystemid, gradename, cast(rangefrom as signed) as rangefrom, rangeto FROM gradesystem where gradesystemstatus='A' and sessionid='"
					+ sessionid
					+ "' and gradesystemid= '"
					+ gradeid
					+ "' order by rangefrom asc";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadGradeTrashList(String sessionid) {
		log.info("Invoking LoadScheduledExamList() based on the staff");
		ArrayList academicList = null;
		try {

			select_query = "select gradesystemid, gradename, cast(rangefrom as signed) as rangefrom, rangeto FROM gradesystem where gradesystemstatus='T' and sessionid='"
					+ sessionid + "' order by rangefrom asc";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadRangeListforsessionid(String sessionid,
			String gradesystemid) {
		log.info("Invoking LoadScheduledExamList() based on the staff");
		ArrayList academicList = null;
		try {
			select_query = "select rangefrom, rangeto FROM gradesystem where gradesystemstatus<> ('X') and sessionid='"
					+ sessionid
					+ "' and gradesystemid <> '"
					+ gradesystemid
					+ "' order by rangefrom asc";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadScheduledExamStudent(String standardscheduleid) {
		log.info("Invoking LoadScheduledExamStudent() based on the student");
		ArrayList academicList = null;
		try {

			select_query = "select b.examname,c.subjectscheduleid,e.subjectname,date_format(examdate,'%d-%b-%Y') as examdate,c.examtimein,c.examtimeout from examallotment a,examname b, examschedule c,subjectschedule d,subject e  where a.standardscheduleid='"
					+ standardscheduleid
					+ "'  and a.examnameid=b.examnameid  and a.examallotmentstatus='A' and c.examallotmentid=a.examallotmentid and c.examschedulestatus='A'  and (c.exampublishstatus='A' or c.exampublishstatus='R') and d.subjectscheduleid=c.subjectscheduleid and d.subjectid=e.subjectid and d.status='A' and e.subjectstatus='A' order by c.subjectscheduleid";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadScheduledExamStudent(String standardscheduleid,
			String examnameid) {
		log.info("Invoking LoadScheduledExamStudent() based on the student");
		ArrayList academicList = null;
		try {

			// select_query = "select
			// b.examname,c.subjectscheduleid,e.subjectname,date_format(examdate,'%d-%b-%Y')
			// as examdate,c.examtimein,c.examtimeout from examallotment
			// a,examname b, examschedule c,subjectschedule d,subject e where
			// a.standardscheduleid='"+standardscheduleid+"' and
			// a.examnameid='"+examnameid+"' and a.examnameid=b.examnameid and
			// a.examallotmentstatus='A' and c.examallotmentid=a.examallotmentid
			// and (c.examschedulestatus='A' or c.examschedulestatus='R') and
			// (c.exampublishstatus='A' or c.exampublishstatus='R') and
			// d.subjectscheduleid=c.subjectscheduleid and
			// d.subjectid=e.subjectid and d.status='A' and e.subjectstatus='A'
			// order by c.subjectscheduleid";
			select_query = "select b.examname,c.subjectscheduleid,e.subjectname,date_format(examdate,'%d-%b-%Y') as examdate,c.examtimein,REPLACE(TIME_FORMAT(c.examtimein,'%r'),':00 ',' ') as examtimeinampm,c.examtimeout,REPLACE(TIME_FORMAT(c.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(c.examtimeout,c.examtimein),1,5) AS duration,c.examtype from examallotment a,examname b, examschedule c,subjectschedule d,subject e  where a.standardscheduleid='"
					+ standardscheduleid
					+ "'  and a.examnameid='"
					+ examnameid
					+ "' and a.examnameid=b.examnameid  and a.examallotmentstatus='A' and c.examallotmentid=a.examallotmentid and (c.examschedulestatus='A' or c.examschedulestatus='R')  and (c.exampublishstatus='A' or c.exampublishstatus='R') and d.subjectscheduleid=c.subjectscheduleid and d.subjectid=e.subjectid and d.status='A' and e.subjectstatus='A' order by c.subjectscheduleid";
			academicList = common_data_object.getListMap(select_query);
			log.info("LoadScheduledExamStudent()>>>" + select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadScheduledForHomepageExamStudent(
			String standardscheduleid, String examnameid) {
		log.info("Invoking LoadScheduledExamStudent() based on the student");
		ArrayList academicList = null;
		try {

			select_query = "select b.examname,c.subjectscheduleid,e.subjectname,date_format(examdate,'%d-%b-%Y') as examdate,c.examtimein,REPLACE(TIME_FORMAT(c.examtimein,'%r'),':00 ',' ') as examtimeinampm,c.examtimeout,REPLACE(TIME_FORMAT(c.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(c.examtimeout,c.examtimein),1,5) AS duration,c.examtype from examallotment a,examname b, examschedule c,subjectschedule d,subject e  where a.standardscheduleid='"
					+ standardscheduleid
					+ "'  and a.examnameid=b.examnameid  and a.examallotmentstatus='A' and c.examallotmentid=a.examallotmentid and c.examschedulestatus='A' and d.subjectscheduleid=c.subjectscheduleid and d.subjectid=e.subjectid and d.status='A' and e.subjectstatus='A' and b.examnameid='"
					+ examnameid + "' order by c.subjectscheduleid";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadScheduledForHomepageExamHM(String examnameid) {
		log.info("Invoking LoadScheduledExamStudent() based on the student");
		ArrayList academicList = null;
		try {

			select_query = "select b.examname,c.subjectscheduleid,e.subjectname,date_format(examdate,'%d-%b-%Y') as examdate,c.examtimein,c.examtimeout from examallotment a,examname b, examschedule c, subjectschedule d,subject e  where a.examnameid=b.examnameid  and a.examallotmentstatus='A' and c.examallotmentid=a.examallotmentid and c.examschedulestatus='A' and d.subjectscheduleid=c.subjectscheduleid and d.subjectid=e.subjectid and d.status='A' and e.subjectstatus='A' and b.examnameid='"
					+ examnameid + "' order by c.subjectscheduleid";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {

			log.error(exception);
		}
		return academicList;
	}

	public int insertGradeSystem(ExamnameBean examnameBean) throws Exception {
		log.info("Invoking insertGradeSystem() for Grade  Insertion");
		int result = 0;
		PreparedStatement gradesystemprepared = null;
		String currentdate = DateTime.showTime("MySqlWithTime");
		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String query = "select max(gradesystemid) from gradesystem";
			long gradesystemid = common_data_object.maxId(query);
			gradesystemid++;
			query = "insert into gradesystem  (gradesystemid, gradename, rangefrom, rangeto, createdby, dateofcreation, sessionid, gradesystemstatus) values(?,?,?,?,?,?,?,?)";
			gradesystemprepared = connection.prepareStatement(query);
			gradesystemprepared.setLong(1, gradesystemid);
			gradesystemprepared.setString(2, examnameBean.getGradename());
			gradesystemprepared.setString(3, examnameBean.getRangefrom());
			gradesystemprepared.setString(4, examnameBean.getRangeto());
			gradesystemprepared.setString(5, examnameBean.getCreatedby());
			gradesystemprepared.setString(6, currentdate);
			gradesystemprepared.setString(7, examnameBean.getSessionid());
			gradesystemprepared.setString(8, "A");
			result += gradesystemprepared.executeUpdate();

			connection.commit();
		} catch (SQLException exception) {
			log.error(exception);
			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {
			if (gradesystemprepared != null)
				gradesystemprepared.close();
			if (connection != null)
				connection.close();
		}
		return result;
	}

	public int updateGradeSystem(ExamnameBean examnameBean) throws SQLException {
		log.info("Invoking updateGradeSystem() for GradeSystem Updation");
		PreparedStatement Gradeupdateprepared = null;
		int rs = 0;
		try {
			connection = ConnectionManager.getKycConnection();
			String query = "update gradesystem set  gradename=?, rangefrom=?, rangeto=?, createdby=?, dateofcreation=? where gradesystemid=?";
			Gradeupdateprepared = connection.prepareStatement(query);
			Gradeupdateprepared.setString(1, examnameBean.getGradename());
			Gradeupdateprepared.setString(2, examnameBean.getRangefrom());
			Gradeupdateprepared.setString(3, examnameBean.getRangeto());
			Gradeupdateprepared.setString(4, examnameBean.getCreatedby());
			Gradeupdateprepared
					.setString(5, DateTime.showTime("MySqlWithTime"));
			Gradeupdateprepared.setString(6, examnameBean.getGradeid());
			rs += Gradeupdateprepared.executeUpdate();
		}

		catch (Exception exception) {
			log.error(exception);
		} finally {
			if (Gradeupdateprepared != null)
				Gradeupdateprepared.close();

			if (connection != null)
				connection.close();
		}
		return rs;
	}

	public int updateGradeSystemStatus(ExamnameBean examnameBean)
			throws SQLException {
		log.info("Invoking updateGradeSystem() for GradeSystemStatys Updation");
		PreparedStatement Gradeupdateprepared = null;
		int rs = 0;
		try {
			connection = ConnectionManager.getKycConnection();
			String query = "update gradesystem set  gradesystemstatus=?  where gradesystemid=?";
			Gradeupdateprepared = connection.prepareStatement(query);
			Gradeupdateprepared.setString(1, examnameBean.getGradestatus());
			Gradeupdateprepared.setString(2, examnameBean.getGradeid());
			rs += Gradeupdateprepared.executeUpdate();
		} catch (Exception exception) {
			log.error(exception);
		} finally {
			if (Gradeupdateprepared != null)
				Gradeupdateprepared.close();

			if (connection != null)
				connection.close();
		}
		return rs;
	}

	public int insertExamnameEntry(ExamnameBean examnameBean) throws Exception {
		log.info("Invoking insertExamnameEntry() for Exam Name Insertion");
		int result = 0;
		PreparedStatement duplicatechkprepared = null;
		PreparedStatement examnameprepared = null;
		PreparedStatement examnamelog = null;
		ResultSet dupResult = null;
		String currentdate = DateTime.showTime("MySqlWithTime");
		String querytoexecute = null;
		ResultSet regidresult = null;
		long examnamelogid = 0l;
		try {
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);

			String dupCheck = "select examnameid,examname from examname where examname=? and instituteid=? and examnamestatus <> ? and sessionid=?";
			duplicatechkprepared = connection.prepareStatement(dupCheck);
			duplicatechkprepared.setString(1, examnameBean.getExamname()
					.toLowerCase());
			duplicatechkprepared.setString(2, examnameBean.getInstituteid());
			duplicatechkprepared.setString(3, "X");
			duplicatechkprepared.setString(4, examnameBean.getSessionid());
			dupResult = duplicatechkprepared.executeQuery();

			if (!dupResult.next()) {
				String query = "select max(examnameid) from examname";
				long examnameid = common_data_object.maxId(query);
				examnameid++;

				query = "insert into examname (examnameid, examname, sessionid, examnamestatus, instituteid, createdby, dateofcreation, remarks) values(?,?,?,?,?,?,?,?)";
				examnameprepared = connection.prepareStatement(query);
				examnameprepared.setLong(1, examnameid);
				examnameprepared.setString(2, examnameBean.getExamname());
				examnameprepared.setString(3, examnameBean.getSessionid());
				examnameprepared.setString(4, "A");
				examnameprepared.setString(5, examnameBean.getInstituteid());
				examnameprepared.setString(6, examnameBean.getCreatedby());
				examnameprepared.setString(7, currentdate);
				examnameprepared.setString(8, examnameBean.getRemarks());

				result += examnameprepared.executeUpdate();

				querytoexecute = "select max(examnamelogid) from examnamelog";
				examnamelog = connection.prepareStatement(querytoexecute);
				regidresult = examnamelog.executeQuery();

				if (regidresult.next()) {
					examnamelogid = regidresult.getLong(1);
				}
				examnamelogid++;
				querytoexecute = "insert into examnamelog(examnamelogid, logdescription, examnameid,createdby, dateofcreation, examnamelogstatus) values(?,?,?,?,?,?)";
				examnamelog = connection.prepareStatement(querytoexecute);
				examnamelog.setLong(1, examnamelogid);
				examnamelog.setString(2, "Created");
				examnamelog.setLong(3, examnameid);
				examnamelog.setString(4, examnameBean.getCreatedby());
				examnamelog.setString(5, currentdate);
				examnamelog.setString(6, "A");
				result += examnamelog.executeUpdate();
				connection.commit();
			} else {
				result = 1000;
			}

		} catch (SQLException e) {

			log.error(e);

			result = 0;
			if (connection != null)
				connection.rollback();
		} finally {
			if (regidresult != null)
				regidresult.close();

			if (examnameprepared != null)
				examnameprepared.close();
			if (examnamelog != null)
				examnamelog.close();
			if (connection != null)
				connection.close();
		}
		return result;
	}

	public boolean checkDuplicate(String gradename, String sessionid,
			String gradesystemid) {
		boolean return_flag = false;
		String return_string = null;
		try {
			String select_query = "SELECT gradename FROM gradesystem g where gradename='"
					+ gradename
					+ "' and gradesystemstatus='A' and sessionid='"
					+ sessionid
					+ "' and gradesystemid <> '"
					+ gradesystemid
					+ "'";
			return_string = common_data_object.getString(select_query);
			log.info(select_query);
			if (return_string == null || return_string.equalsIgnoreCase("null")
					|| return_string.equals("")) {
				return_flag = false;
			} else {
				return_flag = true;
			}
		} catch (Exception exception) {
			log.error(exception);
		}
		return return_flag;
	}

	public int UpdateEditExamname(ExamnameBean examnameBean)
			throws SQLException {
		log.info("Invoking UpdateEditExamname() for Exam Name Updation");
		PreparedStatement examnameupdateprepared = null;
		PreparedStatement duplicatechkprepared = null;
		ResultSet dupResult = null;
		int rs = 0;
		int result = 0;

		try {
			String examnameid = examnameBean.getExamnameid();
			String examname = examnameBean.getExamname();
			String examremarks = examnameBean.getRemarks();

			connection = ConnectionManager.getKycConnection();

			String dupCheck = "select examname from examname where examname=? and instituteid=? and examnamestatus <> ? and sessionid=? ";
			duplicatechkprepared = connection.prepareStatement(dupCheck);
			duplicatechkprepared.setString(1, examnameBean.getExamname()
					.toLowerCase());
			duplicatechkprepared.setString(2, examnameBean.getInstituteid());
			duplicatechkprepared.setString(3, "X");
			duplicatechkprepared.setString(4, examnameBean.getSessionid());
			dupResult = duplicatechkprepared.executeQuery();

			// System.out.print("dupResult.next()-->"+dupResult.next());
			log.info("dupRslt" + dupResult.next());
			if (!dupResult.next()) {
				String query = "update examname set examname=?,remarks=?,dateofcreation=?,instituteid=?,createdby=?  where examnameid=? ";
				examnameupdateprepared = connection.prepareStatement(query);

				examnameupdateprepared.setString(1, examname);
				examnameupdateprepared.setString(2, examremarks);
				examnameupdateprepared.setString(3, DateTime
						.showTime("MySqlWithTime"));
				examnameupdateprepared.setString(4, examnameBean
						.getInstituteid());
				examnameupdateprepared
						.setString(5, examnameBean.getCreatedby());
				examnameupdateprepared.setString(6, examnameid);

				rs = examnameupdateprepared.executeUpdate();

				long l1 = common_data_object
						.fmaxId("select max(examnamelogid)from examnamelog");
				String query1 = "insert into examnamelog (examnamelogid,logdescription,examnameid,createdby,dateofcreation,examnamelogstatus) values(?,?,?,?,?,?)";

				examnameupdateprepared = connection.prepareStatement(query1);
				examnameupdateprepared.setLong(1, l1);
				examnameupdateprepared.setString(2, "Updated");
				examnameupdateprepared.setString(3, examnameBean
						.getExamnameid());
				examnameupdateprepared
						.setString(4, examnameBean.getCreatedby());
				examnameupdateprepared.setString(5, DateTime
						.showTime("MySqlWithTime"));
				examnameupdateprepared.setString(6, "A");
				rs = examnameupdateprepared.executeUpdate();
			} else {
				rs = 1000;
			}

		} catch (Exception exception) {
			log.info(exception);
		} finally {
			if (examnameupdateprepared != null)
				examnameupdateprepared.close();

			if (connection != null)
				connection.close();

			if (duplicatechkprepared != null)
				duplicatechkprepared.close();

			if (dupResult != null)
				dupResult.close();
		}

		return rs;
	}

	public int updateTrashExamname(ExamnameBean examnameBean)
			throws SQLException {
		log.info("Invoking updateTrashExamname() for Exam Name Trash Updation");
		String status = examnameBean.getExamnamestatus();
		String examnameid = examnameBean.getExamnameid();
		PreparedStatement examnametrashprepared = null;
		int rs = 0;
		int result = 0;
		try {
			connection = ConnectionManager.getKycConnection();

			String query = "update examname set examnamestatus=?,dateofcreation=?,createdby=?,instituteid=? where examnameid=?";
			examnametrashprepared = connection.prepareStatement(query);

			examnametrashprepared.setString(1, status);
			examnametrashprepared.setString(2, DateTime
					.showTime("MySqlWithTime"));
			examnametrashprepared.setString(3, examnameBean.getCreatedby());
			examnametrashprepared.setString(4, examnameBean.getInstituteid());
			examnametrashprepared.setString(5, examnameid);

			rs = examnametrashprepared.executeUpdate();

			long l1 = common_data_object
					.fmaxId("select max(examnamelogid)from examnamelog");
			String query1 = "insert into examnamelog (examnamelogid,examnameid,logdescription,dateofcreation,examnamelogstatus,createdby) values(?,?,?,?,?,?)";
			examnametrashprepared = connection.prepareStatement(query1);
			examnametrashprepared.setLong(1, l1);
			examnametrashprepared.setString(2, examnameBean.getExamnameid());
			examnametrashprepared.setString(3, "Trash");
			examnametrashprepared.setString(4, DateTime
					.showTime("MySqlWithTime"));
			examnametrashprepared.setString(5, "A");
			examnametrashprepared.setString(6, examnameBean.getCreatedby());

			result = examnametrashprepared.executeUpdate();
		}

		catch (Exception exception) {

			log.error(exception);

		} finally {
			if (examnametrashprepared != null)
				examnametrashprepared.close();

			if (connection != null)
				connection.close();
		}
		return rs;
	}

	public ArrayList get_All_ExamnameTrashList(String instituteid) {
		log
				.info("Invoking get_All_ExamnameTrashList() for viewing the Exam Name Trashlist");
		ArrayList list = null;
		try {
			select_query = "select examnameid,examname,remarks,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as dateofcreation,createdby,examnamestatus from examname where instituteid='"
					+ instituteid + "' and examnamestatus='T'";
			log.info(select_query);
			list = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return list;
	}

	public int ExamnameDeactivate(ExamnameBean examnameBean)
			throws SQLException {
		log
				.info("Invoking ExamnameDeactivate() for List the Deactivate  Exam Name ");
		PreparedStatement examnamedeactivatelistprepared = null;
		PreparedStatement instituteprepared = null;

		int rs = 0;
		int result = 0;

		try {
			String Examnameid = examnameBean.getExamnameid();

			connection = ConnectionManager.getKycConnection();

			String query = "update examname set examnamestatus=? ,dateofcreation=?,createdby=?,instituteid=?  where examnameid=? ";
			examnamedeactivatelistprepared = connection.prepareStatement(query);

			examnamedeactivatelistprepared.setString(1, "D");
			examnamedeactivatelistprepared.setString(2, DateTime
					.showTime("MySqlWithTime"));
			// examnamedeactivatelistprepared.setString(3,
			// examnameBean.getIpaddess());
			examnamedeactivatelistprepared.setString(3, examnameBean
					.getCreatedby());
			examnamedeactivatelistprepared.setString(4, examnameBean
					.getInstituteid());
			examnamedeactivatelistprepared.setString(5, Examnameid);
			rs = examnamedeactivatelistprepared.executeUpdate();

			long l1 = common_data_object
					.fmaxId("select max(examnamelogid)from examnamelog");
			String query1 = "insert into examnamelog (examnamelogid,logdescription,examnameid,createdby,dateofcreation,examnamelogstatus) values(?,?,?,?,?,?)";
			log.info(select_query);

			examnamedeactivatelistprepared = connection
					.prepareStatement(query1);
			examnamedeactivatelistprepared.setLong(1, l1);
			examnamedeactivatelistprepared.setString(2, "Deactive");
			examnamedeactivatelistprepared.setString(3, examnameBean
					.getExamnameid());
			examnamedeactivatelistprepared.setString(4, examnameBean
					.getCreatedby());
			examnamedeactivatelistprepared.setString(5, DateTime
					.showTime("MySqlWithTime"));
			examnamedeactivatelistprepared.setString(6, "A");
			result = examnamedeactivatelistprepared.executeUpdate();

		} catch (Exception exception) {

			log.error(exception);

		} finally {
			if (examnamedeactivatelistprepared != null)
				examnamedeactivatelistprepared.close();

			if (connection != null)
				connection.close();
		}
		return rs;
	}

	public ArrayList checkdeactiveExamname(String instituteid, String examnameid) {
		log
				.info("Invoking checkedactiveExamname() for checking the Exam Name deactivation");
		ArrayList list = null;
		try {
			select_query = "select examnamelogid,examnameid,examnamelogstatus from examnamelog where instituteid='"
					+ instituteid + "' and examnameid='" + examnameid + "' ";
			log.info(select_query);
			list = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return list;
	}

	public int RestoreExamname(ExamnameBean examnameBean) throws SQLException {
		log.info("Invoking RestoreExamname() for Exam Name Restore");
		PreparedStatement examRestoreprepared = null;
		PreparedStatement instituteprepared = null;

		int rs = 0;
		int result = 0;

		try {
			String examnameid = examnameBean.getExamnameid();
			connection = ConnectionManager.getKycConnection();

			String query = "update examname set examnamestatus=?, dateofcreation=?,createdby=?,instituteid=?  where examnameid=? ";
			examRestoreprepared = connection.prepareStatement(query);
			examRestoreprepared.setString(1, "A");
			examRestoreprepared
					.setString(2, DateTime.showTime("MySqlWithTime"));
			// examRestoreprepared.setString(3, examnameBean.getIpaddess());
			examRestoreprepared.setString(3, examnameBean.getCreatedby());
			examRestoreprepared.setString(4, examnameBean.getInstituteid());
			examRestoreprepared.setString(5, examnameid);

			rs = examRestoreprepared.executeUpdate();

			long l1 = common_data_object
					.fmaxId("select max(examnamelogid)from examnamelog");
			String query1 = "insert into examnamelog (examnamelogid,logdescription,examnameid,createdby,dateofcreation,examnamelogstatus) values(?,?,?,?,?,?)";

			examRestoreprepared = connection.prepareStatement(query1);
			examRestoreprepared.setLong(1, l1);
			examRestoreprepared.setString(2, "Restore");
			examRestoreprepared.setString(3, examnameBean.getExamnameid());
			examRestoreprepared.setString(4, examnameBean.getCreatedby());
			examRestoreprepared
					.setString(5, DateTime.showTime("MySqlWithTime"));
			examRestoreprepared.setString(6, "A");

			result = examRestoreprepared.executeUpdate();

		} catch (Exception exception) {

			log.error(exception);

		} finally {
			if (examRestoreprepared != null)
				examRestoreprepared.close();

			if (connection != null)
				connection.close();
		}
		return rs;
	}

	public ArrayList DeactivatedExamnameList(String instituteid) {
		log
				.info("Invoking DeactivatedExamnameList() for viewing the Exam Name List");
		ArrayList list = null;
		try {
			select_query = "select examnameid,instituteid,examname,remarks,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as dateofcreation,createdby,examnamestatus from examname where instituteid='"
					+ instituteid + "' and examnamestatus='D'";
			list = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return list;
	}

	public int ActivateExamname(ExamnameBean examnameBean) throws SQLException {
		log.info("Invoking ActivateExamnames() for Exam Name Activation");

		PreparedStatement activateexamnameprepared = null;
		PreparedStatement instituteprepared = null;

		int rs = 0;
		int result = 0;

		try {
			String examnameid = examnameBean.getExamnameid();
			connection = ConnectionManager.getKycConnection();

			String query = "update examname set examnamestatus=?, dateofcreation=?,createdby=?,instituteid=?  where examnameid=? ";
			activateexamnameprepared = connection.prepareStatement(query);
			activateexamnameprepared.setString(1, "A");
			activateexamnameprepared.setString(2, DateTime
					.showTime("MySqlWithTime"));
			// activateexamnameprepared.setString(3,
			// examnameBean.getIpaddess());
			activateexamnameprepared.setString(3, examnameBean.getCreatedby());
			activateexamnameprepared
					.setString(4, examnameBean.getInstituteid());
			activateexamnameprepared.setString(5, examnameid);

			rs = activateexamnameprepared.executeUpdate();

			long l1 = common_data_object
					.fmaxId("select max(examnamelogid)from examnamelog");
			String query1 = "insert into examnamelog (examnamelogid, logdescription, examnameid, createdby, dateofcreation, examnamelogstatus) values(?,?,?,?,?,?)";

			activateexamnameprepared = connection.prepareStatement(query1);
			activateexamnameprepared.setLong(1, l1);
			activateexamnameprepared.setString(2, "Active");
			activateexamnameprepared.setString(3, examnameBean.getExamnameid());
			activateexamnameprepared.setString(4, examnameBean.getCreatedby());
			activateexamnameprepared.setString(5, DateTime
					.showTime("MySqlWithTime"));
			activateexamnameprepared.setString(6, "A");

			result = activateexamnameprepared.executeUpdate();

		} catch (Exception exception) {

			log.error(exception);

		} finally {
			if (activateexamnameprepared != null)
				activateexamnameprepared.close();

			if (connection != null)
				connection.close();
		}
		return rs;
	}

	public int DeleteExamnames(ExamnameBean examnameBean) throws SQLException {
		PreparedStatement deleteexamnameprepared = null;
		PreparedStatement instituteprepared = null;

		int rs = 0;
		int result = 0;

		try {
			String examnameid = examnameBean.getExamnameid();

			connection = ConnectionManager.getKycConnection();

			String query = "update examname set examnamestatus=?,dateofcreation=?,createdby=?,instituteid=?  where examnameid=? ";
			deleteexamnameprepared = connection.prepareStatement(query);

			deleteexamnameprepared.setString(1, "X");
			deleteexamnameprepared.setString(2, DateTime
					.showTime("MySqlWithTime"));
			// settingsprepared.setString(3, examnameBean.getIpaddess());
			deleteexamnameprepared.setString(3, examnameBean.getCreatedby());
			deleteexamnameprepared.setString(4, examnameBean.getInstituteid());
			deleteexamnameprepared.setString(5, examnameid);

			rs = deleteexamnameprepared.executeUpdate();

			long l1 = common_data_object
					.fmaxId("select max(examnamelogid)from examnamelog");
			String query1 = "insert into examnamelog (examnamelogid, logdescription, examnameid, createdby, dateofcreation, examnamelogstatus) values(?,?,?,?,?,?)";
			log.info(select_query);

			deleteexamnameprepared = connection.prepareStatement(query1);
			deleteexamnameprepared.setLong(1, l1);
			deleteexamnameprepared.setString(2, "Deleted");
			deleteexamnameprepared.setString(3, examnameBean.getExamnameid());
			deleteexamnameprepared.setString(4, examnameBean.getCreatedby());
			deleteexamnameprepared.setString(5, DateTime
					.showTime("MySqlWithTime"));
			deleteexamnameprepared.setString(6, "A");

			result = deleteexamnameprepared.executeUpdate();
		} catch (Exception exception) {

			log.error(exception);

		} finally {
			if (deleteexamnameprepared != null)
				deleteexamnameprepared.close();

			if (connection != null)
				connection.close();
		}
		return rs;
	}

	public ArrayList listStudentmark(String standardscheduleid,
			String allocationid) {
		ArrayList arraylist = null;

		try {
			select_query = "select c.theoryexternalmin,g.rollno,a.examnameid,a.examname,c.subjectscheduleid,f.marktaken from examname a  join examallotment b on b.standardscheduleid='"
					+ standardscheduleid
					+ "' and a.examnameid=b.examnameid and b.examallotmentstatus='A' and a.examnamestatus='A' join subjectschedule c on c.standardscheduleid=b.standardscheduleid and c.status='A' join subject d on d.subjectid=c.subjectid and d.subjectstatus='A' join studentallocation g on g.studentallocationid='"
					+ allocationid
					+ "'  join examschedule e on b.examallotmentid=e.examallotmentid and e.exampublishstatus='R' and e.markpublishstatus='R' and  e.examschedulestatus='R' and c.subjectscheduleid=e.subjectscheduleid left outer join exammark f on f.examscheduleid=e.examscheduleid and f.markstatus='A' and f.studentallocationid=g.studentallocationid   order by a.examnameid,c.subjectscheduleid asc";
			arraylist = common_data_object.getListMap(select_query);
			log.info(select_query);
			// System.out.print("select_query========>>>>"+select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/Exam/ExamScehedule/SubjectwiseRank.jsp display progress
	 * report for Parent Page - (access by prasanth)
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @return the ArrayList by which result can be printed on the screen
	 */
	public ArrayList StudentDetails(String standardscheduleid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT ys.sessionid,s.standardname,ys.sessionname,(select groupname from standardgroup sg  where sg.groupid=ss.groupid and sg.groupstatus='A' ) as groupname FROM  standardschedule ss join standard s on ss.standardid=s.standardid and  ss.standardscheduleid='"
					+ standardscheduleid
					+ "' and s.standardstatus='A' and ss.stdschedulestatus='A'  join yearofsession ys on ys.sessionid=ss.sessionid and ys.sessionstatus in ('A','R')";
			arraylist = common_data_object.getListMap(select_query);
			/*System.out
					.println("=======StudentDetails>>>>>>>>>>>>>>>>>>>>>>>>>>"
							+ select_query);*/
			log.info("====================>>>>>>>>>>>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}

	/**
	 * This method is accessed from kycportal/jsp/Parent/TimeTable.jsp This
	 * method is accessed from kycportal/jsp/Student/StudentHome.jsp display
	 * Exam for Parent Page - prasanth
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all details from examname table
	 * 
	 * @param instituteid
	 *            that can be used to get all details from examname table
	 * 
	 * @return the ArrayList by which result can be printed on the screen
	 */
	public ArrayList LoadScheduledExamForHomepage(String standardscheduleid,
			String instituteid) {
		log.info("Invoking LoadScheduledExamStudent() based on the student");
		ArrayList academicList = null;
		try {
			select_query = "select date_format(c.examdate,'%d-%b-%Y') as examdate,a.examnameid ,a.examname from examname a ,examallotment b,examschedule c where a.examnamestatus='A' and a.examnameid=b.examnameid and b.examallotmentstatus='A' and b.examallotmentid=c.examallotmentid and c.examschedulestatus='A' and a.instituteid='"
					+ instituteid
					+ "' and b.standardscheduleid='"
					+ standardscheduleid
					+ "'  group by a.examname order by c.examdate desc ";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadScheduledExamForHMHomepage(String sessionid) {
		log.info("Invoking LoadScheduledExamStudent() based on the student");
		ArrayList academicList = null;
		try {
			select_query = "select a.examnameid,a.examname from examname a where a.sessionid='"
					+ sessionid
					+ "' and a.examnamestatus='A' and order by a.dateofcreation desc";
			academicList = common_data_object.getListMap(select_query);
			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	public ArrayList LoadExamMarksForstudent(String studentallocationid,
			String standardscheduleid) {
		log.info("Invoking LoadScheduledExamStudent() based on the student");
		ArrayList academicList = null;
		try {
			// select_query = "SELECT distinct * FROM examname en"
			select_query = "SELECT distinct en.examnameid,en.examname,ss.subjectscheduleid,e.marktaken,ss.theoryexternalmin FROM examname en"
					+ " join examallotment ea on  en.examnameid=ea.examnameid and ea.standardscheduleid='"
					+ standardscheduleid
					+ "'"
					+ " and ea.examallotmentstatus='A'"
					+ " join subjectschedule ss  on ea.standardscheduleid=ss.standardscheduleid and ss.status='A'"
					+ " join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'"
					+ " left outer join examschedule es on  es.subjectscheduleid=ss.subjectscheduleid"
					+ " and es.examallotmentid=ea.examallotmentid and es.exampublishstatus ='R'"
					+ " and  es.markpublishstatus ='R'  and es.examschedulestatus ='R'"
					+ " right outer join  exammark e on e.examscheduleid=es.examscheduleid and e.studentallocationid='"
					+ studentallocationid + "' order by examnameid";
			academicList = common_data_object.getListMap(select_query);

			log.info(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return academicList;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/Exam/ExamScehedule/SubjectwiseRank.jsp display subject wise
	 * rank for Parent Page - (created by prasanth)
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param examnameid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param sectionscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param subjectscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @return the ArrayList by which result can be printed on the screen
	 */
	public ArrayList SubjectWiseRank(String examnameid,
			String subjectscheduleid, String standardscheduleid,
			String sectionscheduleid) {
		ArrayList boardList = new ArrayList();
		try {
			select_query = "SELECT em.studentallocationid,em.marktaken, sub.subjectname FROM examschedule es join examallotment ea on ea.examnameid='"
					+ examnameid
					+ "' and ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and  es.subjectscheduleid='"
					+ subjectscheduleid
					+ "' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on    sa.studentallocationstatus='A' and sa.sectionscheduleid='"
					+ sectionscheduleid
					+ "' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by em.marktaken desc";
			boardList = common_data_object.getListMap(select_query);
			log.info("Exam name QUERY::>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/Exam/ExamScehedule/SubjectwiseRank.jsp display class wise
	 * rank for Parent Page - (created by prasanth)
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param examnameid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param sectionscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * 
	 * @return the ArrayList by which result can be printed on the screen
	 */
	public ArrayList clasRank(String examnameid, String standardscheduleid,
			String sectionscheduleid) {
		ArrayList boardList = new ArrayList();
		try {
			select_query = "SELECT (sum(em.marktaken))as total,es.examscheduleid,sa.studentallocationid FROM examschedule es join examallotment ea on ea.examnameid='"
					+ examnameid
					+ "' and ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"
					+ sectionscheduleid
					+ "' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' group by sa.studentallocationid order by total desc;";
			boardList = common_data_object.getListMap(select_query);
			log.info("Exam name QUERY::>>>>" + select_query);

		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/Exam/ExamScehedule/SubjectwiseRank.jsp display progress
	 * report for Parent Page - (created by prasanth)
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param examnameid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param sectionscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @return the ArrayList by which result can be printed on the screen
	 */
	public ArrayList LoadexammarkforStudentList(String examnameid,
			String standardscheduleid, String sectionscheduleid) {
		ArrayList boardList = new ArrayList();
		try {
			select_query = "SELECT es.examscheduleid,es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"
					+ examnameid
					+ "' and ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"
					+ sectionscheduleid
					+ "' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'   order by sa.rollno,c.candidateregisterid,sub.subjectid,em.marktaken desc ";
			boardList = common_data_object.getListMap(select_query);
			log.info("Exam name QUERY::>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	/**
	 * This method is accessed from
	 * kycportal/jsp/Exam/ExamScehedule/SubjectwiseRank.jsp display class rank
	 * wise mark details for Parent Page - (created by prasanth)
	 * 
	 * @param standardscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param examnameid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param sectionscheduleid
	 *            that can be used to get all details from examname,marktaken
	 *            table
	 * 
	 * @param studentallocationid
	 *            that can be used to get all details for every students from
	 *            examname,marktaken table
	 * 
	 * @return the ArrayList by which result can be printed on the screen
	 */
	public ArrayList LoadexammarkforStudentListRankWise(String examnameid,
			String standardscheduleid, String sectionscheduleid,
			String studentallocationid) {
		ArrayList boardList = new ArrayList();
		try {
			select_query = "SELECT es.examscheduleid,es.markpublishstatus,es.examallotmentid,ss.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"
					+ examnameid
					+ "' and ea.standardscheduleid='"
					+ standardscheduleid
					+ "' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"
					+ standardscheduleid
					+ "'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"
					+ sectionscheduleid
					+ "' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationid='"
					+ studentallocationid
					+ "' and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'   order by sa.rollno,c.candidateregisterid,sub.subjectid,em.marktaken desc ";
			boardList = common_data_object.getListMap(select_query);
			log.info("Exam name QUERY::>>>>" + select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return boardList;
	}

	CommonDataAccess common_data_object;
	String insert_query;
	String select_query;
	int return_value;
	int[] returnvalue;
	Connection connection;
	ExamnameBean examnameBean;

}