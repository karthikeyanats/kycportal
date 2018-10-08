/*     Version Info : KYC version 1.0
		Class Name   : ApplicationQuery
		Created Date : 10-05-2011
		Modified Date : -
		Copy right   : i-Grandee Software Technologies Pvt Ltd.
 */

package com.iGrandee.Application;

// Import Libraries From Packages
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

// Class Define
public class ApplicationQuery {
	// Bean Object Creation
	static Logger log = Logger.getLogger(ApplicationQuery.class);
	CommonDataAccess common_data_object = new CommonDataAccess();

	public String insert_query = null;
	// public String select_query = null;
	int return_value = 0;
	ResourceBundle resourcebundle;
	DateTime datetime = new DateTime();

	// to generate receipt no. based on sessionid,instituteid - Subhash
	public String receiptNo(String sessionid, String instituteid) {
		log
				.info("invoking receiptNo to generate receipt no. based on sessionid,instituteid");
		String temp = null;
		try {
			String select_query = "select max(receiptno) from applicationissue where sessionid='"
					+ sessionid + "' and instituteid='" + instituteid + "'";
			long personid = common_data_object.fmaxId(select_query);
			temp = "" + personid;
			log.info("Query : " + select_query);
		} catch (Exception e) {
			log.error(e);
		}
		return temp;
	}

	public String CheckApplicantAdmitted(String applicationid) throws Exception {

		log
				.info("invoking getApplicantDetails To get details of Applicant based on Application no");
		String courseList = "0";
		try {
			String qry1 = "SELECT count(*) FROM registration r where applicationid='"
					+ applicationid + "'";
			courseList = common_data_object.getSingleColumn(qry1);
			log.info("Query1 : " + qry1);
		} catch (Exception e) {
			log.error(e);
		}
		return courseList;
	}

	// To get details of Applicant based on Application no
	public ArrayList getApplicantDetails(String applicationno) throws Exception {

		log
				.info("invoking getApplicantDetails To get details of Applicant based on Application no");
		ArrayList courseList = new ArrayList();
		try {
			// String qry = "select * from applicationissue where
			// applicationid="+receipt+"";
			String qry1 = "select a.*,'-' as coursename,'-' as coursepublishid from applicationissue a where a.applicationno='"
					+ applicationno + "' and a.standardpublishid is null";
			courseList = common_data_object.getListMap(qry1);
			log.info("Query1 : " + qry1);

			if (courseList.size() == 0) {
				String qry = "select a.*,c.standardname,b.standardscheduleid,date_format(curdate(),'%d-%b-%Y') as currentdate from  applicationissue a,standardschedule b,standard c where a.applicationno='"
						+ applicationno
						+ "' and c.standardid=b.standardid and a.standardpublishid=b.standardscheduleid and a.status='A'";
				courseList = common_data_object.getListMap(qry);
				log.info("Query : " + qry);
			}
		} catch (Exception e) {
			log.error(e);
			// System.out.println("Exception thrown in getCourses()
			// =============> "+e.getMessage());
			// e.printStackTrace();
		}
		return courseList;
	}

	// to insert application - Subhash
	public int applicationInsert(String applicantName, String applicationNo,
			float cost, String contactno, String emailid,
			String standardpublishid, String sessionid, String boardid,
			String createdby, String ipaddress, String instituteid)
			throws Exception {
		log.info("invoking applicationInsert for Application Insertion");
		// Connection connection = null;
		PreparedStatement appstmt = null;
		PreparedStatement appidstmt = null;
		PreparedStatement recptidstmt = null;
		ResultSet appidrs = null;
		ResultSet recptidrs = null;

		long appId = 0l;
		long recptId = 0l;

		int result = 0;

		String datestr = null;
		// datestr = datetime.showTime("sqlserver");
		datestr = datetime.showTime("MySqlWithTime");

		try {
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);

			select_query = "select max(applicationid) from applicationissue";
			appidstmt = applicationConnection.prepareStatement(select_query);
			appidrs = appidstmt.executeQuery();

			if (appidrs.next())
				appId = appidrs.getLong(1);

			appId++;

			select_query = "select max(receiptno) from applicationissue where sessionid='"
					+ sessionid + "' and instituteid='" + instituteid + "'";
			recptidstmt = applicationConnection.prepareStatement(select_query);
			recptidrs = recptidstmt.executeQuery();

			if (recptidrs.next())
				recptId = recptidrs.getLong(1);

			recptId++;

			insert_query = "insert into applicationissue(applicationid,applicantname,applicationno,cost,contactno,emailid,standardpublishid,dateofcreation,receiptno,createdby,ipaddress,instituteid,sessionid,boardid,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			appstmt = applicationConnection.prepareStatement(insert_query);

			appstmt.setLong(1, appId);
			appstmt.setString(2, applicantName);
			appstmt.setString(3, applicationNo);
			appstmt.setFloat(4, cost);
			appstmt.setString(5, contactno);
			appstmt.setString(6, emailid);
			appstmt.setString(7, standardpublishid);
			appstmt.setString(8, datestr);
			appstmt.setLong(9, recptId);
			appstmt.setString(10, createdby);
			appstmt.setString(11, ipaddress);
			appstmt.setString(12, instituteid);
			appstmt.setString(13, sessionid);
			appstmt.setString(14, boardid);
			appstmt.setString(15, "A");

			result = appstmt.executeUpdate();

			applicationConnection.commit();
		} catch (SQLException e) {
			// System.out.println("Error in applicationInsert");
			log.error("",e);
			e.printStackTrace();

			if (applicationConnection != null)
				applicationConnection.rollback();

			result = 0;

		} finally {

			if (appidrs != null)
				appidrs.close();

			if (appidstmt != null)
				appidstmt.close();
			if (appstmt != null)
				appstmt.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}

