package com.iGrandee.GradeSetting;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.GradeSetting.GradeScaleBean;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Exam.ExamnameBean;
public class GradeScaleQuery
{
	static Logger log = Logger.getLogger(GradeScaleQuery.class);

	public GradeScaleQuery()
    {
		date_object = new DateTime();
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        select_query = null;
        insert_query 		= null;
    }
	/**
	 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/GradeSubmit.jsp
	 * @param gradeid that can be used to insert in grade table
	 * @param gradename that can be used to insert in grade table
	 * @param dateofcreation that can be used to insert in grade table
	 * @param createdby that can be used to insert in grade table
	 * @param gradestatus that can be used to insert in grade table
	 * @return ArrayList by which result can be printed on the screen
	 * @throws SQLException
	 */
	public ArrayList insertGrade(GradeBean beanobj)throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		PreparedStatement duplicatechkprepared 		= null;
		int len=beanobj.getGradename_Array().length;
		String[] gradename=beanobj.getGradename_Array();
		String duplicatenames="";
		ResultSet dupResult							= null;
		String message="";
		ArrayList resultList = new ArrayList();

        try
    	{
        	
        log.info("invoking insert Grade Name  from com.iGrandee.GradeSetting.GradeScaleQuery");
        connection = ConnectionManager.getKycConnection();
        String dupCheck			= "select a.gradename from grade a,login b,personmaster c,institution d where  a.gradename=?  and a.createdby=b.userid and b.loginstatus=? and b.personid=c.personid and c.status=? and c.instituteid=? and c.instituteid=d.instituteid and d.status=? and a.gradestatus <> ? ";
		duplicatechkprepared	= connection.prepareStatement(dupCheck);
        if(gradename !=null && gradename.length>0)
        {
	        for(int i = 0; i < len; i++)
			{
	        		if(!gradename[i].equals(""))
	        		{
						
				        duplicatechkprepared.setString(1, gradename[i].toLowerCase());
				        duplicatechkprepared.setString(2, "A");
				        duplicatechkprepared.setString(3, "A");
				        duplicatechkprepared.setString(4, beanobj.getInstituteid());
				        duplicatechkprepared.setString(5, "A");
				        duplicatechkprepared.setString(6, "X");
				        dupResult	= duplicatechkprepared.executeQuery();
				        if(!dupResult.next())
					    {
						long l = common_data_object.fmaxId("select max(gradeid)from grade");
						String query="insert into grade (gradeid,gradename,dateofcreation,createdby,gradestatus) values(?,?,?,?,?)";
						settingsprepared = connection.prepareStatement(query);
				
						settingsprepared.setLong(1, l);
						settingsprepared.setString(2,gradename[i].trim());
						settingsprepared.setString(3, DateTime.showTime("MySqlWithTime"));
						settingsprepared.setString(4, beanobj.getCreatedby());
						settingsprepared.setString(5, "A");
				
						result += settingsprepared.executeUpdate();
					    }
						else
						{
							duplicatenames	+= "<a align='left'><br> "+gradename[i]+" ";
						}
	        	}
			
        }
			
       }
        if(result >0)
			message = "Successfully Grade Name(s)  Inserted.";
		else
			message = "Grade Name(s) Insertion Failed.";
			
		if(duplicatenames != null && duplicatenames.length()>2)
			message	+= " The Following Grade Name(s) are already Exists. "+duplicatenames.substring(0,duplicatenames.length()-1);
		
		resultList.add(result+"");
		resultList.add(message);	
			
    }
     catch(Exception exception) { 
				log.error("",exception);
		}
			finally
			{
				if(settingsprepared != null)
					settingsprepared.close();
				
				if(connection != null)
					connection.close();
			}
    return resultList;
}
	/**
	 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/GradeView.jsp
	 * @param instituteid that can used to get all grades by institution wise from grade table
	 * @param gradestatus that can used to get all grades by status wise from grade table
	 * @return ArrayList by which result can be printed on the screen
	 */
	public ArrayList getGradeList(String instituteid,String gradestatus)
	    {
			ArrayList list=null;
		
			
			try
			{
		        log.info("invoking get getGradeList(instituteid,gradestatus) from com.iGrandee.GradeSetting.GradeScaleQuery");

				select_query="select a.gradeid,a.gradename,date_format(a.dateofcreation,'%d-%b-%Y') as newdates from grade a,login b,personmaster c,institution d where a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A'  and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' and a.gradestatus ='"+gradestatus+"' order by a.dateofcreation desc";
				list=common_data_object.getListMap(select_query);
				
				
					
			}
			catch(Exception exception) 
			{ 
					
				log.error("",exception);				
				}
		    	
		    	return list;
		    }
	/**
	 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/GradeUpdate.jsp
	 * @param gradeid that can used to get particular grades by gradeid wise from grade table
	 * @param gradestatus that can used to get particular grades by status wise from grade table
	 * @return ArrayList by which result can be printed on the screen
	 */
	 public ArrayList getgradeforUpdate(String gradeid,String gradestatus)
	    {
			ArrayList list=null;
		
			
			try
			{
		        log.info("invoking get getgradeforUpdate(gradeid,gradestatus) from com.iGrandee.GradeSetting.GradeScaleQuery");
				select_query="select a.gradeid,a.gradename,date_format(a.dateofcreation,'%d-%b-%Y') as newdates from grade a where a.gradeid='"+gradeid+"' and a.gradestatus='"+gradestatus+"'";
				list=common_data_object.getListMap(select_query);
					
			}
			catch(Exception exception)
			{ 
					
				log.error("",exception);				
				}
		    	
		    	return list;
	 }
	 /**
	  * This method is accessed from kycportal/WebContent/jsp/GradeSetting/GradeStatusUpdate.jsp
      * @param gradeid that can be used to update in grade table
	  * @param gradename that can be used to update in grade table
	  * @param dateofcreation that can be used to update in grade table
	  * @param createdby that can be used to update in grade table
	  * @param gradestatus that can be used to update in grade table	
	  * @return int by which result can be printed on the screen
	  * @throws SQLException
	  */
	 public int UpdateGrade(GradeBean beanobj) throws SQLException
	    {
	    	PreparedStatement settingsprepared  = null;
	    	PreparedStatement duplicatechkprepared 		= null;
			ResultSet dupResult							= null;
			String extracurriduplicate					= "";
	    	int rs=0;
	    	try
	    	{
	    		connection = ConnectionManager.getKycConnection();

		        log.info("invoking update UpdateGrade(GradeBean) from com.iGrandee.GradeSetting.GradeScaleQuery");

		        String dupCheck			= "select gradeid from grade where gradename=? and gradestatus <> ? and gradeid<>?";
		        duplicatechkprepared	= connection.prepareStatement(dupCheck);
		        duplicatechkprepared.setString(1, beanobj.getGradename().toLowerCase());
		        duplicatechkprepared.setString(2, "X");
		        duplicatechkprepared.setString(3, beanobj.getGradeid());
		        dupResult	= duplicatechkprepared.executeQuery();
			    
			    if(!dupResult.next())
			    {
		        
	            
	        	String query="update grade set gradename=?,dateofcreation=?,createdby=? where gradeid=?";
				settingsprepared = connection.prepareStatement(query);

				settingsprepared.setString(1, beanobj.getGradename().trim());
				settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
				settingsprepared.setString(3, beanobj.getCreatedby());
				settingsprepared.setString(4, beanobj.getGradeid());
				rs = settingsprepared.executeUpdate();
			    }
			    else
			    {
			    	rs	= 1000;
			    }
				
	    	}
	    		
				catch(Exception exception)
				{ 
						
					log.error("",exception);	
					}
			    	finally
					{
						if(settingsprepared != null)
							settingsprepared.close();
						
						if(connection!=null)
							connection.close();
					}
			    	return rs;
			    }
	 /**
	  * 
	  * This method is accessed from kycportal/WebContent/jsp/GradeSetting/GradeStatusUpdate.jsp
      * @param gradeid that can be used to update in grade table
	  * @param dateofcreation that can be used to update in grade table
	  * @param createdby that can be used to update in grade table
	  * @param gradestatus that can be used to update in grade table	
	  * @return int by which result can be printed on the screen
	  * @throws SQLException
	  */
	 public int UpdateGradeStatus(GradeBean beanobj) throws SQLException
	    {
	    	PreparedStatement settingsprepared  = null;

			
	    	int rs=0;
	    	try
	    	{
	    		connection = ConnectionManager.getKycConnection();

		        log.info("invoking update UpdateGradeStatus from com.iGrandee.GradeSetting.GradeScaleQuery");

	            
	        	String query="update grade set dateofcreation=?,createdby=?,gradestatus=? where gradeid=?";
				settingsprepared = connection.prepareStatement(query);

				settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
				settingsprepared.setString(2, beanobj.getCreatedby());
				settingsprepared.setString(3, beanobj.getGradestatus());
				settingsprepared.setString(4, beanobj.getGradeid());
				rs = settingsprepared.executeUpdate();
				
				
	    	}
	    		
				catch(Exception exception)
				{ 
						
					log.error("",exception);					
					}
			    	finally
					{
						if(settingsprepared != null)
							settingsprepared.close();
						
						if(connection!=null)
							connection.close();
					}
			    	return rs;
			    }
