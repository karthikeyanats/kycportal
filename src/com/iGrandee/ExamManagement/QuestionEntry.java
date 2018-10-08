package com.iGrandee.ExamManagement;

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
import com.iGrandee.Common.CharacterConvertor;

public class QuestionEntry
{
	static Logger log = Logger.getLogger(QuestionEntry.class);
	public QuestionEntry() {
		
		 
	     common_data_object 	= new CommonDataAccess();
	     insert_query 			= null;
	     select_query 			= null;
	     return_value 			= 0;
	     connection				= null;
	     datetime				= new DateTime();
	 }
	
	
public ArrayList loadBoard(String instituteid)
{
	log.info("Invoking loadBoard(String instituteid) from  com.iGrandee.ExamManagement.QuestionEntry");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select a.boardid,concat(a.boardname,' - ',b.mediumname)as boardname from board a join standardmedium b on a.instituteid='"+instituteid+"' and a.mediumid=b.mediumid and b.mediumstatus='A' and a.boardstatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }


public ArrayList loadStandard(String boardid)
{
	log.info("Invoking loadStandard(String boardid) from  com.iGrandee.ExamManagement.QuestionEntry");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select standardid,standardname from standard where boardid='"+boardid+"' and standardstatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }

public ArrayList loadSubject(String standardid)
{
	log.info("Invoking loadSubject(String standardid) from  com.iGrandee.ExamManagement.QuestionEntry");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select subjectid,concat(subjectname,' - ',subjectcode) as subjectname from subject where standardid='"+standardid+"' and subjectstatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }
	


public ArrayList loadLesson(String subjectid)
{
	log.info("Invoking loadLesson(String subjectid) from  com.iGrandee.ExamManagement.QuestionEntry");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select lessonid,lessonname from lesson where subjectid='"+subjectid+"' and lessonstatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }


public ArrayList loadExamType(String userid)
{
	log.info("Invoking loadExamType(String userid) from  com.iGrandee.ExamManagement.QuestionEntry");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT examtypeid,examtypename FROM examtype  where createdby='"+userid+"' and examtypestatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }


public ArrayList loadQuestion(String questiontype,String difficultyfactor,String examtype,String lesson)
{
	log.info("Invoking loadQuestion(String questiontype,String difficultyfactor,String examtype,String lesson) from  com.iGrandee.ExamManagement.QuestionEntry");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select examquestionid,occurance,date_format(fromdate,'%d-%b-%Y') as fromdate, date_format(todate,'%d-%b-%Y') as todate, question, A, B, C, D, E, F, G, correctans, image, mark, timelimit from examquestion where lessonid='"+lesson+"' and DF='"+difficultyfactor+"' and type='"+questiontype+"' and examtypeid='"+examtype+"' and examquestionstatus='A'"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }


public ArrayList loadQuestion(String questiontype,String difficultyfactor,String examtype,String lesson,int startsat)
{
	log.info("Invoking loadQuestion(String questiontype,String difficultyfactor,String examtype,String lesson,int startsat) from  com.iGrandee.ExamManagement.QuestionEntry");
		ArrayList academicList = null;
		try
		{
			select_query  	= "select examquestionid,occurance,date_format(fromdate,'%d-%b-%Y') as fromdate, date_format(todate,'%d-%b-%Y') as todate, question, A, B, C, D, E, F, G, correctans, image, mark, timelimit from examquestion where lessonid='"+lesson+"' and DF='"+difficultyfactor+"' and type='"+questiontype+"' and examtypeid='"+examtype+"' and examquestionstatus='A' limit "+startsat+",10"; 
			academicList 	= common_data_object.getListMap(select_query);
			log.info(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return academicList;
 }


	public int updateQuestions(QuestionEntryBean bean) throws SQLException{
		
		log.info("Invoking updateQuestions(QuestionEntryBean bean) from  com.iGrandee.ExamManagement.QuestionEntry");
		
		Connection connection 			= null;
		PreparedStatement questionpstmt	= null;
		int returnvalue					= 0;
		int tempArray[]					= null;
		String questionquery 			= "";
		int pos							= 0;
		int questionpos					= 0;
	
		try
		{
			connection 		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String occurences[]			= bean.getOccurences();
			String enddates[]			= bean.getEnddates();
			String questiontype			= bean.getQuestiontype();
			String[] question			= bean.getQuestion();
			String[] answer				= bean.getAnswer();
			String[] correctanswer		= bean.getCorrectanswer();
			String[] totalanswer		= bean.getTotalanswer();
			String[] mark				= bean.getMark();
			String[] time				= bean.getTime();
			String[] files				= bean.getFiles();		
			String[] questionid			= bean.getQuestionid();		
	
			questionquery	= "update examquestion set occurance=?, todate=?, question=?, A=?, B=?, C=?, D=?, E=?, F=?, G=?, correctans=?, image=?, countans=?, mark=?, timelimit=?, examquestionstatus=? where examquestionid=?";
			questionpstmt	= connection.prepareStatement(questionquery);
			
			if(time != null && time.length>0){
				
				for(int a=0;a<time.length;a++){
	
					questionpstmt.setString(1,occurences[a]);
					questionpstmt.setString(2,datetime.getMySQLFormatHifen(enddates[a]).toString());
					
					
					if(questiontype != null && questiontype.equals("Matching")){
						
						String tempquestion = "";
						for(int x=0;x<Integer.parseInt(totalanswer[a]);x++){
							
							tempquestion += question[questionpos]+"\333";
							questionpos ++;
						}
	
						tempquestion = tempquestion.substring(0,tempquestion.length()-1);
						questionpstmt.setString(3,CharacterConvertor.setForXML(tempquestion));
	
					}
					else
						questionpstmt.setString(3,CharacterConvertor.setForXML(question[a]));
					
					
					for(int x=0;x<7;x++){
						
						if(x<Integer.parseInt(totalanswer[a])){
							questionpstmt.setString(x+4,CharacterConvertor.setForXML(answer[pos]));
							pos = pos+1;
						}
						else
							questionpstmt.setString(x+4,null);
					}	
					
					if(questiontype != null && (questiontype.equals("Matching") || questiontype.equals("Objectives")))
						questionpstmt.setString(11,correctanswer[a]);
					else
						questionpstmt.setString(11,answer[a]);
					
					questionpstmt.setString(12,files[a]);
					questionpstmt.setString(13,totalanswer[a]);
					questionpstmt.setString(14,mark[a]);
					questionpstmt.setString(15,time[a]);
					questionpstmt.setString(16,"A");
					questionpstmt.setString(17,questionid[a]);				
					questionpstmt.addBatch();
					
				}
			}
	
			tempArray	= questionpstmt.executeBatch();
			
			if(tempArray != null && tempArray.length>0)
			for(int y=0;y<tempArray.length;y++){
				returnvalue			+=tempArray[y];
			}
	
			connection.commit();
		}
		catch(Exception e)
		{
			log.error(e);
			
			returnvalue = 0;
			if(connection != null)
				connection.rollback();
			
			e.printStackTrace();
	
		}
		finally
		{

			if(questionpstmt != null)
				questionpstmt.close();
			ConnectionManager.closeConnection(connection);
		}
		return returnvalue;
	}
	public int enterQuestions(QuestionEntryBean bean) throws SQLException{
		
		log.info("Invoking enterQuestions(QuestionEntryBean bean) from  com.iGrandee.ExamManagement.QuestionEntry");
		
		Connection connection 			= null;
		PreparedStatement questionpstmt	= null;
		Statement questionmax			= null;
		ResultSet maxresult				= null;
		int returnvalue					= 0;
		int tempArray[]					= null;
		String questionquery 			= "";
		int pos							= 0;
		int questionpos					= 0;
		long l							= 0l;
		String curtime					= null;
	
		try
		{
			connection 		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			curtime			= DateTime.showTime("MySqlWithTime");
			
			String userid				= bean.getUserid();
			String lessonid				= bean.getLessonid();
			String occurence			= bean.getOccurence();
			String examtype				= bean.getExamtype();
			String startdate			= bean.getStartdate();
			String enddate				= bean.getEnddate();
			String difficultyfactor		= bean.getDifficultyfactor();
			String questiontype			= bean.getQuestiontype();
			String[] question			= bean.getQuestion();
			String[] answer				= bean.getAnswer();
			String[] correctanswer		= bean.getCorrectanswer();
			String[] totalanswer		= bean.getTotalanswer();
			String[] mark				= bean.getMark();
			String[] time				= bean.getTime();
			String[] files				= bean.getFiles();		
			
	
			startdate		= datetime.getMySQLFormatHifen(startdate).toString();
			enddate			= datetime.getMySQLFormatHifen(enddate).toString();
	
			questionmax		= connection.createStatement();
			maxresult		= questionmax.executeQuery("select max(examquestionid) from examquestion");
	
			if(maxresult.next())
				l 	= maxresult.getLong(1);
			l++;
	
	
	
			questionquery	= "insert into examquestion(examquestionid, lessonid, type, occurance, DF, fromdate, todate, actualoccurance, question, A, B, C, D, E, F, G, correctans, image, countans, mark, timelimit, examtypeid, dateofcreation, createdby, examquestionstatus)  values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
			questionpstmt	= connection.prepareStatement(questionquery);
			
			if(time != null && time.length>0){
				
				for(int a=0;a<time.length;a++){
	
					questionpstmt.setLong(1,l);
					questionpstmt.setString(2,lessonid);
					questionpstmt.setString(3,questiontype);
					questionpstmt.setString(4,occurence);
					questionpstmt.setString(5,difficultyfactor);
					questionpstmt.setString(6,startdate);
					questionpstmt.setString(7,enddate);
					questionpstmt.setString(8,"0");
					
					
					if(questiontype != null && questiontype.equals("Matching")){
						
						String tempquestion = "";
						for(int x=0;x<Integer.parseInt(totalanswer[a]);x++){
							
							tempquestion += question[questionpos]+"\333";
							questionpos ++;
						}
	
						tempquestion = tempquestion.substring(0,tempquestion.length()-1);
						questionpstmt.setString(9,CharacterConvertor.setForXML(tempquestion));
	
					}
					else
						questionpstmt.setString(9,CharacterConvertor.setForXML(question[a]));
					
					
					for(int x=0;x<7;x++){
						
						if(x<Integer.parseInt(totalanswer[a])){
							questionpstmt.setString(x+10,CharacterConvertor.setForXML(answer[pos]));
							pos = pos+1;
						}
						else
							questionpstmt.setString(x+10,null);
					}	
					
					if(questiontype != null && (questiontype.equals("Matching") || questiontype.equals("Objectives")))
						questionpstmt.setString(17,correctanswer[a]);
					else
						questionpstmt.setString(17,answer[a]);
					
					questionpstmt.setString(18,files[a]);
					questionpstmt.setString(19,totalanswer[a]);
					questionpstmt.setString(20,mark[a]);
					questionpstmt.setString(21,time[a]);
					questionpstmt.setString(22,examtype);
					questionpstmt.setString(23,curtime);
					questionpstmt.setString(24,userid);				
					questionpstmt.setString(25,"A");
					questionpstmt.addBatch();
					
					
					l++;
					
				}
			}
	
			tempArray	= questionpstmt.executeBatch();
			
			if(tempArray != null && tempArray.length>0)
			for(int y=0;y<tempArray.length;y++){
				returnvalue			+=tempArray[y];
			}
	
			connection.commit();
		}
		catch(Exception e)
		{
			log.error(e);
			
			returnvalue = 0;
			if(connection != null)
				connection.rollback();
			
			e.printStackTrace();
	
		}
		finally
		{
			if(maxresult != null)
				maxresult.close();
			if(questionmax != null)
				questionmax.close();
			if(questionpstmt != null)
				questionpstmt.close();
			ConnectionManager.closeConnection(connection);
		}
		return returnvalue;
	}


public int addExamType(String userid,String examtype) throws SQLException{
	
	log.info("Invoking addExamType(String userid,String examtype) from  com.iGrandee.ExamManagement.QuestionEntry");
	
	Connection connection 			= null;
	PreparedStatement questionpstmt	= null;
	PreparedStatement questionmax	= null;
	PreparedStatement check			= null;
	ResultSet checkrs				= null;
	ResultSet maxresult				= null;
	
	int returnvalue					= 0;
	String questionquery 			= "";
	long l							= 0l;
	String curtime					= null;

	try
	{
		connection 		= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		curtime			= DateTime.showTime("MySqlWithTime");
		
		check			= connection.prepareStatement("select examtypeid from examtype where examtypename=? and examtypestatus=? and createdby=?");
		check.setString(1, examtype);
		check.setString(2, "A");
		check.setString(3, userid);
		
		checkrs			= check.executeQuery();
		
		if(!checkrs.next()){
			
			questionmax		= connection.prepareStatement("select max(examtypeid) from examtype");
			maxresult		= questionmax.executeQuery();

			if(maxresult.next())
				l 	= maxresult.getLong(1);
			l++;
			
			questionquery	= "insert into examtype(examtypeid, examtypename, createdby, typecreationdate, examtypestatus)  values(?,?,?,?,?)";
			questionpstmt	= connection.prepareStatement(questionquery);			
			
			questionpstmt.setLong(1,l);
			questionpstmt.setString(2,examtype);
			questionpstmt.setString(3,userid);
			questionpstmt.setString(4,curtime);
			questionpstmt.setString(5,"A");
			returnvalue	=questionpstmt.executeUpdate();
			
		}
		else{
			returnvalue	= 1000;
		}

		connection.commit();
	}
	catch(Exception e)
	{
		log.error(e);
		
		returnvalue = 0;
		if(connection != null)
			connection.rollback();
	}
	finally
	{
		if(checkrs != null)
			checkrs.close();	
		if(check != null)
			check.close();		
		if(maxresult != null)
			maxresult.close();
		if(questionmax != null)
			questionmax.close();
		if(questionpstmt != null)
			questionpstmt.close();
		ConnectionManager.closeConnection(connection);
	}
	return returnvalue;
}

public int updateExamType(String existing,String examtype) throws SQLException{
	
	log.info("Invoking updateExamType(String existing,String examtype) from  com.iGrandee.ExamManagement.QuestionEntry");
	
	Connection connection 			= null;
	PreparedStatement questionpstmt	= null;
	PreparedStatement check			= null;
	ResultSet checkrs				= null;
	int returnvalue					= 0;
	String questionquery 			= "";

	try
	{
		connection 		= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		check			= connection.prepareStatement("select examtypeid from examtype where examtypename=? and examtypeid<>? and examtypestatus=?");
		check.setString(1, examtype);
		check.setString(2, existing);
		check.setString(3, "A");
		
		checkrs			= check.executeQuery();
		
		if(!checkrs.next()){
			
			questionquery	= "update examtype set examtypename=? where examtypeid=?";
			questionpstmt	= connection.prepareStatement(questionquery);			
			
			questionpstmt.setString(1,examtype);
			questionpstmt.setString(2,existing);
			returnvalue	=questionpstmt.executeUpdate();
			
		}
		else{
			returnvalue	= 1000;
		}

		connection.commit();
	}
	catch(Exception e)
	{
		log.error(e);
		
		returnvalue = 0;
		if(connection != null)
			connection.rollback();
	}
	finally
	{
		if(checkrs != null)
			checkrs.close();	
		if(check != null)
			check.close();		
		if(questionpstmt != null)
			questionpstmt.close();
		ConnectionManager.closeConnection(connection);
	}
	return returnvalue;
}


public int deleteExamType(String existing,String examtype) throws SQLException{
	
	log.info("Invoking deleteExamType(String exisitng,String examtype) from  com.iGrandee.ExamManagement.QuestionEntry");
	
	Connection connection 			= null;
	PreparedStatement questionpstmt	= null;
	PreparedStatement check			= null;
	ResultSet checkrs				= null;
	int returnvalue					= 0;
	String questionquery 			= "";

	try
	{
		connection 		= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		check			= connection.prepareStatement("select examquestionid from examquestion where examtypeid=? and examquestionstatus=?");
		check.setString(1, existing);
		check.setString(2, "A");
		checkrs			= check.executeQuery();
		
		if(!checkrs.next()){
			
			questionquery	= "update examtype set examtypestatus=? where examtypeid=?";
			questionpstmt	= connection.prepareStatement(questionquery);			
			
			questionpstmt.setString(1,"D");
			questionpstmt.setString(2,existing);
			returnvalue	=questionpstmt.executeUpdate();
			
		}
		else{
			returnvalue	= 1000;
		}

		connection.commit();
	}
	catch(Exception e)
	{
		log.error(e);
		
		returnvalue = 0;
		if(connection != null)
			connection.rollback();
	}
	finally
	{
		if(checkrs != null)
			checkrs.close();	
		if(check != null)
			check.close();		
		if(questionpstmt != null)
			questionpstmt.close();
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