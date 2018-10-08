package com.iGrandee.MasterEntries.Session;
import java.sql.PreparedStatement;

import com.iGrandee.MasterEntries.Session.SessionBean;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
public class SessionEntry
{
//sessionid, sessionname, instituteid, createdby, dateofcreation, ipaddress, sessionstatus
    public SessionEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        instituteconn      = null;


        select_query = null;
    }

    public int insertsessions(SessionBean instituteBean)throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 
        try
        
    	{

        instituteconn = ConnectionManager.getKycConnection();
        
		long l = common_data_object.fmaxId("select max(sessionid)from yearofsession");
		String query="insert into yearofsession (sessionid,sessionname,description,dateofcreation,createdby,instituteid,sessionstatus,ipaddress) values(?,?,?,?,?,?,?,?)";
		settingsprepared = instituteconn.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,instituteBean.getsessionname());
		settingsprepared.setString(3,instituteBean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, instituteBean.getCreatedBy());
		settingsprepared.setString(6, instituteBean.getinstituteid());
		settingsprepared.setString(7, "A");
		settingsprepared.setString(8, instituteBean.getIpaddess());

	result = settingsprepared.executeUpdate();
	
/*	long l1 = common_data_object.fmaxId("select max(yearofsessionlogid)from yearofsessionlog");
	String query1="insert into yearofsessionlog (yearofsessionlogid,sessionid,logdetails,dateofcreation,yearofsessionlogstatus,createdby) values(?,?,?,?,?,?)";

	settingsprepared = instituteconn.prepareStatement(query1);
	settingsprepared.setLong(1, l1);
	settingsprepared.setLong(2,l);
	settingsprepared.setString(3,instituteBean.getyearofsessionlogstatus());
	settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	settingsprepared.setString(5,"A");
	settingsprepared.setString(6, instituteBean.getCreatedBy());

	result = settingsprepared.executeUpdate();*/
	
    	}catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}
		
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
return result;
}
    public int insertgroupsLogs(SessionBean instituteBean)throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

        try
    	{//yearofsessionlogid, sessionid, yearofsessionlogdetail, createdby, dateofcreation, yearofsessionlogstatus
        instituteconn = ConnectionManager.getKycConnection();
		long l = common_data_object.fmaxId("select max(yearofsessionlogid)from yearofsessionlog");
		String query="insert into yearofsessionlog (yearofsessionlogid,sessionid,logsessionstatus,dateofcreation,deptlogsessionstatus,createdby) values(?,?,?,?,?,?)";
        //System.out.println("********"+l+"******"+instituteBean.getsessionid());

		settingsprepared = instituteconn.prepareStatement(query);
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,instituteBean.getsessionid());
		//settingsprepared.setString(3,instituteBean.getlogsessionstatus());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5,"A");
		settingsprepared.setLong(6, 1);
		//settingsprepared.setLong(6, instituteBean.getboardid());
		result = settingsprepared.executeUpdate();

			}catch(Exception exception) { 
				
				exception.printStackTrace();
				
			}
			finally
			{
				if(settingsprepared != null)
					settingsprepared.close();
				
				if(instituteconn != null)
					instituteconn.close();
			}
    return result;
}
    public ArrayList checkdeactive(SessionBean instituteBean)
    {
		ArrayList list=null;
    	String sessionid=instituteBean.getsessionid();

		try
		{
			select_query="select yearofsessionlogid,sessionid,yearofsessionlogdetail,yearofsessionlogstatus,createdby from yearofsessionlog where sessionid='"+sessionid+"' ";
			//System.out.println("select_query********"+select_query);
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
	}
    public int ChangeAllsessionstatus(SessionBean instituteBean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	
    	try
    	{

            instituteconn = ConnectionManager.getKycConnection();

			String query="update yearofsession set sessionstatus=?,dateofcreation=?,createdby=?,instituteid=?";
			settingsprepared = instituteconn.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, instituteBean.getCreatedBy());
			settingsprepared.setString(4, instituteBean.getinstituteid());


			rs = settingsprepared.executeUpdate();
   		
    	}
	catch(Exception exception)
	{ 
			
			exception.printStackTrace();
			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	return rs;
    }
    public ArrayList get_All_Sessions()
    {
		ArrayList list=null;
	
		
		try
		{
			select_query="select sessionid,instituteid,sessionname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,sessionstatus from yearofsession where sessionstatus='A'";

			list=common_data_object.getListMap(select_query);
			
				
		}
		catch(Exception exception)
		{ 
				
				exception.printStackTrace();
				
			}
	    	finally
			{
				
			}
	    	return list;
	    }
    public int Updatetashsession(SessionBean instituteBean) throws SQLException
    {
    	String sessionstatus=instituteBean.getsessionstatus();
    	String sessionid=instituteBean.getsessionid();
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

		
    	int rs=0;
    	int result=0;
    	try
    	{
            instituteconn = ConnectionManager.getKycConnection();

            
        	String query="update yearofsession set sessionstatus=?,dateofcreation=?,createdby=?,instituteid=?,ipaddress=? where sessionid=?";
			settingsprepared = instituteconn.prepareStatement(query);
			settingsprepared.setString(1, "T");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, instituteBean.getCreatedBy());
			settingsprepared.setString(4, instituteBean.getinstituteid());
			settingsprepared.setString(5, instituteBean.getIpaddess());
			settingsprepared.setString(6,sessionid);
			rs = settingsprepared.executeUpdate();
			
		/*	long l1 = common_data_object.fmaxId("select max(yearofsessionlogid)from yearofsessionlog");
			String query1="insert into yearofsessionlog (yearofsessionlogid,sessionid,logdetails,dateofcreation,yearofsessionlogstatus,createdby) values(?,?,?,?,?,?)";
//
			settingsprepared = instituteconn.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,sessionid);
			settingsprepared.setString(3,instituteBean.getyearofsessionlogstatus());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, instituteBean.getCreatedBy());

			result = settingsprepared.executeUpdate();*/
			
    	}
    		
			catch(Exception exception)
			{ 
					
					exception.printStackTrace();
					
				}
		    	finally
				{
					if(settingsprepared != null)
						settingsprepared.close();
					
					if(instituteconn != null)
						instituteconn.close();
				}
		    	return rs;
		    }
    public ArrayList get_All_groupTrashList()
    {
		ArrayList list=null;
		try
		{
			select_query="select sessionid,instituteid,sessionname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,sessionstatus from yearofsession where sessionstatus='T'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
	}
    public ArrayList get_All_groupDeactivateList()
    {
		ArrayList list=null;
		try
		{
			select_query="select sessionid,instituteid,sessionname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,sessionstatus from yearofsession where sessionstatus='D'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
	}
	 public ArrayList checkStandards(SessionBean instituteBean)
	    {
			String sessionid=instituteBean.getsessionid();
			
		
			ArrayList list=null;
			try
			{
				select_query="select * from standardschedule a ,yearofsession b where a.sessionid=b.sessionid and a.sessionid='"+sessionid+"'";

				list=common_data_object.getListMap(select_query);
			}
	    
 	catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}

			return list;
		}
    public int Deletegroups(SessionBean instituteBean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	int result=0;
    	try
    	{
        	String sessionid=instituteBean.getsessionid();

            instituteconn = ConnectionManager.getKycConnection();

			String query="update yearofsession set sessionstatus=?,dateofcreation=?,createdby=?,instituteid=?  where sessionid=? ";
			settingsprepared = instituteconn.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, instituteBean.getCreatedBy());
			settingsprepared.setString(4, instituteBean.getinstituteid());
			settingsprepared.setString(5,sessionid);
			
			rs = settingsprepared.executeUpdate();

			long l1 = common_data_object.fmaxId("select max(yearofsessionlogid)from yearofsessionlog");
			String query1="insert into yearofsessionlog (yearofsessionlogid,sessionid,logdetails,dateofcreation,yearofsessionlogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = instituteconn.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,sessionid);
			settingsprepared.setString(3,"X");
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, instituteBean.getCreatedBy());

			result = settingsprepared.executeUpdate();

    		
    	}
    	catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	return rs;
    }
    public int groupsDeactivate(SessionBean instituteBean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{
        	String sessionid=instituteBean.getsessionid();
        	//System.out.println("*********"+sessionid);
            instituteconn = ConnectionManager.getKycConnection();

			String query="update yearofsession set sessionstatus=? ,dateofcreation=?,createdby=?,instituteid=?  where sessionid=? ";
			settingsprepared = instituteconn.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, instituteBean.getCreatedBy());
			settingsprepared.setString(4, instituteBean.getinstituteid());
			settingsprepared.setString(5,sessionid);
			rs = settingsprepared.executeUpdate();

		/*	long l1 = common_data_object.fmaxId("select max(yearofsessionlogid)from yearofsessionlog");
			String query1="insert into yearofsessionlog (yearofsessionlogid,sessionid,logdetails,dateofcreation,yearofsessionlogstatus,createdby) values(?,?,?,?,?,?)";
System.out.println("*********"+instituteBean.getyearofsessionlogstatus());
			settingsprepared = instituteconn.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,sessionid);
			settingsprepared.setString(3,instituteBean.getyearofsessionlogstatus());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, instituteBean.getCreatedBy());

			result = settingsprepared.executeUpdate();*/

    		
    	}
    	catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	return rs;
    }
    public int UpdateEdittyearofsession(SessionBean instituteBean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	int result=0;

    	try
    	{
        	String deptname=instituteBean.getsessionid();
        	String deptdesi=instituteBean.getDescription();
    		
            instituteconn = ConnectionManager.getKycConnection();

			String query="update yearofsession set sessionname=?, dateofcreation=?,description=?,createdby=?,instituteid=?,ipaddress=?  where sessionid=? ";
			settingsprepared = instituteconn.prepareStatement(query);
			settingsprepared.setString(1, instituteBean.getsessionname());
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,deptdesi);
			settingsprepared.setString(4, instituteBean.getCreatedBy());
			settingsprepared.setString(5, instituteBean.getinstituteid());
			settingsprepared.setString(6, instituteBean.getIpaddess());
			settingsprepared.setString(7, instituteBean.getsessionid());


			rs = settingsprepared.executeUpdate();
			
		/*	long l1 = common_data_object.fmaxId("select max(yearofsessionlogid)from yearofsessionlog");
			String query1="insert into yearofsessionlog (yearofsessionlogid,sessionid,logdetails,dateofcreation,yearofsessionlogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = instituteconn.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,sessionid);
			settingsprepared.setString(3,instituteBean.getyearofsessionlogstatus());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, instituteBean.getCreatedBy());

			result = settingsprepared.executeUpdate();*/
			
			



    		
    	}
    	catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	return rs;
    }
    public int Restoreyearofsessions(SessionBean instituteBean) throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	int result=0;
		
    	try
    	{
        	String sessionid=instituteBean.getsessionid();
            instituteconn = ConnectionManager.getKycConnection();

    			String query="update yearofsession set sessionstatus=?, dateofcreation=?,createdby=?,instituteid=?,ipaddress=?  where sessionid=? ";
    			settingsprepared = instituteconn.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, instituteBean.getCreatedBy());
    			settingsprepared.setString(4, instituteBean.getinstituteid());
    			settingsprepared.setString(5, instituteBean.getinstituteid());

    			settingsprepared.setString(6,sessionid);

    			rs = settingsprepared.executeUpdate();
    			
    			/*long l1 = common_data_object.fmaxId("select max(yearofsessionlogid)from yearofsessionlog");
    			String query1="insert into yearofsessionlog (yearofsessionlogid,sessionid,logdetails,dateofcreation,yearofsessionlogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = instituteconn.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,sessionid);
    			settingsprepared.setString(3,"Restore");
    			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(5,"A");
    			settingsprepared.setString(6, instituteBean.getCreatedBy());

    			result = settingsprepared.executeUpdate();*/
    			

		}catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	return rs;
    }
    
    public int Activegroups(SessionBean instituteBean) throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	int result=0;
    	
		
    	try
    	{
        	String sessionid=instituteBean.getsessionid();
            instituteconn = ConnectionManager.getKycConnection();

    			String query="update yearofsession set sessionstatus=?, dateofcreation=?,createdby=?,instituteid=?  where sessionid=? ";
    			settingsprepared = instituteconn.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, instituteBean.getCreatedBy());
    			settingsprepared.setString(4, instituteBean.getinstituteid());
    			settingsprepared.setString(5,sessionid);

    		
    			rs = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(yearofsessionlogid)from yearofsessionlog");
    			String query1="insert into yearofsessionlog (yearofsessionlogid,sessionid,logdetails,dateofcreation,yearofsessionlogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = instituteconn.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,sessionid);
    			settingsprepared.setString(3,"Active");
    			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(5,"A");
    			settingsprepared.setString(6, instituteBean.getCreatedBy());

    			result = settingsprepared.executeUpdate();
    			

		}catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	return rs;
    }
    public boolean checkDuplicate(String tablename,String columnname,String fieldname,String instituteid)
	{
		boolean return_flag = false;
		String return_string = null;
		try
		{
			String select_query = "select "+columnname+" from "+tablename+" where "+columnname+"='"+fieldname+"' and instituteid='"+instituteid+"' ";
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
    
    DateTime date_object;
    Connection instituteconn;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}