/**
 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/GradeTrashPreview.jsp
 * @param gradeid that can be used to check whether it is allocated or not 
 * @return String by which result can be printed on the screen
 */
	 public String checkTrashGrade(String gradeid)
	    {
		 String list="";
		
			
			try
			{
		        log.info("invoking get checkTrashGrade from com.iGrandee.GradeSetting.GradeScaleQuery");
				select_query="select b.gradescaleid from gradescale b,grade a where a.gradeid=b.gradeid and a.gradestatus='A' and b.gradescalestatus='A' and a.gradeid='"+gradeid+"';";
				list=common_data_object.getString(select_query);
					
			}
			catch(Exception exception)
			{ 
					
				log.error("",exception);				
				}
		    	
		    	return list;
	 }
	 
	 /**
		 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/ScaleSubmit.jsp
		 * @param scaleid that can be used to insert in scale table
		 * @param scalename that can be used to insert in scale table
		 * @param dateofcreation that can be used to insert in scale table
		 * @param createdby that can be used to insert in scale table
		 * @param scalestatus that can be used to insert in scale table
		 * @return ArrayList by which result can be printed on the screen
		 * @throws SQLException
		 */
	 public ArrayList insertScale(ScaleBean beanobj)throws SQLException
	    {
			int result=0;

	    	PreparedStatement settingsprepared  = null;
			PreparedStatement instituteprepared = null;
			PreparedStatement duplicatechkprepared 		= null;
			int len=beanobj.getScalename_Array().length;
			String[] scalename=beanobj.getScalename_Array();
			String duplicatenames="";
			ResultSet dupResult							= null;
			String message="";
			ArrayList resultList = new ArrayList();

	        try
	    	{
	        	
	        log.info("invoking insert Grade Name  from com.iGrandee.GradeSetting.GradeScaleQuery");
	        connection = ConnectionManager.getKycConnection();
	        String dupCheck			= "select a.scalename from scale a,login b,personmaster c,institution d where  a.scalename=?  and a.createdby=b.userid and b.loginstatus=? and b.personid=c.personid and c.status=? and c.instituteid=? and c.instituteid=d.instituteid and d.status=? and a.scalestatus <> ? ";
			duplicatechkprepared	= connection.prepareStatement(dupCheck);
	        if(scalename !=null && scalename.length>0)
	        {
		        for(int i = 0; i < len; i++)
				{
		        		if(!scalename[i].equals(""))
		        		{
							
					        duplicatechkprepared.setString(1, scalename[i].toLowerCase());
					        duplicatechkprepared.setString(2, "A");
					        duplicatechkprepared.setString(3, "A");
					        duplicatechkprepared.setString(4, beanobj.getInstituteid());
					        duplicatechkprepared.setString(5, "A");
					        duplicatechkprepared.setString(6, "X");
					        dupResult	= duplicatechkprepared.executeQuery();
					        if(!dupResult.next())
						    {
							long l = common_data_object.fmaxId("select max(scaleid)from scale");
							String query="insert into scale (scaleid,scalename,dateofcreation,createdby,scalestatus) values(?,?,?,?,?)";
							settingsprepared = connection.prepareStatement(query);
					
							settingsprepared.setLong(1, l);
							settingsprepared.setString(2,scalename[i].trim());
							settingsprepared.setString(3, DateTime.showTime("MySqlWithTime"));
							settingsprepared.setString(4, beanobj.getCreatedby());
							settingsprepared.setString(5, "A");
					
							result += settingsprepared.executeUpdate();
						    }
							else
							{
								duplicatenames	+= "<a align='left'><br> "+scalename[i]+" ";
							}
		        	}
				
	        }
				
	       }
	        if(result >0)
				message = "Successfully Scale Name(s)  Inserted.";
			else
				message = "Scale Name(s) Insertion Failed.";
				
			if(duplicatenames != null && duplicatenames.length()>2)
				message	+= " The Following Scale Name(s) are already Exists. "+duplicatenames.substring(0,duplicatenames.length()-1);
			
			resultList.add(result+"");
			resultList.add(message);	
				
	    }
	     catch(Exception exception) { 
					log.error("",exception);
			}
				finally
				{
					if(settingsprepared != null)
						settingsprepared.close();
					
					if(connection != null)
						connection.close();
				}
	    return resultList;
	}
	 /**
		 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/ScaleView.jsp
		 * @param instituteid that can used to get all grades by institution wise from scale table
		 * @param scalestatus that can used to get all grades by status wise from scale table
		 * @return ArrayList by which result can be printed on the screen
		 */
		public ArrayList getScaleList(String instituteid,String scalestatus)
		    {
				ArrayList list=null;
			
				
				try
				{
			        log.info("invoking get getScaleList from com.iGrandee.GradeSetting.GradeScaleQuery");

					select_query="select a.scaleid,a.scalename,date_format(a.dateofcreation,'%d-%b-%Y') as newdates from scale a,login b,personmaster c,institution d where a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A'  and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' and a.scalestatus ='"+scalestatus+"' order by a.dateofcreation desc";
					list=common_data_object.getListMap(select_query);
					
					
						
				}
				catch(Exception exception) 
				{ 
						
					log.error("",exception);				
					}
			    	
			    	return list;
			    }
		/**
		 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/ScaleUpdate.jsp
		 * @param scaleid that can used to get particular grades by scaleid wise from scale table
		 * @param scalestatus that can used to get particular grades by status wise from scale table
		 * @return ArrayList by which result can be printed on the screen
		 */
		 public ArrayList getscaleforUpdate(String scaleid,String scalestatus)
		    {
				ArrayList list=null;
			
				
				try
				{
			        log.info("invoking get getscaleforUpdate from com.iGrandee.GradeSetting.GradeScaleQuery");
					select_query="select a.scaleid,a.scalename,date_format(a.dateofcreation,'%d-%b-%Y') as newdates from scale a where a.scaleid='"+scaleid+"' and a.scalestatus='"+scalestatus+"'";
					list=common_data_object.getListMap(select_query);
						
				}
				catch(Exception exception)
				{ 
						
					log.error("",exception);				
					}
			    	
			    	return list;
		 }
		 /**
		  * This method is accessed from kycportal/WebContent/jsp/GradeSetting/ScaleStatusUpdate.jsp
	      * @param scaleid that can be used to update in scale table
		  * @param scalename that can be used to update in scale table
		  * @param dateofcreation that can be used to update in scale table
		  * @param createdby that can be used to update in scale table
		  * @param scalestatus that can be used to update in scale table	
		  * @return int by which result can be printed on the screen
		  * @throws SQLException
		  */
		 public int UpdateScale(ScaleBean beanobj) throws SQLException
		    {
		    	PreparedStatement settingsprepared  = null;
		    	PreparedStatement duplicatechkprepared 		= null;
				ResultSet dupResult							= null;
				String extracurriduplicate					= "";
		    	int rs=0;
		    	try
		    	{
		    		connection = ConnectionManager.getKycConnection();

			        log.info("invoking update UpdateScale from com.iGrandee.GradeSetting.GradeScaleQuery");

			        String dupCheck			= "select scaleid from scale where scalename=? and scalestatus <> ? and scaleid<>?";
			        duplicatechkprepared	= connection.prepareStatement(dupCheck);
			        duplicatechkprepared.setString(1, beanobj.getScalename().toLowerCase());
			        duplicatechkprepared.setString(2, "X");
			        duplicatechkprepared.setString(3, beanobj.getScaleid());
			        dupResult	= duplicatechkprepared.executeQuery();
				    
				    if(!dupResult.next())
				    {
			        
		            
		        	String query="update scale set scalename=?,dateofcreation=?,createdby=? where scaleid=?";
					settingsprepared = connection.prepareStatement(query);

					settingsprepared.setString(1, beanobj.getScalename().trim());
					settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
					settingsprepared.setString(3, beanobj.getCreatedby());
					settingsprepared.setString(4, beanobj.getScaleid());
					rs = settingsprepared.executeUpdate();
				    }
				    else
				    {
				    	rs	= 1000;
				    }
					
		    	}
		    		
					catch(Exception exception)
					{ 
							
						log.error("",exception);	
						}
				    	finally
						{
							if(settingsprepared != null)
								settingsprepared.close();
							
							if(connection!=null)
								connection.close();
						}
				    	return rs;
				    }
		 /**
		  * 
		  * This method is accessed from kycportal/WebContent/jsp/GradeSetting/ScaleStatusUpdate.jsp
	      * @param scaleid that can be used to update in scale table
		  * @param dateofcreation that can be used to update in scale table
		  * @param createdby that can be used to update in scale table
		  * @param scalestatus that can be used to update in scale table	
		  * @return int by which result can be printed on the screen
		  * @throws SQLException
		  */
		 public int UpdateScaleStatus(ScaleBean beanobj) throws SQLException
		    {
		    	PreparedStatement settingsprepared  = null;

				
		    	int rs=0;
		    	try
		    	{
		    		connection = ConnectionManager.getKycConnection();

			        log.info("invoking update UpdateScaleStatus from com.iGrandee.GradeSetting.GradeScaleQuery");

		            
		        	String query="update scale set dateofcreation=?,createdby=?,scalestatus=? where scaleid=?";
					settingsprepared = connection.prepareStatement(query);

					settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
					settingsprepared.setString(2, beanobj.getCreatedby());
					settingsprepared.setString(3, beanobj.getScalestatus());
					settingsprepared.setString(4, beanobj.getScaleid());
					rs = settingsprepared.executeUpdate();
					
					
		    	}
		    		
					catch(Exception exception)
					{ 
							
						log.error("",exception);					
						}
				    	finally
						{
							if(settingsprepared != null)
								settingsprepared.close();
							
							if(connection!=null)
								connection.close();
						}
				    	return rs;
				    }
		 /**
		  * This method is accessed from kycportal/WebContent/jsp/GradeSetting/ScaleTrashPreview.jsp
		  * @param scaleid that can be used to check whether it is allocated or not 
		  * @return String by which result can be printed on the screen
		  */
		 public String checkTrashScale(String scaleid)
		    {
			 String list="";
			
				
				try
				{ 
			        log.info("invoking get checkTrashScale(scaleid) from com.iGrandee.GradeSetting.GradeScaleQuery");
					select_query="select b.scaleid from gradescale b,scale a where a.scaleid=b.scaleid and a.scalestatus='A' and b.gradescalestatus='A' and a.scaleid='"+scaleid+"';";
					list=common_data_object.getString(select_query);
						
				}
				catch(Exception exception)
				{ 
						
					log.error("",exception);				
					}
			    	
			    	return list;
		 }
		 
	/*===================================================================================================*/