		return result;
	}

	// to insert application - Subhash
	// public int applicationInsert(String applicantName, String applicationNo,
	// float cost,String contactno,String emailid,String
	// standardpublishid,String sessionid,String boardid,String createdby,String
	// ipaddress,String instituteid) throws Exception
	public int applicationInsert(ApplicationBean applicationBean)
			throws Exception {
		log.info("invoking applicationInsert for Application Insertion");
		// Connection connection = null;
		PreparedStatement appstmt = null;
		PreparedStatement appidstmt = null;
		PreparedStatement recptidstmt = null;
		ResultSet appidrs = null;
		ResultSet recptidrs = null;

		long appId = 0l;
		long recptId = 0l;

		int result = 0;

		String datestr = null;
		// datestr = datetime.showTime("sqlserver");
		datestr = datetime.showTime("MySqlWithTime");

		try {
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);

			select_query = "select max(applicationid) from applicationissue";
			appidstmt = applicationConnection.prepareStatement(select_query);
			appidrs = appidstmt.executeQuery();

			if (appidrs.next())
				appId = appidrs.getLong(1);

			appId++;

			// select_query = "select max(receiptno) from applicationissue where
			// sessionid='"+sessionid+"' and instituteid='"+instituteid+"'";
			select_query = "select max(receiptno) from applicationissue where sessionid='"
					+ applicationBean.getSessionid()
					+ "' and instituteid='"
					+ applicationBean.getInstituteid() + "'";
			recptidstmt = applicationConnection.prepareStatement(select_query);
			recptidrs = recptidstmt.executeQuery();

			if (recptidrs.next())
				recptId = recptidrs.getLong(1);

			recptId++;

			insert_query = "insert into applicationissue(applicationid,applicantname,applicationno,cost,contactno,emailid,standardpublishid,dateofcreation,receiptno,createdby,ipaddress,instituteid,sessionid,boardid,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			appstmt = applicationConnection.prepareStatement(insert_query);

			/*
			 * appstmt.setLong(1,appId); appstmt.setString(2,applicantName);
			 * appstmt.setString(3,applicationNo); appstmt.setFloat(4,cost);
			 * appstmt.setString(5,contactno); appstmt.setString(6,emailid);
			 * appstmt.setString(7,standardpublishid);
			 * appstmt.setString(8,datestr); appstmt.setLong(9,recptId);
			 * appstmt.setString(10,createdby); appstmt.setString(11,ipaddress);
			 * appstmt.setString(12,instituteid);
			 * appstmt.setString(13,sessionid); appstmt.setString(14,boardid);
			 * appstmt.setString(15,"A");
			 */

			appstmt.setLong(1, appId);
			appstmt.setString(2, applicationBean.getApplicantname());
			appstmt.setLong(3, appId);
			//appstmt.setString(3, applicationBean.getApplicationno());
			appstmt.setString(4, applicationBean.getApplicationcost());
			appstmt.setString(5, applicationBean.getContactno());
			appstmt.setString(6, applicationBean.getEmailid());
			appstmt.setLong(7, applicationBean.getStandardscheduleid());
			appstmt.setString(8, datestr);
			appstmt.setLong(9, recptId);
			appstmt.setString(10, applicationBean.getCreatedby());
			appstmt.setString(11, applicationBean.getIpaddress());
			appstmt.setString(12, applicationBean.getInstituteid());
			appstmt.setLong(13, applicationBean.getSessionid());
			appstmt.setLong(14, applicationBean.getBoardid());
			appstmt.setString(15, "A");

			result = appstmt.executeUpdate();
			if(result>0)
				result = Integer.parseInt(appId+"");

			applicationConnection.commit();
		} catch (SQLException e) {
			// System.out.println("Error in applicationInsert");
			log.error("",e);
			e.printStackTrace();

			if (applicationConnection != null)
				applicationConnection.rollback();

			result = 0;

		} finally {

			if (appidrs != null)
				appidrs.close();

			if (appidstmt != null)
				appidstmt.close();
			if (appstmt != null)
				appstmt.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}

		return result;
	}

	// to list all year of session -- Subhash
	/**
	 * This method is accessed from jsp/Exam/ExamPass/standardpasslist.jsp Get
	 * academic session (acess by prasanth )
	 * 
	 * @param instituteid
	 *            that can be used to list all academic years
	 * @return ArrayList by which result printed on the screen
	 */
	public ArrayList listYearofSession(String instituteid) {
		log.info("invoking listYearofSession to list all year of session");
		ArrayList courseList = new ArrayList();
		String currdate = "";
		try {
			String query = "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"
					+ instituteid
					+ "' and (sessionstatus='A' or sessionstatus='R') order by sessionname";
			// System.out.println("query-->"+query);
			courseList = common_data_object.getListMap(query);
		} catch (Exception e) {
			log.error(e);
		}
		return courseList;
	}

	//to list standardnames in selected year of session -- Subhash
	public ArrayList listYearofSessionStandard(String sessionid,String boardid)
	{
		log.info("invoking listYearofSessionStandard to list standardnames in selected year of session");
		ArrayList courseList = null;
		try
		{
		String query = "select distinct a.standardscheduleid,a.standardid,b.standardname,a.groupid,c.sessionname,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid)  end as groupname from standardschedule a,standard b,yearofsession c where a.standardid=b.standardid  and a.sessionid=c.sessionid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.stdschedulestatus='A' and b.standardstatus='A' and (c.sessionstatus='A' or c.sessionstatus='R') order by b.standardid,a.standardscheduleid";
		courseList = common_data_object.getListMap(query);
	//	System.out.println(query);
		
	
	}catch(Exception e){log.error(e);e.printStackTrace();}
	return courseList;
	}

	// to update application details -- Subhash
	public int updateApplication(ApplicationBean applicationBean)
			throws Exception {
		log.info("invoking updateApplication for Applicant Updation");

		int result = 0;
		PreparedStatement updateprepared = null;
		String currentdate = DateTime.showTime("MySqlWithTime");
		try {
			// System.out.println("applicationBean.getStandardscheduleid()-->"+applicationBean.getStandardscheduleid());
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);
			// applicationid, applicantname, applicationno, cost, contactno,
			// standardpublishid, dateofcreation, receiptno, createdby,
			// ipaddress, instituteid, sessionid, boardid, status
			// , , , , , , , receiptno, , , , sessionid, boardid, status
			select_query = "update applicationissue set applicantname=?,applicationno=?,cost=?,contactno=?,emailid=?,standardpublishid=?,dateofcreation=?,createdby=?,ipaddress=?,instituteid=? where applicationid=?";
			updateprepared = applicationConnection
					.prepareStatement(select_query);
			updateprepared.setString(1, applicationBean.getApplicantname());
			updateprepared.setString(2, applicationBean.getApplicationno());
			updateprepared.setString(3, applicationBean.getApplicationcost());
			updateprepared.setString(4, applicationBean.getContactno());
			updateprepared.setString(5, applicationBean.getEmailid());
			updateprepared.setLong(6, applicationBean.getStandardscheduleid());
			updateprepared.setString(7, currentdate);
			updateprepared.setString(8, applicationBean.getCreatedby());
			updateprepared.setString(9, applicationBean.getIpaddress());
			updateprepared.setString(10, applicationBean.getInstituteid());
			updateprepared.setString(11, applicationBean.getApplicationid());
			result += updateprepared.executeUpdate();

			applicationConnection.commit();

		} catch (SQLException e) {

			log.error("",e);
			e.printStackTrace();
			result = 0;
			if (applicationConnection != null)
				applicationConnection.rollback();
		} finally {

			if (updateprepared != null)
				updateprepared.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}
		return result;
	}

	// To change the status of Application Status - Subhash

	public int updateStatusApplication(ApplicationBean applicationBean)
			throws Exception {
		log.info("invoking updateStatusApplication for Applicant Updation");

		int result = 0;
		PreparedStatement updateprepared = null;
		String currentdate = DateTime.showTime("MySqlWithTime");
		try {
			// System.out.println("applicationBean.getApplicationid()-->"+applicationBean.getApplicationid());
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);
			select_query = "update applicationissue set status=?,dateofcreation=?,createdby=?,ipaddress=?,instituteid=? where applicationid=?";
			updateprepared = applicationConnection
					.prepareStatement(select_query);
			updateprepared.setString(1, applicationBean.getStatus());
			updateprepared.setString(2, currentdate);
			updateprepared.setString(3, applicationBean.getCreatedby());
			updateprepared.setString(4, applicationBean.getIpaddress());
			updateprepared.setString(5, applicationBean.getInstituteid());
			updateprepared.setString(6, applicationBean.getApplicationid());
			result += updateprepared.executeUpdate();
			applicationConnection.commit();

		} catch (SQLException e) {

			log.error("",e);
			e.printStackTrace();
			result = 0;
			if (applicationConnection != null)
				applicationConnection.rollback();
		} finally {

			if (updateprepared != null)
				updateprepared.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}
		return result;
	}

	// to update allocation details -- Subhash
	public int updateAllocation(AllocationBean allocationBean) throws Exception {
		log.info("invoking updateAllocation for Allocation Updation");

		int result = 0;
		PreparedStatement updateprepared = null;
		String currentdate = DateTime.showTime("MySqlWithTime");
		try {
			// System.out.println("applicationBean.getStandardscheduleid()-->"+allocationBean.getStandardscheduleid());
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);
			// studentallocationid, candidateregisterid, sectionscheduleid,
			// rollno, studentcurrentstatus, dateofcreation,
			// studentallocationstatus, registrationnumber, createdby,
			// dateofrollnogen
			select_query = "update studentallocation set sectionscheduleid=?,dateofcreation=?,createdby=? where studentallocationid=?";
			updateprepared = applicationConnection
					.prepareStatement(select_query);
			updateprepared.setLong(1, allocationBean.getSectionscheduleid());
			updateprepared.setString(2, currentdate);
			updateprepared.setString(3, allocationBean.getCreatedby());
			updateprepared
					.setString(4, allocationBean.getStudentallocationid());
			// updateprepared.setString(5,allocationBean.getIpaddress());
			// updateprepared.setString(6,allocationBean.getInstituteid());
			result += updateprepared.executeUpdate();

			applicationConnection.commit();

		} catch (SQLException e) {

			log.error("",e);
			e.printStackTrace();
			result = 0;
			if (applicationConnection != null)
				applicationConnection.rollback();
		} finally {

			if (updateprepared != null)
				updateprepared.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}
		return result;
	}

	// To change the status of Allocation Status - Subhash
	public int updateStatusAllocation(AllocationBean allocationBean)
			throws Exception {
		log.info("invoking updateStatusAllocation for Allocation Updation");

		int result = 0;
		PreparedStatement updateprepared = null;
		String currentdate = DateTime.showTime("MySqlWithTime");
		try {
			// System.out.println("allocationBean.getStudentallocationid()-->"+allocationBean.getStudentallocationid());
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);
			select_query = "update studentallocation set studentallocationstatus=?,dateofcreation=?,createdby=? where studentallocationid=?";
			updateprepared = applicationConnection
					.prepareStatement(select_query);
			updateprepared.setString(1, allocationBean
					.getStudentallocationstatus());
			updateprepared.setString(2, currentdate);
			updateprepared.setString(3, allocationBean.getCreatedby());
			updateprepared
					.setString(4, allocationBean.getStudentallocationid());
			// updateprepared.setString(4,applicationBean.getIpaddress());
			// updateprepared.setString(5,applicationBean.getInstituteid());

			result += updateprepared.executeUpdate();
			applicationConnection.commit();

		} catch (SQLException e) {

			log.error("",e);
			e.printStackTrace();
			result = 0;
			if (applicationConnection != null)
				applicationConnection.rollback();
		} finally {

			if (updateprepared != null)
				updateprepared.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}
		return result;
	}

	// to get report based on sessionid,boardid - Subhash
	public ArrayList getReport(String sessionid, String boardid,
			String instituteid, String process) {
		log
				.info("invoking getReport  based on sessionid,boardid,instituteid,process[Application or Registration]");
		ArrayList standardList = new ArrayList();
		ArrayList newlist = null;
		ArrayList newlist1 = new ArrayList();
		String applicationCount = "";
		String applicationCost = "";
		String tablename = "";
		String costField = "";

		// String eveningcountstr = "";

		try {
			String querystr = "select distinct a.standardscheduleid,a.standardid,b.standardname,a.groupid,c.sessionname,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid)  end as groupname from standardschedule a,standard b,yearofsession c,standardgroup d where a.standardid=b.standardid and b.standardstatus=a.stdschedulestatus and a.sessionid=c.sessionid and a.sessionid='"
					+ sessionid
					+ "' and b.boardid='"
					+ boardid
					+ "' and a.stdschedulestatus='A' and b.standardstatus='A' and (c.sessionstatus='A' or c.sessionstatus='R') order by b.standardid,a.standardscheduleid";
			standardList = common_data_object.getListMap(querystr);

			for (int s = 0; s < standardList.size(); s++) {
				newlist = new ArrayList();
				HashMap map = (HashMap) standardList.get(s);
				String standardscheduleid = (String) map
						.get("standardscheduleid");
				String standardid = (String) map.get("standardid");
				String standardname = (String) map.get("standardname");
				String groupid = (String) map.get("groupid");
				String sessionname = (String) map.get("sessionname");
				String groupname = (String) map.get("groupname");

				if (!groupname.equals("NoGroup")) {
					standardname = standardname + " - " + groupname;
				}

				if (process == "Application") {
					tablename = "applicationissue";
					costField = "cost";
				} else if (process == "Registration") {
					tablename = "registration";
					costField = "registrationamount";
				}

				applicationCount = applicationCount(standardscheduleid,
						tablename, costField);
				applicationCost = applicationCost(standardscheduleid,
						tablename, costField);

				if (applicationCount.equals(""))
					applicationCount = "0";

				newlist.add(standardscheduleid);
				newlist.add(standardname);
				newlist.add(applicationCost);
				newlist.add(applicationCount);
				newlist1.add(newlist);
			}

			// System.out.println(newlist1);

		} catch (Exception e) {
			log.error(e);
		}
		return newlist1;
	}

	// to get count of the application based on
	// standardscheduleid,tablename,costField - Subhash
	public String applicationCount(String standardscheduleid, String tablename,
			String costField) {
		log
				.info("invoking applicationCount  based on standardscheduleid,tablename,costField[Application or Registration]");
		String reqstr = "";
		String query = "";
		try {
			if (costField == "registrationamount")
				query = "select count(*) from applicationissue a join "
						+ tablename
						+ " b on b.standardpublishid='"
						+ standardscheduleid
						+ "' and a.standardpublishid=b.standardpublishid and a.applicationid=b.applicationid and a.status='A' and b.status='A'";
			else
				query = "select count(*) from  " + tablename
						+ " where standardpublishid='" + standardscheduleid
						+ "' and status='A'";
			reqstr = common_data_object.getString(query);
		} catch (Exception e) {
			log.error(e);
		}
		return reqstr;
	}

	// to get total cost of the application based on
	// standardscheduleid,tablename,costField - Subhash
	public String applicationCost(String standardscheduleid, String tablename,
			String costField) {
		log
				.info("invoking applicationCost to get total cost of the application or registration based on standardscheduleid,tablename,costField[Application or Registration]");
		String reqstr = "";
		String query = "";
		try {
			if (costField == "registrationamount")
				query = "select sum("
						+ costField
						+ ") from applicationissue a join "
						+ tablename
						+ " b on b.standardpublishid='"
						+ standardscheduleid
						+ "' and a.standardpublishid=b.standardpublishid and a.applicationid=b.applicationid and a.status='A' and b.status='A'";
			else
				query = "select sum(" + costField + ") from  " + tablename
						+ " where standardpublishid='" + standardscheduleid
						+ "' and status='A'";
			reqstr = common_data_object.getString(query);
		} catch (Exception e) {
			log.error(e);
		}
		return reqstr;
	}

	// to get report based on sessionid,boardid between two dates - Subhash
	public ArrayList getReport(String sessionid, String boardid,
			String instituteid, String fromDate, String toDate, String process) {
		log
				.info("invoking getReport to get report based on sessionid,boardid, between two dates,process[Application or Registration]");
		ArrayList standardList = new ArrayList();
		ArrayList newlist = null;
		ArrayList newlist1 = new ArrayList();
		String applicationCount = "";
		String applicationCost = "";
		String tablename = "";
		String costField = "";

		try {
			String fromdate = ((StringBuffer) datetime.getMySQLFormat(fromDate))
					.toString();
			String todate = ((StringBuffer) datetime.getMySQLFormat(toDate))
					.toString();
			String querystr = "select distinct a.standardscheduleid,a.standardid,b.standardname,a.groupid,c.sessionname,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid)  end as groupname,date_format('"
					+ fromdate
					+ "','%d-%b-%Y') as appFromDate,date_format('"
					+ todate
					+ "','%d-%b-%Y') as appToDate from standardschedule a,standard b,yearofsession c,standardgroup d where a.standardid=b.standardid and b.standardstatus=a.stdschedulestatus and a.sessionid=c.sessionid and a.sessionid='"
					+ sessionid
					+ "' and b.boardid='"
					+ boardid
					+ "' and a.stdschedulestatus='A' and b.standardstatus='A' and (c.sessionstatus='A' or c.sessionstatus='R') order by b.standardid,a.standardscheduleid";
			standardList = common_data_object.getListMap(querystr);

			for (int s = 0; s < standardList.size(); s++) {
				newlist = new ArrayList();
				HashMap map = (HashMap) standardList.get(s);
				String standardscheduleid = (String) map
						.get("standardscheduleid");
				String standardid = (String) map.get("standardid");
				String standardname = (String) map.get("standardname");
				String groupid = (String) map.get("groupid");
				String sessionname = (String) map.get("sessionname");
				String groupname = (String) map.get("groupname");

				String appFromDate = (String) map.get("appFromDate");
				String appToDate = (String) map.get("appToDate");

				if (!groupname.equals("NoGroup")) {
					standardname = standardname + " - " + groupname;
				}

				if (process == "Application") {
					tablename = "applicationissue";
					costField = "cost";
				} else if (process == "Registration") {
					tablename = "registration";
					costField = "registrationamount";
				}

				applicationCount = applicationCountDatewise(standardscheduleid,
						instituteid, fromdate, todate, tablename, costField);
				applicationCost = applicationCostDatewise(standardscheduleid,
						instituteid, fromdate, todate, tablename, costField);

				if (applicationCount.equals(""))
					applicationCount = "0";

				newlist.add(standardscheduleid);
				newlist.add(standardname);
				newlist.add(applicationCost);
				newlist.add(applicationCount);
				newlist.add(appFromDate);
				newlist.add(appToDate);
				newlist1.add(newlist);
			}
		} catch (Exception e) {
			log.error(e);
		}
		return newlist1;
	}

	// to get count of the application based on standardscheduleid,instituteid
	// between two dates - Subhash
	public String applicationCountDatewise(String standardscheduleid,
			String instituteid, String fromDate, String toDate,
			String tablename, String costField) {
		log
				.info("invoking applicationCountDatewise to get count of the application based on standardscheduleid,instituteid between two dates,costField[Application or Registration]");
		String reqstr = "";
		String query = "";
		try {
			if (costField == "registrationamount")
				query = "select count(*) from applicationissue a join "
						+ tablename
						+ " b on b.standardpublishid='"
						+ standardscheduleid
						+ "' and a.standardpublishid=b.standardpublishid and a.applicationid=b.applicationid and a.status='A' and b.status='A' and b.dateofcreation between '"
						+ fromDate + " 00:00:00' and '" + toDate + " 23:59:59'";
			else
				query = "select count(*) from  " + tablename
						+ " where standardpublishid='" + standardscheduleid
						+ "' and status='A' and dateofcreation between '"
						+ fromDate + " 00:00:00' and '" + toDate + " 23:59:59'";

			reqstr = common_data_object.getString(query);
		} catch (Exception e) {
			log.error(e);
		}
		return reqstr;
	}

	// to get total cost of the application based on
	// standardscheduleid,instituteid between two dates - Subhash
	public String applicationCostDatewise(String standardscheduleid,
			String instituteid, String fromDate, String toDate,
			String tablename, String costField) {
		log
				.info("invoking applicationCostDatewise to get total cost of the application based on standardscheduleid,instituteid between two dates,costField[Application or Registration]");
		String reqstr = "";
		String query = "";
		try {
			if (costField == "registrationamount")
				query = "select sum("
						+ costField
						+ ") from applicationissue a join "
						+ tablename
						+ " b on b.standardpublishid='"
						+ standardscheduleid
						+ "' and a.standardpublishid=b.standardpublishid and a.applicationid=b.applicationid and a.status='A' and b.status='A' and b.dateofcreation between '"
						+ fromDate + " 00:00:00' and '" + toDate + " 23:59:59'";
			else
				query = "select sum(" + costField + ") from  " + tablename
						+ " where standardpublishid='" + standardscheduleid
						+ "' and status='A' and dateofcreation between '"
						+ fromDate + " 00:00:00' and '" + toDate + " 23:59:59'";

			reqstr = common_data_object.getString(query);
		} catch (Exception e) {
			log.error(e);
		}
		return reqstr;
	}

	// to list standardnames with collected fees -- Subhash
	public ArrayList getAllFeesReport(String sessionid, String boardid,
			String instituteid, String fromdate, String Todate) {
		log
				.info("invoking getAllFeesReport to list standardnames with collected fees ");
		ArrayList feesList = null;
		try {
			// String query = "select distinct case when a.groupid is null then
			// b.standardname else concat(b.standardname,' - ',d.groupname) end
			// as standardname,(select sum(a1.cost) from applicationissue a1
			// where a1.standardpublishid=a.standardscheduleid and status='A')
			// as appCost,(select sum(b2.registrationamount) from
			// applicationissue a2,registration b2 where
			// b2.standardpublishid=a.standardscheduleid and
			// a2.standardpublishid=b2.standardpublishid and
			// a2.applicationid=b2.applicationid and a2.status='A' and
			// b2.status='A') as regCost,(SELECT SUM(collectionamount) from
			// feescollection f1,termfees f2,standardschedule f3 where
			// f1.termfeesid=f2.termfeesid and
			// f2.standardscheduleid=f3.standardscheduleid and
			// f3.standardscheduleid=a.standardscheduleid and
			// f1.feescollectionstatus='A' and f2.termfeesstatus='A' and
			// f3.stdschedulestatus='A') as feeCost from standardschedule
			// a,standard b,yearofsession c,standardgroup d where
			// a.standardid=b.standardid and
			// b.standardstatus=a.stdschedulestatus and a.sessionid=c.sessionid
			// and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and
			// c.instituteid='"+instituteid+"' and a.stdschedulestatus='A' and
			// b.standardstatus='A' and (c.sessionstatus='A' or
			// c.sessionstatus='R') order by b.standardid,a.standardscheduleid";
			String query = "select distinct a.standardscheduleid,a.standardid,b.standardname,a.groupid,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid)  end as groupname,(select sum(a1.cost) from applicationissue a1 where a1.standardpublishid=a.standardscheduleid and status='A' and a1.dateofcreation between '"
					+ fromdate
					+ " 00:00:00:000' and '"
					+ Todate
					+ " 23:59:59:000') as appCost,(select sum(b2.registrationamount) from applicationissue a2,registration b2 where b2.standardpublishid=a.standardscheduleid and a2.standardpublishid=b2.standardpublishid and a2.applicationid=b2.applicationid and a2.status='A' and b2.status='A'  and a2.dateofcreation between '"
					+ fromdate
					+ " 00:00:00:000' and '"
					+ Todate
					+ " 23:59:59:000' ) as regCost,(SELECT SUM(collectionamount) from feescollection f1,termfees f2,standardschedule f3 where f1.termfeesid=f2.termfeesid and f2.standardscheduleid=f3.standardscheduleid and f3.standardscheduleid=a.standardscheduleid and f1.feescollectionstatus='A' and f2.termfeesstatus='A' and f3.stdschedulestatus='A'   and f1.feescollectiondate between '"
					+ fromdate
					+ " 00:00:00:000' and '"
					+ Todate
					+ " 23:59:59:000') as feeCost from standardschedule a,standard b,yearofsession c,standardgroup d where a.standardid=b.standardid and b.standardstatus=a.stdschedulestatus and a.sessionid=c.sessionid and a.sessionid='"
					+ sessionid
					+ "' and b.boardid='"
					+ boardid
					+ "' and c.instituteid='"
					+ instituteid
					+ "' and a.stdschedulestatus='A' and b.standardstatus='A' and (c.sessionstatus='A' or c.sessionstatus='R') order by b.standardid,a.standardscheduleid";

			feesList = common_data_object.getListMap(query);
		//	System.out.println(query);
			log.info("Query :" + query);

		} catch (Exception e) {
			log.error(e);
		}
		return feesList;
	}

	// to list all year of session -- Subhash
	/**
	 * This method is accessed from jsp/SuperAdmin/Stud_Year_List.jsp
	 * 
	 * @param instituteid
	 *            that can be used to list all academic years
	 * @return ArrayList by which result printed on the screen
	 */
	public ArrayList listYearwithBoard(String instituteid) {
		log.info("invoking listYearwithBoard to list all year of session");
		ArrayList courseList = new ArrayList();
		String currdate = "";
		try {
			String query = "select sessionid,sessionname,sessionstatus,(select count(distinct a.boardid) from board a,standardmedium b,standard c,standardschedule d where a.mediumid=b.mediumid and a.boardid=c.boardid and c.standardid=d.standardid and d.instituteid=b.instituteid and a.instituteid='"
					+ instituteid
					+ "' and d.sessionid=y.sessionid and a.boardstatus='A' and b.mediumstatus='A' and c.standardstatus='A' and d.stdschedulestatus='A') as boardcount from yearofsession y where instituteid='"
					+ instituteid
					+ "' and (sessionstatus='A' or sessionstatus='R') order by sessionstatus,sessionname";
			// System.out.println("query-->"+query);
			courseList = common_data_object.getListMap(query);
		} catch (Exception e) {
			log.error(e);
		}
		return courseList;
	}

	// to list all year of session -- Subhash
	/**
	 * This method is accessed from jsp/SuperAdmin/Stud_Year_List.jsp
	 * 
	 * @param instituteid
	 *            that can be used to list all academic years
	 * @return ArrayList by which result printed on the screen
	 */
	public ArrayList listBrdwithStd(String instituteid, String sessionid) {
		log.info("invoking listYearwithBoard to list all year of session");
		ArrayList courseList = new ArrayList();
		String currdate = "";
		try {
			String query = "select distinct a.boardid,concat(a.boardname,' - ',b.mediumname) as boardmedium,(select count(a1.standardscheduleid) from standardschedule a1	join standard b1 where a1.standardid=b1.standardid and a1.sessionid='"
					+ sessionid
					+ "' and b1.boardid=a.boardid and a1.instituteid='"
					+ instituteid
					+ "'	and a1.stdschedulestatus='A') as stdcount from board a,standardmedium b,standard c,standardschedule d where a.mediumid=b.mediumid and a.boardid=c.boardid and c.standardid=d.standardid and d.instituteid=b.instituteid and a.instituteid='"
					+ instituteid
					+ "' and d.sessionid='"
					+ sessionid
					+ "' and a.boardstatus='A' and b.mediumstatus='A' and c.standardstatus='A' and d.stdschedulestatus='A'";
			// System.out.println("query-->"+query);
			courseList = common_data_object.getListMap(query);
		} catch (Exception e) {
			log.error(e);
		}
		return courseList;
	}

	/**
	 * get Standard Name for standard pass list creation (Access by Subhash)
	 * This method is accessed from kycportal/jsp/SuperAdmin/FeesView.jsp
	 * 
	 * @param boardid
	 *            that can be used to get standard name from standard table by
	 * 
	 * @param sessionid
	 *            that can be used to get standard name from standard table by
	 * 
	 * @param instituteid
	 *            that can be used to get standard name from standard table by
	 * 
	 * @return the ArrayList by which result can be printed on the screen
	 */
	public ArrayList loadstandardfeeswithstatus(String boardid,
			String sessionid, String instituteid, String status) {
		ArrayList arraylist = null;
		try {
			select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,"
					+ "(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"
					+ status
					+ "')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount,"
					+ "(select sum(b1.termfeesamount) from feestermname a1,termfees b1 where a1.termid=b1.termid and b1.standardscheduleid=a.standardscheduleid and a1.termstatus='A' and b1.termfeesstatus='A') as totalamount,"
					+ "(select sum(collectionamount) from feestermname a2,termfees b2,feescollection c2 where a2.termid=b2.termid and b2.standardscheduleid=a.standardscheduleid and b2.termfeesid=c2.termfeesid and a2.termstatus='A' and b2.termfeesstatus='A'  and c2.feescollectionstatus='A') as collectedamount"
					+ " from standardschedule a	"
					+ "join standard b where a.standardid=b.standardid and a.sessionid='"
					+ sessionid
					+ "' and b.boardid='"
					+ boardid
					+ "' and a.instituteid='"
					+ instituteid
					+ "'	and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";
			log.info("===================>>>>>>>>>>>>" + select_query);
			// System.out.println("loadstandardwithstatus===================>>>>>>>>>>>>"+select_query);

			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>" + arraylist);

		} catch (Exception exception) {
		}
		return arraylist;
	}

	String select_query;
	// CommonDataAccess common_data_object;
	ConnectionManager connectionManager;
	Connection applicationConnection;
}
