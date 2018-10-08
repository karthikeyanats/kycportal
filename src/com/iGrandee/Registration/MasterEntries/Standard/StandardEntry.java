package com.iGrandee.Registration.MasterEntries.Standard;
import java.sql.PreparedStatement;

import com.iGrandee.Registration.MasterEntries.Standard.StandardBean;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
public class StandardEntry
{

    public StandardEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        instituteBean = new StandardBean();
        instituteconn      = null;


        select_query = null;
    }

    public int insertstandards()throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

        try
    	{//standardid, standardname, description, instituteid, groupstatus, createdby, dateofcreation, ipaddress, standardstatus, boardid

        instituteconn = ConnectionManager.getKycConnection();
		long l = common_data_object.fmaxId("select max(standardid)from standard");
		String query="insert into standard (standardid,standardname,description,dateofcreation,createdby,instituteid,ipaddress,standardstatus,boardid,groupstatus) values(?,?,?,?,?,?,?,?,?)";
		settingsprepared = instituteconn.prepareStatement(query);
		
		
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,instituteBean.getstandardname());
		settingsprepared.setString(3,instituteBean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, instituteBean.getCreatedBy());
		settingsprepared.setString(6, instituteBean.getinstituteid());
		settingsprepared.setString(7, instituteBean.getIpaddess());
		settingsprepared.setString(8, "A");
		settingsprepared.setLong(9,l);
		settingsprepared.setString(10, "A");



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
    public int insertstandardsLogs()throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

        try
    	{
        instituteconn = ConnectionManager.getKycConnection();
		long l = common_data_object.fmaxId("select max(standardlogid)from standardlog");
		String query="insert into standardlog (standardlogid,standardid,logstandardstatus,dateofcreation,deptlogstandardstatus,createdby) values(?,?,?,?,?,?)";
        System.out.println("********"+l+"******"+instituteBean.getstandardid());

		settingsprepared = instituteconn.prepareStatement(query);
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,instituteBean.getstandardid());
		//settingsprepared.setString(3,instituteBean.getlogstandardstatus());
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
    public ArrayList checkdeactive()
    {
		ArrayList list=null;
    	String standardid=instituteBean.getstandardid();

		try
		{
			select_query="select standardlogid,standardid,logstandardstatus from standardlog where standardid='"+standardid+"' ";
System.out.println("select_query********"+select_query);
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
	}
    public int ChangeAllstandardstatus()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	
    	try
    	{

            instituteconn = ConnectionManager.getKycConnection();

			String query="update standard set standardstatus=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?";
			settingsprepared = instituteconn.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, instituteBean.getIpaddess());
			settingsprepared.setString(4, instituteBean.getCreatedBy());
			settingsprepared.setString(5, instituteBean.getinstituteid());


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
    public ArrayList get_All_standards()
    {
		ArrayList list=null;
	
		
		try
		{//standardid, standardname, description, instituteid, createdby, dateofcreation, ipaddress, standardstatus, boardid
			select_query="select standardid,instituteid,standardname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,standardstatus,boardid from standard where standardstatus='A'";

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
    public int Updatetashstandards() throws SQLException
    {
    	String standardstatus=instituteBean.getstandardstatus();
    	String standardid=instituteBean.getstandardid();
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

		
    	int rs=0;
    	try
    	{
            instituteconn = ConnectionManager.getKycConnection();

    	//standardid, standardname, description, instituteid, createdby, dateofcreation, ipaddress, standardstatus, boardid		
            
        	String query="update standard set standardstatus=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=? where standardid=?";
			settingsprepared = instituteconn.prepareStatement(query);
			settingsprepared.setString(1, standardstatus);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, instituteBean.getIpaddess());
			settingsprepared.setString(4, instituteBean.getCreatedBy());
			settingsprepared.setString(5, instituteBean.getinstituteid());
			settingsprepared.setString(6,standardid);
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
    public ArrayList get_All_standardTrashList()
    {
		ArrayList list=null;
		try
		{
			select_query="select standardid,instituteid,standardname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,standardstatus from standard where standardstatus='T'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
	}
    public ArrayList get_All_standardDeactivateList()
    {
		ArrayList list=null;
		try
		{
			select_query="select standardid,instituteid,standardname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,standardstatus from standard where standardstatus='D'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
	}
    public int Deletestandards()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	
    	try
    	{
        	String standardid=instituteBean.getstandardid();

            instituteconn = ConnectionManager.getKycConnection();

			String query="update standard set standardstatus=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where standardid=? ";
			settingsprepared = instituteconn.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, instituteBean.getIpaddess());
			settingsprepared.setString(4, instituteBean.getCreatedBy());
			settingsprepared.setString(5, instituteBean.getinstituteid());
			settingsprepared.setString(6,standardid);
			
			rs = settingsprepared.executeUpdate();



    		
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
    public int standardsDeactivate()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	
    	try
    	{
        	String standardid=instituteBean.getstandardid();

            instituteconn = ConnectionManager.getKycConnection();

			String query="update standard set standardstatus=? ,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where standardid=? ";
			settingsprepared = instituteconn.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, instituteBean.getIpaddess());
			settingsprepared.setString(4, instituteBean.getCreatedBy());
			settingsprepared.setString(5, instituteBean.getinstituteid());
			settingsprepared.setString(6,standardid);
			rs = settingsprepared.executeUpdate();



    		
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
    public int UpdateEdittstandards()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	
    	try
    	{
        	String deptname=instituteBean.getstandardname();
        	String standardid=instituteBean.getstandardid();
        	String deptdesi=instituteBean.getDescription();
    		
//System.out.println(deptname+standardid+deptdesi);
            instituteconn = ConnectionManager.getKycConnection();

			String query="update standard set standardname=?, dateofcreation=?,description=?,ipaddress=?,createdby=?,instituteid=?  where standardid=? ";
			settingsprepared = instituteconn.prepareStatement(query);
			
			settingsprepared.setString(1, deptname);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,deptdesi);
			settingsprepared.setString(4, instituteBean.getIpaddess());
			settingsprepared.setString(5, instituteBean.getCreatedBy());
			settingsprepared.setString(6, instituteBean.getinstituteid());
			settingsprepared.setString(7,standardid);


			rs = settingsprepared.executeUpdate();



    		
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
    public int Restorestandards() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	
		
    	try
    	{
        	String standardid=instituteBean.getstandardid();
            instituteconn = ConnectionManager.getKycConnection();

    			String query="update standard set standardstatus=?, dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where standardid=? ";
    			settingsprepared = instituteconn.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, instituteBean.getIpaddess());
    			settingsprepared.setString(4, instituteBean.getCreatedBy());
    			settingsprepared.setString(5, instituteBean.getinstituteid());
    			settingsprepared.setString(6,standardid);

    		
    			rs = settingsprepared.executeUpdate();

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
    public int Activestandards() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	
		
    	try
    	{
        	String standardid=instituteBean.getstandardid();
            instituteconn = ConnectionManager.getKycConnection();

    			String query="update standard set standardstatus=?, dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where standardid=? ";
    			settingsprepared = instituteconn.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, instituteBean.getIpaddess());
    			settingsprepared.setString(4, instituteBean.getCreatedBy());
    			settingsprepared.setString(5, instituteBean.getinstituteid());
    			settingsprepared.setString(6,standardid);

    		
    			rs = settingsprepared.executeUpdate();

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
   
    DateTime date_object;
    Connection instituteconn;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    StandardBean instituteBean;
    String select_query;
    Statement stmt;
    ResultSet rs;
}