/**
   *This method is accessed from kycportal/jsp/GradeSetting/GradeScaleSetting.jsp
   @param instituteid that can be used to get  all BoardList  from  standardmedium, table by instituteid, sessionid,boardid wise;
   *
   @return  ArrayList by which result can be printed on the screen   ( accessed by _prasanth)
  */  
public ArrayList loadAcademicYear(String instituteid,String sessionstatus)
{
		log.info("Invoking loadAcademicYear() for Load the Academic Session");
		ArrayList academicList = null;
		try
		{
			select_query  	= "SELECT sessionid,sessionname FROM yearofsession where instituteid='"+instituteid+"' and sessionstatus='"+sessionstatus+"'"; 
			academicList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error("",exception);
		}
		return academicList;
}
	
public ArrayList LoadBoardList(String instituteid)
{
    ArrayList boardList = new ArrayList();
    try
    {
    	select_query = "select a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b where a.mediumid=b.mediumid and a.instituteid='"+instituteid+"' and a.boardstatus='A' and b.mediumstatus='A' order by a.boardid,b.mediumid";
    	boardList = common_data_object.getListMap(select_query);
        log.info(select_query);
    }
    catch(Exception exception) {log.error("",exception);
    }
    return boardList;
}

public ArrayList loadScaleType()
{
		log.info("Invoking loadScaleType() to Load the Scale Session");
		ArrayList scaleList = null;
		try
		{
			select_query  	= "select scaleid,scalename from scale where scalestatus='A'"; 
			scaleList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error("",exception);
		}
		return scaleList;
}

