package com.iGrandee.Assignment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class AssignmentStudent {

	static Logger log = Logger.getLogger(AssignmentStudent.class);

	public AssignmentStudent() {

		common_data_object = new CommonDataAccess();
		insert_query = null;
		select_query = null;
		return_value = 0;
		connection = null;
		datetime = new DateTime();
	}

	/*
	 * This method is accessed from
	 * kycportal/jsp/Assignment/AssignmentCreation.jsp,kycportal/jsp/Assignment/getAgentCourseInfo.jsp
	 */
	public ArrayList loadAssignmentViewForStudent(String sectionid,
			String studentid) {
		log
				.info("invoking loadAssignmentViewForStudent from com.iGrandee.Assignment.AssignmentStudent");

		ArrayList periodsList = null;
		try {
			select_query = "select subjectname,lessonname,questionname,g.mark as questionmark, g. file as questionfile,date_format(h.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(h.submissiondate,'%d-%b-%Y') as submissiondate, i.studentremarks,h.assignmentid, facultyremarks, date_format(studentdate,'%d-%b-%Y') as studentdate, date_format(facultydate,'%d-%b-%Y') as facultydate,i.file,i.mark, c.subjectscheduleid,concat(k.firstname,' ',k.lastname) as staffname, e.lessonscheduleid,case when h.submissiondate>=curDate() then 'Available' else 'Not Available' end as datestatus from sectionschedule a join standardschedule b on a.sectionscheduleid='"
					+ sectionid
					+ "' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join lessonschedule e on c.subjectscheduleid=e.subjectscheduleid and e.status='A' join lesson f on e.lessonid=f.lessonid and f.lessonstatus='A' left outer join assignemntquestion g on e.lessonscheduleid=g.lessonscheduleid and g.status='A' left outer join assignmentmaster h on find_in_set('"
					+ studentid
					+ "',h.studentids) and g.questionid=h.questionid  left outer join assignmenttracking i on h.assignmentid = i.assignmentid  and i.studentid='"
					+ studentid
					+ "' left outer join login j on j.userid=g.createdby  and j.loginstatus='A' left outer join personmaster k on j.personid=k.personid order by c.subjectscheduleid,h.submissiondate desc";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	/*
	 * This method is accessed from kycportal/jsp/Student/AssignmentView.jsp
	 */
	public ArrayList loadAssignmentViewForStudentConsolidated(String sectionid,
			String studentid) {
		log
				.info("invoking loadAssignmentViewForStudentConsolidated(String sectionid,String studentid) from com.iGrandee.Assignment.AssignmentStudent");

		ArrayList periodsList = null;
		try {
			select_query = "select c.subjectscheduleid,concat(d.subjectname,' - ',d.subjectcode) as subjectname, (select count(b1.questionid) from lessonschedule a1,assignemntquestion b1,assignmentmaster c1 where a1.subjectscheduleid=c.subjectscheduleid and a1.lessonscheduleid=b1.lessonscheduleid and a1.status='A' and b1.status='A' and b1.questionid=c1.questionid and find_in_set('"
					+ studentid
					+ "',c1.studentids) group by a1.subjectscheduleid) as assigned, (select count(b1.questionid) from lessonschedule a1,assignemntquestion b1, assignmentmaster c1,assignmenttracking d1 where a1.subjectscheduleid=c.subjectscheduleid and a1.lessonscheduleid=b1.lessonscheduleid and a1.status='A' and b1.status='A' and b1.questionid=c1.questionid and find_in_set('"
					+ studentid
					+ "',c1.studentids) and d1.assignmentid=c1.assignmentid and d1.studentid='"
					+ studentid
					+ "' group by a1.subjectscheduleid) as submitted from sectionschedule a join standardschedule b on a.sectionscheduleid='"
					+ sectionid
					+ "' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' order by c.subjectscheduleid desc";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	/*
	 * This method is accessed from kycportal/jsp/Student/AssignmentList.jsp
	 */
	public ArrayList loadAssignmentViewForStudentSubject(String studentid,
			String subjectscheduleid, String status) {
		log
				.info("invoking loadAssignmentViewForStudentSubject(String studentid,String subjectscheduleid,String status) from com.iGrandee.Assignment.AssignmentStudent");

		ArrayList periodsList = null;
		try {
			if (status != null && status.equals("A"))
				select_query = "select e.lessonscheduleid,f.lessonname,g.questionid,h.assignmentid, g.questionname,g.mark as questionmark, g. file as questionfile,date_format(h.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(h.submissiondate,'%d-%b-%Y') as submissiondate, case when h.submissiondate>=curDate() then 'Available' else 'Not Available' end as datestatus,case when (select mark from assignmenttracking where h.assignmentid = assignmentid  and studentid='"
						+ studentid
						+ "' group by studentid,assignmentid)is null then '-' else (select mark from assignmenttracking where h.assignmentid = assignmentid  and studentid='"
						+ studentid
						+ "' group by studentid,assignmentid) end as obtained from lessonschedule e join lesson f on e.subjectscheduleid='"
						+ subjectscheduleid
						+ "' and e.status='A' and e.lessonid=f.lessonid and f.lessonstatus='A' join assignemntquestion g on e.lessonscheduleid=g.lessonscheduleid and g.status='A' join assignmentmaster h on find_in_set('"
						+ studentid
						+ "',h.studentids) and g.questionid=h.questionid order by e.lessonscheduleid,h.assignmentid desc";
			else if (status != null && status.equals("S"))
				select_query = "select e.lessonscheduleid,f.lessonname,g.questionid,h.assignmentid, g.questionname,g.mark as questionmark, g. file as questionfile,date_format(h.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(h.submissiondate,'%d-%b-%Y') as submissiondate, case when h.submissiondate>=curDate() then 'Available' else 'Not Available' end as datestatus,case when (select mark from assignmenttracking where h.assignmentid = assignmentid  and studentid='"
						+ studentid
						+ "' group by studentid,assignmentid)is null then '-' else (select mark from assignmenttracking where h.assignmentid = assignmentid  and studentid='"
						+ studentid
						+ "' group by studentid,assignmentid) end as obtained from lessonschedule e join lesson f on e.subjectscheduleid='"
						+ subjectscheduleid
						+ "' and e.status='A' and e.lessonid=f.lessonid and f.lessonstatus='A' join assignemntquestion g on e.lessonscheduleid=g.lessonscheduleid and g.status='A' join assignmentmaster h on find_in_set('"
						+ studentid
						+ "',h.studentids) and g.questionid=h.questionid and h.assignmentid in(select assignmentid from assignmenttracking where h.assignmentid = assignmentid  and studentid='"
						+ studentid
						+ "') order by e.lessonscheduleid,h.assignmentid desc";
			else if (status != null && status.equals("Y"))
				select_query = "select e.lessonscheduleid,f.lessonname,g.questionid,h.assignmentid, g.questionname,g.mark as questionmark, g. file as questionfile,date_format(h.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(h.submissiondate,'%d-%b-%Y') as submissiondate, case when h.submissiondate>=curDate() then 'Available' else 'Not Available' end as datestatus,'-' as obtained from lessonschedule e join lesson f on e.subjectscheduleid='"
						+ subjectscheduleid
						+ "' and e.status='A' and e.lessonid=f.lessonid and f.lessonstatus='A' join assignemntquestion g on e.lessonscheduleid=g.lessonscheduleid and g.status='A' join assignmentmaster h on find_in_set('"
						+ studentid
						+ "',h.studentids) and g.questionid=h.questionid and h.assignmentid not in(select assignmentid from assignmenttracking where h.assignmentid = assignmentid  and studentid='"
						+ studentid
						+ "') order by e.lessonscheduleid,h.assignmentid desc";

			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	/*
	 * This method is accessed from kycportal/jsp/Student/AssignmentView.jsp
	 */
	public ArrayList loadStaffForStudentConsolidated(String sectionid,
			String subjectidid) {
		log
				.info("invoking loadStaffForStudentConsolidated(String sectionid,String subjectidid) from com.iGrandee.Assignment.AssignmentStudent");
		ArrayList periodsList = null;
		try {
			select_query = "select b.staffid,concat(prefix,' ',d.firstname,' ',case when d.middlename is null or d.middlename='' then '' else d.middlename end,' ',d.lastname,', ',d.qualification) as staffname from subjectallotment a,staffmaster b,login c,personmaster d where a.subjectscheduleid='"
					+ subjectidid
					+ "' and a.sectionpublishid='"
					+ sectionid
					+ "' and a.subjectallotmentstatus='A' and a.staffid=b.staffid and b.staffstatus='A' and b.userid=c.userid and c.loginstatus='A' and d.personid=c.personid and d.status='A'";
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return periodsList;
	}

	// created by prasanth
	public ArrayList loadAssignmentViewForStudentHomepage(String sectionid,
			String studentid, String assignmentid) {
		log
				.info("invoking loadAssignmentViewForStudent from com.iGrandee.Assignment.AssignmentStudent");

		ArrayList periodsList = null;
		try {
			select_query = "select h.assignmentid,g.questionid,subjectname,lessonname,questionname,g.mark as questionmark, g.file as questionfile,date_format(h.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(h.submissiondate,'%d-%b-%Y') as submissiondate, i.studentremarks,facultyremarks, date_format(studentdate,'%d-%b-%Y') as studentdate, date_format(facultydate,'%d-%b-%Y') as facultydate,i.file,i.mark, c.subjectscheduleid,concat(k.firstname,' ',k.lastname) as staffname, e.lessonscheduleid from sectionschedule a join standardschedule b on a.sectionscheduleid='"
					+ sectionid
					+ "' and a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join lessonschedule e on c.subjectscheduleid=e.subjectscheduleid and e.status='A' join lesson f on e.lessonid=f.lessonid and f.lessonstatus='A' join assignmentmaster h on find_in_set('"
					+ studentid
					+ "',h.studentids) and assignmentid='"
					+ assignmentid
					+ "' join assignemntquestion g on e.lessonscheduleid=g.lessonscheduleid and g.status='A' and g.questionid=h.questionid left outer join assignmenttracking i on h.assignmentid = i.assignmentid and i.studentid='"
					+ studentid
					+ "' left outer join login j on j.userid=g.createdby and j.loginstatus='A' left outer join personmaster k on j.personid=k.personid";
			periodsList = common_data_object.getListMap(select_query);
			// System.out.println(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	public ArrayList loadAssignmentViewForHMHomepage(String assignmentid) {
		log
				.info("invoking loadAssignmentViewForStudent from com.iGrandee.Assignment.AssignmentStudent");

		ArrayList periodsList = null;
		try {
			select_query = "select i.assignmentid,g.questionid,subjectname,lessonname,questionname,g.mark as questionmark,g.file as questionfile,date_format(h.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(h.submissiondate,'%d-%b-%Y') as submissiondate, i.studentremarks,facultyremarks, date_format(studentdate,'%d-%b-%Y') as studentdate, date_format(facultydate,'%d-%b-%Y') as facultydate,i.file,i.mark, c.subjectscheduleid,concat(k.firstname,' ',k.lastname) as staffname, e.lessonscheduleid,l.standardname,m.sectionname,n.sessionname from sectionschedule a join standardschedule b on a.standardscheduleid=b.standardscheduleid and a.sectionschedulestatus='A' and b.stdschedulestatus='A' join subjectschedule c on b.standardscheduleid=c.standardscheduleid and c.status='A' join subject d on c.subjectid=d.subjectid and d.subjectstatus='A' join lessonschedule e on c.subjectscheduleid=e.subjectscheduleid and e.status='A' join lesson f on e.lessonid=f.lessonid and f.lessonstatus='A' join assignmentmaster h on assignmentid='"
					+ assignmentid
					+ "' join assignemntquestion g on e.lessonscheduleid=g.lessonscheduleid and g.status='A' and g.questionid=h.questionid left outer join assignmenttracking i on h.assignmentid = i.assignmentid  left outer join login j on j.userid=g.createdby and j.loginstatus='A' left outer join personmaster k on j.personid=k.personid join standard l on l.standardstatus='A' and l.standardid=b.standardid join section m on m.status='A' and m.sectionid=a.sectionid join yearofsession n on n.sessionstatus='A' and n.sessionid=b.sessionid group by assignmentid";
			periodsList = common_data_object.getListMap(select_query);
			// System.out.println(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	//

	/*
	 * This method is accessed from
	 * kycportal/jsp/Assignment/AssignmentCreation.jsp,kycportal/jsp/Assignment/getAgentCourseInfo.jsp
	 */
	// access by prasanth
	public ArrayList loadAssignmentForSubmit(String assignmentid,
			String studentid) {
		log
				.info("invoking loadAssignmentForSubmit from com.iGrandee.Assignment.AssignmentStudent");

		ArrayList periodsList = null;
		try {
			select_query = "select g.lessonname,questionname,concat(k.prefix,k.firstname,' ',case when k.middlename is null or k.middlename='' then '' else k.middlename end,' ',k.lastname,' ',k.qualification) as staffname, remarks,b.file as questionfile,studentremarks, date_format(a.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(a.submissiondate,'%d-%b-%Y') as submissiondate, c.file,subjectname from assignmentmaster a join assignemntquestion b on a.assignmentid='"
					+ assignmentid
					+ "' and a.questionid=b.questionid join login j on j.userid=b.createdby and j.loginstatus='A' join personmaster k on j.personid=k.personid join lessonschedule d on b.lessonscheduleid=d.lessonscheduleid join subjectschedule e on d.subjectscheduleid=e.subjectscheduleid join subject f on e.subjectid=f.subjectid left outer join assignmenttracking c on c.assignmentid = a.assignmentid and c.studentid='"
					+ studentid
					+ "' join lesson g on f.subjectid=g.subjectid and g.lessonstatus='A'";
			// System.out.println("select_query ===>"+select_query);
			periodsList = common_data_object.getListMap(select_query);
		} catch (Exception exception) {

			log.error(exception);

		}
		return periodsList;
	}

	// access by prasanth

	public int insertAssignment_Tracking(String assignmentid, String agentid,
			String remarks, String studentid, String file, String ipaddress)
			throws SQLException {
		log
				.info("invoking insertAssignment_Tracking from com.iGrandee.Assignment.AssignmentStudent");

		PreparedStatement assignstmt = null;
		PreparedStatement assignlogstmt = null;

		ResultSet idrs = null;
		PreparedStatement idstmt = null;

		ResultSet idlogrs = null;
		PreparedStatement idlogstmt = null;

		ResultSet checkrs = null;
		PreparedStatement checkstmt = null;

		long assignmentracktid = 0l;
		long assignmenlogtid = 0l;

		int returnvalue = 0;
		String sqlquery = "";
		Connection connection = null;

		try {

			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime = DateTime.showTime("MySqlWithTime");

			sqlquery = "select assigntracking from assignmenttracking where studentid=? and assignmentid=?";

			checkstmt = connection.prepareStatement(sqlquery);
			checkstmt.setString(1, studentid);
			checkstmt.setString(2, assignmentid);

			checkrs = checkstmt.executeQuery();

			if (checkrs.next()) {

				assignmentracktid = checkrs.getLong(1);

				sqlquery = "update assignmenttracking set studentremarks=?,file=?,studentdate=? where assigntracking=?";
				assignstmt = connection.prepareStatement(sqlquery);

				assignstmt.setString(1, remarks);
				assignstmt.setString(2, file);
				assignstmt.setString(3, temptime);
				assignstmt.setLong(4, assignmentracktid);

				returnvalue += assignstmt.executeUpdate();

			} else {

				sqlquery = "select max(assigntracking) from assignmenttracking";
				idstmt = connection.prepareStatement(sqlquery);
				idrs = idstmt.executeQuery();

				if (idrs.next()) {
					assignmentracktid = idrs.getLong(1);
				}
				assignmentracktid++;

				sqlquery = "insert into assignmenttracking (assignmentid, assigntracking, studentid, agentid, studentdate, studentremarks, file) values(?,?,?,?,?,?,?)";
				assignstmt = connection.prepareStatement(sqlquery);

				assignstmt.setString(1, assignmentid);
				assignstmt.setLong(2, assignmentracktid);
				assignstmt.setString(3, studentid);
				assignstmt.setString(4, agentid);
				assignstmt.setString(5, temptime);
				assignstmt.setString(6, remarks);
				assignstmt.setString(7, file);

				returnvalue += assignstmt.executeUpdate();

			}

			sqlquery = "select max(assignmentlogid) from assignment_log";
			idlogstmt = connection.prepareStatement(sqlquery);
			idlogrs = idlogstmt.executeQuery();

			if (idlogrs.next()) {
				assignmenlogtid = idlogrs.getLong(1);
			}
			assignmenlogtid++;

			sqlquery = "insert into assignment_log(assignmentlogid, assignmentid, studentid, status, createddate, ipaddress, file) values(?,?,?,?,?,?,?)";
			assignlogstmt = connection.prepareStatement(sqlquery);

			assignlogstmt.setLong(1, assignmenlogtid);
			assignlogstmt.setString(2, assignmentid);
			assignlogstmt.setString(3, studentid);
			assignlogstmt.setString(4, "Insert");
			assignlogstmt.setString(5, temptime);
			assignlogstmt.setString(6, ipaddress);
			assignlogstmt.setString(7, file);

			returnvalue += assignlogstmt.executeUpdate();

			connection.commit();
		} catch (Exception exception) {
			log.error(exception);
			if (connection != null)
				connection.rollback();
			returnvalue = 0;
		} finally {

			if (checkrs != null)
				checkrs.close();

			if (checkstmt != null)
				checkstmt.close();

			if (idrs != null)
				idrs.close();

			if (idstmt != null)
				idstmt.close();

			if (idlogrs != null)
				idlogrs.close();

			if (idlogstmt != null)
				idlogstmt.close();

			if (assignstmt != null)
				assignstmt.close();

			if (assignlogstmt != null)
				assignlogstmt.close();

			if (connection != null)
				connection.close();
		}

		return returnvalue;

	}

	public int insertAssignment_Tracking(AssignmentReplyBean bean)
			throws SQLException {
		log
				.info("invoking insertAssignment_Tracking from com.iGrandee.Assignment.AssignmentStudent");

		String assignmentid = bean.getAssignmentid();
		String agentid = bean.getAgentid();
		String remarks = bean.getStudentremarks();
		String studentid = bean.getStudentid();
		String file = bean.getFile();
		String ipaddress = bean.getIpaddress();

		PreparedStatement assignstmt = null;
		PreparedStatement assignlogstmt = null;

		ResultSet idrs = null;
		PreparedStatement idstmt = null;

		ResultSet idlogrs = null;
		PreparedStatement idlogstmt = null;

		ResultSet checkrs = null;
		PreparedStatement checkstmt = null;

		long assignmentracktid = 0l;
		long assignmenlogtid = 0l;

		int returnvalue = 0;
		String sqlquery = "";
		Connection connection = null;

		try {

			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime = DateTime.showTime("MySqlWithTime");

			sqlquery = "select assigntracking from assignmenttracking where studentid=? and assignmentid=?";

			checkstmt = connection.prepareStatement(sqlquery);
			checkstmt.setString(1, studentid);
			checkstmt.setString(2, assignmentid);

			checkrs = checkstmt.executeQuery();

			if (checkrs.next()) {

				assignmentracktid = checkrs.getLong(1);

				sqlquery = "update assignmenttracking set studentremarks=?,file=?,studentdate=? where assigntracking=?";
				assignstmt = connection.prepareStatement(sqlquery);

				assignstmt.setString(1, remarks);
				assignstmt.setString(2, file);
				assignstmt.setString(3, temptime);
				assignstmt.setLong(4, assignmentracktid);

				returnvalue += assignstmt.executeUpdate();

			} else {

				sqlquery = "select max(assigntracking) from assignmenttracking";
				idstmt = connection.prepareStatement(sqlquery);
				idrs = idstmt.executeQuery();

				if (idrs.next()) {
					assignmentracktid = idrs.getLong(1);
				}
				assignmentracktid++;

				sqlquery = "insert into assignmenttracking (assignmentid, assigntracking, studentid, agentid, studentdate, studentremarks, file) values(?,?,?,?,?,?,?)";
				assignstmt = connection.prepareStatement(sqlquery);

				assignstmt.setString(1, assignmentid);
				assignstmt.setLong(2, assignmentracktid);
				assignstmt.setString(3, studentid);
				assignstmt.setString(4, agentid);
				assignstmt.setString(5, temptime);
				assignstmt.setString(6, remarks);
				assignstmt.setString(7, file);

				returnvalue += assignstmt.executeUpdate();

			}

			sqlquery = "select max(assignmentlogid) from assignment_log";
			idlogstmt = connection.prepareStatement(sqlquery);
			idlogrs = idlogstmt.executeQuery();

			if (idlogrs.next()) {
				assignmenlogtid = idlogrs.getLong(1);
			}
			assignmenlogtid++;

			sqlquery = "insert into assignment_log(assignmentlogid, assignmentid, studentid, status, createddate, ipaddress, file) values(?,?,?,?,?,?,?)";
			assignlogstmt = connection.prepareStatement(sqlquery);

			assignlogstmt.setLong(1, assignmenlogtid);
			assignlogstmt.setString(2, assignmentid);
			assignlogstmt.setString(3, studentid);
			assignlogstmt.setString(4, "Insert");
			assignlogstmt.setString(5, temptime);
			assignlogstmt.setString(6, ipaddress);
			assignlogstmt.setString(7, file);

			returnvalue += assignlogstmt.executeUpdate();

			connection.commit();
		} catch (Exception exception) {
			log.error(exception);
			if (connection != null)
				connection.rollback();
			returnvalue = 0;
		} finally {

			if (checkrs != null)
				checkrs.close();

			if (checkstmt != null)
				checkstmt.close();

			if (idrs != null)
				idrs.close();

			if (idstmt != null)
				idstmt.close();

			if (idlogrs != null)
				idlogrs.close();

			if (idlogstmt != null)
				idlogstmt.close();

			if (assignstmt != null)
				assignstmt.close();

			if (assignlogstmt != null)
				assignlogstmt.close();

			if (connection != null)
				connection.close();
		}

		return returnvalue;

	}

	CommonDataAccess common_data_object;
	String insert_query;
	String select_query;
	int return_value;
	int[] returnvalue;
	Connection connection;
	DateTime datetime;

}
