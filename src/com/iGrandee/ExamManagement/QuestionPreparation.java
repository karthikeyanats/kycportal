package com.iGrandee.ExamManagement;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Random;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class QuestionPreparation
{
	static Logger log = Logger.getLogger(QuestionPreparation.class);
	public QuestionPreparation() {
		
		 
	     common_data_object 	= new CommonDataAccess();
	     insert_query 			= null;
	     select_query 			= null;
	     return_value 			= 0;
	     connection				= null;
	     datetime				= new DateTime();
	 }
	
	/**
	 * This method used to get all the active sessions. 
	 * It is accessed from /jsp/ExamManagement/QuestionPreparation.jsp
	 * @param instituteid
	 * @return list contains session.
	 */
	
	//used
	
	public ArrayList loadSession(String instituteid)
	{
		log.info("Invoking loadSession(String instituteid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT sessionid,sessionname FROM yearofsession where instituteid='"+instituteid+"' and sessionstatus='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	
	/**
	 * This method used to  get the board names based on the sessionid.
	 * It is accessed from /jsp/ExamManagement/QuestionPrepareAjax.jsp
	 * @param sessionid from yearofsession table
	 * @return BoardNameList
	 */
	
	// used

	public ArrayList loadBoardNamePrepare(String sessionid)
	{
		log.info("Invoking loadBoardNamePrepare(String sessionid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct c.boardid,concat(c.boardname,'-',d.mediumname) as boardname from standardschedule a,standard b,board c, standardmedium d where a.sessionid='"+sessionid+"' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A' and b.boardid=c.boardid and c.boardstatus='A' and c.mediumid=d.mediumid and d.mediumstatus='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	
	/**
	 * This method used to  get the board names based on the sessionid
	 * @param sessionid from yearofsession table @boardid from board table
	 * @return StandardNameList
	 */
	
	//used

	public ArrayList loadStandardNamePrepare(String sessionid,String boardid)
	{
		log.info("Invoking loadStandardNamePrepare(String sessionid,String boardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct a.standardscheduleid,concat(b.standardname,case when a.groupid is null then '' else (select concat(' - ',groupname) from standardgroup where a.groupid=groupid) end) as standardname from standardschedule a,standard b where a.sessionid='"+sessionid+"' and a.standardid=b.standardid and b.boardid='"+boardid+"' and a.stdschedulestatus='A' and b.standardstatus='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		
	
	/**
	 * This method used to get all the subjects for a Standard.
	 * It is accessed from /jsp/ExamManagement/Preparation.jsp 
	 * @param standardscheduleid
	 * @return List contains subject in the Standard.
	 */
	// used
	public ArrayList loadSubjects(String standardscheduleid)
	{
		log.info("Invoking loadSubjects(String standardscheduleid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT b.subjectscheduleid,concat(subjectname,'-',subjectcode) as subjectname FROM `subject` a, subjectschedule b where b.standardscheduleid='"+standardscheduleid+"' and a.subjectid=b.subjectid and b.status='A' and subjectstatus='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method used to load all the lessons for a particular Subject.
	 * It is accessed from /jsp/ExamManagement/Preparation.jsp
	 * @param subjectscheduleid
	 * @return List contains all the Lesson.
	 */
	//used

	public ArrayList loadLessons(String subjectscheduleid)
	{
		log.info("Invoking loadLessons(String subjectscheduleid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select a.lessonid,a.lessonname from lesson a,lessonschedule b where b.subjectscheduleid='"+subjectscheduleid+"' and lessonstatus='A' and b.lessonid=a.lessonid and b.status='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	
	/**
	 * This method used to get all the existing generated template for this subject.
	 * It is accessed from /jsp/ExamManagement/Preparation.jsp.
	 * @param subjectscheduleid
	 * @return List contains all the template.
	 */
	//used
	public ArrayList loadExistingTempates(String subjectscheduleid)
	{
		log.info("Invoking loadExistingTempates(String subjectid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct qsid,examname from questionsheetmaster where questionsheetstatus='A' and subjectscheduleid in (select subjectscheduleid from subjectschedule where status='A' and subjectid in (select subjectid from subjectschedule where subjectscheduleid='"+subjectscheduleid+"'))"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method used get the total template generated for this subject.
	 * It is accessed from /jsp/ExamManagement/Preparation.jsp
	 * @param subjectscheduleid
	 * @return String which represent the count.
	 */
	
	//used
	public String getMaxTemplateNumber(String subjectscheduleid)
	{
		log.info("Invoking getMaxTemplateNumber(String subjectscheduleid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		String academicList = null;
		try
		{
			select_query  	= "select count(qsid) from questionsheetmaster where questionsheetstatus='A' and subjectscheduleid in (select subjectscheduleid from subjectschedule where status='A' and subjectid in (select subjectid from subjectschedule where subjectscheduleid='"+subjectscheduleid+"'))";  
			academicList 	= common_data_object.getString(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}	
	
	/**
	 * This method used to get the template details for a template.
	 * It is accessed from /jsp/ExamManagement/QuestionPreparationAjax.jsp
	 * @param qsid
	 * @return List contains Template details.
	 */
	
	public ArrayList loadExistingTemplateDetails(String qsid)
	{
		log.info("Invoking loadExistingTemplateDetails(String qsid) from  com.iGrandee.ExamManagement.QuestionPreparation");
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
	
	/**
	 * This method is used to get the question type.
	 * It is accessed from /jsp/ExamManagement/QuestionPreparationAjax.jsp
	 * @param lessonid
	 * @return List contains question type.
	 */
	
	public ArrayList loadQuestionType(String lessonid)
	{
		log.info("Invoking loadQuestionType(String lessonid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct type FROM examquestion where lessonid='"+lessonid+"' and examquestionstatus='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method is used to load the difficulty.
	 * It is accessed from /jsp/ExamManagement/QuestionPreparationAjax.jsp
	 * @param lessonid
	 * @param questiontype
	 * @return List contains Difficulty factor.
	 */
	
	
	public ArrayList loadDifficultyFactor(String lessonid,String questiontype)
	{
		log.info("Invoking loadDifficultyFactor(String lessonid,String questiontype) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct df from examquestion where lessonid='"+lessonid+"' and type='"+questiontype+"' and examquestionstatus='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method is used to get the Exam Type
	 * It is accessed from /jsp/ExamManagement/QuestionPreparationAjax.jsp
	 * @param lessonid
	 * @param questiontype
	 * @param dfactor
	 * @return List contains Exam Type.
	 */
	
	public ArrayList getExamType(String lessonid,String questiontype,String dfactor)
	{
		log.info("Invoking getExamType(String lessonid,String questiontype,String dfactor) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select distinct b.examtypeid,b.examtypename from examquestion a,examtype b where lessonid='"+lessonid+"' and type='"+questiontype+"' and df='"+dfactor+"' and a.examtypeid=b.examtypeid and a.examquestionstatus='A' and b.examtypestatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}	
	
	/**
	 * This method used to get the mark details.
	 * It is accessed from /jsp/ExamManagement/QuestionPreparationAjax.jsp
	 * @param lessonid
	 * @param questiontype
	 * @param dfactor
	 * @param examid
	 * @return List contains Marks
	 */
	public ArrayList getExamMark(String lessonid,String questiontype,String dfactor,String examid)
	{
		log.info("Invoking getExamMark(String lessonid,String questiontype,String dfactor,String examid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select distinct mark from examquestion  where lessonid='"+lessonid+"' and type='"+questiontype+"' and df='"+dfactor+"' and examtypeid='"+examid+"' and examquestionstatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}	
	
	/**
	 * This method is used to get the Total Question entered for the lesson.
	 * It is accessed from /jsp/ExamManagement/QuestionPreparationAjax.jsp
	 * @param lessonid
	 * @param questiontype
	 * @param dfactor
	 * @param examid
	 * @param mark
	 * @return String which represent the count.
	 */
	
	public String getTotalQuestion(String lessonid,String questiontype,String dfactor,String examid,String mark)
	{
		log.info("Invoking getTotalQuestion(String lessonid,String questiontype,String dfactor,String examid,String mark) from  com.iGrandee.ExamManagement.QuestionPreparation");
		String academicList = null;
		try
		{
			select_query  	= "select count(examquestionid) from examquestion where lessonid='"+lessonid+"' and Type='"+questiontype+"' and DF='"+dfactor+"' and examtypeid='"+examid+"' and mark='"+mark+"'  and examquestionstatus='A'"; 
			academicList 	= common_data_object.getString(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}
	
	/**
	 * This method used to get the question available for use.
	 * It is accessed from /jsp/ExamManagement/QuestionPreparationAjax.jsp
	 * @param lessonid
	 * @param questiontype
	 * @param dfactor
	 * @param examid
	 * @param mark
	 * @return String represent the count.
	 */
	public String getAvailableQuestion(String lessonid,String questiontype,String dfactor,String examid,String mark)
	{
		log.info("Invoking getAvailableQuestion(String lessonid,String questiontype,String dfactor,String examid,String mark) from  com.iGrandee.ExamManagement.QuestionPreparation");
		String academicList = null;
		try
		{
			select_query  	= "select count(examquestionid) from examquestion where lessonid='"+lessonid+"' and Type='"+questiontype+"' and DF='"+dfactor+"' and examtypeid='"+examid+"' and mark='"+mark+"' and (occurance>actualoccurance or occurance=0) and fromdate<=curDate() and todate>=curDate()  and examquestionstatus='A'";  
			academicList 	= common_data_object.getString(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}	
	
	/**
	 * This method is used load the Session Details for Template Approval.
	 * It is accessed from /jsp/ExamManagement/QuestionApprove.jsp
	 * @param instituteid
	 * @return List contains Session Name.
	 */
	
	public ArrayList loadSessionForApproval(String instituteid)
	{
		log.info("Invoking loadSessionForApproval(String instituteid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT distinct sessionid,sessionname FROM yearofsession where instituteid='"+instituteid+"' and sessionstatus='A' and sessionid in (select a.sessionid from standardschedule a,subjectschedule b, questionsheetmaster c where a.instituteid='"+instituteid+"' and a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A' and b.subjectscheduleid=c.subjectscheduleid and b.status='A')";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	 }	
	
	/**
	 * This method is used to get the Board Details for approve.
	 * It is accessed from /jsp/ExamManagement/QuestionApprove.jsp
	 * @param sessionid
	 * @return List contains Board Name
	 */
	public ArrayList loadBoardNameForApproval(String sessionid)
	{
		log.info("Invoking loadBoardNameForApproval(String sessionid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct c.boardid,concat(c.boardname,'-',d.mediumname) as boardname FROM standardschedule a,standard b,board c, standardmedium d where a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A' and b.boardid=c.boardid and c.boardstatus='A' and c.mediumid=d.mediumid and d.mediumstatus='A' and a.sessionid in (select a1.sessionid from standardschedule a1,subjectschedule b1, questionsheetmaster c1 where a1.sessionid='"+sessionid+"' and a1.standardscheduleid=b1.standardscheduleid and a1.stdschedulestatus='A' and b1.subjectscheduleid=c1.subjectscheduleid and b1.status='A')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * Method used to get the standard List for template approve
	 * It is accessed from /jsp/ExamManagement/QuestionApprove.jsp
	 * accessed by prasanth in igeducation/jsp/ExamManagement/TemplateStatusList.jsp
	 * @param sessionid that can be used to get standard by sessionid wise
	 * @param examid that can be used to get standard by examid wise
	 * @param boardid that can be used to get standard by boardid wise
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList loadStandardForApproval(String sessionid,String boardid)
	{
		log.info("Invoking loadStandardForApproval(String sessionid,String examid,String boardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct a.standardscheduleid,concat(d.standardname,case when a.groupid is null then '' else (select concat(' - ',groupname) from standardgroup where a.groupid=groupid) end) as standardname from standardschedule a,subjectschedule b, questionsheetmaster c,standard d where a.sessionid='"+sessionid+"' and a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A' and b.subjectscheduleid=c.subjectscheduleid and b.status='A' and a.standardid=d.standardid and d.boardid='"+boardid+"' and d.standardstatus='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method is used to load the subject name for Template Approval.
	 * It is accessed from /jsp/ExamManagement/QuestionApprove.jsp
	 * @param standardscheduleid
	 * @return List contains Subject Name
	 */
	
	public ArrayList loadSubjectForApproval(String standardscheduleid)
	{
		log.info("Invoking loadSubjectForApproval(String standardscheduleid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct b.subjectscheduleid,concat(a.subjectname,' - ',a.subjectcode) as subjectname from subject a,subjectschedule b,questionsheetmaster c where b.standardscheduleid='"+standardscheduleid+"' and a.subjectid=b.subjectid and a.subjectstatus='A' and b.subjectscheduleid=c.subjectscheduleid and b.status='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
				   
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method used to get the template details.
	 * It is accessed from /jsp/ExamManagement/QuestionApprove.jsp
	 * @param subjectscheduleid
	 * @return List contains Template Details.
	 */
	
	public ArrayList loadTemplateForApproval(String subjectscheduleid)
	{
		log.info("Invoking loadTemplateForApproval(String sessionid,String examid,String subjectid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct qsid,examname from questionsheetmaster where subjectscheduleid='"+subjectscheduleid+"'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method is used get the template type.
	 * It is accessed from /jsp/ExamManagement/QuestionApprove.jsp
	 * @param qsid
	 * @return List contains Template Type.
	 */
	
	public ArrayList loadTemplateTypeForApproval(String qsid)
	{
		log.info("Invoking loadTemplateTypeForApproval(String qsid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct c.templatetype FROM questionsheetmaster c where c.qsid='"+qsid+"' and (c.questionsheetstatus='D' or c.questionsheetstatus='A' or c.questionsheetstatus='X')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	/**
	 * This method used to get the question sheet details.
	 * It is accessed from /jsp/ExamManagement/QuestionApprove.jsp
	 * @param qsid
	 * @return List contains all the question sheet details.
	 */
	
	
	public ArrayList questionSheetDetails(String qsid)
	{
		log.info("Invoking questionSheetDetails(String qsid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select d.lessonname,b.examname,a.df,a.type,a.noqn,a.marksperqn, b.questionsheetstatus, case when (select examquestionid from questions where a.qsdid=qsdid group by qsdid) is null then 'Not Generated' else 'Generated' end as status, case when b.instruction is null or b.instruction='' then '-' else b.instruction end as instruction, case when (select onlineexamid from onlineexam where qsid=b.qsid and onlineexamstatus='A') is null then 'Not Assigned' else 'Assigned' end as assignstatus  from questionsheetdetail a,questionsheetmaster b, lesson d where b.qsid='"+qsid+"' and a.qsid=b.qsid and a.lessonid=d.lessonid";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method used to get the Session List for Generation.
	 * It is accessed from /jsp/ExamManagement/QuestionGeneration.jsp
	 * @param instituteid
	 * @return List contains Session Name
	 */
	public ArrayList loadSessionForGeneration(String instituteid)
	{
		log.info("Invoking loadSessionForGeneration(String instituteid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct sessionid,sessionname FROM yearofsession where instituteid='"+instituteid+"' and sessionstatus='A' and sessionid in (select a.sessionid from standardschedule a,subjectschedule b, questionsheetmaster c where a.instituteid='"+instituteid+"' and a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A' and b.subjectscheduleid=c.subjectscheduleid and b.status='A' and c.questionsheetstatus='A')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method used to get the exam type
	 * It is accessed from /jsp/ExamManagement/QuestionGeneration.jsp
	 * @param userid
	 * @return List contains all the exam type.
	 */
	
	public ArrayList getExamType(String userid)
	{
		log.info("Invoking getExamType(String userid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select distinct b.examtypeid,b.examtypename from examtype b where b.createdby='"+userid+"' and b.examtypestatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	}	
	
	
	/**
	 * This method used to get the board details for the Question Generation.
	 * It is accessed from /jsp/ExamManagement/QuestionGeneration.jsp
	 * @param sessionid
	 * @return List contains Board Details.
	 */
	public ArrayList loadBoardForGeneration(String sessionid)
	{
		log.info("Invoking loadBoardForGeneration(String sessionid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct c.boardid,concat(c.boardname,'-',d.mediumname) as boardname FROM standardschedule a,standard b,board c, standardmedium d where a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A' and b.boardid=c.boardid and c.boardstatus='A' and c.mediumid=d.mediumid and d.mediumstatus='A' and a.sessionid in (select a1.sessionid from standardschedule a1,subjectschedule b1, questionsheetmaster c1 where a1.sessionid='"+sessionid+"' and a1.standardscheduleid=b1.standardscheduleid and a1.stdschedulestatus='A' and b1.subjectscheduleid=c1.subjectscheduleid and b1.status='A' and c1.questionsheetstatus='A')";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method used to get the Standard for Question Generation
	 * It is accessed from /jsp/ExamManagement/QuestionGeneration.jsp
	 * @param sessionid
	 * @param boardid
	 * @return List contains the standard name.
	 */
	
	public ArrayList loadStandardForGeneration(String sessionid,String boardid)
	{
		log.info("Invoking loadStandardForGeneration(String sessionid,String boardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select distinct a.standardscheduleid,concat(d.standardname,case when a.groupid is null then '' else (select concat(' - ',groupname) from standardgroup where a.groupid=groupid) end) as standardname from standardschedule a,subjectschedule b, questionsheetmaster c,standard d where a.sessionid='"+sessionid+"' and a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A' and b.subjectscheduleid=c.subjectscheduleid and b.status='A' and a.standardid=d.standardid and d.boardid='"+boardid+"' and d.standardstatus='A' and c.questionsheetstatus='A'";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
	 }	
	/**
	 * This method used to get the subject name for question generation.
	 * It is accessed from /jsp/ExamManagement/QuestionGeneration.jsp
	 * @param standardscheduleid
	 * @return List contains Subject Name.
	 */
	
	public ArrayList loadSubjectForGeneration(String standardscheduleid)
	{
		log.info("Invoking loadSubjectForGeneration(String standardscheduleid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct b.subjectscheduleid,concat(a.subjectname,' - ',a.subjectcode) as subjectname from subject a,subjectschedule b, questionsheetmaster c where b.standardscheduleid='"+standardscheduleid+"' and a.subjectid=b.subjectid and a.subjectstatus='A' and b.subjectscheduleid=c.subjectscheduleid and b.status='A' and c.questionsheetstatus='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	
	/**
	 * This method used to get the template name for question generation
	 * It is accessed from /jsp/ExamManagement/QuestionGeneration.jsp
	 * @param subjecscheduletid
	 * @return List contains Template Name.
	 */
	
	public ArrayList loadTemplateForGeneration(String subjecscheduletid)
	{
		log.info("Invoking loadTemplateForGeneration(String subjecscheduletid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select distinct qsid,examname from questionsheetmaster where subjectscheduleid='"+subjecscheduletid+"' and questionsheetstatus='A'";    
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * This method is used to insert Question Sheet and its details through the bean.
	 * It is accessed from /jsp/ExamManagement/PreparationSubmit.jsp
	 * @param beanmaster
	 * @param beandetails
	 * @return
	 * @throws Exception
	 */
	
	
	public int createTemplate(ExamSheetmasterBean beanmaster,ExamSheetDetailsBean beandetails)throws Exception
	{
		
		String templatename		= beanmaster.getExamname();
		String subjectid		= beanmaster.getSubjectscheduleid();
		String templatetype		= beanmaster.getTemplatetype();

		String[] lessonid		= beandetails.getLessonids();
		String[] df				= beandetails.getDfs();
		String[] type			= beandetails.getTypes();
		String[] noqn			= beandetails.getNoqns();
		String[] markperqn		= beandetails.getMarksperqns();
		
		Connection connection 			= null;
		ResultSet master 				= null;
		ResultSet details 				= null;
		Statement masterstmt			= null;
		PreparedStatement masterpstmt	= null;
		PreparedStatement detailpstmt	= null;
		Statement detailsstmt			= null;
		long l 							= 0L;
		long l1							= 0L;
		int  returnvalue				= 0;

		try
		{

			connection 		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);

			String todaydate = DateTime.showTime("MySqlWithTime");
			masterstmt		 = connection.createStatement();
			master 			 = masterstmt.executeQuery("select max(qsid) from questionsheetmaster");

			if(master.next())
				l = master.getLong(1);

			l++;

			String masterquery	= "insert into questionsheetmaster (qsid, examname, createddate, questionsheetstatus, subjectscheduleid, templatetype) values(?,?,?,?,?,?)";
			masterpstmt			= connection.prepareStatement(masterquery);
			masterpstmt.setLong(1,l);
			masterpstmt.setString(2,templatename);
			masterpstmt.setString(3,todaydate);
			masterpstmt.setString(4,"D");
			masterpstmt.setString(5,subjectid);
			masterpstmt.setString(6,templatetype);
			returnvalue			= masterpstmt.executeUpdate();

			detailsstmt			= connection.createStatement();
			details 			= detailsstmt.executeQuery("select max(qsdid) from questionsheetdetail");

			if(details.next())
				l1 	= details.getLong(1);

			l1++;

			String detailsquery = "insert into questionsheetdetail(qsdid, qsid, lessonid, df, type, noqn, marksperqn) values(?,?,?,?,?,?,?)";
			detailpstmt			= connection.prepareStatement(detailsquery);


			if(lessonid != null && lessonid.length>0)
			for(int x=0;x<lessonid.length;x++)
			{
				
				detailpstmt.setLong(1,l1);
				detailpstmt.setLong(2,l);
				detailpstmt.setString(3,lessonid[x]);
				detailpstmt.setString(4,df[x]);
				detailpstmt.setString(5,type[x]);
				detailpstmt.setString(6,noqn[x]);
				detailpstmt.setString(7,markperqn[x]);
				detailpstmt.addBatch();
				l1++;
			}

			int temp[]	= detailpstmt.executeBatch();
			if(temp != null && temp.length>0)
				for(int y=0;y<temp.length;y++)
					returnvalue			+=temp[y];
			
			connection.commit();

		}
		catch(Exception Ex)
		{
			Ex.printStackTrace();
			returnvalue	= 0;
			if(connection != null)
				connection.rollback();
		}
		finally
		{

			if(master != null)
				master.close();
			if(details != null)
				details.close();
			if(masterstmt != null)
				masterstmt.close();
			if(detailsstmt != null)
				detailsstmt.close();
			if(masterpstmt != null)
				masterpstmt.close();
			if(detailpstmt != null)
				detailpstmt.close();

			ConnectionManager.closeConnection(connection);
		}

		return returnvalue;
	}	
	
	
	/**
	 * This method used to generate question 
	 * @param templateid
	 * @param repetation
	 * @param examtypeid
	 * @param instruction
	 * @return List which contains the question generation status.
	 * @throws Exception
	 */
	
	public ArrayList questionGeneration(String templateid,String repetation,String examtypeid,String instruction)throws Exception
	{
		Connection connection 			= null;
		Random random					= null;
		HashMap  hashmap				= null;

		PreparedStatement masterpstmt	= null;
		PreparedStatement questionstmt	= null;
		PreparedStatement deletestmt	= null;
		PreparedStatement updatestmt	= null;
		PreparedStatement detailsstmt	= null;
		PreparedStatement detailsstmtl	= null;
		long questionid					= 0L;
		ArrayList keylist				= null;
		ArrayList questionlist			= null;
		ArrayList result				= new ArrayList();
		int noofquestion				= 0;
		int nextint 					= 0;
		int serialnumber				= 1;
		ResultSet detailsstmtrs			= null;
		ResultSet details 				= null;

		PreparedStatement type			= null;
		ResultSet typers 				= null;
		PreparedStatement schedule		= null;
		ResultSet schedulers			= null;
		String templatetype				= null;
		String subjectscheduleid		= null;
		
		

		

		try
		{

			connection 			= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			random				= new Random();

			
			masterpstmt			= connection.prepareStatement("update questionsheetmaster set instruction=? where qsid=?");
			masterpstmt.setString(1,instruction);
			masterpstmt.setString(2,templateid);
			masterpstmt.executeUpdate();
			
			type				= connection.prepareStatement("select templatetype,subjectscheduleid from questionsheetmaster where qsid=?");
			type.setString(1, templateid);
			typers				= type.executeQuery();
			
			if(typers.next()){
				templatetype		= typers.getString(1);
				subjectscheduleid	= typers.getString(2);
			}
			
			
			
			questionstmt		= connection.prepareStatement("insert into questions(questionid, qsdid, examquestionid, serialnumber) values(?,?,?,?)"); 
			deletestmt			= connection.prepareStatement("delete from questions where qsdid=?");
			updatestmt			= connection.prepareStatement("update examquestion set actualoccurance=? where examquestionid=?");
			detailsstmtl		= connection.prepareStatement("select a.qsdid,c.subjectname,d.lessonname,a.type,a.df,a.noqn, a.marksperqn,c.subjectid, d.lessonid from questionsheetdetail a, questionsheetmaster b,subject c,lesson d, subjectschedule e where b.qsid=? and a.qsid=b.qsid and e.subjectid=c.subjectid and b.subjectscheduleid=e.subjectscheduleid and a.lessonid=d.lessonid and a.lessonid=d.lessonid");
			detailsstmt 		= connection.prepareStatement("select max(questionid) from questions");
			
			details 			= detailsstmt.executeQuery();
			if(details.next())
				questionid 	= details.getLong(1);

			questionid++;
			
			detailsstmtl.setString(1, templateid);
			detailsstmtrs		= detailsstmtl.executeQuery();
			
			/*if(templatetype != null && templatetype.equals("Online Exam")){

				schedule	= connection.prepareStatement("select examscheduleid from examschedule where subjectscheduleid=? and exampublishstatus=? and examtype=?");
				schedule.setString(1, subjectscheduleid);
				schedule.setString(2, "A");
				schedule.setString(3, "online");
				schedulers	= schedule.executeQuery();
				
				if(!schedulers.next()){
					result.add(0,"No Scheduled Online Exam found for this subject.");
					return result;
				}
			}
			else if(templatetype != null && templatetype.equals("Offline Exam")){

				schedule	= connection.prepareStatement("select examscheduleid from examschedule where subjectscheduleid=? and exampublishstatus=? and examtype=?");
				schedule.setString(1, subjectscheduleid);
				schedule.setString(2, "A");
				schedule.setString(3, "offline");
				schedulers	= schedule.executeQuery();
				
				if(!schedulers.next()){
					result.add(0,"No Scheduled Offline Exam found for this subject.");
					return result;
				}
			}*/
			
			while(detailsstmtrs.next()){
				
				
				if(repetation != null && repetation.equals("without"))
					questionlist	= common_data_object.getListMap("select examquestionid,actualoccurance from examquestion where lessonid='"+detailsstmtrs.getString(9)+"' and type='"+detailsstmtrs.getString(4)+"' and examtypeid='"+examtypeid+"' and df='"+detailsstmtrs.getString(5)+"' and mark='"+detailsstmtrs.getString(7)+"' and  actualoccurance=0 and  curdate() between fromdate and todate");
				else
					questionlist	= common_data_object.getListMap("select examquestionid,actualoccurance from examquestion where lessonid='"+detailsstmtrs.getString(9)+"' and type='"+detailsstmtrs.getString(4)+"' and examtypeid='"+examtypeid+"' and df='"+detailsstmtrs.getString(5)+"' and mark='"+detailsstmtrs.getString(7)+"' and  (occurance>actualoccurance or occurance=0) and  curdate() between fromdate and todate");

				
				noofquestion			= detailsstmtrs.getInt(6);
				
				
				if(questionlist != null && noofquestion <= questionlist.size())
				{
					keylist				= new ArrayList();
					for(int yy=0;noofquestion > keylist.size();yy++)
					{
						nextint 		= random.nextInt(questionlist.size());
						if(!keylist.contains(nextint+""))
							keylist.add(nextint+"");
					}

					for(int y=0;y<noofquestion;y++)
					{
						hashmap				= (HashMap)questionlist.get(Integer.parseInt(keylist.get(y)+""));

						questionstmt.setLong(1,questionid);
						questionstmt.setString(2,detailsstmtrs.getString(1));
						questionstmt.setString(3,(String)hashmap.get("examquestionid"));
						questionstmt.setInt(4,serialnumber);
						questionstmt.addBatch();
						
						deletestmt.setString(1,detailsstmtrs.getString(1));
						deletestmt.addBatch();

						serialnumber++;
						questionid++;

						updatestmt.setInt(1,Integer.parseInt((String)hashmap.get("actualoccurance"))+1);
						updatestmt.setString(2,(String)hashmap.get("examquestionid"));
						updatestmt.addBatch();
					}
				}
				else
				{
					if(connection != null)
						connection.rollback();

					result.add(0,"Not Enough");
					result.add(1,detailsstmtrs.getString(2));
					result.add(2,detailsstmtrs.getString(3));
					result.add(3,detailsstmtrs.getString(6));
					result.add(4,questionlist.size()+"");
					result.add(5,detailsstmtrs.getString(4));
					result.add(6,detailsstmtrs.getString(5));

					return result;
				}
				
			}
			
			deletestmt.executeBatch();
			updatestmt.executeBatch();
			questionstmt.executeBatch();
			result.add(0,"Success");
			
			if(connection != null)
				connection.commit();

		}
		catch(Exception Ex){
			
			Ex.printStackTrace();
			result.add(0,"Failed");
			if(connection != null)
				connection.rollback();
		}
		finally
		{

			if(details != null)
				details.close();
			if(detailsstmt != null)
				detailsstmt.close();
			if(masterpstmt != null)
				masterpstmt.close();
			if(questionstmt != null)
				questionstmt.close();
			if(deletestmt != null)
				deletestmt.close();
			if(updatestmt != null)
				updatestmt.close();

			if(detailsstmtrs != null)
				detailsstmtrs.close();
			
			if(detailsstmtl != null)
				detailsstmtl.close();
			
			if(typers != null)
				typers.close();
			
			if(type != null)
				type.close();
			
			if(schedulers != null)
				schedulers.close();
			
			if(schedule != null)
				schedule.close();
			
			
			ConnectionManager.closeConnection(connection);
			
		}

		return result;
	}	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	




/**
 * This method is accessed from  igeducation/jsp/ExamManagement/TemplateStatusList.jsp
 * @param instituteid that can be used to get sessionid,sessionname and sessionstatus 
 * @return ArrayList by which result can be printed on the screec
 */
public ArrayList loadSessionForApprovalwithRk(String instituteid)
{
	log.info("Invoking load session details from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT distinct a.sessionid,a.sessionname,a.sessionstatus FROM yearofsession a where a.instituteid='"+instituteid+"' and (a.sessionstatus='A' or  a.sessionstatus='R') ";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }





/**
 * this method is acessed from igeducation/jsp/ExamManagement/ListTemplates.jsp
 * @param sessionid that can be used to get template names by session wise
 * @param subjectid that can be used to get template names by subjectid wise
 * @return Arraylist by which result can be printed on the screen
 */
public ArrayList TemplateDetails(String sessionid,String subjectid)
{
	log.info("Invoking get Templates from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select qm.qsid,qm.examname,date_format(qm.createddate,'%d-%b-%Y-%r') as newdates, questionsheetstatus,templatetype from questionsheetmaster qm where qm.sessionid='"+sessionid+"' and qm.subjectid='"+subjectid+"' and (qm.questionsheetstatus='A' or qm.questionsheetstatus='X') order by qm.createddate desc;";  
			academicList 	= common_data_object.getListMap(select_query); 
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }
public ArrayList LoadTemplateForOnlineExamDetails(String sessionid,String subjectid,String templatetype)
{
	log.info("Invoking questionSheetDetails(String qsid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try 
		{
			//select_query  	= "select a.qsid,a.examname,date_format(a.createddate,'%d-%b-%Y %r') as createddate,case when a.questionsheetstatus='A' then 'Yes' else 'No' end as templateapprovalstatus,case when c.qsdid is null  then 'No' else 'Yes' end as questiongeneratedstauts,case when d.qsid  is null  then 'No' else 'Yes' end as onlineexamstatus from questionsheetmaster a join yearofsession b on  a.templatetype='"+templatetype+"' and a.sessionid='"+sessionid+"' and a.subjectid='"+subjectid+"' and a.questionsheetstatus<>'X' and a.sessionid=b.sessionid and b.sessionstatus in ('A','R') left outer join questions c on c.qsdid=a.qsid left outer join onlineexam d on d.qsid=a.qsid and onlineexamstatus='A'";   
			select_query  	= "select distinct  case when  d.attempt is null then '0' else d.attempt end as attempt,a.qsid,a.examname,date_format(a.createddate,'%d-%b-%Y %r') as createddate,fee,feetype,c.duration,c.restartingduration from questionsheetmaster a join onlineexam b on a.qsid=b.qsid  and b.onlineexamstatus='A' and a.questionsheetstatus<>'X' and  a.templatetype='"+templatetype+"' and a.sessionid='"+sessionid+"' and a.subjectid='"+subjectid+"' join questionsheetmaster c on  c.qsid=a.qsid	left join onlineanswers d on  d.qsid=a.qsid";
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;  
 }
public ArrayList LoadTemplateOnlineExamDetails(String sessionid,String subjectid,String standardscheduleid)
{
	log.info("Invoking questionSheetDetails(String qsid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try 
		{
			//select_query  	= "select a.qsid,a.examname,date_format(a.createddate,'%d-%b-%Y %r') as createddate,case when a.questionsheetstatus='A' then 'Yes' else 'No' end as templateapprovalstatus,case when c.qsdid is null  then 'No' else 'Yes' end as questiongeneratedstauts,case when d.qsid  is null  then 'No' else 'Yes' end as onlineexamstatus from questionsheetmaster a join yearofsession b on  a.templatetype='"+templatetype+"' and a.sessionid='"+sessionid+"' and a.subjectid='"+subjectid+"' and a.questionsheetstatus<>'X' and a.sessionid=b.sessionid and b.sessionstatus in ('A','R') left outer join questions c on c.qsdid=a.qsid left outer join onlineexam d on d.qsid=a.qsid and onlineexamstatus='A'";
			 
			//select_query  	= "select distinct  case when  d.attempt is null then '0' else d.attempt end as attempt,a.qsid,a.examname,date_format(a.createddate,'%d-%b-%Y %r') as createddate,fee,feetype,c.duration,c.restartingduration from questionsheetmaster a join onlineexam b on a.qsid=b.qsid and a.questionsheetstatus<>'X' and  a.templatetype='"+templatetype+"' and a.sessionid='"+sessionid+"' and a.subjectid='"+subjectid+"' join questionsheetmaster c on  c.qsid=a.qsid	left join onlineanswers d on  d.qsid=a.qsid";
			select_query  	= "select a.qsid,b.onlineexamid,a.examname,date_format(b.assigneddate,'%d-%b-%Y %r') as assigneddate,(SELECT count(qsid) from onlinexamsubscription where  qsid=b.qsid) as subscribedstatus,(select count(a1.onlineexamsubscriptionid) from onlinexamsubscription a1, studentapproval b1 where a1.qsid=a.qsid and a1.subscribedby=b1.studentapprovalid and b1.standardscheduleid='"+standardscheduleid+"') as requestedusers, (select count(distinct a1.studentid) from onlineanswers a1,studentallocation b1, studentapproval c1 where a1.qsid=a.qsid and a1.studentid=b1.studentallocationid and b1.candidateregisterid=c1.registrationid and c1.standardscheduleid='"+standardscheduleid+"') as attendedusers,(select count(distinct a1.studentid) from onlineanswers a1, studentallocation b1,studentapproval c1 where a1.qsid=a.qsid and a1.studentid=b1.studentallocationid and b1.candidateregisterid=c1.registrationid and c1.standardscheduleid='"+standardscheduleid+"' and a1.dateofcreation like date_format(current_timestamp,'%Y-%m-%d %h%')) as ontimeusers	from questionsheetmaster a			join onlineexam b on a.qsid=b.qsid		 and b.onlineexamstatus='A' 	and a.questionsheetstatus='A' and  a.templatetype='Exam'  and a.sessionid='"+sessionid+"' and a.subjectid='"+subjectid+"'";
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }
public ArrayList LoadTemplateDetails(String sessionid,String subjectid,String templatetype)
{
	log.info("Invoking questionSheetDetails(String qsid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try 
		{
			//select_query  	= "select a.qsid,a.examname,date_format(a.createddate,'%d-%b-%Y %r') as createddate,case when a.questionsheetstatus='A' then 'Yes' else 'No' end as templateapprovalstatus,case when c.qsdid is null  then 'No' else 'Yes' end as questiongeneratedstauts,case when d.qsid  is null  then 'No' else 'Yes' end as onlineexamstatus from questionsheetmaster a join yearofsession b on  a.templatetype='"+templatetype+"' and a.sessionid='"+sessionid+"' and a.subjectid='"+subjectid+"' and a.questionsheetstatus<>'X' and a.sessionid=b.sessionid and b.sessionstatus in ('A','R') left outer join questions c on c.qsdid=a.qsid left outer join onlineexam d on d.qsid=a.qsid and onlineexamstatus='A'";   
			select_query  	= "select distinct  a.qsid,a.examname,date_format(a.createddate,'%d-%b-%Y %r') as createddate,case when a.questionsheetstatus='A' then 'Yes' else 'No' end as templateapprovalstatus,case when (select examquestionid from questions ab,questionsheetdetail cd where cd.qsdid=ab.qsdid and  cd.qsid=a.qsid group by cd.qsid) is null  then 'No' else 'Yes' end as questiongeneratedstauts,case when (select qsid from onlineexam where qsid=a.qsid and onlineexamstatus='A' group by qsid) is null  then 'No' else 'Yes' end as onlineexamstatus from questionsheetmaster a where  a.templatetype='"+templatetype+"' and a.sessionid='"+sessionid+"' and a.subjectid='"+subjectid+"' and a.questionsheetstatus<>'X' order by a.createddate desc";
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }


	/**
	 * This method used to  get the exam names based on the sessionid
	 * @param sessionid from yearofsession table
	 * @return ExamNameList
	 */

	public ArrayList loadExamNamePrepare(String sessionid)
	{
		log.info("Invoking loadExamNamePrepare(String sessionid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct examnameid,examname FROM examname where examnamestatus='A' and sessionid='"+sessionid+"'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	

	


public ArrayList loadExamNameForApproval(String sessionid)
{
	log.info("Invoking loadExamNameForApproval(String sessionid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT distinct a.examnameid,a.examname FROM examname a,questionsheetmaster b where a.examnamestatus='A' and b.sessionid='"+sessionid+"' and a.examnameid=b.examid";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }

public ArrayList loadExamNameForGeneration(String sessionid)
{
	log.info("Invoking loadExamNameForGeneration(String sessionid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT distinct a.examnameid,a.examname FROM examname a,questionsheetmaster b where a.examnamestatus='A' and b.sessionid='"+sessionid+"' and b.questionsheetstatus='A' and a.examnameid=b.examid";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }







	
	
	public ArrayList loadStandardForGeneration1(String sessionid,String boardid)
	{
		log.info("Invoking loadStandardForGeneration1(String sessionid,String boardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct d.standardscheduleid, concat(a.standardname,case when d.groupid is null then '' else (select groupname from standardgroup where d.groupid=groupid) end) as standardname FROM standard a, subject b, questionsheetmaster c,standardschedule d where c.sessionid='"+sessionid+"' and  c.subjectid=b.subjectid and a.standardid=b.standardid and c.questionsheetstatus='A' and b.subjectstatus='A' and a.standardstatus='A' and a.boardid='"+boardid+"' and a.standardid=d.standardid and c.sessionid=d.sessionid and d.stdschedulestatus='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	
	
	
	/**
	 * This method used for getting the standard name based on session id and boardid
	 * @param sessionid
	 * @param boardid
	 * @return list of standard names.
	 */
	
	public ArrayList loadStandardForReports(String sessionid ,String boardid)
	{
		log.info("Invoking loadStandardForReports(String sessionid ,String boardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct d.standardscheduleid,concat(a.standardname,case when a.groupstatus='No' then '' else (select concat(' - ',groupname) from standardgroup where d.groupid=groupid)end ) as standardname  FROM standard a,subject b, questionsheetmaster c,standardschedule d where c.sessionid='"+sessionid+"' and  c.subjectid=b.subjectid and a.standardid=b.standardid and c.questionsheetstatus='A' and b.subjectstatus='A' and a.standardstatus='A' and a.boardid='"+boardid+"' and a.standardid=d.standardid and d.sessionid='"+sessionid+"'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }	
	



/**
 * this method is accessed from igeducation/jsp/ExamManagement/TemplateStatusList.jsp
 * @param sessionid that can be used to get subjects
 * @param examid  that can be used to get subjects
 * @param standardid  that can be used to get subjects
 * @return ArrayList by which result can be printed on the screen
 */
public ArrayList loadSubjectForApproval_withoutcode(String sessionid,String examid,String standardid)
{
	log.info("Invoking loadSubjectForApproval(String sessionid,String examid,String standardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT distinct b.subjectid,b.subjectname FROM subject b, questionsheetmaster c where c.sessionid='"+sessionid+"' and c.subjectid=b.subjectid and b.subjectstatus='A' and b.standardid='"+standardid+"'";  
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }

	public ArrayList loadTemplateForGeneration(String sessionid,String examid,String subjectid)
	{
		log.info("Invoking loadTemplateForGeneration(String sessionid,String examid,String standardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct c.qsid,c.examname FROM questionsheetmaster c where c.sessionid='"+sessionid+"' and  c.subjectid='"+subjectid+"' and c.questionsheetstatus='A'";   
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	
	



	public ArrayList loadSubjectForGeneration(String sessionid,String examid,String standardid)
	{
		log.info("Invoking loadSubjectForGeneration(String sessionid,String examid,String standardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct b.subjectid,concat(b.subjectname,'-',b.subjectcode) as subjectname FROM subject b, questionsheetmaster c where c.sessionid='"+sessionid+"'  and c.subjectid=b.subjectid and b.subjectstatus='A' and b.standardid='"+standardid+"' and c.questionsheetstatus='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	
	public ArrayList loadSubjectForGeneration(String sessionid,String standardid)
	{
		log.info("Invoking loadSubjectForGeneration(String sessionid,String standardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct d.subjectscheduleid,concat(b.subjectname,'-',b.subjectcode) as subjectname FROM subject b, questionsheetmaster c,subjectschedule d where c.sessionid='"+sessionid+"' and c.subjectid=b.subjectid and b.subjectstatus='A' and d.standardscheduleid='"+standardid+"' and c.questionsheetstatus='A' and b.subjectid=d.subjectid and d.status='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }
	

	/**
	 * This method is used for getting subject name based on sessionid and standardscheduleid
	 * @param sessionid
	 * @param standardid
	 * @return list of subjectnames.
	 */

	public ArrayList loadSubjectForReports(String sessionid,String standardid)
	{
		log.info("Invoking loadSubjectForReports(String sessionid ,String standardid) from  com.iGrandee.ExamManagement.QuestionPreparation");
			ArrayList academicList = null;
			try
			{
				select_query  	= "SELECT distinct b.subjectid,concat(b.subjectname,'-',b.subjectcode) as subjectname FROM subject b, questionsheetmaster c,subjectschedule d where c.sessionid='"+sessionid+"' and c.subjectid=b.subjectid and b.subjectstatus='A' and d.standardscheduleid='"+standardid+"' and c.questionsheetstatus='A' and b.subjectid=d.subjectid and d.status='A'";  
				academicList 	= common_data_object.getListMap(select_query);
				log.info(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }




public ArrayList loadExam(String instituteid)
{
	log.info("Invoking loadExam(String instituteid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT examnameid,examname FROM examname where instituteid='"+instituteid+"' and (examnamestatus='A' or examnamestatus='R')"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }


public ArrayList loadStandard(String instituteid)
{
	log.info("Invoking loadStandard(String instituteid) from  com.iGrandee.ExamManagement.QuestionPreparation");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT standardid,standardname FROM standard where instituteid='"+instituteid+"' and standardstatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }



























	/*
	*	This Method is Accessed from QuestionSheet_Editable.jsp
	*	from Administrator Login
	**/
	
public ArrayList getFullQuestions(String qsid) {
	ArrayList returnlist = null;
	try {
		/*
		 * String query = "select c.examquestionid, a.subjectid, c.lessonid,
		 * c.type, c.occurance,c.df, date_format(c.fromdate,'%d-%b-%Y') as
		 * fromdate, date_format(c.todate,'%d-%b-%Y') as
		 * todate,c.actualoccurance, c.Question, c.A, c.B, c.C, c.D, c.E,
		 * c.F, c.G, c.CorrectAns, c.Image, c.CountAns, c.Mark,
		 * c.Timelimit,b.qsdid,b.noqn,b.marksperqn,d.serialnumber from
		 * questionsheetmaster a,questionsheetdetail b, examquestion
		 * c,questions d where a.qsid='" + qsid + "' and a.qsid=b.qsid and
		 * d.qsdid=b.qsdid and c.examquestionid=d.examquestionid order by
		 * d.serialnumber asc";
		 */
		String query = "select  c.examquestionid, a.subjectscheduleid, c.lessonid, c.type, c.occurance,c.df, date_format(c.fromdate,'%d-%b-%Y') as fromdate, date_format(c.todate,'%d-%b-%Y') as todate,c.actualoccurance, c.Question, c.A, c.B, c.C, c.D, c.E, c.F, c.G, c.CorrectAns, c.Image, c.CountAns,  c.Mark, c.Timelimit,b.qsdid,b.noqn,b.marksperqn,d.serialnumber from questionsheetmaster a,questionsheetdetail b, examquestion c,questions d where a.qsid='"
				+ qsid
				+ "' and a.qsid=b.qsid and d.qsdid=b.qsdid and c.examquestionid=d.examquestionid order by d.serialnumber asc";
		returnlist = common_data_object.getListMap(query);
		//System.out.println("SQUERY>>>>>>>>" + query);
	} catch (Exception e) {
		log.error(e);
	}
	return returnlist;
}
	/*
	*	This Method is Accessed from PdfRtfWriter.java
	*	from Administrator Login
	**/
	
	public ArrayList getExamDetails(String qsid) {
		ArrayList returnlist = null;
		try {
			// String query = "select
			// examname,instruction,standardname,c.instituteid,sessionname,
			// concat(boardname,' - ',mediumname) as
			// boardname,concat(subjectname,' - ',subjectcode) as subjectname
			// from questionsheetmaster a, subject b,standard c,yearofsession
			// d,board e,standardmedium f where a.qsid='" + qsid + "' and
			// a.subjectid=b.subjectid and b.standardid=c.standardid and
			// a.sessionid=d.sessionid and c.boardid=e.boardid and
			// e.mediumid=f.mediumid";
			String query = "select examname,instruction,standardname,c.instituteid,sessionname, concat(boardname,' - ',mediumname)	as boardname,subjectname,subjectcode		from questionsheetmaster a, subject b,standard c,		yearofsession d,			board e,standardmedium f,			subjectschedule g,standardschedule h			where a.qsid='"
					+ qsid
					+ "' and b.subjectid=g.subjectid and a.subjectscheduleid=g.subjectscheduleid			and b.standardid=c.standardid and h.sessionid=d.sessionid			and h.standardscheduleid=g.standardscheduleid			and c.boardid=e.boardid and e.mediumid=f.mediumid";
			returnlist = common_data_object.getListMap(query);
			//System.out.println("query>>>>>>>>>>>>" + query);
		} catch (Exception e) {
			log.error(e);
		}
		return returnlist;
	}					

	
	/*
	*	This Method is Accessed from PdfRtfWriter.java
	*	from Administrator Login
	**/
	
	public ArrayList getInstituteDetails(String instituteid)
	{
		ArrayList returnlist=null;
		try
		{
			String query	= "select institutename,institutelogo,contactaddress,state,country,emailid,url,mobilenumber, date_format(current_timestamp,'%d-%b-%Y %H:%i') as currenttime from institution a where a.instituteid='"+instituteid+"'";
			returnlist		= common_data_object.getListMap(query);
		}
		catch(Exception e)
		{
			log.error(e);
		}
		return returnlist;
	}	


public ArrayList loadGeneratedQuestions(String qsid)
{
	log.info("Invoking loadGeneratedQuestions(String qsid) from  com.iGrandee.ExamManagement.QuestionPreparation");
	ArrayList academicList = null;
	try
	{
		select_query  	= "select a.examquestionid,question, A, B, C, D, E, F, G, a.correctans, a.image, a.mark, timelimit,a.type from examquestion a,questions b,questionsheetdetail c where c.qsid='"+qsid+"' and c.qsdid=b.qsdid and b.examquestionid=a.examquestionid";  
		academicList 	= common_data_object.getListMap(select_query);
		log.info(select_query);
	}
	catch(Exception exception) { 
		log.error(exception);
	}
	return academicList;
}


public int createTemplate(String templatename, String subjectid,String templatetype,String sessionid,String examid,String[] lessonid,String[] df,String[] type,String[] noqn,String[] markperqn)throws Exception
{
	Connection connection 			= null;
	ResultSet master 				= null;
	ResultSet details 				= null;
	Statement masterstmt			= null;
	PreparedStatement masterpstmt	= null;
	PreparedStatement detailpstmt	= null;
	Statement detailsstmt			= null;
	long l 							= 0L;
	long l1							= 0L;
	int  returnvalue				= 0;

	try
	{

		connection 		= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);

		String todaydate = DateTime.showTime("MySqlWithTime");
		masterstmt		 = connection.createStatement();
		master 			 = masterstmt.executeQuery("select max(qsid) from questionsheetmaster");

		if(master.next())
			l = master.getLong(1);

		l++;

		String masterquery	= "insert into questionsheetmaster (qsid, examname, createddate,  questionsheetstatus, subjectid, templatetype, sessionid) values(?,?,?,?,?,?,?)";
		masterpstmt			= connection.prepareStatement(masterquery);
		masterpstmt.setLong(1,l);
		masterpstmt.setString(2,templatename);
		masterpstmt.setString(3,todaydate);
		masterpstmt.setString(4,"D");
		masterpstmt.setString(5,subjectid);
		masterpstmt.setString(6,templatetype);
		masterpstmt.setString(7,sessionid);
		//masterpstmt.setString(8,examid);
		returnvalue			= masterpstmt.executeUpdate();

		detailsstmt			= connection.createStatement();
		details 			= detailsstmt.executeQuery("select max(qsdid) from questionsheetdetail");

		if(details.next())
			l1 	= details.getLong(1);

		l1++;

		String detailsquery = "insert into questionsheetdetail(qsdid, qsid, lessonid, df, type, noqn, marksperqn) values(?,?,?,?,?,?,?)";
		detailpstmt			= connection.prepareStatement(detailsquery);


		if(lessonid != null && lessonid.length>0)
		for(int x=0;x<lessonid.length;x++)
		{
			
			detailpstmt.setLong(1,l1);
			detailpstmt.setLong(2,l);
			detailpstmt.setString(3,lessonid[x]);
			detailpstmt.setString(4,df[x]);
			detailpstmt.setString(5,type[x]);
			detailpstmt.setString(6,noqn[x]);
			detailpstmt.setString(7,markperqn[x]);
			detailpstmt.addBatch();
			l1++;
		}

		int temp[]	= detailpstmt.executeBatch();
		if(temp != null && temp.length>0)
			for(int y=0;y<temp.length;y++)
				returnvalue			+=temp[y];
		
		connection.commit();

	}
	catch(Exception Ex)
	{
		Ex.printStackTrace();
		returnvalue	= 0;
		if(connection != null)
			connection.rollback();
	}
	finally
	{

		if(master != null)
			master.close();
		if(details != null)
			details.close();
		if(masterstmt != null)
			masterstmt.close();
		if(detailsstmt != null)
			detailsstmt.close();
		if(masterpstmt != null)
			masterpstmt.close();
		if(detailpstmt != null)
			detailpstmt.close();

		ConnectionManager.closeConnection(connection);
	}

	return returnvalue;
}

public int updateTemplate(String templateid, String status)throws Exception
{
	Connection connection 			= null;
	PreparedStatement masterpstmt	= null;
	int  returnvalue				= 0;

	try
	{

		connection 		= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);

		String masterquery	= "update questionsheetmaster set questionsheetstatus=? where qsid=?";
		masterpstmt			= connection.prepareStatement(masterquery);
		masterpstmt.setString(1,status);
		masterpstmt.setString(2,templateid);
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

		if(masterpstmt != null)
			masterpstmt.close();
	
		ConnectionManager.closeConnection(connection);
	}

	return returnvalue;
}

public ArrayList questionGeneration(String templateid,String repetation,String duration,String examtypeid,String instruction,String restartduration,String attempt)throws Exception
{
	Connection connection 			= null;
	Random random					= null;
	HashMap  hashmap				= null;

	PreparedStatement masterpstmt	= null;
	PreparedStatement questionstmt	= null;
	PreparedStatement deletestmt	= null;
	PreparedStatement updatestmt	= null;
	PreparedStatement detailsstmt	= null;
	PreparedStatement detailsstmtl	= null;
	long questionid					= 0L;
	ArrayList keylist				= null;
	ArrayList questionlist			= null;
	ArrayList result				= new ArrayList();
	int noofquestion				= 0;
	int nextint 					= 0;
	int serialnumber				= 1;
	ResultSet detailsstmtrs			= null;
	ResultSet details 				= null;
	

	try
	{

		connection 			= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		random				= new Random();

		
		masterpstmt			= connection.prepareStatement("update questionsheetmaster set duration=?, instruction=?, attempt=?, restartingduration=? where qsid=?");
		masterpstmt.setString(1,duration);
		masterpstmt.setString(2,instruction);
		masterpstmt.setString(3,attempt);
		masterpstmt.setString(4,restartduration);
		masterpstmt.setString(5,templateid);
		masterpstmt.executeUpdate();
		
		questionstmt		= connection.prepareStatement("insert into questions(questionid, qsdid, examquestionid, serialnumber) values(?,?,?,?)"); 
		deletestmt			= connection.prepareStatement("delete from questions where qsdid=?");
		updatestmt			= connection.prepareStatement("update examquestion set actualoccurance=? where examquestionid=?");
		detailsstmtl		= connection.prepareStatement("select a.qsdid,c.subjectname,d.lessonname,a.type,a.df,a.noqn, a.marksperqn,c.subjectid,d.lessonid from questionsheetdetail a, questionsheetmaster b,subject c,lesson d where b.qsid=? and a.qsid=b.qsid and b.subjectid=c.subjectid and a.lessonid=d.lessonid and a.lessonid=d.lessonid");
		detailsstmt 		= connection.prepareStatement("select max(questionid) from questions");
		
		details 			= detailsstmt.executeQuery();
		if(details.next())
			questionid 	= details.getLong(1);

		questionid++;
		
		detailsstmtl.setString(1, templateid);
		detailsstmtrs		= detailsstmtl.executeQuery();
		
		while(detailsstmtrs.next()){
			
			
			if(repetation != null && repetation.equals("without"))
				questionlist	= common_data_object.getListMap("select examquestionid,actualoccurance from examquestion where lessonid='"+detailsstmtrs.getString(9)+"' and type='"+detailsstmtrs.getString(4)+"' and examtypeid='"+examtypeid+"' and df='"+detailsstmtrs.getString(5)+"' and mark='"+detailsstmtrs.getString(7)+"' and  actualoccurance=0 and  curdate() between fromdate and todate");
			else
				questionlist	= common_data_object.getListMap("select examquestionid,actualoccurance from examquestion where lessonid='"+detailsstmtrs.getString(9)+"' and type='"+detailsstmtrs.getString(4)+"' and examtypeid='"+examtypeid+"' and df='"+detailsstmtrs.getString(5)+"' and mark='"+detailsstmtrs.getString(7)+"' and  (occurance>actualoccurance or occurance=0) and  curdate() between fromdate and todate");

			
			noofquestion			= detailsstmtrs.getInt(6);
			
			
			if(questionlist != null && noofquestion <= questionlist.size())
			{
				keylist				= new ArrayList();
				for(int yy=0;noofquestion > keylist.size();yy++)
				{
					nextint 		= random.nextInt(questionlist.size());
					if(!keylist.contains(nextint+""))
						keylist.add(nextint+"");
				}

				for(int y=0;y<noofquestion;y++)
				{
					hashmap				= (HashMap)questionlist.get(Integer.parseInt(keylist.get(y)+""));

					questionstmt.setLong(1,questionid);
					questionstmt.setString(2,detailsstmtrs.getString(1));
					questionstmt.setString(3,(String)hashmap.get("examquestionid"));
					questionstmt.setInt(4,serialnumber);
					questionstmt.addBatch();
					
					deletestmt.setString(1,detailsstmtrs.getString(1));
					deletestmt.addBatch();

					serialnumber++;
					questionid++;

					updatestmt.setInt(1,Integer.parseInt((String)hashmap.get("actualoccurance"))+1);
					updatestmt.setString(2,(String)hashmap.get("examquestionid"));
					updatestmt.addBatch();
				}
			}
			else
			{
				if(connection != null)
					connection.rollback();

				result.add(0,"Not Enough");
				result.add(1,detailsstmtrs.getString(2));
				result.add(2,detailsstmtrs.getString(3));
				result.add(3,detailsstmtrs.getString(6));
				result.add(4,questionlist.size()+"");
				result.add(5,detailsstmtrs.getString(4));
				result.add(6,detailsstmtrs.getString(5));

				return result;
			}
			
		}
		
		deletestmt.executeBatch();
		updatestmt.executeBatch();
		questionstmt.executeBatch();
		result.add(0,"Success");
		
		if(connection != null)
			connection.commit();

	}
	catch(Exception Ex)
	{
		Ex.printStackTrace();
		result.add(0,"Failed");
		if(connection != null)
			connection.rollback();
	}
	finally
	{

		if(details != null)
			details.close();
		if(detailsstmt != null)
			detailsstmt.close();
		if(masterpstmt != null)
			masterpstmt.close();
		if(questionstmt != null)
			questionstmt.close();
		if(deletestmt != null)
			deletestmt.close();
		if(updatestmt != null)
			updatestmt.close();

		if(detailsstmtrs != null)
			detailsstmtrs.close();
		
		if(detailsstmtl != null)
			detailsstmtl.close();
		
		ConnectionManager.closeConnection(connection);
		
	}

	return result;
}





CommonDataAccess common_data_object;
String insert_query;
String select_query; 
int 	return_value;
int[] returnvalue;
Connection connection;
DateTime datetime;
}