public ArrayList loadScaleType(String boardid)
{
		log.info("Invoking loadScaleType() to Load the Scale Session");
		ArrayList scaleList = null;
		try
		{
			select_query  	= "select scaleid,scalename from scale where scalestatus='A' and boardid='"+boardid+"'"; 
			scaleList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error("",exception);
		}
		return scaleList;
}
public ArrayList loadAllGrade(String sessionid,String boardid,String scaleid,String instituteid)
{
		log.info("Invoking loadAllGrade() to Load the Grade");
		ArrayList scaleList = null;
		try
		{
			//select_query  = "select a.gradeid,a.gradename,b.gradescaleid,b.rangefrom,b.rangeto from grade a left outer join gradescale b on b.sessionid='"+sessionid+"' and a.gradeid =b.gradeid and b.boardid='"+boardid+"' and b.scaleid='"+scaleid+"' and  b.gradescalestatus='A' and a.gradestatus='A' order by b.gradescaleid desc"; 
			/*select_query  = "select a.gradeid,a.gradename,(select b1.gradescaleid from grade a1,gradescale b1 where a1.gradeid=b1.gradeid "
							+" and a1.gradeid=a.gradeid and a1.gradestatus='A' and b1.gradescalestatus='A' and b1.sessionid='"+sessionid+"' and b1.boardid='"+boardid+"' and b1.scaleid='"+scaleid+"') as gradescaleid ,(select b1.rangefrom from grade a1,gradescale b1 where a1.gradeid=b1.gradeid "
							+" and a1.gradeid=a.gradeid and a1.gradestatus='A' and b1.gradescalestatus='A' and b1.sessionid='"+sessionid+"' and b1.boardid='"+boardid+"' and b1.scaleid='"+scaleid+"') as rangefrom ,(select b1.rangeto from grade a1,gradescale b1 where a1.gradeid=b1.gradeid "
							+" and a1.gradeid=a.gradeid and a1.gradestatus='A' and b1.gradescalestatus='A' and b1.sessionid='"+sessionid+"' and b1.boardid='"+boardid+"' and b1.scaleid='"+scaleid+"') as rangeto  "
							+" from grade a,login b,personmaster c,institution d  where a.gradestatus='A' and a.createdby=b.userid "
							+" and b.userid=c.personid and c.instituteid=d.instituteid and d.instituteid='"+instituteid+"' and a.scaleid='"+scaleid+"' order by a.gradeid desc";*/
 
			select_query  = "select a.gradeid,a.gradename,(select b1.gradescaleid from grade a1,gradescale b1 where a1.gradeid=b1.gradeid "
							+" and a1.gradeid=a.gradeid and a1.gradestatus='A' and b1.gradescalestatus='A' and b1.sessionid='"+sessionid+"') as gradescaleid ,(select b1.rangefrom from grade a1,gradescale b1 where a1.gradeid=b1.gradeid "
							+" and a1.gradeid=a.gradeid and a1.gradestatus='A' and b1.gradescalestatus='A' and b1.sessionid='"+sessionid+"') as rangefrom ,(select b1.rangeto from grade a1,gradescale b1 where a1.gradeid=b1.gradeid "
							+" and a1.gradeid=a.gradeid and a1.gradestatus='A' and b1.gradescalestatus='A' and b1.sessionid='"+sessionid+"') as rangeto  "
							+" from grade a,login b,personmaster c,institution d  where a.gradestatus='A' and a.createdby=b.userid "
							+" and b.userid=c.personid and c.instituteid=d.instituteid and d.instituteid='"+instituteid+"' and a.scaleid='"+scaleid+"' order by a.gradeid desc";
			
			//System.out.print("select_query-->"+select_query); 
			scaleList 	  = common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error("",exception);
		}
		return scaleList;
}
public String loadMarkPuBlishedorNot(String sessionid,String boardid)
{
		log.info("Invoking loadAllGrade() to Load the Grade");
		String count = null;
		try
		{
			//select_query  = "select a.gradeid,a.gradename,b.gradescaleid,b.rangefrom,b.rangeto from grade a left outer join gradescale b on b.sessionid='"+sessionid+"' and a.gradeid =b.gradeid and b.boardid='"+boardid+"' and b.scaleid='"+scaleid+"' and  b.gradescalestatus='A' and a.gradestatus='A' order by b.gradescaleid desc"; 
			select_query  = "	select count(d.examscheduleid) from standardschedule a join  standard b on a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' " 
							+"	and stdschedulestatus='A' and standardstatus='A'"
							+"	join  examallotment c on c.standardscheduleid=a.standardscheduleid and examallotmentstatus='A'"
							+"	join examschedule d on d.examallotmentid=c.examallotmentid and  d.markpublishstatus='R' and d.examschedulestatus='R' and d.examschedulestatus='R'";
			count 	  = common_data_object.getSingleColumn(select_query);
			//System.out.print("loadMarkPuBlishedorNot select_query-->"+select_query);
		}
		catch(Exception exception) { 
			log.error("",exception);
		}
		return count;
}

public String loadMarkPuBlishedorNot(String sessionid,String boardid,String scaleid)
{
		log.info("Invoking loadAllGrade() to Load the Grade");
		String count = null;
		try
		{
			//select_query  = "select a.gradeid,a.gradename,b.gradescaleid,b.rangefrom,b.rangeto from grade a left outer join gradescale b on b.sessionid='"+sessionid+"' and a.gradeid =b.gradeid and b.boardid='"+boardid+"' and b.scaleid='"+scaleid+"' and  b.gradescalestatus='A' and a.gradestatus='A' order by b.gradescaleid desc"; 
			select_query  = "	select count(d.examscheduleid) from standardschedule a join  standard b on a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and scaleid='"+scaleid+"'" 
							+"	and stdschedulestatus='A' and standardstatus='A'"
							+"	join  examallotment c on c.standardscheduleid=a.standardscheduleid and examallotmentstatus='A'"
							+"	join examschedule d on d.examallotmentid=c.examallotmentid and  d.markpublishstatus='R' and d.examschedulestatus='R' and d.examschedulestatus='R'";
			count 	  = common_data_object.getSingleColumn(select_query);
			//System.out.print("loadMarkPuBlishedorNot select_query-->"+select_query);
		}
		catch(Exception exception) { 
			log.error("",exception);
		}
		return count;
}


