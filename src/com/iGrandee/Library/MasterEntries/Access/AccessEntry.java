package com.iGrandee.Library.MasterEntries.Access;
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

public class AccessEntry
{
	static Logger log = Logger.getLogger(AccessEntry.class);

    public AccessEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        accessconnection      = null;


        select_query = null;
    }
    /**
     * This method is accessed from kycportal/jsp/masterentries/Access/AccessSubmit.jsp
 	  * insert access details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  accessid   that can be inserted to rolewiseaccess table
 	  * 
 	  @param roleid that can be inserted to rolewiseaccess table
 	  *
 	  @param renewdays that can be inserted to rolewiseaccess table
 	  *
 	  @param renewcount that can be inserted to rolewiseaccess table
 	  *
 	  @param fineperday that can be inserted to rolewiseaccess table
 	  *
      @param noofbooks that can be inserted to rolewiseaccess table
      *
 	  @param instituteid that can be inserted to rolewiseaccess table
 	  *
 	  @param createdby that can be inserted to rolewiseaccess table
 	  *
 	  @param dateofcreation that can be inserted to rolewiseaccess table
 	  *
 	  @param accessstatus that can be inserted to rolewiseaccess table
 	  *
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int insertAccess(AccessBean accessbean)throws SQLException
    {
		int result=0;
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

        try
    	{
	    	log.info("invoking insert Access from com.iGrandee.MasterEntries.Access.AccessEntry");
	    	accessconnection = ConnectionManager.getKycConnection();
	
        long l = common_data_object.fmaxId("select max(accessid)from rolewiseaccess");
		String query="insert into rolewiseaccess (accessid,roleid,renewdays,returndays,renewcount,fineperday,noofbooks,instituteid,createdby,dateofcreation,accessstatus,usercategory) values(?,?,?,?,?,?,?,?,?,?,?,?)";
		settingsprepared = accessconnection.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,accessbean.getRoleid());
		settingsprepared.setString(3,accessbean.getRenewdays());
		settingsprepared.setString(4,accessbean.getReturndays());
		settingsprepared.setString(5,accessbean.getRenewcount());
		settingsprepared.setString(6,accessbean.getFineperday());
		settingsprepared.setString(7,accessbean.getNoofbooks());
		settingsprepared.setString(8, accessbean.getInstituteid());
		settingsprepared.setString(9, accessbean.getCreatedby());
		settingsprepared.setString(10, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(11, accessbean.getAccessstatus());
		settingsprepared.setString(12, accessbean.getUsercategory());
		result = settingsprepared.executeUpdate();
	   
		long l1 = common_data_object.fmaxId("select max(accesslogid)from rolewiseaccesslog");
		String query_log="insert into rolewiseaccesslog (rolewiseaccesslogid,rolewiseaccessid,logstatus,dateofcreation,createdby,accesslogstatus) values(?,?,?,?,?,?)";
		instituteprepared = accessconnection.prepareStatement(query_log);
		
		instituteprepared.setLong(1, l1);
		instituteprepared.setLong(2,l);
		instituteprepared.setString(3,accessbean.getLogstatus());
		instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		instituteprepared.setString(5, accessbean.getCreatedby());
		instituteprepared.setString(6, accessbean.getAccesslogstatus());
	
		result = instituteprepared.executeUpdate();
		
			}
        	catch(Exception exception)
			{ 
				log.error(exception);	
			} 
			finally 
			{
				if(rs1!=null)
					rs1.close();
				
				if(settingsprepared != null)
					settingsprepared.close();
				
				if(instituteprepared!=null)
					instituteprepared.close();
				
				if(accessconnection != null)
					accessconnection.close();
				
			
			}
    return result;
}
    /**
     * This method is accessed from kycportal/jsp/masterentries/Access/AccessList.jsp
 	  * get rolewise wise access lists  - prasanth
      * Returns an ArrayList  by which result can be printed on the screen. 
 	  @param  instituteid   that can be used to get access details from rolewiseacess table
 	  * 
 	  @param  status that can be used to specify the status of rolewiseacess table
 	  * 
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public ArrayList get_All_AccessList(String instituteid,String status)
    {
    		ArrayList list=null;
    	
    		
    		try
    		{
            	log.info("invoking get All Acess Active List from com.iGrandee.MasterEntries.Acess.AcessEntry");
    			select_query="select a.accessid,a.roleid,a.renewdays,a.returndays,a.renewcount,a.fineperday,a.noofbooks,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates,a.accessstatus,b.rolename from rolewiseaccess a,role b where a.instituteid='"+instituteid+"' and a.accessstatus='"+status+"' and a.roleid=b.roleid and a.instituteid=b.instituteid and b.status='A' order by a.dateofcreation desc";
    			list=common_data_object.getListMap(select_query);
    		}
    		catch(Exception exception)
    		{ 	
    			log.error(exception);				
    		}  
    	    	
    	    	return list;
    }    

    /**
     * This method is accessed from kycportal/jsp/masterentries/Access/AccessEntry.jsp
 	  * insert racks details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 
 	  @param  instituteid   that can be used to get role name,role id from role table
 	  * 
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public ArrayList get_All_Role(String instituteid)
    {
    		ArrayList list=null;
    	
    		
    		try
    		{
            	log.info("invoking get All Acess Active List from com.iGrandee.MasterEntries.Acess.AcessEntry");

    			select_query="select a.roleid,a.rolename from role a where a.roleid not in (select b.roleid from rolewiseaccess b where b.instituteid=a.instituteid and b.accessstatus <> 'X') and a.instituteid='"+instituteid+"' and a.status='A';";
    			list=common_data_object.getListMap(select_query);
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    return list;
    }
    /**
     * This method is accessed from kycportal/jsp/masterentries/Access/AcessUpdateByClick.jsp
 	  * get particular access details  by accessid wise - prasanth
 	  @param  instituteid   that can be used to get role name,role id from role table
 	  * 
 	  @param  status   that can be used to specify rolewiseaccess  status from rolewiseaccess table
 	  *
 	  @param  instituteid   that can be used to get access details from rolewiseaccess table
 	  *
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public ArrayList get_Access_detail(String instituteid,String status,String accessid)
    {
    		ArrayList list=null; 
    	
    		
    		try
    		{
            	log.info("invoking get All Acess Active List from com.iGrandee.MasterEntries.Acess.AcessEntry");

    			select_query="select a.accessid,a.renewdays,a.returndays,a.renewcount,a.fineperday,a.noofbooks,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates,a.accessstatus,b.rolename from rolewiseaccess a,role b where a.accessid='"+accessid+"' and a.roleid=b.roleid and a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and accessstatus='"+status+"' and b.status='A' ";
    			list=common_data_object.getListMap(select_query);
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    	return list;
    }
    /**
     * This method is accessed from kycportal/jsp/masterentries/Access/AccessEditUpdate.jsp
 	  * update access details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	 @param  accessid   that can be update to rolewiseaccess table
 	  * 
 	  @param roleid that can be update to rolewiseaccess table
 	  *
 	  @param renewdays that can be update to rolewiseaccess table
 	  *
 	  @param renewcount that can be update to rolewiseaccess table
 	  *
 	  @param fineperday that can be update to rolewiseaccess table
 	  *
      @param noofbooks that can be update to rolewiseaccess table
      *
 	  @param instituteid that can be update to rolewiseaccess table
 	  *
 	  @param createdby that can be update to rolewiseaccess table
 	  *
 	  @param dateofcreation that can be update to rolewiseaccess table
 	  *
 	  @param accessstatus that can be update to rolewiseaccess table
 	  *
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int UpdateEditAccess(AccessBean accessbean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
    	PreparedStatement instituteprepared = null;
    	ResultSet rs1						= null;

    	int result=0;
    	 
    	try
    	{
    		log.info("invoking Update Access  from com.iGrandee.MasterEntries.Access.AccessEntry");
    		accessconnection = ConnectionManager.getKycConnection();
          
    		
    	         String query="update rolewiseaccess set renewdays=?, returndays=?,renewcount=?,fineperday=?,noofbooks=?,instituteid=?,createdby=?,dateofcreation=?  where accessid=? ";
    			settingsprepared = accessconnection.prepareStatement(query);
    		
    			settingsprepared.setString(1, accessbean.getRenewdays());
    			settingsprepared.setString(2, accessbean.getReturndays());
    			settingsprepared.setString(3,accessbean.getRenewcount());
    			settingsprepared.setString(4, accessbean.getFineperday());
    			settingsprepared.setString(5, accessbean.getNoofbooks());
    			settingsprepared.setString(6, accessbean.getInstituteid());
    			settingsprepared.setString(7,accessbean.getCreatedby());
    			settingsprepared.setString(8, DateTime.showTime("MySqlWithTime"));	
    			settingsprepared.setString(9,accessbean.getAccessid());
    			result = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(accesslogid)from accesslog");
    			String query_log="insert into rolewiseaccesslog (rolewiseaccesslogid,rolewiseaccessid,logstatus,dateofcreation,createdby,accesslogstatus) values(?,?,?,?,?,?)";
    			instituteprepared = accessconnection.prepareStatement(query_log);
    			
    			instituteprepared.setLong(1, l1);
    			instituteprepared.setString(2,accessbean.getAccessid());
    			instituteprepared.setString(3,accessbean.getLogstatus());
    			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			instituteprepared.setString(5, accessbean.getCreatedby());
    			instituteprepared.setString(6, accessbean.getAccesslogstatus());
    		
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
    		
    		if(accessconnection != null)
    			accessconnection.close();
    		
    		if(rs1!=null)
    		rs1.close();
    	}
    	return result;
    }
    /**
     * This method is accessed from kycportal/jsp/masterentries/Access/RackStatusUpdate.jsp
 	  * update access details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	 @param  accessid   that can be update to rolewiseaccess table
 	  * 
 	  @param roleid that can be update to rolewiseaccess table
 	  *
 	  @param renewdays that can be update to rolewiseaccess table
 	  *
 	  @param renewcount that can be update to rolewiseaccess table
 	  *
 	  @param fineperday that can be update to rolewiseaccess table
 	  *
      @param noofbooks that can be update to rolewiseaccess table
      *
 	  @param instituteid that can be update to rolewiseaccess table
 	  *
 	  @param createdby that can be update to rolewiseaccess table
 	  *
 	  @param dateofcreation that can be update to rolewiseaccess table
 	  *
 	  @param accessstatus that can be update to rolewiseaccess table
 	  *
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int StatusUpdateAccess(AccessBean accessbean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
    	PreparedStatement instituteprepared = null;
    	ResultSet rs1						= null;

    	int result=0;
    	 
    	try
    	{
    		log.info("invoking Update Access  from com.iGrandee.MasterEntries.Access.AccessEntry");
    		accessconnection = ConnectionManager.getKycConnection();
          
    		
    	         String query="update rolewiseaccess set instituteid=?,createdby=?,dateofcreation=? ,accessstatus=? where accessid=? ";
    			settingsprepared = accessconnection.prepareStatement(query);
    		
    			
    			settingsprepared.setString(1, accessbean.getInstituteid());
    			settingsprepared.setString(2,accessbean.getCreatedby());
    			settingsprepared.setString(3, DateTime.showTime("MySqlWithTime"));	
    			settingsprepared.setString(4,accessbean.getAccessstatus());
    			settingsprepared.setString(5,accessbean.getAccessid());
    			result = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(accesslogid)from accesslog");
    			String query_log="insert into rolewiseaccesslog (rolewiseaccesslogid,rolewiseaccessid,logstatus,dateofcreation,createdby,accesslogstatus) values(?,?,?,?,?,?)";
    			instituteprepared = accessconnection.prepareStatement(query_log);
    			
    			instituteprepared.setLong(1, l1);
    			instituteprepared.setString(2,accessbean.getAccessid());
    			instituteprepared.setString(3,accessbean.getLogstatus());
    			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			instituteprepared.setString(5, accessbean.getCreatedby());
    			instituteprepared.setString(6, accessbean.getAccesslogstatus());
    		
    			result = instituteprepared.executeUpdate();
    	}
    	catch(Exception exception) { 
    		log.error(exception);	
    	}
    	finally
    	{
    		if(rs1!=null)
        		rs1.close();
    		
    		if(settingsprepared != null)
    			settingsprepared.close();
    		
    		if(instituteprepared!=null)
    			instituteprepared.close();
    		
    		if(accessconnection != null)
    			accessconnection.close();
    		
    		
    	}
    	return result;
    }
    /**
     * This method is accessed from kycportal/jsp/masterentries/Access/AccessEntry.jsp
 	  * get particular Categoryname name  by roleid wise - prasanth
 	  @param  instituteid   that can be used to getCategory name from staffcategory table by institute wise
 	  * 
 	  @param  roleid   that can be used to get Category name from staffcategory table
 	  *
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public String get_All_Categoryname(String roleid,String instituteid)
    {
    		String list=null; 
    	
    		
    		try
    		{
            	log.info("invoking get All Acess Active List from com.iGrandee.MasterEntries.Acess.AcessEntry");

    			select_query="select distinct c.categoryname from role a,staffmaster b,staffcategory c where a.roleid=b.roleid and a.roleid='"+roleid+"' and a.instituteid='"+instituteid+"' and a.status='A' and b.staffcategoryid=c.staffcategoryid and a.instituteid=c.instituteid and b.staffstatus='A'  and c.staffcategorystatus='A';";
    			//System.out.print("select_query-->"+select_query);
    			list=common_data_object.getString(select_query);
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    	return list;
    }

    /**
     * This method is accessed from kycportal/jsp/masterentries/Access/AccessEntry.jsp
 	  * get particular Categoryname name  by roleid wise - prasanth
 	  @param  instituteid   that can be used to getCategory name from staffcategory table by institute wise
 	  * 
 	  @param  roleid   that can be used to get Category name from staffcategory table
 	  *
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public String get_Rolename(String roleid)
    {
    		String list=null; 
    	
    		
    		try
    		{
            	log.info("invoking get All Acess Active List from com.iGrandee.MasterEntries.Acess.AcessEntry");

    			select_query="select a.rolename from role a where a.roleid='"+roleid+"' and a.status='A'";
    			//System.out.print("select_query-->"+select_query);
    			list=common_data_object.getString(select_query);
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    	return list;
    }
    
    DateTime date_object;
    Connection accessconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}