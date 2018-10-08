package com.iGrandee.Attendance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

// Referenced classes of package com.iGrandee.Common:
//            CommonDataAccess

public class AttendanceQuery {
	static Logger log = Logger.getLogger(AttendanceQuery.class);

	public AttendanceQuery() {
		common_data_object = new CommonDataAccess();
		select_query = null;
	}

	public int checkUser(String s, String s1) {
		int i = 0;
		try {
			ArrayList arraylist = null;
			select_query = "select * from login where username='" + s + "'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info(arraylist);
			if (arraylist != null && arraylist.size() > 0) {
				i = 1;
			}
			select_query = null;
		} catch (Exception exception) {
		}
		return i;
	}

	public ArrayList loadstandard(String boardid, String sessionid,
			String instituteid) {
		ArrayList arraylist = null;
		try {
			select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,date_format(a.enddate,'%d-%b-%Y') as enddate,date_format(a.startdate,'%d-%b-%Y') as startdate from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"
					+ sessionid
					+ "' and b.boardid='"
					+ boardid
					+ "' and a.instituteid='"
					+ instituteid
					+ "'	and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid";
			log.info("===================>>>>>>>>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadsmstemplate() {
		ArrayList arraylist = null;
		try {
			select_query = "select smstemplateid,smstemplatename, smsdescription from smstemplate where smstemplatestatus='A';";
			log.info("===================>>>>>>>>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadsmstemplateID(String smstemplateid) {
		ArrayList arraylist = null;
		try {
			select_query = "select smstemplateid,smstemplatename, smsdescription from smstemplate where smstemplateid='"
					+ smstemplateid + "' and smstemplatestatus='A';";
			log.info("===================>>>>>>>>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);
			// System.out.println(select_query);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadNoofworkingdayabsentod(String studentallocationid,
			String sessionid, String instituteid, String standardscheduleid,
			String status) {
		ArrayList arraylist = null;
		try {
			select_query = "select DATEDIFF(enddate,startdate)-(SELECT count(a.schoolcalendarid) FROM schoolcalendar a,standardschedule b where a.sessionid='"
					+ sessionid
					+ "' and a.calendarstatus='A' and b.instituteid='"
					+ instituteid
					+ "' AND b.sessionid=a.sessionid and b.startdate >=startdate   and    b.enddate<= enddate and b.stdschedulestatus='A' and a.holidaystatus='Y') as totalworkingdays,(select count(a.studentattendanceid) from studentattendance a,studentallocation b where a.attendancedate between startdate and enddate and a.studentattendancestatus='A'  and b.studentallocationid=a.studentallocationid and b.studentallocationstatus in ('"
					+ status
					+ "') and b.studentallocationid='"
					+ studentallocationid
					+ "' and a.studentstate='P')as noofpreset,(select count(a.studentattendanceid) from studentattendance a,studentallocation b where a.attendancedate between startdate and enddate and a.studentattendancestatus='A'  and b.studentallocationid=a.studentallocationid and b.studentallocationstatus in ('"
					+ status
					+ "') and b.studentallocationid='"
					+ studentallocationid
					+ "' and a.studentstate='A')as noofabsent,(select count(a.studentattendanceid) from studentattendance a,studentallocation b where a.attendancedate between startdate and enddate and a.studentattendancestatus='A'  and b.studentallocationid=a.studentallocationid and b.studentallocationstatus in ('"
					+ status
					+ "') and b.studentallocationid='"
					+ studentallocationid
					+ "' and a.studentstate='OD')as noofod from standardschedule where standardscheduleid='"
					+ standardscheduleid + "' and stdschedulestatus='A'";
			// select_query = "select
			// a.standardscheduleid,b.standardname,(select groupname from
			// standardgroup x where x.groupid=a.groupid) as groupname from
			// standardschedule a join standard b where
			// a.standardid=b.standardid and a.sessionid='"+sessionid+"' and
			// b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' group
			// by a.standardscheduleid order by a.standardid";
			// select_query = "SELECT a.standardname,b.standardscheduleid FROM
			// standard a,standardschedule b where a.standardid =b.standardid
			// and boardid='"+boardid+"' and b.sessionid='"+sessionid+"' and
			// a.instituteid='"+instituteid+"' order by a.standardid ";
			log.info("===================>>>>>>>>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);
			// log.info("==========>>>>>"+arraylist);
			// System.out.println("========>>>>>>>>>>"+select_query);
		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList nextpreviousdate(String searchdate) {
		ArrayList arraylist = null;
		try {
			select_query = "select DATE_ADD('" + searchdate
					+ "', INTERVAL(-1) DAY) as previousdate,case when	'"
					+ searchdate + "'<curdate() then DATE_ADD('" + searchdate
					+ "', INTERVAL(1) DAY) else null end as nextdate";
			log.info("===================>>>>>>>>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}

	public ArrayList loadwholestudent(String sessionid) {
		ArrayList arraylist = null;
		try {
			select_query = "select d.sessionid,(select groupname from standardgroup x where x.groupid=d.groupid) as groupname,sta.standardname,sec.sectionname,sec.sectionid,sta.standardid,g.sectionscheduleid,b.standardpublishid,g.studentallocationid,g.rollno, f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as 	dateofallocation,a.applicantname,a.applicationno from applicationissue a 	join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid 	and a.sessionid='"
					+ sessionid
					+ "'  and a.status='A' and b.status='A' join yearofsession c 	on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on 	b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' 	join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' 	join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' 	join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus='A' join standard sta on sta.standardid=d.standardid  and sta.standardstatus='A' join sectionschedule  secs on secs.sectionscheduleid=g.sectionscheduleid and d.standardscheduleid=secs.standardscheduleid and secs.sectionschedulestatus='A' join section sec on sec.sectionid=secs.sectionid and sec.status='A'order by sta.standardid,sec.sectionid";
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	/*
	 * created by maruthu And Accessed in YearofsessionAttendanceView.jsp
	 */
	public ArrayList loadAbsentesscount(String sessionid,
			String standardscheduleid, String searchdate) {
		ArrayList arraylist = null;
		try {
			//
			select_query = "SELECT 	count(stua.studentallocationid) as absentees,DATE_ADD('"
					+ searchdate
					+ "', INTERVAL(-1) DAY) as previousdate,case when	'"
					+ searchdate
					+ "'<curdate() then DATE_ADD('"
					+ searchdate
					+ "', INTERVAL(1) DAY) else null end as nextdate,secs.standardscheduleid,(select groupname from standardgroup x where x.groupid=d.groupid) as groupname,sec.sectionname,sta.standardname,stua.studentallocationid,studentattendanceid FROM  standardschedule d";
			select_query += " join standard sta on sta.standardid=d.standardid";
			select_query += " join sectionschedule secs on secs.standardscheduleid= d.standardscheduleid";
			select_query += " join section sec on sec.sectionid=secs.sectionid";
			select_query += " join studentallocation sa on sa.sectionscheduleid=secs.sectionscheduleid";
			select_query += " join candidateregister c on c.candidateregisterid=sa.candidateregisterid";
			select_query += " join studentattendance stua on stua.studentallocationid=sa.studentallocationid";
			select_query += " and attendancedate='" + searchdate
					+ "' and studentstate='A'";
			select_query += " and c.candidateregisterstatus='A' and sa.studentallocationstatus='A'";
			select_query += " and d.sessionid='" + sessionid
					+ "' and sec.status='A' and secs.sectionschedulestatus='A'";
			select_query += " and d.stdschedulestatus='A' and studentattendancestatus ='A' ";
			select_query += " and sta.standardstatus='A' and  d.standardscheduleid='"
					+ standardscheduleid + "'   group by d.standardscheduleid";
			log.info("select_query==========>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);
		} catch (Exception exception) {
		}
		return arraylist;
	}

	/*
	 * created by maruthu And Accessed in YearofsessionAttendanceView.jsp
	 */
	public ArrayList loadpresentcount(String sessionid,
			String standardscheduleid, String searchdate) {
		ArrayList arraylist = null;
		try {
			//
			select_query = "SELECT 	count(stua.studentallocationid) as present,DATE_ADD('"
					+ searchdate
					+ "', INTERVAL(-1) DAY) as previousdate,case when	'"
					+ searchdate
					+ "'<curdate() then DATE_ADD('"
					+ searchdate
					+ "', INTERVAL(1) DAY) else null end as nextdate,secs.standardscheduleid,(select groupname from standardgroup x where x.groupid=d.groupid) as groupname,sec.sectionname,sta.standardname,stua.studentallocationid,studentattendanceid FROM  standardschedule d";
			select_query += " join standard sta on sta.standardid=d.standardid";
			select_query += " join sectionschedule secs on secs.standardscheduleid= d.standardscheduleid";
			select_query += " join section sec on sec.sectionid=secs.sectionid";
			select_query += " join studentallocation sa on sa.sectionscheduleid=secs.sectionscheduleid";
			select_query += " join candidateregister c on c.candidateregisterid=sa.candidateregisterid";
			select_query += " join studentattendance stua on stua.studentallocationid=sa.studentallocationid";
			select_query += " and attendancedate='" + searchdate
					+ "' and studentstate in ('P','OD')";
			select_query += " and c.candidateregisterstatus='A' and sa.studentallocationstatus='A'";
			select_query += " and d.sessionid='" + sessionid
					+ "' and sec.status='A' and secs.sectionschedulestatus='A'";
			select_query += " and d.stdschedulestatus='A' and studentattendancestatus ='A' ";
			select_query += " and sta.standardstatus='A' and  d.standardscheduleid='"
					+ standardscheduleid + "'   group by d.standardscheduleid";
			log.info("select_query==========>>>>>" + select_query);

			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);
		} catch (Exception exception) {
		}
		return arraylist;
	}

	/*
	 * created by maruthu And Accessed in AbsenteesListView.jsp
	 */
	public ArrayList loadAbsentStudent(String sessionid,
			String standardscheduleid, String searchdate, String state) {
		ArrayList arraylist = null;
		try {
			//
			select_query = "SELECT sa.rollno,pm.mobilenumber,pa.smscontactno,pm.emailid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname ) end as uname,stua.studentallocationid,";
			select_query += " stua.studentallocationid,secs.standardscheduleid,(select groupname from standardgroup x where x.groupid=d.groupid) as groupname,sec.sectionname,sta.standardname,stua.studentallocationid,studentattendanceid FROM  standardschedule d";
			select_query += " join standard sta on sta.standardid=d.standardid";
			select_query += " join sectionschedule secs on secs.standardscheduleid= d.standardscheduleid";
			select_query += " join section sec on sec.sectionid=secs.sectionid";
			select_query += " join studentallocation sa on sa.sectionscheduleid=secs.sectionscheduleid and sa.studentallocationstatus='A'";
			select_query += " join candidateregister c on c.candidateregisterid=sa.candidateregisterid";
			select_query += " join studentattendance stua on stua.studentallocationid=sa.studentallocationid";
			select_query += " join personmaster pm on pm.personid=c.personid	and pm.status='A'";
			select_query += " and attendancedate='"
					+ searchdate
					+ "' join personaddress pa on pa.personid=pm.personid and pa.peraddstatus='A' ";
			if (state.equals("A"))
				select_query += " and studentstate='A'";
			else if (state.equals("P"))
				select_query += " and studentstate in ('P','OD')";
			else
				select_query += " and studentstate in ('A')";

			select_query += " and c.candidateregisterstatus='A' and sa.studentallocationstatus='A'";
			select_query += " and d.sessionid='" + sessionid
					+ "' and sec.status='A' and secs.sectionschedulestatus='A'";
			select_query += " and d.stdschedulestatus='A' and studentattendancestatus ='A' ";
			select_query += " and sta.standardstatus='A' and  d.standardscheduleid='"
					+ standardscheduleid + "'";
			log.info("select_query==========>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	/*
	 * created by maruthu And Accessed in StandardWiseAttendanceView.jsp
	 */
	public ArrayList loadAbsentStudentSectionWise(String sessionid,
			String standardscheduleid, String sectionscheduleid,
			String searchdate, String state) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT sa.rollno,pm.mobilenumber,pm.emailid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname ) end as uname,stua.studentallocationid,";
			select_query += "secs.standardscheduleid,(select groupname from standardgroup x where x.groupid=d.groupid) as groupname,sec.sectionname,sta.standardname,stua.studentallocationid,studentattendanceid FROM  standardschedule d";
			select_query += " join standard sta on sta.standardid=d.standardid";
			select_query += " join sectionschedule secs on secs.standardscheduleid= d.standardscheduleid";
			select_query += " join section sec on sec.sectionid=secs.sectionid";
			select_query += " join studentallocation sa on sa.sectionscheduleid=secs.sectionscheduleid";
			select_query += " join candidateregister c on c.candidateregisterid=sa.candidateregisterid";
			select_query += " join studentattendance stua on stua.studentallocationid=sa.studentallocationid";
			select_query += " join personmaster pm on pm.personid=c.personid	and pm.status='A'";
			select_query += " and secs.sectionscheduleid='" + sectionscheduleid
					+ "' and attendancedate='" + searchdate + "'";
			if (state.equals("A"))
				select_query += " and studentstate='A'";
			else if (state.equals("P"))
				select_query += " and studentstate in ('P','OD')";
			else
				select_query += " and studentstate in ('A')";
			select_query += " and c.candidateregisterstatus='A' and sa.studentallocationstatus='A'";
			select_query += " and d.sessionid='" + sessionid
					+ "' and sec.status='A' and secs.sectionschedulestatus='A'";
			select_query += " and d.stdschedulestatus='A' and studentattendancestatus ='A' ";
			select_query += " and sta.standardstatus='A' and  d.standardscheduleid='"
					+ standardscheduleid + "'";
			log.info("select_query==========>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);
		} catch (Exception exception) {
		}
		return arraylist;
	}

	/*
	 * created by maruthu And Accessed in AbsenteesListView.jsp
	 */
	public ArrayList loadAbsentesscountforStandard(String sessionid,
			String standardscheduleid, String sectionscheduleid,
			String searchdate, String state) {
		ArrayList arraylist = null;
		try {
			//
			select_query = "SELECT count(stua.studentallocationid) as absentees,secs.standardscheduleid,(select groupname from standardgroup x where x.groupid=d.groupid) as groupname,sec.sectionname,sta.standardname,stua.studentallocationid,studentattendanceid FROM  standardschedule d";
			select_query += " join standard sta on sta.standardid=d.standardid";
			select_query += " join sectionschedule secs on secs.standardscheduleid= d.standardscheduleid";
			select_query += " join section sec on sec.sectionid=secs.sectionid";
			select_query += " join studentallocation sa on sa.sectionscheduleid=secs.sectionscheduleid";
			select_query += " join candidateregister c on c.candidateregisterid=sa.candidateregisterid";
			select_query += " join studentattendance stua on stua.studentallocationid=sa.studentallocationid";
			select_query += " and secs.sectionscheduleid='" + sectionscheduleid
					+ "' and attendancedate='" + searchdate + "' ";
			if (state.equals("A"))
				select_query += " and studentstate='A'";
			else if (state.equals("P"))
				select_query += " and studentstate in ('P','OD')";
			else
				select_query += " and studentstate in ('A')";
			select_query += " and c.candidateregisterstatus='A' and sa.studentallocationstatus='A'";
			select_query += " and d.sessionid='" + sessionid
					+ "' and sec.status='A' and secs.sectionschedulestatus='A'";
			select_query += " and d.stdschedulestatus='A' and studentattendancestatus ='A' ";
			select_query += " and sta.standardstatus='A' and  d.standardscheduleid='"
					+ standardscheduleid
					+ "'  group by secs.standardscheduleid";
			log.info("select_query==========>>>>>" + select_query);

			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadsection(String standardscheduleid, String instituteid) {
		ArrayList arraylist = null;
		try {

			select_query = "SELECT a.sectionscheduleid,b.sectionname FROM sectionschedule a ,section b where a.sectionid=b.sectionid and a.standardscheduleid='"
					+ standardscheduleid
					+ "' and  b.instituteid='"
					+ instituteid
					+ "' and a.sectionschedulestatus='A' and b.status='A' order by a.sectionid ";
			log.info("==========>>>>>" + select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadstudent(String standardscheduleidid, String sessionid,
			String sectionscheduleid, String instituteid) {
		ArrayList arraylist = null;
		try {

			// select_query = "select
			// g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y')
			// as dateofallocation,a.applicantname,a.applicationno from
			// applicationissue a join registration b on
			// a.applicationid=b.applicationid and
			// a.standardpublishid=b.standardpublishid and
			// a.sessionid='"+sessionid+"' and
			// b.standardpublishid='"+standardscheduleidid+"' and a.status='A'
			// and b.status='A' join yearofsession c on a.sessionid=c.sessionid
			// and c.sessionstatus='A' join standardschedule d on
			// b.standardpublishid=d.standardscheduleid and
			// d.stdschedulestatus='A' join studentapproval e on
			// e.registrationid=b.registrationid and e.approvalstatus='A' join
			// candidateregister f on f.studentapprovalid=e.studentapprovalid
			// and f.candidateregisterstatus='A' join studentallocation g on
			// g.candidateregisterid=f.candidateregisterid and
			// g.sectionscheduleid='"+sectionscheduleid+"' and
			// g.studentallocationstatus='A'";
			select_query = "select case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname )"
					+ " end as applicantname,f.personid,g.studentallocationid,case when g.rollno is null then 'NYG' else g.rollno end as rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation"
					+ " from studentallocation g"
					+ " join candidateregister f    on g.candidateregisterid=f.candidateregisterid"
					+ " join sectionschedule secs   on secs.sectionscheduleid=g.sectionscheduleid"
					+ " join standardschedule d     on d.standardscheduleid=secs.standardscheduleid"
					+ " join personmaster pm        on pm.personid=f.personid"
					+ " and pm.status='A'           and d.stdschedulestatus='A'       and f.candidateregisterstatus='A'"
					+ " and g.sectionscheduleid='"
					+ sectionscheduleid
					+ "' and secs.standardscheduleid='"
					+ standardscheduleidid
					+ "'   and d.sessionid='"
					+ sessionid
					+ "'"
					+ " and d.instituteid='"
					+ instituteid
					+ "'       and g.studentallocationstatus='A' and secs.sectionschedulestatus='A'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadstudentwithstatus(String standardscheduleidid,
			String sessionid, String sectionscheduleid, String instituteid,
			String status) {
		ArrayList arraylist = null;
		try {

			// select_query = "select
			// g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y')
			// as dateofallocation,a.applicantname,a.applicationno from
			// applicationissue a join registration b on
			// a.applicationid=b.applicationid and
			// a.standardpublishid=b.standardpublishid and
			// a.sessionid='"+sessionid+"' and
			// b.standardpublishid='"+standardscheduleidid+"' and a.status='A'
			// and b.status='A' join yearofsession c on a.sessionid=c.sessionid
			// and c.sessionstatus='A' join standardschedule d on
			// b.standardpublishid=d.standardscheduleid and
			// d.stdschedulestatus='A' join studentapproval e on
			// e.registrationid=b.registrationid and e.approvalstatus='A' join
			// candidateregister f on f.studentapprovalid=e.studentapprovalid
			// and f.candidateregisterstatus='A' join studentallocation g on
			// g.candidateregisterid=f.candidateregisterid and
			// g.sectionscheduleid='"+sectionscheduleid+"' and
			// g.studentallocationstatus='A'";
			select_query = "select case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname )"
					+ " end as applicantname,f.personid,g.studentallocationid,case when g.rollno is null then 'NYG' else g.rollno end as rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation"
					+ " from studentallocation g"
					+ " join candidateregister f    on g.candidateregisterid=f.candidateregisterid"
					+ " join sectionschedule secs   on secs.sectionscheduleid=g.sectionscheduleid"
					+ " join standardschedule d     on d.standardscheduleid=secs.standardscheduleid"
					+ " join personmaster pm        on pm.personid=f.personid"
					+ " and pm.status='A'           and d.stdschedulestatus='A'       and f.candidateregisterstatus='A'"
					+ " and g.sectionscheduleid='"
					+ sectionscheduleid
					+ "' and secs.standardscheduleid='"
					+ standardscheduleidid
					+ "'   and d.sessionid='"
					+ sessionid
					+ "'"
					+ " and d.instituteid='"
					+ instituteid
					+ "'       and g.studentallocationstatus in ('"
					+ status
					+ "') and secs.sectionschedulestatus='A'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);
			// System.out.println("select_query========>>>>>"+select_query);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadboard(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "select a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b where a.mediumid=b.mediumid and a.instituteid='"
					+ instituteid
					+ "' and a.boardstatus='A' and b.mediumstatus='A' order by a.boardid,b.mediumid";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}

	/*
	 * created by maruthu accessed in
	 */

	public ArrayList loadsms() {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT smstemplateid, smstemplatename, smsdescription FROM smstemplate s where smstemplatestatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			// log.info("==========>>>>>"+arraylist);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadyearofsession(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT sessionstatus,sessionid,sessionname FROM yearofsession where instituteid='"
					+ instituteid + "'  and sessionstatus in ('A','R');";
			arraylist = common_data_object.getListMap(select_query);
			// log.info("==========>>>>>"+arraylist);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	public ArrayList loadreligion(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT religionid,religionname FROM religion r where instituteid='"
					+ instituteid + "' and relistatus='A'";
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}

	public ArrayList getattendanceforstudent(String studentallocationid,
			String attendancedate) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT studentattendanceid,studentstate FROM studentattendance s where studentallocationid='"
					+ studentallocationid
					+ "'  and attendancedate ='"
					+ attendancedate + "' and studentattendancestatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			// System.out.println("select_query=====>>>"+select_query);

		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}

	public String toGetAllDates(String monthPick) throws Exception {
		String datee = "";
		try {
			String monthPickarray[] = monthPick.split("-");
			String qry = "SELECT DAYOFMONTH(LAST_DAY('" + monthPickarray[1]
					+ "-" + monthPickarray[0] + "-01'));";
			datee = common_data_object.getString(qry);
			// log.info("Select query========>>>>>"+qry);
		} catch (Exception de) {
			// log.info("Exception toGetAllDates=============>
			// "+de.getMessage());
			// de.printStackTrace();
			log.error(de);
		}
		return datee;
	}

	public String toGetDayfordate(String date) throws Exception {
		String datee = "";
		try {
			String qry = "SELECT  DAYNAME('" + date + "')";
			datee = common_data_object.getString(qry);
			// log.info("Select query========>>>>>"+qry);
		} catch (Exception de) {
			// log.info("Exception toGetAllDates=============>
			// "+de.getMessage());
			// de.printStackTrace();
			log.error(de);
		}
		return datee;
	};

	public ArrayList getattendanceforview(String studentallocationid,
			String attendancedate) {
		ArrayList arraylist = null;

		try {

			select_query = "SELECT studentattendanceid,studentstate FROM studentattendance s where studentallocationid='"
					+ studentallocationid
					+ "'  and attendancedate ='"
					+ attendancedate + "' and studentattendancestatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			// log.info("Studentstaus========>>>>>>"+arraylist);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}

	public ArrayList getweekdatesforgivendate(String date) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT  DATE_ADD('" + date
					+ "', INTERVAL(1-DAYOFWEEK('" + date
					+ "')) DAY) as date1 ,DAYNAME(DATE_ADD('" + date
					+ "', INTERVAL(1-DAYOFWEEK('" + date
					+ "')) DAY)) as day1,DATE_ADD('" + date
					+ "', INTERVAL(2-DAYOFWEEK('" + date
					+ "')) DAY) as date2,DAYNAME(DATE_ADD('" + date
					+ "', INTERVAL(2-DAYOFWEEK('" + date
					+ "')) DAY)) as day2,DATE_ADD('" + date
					+ "', INTERVAL(3-DAYOFWEEK('" + date
					+ "')) DAY) as date3, DAYNAME(DATE_ADD('" + date
					+ "', INTERVAL(3-DAYOFWEEK('" + date
					+ "')) DAY)) as day3,DATE_ADD('" + date
					+ "', INTERVAL(4-DAYOFWEEK('" + date
					+ "')) DAY) as date4, DAYNAME(DATE_ADD('" + date
					+ "', INTERVAL(4-DAYOFWEEK('" + date
					+ "')) DAY)) as day4,DATE_ADD('" + date
					+ "', INTERVAL(5-DAYOFWEEK('" + date
					+ "')) DAY) as date5, DAYNAME(DATE_ADD('" + date
					+ "', INTERVAL(5-DAYOFWEEK('" + date
					+ "')) DAY)) as day5,DATE_ADD('" + date
					+ "', INTERVAL(6-DAYOFWEEK('" + date
					+ "')) DAY) as date6,DAYNAME(DATE_ADD('" + date
					+ "', INTERVAL(6-DAYOFWEEK('" + date
					+ "')) DAY)) as day6,DATE_ADD('" + date
					+ "', INTERVAL(7-DAYOFWEEK('" + date
					+ "')) DAY) as date7,DAYNAME(DATE_ADD('" + date
					+ "', INTERVAL(7-DAYOFWEEK('" + date + "')) DAY)) as day7";
			// select_query = "SELECT DATE_ADD('"+date+"',
			// INTERVAL(1-DAYOFWEEK('"+date+"')) DAY) as date1
			// ,DATE_ADD('"+date+"', INTERVAL(2-DAYOFWEEK('"+date+"')) DAY) as
			// date2,DATE_ADD('"+date+"', INTERVAL(3-DAYOFWEEK('"+date+"')) DAY)
			// as date3, DATE_ADD('"+date+"', INTERVAL(4-DAYOFWEEK('"+date+"'))
			// DAY) as date4, DATE_ADD('"+date+"',
			// INTERVAL(5-DAYOFWEEK('"+date+"')) DAY) as date5,
			// DATE_ADD('"+date+"', INTERVAL(6-DAYOFWEEK('"+date+"')) DAY) as
			// date6, DATE_ADD('"+date+"', INTERVAL(7-DAYOFWEEK('"+date+"'))
			// DAY) as date7,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(1-DAYOFWEEK('"+date+"')) DAY)) as
			// day1,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(2-DAYOFWEEK('"+date+"')) DAY)) as
			// day2,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(3-DAYOFWEEK('"+date+"')) DAY)) as
			// day3,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(4-DAYOFWEEK('"+date+"')) DAY)) as
			// day4,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(5-DAYOFWEEK('"+date+"')) DAY)) as
			// day5,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(6-DAYOFWEEK('"+date+"')) DAY)) as
			// day6,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(7-DAYOFWEEK('"+date+"')) DAY)) as day7";
			arraylist = common_data_object.getList(select_query);
			// System.out.print("Studentstaus========>>>>>>"+select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}

	public ArrayList getweekprenextdatesforgivendate(String date) {
		ArrayList arraylist = null;
		try {
			select_query = "select	DATE_ADD('" + date
					+ "', INTERVAL(0-DAYOFWEEK('" + date
					+ "')) DAY) as previousdate,	DATE_ADD('" + date
					+ "', INTERVAL(8-DAYOFWEEK('" + date
					+ "')) DAY) as nextdate";
			// select_query = "SELECT DATE_ADD('"+date+"',
			// INTERVAL(1-DAYOFWEEK('"+date+"')) DAY) as date1
			// ,DATE_ADD('"+date+"', INTERVAL(2-DAYOFWEEK('"+date+"')) DAY) as
			// date2,DATE_ADD('"+date+"', INTERVAL(3-DAYOFWEEK('"+date+"')) DAY)
			// as date3, DATE_ADD('"+date+"', INTERVAL(4-DAYOFWEEK('"+date+"'))
			// DAY) as date4, DATE_ADD('"+date+"',
			// INTERVAL(5-DAYOFWEEK('"+date+"')) DAY) as date5,
			// DATE_ADD('"+date+"', INTERVAL(6-DAYOFWEEK('"+date+"')) DAY) as
			// date6, DATE_ADD('"+date+"', INTERVAL(7-DAYOFWEEK('"+date+"'))
			// DAY) as date7,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(1-DAYOFWEEK('"+date+"')) DAY)) as
			// day1,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(2-DAYOFWEEK('"+date+"')) DAY)) as
			// day2,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(3-DAYOFWEEK('"+date+"')) DAY)) as
			// day3,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(4-DAYOFWEEK('"+date+"')) DAY)) as
			// day4,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(5-DAYOFWEEK('"+date+"')) DAY)) as
			// day5,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(6-DAYOFWEEK('"+date+"')) DAY)) as
			// day6,DAYNAME(DATE_ADD('"+date+"',
			// INTERVAL(7-DAYOFWEEK('"+date+"')) DAY)) as day7";
			arraylist = common_data_object.getList(select_query);
			log.info("select_query========>>>>>>" + select_query);
			// System.out.println("select_query========>>>>>>"+select_query);
			log.info("Studentstaus========>>>>>>" + arraylist);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}

	public int Studentattendanceinsert(AttendanceBean beanobj)
			throws SQLException {
		int result = 0;

		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;

		log
				.info("invoking Studentattendanceinsert for Student attendance insert");

		String Query = "";
		Connection connection = null;

		try {

			long max_studentattendanceid = common_data_object
					.fmaxId("select max(studentattendanceid) from studentattendance");
			long max_studattendancelogid = common_data_object
					.fmaxId("select max(studattendancelogid) from studentattendancelog");
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			log.info("=====max_studattendancelogid======="
					+ max_studattendancelogid);

			// connection = ConnectionManager.getKycConnection();
			String Editstatus[] = beanobj.getEditstatus();
			String studentattendanceid[] = beanobj.getAttendanceid();
			String Studentallocationid[] = beanobj.getStudentallocationid();
			String Studentattendancestatus[] = beanobj
					.getStudentattendancestatus();
			log.info(Editstatus.length + "=====Editstatus======="
					+ studentattendanceid.length
					+ "=====studentattendanceid======="
					+ Studentallocationid.length
					+ "=====Studentallocationid======="
					+ Studentattendancestatus.length
					+ "=====Studentattendancestatus=======");
			if (Studentallocationid != null && Studentallocationid.length > 0
					&& Studentattendancestatus != null
					&& Studentattendancestatus.length > 0 && Editstatus != null
					&& Editstatus.length > 0 && studentattendanceid != null
					&& studentattendanceid.length > 0) {
				for (int i = 0; i < Studentallocationid.length; i++) {
					String editstatus = Editstatus[i];
					if (editstatus.equals("new")) {
						Query = "insert into studentattendance (studentattendanceid, attendancedate, studentallocationid, studentstate, createdby, dateofcreation, ipaddress, studentattendancestatus) values(?,?,?,?,?,?,?,?)";
						pstmt = connection.prepareStatement(Query);
						pstmt.setLong(1, max_studentattendanceid);
						pstmt.setString(2, beanobj.getDateofattendance());
						pstmt.setString(3, Studentallocationid[i]);
						pstmt.setString(4, Studentattendancestatus[i]);
						pstmt.setString(5, beanobj.getCreatedby());
						pstmt.setString(6, datetime.showTime("MySqlWithTime"));
						pstmt.setString(7, beanobj.getIpaddress());
						pstmt.setString(8, "A");
						result += pstmt.executeUpdate();
						max_studentattendanceid++;
					} else if (editstatus.equals("update")) {
						Query = "update studentattendance  set  studentstate=?,dateofcreation=?,ipaddress=? where attendancedate=? and studentallocationid=? and studentattendanceid=?";
						pstmt = connection.prepareStatement(Query);
						pstmt.setString(1, Studentattendancestatus[i]);
						pstmt.setString(2, datetime.showTime("MySqlWithTime"));
						pstmt.setString(3, beanobj.getIpaddress());
						pstmt.setString(4, beanobj.getDateofattendance());
						pstmt.setString(5, Studentallocationid[i]);
						pstmt.setString(6, studentattendanceid[i]);

						result += pstmt.executeUpdate();

						Query = "insert into studentattendancelog (studattendancelogid, logdescription, studentattendanceid, dateofcreation, ipaddress, studattendancelogstatus) values(?,?,?,?,?,?)";
						pstmt1 = connection.prepareStatement(Query);

						pstmt1.setLong(1, max_studattendancelogid);
						pstmt1.setString(2, "updated");
						pstmt1.setString(3, studentattendanceid[i]);
						pstmt1
								.setString(4, datetime
										.showTime("databaseinsert"));
						pstmt1.setString(5, beanobj.getIpaddress());
						pstmt1.setString(6, "A");

						result += pstmt1.executeUpdate();

						max_studattendancelogid++;
					} else if (editstatus.equals("delete")) {
						Query = "update studentattendance  set  studentattendancestatus=?,dateofcreation=?,ipaddress=? where attendancedate=? and studentallocationid=? and studentattendanceid=?";
						pstmt = connection.prepareStatement(Query);
						pstmt.setString(1, Studentattendancestatus[i]);
						pstmt.setString(2, datetime.showTime("MySqlWithTime"));
						pstmt.setString(3, beanobj.getIpaddress());
						pstmt.setString(4, beanobj.getDateofattendance());
						pstmt.setString(5, Studentallocationid[i]);
						pstmt.setString(6, studentattendanceid[i]);
						result += pstmt.executeUpdate();
						Query = "insert into studentattendancelog (studattendancelogid, logdescription, studentattendanceid, dateofcreation, ipaddress, studattendancelogstatus) values(?,?,?,?,?,?)";
						pstmt1 = connection.prepareStatement(Query);

						pstmt1.setLong(1, max_studattendancelogid);
						pstmt1.setString(2, "deleted");
						pstmt1.setString(3, studentattendanceid[i]);
						pstmt1
								.setString(4, datetime
										.showTime("databaseinsert"));
						pstmt1.setString(5, beanobj.getIpaddress());
						pstmt1.setString(6, "A");

						result += pstmt1.executeUpdate();

						max_studattendancelogid++;
					}
				}
			}
			log.info("Studentattendanceinsert================>>");
			connection.commit();

		} catch (Exception exception) {
			if (connection != null)
				connection.rollback();
			log.error(exception);
			exception.printStackTrace();
			return 0;
		} finally {
			if (pstmt != null)
				pstmt.close();

			if (connection != null)
				connection.close();

		}
		return result;
	}
	
	/**
	 *  Created by Subhash.D
	 *  This method used for loading the attendance in staff login.
	 * @param studentallocationid,attendancedate
	 * @return
	 * @throws Exception
	 */
	public ArrayList getattendanceforstudentstaff(String studentallocationid,String attendancedate) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT a.studentattendanceid,a.studentstate,(select concat(c1.prefix,' ',c1.firstname,' ',case when c1.middlename is null or c1.middlename='' then '' else c1.middlename end,c1.lastname) from login a1, staffmaster b1,personmaster c1 where a1.userid=a.createdby and a1.userid=b1.userid and c1.personid=a1.personid) as staffname,a.createdby,date_format(a.dateofcreation,'%d-%b-%Y %r') as dateofcreation,a.createdby FROM studentattendance a where a.studentallocationid='"
					+ studentallocationid
					+ "'  and a.attendancedate ='"
					+ attendancedate + "' and a.studentattendancestatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			// System.out.println("select_query=====>>>"+select_query);

		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
	
	/**
	 * Created by Subhash.D
	 *  This method used for entering the attendance for student.
	 * @param beanobj
	 * @return
	 * @throws SQLException
	 */
	public int Studentattendanceinsertser(AttendanceBean beanobj)
	throws SQLException{

		int result = 0;
		String returnnames		= "";
		String returnids		= "";
		PreparedStatement pstmt  = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		ResultSet attrs		 = null;
		log
				.info("invoking Studentattendanceinsert for Student attendance insert");

		String Query = "";
		Connection connection = null;

		try {

			long max_studentattendanceid = common_data_object
					.fmaxId("select max(studentattendanceid) from studentattendance");
			long max_studattendancelogid = common_data_object
					.fmaxId("select max(studattendancelogid) from studentattendancelog");
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			log.info("=====max_studattendancelogid======="
					+ max_studattendancelogid);

			// connection = ConnectionManager.getKycConnection();
			String Editstatus[] = beanobj.getEditstatus();
			String studentattendanceid[] = beanobj.getAttendanceid();
			String Studentallocationid[] = beanobj.getStudentallocationid();
			String Studentattendancestatus[] = beanobj
					.getStudentattendancestatus();
			log.info(Editstatus.length + "=====Editstatus======="
					+ studentattendanceid.length
					+ "=====studentattendanceid======="
					+ Studentallocationid.length
					+ "=====Studentallocationid======="
					+ Studentattendancestatus.length
					+ "=====Studentattendancestatus=======");
			if (Studentallocationid != null && Studentallocationid.length > 0
					&& Studentattendancestatus != null
					&& Studentattendancestatus.length > 0 && Editstatus != null
					&& Editstatus.length > 0 && studentattendanceid != null
					&& studentattendanceid.length > 0) {
					
					Query	= "select case when pm.middlename='-' or pm.middlename='' or pm.middlename is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname ) end as applicantname from studentallocation g join candidateregister f on g.candidateregisterid=f.candidateregisterid join sectionschedule secs on secs.sectionscheduleid=g.sectionscheduleid join standardschedule d on d.standardscheduleid=secs.standardscheduleid join personmaster pm on pm.personid=f.personid and pm.status='A' and d.stdschedulestatus='A'  and f.candidateregisterstatus='A' and g.studentallocationstatus='A' and secs.sectionschedulestatus='A' join studentattendance sa on sa.attendancedate=? and sa.studentallocationid=? and sa.createdby!=? and sa.studentattendancestatus='A' and g.studentallocationid=sa.studentallocationid"; 
					pstmt2	= connection.prepareStatement(Query);
				
				for (int i = 0; i < Studentallocationid.length; i++) {
					String editstatus = Editstatus[i];
					String usercategory = beanobj.getUsercategory();
					if(usercategory!=null && usercategory.equals("T"))
					{
						pstmt2.setString(1, beanobj.getDateofattendance());
						pstmt2.setString(2, Studentallocationid[i]);
						pstmt2.setString(3, beanobj.getCreatedby());
						attrs	= pstmt2.executeQuery();
					}
					if(attrs==null || !attrs.next()){
					if (editstatus.equals("new")) {
						Query = "insert into studentattendance (studentattendanceid, attendancedate, studentallocationid, studentstate, createdby, dateofcreation, ipaddress, studentattendancestatus) values(?,?,?,?,?,?,?,?)";
						pstmt = connection.prepareStatement(Query);
						pstmt.setLong(1, max_studentattendanceid);
						pstmt.setString(2, beanobj.getDateofattendance());
						pstmt.setString(3, Studentallocationid[i]);
						pstmt.setString(4, Studentattendancestatus[i]);
						pstmt.setString(5, beanobj.getCreatedby());
						pstmt.setString(6, datetime.showTime("MySqlWithTime"));
						pstmt.setString(7, beanobj.getIpaddress());
						pstmt.setString(8, "A");
						result += pstmt.executeUpdate();
						max_studentattendanceid++;
					} else if (editstatus.equals("update")) {
						Query = "update studentattendance  set  studentstate=?,dateofcreation=?,ipaddress=?,createdby=? where attendancedate=? and studentallocationid=? and studentattendanceid=?";
						pstmt = connection.prepareStatement(Query);
						pstmt.setString(1, Studentattendancestatus[i]);
						pstmt.setString(2, datetime.showTime("MySqlWithTime"));
						pstmt.setString(3, beanobj.getIpaddress());
						pstmt.setString(4, beanobj.getCreatedby());
						pstmt.setString(5, beanobj.getDateofattendance());
						pstmt.setString(6, Studentallocationid[i]);
						pstmt.setString(7, studentattendanceid[i]);

						result += pstmt.executeUpdate();

						Query = "insert into studentattendancelog (studattendancelogid, logdescription, studentattendanceid, dateofcreation, ipaddress, studattendancelogstatus) values(?,?,?,?,?,?)";
						pstmt1 = connection.prepareStatement(Query);

						pstmt1.setLong(1, max_studattendancelogid);
						pstmt1.setString(2, "updated");
						pstmt1.setString(3, studentattendanceid[i]);
						pstmt1
								.setString(4, datetime
										.showTime("databaseinsert"));
						pstmt1.setString(5, beanobj.getIpaddress());
						pstmt1.setString(6, "A");

						result += pstmt1.executeUpdate();

						max_studattendancelogid++;
					} else if (editstatus.equals("delete")) {
						Query = "update studentattendance  set  studentattendancestatus=?,dateofcreation=?,ipaddress=? where attendancedate=? and studentallocationid=? and studentattendanceid=?";
						pstmt = connection.prepareStatement(Query);
						pstmt.setString(1, Studentattendancestatus[i]);
						pstmt.setString(2, datetime.showTime("MySqlWithTime"));
						pstmt.setString(3, beanobj.getIpaddress());
						pstmt.setString(4, beanobj.getDateofattendance());
						pstmt.setString(5, Studentallocationid[i]);
						pstmt.setString(6, studentattendanceid[i]);
						result += pstmt.executeUpdate();
						Query = "insert into studentattendancelog (studattendancelogid, logdescription, studentattendanceid, dateofcreation, ipaddress, studattendancelogstatus) values(?,?,?,?,?,?)";
						pstmt1 = connection.prepareStatement(Query);

						pstmt1.setLong(1, max_studattendancelogid);
						pstmt1.setString(2, "deleted");
						pstmt1.setString(3, studentattendanceid[i]);
						pstmt1
								.setString(4, datetime
										.showTime("databaseinsert"));
						pstmt1.setString(5, beanobj.getIpaddress());
						pstmt1.setString(6, "A");

						result += pstmt1.executeUpdate();

						max_studattendancelogid++;
					}
				}
				else{
					result++;
					returnnames	+= attrs.getString(1)+",";
					returnids	+= Studentallocationid[i]+",";
				}	
					if(attrs != null)
						attrs.close();

				}
			}
			log.info("Studentattendanceinsert================>>");
			beanobj.setResultnames(returnnames);
			beanobj.setResultids(returnids);

			connection.commit();

		} catch (Exception exception) {
			if (connection != null)
				connection.rollback();
			log.error(exception);
			exception.printStackTrace();
			return 0;
		} finally {
			if (pstmt != null)
				pstmt.close();
			if(attrs != null)
				attrs.close();

			if (connection != null)
				connection.close();

		}
		return result;
			
	}
	CommonDataAccess common_data_object;
	DateTime datetime;

	String select_query;

}