public int insertGradeSystem(GradeScaleBean GradeBean) throws Exception  
{
	log.info("Invoking insertGradeSystem() for Grade  Insertion");
	 	int result					= 0;
		PreparedStatement gradesystemprepared = null;
		String currentdate			= DateTime.showTime("MySqlWithTime");
		
		String [] gradeid =GradeBean.getGradeId();
		String [] fromrange =GradeBean.getRangeFrom();
		String [] torange =GradeBean.getRangeTo();
		String [] gscaleid =GradeBean.getGradescaleId();
	try
	{
		connection = ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		String query="";
		long gradescaleid = common_data_object.fmaxId("select max(gradescaleid) from gradescale");  
		for(int i=0;i<gradeid.length;i++)
		{
			if(gscaleid[i]!=null && gscaleid[i].equalsIgnoreCase(""))
			{
				query="insert into gradescale  (gradescaleid,gradeid,sessionid,rangefrom,rangeto, createdby, dateofcreation,gradescalestatus) values(?,?,?,?,?,?,?,?)";
				gradesystemprepared = connection.prepareStatement(query);
				gradesystemprepared.setLong(1,gradescaleid);
				//gradesystemprepared.setString(2,GradeBean.getScaleid()); 
				gradesystemprepared.setString(2,gradeid[i]);
				gradesystemprepared.setString(3,GradeBean.getSessionid());
				gradesystemprepared.setString(4,fromrange[i]);
				gradesystemprepared.setString(5,torange[i]);
				gradesystemprepared.setString(6,GradeBean.getCreatedby());
				gradesystemprepared.setString(7,currentdate);
				//gradesystemprepared.setString(9,GradeBean.getBoardid());
				gradesystemprepared.setString(8,"A");
				gradescaleid++;

				result += gradesystemprepared.executeUpdate();

			}
			else if(gscaleid[i]!=null && !gscaleid[i].equalsIgnoreCase("") && (fromrange[i].trim()).length()==0 && (torange[i].trim()).length()==0)
			{
				query="update gradescale set gradescalestatus=? where gradescaleid=?";
				gradesystemprepared = connection.prepareStatement(query);
				gradesystemprepared.setString(1,"X");
				gradesystemprepared.setString(2,gscaleid[i]); 
				log.info("=========>>>>>>>>>>>>>"+result);
				result += gradesystemprepared.executeUpdate();
				log.info("=========>>>>>>>>>>>>>"+fromrange[i].trim().length());
				log.info("=========>>>>>>>>>>>>>"+result);

			}
			else if(gscaleid[i]!=null && !gscaleid[i].equalsIgnoreCase("") && !(fromrange[i].trim()).equalsIgnoreCase("") && !(torange[i].trim()).equalsIgnoreCase(""))
			{
				query="update gradescale set rangefrom=?,rangeto=? where gradescaleid=?";
				gradesystemprepared = connection.prepareStatement(query);
				gradesystemprepared.setString(1,fromrange[i]);
				gradesystemprepared.setString(2,torange[i]); 
				gradesystemprepared.setString(3,gscaleid[i]);
				result += gradesystemprepared.executeUpdate();
			}
		}
		connection.commit();
 	}catch(SQLException exception)
 	{
 		log.error("",exception);
 		exception.printStackTrace();
 		result	= 0;
 		if(connection != null)
 			connection.rollback();
 	}
finally
	{
	 if(gradesystemprepared != null)
		 gradesystemprepared.close();
	 if(connection != null)
		 connection.close();
	 }
return result;
}
public int UpdateStandardScaleType(GradeScaleBean GradeBean) throws Exception 
{
	log.info("Invoking insertGradeSystem() for Grade  Insertion");
	 	int result					= 0;
		PreparedStatement gradesystemprepared = null;
		
		String [] standardscheduleid =GradeBean.getStandardscheduleid();
		String [] scaleid =GradeBean.getScaleId();
		//System.out.println("gradesystemprepared======>>>>>>>>"+scaleid.length);

	try
	{
		connection = ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		String query="";

		if(scaleid!=null && scaleid.length>0)
		{
			for(int i=0;i<scaleid.length;i++)
			{
					query="update standardschedule set scaleid=? where standardscheduleid=?";
					gradesystemprepared = connection.prepareStatement(query);
					gradesystemprepared.setString(1,scaleid[i]);
					gradesystemprepared.setString(2,standardscheduleid[i]);
					//System.out.println("gradesystemprepared======>>>>>>>>"+gradesystemprepared);
					result += gradesystemprepared.executeUpdate();
			}
		}
			
		connection.commit();
 	}catch(SQLException exception)
 	{
 		log.error("",exception);
 		exception.printStackTrace();
 		result	= 0;
 		if(connection != null)
 			connection.rollback();
 	}
finally
	{
	 if(gradesystemprepared != null)
		 gradesystemprepared.close();
	 if(connection != null)
		 connection.close();
	 }
return result;
}
public ArrayList loadstandard(String boardid,String sessionid,String instituteid) {
	ArrayList arraylist = null;
	try {  
		select_query = "select a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,a.scaleid from  standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	and a.stdschedulestatus='A' order by a.standardid,a.groupid";  
		log.info("===================>>>>>>>>>>>>"+select_query);   
//System.out.println("loadstandardwithstatus===================>>>>>>>>>>>>"+select_query);   

		arraylist = common_data_object.getListMap(select_query);
		log.info("==========>>>>>"+arraylist);  
					
	} catch (Exception exception) { exception.printStackTrace();
	}
	return    arraylist;
}	 

	/**
	 *This method is accessed from kycportal/jsp/Principal/ExamResultPublishView.jsp
	 @param standardscheduleid that can be used to get  all GradeScaleList  from  grade,scale,gradescale,
	 standardschedule table by standardscheduleid wise;
	 *
	 @return  ArrayList by which result can be printed on the screen   ( accessed by subhash)
	*/  
	
	public ArrayList LoadGradeScaleList(String standardscheduleid)
	{
		log.info("Invoking LoadGradeScaleList() based on the standard");
			ArrayList gradescaleList = null;
			try
			{
				//select_query  	= "select gradesystemid, gradename, cast(rangefrom as signed) as rangefrom, rangeto FROM gradesystem where gradesystemstatus='A' and sessionid='"+sessionid+"' order by rangefrom asc";
				select_query  	= "select a.gradeid,a.gradename,cast(c.rangefrom as signed) as rangefrom,c.rangeto from grade a,scale b,gradescale c,standardschedule d where a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and d.stdschedulestatus='A'  order by rangefrom asc";
				gradescaleList 	= common_data_object.getListMap(select_query);
				log.info("LoadGradeScaleList Query :"+select_query);
			}
			catch(Exception exception) { 
							
				log.error("",exception);
			}
			return gradescaleList;
	}

	/**
	 *This method is accessed from kycportal/jsp/Reports/ExamMarkResult.jsp
	 @param standardscheduleid,totalmark that can be used to get  all GradeScaleList  from  grade,scale,gradescale,
	 standardschedule table by standardscheduleid wise;
	 *
	 @return  String by which result can be printed on the screen   ( accessed by subhash)
	*/  
	
	public String getGradeScaleSystem(String standardscheduleid,String totalmark)
	{
		log.info("Invoking getGradeSystem() for Loading Topper Weeker List");
		String  grade = null;
			try
			{
				//select_query  			= "select gradename from gradesystem where sessionid='"+sessionid+"' and gradesystemstatus='A' and ("+mark+" between rangefrom and rangeto)";
				select_query  			= "select a.gradename from grade a,scale b,gradescale c,standardschedule d where a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and d.stdschedulestatus='A' and ("+totalmark+" between c.rangefrom and c.rangeto)";
				grade 					= common_data_object.getString(select_query);
				//System.out.println("======>>>>>>>>"+select_query);
			}
			catch(Exception exception) { 
				log.error("",exception);
			}
			return grade;
	}

	public ArrayList LoadFailedID(String standardscheduleid,String examnameid)
	{
		log.info("Invoking LoadFailedID(standardscheduleid,examnameid) based on the standard");
			ArrayList gradescaleList = null;
			try
			{
				select_query  	= "select distinct h.studentallocationid as studentallocationid from standardschedule a join sectionschedule b on a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A' and b.sectionschedulestatus='A' join studentallocation c on b.standardscheduleid='"+standardscheduleid+"' and c.sectionscheduleid=b.sectionscheduleid and c.studentallocationstatus='A' join subjectschedule d on d.standardscheduleid=a.standardscheduleid join examname e on e.sessionid=a.sessionid and e.examnamestatus='A' and e.examnameid='"+examnameid+"' join examallotment f on f.examnameid=e.examnameid and f.examallotmentstatus='A' join examschedule g on g.examallotmentid=f.examallotmentid and g.examschedulestatus='R' join exammark h on h.examscheduleid=g.examscheduleid and h.studentallocationid=c.studentallocationid and h.markstatus='A' and cast(d.theoryexternalmin as unsigned integer) > cast(h.marktaken as unsigned integer)";
				//System.out.print("select_query-->"+select_query);
				gradescaleList 	= common_data_object.getListMap(select_query);
				log.info("LoadGradeScaleList Query :"+select_query);
			}
			catch(Exception exception) { 
							
				log.error("",exception);
			}
			return gradescaleList;
	}
	
	/**
	 *This method is accessed from kycportal/jsp/Principal/GradewiseStudentView.jsp
	 @param examnameid,standardscheduleid,sectionscheduleid,gradeid,sessionid that can be used to get  all StudentList  from  grade,scale,gradescale,
	 standardschedule,exammark,examname,sectionschedule,grade,yearofsession table by standardscheduleid wise;
	 *
	 @return  ArrayList by which result can be printed on the screen   ( accessed by subhash)
	*/  
	
	public ArrayList LoadStudentGradeScaleWise(String examnameid,String standardscheduleid,String sectionscheduleid,String gradeid,String sessionid,String failedAllocationId)
	{
		//System.out.print("examnameid,String standardscheduleid,String sectionscheduleid,String gradeid,String sessionid-->"+examnameid+"--"+standardscheduleid+"--"+sectionscheduleid+"--"+gradeid+"--"+sessionid);
		log.info("Invoking LoadStudentGradeScaleWise(examnameid,standardscheduleid,sectionscheduleid,gradeid,sessionid) for Loading Gradewise List");
		ArrayList boardList = new ArrayList();
		Connection connection;
	    try
	    {
	    	connection 	    =   ConnectionManager.getKycConnection();
	        /*select_query    =   " CREATE OR REPLACE view gradewise as SELECT case when sum(em.marktaken) is null then '0' else sum(em.marktaken) end as total," +
							    " case when (SELECT gradesystemid  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto and sessionid='"+sessionid+"') is null then '0' "+
							    " else (SELECT gradesystemid  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto  and sessionid='"+sessionid+"') end as gradesystemid, "+
							    " case when (SELECT gradename  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto and sessionid='"+sessionid+"') is null then 'No Grade' "+
							    " else (SELECT gradename  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto  and sessionid='"+sessionid+"') end as gradename, "+
							    " case when (SELECT rangefrom  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto and sessionid='"+sessionid+"') is null then '0' "+
							    " else (SELECT rangefrom  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto  and sessionid='"+sessionid+"') end as rangefrom, "+
							    " case when (SELECT rangeto  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto and sessionid='"+sessionid+"') is null then 'No Grade' "+
							    " else (SELECT rangeto  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto  and sessionid='"+sessionid+"') end as rangeto, "+
		        			    " es.examallotmentid,sa.studentallocationid,sum(ss.theoryexternalmax) as totalmark," +
		        			    " sa.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname  FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')    and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  group by studentallocationid order by gradesystemid asc,total,studentallocationid; ";*/
	        select_query    =   " CREATE OR REPLACE view gradewise as SELECT case when sum(em.marktaken) is null then '0' else sum(em.marktaken) end as total," +
		    " case when (select a.gradeid from grade a,scale b,gradescale c,standardschedule d where " +
		    "a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and " +
		    "d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and " +
		    "d.stdschedulestatus='A' and  sum(em.marktaken) "+
		    " between c.rangefrom and c.rangeto and c.sessionid='"+sessionid+"') is null then '0' "+
		    " else (select a.gradeid from grade a,scale b,gradescale c,standardschedule d where " +
		    "a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and " +
		    "d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and " +
		    "d.stdschedulestatus='A' and  sum(em.marktaken) "+
		    " between c.rangefrom and c.rangeto and c.sessionid='"+sessionid+"') end as gradeid, "+
		    " case when (select a.gradename from grade a,scale b,gradescale c,standardschedule d where " +
		    "a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and " +
		    "d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and " +
		    "d.stdschedulestatus='A' and  sum(em.marktaken) "+
		    " between c.rangefrom and c.rangeto and c.sessionid='"+sessionid+"') is null then 'No Grade' "+
		    " else (select a.gradename from grade a,scale b,gradescale c,standardschedule d where " +
		    "a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and " +
		    "d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and " +
		    "d.stdschedulestatus='A' and  sum(em.marktaken) "+
		    " between c.rangefrom and c.rangeto and c.sessionid='"+sessionid+"') end as gradename, "+
		    " case when (select c.rangefrom from grade a,scale b,gradescale c,standardschedule d where " +
		    "a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and " +
		    "d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and " +
		    "d.stdschedulestatus='A' and  sum(em.marktaken) "+
		    " between c.rangefrom and c.rangeto and c.sessionid='"+sessionid+"') is null then '0' "+
		    " else (select c.rangefrom from grade a,scale b,gradescale c,standardschedule d where " +
		    "a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and " +
		    "d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and " +
		    "d.stdschedulestatus='A' and  sum(em.marktaken) "+
		    " between c.rangefrom and c.rangeto and c.sessionid='"+sessionid+"') end as rangefrom, "+
		    " case when (select c.rangeto from grade a,scale b,gradescale c,standardschedule d where " +
		    "a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and " +
		    "d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and " +
		    "d.stdschedulestatus='A' and  sum(em.marktaken) "+
		    " between c.rangefrom and c.rangeto and c.sessionid='"+sessionid+"') is null then 'No Grade' "+
		    " else (select c.rangeto from grade a,scale b,gradescale c,standardschedule d where " +
		    "a.gradeid=c.gradeid and b.scaleid=a.scaleid and b.scaleid=d.scaleid and c.sessionid=d.sessionid and " +
		    "d.standardscheduleid='"+standardscheduleid+"' and a.gradestatus='A' and b.scalestatus='A' and c.gradescalestatus='A' and " +
		    "d.stdschedulestatus='A' and  sum(em.marktaken) "+
		    " between c.rangefrom and c.rangeto and c.sessionid='"+sessionid+"') end as rangeto, "+
		    " es.examallotmentid,sa.studentallocationid,sum(ss.theoryexternalmax) as totalmark," +
		    " sa.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname  FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')    and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A' "+failedAllocationId+" group by studentallocationid order by gradeid asc,total,studentallocationid; ";   

			Statement stmt1 =   connection.createStatement(); 
	        stmt1.executeUpdate(select_query);
	        String  select_querynew = "select *  from gradewise where gradeid in ('"+gradeid+"')";   
	        boardList = common_data_object.getListMap(select_querynew);
	        log.info("Exam Grade  QUERY::>>>>"+select_querynew);
	        Statement stmt = connection.createStatement();
			stmt.executeUpdate("DROP VIEW IF EXISTS `kycportal`.`gradewise`");
			try {
				if(stmt1!=null)
					stmt1.close();
				if(stmt!=null)
					stmt.close();
			    if(connection!=null)
					connection.close();
			} catch (RuntimeException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				//System.out.print("e-->"+e);
			}
	    }
	    catch(Exception exception) {
	    	log.error("",exception); 
	    	//System.out.print("exception-->"+exception);	
	    }
	    return boardList;
	}
	
	 public int insertScaleBoard(ScaleBean scaleBean) throws Exception
	 {
		 	log.info("invoking insertScaleBoard for Scale Insertion");
		 
		 	int result					= 0;
			PreparedStatement standprepared = null;
			//PreparedStatement scalelog = null;
			
			long regid					= 0l;
			String currentdate			= DateTime.showTime("MySqlWithTime");
			String querytoexecute		= null;
			//ResultSet regidresult		= null;
			//long scalelogid			= 0l;
	 try
	 {
		 connection = ConnectionManager.getKycConnection();
		 connection.setAutoCommit(false);
			
			String query="select max(scaleid) from scale";
			long scaleid = common_data_object.maxId(query);
			scaleid++;
			boolean return_flag=false;
			String select_query = "SELECT scalename FROM scale where scalename='"+scaleBean.getScalename()+"' and scalestatus='A' and boardid='"+scaleBean.getBoardid()+"'" ;
    		String return_string = common_data_object.getString(select_query);
    		if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
    			return_flag = true;
    		}
    		else
    		{
    			return_flag = false;
    		}
			if(return_flag)
			{
					query="insert into scale(scaleid,scalename,createdby,dateofcreation,scalestatus,boardid) values(?,?,?,?,?,?)";
					standprepared = connection.prepareStatement(query);
					standprepared.setLong(1, scaleid);
					standprepared.setString(2,scaleBean.getScalename());
					standprepared.setString(3,scaleBean.getCreatedby());
					standprepared.setString(4, currentdate);
					standprepared.setString(5,"A");
					standprepared.setString(6,scaleBean.getBoardid());
					result += standprepared.executeUpdate();
					
					
					//querytoexecute		= "select max(stdlogid) from scalelog";
					//scalelog			= connection.prepareStatement(querytoexecute);
					//regidresult			= scalelog.executeQuery();
					
					//if(regidresult.next()){
						//scalelogid	= regidresult.getLong(1);
					//}
					
					//scalelogid++;
					
					//querytoexecute		= "insert into scalelog(stdlogid, logdescription, standardid, createdby, dateofcreation, stdlogstatus) values(?,?,?,?,?,?)";
					//scalelog				= connection.prepareStatement(querytoexecute);
					
					//scalelog.setLong(1, scalelogid);
					//scalelog.setString(2,"Created");
					//scalelog.setLong(3,standardid);
					//scalelog.setString(4, scaleBean.getCreatedby());
					//scalelog.setString(5, currentdate);
					//scalelog.setString(6,"A");
					
					//result += scalelog.executeUpdate();
			}
			else
			{
				result =1000;
			}
			
			
			
			connection.commit();

		 
	 }catch(SQLException e){
		 
		 //System.out.println("THe problem is here...");
			log.error("",e);
			result	= 0;
			if(connection != null)
				connection.rollback();
	 }
	 finally
		{
		 //if(regidresult != null)
			// regidresult.close();
		 
		 if(standprepared != null)
			standprepared.close();
		 //if(scalelog != null)
			//scalelog.close();
		 if(connection != null)
			 connection.close();
		 }
	 return result;
	 }

	 
	 /**
		 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/ScaleList.jsp
		 * @param boardid that can used to get all scales by board wise from scale table
		 * @param scalestatus that can used to get all grades by status wise from scale table
		 * @return ArrayList by which result can be printed on the screen
		 */
		public ArrayList listScaleList(String instituteid,String boardid,String scalestatus)
		    {
				ArrayList list=null;
	
				try
				{
			        log.info("invoking listScaleList from com.iGrandee.GradeSetting.GradeScaleQuery");
					select_query="select a.scaleid,a.scalename,date_format(a.dateofcreation,'%d-%b-%Y') as dateofcreation from scale a,login b,personmaster c,institution d where a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A'  and c.instituteid='"+instituteid+"' and a.boardid='"+boardid+"' and c.instituteid=d.instituteid and d.status='A' and a.scalestatus ='"+scalestatus+"' order by dateofcreation desc";
					list=common_data_object.getListMap(select_query);
					
				}
				catch(Exception exception) 
				{ 
						
					log.error("",exception);				
					}
			    	
			    	return list;
			    }
		 /**
		  * This method is accessed from kycportal/jsp/GradeSetting/Scale/checkDuplicate.jsp
		  * check duplicate scale (update screen)      - subhash
		   @param  scalename  that can be used to check duplicate names from scale table by instituteid,scalename,boardid wise
		   *
		   @param scaleid that can be used to check duplicate names from standard table by instituteid,scalename,boardid wise
		   *
		   @param boardid that can be used to check duplicate names from standard table by instituteid,scalename,boardid wise
		   *
		   @param instituteid that can be used to check duplicate names from standard table by instituteid,scalename,boardid wise
		   *
		   @return the boolean by which result can be printed on the screen
		 */
		 public boolean checkDuplicateupdate(String scalename,String scaleid,String boardid,String instituteid)
		    {
		    	boolean return_flag = false;
		    	String return_string = null;
		    	try
		    	{
		    		log.info("invoke scale checkDuplicateupdate update screen from com.iGrandee.GradeSetting.GradeScaleQuery");

		    		String select_query = "SELECT scalename FROM scale where scalename='"+scalename+"' and scalestatus='A' and boardid='"+boardid+"'  and scaleid <> '"+scaleid+"' " ;
		    		return_string = common_data_object.getString(select_query);
		    		if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
		    			return_flag = false;
		    		}
		    		else
		    		{
		    			return_flag = true;
		    		}
		    	}
		    	catch(Exception e)
		    	{
		    		log.error("",e);	
		    	}
		    	return return_flag;
		    }
		 
		 public int updateScale(ScaleBean scaleBean) throws Exception
		 {
			 	log.info("invoking updateScale for Scale  Updation");
			 
			 	int result	= 0;
				PreparedStatement scaleprepared = null;
				//String currentdate = DateTime.showTime("MySqlWithTime");
		 try
		 {
			 connection = ConnectionManager.getKycConnection();
			 connection.setAutoCommit(false);
				if(!checkDuplicateupdate(scaleBean.getScalename(), scaleBean.getScaleid(), scaleBean.getBoardid(), scaleBean.getInstituteid()))
				{
					select_query="update scale set scalename=?,boardid=? where scaleid=?";
					log.info(select_query);
					scaleprepared = connection.prepareStatement(select_query);
					scaleprepared.setString(1,scaleBean.getScalename());
					scaleprepared.setString(2, scaleBean.getBoardid());
					scaleprepared.setString(3, scaleBean.getScaleid());
					result += scaleprepared.executeUpdate();
				}
				else
				{
					result=1000;
				}
				
				connection.commit();

			 
		 }catch(SQLException e){
			 
				log.error("",e);
				result	= 0;
				if(connection != null)
					connection.rollback();
		 }
		 finally
			{
		 
			 if(scaleprepared != null)
				 scaleprepared.close();
			
			 if(connection != null)
				 connection.close();
			 }
		 return result;
		 }
		
		public int updateScaleStatus(ScaleBean scaleBean) throws Exception
		 {
			 	log.info("invoking updateScaleStatus for Scale Status");
			 
			 	int result	= 0;
				PreparedStatement scaleprepared = null;
				
		 try
		 {
			 connection = ConnectionManager.getKycConnection();
			 connection.setAutoCommit(false);
				
				
				select_query="update scale set scalestatus=? where scaleid=?";
				scaleprepared = connection.prepareStatement(select_query);
				scaleprepared.setString(1,scaleBean.getScalestatus());
				scaleprepared.setString(2,scaleBean.getScaleid());
				result += scaleprepared.executeUpdate();
				
				connection.commit();

			 
		 }catch(SQLException e){
			 
				log.error("",e);
				result	= 0;
				if(connection != null)
					connection.rollback();
		 }
		 finally
			{
		 
			 if(scaleprepared != null)
				 scaleprepared.close();
			
			 if(connection != null)
				 connection.close();
			 }
		 return result;
		 }		

		 /**
		 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/ScaleTrash.jsp
		 * @param boardid that can used to get all scales by board wise from scale table
		 * @param scaleid that can used to get all scales by scale wise from scale table
		 * @return ArrayList by which result can be printed on the screen
		 */
		public ArrayList loadScaleDetails(String reqscaleid)
		    {
		        ArrayList arraylist = new ArrayList();
		        try
		        {
		            select_query = "select a.scaleid,a.scalename,a.boardid,b.boardname,c.mediumname from scale a,board b,standardmedium c where a.scaleid='"+reqscaleid+"' and a.boardid=b.boardid and b.boardstatus='A' and c.mediumid=b.mediumid and c.mediumstatus='A'";
		            arraylist = common_data_object.getListMap(select_query);
		        }
		        catch(Exception exception) { }
		        return arraylist;
			}
		
		 public ArrayList loadGradeStatusforUpdate(String reqscaleid,String state)
		    {
		        ArrayList arraylist = new ArrayList();
		        try
		        {
		        	if(state.equals("grade"))
		        	{
		            select_query = "select * from grade where scaleid='"+reqscaleid+"' and gradestatus!='X'";
		            arraylist = common_data_object.getListMap(select_query);
		        	}
		        	else if(state.equals("schedule"))
		        	{
		        		select_query = "select * from standardschedule where groupid='"+reqscaleid+"' and stdschedulestatus!='X'";
			            arraylist = common_data_object.getListMap(select_query);
		        	}
		        }
		        catch(Exception exception) { }
		        return arraylist;
			}		

		 /**
			 * This method is accessed from kycportal/WebContent/jsp/GradeSetting/Grade/GradeCreation.jsp
			 * @param instituteid that can used to get all grades by institution wise from scale table
			 * @param scalestatus that can used to get all grades by status wise from scale table
			 * @return ArrayList by which result can be printed on the screen
			 */
			public ArrayList listGrade(String scaleid,String instituteid,String gradestatus)
			    {
					ArrayList list=null;
				
					
					try
					{
				        log.info("invoking get listGrade(scaleid,instituteid,gradestatus) from com.iGrandee.GradeSetting.GradeScaleQuery");
						select_query="select a.gradeid,a.gradename,date_format(a.dateofcreation,'%d-%b-%Y') as dateofcreation from grade a,login b,personmaster c,institution d where a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and a.scaleid='"+scaleid+"' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' and a.gradestatus ='"+gradestatus+"' order by a.dateofcreation desc";
						list=common_data_object.getListMap(select_query);								
					}
					catch(Exception exception) 
					{ 
							
						log.error("",exception);				
						}
				    	
				    	return list;
				    }

			 /**
			  * This method is accessed from kycportal/jsp/GradeSetting/Grade/GradeInfo.jsp
			  * check duplicate for grade name(entry screen)         - subhash
			   @param  fieldname that can be used to check duplicate names from grade table 
			   *
			   @param scaleid that can be used to check duplicate names from grade table 
			   *
			   @param fieldvalue that can be used to check duplicate names from grade table 
			   *
			   @return the boolean by which result can be printed on the screen
			 */
			public boolean checkDuplicateentry(String fieldname,String scaleid,String fieldvalue)
			{
				boolean return_flag = false;
				String return_string = null;
				try 
				{ 
					log.info("invoke grade checkDuplicateentry from com.iGrandee.GradeSetting.GradeScaleQuery");
					String select_query = "SELECT g."+fieldname+" FROM `grade` g where g.scaleid='"+scaleid+"' and g."+fieldname+"='"+fieldvalue+"' and g.gradestatus <> 'X' " ;
					return_string = common_data_object.getString(select_query);

					if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
						return_flag = false;
					}
					else {
						return_flag = true;
					}

				}
				catch(Exception e)
				{log.error("",e);
				}
				return return_flag;
			}
			
			public boolean checkDuplicate(String fieldname,String scaleid,String fieldvalue,String fieldvalue2)
			{
				boolean return_flag = false;
				String return_string = null;
				try
				{
					log.info("invoke grade checkDuplicateentry from com.iGrandee.GradeSetting.GradeScaleQuery");
					String select_query = "SELECT g."+fieldname+" FROM `grade` g where g.scaleid='"+scaleid+"' and g.gradeid <> '"+fieldvalue2+"' and g."+fieldname+"='"+fieldvalue+"'" ;
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
			
			 public int insertGradeFromScale(GradeBean gradeBean) throws Exception
			 {
				 	log.info("invoking insertGradeFromScale for Grade Insertion");
				 
				 	int result					= 0;
					PreparedStatement gradeprepared = null;
					
					String currentdate			= DateTime.showTime("MySqlWithTime");
			 try
			 {
				 
				 //checkDuplicate(gradeBean.getGradename(),gradeBean.getInstituteid());
				 
				 
					connection = ConnectionManager.getKycConnection();
					connection.setAutoCommit(false);
					String query="select max(gradeid) from grade";
					long gradeid = common_data_object.maxId(query);
					gradeid++;
					query="insert into grade (gradeid, gradename, createdby, dateofcreation , gradestatus, scaleid) values(?,?,?,?,?,?)";
					gradeprepared = connection.prepareStatement(query);
					gradeprepared.setLong(1,gradeid);
					gradeprepared.setString(2,gradeBean.getGradename());
					gradeprepared.setString(3,gradeBean.getCreatedby());
					gradeprepared.setString(4, currentdate);					
					gradeprepared.setString(5,"A");
					gradeprepared.setString(6,gradeBean.getScaleid());

					result += gradeprepared.executeUpdate();
				
					connection.commit();

			 }catch(SQLException e){
				 
				 //System.out.println("THe problem is here...");
					log.error("",e);
					result	= 0;
					if(connection != null)
						connection.rollback();
			 }
			 finally
				{
				 if(gradeprepared != null)
					 gradeprepared.close();
				 if(connection != null)
					 connection.close();
				 }
			 return result;
			 }

			public ArrayList loadGradeforgradeid(String scaleid,String gradeid)
		    {
		        ArrayList arraylist = new ArrayList();
		        try
		        {
		        	select_query = "SELECT a.gradeid,a.gradename FROM `grade` a where a.scaleid='"+scaleid+"' and a.gradestatus='A' and a.gradeid='"+gradeid+"'";
		        	log.info(select_query);
			        arraylist = common_data_object.getListMap(select_query);
		        }catch(Exception e){log.error("",e);}
		        return arraylist;
		    }		

			public int updateGradeDetail(GradeBean gradeBean,String Editstatus) throws Exception
			 {
				 	log.info("invoking updateGradeDetail for Grade Update");
				 
				 	int result	= 0;
					PreparedStatement updategradeprepared = null;
					try
					{
						connection = ConnectionManager.getKycConnection();
						connection.setAutoCommit(false);
					if(Editstatus.equals("E"))
					{
					select_query="update grade set gradename=?, createdby=?, dateofcreation=?  where gradeid=?";
					updategradeprepared = connection.prepareStatement(select_query);
					updategradeprepared.setString(1,gradeBean.getGradename());
					updategradeprepared.setString(2,gradeBean.getCreatedby());
					updategradeprepared.setString(3,DateTime.showTime("MySqlWithTime"));
					updategradeprepared.setString(4,gradeBean.getGradeid());
					}
					else if(Editstatus.equals("T") || Editstatus.equals("A") || Editstatus.equals("X"))
					{
						select_query="update grade set  gradestatus=?  where gradeid=?";
						updategradeprepared = connection.prepareStatement(select_query);
						updategradeprepared.setString(1,Editstatus);
						updategradeprepared.setString(2,gradeBean.getGradeid());
					}
					//System.out.println("select_query"+updategradepreparedupdategradeprepared);
					result += updategradeprepared.executeUpdate();
					connection.commit();
			 		}
					catch(Exception e){
					log.error("",e);
					result	= 0;
					if(connection != null)
						connection.rollback();
			 		}
			 finally
				{
			 
				 if(updategradeprepared != null)
					 updategradeprepared.close();
				
				 if(connection != null)
					 connection.close();
				 }
			 return result;
			 }			

			public String CheckGradeSchedule(String gradeid)
		    {
		        String str = null;
		        try
		        {
		        	select_query = "SELECT count(*) FROM gradescale ss  where ss.gradeid='"+gradeid+"' and ss.gradescalestatus='A'";
		        	log.info(select_query);
		        	str = common_data_object.getSingleColumn(select_query);
		        }catch(Exception e){log.error("",e);}
		        return str;
		    }
			
	public String insert_query;
	DateTime date_object;
	Connection connection;
	CommonDataAccess common_data_object;
	ConnectionManager connectionManager;
	String select_query;
	Statement stmt;
	ResultSet rs;
}