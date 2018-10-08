package com.iGrandee.ExamManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class OnlineExam
{
	static Logger log = Logger.getLogger(OnlineExam.class);
	public OnlineExam() {
		
		 
	     common_data_object 	= new CommonDataAccess();
	     insert_query 			= null;
	     select_query 			= null;
	     return_value 			= 0;
	     connection				= null;
	     datetime				= new DateTime();
	 }
	
	/**
	 * This method used to get the session name list for online exam.
	 * @param instituteid
	 * @return List contains all the session name.
	 */
	
	public ArrayList loadSessionForOnlineExam(String instituteid)
	{
		log.info("Invoking loadSessionForOnlineExam(String instituteid) from  com.iGrandee.ExamManagement.OnlineExam");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT distinct a.sessionid,a.sessionname FROM yearofsession a, questionsheetmaster b,subjectschedule c, standardschedule d where a.instituteid='"+instituteid+"' and b.subjectscheduleid=c.subjectscheduleid and d.standardscheduleid=d.standardscheduleid and a.sessionid=d.sessionid and a.sessionstatus='A' and b.questionsheetstatus='A' and c.status='A' and d.stdschedulestatus='A' and b.templatetype='Online Exam' and qsid in (select qsid from questionsheetdetail c,questions d where b.qsid=c.qsid and c.qsdid=d.qsdid and c.type='Objectives') and qsid not in(select qsid from onlineexam where onlineexamstatus='A') and b.qsid not in(select qsid from questionsheetdetail where qsid=b.qsid and type<>'Objectives')";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	 }	
	
	/**
	 * This method used to load all the board for online exam.
	 * @param sessionid
	 * @return List contains board name.
	 */
	
	public ArrayList loadBoardForOnlineExam(String sessionid)
	{
		log.info("Invoking loadBoardForOnlineExam(String sessionid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct c.boardid,concat(c.boardname,'-',d.mediumname) as boardname FROM questionsheetmaster f, standardschedule a, standard b,board c, standardmedium d,subjectschedule e where a.sessionid='"+sessionid+"' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A' and f.templatetype='Online Exam'  and b.boardid=c.boardid and c.boardstatus='A' and c.mediumid=d.mediumid and d.mediumstatus='A' and a.standardscheduleid=e.standardscheduleid and e.subjectscheduleid=f.subjectscheduleid and f.questionsheetstatus='A' and e.status='A' and f.qsid in (select d.qsid from questionsheetdetail d,questions e where f.qsid=d.qsid and d.qsdid=e.qsdid and d.type='Objectives') and f.qsid not in(select qsid from onlineexam where onlineexamstatus='A') and f.qsid not in(select qsid from questionsheetdetail where qsid=f.qsid and type<>'Objectives')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		

	/**
	 * This method used to get all the standard scheduled for online exam.
	 * It is accessed from /jsp/ExamManagement/QuestionPrepareAjax.jsp
	 * @param sessionid
	 * @param boardid
	 * @return List contains Board Names.
	 */
	public ArrayList loadStandardForOnlineExam(String sessionid,String boardid)
	{
		log.info("Invoking loadStandardForOnlineExam(String sessionid,String boardid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct d.standardscheduleid,concat(a.standardname,case when d.groupid is null then '' else (select concat(' - ',groupname) from standardgroup where d.groupid=groupid) end) as standardname FROM standard a, questionsheetmaster c,standardschedule d,subjectschedule e where d.sessionid='"+sessionid+"' and c.subjectscheduleid=e.subjectscheduleid and e.status='A' and d.standardscheduleid=e.standardscheduleid and d.stdschedulestatus='A' and a.standardid=d.standardid and d.stdschedulestatus='A' and c.questionsheetstatus='A' and e.status='A' and a.standardstatus='A' and c.templatetype='Online Exam' and a.boardid='"+boardid+"' and c.qsid in (select d.qsid from questionsheetdetail d,questions e where c.qsid=d.qsid and d.qsdid=e.qsdid and d.type='Objectives') and c.qsid not in(select qsid from onlineexam where onlineexamstatus='A') and c.qsid not in(select qsid from questionsheetdetail where qsid=c.qsid and type<>'Objectives')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		
	
	/**
	 * This method is used to get all the subject name for online exam.
	 * It is accessed from /jsp/ExamManagement/QuestionPrepareAjax.jsp
	 * @param standardscheduleid
	 * @return List contains standard name.
	 */
	public ArrayList loadSubjectForOnlineExam(String standardscheduleid)
	{
		log.info("Invoking loadSubjectForOnlineExam(String standardscheduleid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct a.subjectscheduleid,concat(b.subjectname,'-',b.subjectcode) as subjectname FROM subject b, questionsheetmaster c,subjectschedule a where b.subjectid=a.subjectid and b.subjectstatus='A' and a.status='A' and c.templatetype='Online Exam' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"+standardscheduleid+"' and c.questionsheetstatus='A' and c.qsid in (select d.qsid from questionsheetdetail d,questions e where c.qsid=d.qsid and d.qsdid=e.qsdid and d.type='Objectives') and c.qsid not in(select qsid from onlineexam where onlineexamstatus='A') and c.qsid not in(select qsid from questionsheetdetail where qsid=c.qsid and type<>'Objectives')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		
	
	
	/**
	 * This method used to get the  template names for online exam. 
	 * It is accessed from /jsp/ExamManagement/QuestionPrepareAjax.jsp
	 * @param subjectscheduleid
	 * @return List contains template Name.
	 */
	
	public ArrayList loadTemplateForOnlineExam(String subjectscheduleid)
	{
		log.info("Invoking loadTemplateForOnlineExam(String subjectscheduleid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT c.qsid,c.examname,sum(d.noqn*d.marksperqn) as totalmark, date_format(c.createddate,'%d-%b-%Y') as createddate FROM questionsheetmaster c,questionsheetdetail d where c.subjectscheduleid='"+subjectscheduleid+"' and c.questionsheetstatus='A' and c.templatetype='Online Exam' and c.qsid=d.qsid and d.type='Objectives' and d.qsdid in (select qsdid from questions  where d.qsdid=qsdid) and c.qsid not in(select qsid from onlineexam where onlineexamstatus='A') and c.qsid not in(select qsid from questionsheetdetail where qsid=c.qsid and type<>'Objectives') group by c.qsid";   
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
		
	 }		
	
	/**
	 * This method is used to get the template details for a template.
	 * It is accessed from /jsp/ExamManagement/QuestionPrepareAjax.jsp
	 * @param qsid
	 * @return List contains all the template details.
	 */
	public ArrayList questionSheetDetailsOnlineExam(String qsid)
	{
		log.info("Invoking questionSheetDetailsOnlineExam(String qsid) from  com.iGrandee.ExamManagement.OnlineExam");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select d.lessonname,b.examname,a.df,a.type,a.noqn,a.marksperqn, b.questionsheetstatus from questionsheetdetail a,questionsheetmaster b, lesson d where b.qsid='"+qsid+"' and a.qsid=b.qsid and a.lessonid=d.lessonid and b.templatetype='Online Exam' and a.qsdid in (select qsdid from questions  where a.qsdid=qsdid)";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	 }	
	
	/**
	 * This method used to get all the online exam allotted for the standard today.
	 * It is accessed from /jsp/Student/OnlineExam.jsp
	 * @param standardscheduleid
	 * @return List contains online exam details.
	 */
	
	public ArrayList onlineExamToday(String standardscheduleid)
	{
		log.info("Invoking onlineExamToday(String standardscheduleid) from  com.iGrandee.ExamManagement.OnlineExam");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select b.qsid,b.examname,c.examtimein,c.examtimeout, case when current_timestamp< ADDTIME(concat(curDate(),' 00:00:00'),c.examtimein) then 'NotYetStarted' when current_timestamp between ADDTIME(concat(curDate(),' 00:00:00'),c.examtimein) and ADDTIME(concat(curDate(),' 00:00:00'),c.examtimeout) then 'OnTime' when current_timestamp> ADDTIME(concat(curDate(),' 00:00:00'),c.examtimeout) then 'Finished' end as status from subjectschedule a, questionsheetmaster b,examschedule c,onlineexam d  where a.standardscheduleid='"+standardscheduleid+"' and a.subjectscheduleid=b.subjectscheduleid and a.subjectscheduleid=c.subjectscheduleid and b.templatetype='Online Exam' and c.examdate=curdate() and b.qsid=d.qsid and d.onlineexamstatus='A' and b.questionsheetstatus='A'";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	 }	
	
	/**
	 * This method is used to get the mark scored by student
	 * @param qsid
	 * @param studentid
	 * @return single mark scored
	 */
	
	public String getMarkScored(String qsid,String studentid)
	{
		log.info("Invoking getMarkScored(String qsid,String studentid) from  com.iGrandee.ExamManagement.OnlineExam");
		String pay 		= null;
		try
		{
			select_query  	= "select sum(b.mark) from onlineanswers a,examquestion b where a.qsid='"+qsid+"' and a.studentid='"+studentid+"' and a.examquestionid=b.examquestionid and a.answer=b.correctans"; 
			pay 			= common_data_object.getString(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return pay;
	}		
	
	/**
	 * This method used to the total question answered by the student.
	 * @param qsid
	 * @param studentid
	 * @return number which is totally answered.
	 */
	
	public int getTotalAnswered(String qsid,String studentid)
	{
		log.info("Invoking getTotalAnswered(String qsid,String studentid) from  com.iGrandee.ExamManagement.OnlineExam");
		int pay 		= 0;
		try
		{
			select_query  	= "select count(answerid) from onlineanswers a where a.qsid='"+qsid+"' and a.studentid='"+studentid+"'"; 
			pay 			= Integer.parseInt(common_data_object.getString(select_query));
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return pay;
	}		
	
	/**
	 * This method is used get the total questions for template id
	 * @param qsid
	 * @return single total question number.
	 */
	public int getTotalQuestion(String qsid)
	{
		log.info("Invoking getTotalQuestion(String qsid) from  com.iGrandee.ExamManagement.OnlineExam");
		int pay 		= 0;
		try
		{
			select_query  	= "select sum(noqn) from questionsheetdetail where qsid='"+qsid+"'"; 
			pay 			= Integer.parseInt(common_data_object.getString(select_query));
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return pay;
	}		
	

	/**
	 * This method is used get the total mark for template id
	 * @param qsid
	 * @return single total mark
	 */
	public String getTotalMark(String qsid)
	{
		log.info("Invoking getTotalMark(String qsid) from  com.iGrandee.ExamManagement.OnlineExam");
		String pay 		= null;
		try
		{
			select_query  	= "select sum(noqn*marksperqn) from questionsheetdetail where qsid='"+qsid+"'"; 
			pay 			= common_data_object.getString(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return pay;
	}			
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * This method used for inserting the online exam.
	 * It is accessed from /jsp/ExamManagement/OnlineExamSubmit.jsp
	 * @param qsid
	 * @param passmark
	 * @return 0 for failure and greater than  0 for success.
	 * @throws Exception
	 */
	
	public int assignOnlineExam(String qsid, String passmark)throws Exception
	{
		Connection connection 			= null;
		ResultSet master 				= null;
		Statement masterstmt			= null;
		ResultSet checkrs 				= null;
		PreparedStatement checkstmt		= null;
		
		PreparedStatement masterpstmt	= null;
		long l 							= 0L;
		int  returnvalue				= 0;
	
		try
		{
	
			connection 		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			
			checkstmt		 = connection.prepareStatement("select onlineexamid from onlineexam where qsid=? and onlineexamstatus=?");
			checkstmt.setString(1, qsid);
			checkstmt.setString(2, "A");
			checkrs			 = checkstmt.executeQuery();
			
			if(!checkrs.next()){
	
				String todaydate = DateTime.showTime("MySqlWithTime");
				masterstmt		 = connection.createStatement();
				master 			 = masterstmt.executeQuery("select max(onlineexamid) from onlineexam");
				
				if(master.next())
					l = master.getLong(1);
		
				l++;
		
				String masterquery	= "insert into onlineexam (onlineexamid, qsid, assigneddate, passmark, onlineexamstatus) values(?,?,?,?,?)";
				masterpstmt			= connection.prepareStatement(masterquery);
				masterpstmt.setLong(1,l);
				masterpstmt.setString(2,qsid);
				masterpstmt.setString(3,todaydate);
				masterpstmt.setString(4,passmark);
				masterpstmt.setString(5,"A");
				returnvalue			= masterpstmt.executeUpdate();
			}
			else
				returnvalue			= 1000;
			
			connection.commit();
	
		}
		catch(Exception Ex)
		{
			returnvalue	= 0;
			if(connection != null)
				connection.rollback();
		}
		finally
		{
	
			if(master != null)
				master.close();
			if(masterstmt != null)
				masterstmt.close();
			if(checkrs != null)
				checkrs.close();
			if(checkstmt != null)
				checkstmt.close();
			if(masterpstmt != null)
				masterpstmt.close();
	
			ConnectionManager.closeConnection(connection);
		}
	
		return returnvalue;
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	public String getIssueDescription(String qsid,String studentid)
	{
		log.info("Invoking getIssueDescription(String qsid,String studentid) from  com.iGrandee.ExamManagement.OnlineExam");
		String academicList = null;
			try
			{
				select_query  	= "SELECT description FROM certificateissue where studentid='"+studentid+"' and qsid='"+qsid+"' and certificateissuestatus='A'"; 
				academicList 	= common_data_object.getString(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		

	

	
	
	public ArrayList loadSessionForOnlineExamForReport(String instituteid)
	{
		log.info("Invoking loadSessionForOnlineExam(String instituteid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct a.sessionid,a.sessionname FROM yearofsession a, questionsheetmaster b where a.instituteid='"+instituteid+"' and (a.sessionstatus='A' or a.sessionstatus='R') and a.sessionid=b.sessionid and b.questionsheetstatus='A' and b.templatetype='Exam' and qsid in (select qsid from questionsheetdetail c,questions d where b.qsid=c.qsid and c.qsdid=d.qsdid)";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	
	public ArrayList loadExamNameForOnlineExam(String sessionid)
	{
		log.info("Invoking loadExamNameForOnlineExam(String sessionid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct a.examnameid,a.examname FROM examname a,questionsheetmaster b where a.examnamestatus='A' and b.sessionid='"+sessionid+"' and b.questionsheetstatus='A' and b.templatetype='Exam' and a.examnameid=b.examid and b.qsid in (select c.qsid from questionsheetdetail c,questions d where b.qsid=c.qsid and c.qsdid=d.qsdid) and b.qsid not in(select qsid from onlineexam where onlineexamstatus='A')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }

	public ArrayList loadBoardForOnlineExam(String sessionid,String examid)
	{
		log.info("Invoking loadBoardForOnlineExam(String sessionid,String examid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct c.boardid,concat(c.boardname,'-',d.mediumname) as boardname FROM questionsheetmaster f, standardschedule a,standard b,board c, standardmedium d where a.sessionid='"+sessionid+"' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A' and f.templatetype='Online Exam'  and b.boardid=c.boardid and c.boardstatus='A' and c.mediumid=d.mediumid and d.mediumstatus='A' and a.sessionid=f.sessionid and f.questionsheetstatus='A'  and f.qsid in (select d.qsid from questionsheetdetail d,questions e where f.qsid=d.qsid and d.qsdid=e.qsdid and d.type='Objectives') and f.qsid not in(select qsid from onlineexam where onlineexamstatus='A') and f.qsid not in(select qsid from questionsheetdetail where qsid=f.qsid and type<>'Objectives')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	

	public ArrayList loadStandardForOnlineExam(String sessionid,String examid,String boardid)
	{
		log.info("Invoking loadStandardForOnlineExam(String sessionid,String examid,String boardid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct a.standardid,a.standardname FROM standard a,subject b, questionsheetmaster c where c.sessionid='"+sessionid+"' and c.subjectid=b.subjectid and a.standardid=b.standardid and c.questionsheetstatus='A' and b.subjectstatus='A' and a.standardstatus='A' and c.templatetype='Online Exam' and a.boardid='"+boardid+"' and c.qsid in (select d.qsid from questionsheetdetail d,questions e where c.qsid=d.qsid and d.qsdid=e.qsdid and d.type='Objectives') and c.qsid not in(select qsid from onlineexam where onlineexamstatus='A') and c.qsid not in(select qsid from questionsheetdetail where qsid=c.qsid and type<>'Objectives')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	public ArrayList loadSubjectForOnlineExam(String sessionid,String examid,String standardid)
	{
		log.info("Invoking loadSubjectForOnlineExam(String sessionid,String examid,String standardid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct b.subjectid,concat(b.subjectname,'-',b.subjectcode) as subjectname FROM subject b, questionsheetmaster c where c.sessionid='"+sessionid+"' and c.subjectid=b.subjectid and b.subjectstatus='A' and c.templatetype='Online Exam'  and b.standardid='"+standardid+"' and c.questionsheetstatus='A' and c.qsid in (select d.qsid from questionsheetdetail d,questions e where c.qsid=d.qsid and d.qsdid=e.qsdid and d.type='Objectives') and c.qsid not in(select qsid from onlineexam where onlineexamstatus='A') and c.qsid not in(select qsid from questionsheetdetail where qsid=c.qsid and type<>'Objectives')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	
	public ArrayList loadTemplateForOnlineExam(String sessionid,String examid,String subjectid)
	{
		log.info("Invoking loadTemplateForOnlineExam(String sessionid,String examid,String standardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT c.qsid,c.examname,sum(d.noqn*d.marksperqn) as totalmark, date_format(c.createddate,'%d-%b-%Y') as createddate FROM questionsheetmaster c,questionsheetdetail d where c.sessionid='"+sessionid+"' and c.subjectid='"+subjectid+"' and c.questionsheetstatus='A' and c.templatetype='Online Exam'  and c.qsid=d.qsid and d.type='Objectives' and d.qsdid in (select qsdid from questions  where d.qsdid=qsdid) and c.qsid not in(select qsid from onlineexam where onlineexamstatus='A') and c.qsid not in(select qsid from questionsheetdetail where qsid=c.qsid and type<>'Objectives') group by c.qsid";   
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	



	
	public ArrayList loadQuestionForOnlneExam(String studentid)
	{
		log.info("Invoking loadQuestionForOnlneExam(String studentid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select d.subjectid,e.qsid,concat(d.subjectname,' - ',d.subjectcode) as subjectname, e.duration, f.feetype,f.fee,e.examname,e.restartingduration,e.attempt,sum(h.noqn) as totalquestion from subscription a join subjectschedule b on a.studentapprovalid='"+studentid+"' and a.subjectscheduleid=b.subjectscheduleid and a.subscriptionstatus='A' and b.status='A' join subject d on b.subjectid=d.subjectid and d.subjectstatus='A' join questionsheetmaster e on d.subjectid=e.subjectid and e.questionsheetstatus='A' join onlineexam f on e.qsid=f.qsid and f.onlineexamstatus='A' join standardschedule g on g.sessionid=e.sessionid and g.standardscheduleid=b.standardscheduleid join questionsheetdetail h on e.qsid=h.qsid group by e.qsid order by d.subjectid,f.assigneddate desc";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	

	public ArrayList loadQuestionForOnlneExam(String studentid,String subjectscheduleid)
	{
		log.info("Invoking loadQuestionForOnlneExam(String studentid,String subjectscheduleid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select e.qsid,concat(d.subjectname,' - ',d.subjectcode) as subjectname, e.duration, f.feetype,f.fee,e.examname,(select onlineexamsubscriptionid from onlinexamsubscription where qsid=e.qsid and subscribedby='"+studentid+"' and examsubscriptionstatus='A') as paidstatus from subscription a join subjectschedule b on a.studentapprovalid='"+studentid+"' and b.subjectscheduleid='"+subjectscheduleid+"' and a.subjectscheduleid=b.subjectscheduleid and a.subscriptionstatus='A' and b.status='A' join subject d on b.subjectid=d.subjectid and d.subjectstatus='A' join questionsheetmaster e on d.subjectid=e.subjectid and e.questionsheetstatus='A' join onlineexam f on e.qsid=f.qsid and f.onlineexamstatus='A' join standardschedule g on g.sessionid=e.sessionid and g.standardscheduleid=b.standardscheduleid order by paidstatus,f.assigneddate desc";  
				academicList 	= common_data_object.getListMap(select_query);
				//System.out.print("select_query-->"+select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	public ArrayList loadQuestionWritten(String standardscheduleid,String studentid)
	{
		log.info("Invoking loadQuestionWritten(String standardscheduleid,String studentid) from  com.iGrandee.ExamManagement.OnlineExam");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select e.qsid,concat(d.subjectname,' - ',d.subjectcode) as subjectname,e.examname, (select certificateissueid from certificateissue where e.qsid=qsid and studentid='"+studentid+"') as certificateissueid from standardschedule a join subjectschedule b on a.standardscheduleid='"+standardscheduleid+"' and a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A' and b.status='A' join subject d on b.subjectid=d.subjectid and d.subjectstatus='A' join questionsheetmaster e on d.subjectid=e.subjectid and e.questionsheetstatus='A' and e.qsid in (select qsid from onlineanswers where studentid='"+studentid+"')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	
	
	
	public ArrayList loadExistingTemplateDetails(String qsid)
	{
		log.info("Invoking loadExistingTemplateDetails(String qsid) from  com.iGrandee.ExamManagement.OnlineExam");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT distinct a.qsdid,a.lessonid, a.df, a.type, a.noqn, a.marksperqn, b.lessonname FROM questionsheetdetail a,lesson b where a.qsid='"+qsid+"' and a.lessonid=b.lessonid"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}	
	
	public ArrayList loadPaidDetails(String qsid,String studentid)
	{
		log.info("Invoking loadPaidDetails(String qsid,String studentid) from  com.iGrandee.ExamManagement.OnlineExam");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT bankname,date_format(dddate,'%d-%b-%Y') as dddate, ddnumber,amount FROM onlinexamsubscription where qsid='"+qsid+"' and subscribedby='"+studentid+"' and examsubscriptionstatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}		
	
	
	public ArrayList loadExamDetails(String qsid)
	{
		log.info("Invoking loadExamDetails(String qsid) from  com.iGrandee.ExamManagement.OnlineExam");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select a.examname,concat(b.subjectname,' - ',b.subjectcode) as subjectname,a.duration, date_format(a.createddate,'%d-%b-%Y') as createddate from questionsheetmaster a, subject b where a.qsid='"+qsid+"' and a.subjectid=b.subjectid"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}		
	
	
	
	public String getPayStatus(String qsid,String studentid)
	{
		log.info("Invoking getPayStatus(String qsid,String studentid) from  com.iGrandee.ExamManagement.OnlineExam");
		String pay 		= null;
		try
		{
			select_query  	= "select onlineexamsubscriptionid from onlinexamsubscription where qsid='"+qsid+"' and subscribedby='"+studentid+"' and examsubscriptionstatus='A'"; 
			pay 			= common_data_object.getString(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return pay;
	}		


	
	
	

	public int assignOnlineExam(String qsid, String passmark,String examfeetype,String examfee)throws Exception
	{
		Connection connection 			= null;
		ResultSet master 				= null;
		Statement masterstmt			= null;
		ResultSet checkrs 				= null;
		PreparedStatement checkstmt		= null;
		
		PreparedStatement masterpstmt	= null;
		long l 							= 0L;
		int  returnvalue				= 0;
	
		try
		{
	
			connection 		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			
			checkstmt		 = connection.prepareStatement("select onlineexamid from onlineexam where qsid=? and onlineexamstatus=?");
			checkstmt.setString(1, qsid);
			checkstmt.setString(2, "A");
			checkrs			 = checkstmt.executeQuery();
			
			if(!checkrs.next()){
	
				String todaydate = DateTime.showTime("MySqlWithTime");
				masterstmt		 = connection.createStatement();
				master 			 = masterstmt.executeQuery("select max(onlineexamid) from onlineexam");
				
				
				
				if(master.next())
					l = master.getLong(1);
		
				l++;
		
				String masterquery	= "insert into onlineexam (onlineexamid, qsid, assigneddate, passmark, onlineexamstatus, feetype, fee) values(?,?,?,?,?,?,?)";
				masterpstmt			= connection.prepareStatement(masterquery);
				masterpstmt.setLong(1,l);
				masterpstmt.setString(2,qsid);
				masterpstmt.setString(3,todaydate);
				masterpstmt.setString(4,passmark);
				masterpstmt.setString(5,"A");
				masterpstmt.setString(6,examfeetype);
				masterpstmt.setString(7,examfee);
				
				returnvalue			= masterpstmt.executeUpdate();
			}
			else
				returnvalue			= 1000;
			
			connection.commit();
	
		}
		catch(Exception Ex)
		{
			returnvalue	= 0;
			if(connection != null)
				connection.rollback();
		}
		finally
		{
	
			if(master != null)
				master.close();
			if(masterstmt != null)
				masterstmt.close();
			if(checkrs != null)
				checkrs.close();
			if(checkstmt != null)
				checkstmt.close();
			if(masterpstmt != null)
				masterpstmt.close();
	
			ConnectionManager.closeConnection(connection);
		}
	
		return returnvalue;
	}
	
	
	public int DeallocateOnlineExam(String [] onlineid, String status)throws Exception
	{
		Connection connection 			= null;
		PreparedStatement masterpstmt	= null;
		int  returnvalue				= 0;

		try
		{

			connection 		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			if(onlineid!=null &&  onlineid.length>0)
			{
				for(int i=0;i<onlineid.length;i++)
				{
					String masterquery	= "update onlineexam set onlineexamstatus=? where onlineexamid=?";
					masterpstmt			= connection.prepareStatement(masterquery);
					masterpstmt.setString(1,status);
					masterpstmt.setString(2,onlineid[i]);
					returnvalue	+= masterpstmt.executeUpdate();
				}
			}
			connection.commit();

		}
		catch(Exception Ex)
		{
			returnvalue	= 0;
			if(connection != null)
				connection.rollback();
			
		}
		finally
		{

			if(masterpstmt != null)
				masterpstmt.close();
		
			ConnectionManager.closeConnection(connection);
		}

		return returnvalue;
	}

	public int payForExam(String qsid,String studentid, String bankname, String ddnumber, String dddate, String amount,String jointype)throws Exception
	{
		Connection connection 			= null;
		ResultSet master 				= null;
		Statement masterstmt			= null;
		PreparedStatement masterpstmt	= null;
		long l 							= 0L;
		int  returnvalue				= 0;
	
		try
		{
	
			connection 		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			

			String todaydate = DateTime.showTime("MySqlWithTime");
			masterstmt		 = connection.createStatement();
			master 			 = masterstmt.executeQuery("select max(onlineexamsubscriptionid) from onlinexamsubscription");
			
			
			
			if(master.next())
				l = master.getLong(1);
	
			l++;
	
			String masterquery	= "insert into onlinexamsubscription(onlineexamsubscriptionid, qsid, subscribedby, dateofsubscription, amount,dddate, dateofcreation, createdby, examsubscriptionstatus,jointype, bankname, ddnumber) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			masterpstmt			= connection.prepareStatement(masterquery);
			masterpstmt.setLong(1,l);
			masterpstmt.setString(2,qsid);
			masterpstmt.setString(3,studentid);
			masterpstmt.setString(4,todaydate);
			masterpstmt.setString(5,amount);
			masterpstmt.setString(6,datetime.getMySQLFormatHifen(dddate).toString());
			masterpstmt.setString(7,todaydate);
			masterpstmt.setString(8,null);
			masterpstmt.setString(9,"A");
			masterpstmt.setString(10,jointype);
			masterpstmt.setString(11,bankname);
			masterpstmt.setString(12,ddnumber);
			returnvalue			= masterpstmt.executeUpdate();
			
			
			connection.commit();
	
		}
		catch(Exception Ex)
		{
			returnvalue	= 0;
			if(connection != null)
				connection.rollback();
		}
		finally
		{
	
			if(master != null)
				master.close();
			if(masterstmt != null)
				masterstmt.close();
			if(masterpstmt != null)
				masterpstmt.close();
	
			ConnectionManager.closeConnection(connection);
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
