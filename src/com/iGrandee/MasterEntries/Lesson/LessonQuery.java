package com.iGrandee.MasterEntries.Lesson;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.MasterEntries.Lesson.LessonBean;
import org.apache.log4j.Logger;

public class LessonQuery
{
	static Logger log = Logger.getLogger(LessonQuery.class);
	public LessonQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 lessonConnection      = null;
		 rollbackvalue = 0;
		select_query= "";
	}
	
	
	public int insertLesson(LessonBean lessonBean) throws Exception
	 {
		 	log.info("invoking insertLesson for Stanard Lesson Insertion");
		 
		 	int result							= 0;
			PreparedStatement lessonprepared 	= null;
			PreparedStatement checkprepared 	= null;
			ResultSet checkrs 					= null;
			
			String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	lessonConnection = ConnectionManager.getKycConnection();
			lessonConnection.setAutoCommit(false);
			
			
			checkprepared		= lessonConnection.prepareStatement("select lessonid from lesson where lessonname=? and lessonstatus<>? and subjectid=?");
			checkprepared.setString(1, lessonBean.getLessonname());
			checkprepared.setString(2, "X");
			checkprepared.setString(3,lessonBean.getSubjectid());
			
			checkrs				= checkprepared.executeQuery();
			
			if(!checkrs.next()){
				
				String query="select max(lessonid) from lesson";
				long lessonid = common_data_object.maxId(query);
				lessonid++;
	
				query="insert into lesson (lessonid, lessonname, lessondescription, subjectid, createdby, lessoncreationdate, lessonstatus) values(?,?,?,?,?,?,?)";
				lessonprepared = lessonConnection.prepareStatement(query);
				lessonprepared.setLong(1, lessonid);
				lessonprepared.setString(2,lessonBean.getLessonname());
				lessonprepared.setString(3,lessonBean.getDescription());
				lessonprepared.setString(4,lessonBean.getSubjectid());
				lessonprepared.setString(5,lessonBean.getCreatedby());
				lessonprepared.setString(6, currentdate);
				lessonprepared.setString(7,"A");
				result += lessonprepared.executeUpdate();
			}
			else
				result		= 1000;
			

			
			
			lessonConnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(lessonConnection != null)
				lessonConnection.rollback();
	 }
	 finally
		{
	 
		 	if(lessonprepared != null)
		 		lessonprepared.close();

			if(checkrs != null)
				checkrs.close();
		
			if(checkprepared != null)
				checkprepared.close();
		 
			if(lessonConnection != null)
				lessonConnection.close();
		 }
	 return result;
	 }
	
	
	public int updateLesson(LessonBean lessonBean) throws Exception
	 {
		 	log.info("invoking updateLesson for Stanard Lesson Updation");
		 
		 	int result	= 0;
			PreparedStatement lessonprepared 	= null;
			PreparedStatement checkprepared 	= null;
			ResultSet checkrs 					= null;
			
			String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	lessonConnection = ConnectionManager.getKycConnection();
			lessonConnection.setAutoCommit(false);
			String query="";
			
			checkprepared		= lessonConnection.prepareStatement("select lessonid from lesson where lessonname=? and lessonstatus<>? and subjectid=? and lessonid<>?");
			checkprepared.setString(1, lessonBean.getLessonname());
			checkprepared.setString(2, "X");
			checkprepared.setString(3,lessonBean.getSubjectid());
			checkprepared.setString(4,lessonBean.getLessonid());
			checkrs				= checkprepared.executeQuery();
			
			if(!checkrs.next()){
			

				query="update lesson set lessonname=?,lessoncreationdate=?,lessondescription=? where lessonid=?";
				lessonprepared = lessonConnection.prepareStatement(query);
				lessonprepared.setString(1,lessonBean.getLessonname());
				lessonprepared.setString(2, currentdate);
				lessonprepared.setString(3,lessonBean.getDescription());
				lessonprepared.setString(4, lessonBean.getLessonid());
				
				result += lessonprepared.executeUpdate();
			}
			else
				result	= 1000;
			
			lessonConnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(lessonConnection != null)
				lessonConnection.rollback();
	 }
	 finally
		{
	 
		 if(lessonprepared != null)
			lessonprepared.close();

			if(checkrs != null)
				checkrs.close();
		
			if(checkprepared != null)
				checkprepared.close();

		 
		 if(lessonConnection != null)
		 lessonConnection.close();
		 }
	 return result;
	 }
	
	public int updateLessonStatus(LessonBean lessonBean) throws Exception
	 {
		 	log.info("invoking updateLesson for Stanard Lesson Updation");
		 
		 	int result	= 0;
			PreparedStatement lessonprepared = null;
			//String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	lessonConnection = ConnectionManager.getKycConnection();
			lessonConnection.setAutoCommit(false);
			String query="update lesson set lessonstatus=? where lessonid=?";
			lessonprepared = lessonConnection.prepareStatement(query);
			lessonprepared.setString(1,lessonBean.getLessonstatus());
			lessonprepared.setString(2,lessonBean.getLessonid());
			//System.out.println("====>>>>>>"+lessonprepared);
			result += lessonprepared.executeUpdate();
			lessonConnection.commit();

	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(lessonConnection != null)
				lessonConnection.rollback();
	 }
	 finally
		{
	 
		 if(lessonprepared != null)
			lessonprepared.close();
		
		 if(lessonConnection != null)
		 lessonConnection.close();
		 }
	 return result;
	 }
	
	
	//subjectid, subjectname, subjecttypeid, subjectypename
	public ArrayList listLesson(String reqsubjectid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select lessonid,lessonname,lessondescription from lesson where lessonstatus='A' and subjectid='"+reqsubjectid+"'";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	public ArrayList LessonTrashList(String reqsubjectid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select lessonid,lessonname,lessondescription from lesson where lessonstatus='T' and subjectid='"+reqsubjectid+"'";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	public boolean checkDuplicate(String lessonname,String subjectid,String lessonid)
	{
		boolean return_flag = false;
		String return_string = null;
		try
		{
			String select_query = "SELECT l.lessonname FROM lesson l where l.lessonname='"+lessonname+"' and l.subjectid='"+subjectid+"' and l.lessonid <> '"+lessonid+"' and lessonstatus='A'" ;
			//System.out.println("=====>>>>>"+select_query);
			return_string = common_data_object.getString(select_query);
			if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
				return_flag = false;
			}
			else {
				return_flag = true;
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return return_flag;
	} /**
	  * This method is accessed from kycportal/jsp/masterentries/lesson/checkDuplicate.jsp
	  * check duplicate lesson name(entry screen)         - prasanth
	    @param  lessonname  that can be used to check duplicate names from lesson table by lessonname,subjectid wise
	    *
	    @param  subjectid  that can be used to check duplicate names from lesson table by lessonname,subjectid wise
	 	*
	    @return the boolean by which result can be printed on the screen
	 */
	public boolean checkDuplicateentry(String lessonname,String subjectid)
	{
		boolean return_flag = false;
		String return_string = null;
		try
		{ log.info("invoke lesson checkDuplicateentry com.iGrandee.MasterEntries.Lesson.LessonQuery");
			String select_query = "SELECT l.lessonname FROM lesson l where l.lessonname='"+lessonname+"' and l.subjectid='"+subjectid+"'  and lessonstatus='A'" ;
			return_string = common_data_object.getString(select_query);
			if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
				return_flag = false;
			}
			else {
				return_flag = true;
			}

		}
		catch(Exception e)
		{
			log.error(e);	
			}
		return return_flag;
	}
	public ArrayList loadLessonForLessonid(String reqsubjectid,String reqLessionid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select lessonid,lessonname,lessondescription from lesson where subjectid='"+reqsubjectid+"' and  lessonstatus ='A' and lessonid='"+reqLessionid+"'";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection lessonConnection;
	 int rollbackvalue;
   
}
