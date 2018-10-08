package com.iGrandee.Assignment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;


public class Assignment {

	static Logger log = Logger.getLogger(Assignment.class);

 public Assignment() {
	 
     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
     datetime				= new DateTime();
 }
  

  /*
   * This method is accessed from kycportal/jsp/Assignment/AssignmentCreation.jsp,kycportal/jsp/Assignment/getAgentCourseInfo.jsp,kycportal/jsp/Exam/ExamnameList.jsp,kycportal/jsp/kycpanel/Homepage.jsp
  */

 public ArrayList loadSessionForStaff(String userid)
 {
	 	log.info("invoking loadSessionForStaff from com.iGrandee.Assignment.Assignment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct e.sessionid,e.sessionname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.stdschedulestatus='A' join yearofsession e on d.sessionid=e.sessionid and e.sessionstatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
			//System.out.println(select_query);
		}
		catch(Exception exception) { 
			
 			log.error(exception);

		}
		return periodsList;
 }
 /*
  * Created by maruthupandian
  * This method is accessed from kycportal/jsp/Attendance/AttendanceForStaff.jsp
 */
 public ArrayList loadSectionForStaffUsingStandardscheduleid(String userid,String standardscheduleid)
 {
	 	log.info("invoking loadSessionForStaff from com.iGrandee.Assignment.Assignment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT distinct ss.sectionscheduleid,sec.sectionid,sec.sectionname FROM staffmaster s	join subjectallotment sa on sa.staffid=s.staffid and s.staffstatus='A' and sa.subjectallotmentstatus='A' and s.userid='"+userid+"' join sectionschedule ss on ss.sectionscheduleid=sa.sectionpublishid and ss.standardscheduleid='"+standardscheduleid+"' join section sec on sec.sectionid=ss.sectionid and sec.status='A'";
			periodsList 	= common_data_object.getListMap(select_query);
			//System.out.println(select_query);
		}
		catch(Exception exception) { 
			
 			log.error(exception);

		}
		return periodsList;
 }
 
