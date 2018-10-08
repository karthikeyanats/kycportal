package com.iGrandee.MasterEntries.Extracurricularactivity;
import com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityBean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;


import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import org.apache.log4j.Logger;

public class ExtracurricularactivityEntry
{
	static Logger log = Logger.getLogger(ExtracurricularactivityEntry.class);

    public ExtracurricularactivityEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        Extracurricularactivitycon      = null;


        select_query = null;
    }
    
    /**
	  * This method is accessed from kycportal/jsp/masterentries/Extracurricularactivity/ExtracurricularactivitySubmit.jsp
	  * insert Extracurricularactivity details           - prasanth
	  @param  extracurricularactivityid that can be inserted to extracurricularactivity table
	  *
	  @param extracurricularname that can be inserted to extracurricularactivity table
	  *
	  @param description that can be inserted to extracurricularactivity table
	  *
	  @param dateofcreation that can be inserted to extracurricularactivity table
	  *
	  @param createdby that can be inserted to extracurricularactivity table
	  *
	  @param extracurricularstatus that can be inserted to extracurricularactivity table
	  *
	  @return the integer by which result can be printed on the screen
	 */
   public int insertExtracurricularactivity(ExtracurricularactivityBean activitybean)throws SQLException
   {
   	log.info("invoking insert extracurricularactivity from com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry");
		int result=0;

		PreparedStatement settingsprepared  = null;
		PreparedStatement activityprepared = null;
		ResultSet rs1						= null;

       try
       
   	{

       Extracurricularactivitycon = ConnectionManager.getKycConnection();
       String str			= "select a.extracurricularname from extracurricularactivity a,login b,personmaster c,institution d where a.extracurricularname=?  and a.createdby=b.userid and b.loginstatus=? and b.personid=c.personid and c.status=? and c.instituteid=? and c.instituteid=d.instituteid and d.status=? and  a.extracurricularstatus <> ? ";
 
       activityprepared	= Extracurricularactivitycon.prepareStatement(str);
       activityprepared.setString(1, activitybean.getExtracurricularname().toLowerCase()); 
       activityprepared.setString(2, "A");   
       activityprepared.setString(3, "A");   
       activityprepared.setString(4, activitybean.getInstituteid());   
       activityprepared.setString(5, "A");   
       activityprepared.setString(6, "X");   

       rs1	= activityprepared.executeQuery();
       if(!rs1.next())
       {  
		long l = common_data_object.fmaxId("select max(extracurricularactivityid)from extracurricularactivity");

		String query="insert into extracurricularactivity (extracurricularactivityid,extracurricularname,description,dateofcreation,createdby,extracurricularstatus) values(?,?,?,?,?,?)";
		settingsprepared = Extracurricularactivitycon.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,activitybean.getExtracurricularname());
		settingsprepared.setString(3,activitybean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, activitybean.getCreatedby());
		settingsprepared.setString(6, "A");
	    result = settingsprepared.executeUpdate();
	    
		long l1 = common_data_object.fmaxId("select max(extracurricularactivitylogid)from extracurricularactivitylog");
		String query1="insert into extracurricularactivitylog (extracurricularactivitylogid,extracurricularactivityid,action,dateofcreation,status) values(?,?,?,?,?)";
		settingsprepared = Extracurricularactivitycon.prepareStatement(query1);
		
		settingsprepared.setLong(1, l1);
		settingsprepared.setLong(2,l);
		settingsprepared.setString(3, activitybean.getAction());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, "A");
	    result = settingsprepared.executeUpdate();
	    
       }
       else
       {
       	result=1000;
       }
	
   	}catch(Exception exception) { 
   		log.error(exception);	
		}
		
   	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(Extracurricularactivitycon != null)
				Extracurricularactivitycon.close();
			
			if(activityprepared != null) 
				activityprepared.close(); 
			
			if(rs1 != null)
				rs1.close();
		}
   	return result;
   	}
   /**
    * This method is accessed from kycportal/jsp/masterentries/Extracurricularactivity/ExtracurricularactivityList.jsp
    * get details for updation - prasanth
    @param  status   that can be get extracurricularactivityid,extracurricularactivityname and description by status wise from extracurricularactivityid table
    *
    @return  the ArrayList for    printed the result on the screen 
   */
