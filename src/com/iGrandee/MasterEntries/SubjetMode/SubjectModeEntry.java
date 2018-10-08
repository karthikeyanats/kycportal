package com.iGrandee.MasterEntries.SubjetMode;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.iGrandee.MasterEntries.SubjetMode.SubjectModeBean;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import org.apache.log4j.Logger;

public class SubjectModeEntry
{
	static Logger log = Logger.getLogger(SubjectModeEntry.class);

    public SubjectModeEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        sectioncon      = null;
        select_query = null;
    }
    public int insertSubjectMode(SubjectModeBean subjectmodebean)throws SQLException
    {
		int result=0;
		int rs2=0;
    	PreparedStatement settingsprepared  = null;
		PreparedStatement settingsprepared_log = null;
		PreparedStatement settingsprepared_duplicate = null;
		ResultSet rs1						= null;
		
        try
    	{
        	log.info("invoking insert Subject Mode from com.iGrandee.MasterEntries.SubjectMode.SubjectModeEntry");
        	sectioncon = ConnectionManager.getKycConnection();
		
        
		  String strs			= "select subjectmodeid,subjectmodename from subjectmode where subjectmodename=?  and subjectmodestatus <> ? ";
		  settingsprepared_duplicate	= sectioncon.prepareStatement(strs);
	      settingsprepared_duplicate.setString(1, subjectmodebean.getSubjectmodename().toLowerCase());
	      settingsprepared_duplicate.setString(2, "X");
	      rs1	= settingsprepared_duplicate.executeQuery(); 
	   
	      if(!rs1.next())
	      {
        	
        long l = common_data_object.fmaxId("select max(subjectmodeid)from subjectmode");
		String query="insert into subjectmode (subjectmodeid,subjectmodename,description,createdby,dateofcreation,subjectmodestatus) values(?,?,?,?,?,?)";
		settingsprepared = sectioncon.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,subjectmodebean.getSubjectmodename());
		settingsprepared.setString(3,subjectmodebean.getDescription());
		settingsprepared.setString(4, subjectmodebean.getCreatedby());
		settingsprepared.setString(5, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(6, subjectmodebean.getSubjectmodestatus());
		result = settingsprepared.executeUpdate();
		
		long l1 = common_data_object.fmaxId("select max(subjectmodelogid)from subjectmodelog");
		String str="insert into subjectmodelog (subjectmodelogid,subjectmodeid,logdetails,createdby,dateofcreation,subjectmodelogstatus) values(?,?,?,?,?,?)";
		settingsprepared_log = sectioncon.prepareStatement(str); 
		
		settingsprepared_log.setLong(1, l1);
		settingsprepared_log.setLong(2,l);
		settingsprepared_log.setString(3,subjectmodebean.getLogdetails());
		settingsprepared_log.setString(4, subjectmodebean.getCreatedby());
		settingsprepared_log.setString(5, DateTime.showTime("MySqlWithTime"));
		settingsprepared_log.setString(6, subjectmodebean.getSubjectmodelogstatus());
		rs2 = settingsprepared_log.executeUpdate();
		
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
				
				if(settingsprepared_log!=null)
					settingsprepared_log.close();
				
				if(settingsprepared_duplicate!=null)
					settingsprepared_duplicate.close();
				
				if(sectioncon!=null)
					sectioncon.close();
				
				if(rs1!=null)
				rs1.close();
				
			}
    return result;
}
    
    public ArrayList get_All_SubjectModes()
    {
		ArrayList list=null;
	
		
		try
		{
        	log.info("invoking get All  Subject Mode from com.iGrandee.MasterEntries.SubjectMode.SubjectModeEntry");

			select_query="select subjectmodeid,subjectmodename,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates from subjectmode where subjectmodestatus='A' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
			
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
	    } 
    public ArrayList get_SubjectModes_Update(String subjectmodeid)
    {
		ArrayList list=null;
	
		
		try
		{
        	log.info("invoking get   Subject Mode from com.iGrandee.MasterEntries.SubjectMode.SubjectModeEntry");

			select_query="select subjectmodeid,subjectmodename,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates from subjectmode where subjectmodeid='"+subjectmodeid+"' and subjectmodestatus='A' ";

			list=common_data_object.getListMap(select_query);
			
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
	    } 
    public int UpdateEditSubjectMode(SubjectModeBean subjectmodebean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		ResultSet rs1						= null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{
    		log.info("invoking Update Edit Subject Modes from com.iGrandee.MasterEntries.SubjectMode.SubjectModeEntry");
				String query="update subjectmode set subjectmodename=?, dateofcreation=?,description=?,createdby=?  where subjectmodeid=? ";
				settingsprepared = sectioncon.prepareStatement(query);
				settingsprepared.setString(1, subjectmodebean.getSubjectmodename());
				settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
				settingsprepared.setString(3,subjectmodebean.getDescription());
				settingsprepared.setString(4, subjectmodebean.getCreatedby());
				settingsprepared.setString(5,subjectmodebean.getSubjectmodeid());
				rs = settingsprepared.executeUpdate();
				
	
    	}
    	catch(Exception exception) { 
    		log.error(exception);			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(rs1!=null)
			rs1.close();
		}
    	return rs;
    }

DateTime date_object;
Connection sectioncon;
CommonDataAccess common_data_object;
ConnectionManager connectionManager;
String select_query;
Statement stmt;
ResultSet rs;
}