
package com.iGrandee.MasterEntries.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.MasterEntries.Standard.StandardBean;
import com.iGrandee.MasterEntries.Subject.SubjectBean;
import com.iGrandee.Common.DateTime;
import org.apache.log4j.Logger;
public class SubjectQuery
{
	static Logger log = Logger.getLogger(SubjectQuery.class);

	public  SubjectQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 subjectConnection      = null;
		 rollbackvalue = 0;
		select_query= "";
	}
	

	public ArrayList listTrashedSubject(String standardid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        		select_query = "SELECT a.subjectid,a.subjectname,a.subjectcode,a.credithours,b.subjecttypeid,b.subjectypename FROM `subject` a,subjecttype b where a.standardid='"+standardid+"' and a.subjecttypeid=b.subjecttypeid and a.subjectstatus='T'   order by a.subjecttypeid";
        		log.info(select_query);
	        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	public ArrayList LoadLessonForSubject(String reqsubjectid)
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
	public ArrayList listSubjectType(String instituteid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        		select_query = "SELECT subjecttypeid, subjectypename FROM subjecttype where instituteid='"+instituteid+"' and subjecttypestatus='A'";
	          log.info(select_query);
	        	arraylist = common_data_object.getListMap(select_query);
        	
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public boolean checkDuplicate(String fieldname,String standardid,String fieldvalue,String fieldvalue2)
	{
		boolean return_flag = false;
		String return_string = null;
		try
		{
			String select_query = "SELECT s."+fieldname+" FROM `subject` s where s.standardid='"+standardid+"' and  s.subjectid <> '"+fieldvalue2+"' and s."+fieldname+"='"+fieldvalue+"'" ;
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
	}
	 /**
	  * This method is accessed from kycportal/jsp/masterentries/subject/SubjectInfo.jsp
	  * check duplicate for subject name,code(entry screen)         - prasanth
	   @param  fieldname that can be used to check duplicate names from subject table 
	   *
	   @param standardid that can be used to check duplicate names from subject table 
	   *
	   @param fieldvalue that can be used to check duplicate names from subject table 
	   *
	   @return the boolean by which result can be printed on the screen
	 */
	public boolean checkDuplicateentry(String fieldname,String standardid,String fieldvalue)
	{
		boolean return_flag = false;
		String return_string = null;
		try 
		{ 
			log.info("invoke subject checkDuplicateentry from com.iGrandee.MasterEntries.Subject.SubjectQuery");
			String select_query = "SELECT s."+fieldname+" FROM `subject` s where s.standardid='"+standardid+"' and s."+fieldname+"='"+fieldvalue+"' and subjectstatus <> 'X' " ;
			return_string = common_data_object.getString(select_query);

			if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
				return_flag = false;
			}
			else {
				return_flag = true;
			}

		}
		catch(Exception e)
		{log.error(e);
		}
		return return_flag;
	}
	public ArrayList listSubject(String standardid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT a.subjectid,a.subjectname,a.subjectcode,a.credithours,b.subjecttypeid,b.subjectypename FROM `subject` a,subjecttype b where a.standardid='"+standardid+"' and a.subjecttypeid=b.subjecttypeid and a.subjectstatus='A' order by a.subjecttypeid";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	public ArrayList loadSubjectforsubjectid(String standardid,String subjectid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT a.subjectid,a.subjectname,a.subjectcode,a.credithours,b.subjecttypeid,b.subjectypename FROM `subject` a,subjecttype b where a.standardid='"+standardid+"' and a.subjecttypeid=b.subjecttypeid and a.subjectstatus='A' and a.subjectid='"+subjectid+"'  order by a.subjecttypeid";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	public String CheckSubjectSchedule(String subjectid)
    {
        String str = null;
        try
        {
        	select_query = "SELECT count(*) FROM subjectschedule ss join `subject` s on  s.subjectid='"+subjectid+"' and  s.subjectid=ss.subjectid and ss.status='A' and s.subjectstatus='A';";
        	log.info(select_query);
        	str = common_data_object.getSingleColumn(select_query);
        }catch(Exception e){log.error(e);}
        return str;
    }
	public String CheckLessonSchedule(String lessonid)
    {
        String str = null;
        try
        {
        	select_query = "SELECT count(*) FROM lessonschedule ll join lesson l on ll.lessonid=l.lessonid and l.lessonid='"+lessonid+"' and l.lessonstatus='A' and status='A';";
        	log.info(select_query);
        	str = common_data_object.getSingleColumn(select_query);
        }catch(Exception e){log.error(e);}
        return str;
    }
	//for mark seetings
	public ArrayList listSubjectMark(String standardid)
	  {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT a.subjectid,a.subjectname,a.subjectcode,b.subjectypename,theoryinternalmin, theoryinternalmax, theoryexternalmin, theoryexternalmax, practicalinternalmin, practicalinternalmax, practicalexternalmin, practicalexternalmax, projectinternalmin, projectinternalmax, projectexternalmin, projectexternalmax FROM `subject` a,subjecttype b where a.standardid='"+standardid+"' and a.subjecttypeid=b.subjecttypeid and a.subjectstatus='A' order by a.subjecttypeid";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	

	/* public boolean checkDuplicate(String givenstring,String standardid,String instituteid,String state)
	    {
	        ArrayList arraylist = new ArrayList();
	        ArrayList arraylist1 = new ArrayList();
	        
	        String subjectname_state = "";
	        
	        try
	        {
	        	if(state.equals("duplicatesubjectname"))
	        	{
		        	select_query = "select  * from subject where subjectname='"+givenstring+"' and standardid='"+standardid+"'";
		          log.info(select_query);
		        	arraylist = common_data_object.getListMap(select_query);
		        	log.info("size arraylist"+arraylist.size());
		        	if(arraylist.size() ==0)
		        	{
		        		return false;
		        	}
		        	else
		        	{
		        		return true;
		        	}
	        	}
	        	else if(state.equals("duplicatesubjectcode"))
	        	{
	        		String select_query1 = "select * from subject a,standard b where a.subjectcode='"+givenstring+"' and a.standardid=b.standardid and b.instituteid='"+instituteid+"'";
	        	         log.info(select_query1);
		        	arraylist1 = common_data_object.getListMap(select_query1);
		        	log.info("size arraylist1"+arraylist1.size());
		        	if(arraylist1.size() ==0)
		        	{
		        		return false;
		        	}
		        	else
		        	{
		        		return true;
		        	}
		        	log.info("subjectname_state"+subjectname_state);
	        	}
	        }
	        catch(Exception exception) { log.error(exception);}
	        return subjectname_state;
		}*/
	 
	 public int insertSubject(SubjectBean subjectBean) throws Exception
	 {
		 	log.info("invoking insertStandard for Stanard Insertion");
		 
		 	int result					= 0;
			PreparedStatement subjectprepared = null;
			
			String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 
		 //checkDuplicate(subjectBean.getSubjectname(),subjectBean.getInstituteid());
		 
		 
		 	subjectConnection = ConnectionManager.getKycConnection();
			subjectConnection.setAutoCommit(false);
			String query="select max(subjectid) from subject";
			long subjectid = common_data_object.maxId(query);
			subjectid++;
			query="insert into subject (subjectid, subjectname, description, standardid, subjectcode, credithours, subjecttypeid, createdby, dateofcreation, subjectstatus) values(?,?,?,?,?,?,?,?,?,?)";
			subjectprepared = subjectConnection.prepareStatement(query);
			subjectprepared.setLong(1, subjectid);
			subjectprepared.setString(2,subjectBean.getSubjectname());
			subjectprepared.setString(3,subjectBean.getDescription());
			subjectprepared.setString(4,subjectBean.getStandardid());
			subjectprepared.setString(5,subjectBean.getSubjectcode());
			subjectprepared.setString(6,subjectBean.getCredithours());
			subjectprepared.setString(7,subjectBean.getSubjecttypeid());
			subjectprepared.setString(8,subjectBean.getCreatedby());
			subjectprepared.setString(9, currentdate);
			subjectprepared.setString(10,"A");
			result += subjectprepared.executeUpdate();
			
			
			
			
			subjectConnection.commit();

		 
	 }catch(SQLException e){
		 
		 //System.out.println("THe problem is here...");
			log.error(e);
			result	= 0;
			if(subjectConnection != null)
				subjectConnection.rollback();
	 }
	 finally
		{
		 if(subjectprepared != null)
			subjectprepared.close();
		 if(subjectConnection != null)
		 subjectConnection.close();
		 }
	 return result;
	 }
	 
	//update updateSubjectMark
		public int updateSubjectMark(SubjectBean subjectBean) throws Exception
		 {
			 	log.info("invoking updateSubjectMark for Stanard Subject Mark");
			 
			 	int result	= 0;
				PreparedStatement updatesubjectprepared = null;
		 try
		 {
			 	subjectConnection = ConnectionManager.getKycConnection();
				subjectConnection.setAutoCommit(false);
				
			
				select_query="update subject set theoryinternalmin=?, theoryinternalmax=?, theoryexternalmin=?, theoryexternalmax=?, practicalinternalmin=?, practicalinternalmax=?, practicalexternalmin=?, practicalexternalmax=?, projectinternalmin=?, projectinternalmax=?, projectexternalmin=?, projectexternalmax=?  where subjectid=?";
				updatesubjectprepared = subjectConnection.prepareStatement(select_query);
				updatesubjectprepared.setString(1,subjectBean.getTheoryinternalmin());
				updatesubjectprepared.setString(2,subjectBean.getTheoryinternalmax());
				updatesubjectprepared.setString(3,subjectBean.getTheoryexternalmin());
				updatesubjectprepared.setString(4,subjectBean.getTheoryexternalmax());
				updatesubjectprepared.setString(5,subjectBean.getProjectinternalmin());
				updatesubjectprepared.setString(6,subjectBean.getProjectinternalmax());
				updatesubjectprepared.setString(7,subjectBean.getProjectexternalmin());
				updatesubjectprepared.setString(8,subjectBean.getProjectexternalmax());
				updatesubjectprepared.setString(9,subjectBean.getPracticalinternalmin());
				updatesubjectprepared.setString(10,subjectBean.getPracticalinternalmax());
				updatesubjectprepared.setString(11,subjectBean.getPracticalexternalmin());
				updatesubjectprepared.setString(12,subjectBean.getPracticalexternalmax());
				updatesubjectprepared.setString(13,subjectBean.getSubjectid());
				result += updatesubjectprepared.executeUpdate();
				subjectConnection.commit();				
			
		 }catch(SQLException e){
			 
				log.error(e);
				result	= 0;
				if(subjectConnection != null)
					subjectConnection.rollback();
		 }
		 finally
			{
		 
			 if(updatesubjectprepared != null)
				updatesubjectprepared.close();
			
			 if(subjectConnection != null)
			 subjectConnection.close();
			 }
		 return result;
		 }
		public int updateSubjectDetail(SubjectBean subjectBean,String Editstatus) throws Exception
		 {
			 	log.info("invoking updateSubjectDetail for Standard Subject Update");
			 
			 	int result	= 0;
				PreparedStatement updatesubjectprepared = null;
				try
				{
			 	subjectConnection = ConnectionManager.getKycConnection();
				subjectConnection.setAutoCommit(false);
				if(Editstatus.equals("E"))
				{
				select_query="update subject set subjectname=?, subjectcode=?, credithours=?, subjecttypeid=?, createdby=?, dateofcreation=?  where subjectid=?";
				updatesubjectprepared = subjectConnection.prepareStatement(select_query);
				updatesubjectprepared.setString(1,subjectBean.getSubjectname());
				updatesubjectprepared.setString(2,subjectBean.getSubjectcode());
				updatesubjectprepared.setString(3,subjectBean.getCredithours());
				updatesubjectprepared.setString(4,subjectBean.getSubjecttypeid());
				updatesubjectprepared.setString(5,subjectBean.getCreatedby());
				updatesubjectprepared.setString(6,DateTime.showTime("MySqlWithTime"));
				updatesubjectprepared.setString(7,subjectBean.getSubjectid());
				}
				else if(Editstatus.equals("T") || Editstatus.equals("A") || Editstatus.equals("X"))
				{
					select_query="update subject set  subjectstatus=?  where subjectid=?";
					updatesubjectprepared = subjectConnection.prepareStatement(select_query);
					updatesubjectprepared.setString(1,Editstatus);
					updatesubjectprepared.setString(2,subjectBean.getSubjectid());
				}
				//System.out.println("select_query"+updatesubjectprepared);
				result += updatesubjectprepared.executeUpdate();
				subjectConnection.commit();
		 		}
				catch(Exception e){
				log.error(e);
				result	= 0;
				if(subjectConnection != null)
					subjectConnection.rollback();
		 		}
		 finally
			{
		 
			 if(updatesubjectprepared != null)
				updatesubjectprepared.close();
			
			 if(subjectConnection != null)
			 subjectConnection.close();
			 }
		 return result;
		 }
		
	 
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection subjectConnection;
	 int rollbackvalue;
}