 /*
  * This method is accessed from kycportal/jsp/Assignment/AssignmentCreation.jsp,kycportal/jsp/Assignment/getAgentCourseInfo.jsp
 */
public ArrayList loadAssignmentStudent(String sectionid,String questionid)
{
 	log.info("invoking loadAssignmentStudent from com.iGrandee.Assignment.Assignment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct a.studentallocationid,d.remarks,concat(c.firstname,' ',c.lastname) as studentname, date_format(d.assignmentdate,'%d-%b-%Y') as assignmentdate, date_format(d.submissiondate,'%d-%b-%Y') as submissiondate, d.assignmentid,case when d.assignmentid is null then 'No' else 'Yes' end as status from studentallocation a join candidateregister b on a.candidateregisterid=b.candidateregisterid and a.studentallocationstatus='A' and b.candidateregisterstatus='A' and a.sectionscheduleid='"+sectionid+"' join personmaster c on b.personid=c.personid and c.status='A' left outer join assignmentmaster d on find_in_set(a.studentallocationid,d.studentids) and d.questionid='"+questionid+"'  left outer join assignemntquestion e on d.questionid=e.questionid and e.status='A' order by status desc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
 			log.error(exception);

		}
		return periodsList;
}
 
 
 /*
  * This method is accessed from kycportal/jsp/Assignment/AssignmentCreation.jsp,kycportal/jsp/Assignment/getAgentCourseInfo.jsp
 */
public ArrayList loadStandardForStaff(String userid,String sessionid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct d.standardscheduleid,e.standardname,(select groupname from standardgroup x where x.groupid=d.groupid and x.groupstatus='A') as groupname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+sessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.standardstatus='A'";
			//System.out.println(select_query);
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
 			log.error(exception);

		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Staff/SubjectWeakerList.jsp,kycportal/jsp/Staff/SubjectTopperList.jsp
*/
public ArrayList loadBoardForStaff(String userid,String sessionid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct f.boardid,mediumname,boardname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+sessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.standardstatus='A' join board f on e.boardid=f.boardid join standardmedium g on g.mediumid=f.mediumid"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Staff/SubjectWeakerList.jsp,kycportal/jsp/Staff/SubjectTopperList.jsp
*/
public ArrayList loadExamForStaff(String userid,String sessionid,String boardid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct j.examnameid,j.examname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+sessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.standardstatus='A' join board f on e.boardid=f.boardid and f.boardid='"+boardid+"' join standardmedium g on g.mediumid=f.mediumid join examschedule h on c.subjectscheduleid=h.subjectscheduleid and h.examschedulestatus='R' join examallotment i on h.examallotmentid=i.examallotmentid and i.examallotmentstatus='A' join examname j on j.examnameid=i.examnameid and j.examnamestatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Staff/SubjectWeakerList.jsp,kycportal/jsp/Staff/SubjectTopperList.jsp
*/
public ArrayList loadStandardForStaffExam(String userid,String sessionid,String examid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct d.standardscheduleid, case when d.groupid is null then e.standardname else concat(e.standardname,'-',j.groupname) end as standardname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+sessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.standardstatus='A' join examschedule h on c.subjectscheduleid=h.subjectscheduleid and h.examschedulestatus='R'  join examallotment i on h.examallotmentid=i.examallotmentid and i.examallotmentstatus='A' and i.examnameid='"+examid+"' and d.standardscheduleid = i.standardscheduleid left outer join standardgroup j on d.groupid=j.groupid and j.groupstatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Staff/SubjectWeakerList.jsp,kycportal/jsp/Staff/SubjectTopperList.jsp
 * modified by selvakumar_v oct-10-2013 due to issue in position while view top rank wise
*/

public ArrayList subjectTopperWeekerList(String standardid,String examid,String status,String number,String subjectid)
{
	log.info("Invoking subjectTopperWeekerList() for Loading Topper Weeker List");
	ArrayList groupedStandardList = null;
		try
		{
			//select_query  			= "select concat(firstname,' ',lastname) as studentname,b.rollno,sum(marktaken) as totalmark,marktaken, b.studentallocationid from sectionschedule a join studentallocation b on a.standardscheduleid='"+standardid+"' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus='A' join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"+examid+"' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.examschedulestatus='R' and f.subjectscheduleid='"+subjectid+"' left outer join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid group by b.studentallocationid order by totalmark "+status+" limit 0,"+number;
			//old query select_query  			= "select concat(firstname,' ',lastname) as studentname,b.rollno,sum(marktaken) as totalmark,marktaken, b.studentallocationid from sectionschedule a join studentallocation b on a.standardscheduleid='"+standardid+"' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus='A' join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"+examid+"' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.examschedulestatus='R' and f.subjectscheduleid='"+subjectid+"' join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid group by b.studentallocationid order by totalmark "+status+" limit 0,"+number;
			select_query  			= "select concat(firstname,' ',lastname) as studentname,b.rollno,sum(marktaken) as totalmark,marktaken, b.studentallocationid from sectionschedule a join studentallocation b on a.standardscheduleid='"+standardid+"' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus='A' join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"+examid+"' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.examschedulestatus='R' and f.subjectscheduleid='"+subjectid+"' join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid group by b.studentallocationid order by totalmark "+status+"";
			System.out.print("subjectTopperWeekerList-->"+select_query);
			groupedStandardList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return groupedStandardList;
}


/*
 * This method is accessed from kycportal/jsp/Assignment/AssignmentCreation.jsp,kycportal/jsp/Assignment/getAgentCourseInfo.jsp
*/
public ArrayList loadSubjectForStaff(String userid,String standardscheduleid)
{
 	log.info("invoking loadSubjectForStaff from com.iGrandee.Assignment.Assignment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct c.subjectscheduleid,d.subjectname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join subject d on d.subjectid=c.subjectid and d.subjectstatus='A' and c.standardscheduleid='"+standardscheduleid+"'"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
 			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Assignment/AssignmentCreation.jsp,kycportal/jsp/Assignment/getAgentCourseInfo.jsp
*/
public ArrayList loadLessonForStaff(String userid,String subjectscheduleid)
{
 	log.info("invoking loadLessonForStaff from com.iGrandee.Assignment.Assignment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct c.lessonscheduleid,d.lessonname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' and b.subjectscheduleid='"+subjectscheduleid+"' join lessonschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join lesson d on c.lessonid=d.lessonid and d.lessonstatus='A' order by d.lessonid asc"; 
			
			log.info(select_query);
			
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
 			log.error(exception);

		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Assignment/AssignmentView.jsp
*/
public ArrayList loadQuestions(String lessonscheduleid,String sectionscheduleid)
{
 	log.info("invoking loadQuestions from com.iGrandee.Assignment.Assignment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select questionid, questionname, mark, file from assignemntquestion where lessonscheduleid='"+lessonscheduleid+"' and sectionscheduleid='"+sectionscheduleid+"' and status='A'"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
			//System.out.println(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Assignment/UpdateQuestion.jsp
*/
public ArrayList loadQuestionsSingle(String questionid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select questionid, questionname, mark, file from assignemntquestion where questionid='"+questionid+"'"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
			//System.out.println(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Assignment/AssignmentCreation.jsp,kycportal/jsp/Assignment/getAgentCourseInfo.jsp
*/
public ArrayList loadSectionForStaff(String userid,String subjectscheduleid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct c.sectionscheduleid,d.sectionname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' and b.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule c on b.sectionpublishid=c.sectionscheduleid and c.sectionschedulestatus='A' join section d on c.sectionid=d.sectionid and d.status='A'"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
			//System.out.println(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Assignment/getAgentCourseInfo.jsp
*/
public ArrayList loadTopicForStaff(String lessonid,String sectionid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT questionid,questionname FROM assignemntquestion where lessonscheduleid='"+lessonid+"' and sectionscheduleid='"+sectionid+"' and status='A'"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
			//System.out.println(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Assignment/getAgentCourseInfo.jsp
*/
public ArrayList loadAssignmentSubmitted(String questionid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.studentallocationid,concat(c.firstname,' ',c.lastname) as studentname, f.studentremarks,f.facultyremarks,d.assignmentid,f.mark,f.file from assignemntquestion e join assignmentmaster d on d.questionid=e.questionid and e.questionid='"+questionid+"' and e.status='A' join studentallocation a on find_in_set(a.studentallocationid,d.studentids) and a.studentallocationstatus='A' and a.sectionscheduleid=e.sectionscheduleid join candidateregister b on a.candidateregisterid=b.candidateregisterid  and b.candidateregisterstatus='A' join personmaster c on b.personid=c.personid and c.status='A' left outer join assignmenttracking f on d.assignmentid=f.assignmentid and a.studentallocationid=f.studentid"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
			//System.out.println(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/Assignment/getAgentCourseInfo.jsp
*/
public ArrayList loadAssignmentEvaluate(String assignmentid,String studentid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.studentallocationid,concat(c.firstname,' ',c.lastname) as studentname, f.studentremarks,f.facultyremarks,d.assignmentid,f.mark,f.file,date_format(d.assignmentdate,'%d-%b-%Y') as assignmentdate,date_format(d.submissiondate,'%d-%b-%Y') as submissiondate, d.remarks,e.file as refernce,e.mark as questionmark,date_format(f.studentdate,'%d-%b-%Y') as studentdate,e.questionname,f.assigntracking from assignemntquestion e join assignmentmaster d on d.questionid=e.questionid and d.assignmentid='"+assignmentid+"' and e.status='A' join studentallocation a on find_in_set(a.studentallocationid,d.studentids) and a.studentallocationstatus='A' and a.sectionscheduleid=e.sectionscheduleid join candidateregister b on a.candidateregisterid=b.candidateregisterid  and b.candidateregisterstatus='A' join personmaster c on b.personid=c.personid and c.status='A' join assignmenttracking f on d.assignmentid=f.assignmentid and a.studentallocationid=f.studentid and a.studentallocationid='"+studentid+"'"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
			//System.out.println(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Assignment/Remove_Assignment.jsp
*/
public ArrayList loadAssignmentStudents(String questionid)
{
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.studentallocationid,concat(c.firstname,' ',c.lastname) as studentname,case when f.studentremarks is null then 'No' else 'Yes' end as studentstatus,case when f.facultyremarks is null then 'No' else 'Yes' end as facultystatus from assignemntquestion e join assignmentmaster d on d.questionid=e.questionid and e.questionid='"+questionid+"' and e.status='A' join studentallocation a on find_in_set(a.studentallocationid,d.studentids) and a.studentallocationstatus='A' and a.sectionscheduleid=e.sectionscheduleid join candidateregister b on a.candidateregisterid=b.candidateregisterid  and b.candidateregisterstatus='A' join personmaster c on b.personid=c.personid and c.status='A' left outer join assignmenttracking f on d.assignmentid=f.assignmentid and a.studentallocationid=f.studentid"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
			//System.out.println(exception);
		}
		return periodsList;
}

	/**
	 * This method is used to insert assignment questions through AssignmentBean
	 * @param bean
	 * @return 0 for failure greater than 0 for success.
	 * @throws SQLException
	 * @throws Exception
	 */

	public int questionInsert(AssignmentBean bean)throws SQLException,Exception {
		
		
		String[] topic				= bean.getQuestionnames();
		String[] mark				= bean.getMarks();
		String[] files				= bean.getFiles();
		String userid				= bean.getCreatedby();
		String lessonscheduleid		= bean.getLessonscheduleid();
		String sectionsceheduleid	= bean.getSectionscheduleid();
		
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		PreparedStatement idstate 		= null;
		ResultSet idrs 					= null;
		
		int[]	result					= null;
		long questionid					= 0l;
	
		try {
			
		
			workstate		= connection.prepareStatement("insert into assignemntquestion(lessonscheduleid, questionid, questionname, mark, file, status, createdby, sectionscheduleid)values(?,?,?,?,?,?,?,?)");
			idstate			= connection.prepareStatement("select max(questionid) from assignemntquestion");
			idrs			= idstate.executeQuery();
			
			if(idrs.next())
				questionid	= idrs.getLong(1);
			
			questionid++;
			
			if(topic != null &&  topic.length>0)
				for(int x=0;x<topic.length;x++){
										
					workstate.setString(1, lessonscheduleid);
					workstate.setLong(2,questionid);
					workstate.setString(3,topic[x]);
					workstate.setString(4,mark[x]);
					workstate.setString(5,files[x]);
					workstate.setString(6,"A");
					workstate.setString(7,userid);
					workstate.setString(8,sectionsceheduleid);
					workstate.addBatch();
					
					questionid++;
				
				}
				
			result		= 	workstate.executeBatch();
			
			if(result != null)
			for(int y=0;y<result.length;y++)
				return_value += result[y];
			
		connection.commit();
	
	}
	catch(SQLException sqlexception) { 
		
		sqlexception.printStackTrace();
		if(connection != null)
			connection.rollback();
		return_value = 0;
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


public int questionInsert(String[] topic,String[] mark,String[] files,String userid,String lessonscheduleid,String sectionsceheduleid)throws SQLException,Exception {
	
	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	PreparedStatement workstate 	= null;
	PreparedStatement idstate 		= null;
	ResultSet idrs 					= null;
	
	int[]	result					= null;
	long questionid					= 0l;

	try {
		
	
		workstate		= connection.prepareStatement("insert into assignemntquestion(lessonscheduleid, questionid, questionname, mark, file, status, createdby, sectionscheduleid)values(?,?,?,?,?,?,?,?)");
		idstate			= connection.prepareStatement("select max(questionid) from assignemntquestion");
		idrs			= idstate.executeQuery();
		
		if(idrs.next())
			questionid	= idrs.getLong(1);
		
		questionid++;
		
		if(topic != null &&  topic.length>0)
			for(int x=0;x<topic.length;x++){
									
				workstate.setString(1, lessonscheduleid);
				workstate.setLong(2,questionid);
				workstate.setString(3,topic[x]);
				workstate.setString(4,mark[x]);
				workstate.setString(5,files[x]);
				workstate.setString(6,"A");
				workstate.setString(7,userid);
				workstate.setString(8,sectionsceheduleid);
				workstate.addBatch();
				
				questionid++;
			
			}
			
		result		= 	workstate.executeBatch();
		
		if(result != null)
		for(int y=0;y<result.length;y++)
			return_value += result[y];
		
	connection.commit();

}
catch(SQLException sqlexception) { 
	
	sqlexception.printStackTrace();
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
	//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.BroadCastSession.insertPeriods====>"+sqlexception.getMessage());	
	//System.out.println(sqlexception);
	
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

public int questionUpdate(String topic,String mark,String files,String questionid)throws SQLException,Exception {
	
	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	PreparedStatement workstate 	= null;

	try {
		
	
		workstate		= connection.prepareStatement("update assignemntquestion set questionname=?, mark=?, file=? where questionid=?");

		workstate.setString(1, topic);
		workstate.setString(2,mark);
		workstate.setString(3,files);
		workstate.setString(4,questionid);
		workstate.addBatch();
			
		return_value		= 	workstate.executeUpdate();
		
		
	connection.commit();

}
catch(SQLException sqlexception) { 
	
	sqlexception.printStackTrace();
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
	//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.BroadCastSession.insertPeriods====>"+sqlexception.getMessage());	
	//System.out.println(sqlexception);
	
}
finally {
		
	if(workstate != null)
		workstate.close();

	
	ConnectionManager.closeConnection(connection);
}
return return_value;
}

	/**
	 * This method used to update the assignment question through AssignmentBean
	 * @param bean
	 * @return 0 for failure and greater than 0 for success.
	 * @throws SQLException
	 * @throws Exception
	 */

	public int questionUpdate(AssignmentBean bean)throws SQLException,Exception {
		
		String topic		= bean.getQuestionname();
		String mark			= bean.getMark();
		String files		= bean.getFile();
		String questionid	= bean.getQuestionid();
		
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
	
		try {
			
		
			workstate		= connection.prepareStatement("update assignemntquestion set questionname=?, mark=?, file=? where questionid=?");
	
			workstate.setString(1, topic);
			workstate.setString(2,mark);
			workstate.setString(3,files);
			workstate.setString(4,questionid);
			workstate.addBatch();
				
			return_value		= 	workstate.executeUpdate();
			
			
		connection.commit();
	
	}
	catch(SQLException sqlexception) { 
		
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

	public int changeStatus(String questionid,String status)throws SQLException,Exception {
		
			connection 						= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			PreparedStatement workstate 	= null;
		
			try {
				
			
				workstate		= connection.prepareStatement("update assignemntquestion set status=? where questionid=?");
		
				workstate.setString(1, status);
				workstate.setString(2,questionid);
				return_value		= 	workstate.executeUpdate();
				
				
			connection.commit();
		
		}
		catch(SQLException sqlexception) { 
			
			sqlexception.printStackTrace();
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
	 * This method used to delete the assignment question through AssignmentBean
	 * @param bean
	 * @return 0 for failure and greater than 0 for success. 1000 for assignment already assigned to students.
	 * @throws SQLException
	 * @throws Exception
	 */
	
	public int deleteAssignemntQuestion(AssignmentBean bean)throws SQLException,Exception {
		
		String questionid				= bean.getQuestionid();
		String status					= bean.getStatus();
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		PreparedStatement checkstate 	= null;
		ResultSet checkrs 				= null;
		
	
		try {
			
		
			checkstate		= connection.prepareStatement("select assignmentid from assignmentmaster where questionid=?");
			checkstate.setString(1,questionid);
			
			checkrs			= checkstate.executeQuery();
			
			if(!checkrs.next()){
			
				workstate		= connection.prepareStatement("update assignemntquestion set status=? where questionid=?");
		
				workstate.setString(1, status);
				workstate.setString(2,questionid);
				return_value		= 	workstate.executeUpdate();
			}
			else
				return_value = 1000;
			
			
		connection.commit();
	
	}
	catch(SQLException sqlexception) { 
		
		sqlexception.printStackTrace();
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
	
	
	
	public int deleteAssignemntQuestion(String questionid,String status)throws SQLException,Exception {
		
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		PreparedStatement checkstate 	= null;
		ResultSet checkrs 				= null;
		
	
		try {
			
		
			checkstate		= connection.prepareStatement("select assignmentid from assignmentmaster where questionid=?");
			checkstate.setString(1,questionid);
			
			checkrs			= checkstate.executeQuery();
			
			if(!checkrs.next()){
			
				workstate		= connection.prepareStatement("update assignemntquestion set status=? where questionid=?");
		
				workstate.setString(1, status);
				workstate.setString(2,questionid);
				return_value		= 	workstate.executeUpdate();
			}
			else
				return_value = 1000;
			
			
		connection.commit();
	
	}
	catch(SQLException sqlexception) { 
		
		sqlexception.printStackTrace();
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
	 * This method used to insert faculty remark through the AssignmentReplyBean
	 * @param bean 
	 * @return 0 for failure greater than 0 for success
	 * @throws SQLException
	 * @throws Exception
	 */
	
	public int updateFacultyRemarks(AssignmentReplyBean bean)throws SQLException,Exception {
		
		String assigntrack		= bean.getAssigntracking();
		String remarks			= bean.getFacultyremarks();
		String mark				= bean.getMark();
		
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		String curTime					= DateTime.showTime("MySqlWithTime");
	
	
		try {
			
		
			workstate		= connection.prepareStatement("update assignmenttracking set facultyremarks=?,mark=?,facultydate=? where assigntracking=?");
	
			workstate.setString(1, remarks);
			workstate.setString(2,mark);
			workstate.setString(3,curTime);
			workstate.setString(4,assigntrack);
			return_value		= 	workstate.executeUpdate();
			
			
		connection.commit();
	
	}
	catch(SQLException sqlexception) { 
		
		sqlexception.printStackTrace();
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
	

	public int updateFacultyRemarks(String assigntrack,String remarks,String mark)throws SQLException,Exception {
		
		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		String curTime					= DateTime.showTime("MySqlWithTime");
	
	
		try {
			
		
			workstate		= connection.prepareStatement("update assignmenttracking set facultyremarks=?,mark=?,facultydate=? where assigntracking=?");
	
			workstate.setString(1, remarks);
			workstate.setString(2,mark);
			workstate.setString(3,curTime);
			workstate.setString(4,assigntrack);
			return_value		= 	workstate.executeUpdate();
			
			
		connection.commit();
	
	}
	catch(SQLException sqlexception) { 
		
		sqlexception.printStackTrace();
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


public int updateAssignment_Tracking(String assigntrack,String remarks,String mark)
{
	int i 						= 0;
	try
	{
		HashMap 	hm			= new HashMap();
		hm.put("0",remarks);
		hm.put("1",mark);
		hm.put("2",assigntrack);
		String s8 				= "update assignmenttracking set remarks=?,mark=? where assigntracking=?";
		i 						= common_data_object.insertUpdatePreparedCommon(hm,s8);
	}
	catch(Exception exception)
	{
		exception.printStackTrace();
	}
	return i;
}

public int insertAssignment(String questionid,String startdate,String enddate,String description,String studentids,String agentid) throws SQLException
{


	PreparedStatement assignstmt 	= null;
	ResultSet idrs					= null;
	PreparedStatement idstmt 		= null;
	ResultSet checkrs				= null;
	PreparedStatement checkstmt 	= null;
	long  assignmentid				= 0l;
	int returnvalue					= 0;
	String sqlquery					= "";
	String oldstudentids			= "";
	Connection connection			= null;



	try {

		connection 	= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);


		sqlquery 		= "select assignmentid,studentids from assignmentmaster where questionid=?";
		checkstmt		= connection.prepareStatement(sqlquery);
		checkstmt.setString(1,questionid);
		checkrs 		= checkstmt.executeQuery();

		if(checkrs.next()) {

			assignmentid	= checkrs.getLong(1);
			oldstudentids	= checkrs.getString(2);


			sqlquery				= "update assignmentmaster set assignmentdate=?,submissiondate=?,remarks=?,studentids=? where assignmentid=?";
			assignstmt		= connection.prepareStatement(sqlquery);
			assignstmt.setString(1,((StringBuffer)datetime.getMySQLFormat(startdate)).toString());
			assignstmt.setString(2,((StringBuffer)datetime.getMySQLFormat(enddate)).toString());
			assignstmt.setString(3,description);
			assignstmt.setString(4,oldstudentids+","+studentids);
			assignstmt.setLong(5,assignmentid);

			returnvalue 		= assignstmt.executeUpdate();

		}
		else{

			sqlquery	= "select max(assignmentid) from assignmentmaster";
			idstmt		= connection.prepareStatement(sqlquery);
			idrs 		= idstmt.executeQuery();

			if(idrs.next()) {
				assignmentid	= idrs.getLong(1);
			}
			assignmentid ++;

			sqlquery			= "insert into assignmentmaster (assignmentid, questionid, assignmentdate, submissiondate, remarks, staffid, studentids) values(?,?,?,?,?,?,?)";

			assignstmt		= connection.prepareStatement(sqlquery);

			assignstmt.setLong(1,assignmentid);
			assignstmt.setString(2,questionid);
			assignstmt.setString(3,((StringBuffer)datetime.getMySQLFormat(startdate)).toString());
			assignstmt.setString(4,((StringBuffer)datetime.getMySQLFormat(enddate)).toString());
			assignstmt.setString(5,description);
			assignstmt.setString(6,agentid);
			assignstmt.setString(7,studentids);
			returnvalue 		= assignstmt.executeUpdate();

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
	 * This method is used to allocate assignment to students through AssignmentBean
	 * @param bean
	 * @return 0 for failure and  greater than 0 for success.
	 * @throws SQLException
	 */

	public int insertAssignment(AssignmentBean bean) throws SQLException
	{
	
		String questionid		= bean.getQuestionid();
		String startdate		= bean.getAssignmentdate();
		String enddate			= bean.getSubmissiondate();
		String description		= bean.getRemarks();
		String studentids		= bean.getStudentids();
		String agentid			= bean.getStaffid();
	
		PreparedStatement assignstmt 	= null;
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
		long  assignmentid				= 0l;
		int returnvalue					= 0;
		String sqlquery					= "";
		String oldstudentids			= "";
		Connection connection			= null;
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
	
	
			sqlquery 		= "select assignmentid,studentids from assignmentmaster where questionid=?";
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,questionid);
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				assignmentid	= checkrs.getLong(1);
				oldstudentids	= checkrs.getString(2);
	
	
				sqlquery				= "update assignmentmaster set assignmentdate=?,submissiondate=?,remarks=?,studentids=? where assignmentid=?";
				assignstmt		= connection.prepareStatement(sqlquery);
				assignstmt.setString(1,((StringBuffer)datetime.getMySQLFormat(startdate)).toString());
				assignstmt.setString(2,((StringBuffer)datetime.getMySQLFormat(enddate)).toString());
				assignstmt.setString(3,description);
				assignstmt.setString(4,oldstudentids+","+studentids);
				assignstmt.setLong(5,assignmentid);
	
				returnvalue 		= assignstmt.executeUpdate();
	
			}
			else{
	
				sqlquery	= "select max(assignmentid) from assignmentmaster";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					assignmentid	= idrs.getLong(1);
				}
				assignmentid ++;
	
				sqlquery			= "insert into assignmentmaster (assignmentid, questionid, assignmentdate, submissiondate, remarks, staffid, studentids) values(?,?,?,?,?,?,?)";
	
				assignstmt		= connection.prepareStatement(sqlquery);
	
				assignstmt.setLong(1,assignmentid);
				assignstmt.setString(2,questionid);
				assignstmt.setString(3,((StringBuffer)datetime.getMySQLFormat(startdate)).toString());
				assignstmt.setString(4,((StringBuffer)datetime.getMySQLFormat(enddate)).toString());
				assignstmt.setString(5,description);
				assignstmt.setString(6,agentid);
				assignstmt.setString(7,studentids);
				returnvalue 		= assignstmt.executeUpdate();
	
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
	 * This method is used to remove the studets from the assignment. 
	 * @param bean
	 * @return 0 for failure greater than 0 for success.
	 * @throws SQLException
	 */
	public int removeStudents(AssignmentBean bean) throws SQLException
	{
		
		String[] students		= bean.getStudentidss();
		String assignmentid		= bean.getAssignmentid();
	 	log.info("invoking removeStudents from com.iGrandee.Assignment.Assignment");
	
	
		PreparedStatement assignstmt 	= null;
		PreparedStatement assignustmt 	= null;
	
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
		int returnvalue					= 0;
		String sqlquery					= "";
		long logid						= 0l;
		String oldstudentids			= "";
		String newstudentids			= "";
		String time						= "";
		String temp[]					= null;
		Connection connection			= null;
		HashMap keyMap					= new HashMap();
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
	
	
			sqlquery 		= "select studentids,current_timestamp from assignmentmaster where assignmentid=?";
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,assignmentid);
	
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				oldstudentids	= checkrs.getString(1);
				time			= checkrs.getString(2);
	
				if(oldstudentids != null)
					temp		= oldstudentids.split(",");
	
				if(students != null && students.length>0){
					for(int y=0;y<students.length;y++){
	
						if(!keyMap.containsKey(students[y]))
							keyMap.put(students[y],students[y]);
					}
				}
	
					if(temp != null && temp.length>0){
						for(int z=0;z<temp.length;z++){
							if(!keyMap.containsKey(temp[z]))
							newstudentids += temp[z]+",";
						}
					}
	
	
				if(newstudentids.length()>2)
					newstudentids	= newstudentids.substring(0,newstudentids.length()-1);
	
	
				sqlquery		= "update assignmentmaster set studentids=? where assignmentid=?";
				assignustmt		= connection.prepareStatement(sqlquery);
				assignustmt.setString(1,newstudentids);
				assignustmt.setString(2,assignmentid);
	
				returnvalue 		+= assignustmt.executeUpdate();
	
	
				sqlquery	= "select max(logid) from assignmentremovelog";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					logid	= idrs.getLong(1);
				}
				logid ++;
	
				sqlquery			= "insert into assignmentremovelog(logid, studentid, studentids, assignmentid, datetime) values(?,?,?,?,?)";
	
				assignstmt		= connection.prepareStatement(sqlquery);
	
	
				if(students != null && students.length>0){
					for(int z=0;z<students.length;z++){
	
						assignstmt.setLong(1,logid);
						assignstmt.setString(2,students[z]);
						assignstmt.setString(3,oldstudentids);
						assignstmt.setString(4,assignmentid);
						assignstmt.setString(5,time);
						assignstmt.addBatch();
						logid++;
					}
				}
	
				assignstmt.executeBatch();
	
			}
	
			connection.commit();
			keyMap	= null;
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
			if(assignustmt != null)
				assignustmt.close();
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	}  
	
	
	
	public int removeStudents(String[] students,String assignmentid) throws SQLException
	{
	 	log.info("invoking removeStudents from com.iGrandee.Assignment.Assignment");
	
	
		PreparedStatement assignstmt 	= null;
		PreparedStatement assignustmt 	= null;
	
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
		ResultSet checkrs				= null;
		PreparedStatement checkstmt 	= null;
		int returnvalue					= 0;
		String sqlquery					= "";
		long logid						= 0l;
		String oldstudentids			= "";
		String newstudentids			= "";
		String time						= "";
		String temp[]					= null;
		Connection connection			= null;
		HashMap keyMap					= new HashMap();
	
	
	
		try {
	
			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
	
	
			sqlquery 		= "select studentids,current_timestamp from assignmentmaster where assignmentid=?";
			checkstmt		= connection.prepareStatement(sqlquery);
			checkstmt.setString(1,assignmentid);
	
			checkrs 		= checkstmt.executeQuery();
	
			if(checkrs.next()) {
	
				oldstudentids	= checkrs.getString(1);
				time			= checkrs.getString(2);
	
				if(oldstudentids != null)
					temp		= oldstudentids.split(",");
	
				if(students != null && students.length>0){
					for(int y=0;y<students.length;y++){
	
						if(!keyMap.containsKey(students[y]))
							keyMap.put(students[y],students[y]);
					}
				}
	
					if(temp != null && temp.length>0){
						for(int z=0;z<temp.length;z++){
							if(!keyMap.containsKey(temp[z]))
							newstudentids += temp[z]+",";
						}
					}
	
	
				if(newstudentids.length()>2)
					newstudentids	= newstudentids.substring(0,newstudentids.length()-1);
	
	
				sqlquery		= "update assignmentmaster set studentids=? where assignmentid=?";
				assignustmt		= connection.prepareStatement(sqlquery);
				assignustmt.setString(1,newstudentids);
				assignustmt.setString(2,assignmentid);
	
				returnvalue 		+= assignustmt.executeUpdate();
	
	
				sqlquery	= "select max(logid) from assignmentremovelog";
				idstmt		= connection.prepareStatement(sqlquery);
				idrs 		= idstmt.executeQuery();
	
				if(idrs.next()) {
					logid	= idrs.getLong(1);
				}
				logid ++;
	
				sqlquery			= "insert into assignmentremovelog(logid, studentid, studentids, assignmentid, datetime) values(?,?,?,?,?)";
	
				assignstmt		= connection.prepareStatement(sqlquery);
	
	
				if(students != null && students.length>0){
					for(int z=0;z<students.length;z++){
	
						assignstmt.setLong(1,logid);
						assignstmt.setString(2,students[z]);
						assignstmt.setString(3,oldstudentids);
						assignstmt.setString(4,assignmentid);
						assignstmt.setString(5,time);
						assignstmt.addBatch();
						logid++;
					}
				}
	
				assignstmt.executeBatch();
	
			}
	
			connection.commit();
			keyMap	= null;
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
			if(assignustmt != null)
				assignustmt.close();
			if(connection != null)
				connection.close();
		}
	
		return returnvalue;
	}  


public ArrayList getAssignmentForHMHomeScreen(String sessionid) throws Exception
{
	ArrayList list=null;
	try
	{	
		log.info("invoking insertStandard for Stanard Insertion");
		select_query="select questionname from assignemntquestion a,yearofsession b,standardschedule c,sectionschedule d where c.sessionid=b.sessionid and c.sessionid='"+sessionid+"' and d.sectionscheduleid=a.sectionscheduleid and d.standardscheduleid=c.standardscheduleid and a.status='A' and b.sessionstatus='A' and c.stdschedulestatus='A' and d.sectionschedulestatus='A';";
		//System.out.print(select_query);
		list=common_data_object.getListMap(select_query);
	}
	catch(Exception exception)
	{
		log.error(exception);

	}
	return list;
}
/**
 * This method is accessed from kycportal/jsp/Parent/TimeTable.jsp
 * This method is accessed from kycportal/jsp/Student/StudentHome.jsp
 * display  Assignment for Parent Page          - prasanth
 @param  standardscheduleid  that can be used to get all assignment details from assignemntquestion table 
 *
 @param  studentid  that can be used to get all assignment details from assignemntquestion table 
 *
 @return the ArrayList by which result can be printed on the screen
*/
public ArrayList loadQuestionsForHomeScreen(String standardscheduleid,String studentid) throws Exception
{
	ArrayList list=null;  
	try  
	{	
		log.info("display  Assignment for Parent Page from com.iGrandee.Assignment.Assignment");
		
		select_query	= "select c.assignmentid,a.lessonscheduleid,a.questionid,a.questionname,case when c.submissiondate>=curDate() then 'Available' else 'Not Available' end as datestatus from assignemntquestion a,sectionschedule b,assignmentmaster c where b.sectionscheduleid=a.sectionscheduleid and b.standardscheduleid='"+standardscheduleid+"' and b.sectionschedulestatus='A' and a.questionid=c.questionid and a.status='A' and find_in_set('"+studentid+"',c.studentids) order by c.assignmentdate desc";
		list			= common_data_object.getListMap(select_query);
		log.info("Display Assign:::>>>>"+select_query);
	}
	catch(Exception exception) 
	{
		log.error(exception); 

	}
	return list;
}
public ArrayList loadQuestionsForHMHomeScreen(String sectionscheduleid) throws Exception
{
	ArrayList list=null;
	try
	{	
		log.info("invoking insertStandard for Stanard Insertion");
		
		select_query	= "select c.assignmentid,a.questionname,a.questionid from assignemntquestion a,assignmentmaster c, standardschedule d,sectionschedule b where a.sectionscheduleid=b.sectionscheduleid and a.status='A' and b.sectionschedulestatus='A' and b.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' and d.sessionid='"+sectionscheduleid+"' and c.questionid=a.questionid ;";
		list			= common_data_object.getListMap(select_query);
		//select_query="select a.questionname from assignemntquestion a where a.sectionscheduleid='"+sectionscheduleid+"'";
		//list=common_data_object.getListMap(select_query);
	}
	catch(Exception exception)
	{
		log.error(exception);

	}
	return list;
}
 CommonDataAccess common_data_object; 
 String insert_query;
 String select_query;
 int 	return_value;
 int[] returnvalue;
 Connection connection;
 DateTime datetime;

}
