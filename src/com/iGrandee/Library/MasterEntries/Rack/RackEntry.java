package com.iGrandee.Library.MasterEntries.Rack;
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

public class RackEntry
{
	static Logger log = Logger.getLogger(RackEntry.class);

    public RackEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        rackconnection      = null;


        select_query = null;
    }
    /**
     * This method is accessed from kycportal/jsp/masterentries/Rack/RackSubmit.jsp
 	  * insert racks details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  rackid   that can be inserted to rack table
 	  * 
 	  @param rackname that can be inserted to rack table
 	  *
 	  @param description that can be inserted to rack table
 	  *
 	  @param dateofcreation that can be inserted to rack table
 	  *
 	  @param createdby that can be inserted to rack table
 	  *
      @param instituteid that can be inserted to rack table
      *
 	  @param ipaddress that can be inserted to rack table
 	  *
 	  @param status that can be inserted to rack table  
 	  *     
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int insertRack(RackBean rackbean)throws SQLException
    {
		int result=0;
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

        try
    	{
	    	log.info("invoking insert Rack from com.iGrandee.MasterEntries.Rack.RackEntry");
	    	rackconnection = ConnectionManager.getKycConnection();
	
    	 String str			= "select rackid,rackname from rack where rackname=? and instituteid=? and rackstatus <> ? ";
    	 settingsprepared	= rackconnection.prepareStatement(str);
    	 settingsprepared.setString(1,rackbean.getRackname().toLowerCase());
    	 settingsprepared.setString(2, rackbean.getInstituteid());
    	 settingsprepared.setString(3, "X");
         rs1	= settingsprepared.executeQuery(); 
         if(!rs1.next())
         {
        long l = common_data_object.fmaxId("select max(rackid)from rack");
		String query="insert into rack (rackid,rackname,description,dateofcreation,createdby,instituteid,ipaddress,rackstatus) values(?,?,?,?,?,?,?,?)";
		settingsprepared = rackconnection.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,rackbean.getRackname());
		settingsprepared.setString(3,rackbean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, rackbean.getCreatedby());
		settingsprepared.setString(6, rackbean.getInstituteid());
		settingsprepared.setString(7, rackbean.getIpaddress());
		settingsprepared.setString(8, "A");
		result = settingsprepared.executeUpdate();
		
		    long l1 = common_data_object.fmaxId("select max(racklogid)from racklog");
			String query_log="insert into racklog (racklogid,rackid,logstatus,dateofcreation,createdby,racklogstatus) values(?,?,?,?,?,?)";
			instituteprepared = rackconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setLong(2,l);
			instituteprepared.setString(3,rackbean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, rackbean.getCreatedby());
			instituteprepared.setString(6, rackbean.getRacklogstatus());
		
			result = instituteprepared.executeUpdate();
		
             }
             else
             {
            	 result=1000;
             }
			
			}catch(Exception exception)
			{ 
				log.error(exception);	
			}
			finally 
			{
				if(settingsprepared != null)
					settingsprepared.close();
				
				if(instituteprepared!=null)
					instituteprepared.close();
				
				if(rackconnection != null)
					rackconnection.close();
				
				if(rs1!=null)
				rs1.close();
			}
    return result;
}
    
    /**
     * This method is accessed from kycportal/jsp/masterentries/Rack/RackList.jsp
     * get details for updation - prasanth
    
     @param  instituteid  that can be get rackid,rackname and description by institute wise from rack table
     * 
     @param  status   that can be get rackid,rackname and description by status wise from rack table
     *
     @return  the ArrayList for    printed the result on the screen 
    */