public ArrayList get_All_Extracurricularactivity(String status,String createdby,String instituteid)
{
		ArrayList list=null;
	
		
		try
		{
		   	log.info("invoking list extracurricularactivity  from com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry");

			select_query="select a.extracurricularactivityid,a.extracurricularname,a.description, DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates,a.extracurricularstatus from extracurricularactivity a,login b,personmaster c,institution d where  a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' and a.extracurricularstatus='"+status+"' order by a.dateofcreation desc;";
					
			//System.out.println(select_query);
					
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
}



/**
 * This method is accessed from kycportal/jsp/masterentries/Extracurricularactivity/ExtracurricularactivityUpdateByClick.jsp
 * get details for updation - prasanth
 @param  extracurricularactivityid   that can be get extracurricularactivityid,extracurricularactivityname and description from  extracurricularactivity table
 *  
 @param  status   that can be get that can be get extracurricularactivityid,extracurricularactivityname and description from  extracurricularactivity table
 *
 @return  the ArrayList for    printed the result on the screen 
*/
public ArrayList getDetailsForuadate(String extracurricularactivityid,String status)
{
		ArrayList list=null;
		
		try
		{
		   	log.info("invoking list extracurricularactivity  from com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry");

			select_query="select extracurricularactivityid,extracurricularname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,extracurricularstatus from extracurricularactivity where extracurricularactivityid='"+extracurricularactivityid+"' and extracurricularstatus='"+status+"'  order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
} /**
 * This method is accessed from kycportal/jsp/masterentries/Extracurricularactivity/ExtracurricularactivityTrashPriview.jsp
 * check Activity allocated for students or not- prasanth
 @param  extracurricularactivityid   that can be get extracurricularactivityid   from  extracurricularactivity table
 *  
 
 @return  the ArrayList for    printed the result on the screen 
*/  
public ArrayList checkTrash(String extracurricularactivityid)
{
		ArrayList list=null;
		
		try
		{
		   	log.info("invoking list extracurricularactivity  from com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry");

			select_query="SELECT b.studextracurricular FROM extracurricularactivity a,candidateregister b where a.extracurricularactivityid='"+extracurricularactivityid+"' and find_in_set(a.extracurricularactivityid,b.studextracurricular) and a.extracurricularstatus='A' and b.candidateregisterstatus='A';";
			list=common_data_object.getListMap(select_query);
		
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/Extracurricularactivity/ExtracurricularactivityEditUpdate.jsp
 * update  extracurricularactivity details  - prasanth
   @param  extracurricularactivityid that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param extracurricularactivityname that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param description that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param dateofcreation that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param createdby that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param extracurricularactivitystatus  that can be updated to extracurricularactivity table  by extracurricularactivityid wise  
   *          
  @return  the int for   printed the result on the screen 
*/

public int UpdateEdittExtracurricularactivity(ExtracurricularactivityBean activitybean)  throws SQLException
{
	PreparedStatement settingsprepared  = null;
	PreparedStatement activityprepared = null;
	ResultSet rs1						= null;

	int result=0;
	
	try
	{
		log.info("invoking Update extracurricularactivity  from com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry");
		Extracurricularactivitycon = ConnectionManager.getKycConnection();
			String str			= "select extracurricularname from extracurricularactivity where extracurricularname=? and extracurricularactivityid<>?  and extracurricularstatus <> ?";
			activityprepared	= Extracurricularactivitycon.prepareStatement(str);
			activityprepared.setString(1, activitybean.getExtracurricularname().toLowerCase());
			activityprepared.setString(2, activitybean.getExtracurricularactivityid());
			activityprepared.setString(3, "X");
            rs1	= activityprepared.executeQuery();
	            
            if(!rs1.next())
            {
	         String query="update extracurricularactivity set extracurricularname=?, dateofcreation=?,description=?,createdby=?  where extracurricularactivityid=? ";
			settingsprepared = Extracurricularactivitycon.prepareStatement(query);
		
			settingsprepared.setString(1, activitybean.getExtracurricularname());
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,activitybean.getDescription());
			settingsprepared.setString(4, activitybean.getCreatedby());
			settingsprepared.setString(5,activitybean.getExtracurricularactivityid());
			result = settingsprepared.executeUpdate();
			

			long l1 = common_data_object.fmaxId("select max(extracurricularactivitylogid)from extracurricularactivitylog");
			String query1="insert into extracurricularactivitylog (extracurricularactivitylogid,extracurricularactivityid,action,dateofcreation,status) values(?,?,?,?,?)";
			settingsprepared = Extracurricularactivitycon.prepareStatement(query1);
			
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,activitybean.getExtracurricularactivityid());
			settingsprepared.setString(3, activitybean.getAction());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5, "A"); 
		    result = settingsprepared.executeUpdate();
	}
	else
	{
		
		result=1000;
	}
	}
	catch(Exception exception) { 
		log.error(exception);			
	}
	finally
	{
		if(settingsprepared != null)
			settingsprepared.close();
		
		if(Extracurricularactivitycon != null)
			Extracurricularactivitycon.close();
		
		if(activityprepared != null) 
			activityprepared.close(); 
		
		if(rs1 != null)
			rs1.close();
	}
	return result;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/Extracurricularactivity/ExtracurricularactivityEditUpdate.jsp
 * update  extracurricularactivity details  - prasanth
   @param  extracurricularactivityid that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param extracurricularactivityname that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param description that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param dateofcreation that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param createdby that can be updated to extracurricularactivity table  by extracurricularactivityid wise
   *
   @param extracurricularactivitystatus  that can be updated to extracurricularactivity table  by extracurricularactivityid wise  
   *          
  @return  the int for   printed the result on the screen 
*/

public int ExtracurricularactivityStatusUpdate(ExtracurricularactivityBean activitybean)  throws SQLException
{
	PreparedStatement settingsprepared  = null;
	PreparedStatement activityprepared = null;
	ResultSet rs1						= null;

	int result=0;
	
	try
	{
		log.info("invoking Update extracurricularactivity  from com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry");
		Extracurricularactivitycon = ConnectionManager.getKycConnection();
			
	         String query="update extracurricularactivity set  dateofcreation=?,createdby=? ,extracurricularstatus=? where extracurricularactivityid=? ";
			settingsprepared = Extracurricularactivitycon.prepareStatement(query);
		
			settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(2, activitybean.getCreatedby());
			settingsprepared.setString(3, activitybean.getExtracurricularstatus());
			settingsprepared.setString(4,activitybean.getExtracurricularactivityid());
			result = settingsprepared.executeUpdate();
			

			long l1 = common_data_object.fmaxId("select max(extracurricularactivitylogid)from extracurricularactivitylog");
			String query1="insert into extracurricularactivitylog (extracurricularactivitylogid,extracurricularactivityid,action,dateofcreation,status) values(?,?,?,?,?)";
			settingsprepared = Extracurricularactivitycon.prepareStatement(query1);
			
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,activitybean.getExtracurricularactivityid());
			settingsprepared.setString(3, activitybean.getAction());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5, "A"); 
		    result = settingsprepared.executeUpdate();
	
	}
	catch(Exception exception) { 
		log.error(exception);			
	}
	finally
	{
		if(settingsprepared != null)
			settingsprepared.close();
		
		if(Extracurricularactivitycon != null)
			Extracurricularactivitycon.close();
		
		if(activityprepared != null) 
			activityprepared.close(); 
		
		if(rs1 != null)
			rs1.close();
	}
	return result;
}
    
    DateTime date_object;
    Connection Extracurricularactivitycon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}