public ArrayList get_All_Rack(String instituteid,String status)
{
		ArrayList list=null;
	
		
		try
		{
        	log.info("invoking get All Rack Active List from com.iGrandee.MasterEntries.Rack.RackEntry");

			select_query="select rackid,rackname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,rackstatus from rack where instituteid='"+instituteid+"' and rackstatus='"+status+"' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/Rack/RackUpdateByClick.jsp
 * get details for updation - prasanth
 @param  rackid   that can be get rackid,rackname and description from rack table
 *  
 @param  instituteid  that can be get rackid,rackname and description by institute wise from rack table
 * 
 @param  status   that can be get rackid,rackname and description by status wise from rack table
 *
 @return  the ArrayList for    printed the result on the screen 
*/
public ArrayList getDetailsForuadate(String rackid,String status,String instituteid)
{
		ArrayList list=null;
	
		
		try
		{
        	log.info("invoking get All Rack Active List from com.iGrandee.MasterEntries.Rack.RackEntry");

			select_query="select rackid,rackname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,rackstatus from rack where rackid='"+rackid+"' and rackstatus='"+status+"' and instituteid='"+instituteid+"' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/Rack/RackEditUpdate.jsp
 * update  rack details  - prasanth
   @param  rackid that can be updated to rack table  by rackid wise
   *
   @param rackname that can be updated to rack table  by rackid wise
   *
   @param description that can be updated to rack table  by rackid wise
   *
   @param dateofcreation that can be updated to rack table  by rackid wise
   *
   @param createdby that can be updated to rack table  by rackid wise
   *
   @param instituteid that can be updated to rack table  by rackid wise
   *
   @param ipaddress that can be updated to rack table  by rackid wise
   *
   @param rackstatus  that can be updated to rack table  by rackid wise  
   *          
  @return  the int for   printed the result on the screen 
*/
public int UpdateEdittRack(RackBean rackbean)  throws SQLException
{
	PreparedStatement settingsprepared  = null;
	PreparedStatement instituteprepared = null;
	ResultSet rs1						= null;

	int result=0;
	
	try
	{
		log.info("invoking Update Rack  from com.iGrandee.MasterEntries.Rack.RackEntry");
			rackconnection = ConnectionManager.getKycConnection();
      
			String str			= "select rackname from rack where rackname=? and rackid<>? and instituteid=? and rackstatus <> ?";
            instituteprepared	= rackconnection.prepareStatement(str);
            instituteprepared.setString(1, rackbean.getRackname().toLowerCase());
            instituteprepared.setString(2, rackbean.getRackid());
            instituteprepared.setString(3,rackbean.getInstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
	            
            if(!rs1.next())
            {
	         String query="update rack set rackname=?, dateofcreation=?,description=?,ipaddress=?,createdby=?,instituteid=?  where rackid=? ";
			settingsprepared = rackconnection.prepareStatement(query);
		
			settingsprepared.setString(1, rackbean.getRackname());
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,rackbean.getDescription());
			settingsprepared.setString(4, rackbean.getIpaddress());
			settingsprepared.setString(5, rackbean.getCreatedby());
			settingsprepared.setString(6, rackbean.getInstituteid());
			settingsprepared.setString(7,rackbean.getRackid());
			result = settingsprepared.executeUpdate();
			

		    long l1 = common_data_object.fmaxId("select max(racklogid)from racklog");
			String query_log="insert into racklog (racklogid,rackid,logstatus,dateofcreation,createdby,racklogstatus) values(?,?,?,?,?,?)";
			instituteprepared = rackconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setString(2,rackbean.getRackid());
			instituteprepared.setString(3,rackbean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, rackbean.getCreatedby());
			instituteprepared.setString(6, rackbean.getRacklogstatus());
			result = instituteprepared.executeUpdate();
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
		
		if(instituteprepared!=null)
			instituteprepared.close();
		
		if(rackconnection != null)
			rackconnection.close();
		
		if(rs1!=null)
		rs1.close();
	}
	return result;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/Rack/RackStatusUpdate.jsp
 * update  rack details  - prasanth
   @param  rackid that can be updated to rack table  by rackid wise
   *
   @param rackname that can be updated to rack table  by rackid wise
   *
   @param description that can be updated to rack table  by rackid wise
   *
   @param dateofcreation that can be updated to rack table  by rackid wise
   *
   @param createdby that can be updated to rack table  by rackid wise
   *
   @param instituteid that can be updated to rack table  by rackid wise
   *
   @param ipaddress that can be updated to rack table  by rackid wise
   *
   @param rackstatus  that can be updated to rack table  by rackid wise  
   *          
  @return  the int for   printed the result on the screen 
*/
public int RackStatusUpdate(RackBean rackbean)  throws SQLException
{
	PreparedStatement settingsprepared  = null;
	PreparedStatement instituteprepared = null;
	ResultSet rs1						= null;

	int result=0;
	
	try
	{
		log.info("invoking Update Rack  from com.iGrandee.MasterEntries.Rack.RackEntry");
			rackconnection = ConnectionManager.getKycConnection();
      
		
	        String query="update rack set  dateofcreation=?,ipaddress=?,createdby=?,instituteid=?,rackstatus=?  where rackid=? ";
			settingsprepared = rackconnection.prepareStatement(query);
		
			settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(2, rackbean.getIpaddress());
			settingsprepared.setString(3, rackbean.getCreatedby());
			settingsprepared.setString(4, rackbean.getInstituteid());
			settingsprepared.setString(5,rackbean.getRackstatus());
			settingsprepared.setString(6,rackbean.getRackid());
			result = settingsprepared.executeUpdate();
			System.out.println(settingsprepared);

		   long l1 = common_data_object.fmaxId("select max(racklogid)from racklog");
			String query_log="insert into racklog (racklogid,rackid,logstatus,dateofcreation,createdby,racklogstatus) values(?,?,?,?,?,?)";
			instituteprepared = rackconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setString(2,rackbean.getRackid());
			instituteprepared.setString(3,rackbean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, rackbean.getCreatedby());
			instituteprepared.setString(6, rackbean.getRacklogstatus());
			result = instituteprepared.executeUpdate();

	}
	catch(Exception exception) { 
		log.error(exception);			
	}
	finally
	{
		if(settingsprepared != null)
			settingsprepared.close();
		
		if(instituteprepared!=null)
			instituteprepared.close();
		
		if(rackconnection != null)
			rackconnection.close();
		
		if(rs1!=null)
		rs1.close();
	}
	return result;
}

/**
 * This method is accessed from kycportal/jsp/masterentries/department/DepartmentTrashPriview.jsp
 * check No of  Staff in this Department present or not - prasanth
 @param  instituteid   that can be check check No of  Staff in this Department present or not 
 *               
 @return  the String for    printed the result on the screen 
*/
public String checkTrashRacks(String rackid)
{
	String count	= null;
	try
	{
		log.info("invoking checkTrashRacks from com.iGrandee.MasterEntries.Rack.RackEntry");
		select_query	= "select count(rackid) as rackcount from bookmaster b where b.rackid='"+rackid+"' and b.bookmasterstatus='A'";
		count			= common_data_object.getString(select_query);
	}
	catch(Exception exception)
	{
		log.error(exception);
	}
	return count;
}

    DateTime date_object;
    Connection rackconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}