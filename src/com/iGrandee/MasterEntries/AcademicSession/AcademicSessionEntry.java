package com.iGrandee.MasterEntries.AcademicSession;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import org.apache.log4j.Logger;

public class AcademicSessionEntry
{
	static Logger log = Logger.getLogger(AcademicSessionEntry.class);

    public AcademicSessionEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        sessioncon      = null;


        select_query = null;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionSubmit.jsp
	  * insert AcademicSession details           - prasanth
	  @param  sessionid that can be inserted to yearofsession table
	  *
	  @param sessionname that can be inserted to yearofsession table
	  *
	  @param description that can be inserted to yearofsession table
	  *
	  @param dateofcreation that can be inserted to yearofsession table
	  *
	  @param createdby that can be inserted to yearofsession table
	  *
	  @param instituteid that can be inserted to yearofsession table
	  *
	  @param sessionstatus that can be inserted to yearofsession table
	  *
	  @param ipaddress that can be inserted to yearofsession table
	  *
	  @return the integer by which result can be printed on the screen
	 */
    public int insertsessions(AcademicSessionBean sessionbean)throws SQLException
    {
    	HashMap<String,String> MonthMap=new HashMap<String,String>();
    	MonthMap.put("1", "January");MonthMap.put("2", "February");MonthMap.put("3", "March");
	MonthMap.put("4", "April");MonthMap.put("5", "May");MonthMap.put("6", "June");
	MonthMap.put("7", "July");MonthMap.put("8", "August");MonthMap.put("9", "September");
	MonthMap.put("10", "October");MonthMap.put("11", "November");MonthMap.put("12", "December");
    	//System.out.println(MonthMap.size());
    	log.info("invoking insertsessions from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

        try
        
    	{

        sessioncon = ConnectionManager.getKycConnection();
        String str			= "select sessionname from yearofsession where sessionname=?  and instituteid=? and sessionstatus<> ? ";
        instituteprepared	= sessioncon.prepareStatement(str);
        instituteprepared.setString(1, sessionbean.getsessionname().toLowerCase()); 
        instituteprepared.setString(2, sessionbean.getinstituteid());  
        instituteprepared.setString(3, "X");   
       // System.out.println(instituteprepared);
        rs1	= instituteprepared.executeQuery();
        if(!rs1.next())
        {  
		long l = common_data_object.fmaxId("select max(sessionid)from yearofsession");

		String query="insert into yearofsession (sessionid,sessionname,description,dateofcreation,createdby,instituteid,sessionstatus,ipaddress,startmonth,startyear,endmonth,endyear) values(?,?,?,?,?,?,?,?,?,?,?,?)";
		settingsprepared = sessioncon.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,sessionbean.getsessionname());
		settingsprepared.setString(3,sessionbean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, sessionbean.getCreatedBy());
		settingsprepared.setString(6, sessionbean.getinstituteid());
		settingsprepared.setString(7, "N");
		settingsprepared.setString(8, sessionbean.getIpaddess());
		
		if(MonthMap.containsKey((sessionbean.getMonthstart())))
				settingsprepared.setString(9,MonthMap.get(sessionbean.getMonthstart()));
		else
			settingsprepared.setString(9,sessionbean.getMonthstart());
		
		settingsprepared.setString(10, sessionbean.getYearstart());
		
		if(MonthMap.containsKey((sessionbean.getMonthend())))
			settingsprepared.setString(11,MonthMap.get(sessionbean.getMonthend()));
		else
		settingsprepared.setString(11,sessionbean.getMonthend());
	
		
		settingsprepared.setString(12, sessionbean.getYearend());
//System.out.println("settingsprepared"+settingsprepared);
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
			
			if(sessioncon != null)
				sessioncon.close();
			
			if(instituteprepared != null) 
				instituteprepared.close(); 
			
			if(rs1 != null)
				rs1.close();
		}
    	return result;
    	}
   
   
    /**
	   * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionList.jsp
	   * get all AcademicSession active Details          - prasanth
	   @param instituteid that can be used to get all details from  yearofsession table by instituteid wise
	   * 
	   @return the ArrayList by which result can be printed on the screen
	   
	 */
    public ArrayList get_All_AcademicSessions(String instituteid)
    {
    	log.info("invoking get_All_AcademicSessions from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
		ArrayList list=null;
	
		
		try
		{
			
			select_query="select sessionstatus,sessionid,instituteid,sessionname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,sessionstatus,startmonth,startyear,endmonth,endyear from yearofsession where instituteid='"+instituteid+"' and (sessionstatus='N' or sessionstatus='A' or sessionstatus='R') order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
			
				
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);					
			}
	    	finally
			{
				
			}
	    	return list;
	    }
    
   
    
   
    /**
	   * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionTrash.jsp
	   * change  AcademicSession status as T (Trash)           - prasanth
	   @param sessionstatus that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	   *
	   @param dateofcreation that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	   *
	   @param createdby that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	   *
	   @param instituteid that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	   *
	   @param ipaddress that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	   *
	   @return the integer by which result can be printed on the screen
	 */
    public int UpdatetashYearOfsessions(AcademicSessionBean sessionbean) throws SQLException
    {
    	String sessionid=sessionbean.getsessionid();
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

		
    	int rs=0;
    	int result=0;
    	try
    	{log.info("invoking UpdatetashYearOfsessions from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
            sessioncon = ConnectionManager.getKycConnection();

            
        	String query="update yearofsession set sessionstatus=?,dateofcreation=?,createdby=?,instituteid=?,ipaddress=? where sessionid=?";
			settingsprepared = sessioncon.prepareStatement(query);
			settingsprepared.setString(1, "T");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sessionbean.getCreatedBy());
			settingsprepared.setString(4, sessionbean.getinstituteid());
			settingsprepared.setString(5, sessionbean.getIpaddess());
			settingsprepared.setString(6,sessionid);
			rs = settingsprepared.executeUpdate();
			
		
			
    	}
    		
			catch(Exception exception)
			{ 
					
				log.error(exception);						
				}
		    	finally
				{
					if(settingsprepared != null)
						settingsprepared.close();
					
					if(sessioncon != null)
						sessioncon.close();
				}
		    	return rs;
		    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionTrashListview.jsp
	  * get all AcademicSession Trash lists          - prasanth
	  @param instituteid that can be used to get all details from  yearofsession table by instituteid wise
	  *
	  @return the ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_SessionTrashList(String instituteid)
    {
		ArrayList list=null;
		try
		{log.info("invoking get_All_SessionList from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
			select_query="select sessionid,instituteid,sessionname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,sessionstatus from yearofsession where instituteid='"+instituteid+"' and sessionstatus='T' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);	
		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionDeactiveList.jsp
	  * get all AcademicSession DeActive list         - prasanth
	  @param instituteid that can be used to get all details from  yearofsession table by instituteid wise
	  *
	  @return the ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_AcademicDeactivateList(String instituteid)
    {
		ArrayList list=null;
		try
		{log.info("invoking get_All_Session DeactivateList from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
			select_query="select sessionid,instituteid,sessionname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,sessionstatus from yearofsession where instituteid='"+instituteid+"' and sessionstatus='D' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);	
		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionTrashPriview.jsp
	  * check  standard allocated or not for AcademicSession            - prasanth
	  @param instituteid that can be used to check  standard allocated or not for AcademicSession by instituteid,sessionid wise
	  *
	  @param sessionid  that can be used to check  standard allocated or not for AcademicSession by instituteid,sessionid wise
	  *
	  @return the ArrayList by which result can be printed on the screen
	 */
    public ArrayList checkforTrashAcademicSession(String sessionid,String  instituteid)
    {
		ArrayList list=null;

		try
		{
			log.info("invoking checkforTrashAcademicSession from com.iGrandee.MasterEntries.AcademicSessionEntry");
			select_query="select b.sessionid,b.sessionname from standardschedule a,yearofsession b where a.sessionid=b.sessionid and a.stdschedulestatus='A' and a.sessionid='"+sessionid+"' and a.instituteid=b.instituteid and b.instituteid='"+instituteid+"' and (sessionstatus='A' or sessionstatus='R' or sessionstatus='N')";
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);	
		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionDelete.jsp
	  * change  AcademicSession status as X (Delete)          - prasanth
	  @param sessionstatus that can be used to update all details to  yearofsession table by instituteid,sessionid wise
	  *
	  @param dateofcreation that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param createdby that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param instituteid that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param ipaddress that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @return the int by which result can be printed on the screen
	 */
    public int DeleteSession(AcademicSessionBean sessionbean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	try
    	{
    		log.info("invoking Delete Academic Session from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
        	String sessionid=sessionbean.getsessionid();

            sessioncon = ConnectionManager.getKycConnection();

			String query="update yearofsession set sessionstatus=?,dateofcreation=?,createdby=?,instituteid=?,ipaddress=?  where sessionid=? ";
			settingsprepared = sessioncon.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sessionbean.getCreatedBy());
			settingsprepared.setString(4, sessionbean.getinstituteid());
			settingsprepared.setString(5, sessionbean.getIpaddess());

			settingsprepared.setString(6,sessionid);
			
			rs = settingsprepared.executeUpdate();

			


    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(sessioncon != null)
				sessioncon.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionDeactiveFinal.jsp
	  * change AcademicSession status as D(DeActive)         - prasanth
	  @param sessionstatus that can be used to update all details to  yearofsession table by instituteid,sessionid wise
	  *
	  @param dateofcreation that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param createdby that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param instituteid that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param ipaddress that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @return the int by which result can be printed on the screen
	 */
    public int AcademicSessionDeactivate(AcademicSessionBean sessionbean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{log.info("invoking Academic Session Deactivate from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
        	String sessionid=sessionbean.getsessionid();
            sessioncon = ConnectionManager.getKycConnection();

			String query="update yearofsession set sessionstatus=? ,dateofcreation=?,createdby=?,instituteid=?  where sessionid=? ";
			settingsprepared = sessioncon.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sessionbean.getCreatedBy());
			settingsprepared.setString(4, sessionbean.getinstituteid());
			settingsprepared.setString(5,sessionid);
			rs = settingsprepared.executeUpdate();

		
    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(sessioncon != null)
				sessioncon.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionEditUpdate.jsp
	  * update  AcademicSession Details          - prasanth
	  @param sessionstatus that can be used to update all details to  yearofsession table by instituteid,sessionid wise
	  * 
	  @param dateofcreation that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param createdby that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param instituteid that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param ipaddress that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param description that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @return the int by which result can be printed on the screen
	 */
    public int UpdateEdittyearofsession(AcademicSessionBean sessionbean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		HashMap<String,String> MonthMap=new HashMap<String,String>();
    	MonthMap.put("1", "January");MonthMap.put("2", "February");MonthMap.put("3", "March");
	MonthMap.put("4", "April");MonthMap.put("5", "May");MonthMap.put("6", "June");
	MonthMap.put("7", "July");MonthMap.put("8", "August");MonthMap.put("9", "September");
	MonthMap.put("10", "October");MonthMap.put("11", "November");MonthMap.put("12", "December");
    	int rs=0;
    	
    	int result=0;
		ResultSet rs1						= null;

    	try
    	{log.info("invoking UpdateEdittyearofsession from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
        	String academicname=sessionbean.getsessionname();
        	String sessionid=sessionbean.getsessionid();
        	String academicdesi=sessionbean.getDescription();
    		
            sessioncon = ConnectionManager.getKycConnection();

            String str			= "select sessionname from yearofsession where sessionname=? and sessionid<>? and instituteid=? and sessionstatus <> ? ";
            
            instituteprepared	= sessioncon.prepareStatement(str);
            instituteprepared.setString(1, academicname.toLowerCase());
            instituteprepared.setString(2, sessionid);
            instituteprepared.setString(3,sessionbean.getinstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
            if(!rs1.next()){
            	
           
			String query="update yearofsession set sessionname=?, dateofcreation=?,description=?,createdby=?,instituteid=?,ipaddress=?,startmonth=?,startyear=?,endmonth=?,endyear=?  where sessionid=? and sessionstatus <> 'R' ";
			settingsprepared = sessioncon.prepareStatement(query);
			
			settingsprepared.setString(1, academicname.toLowerCase()); 
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,academicdesi);
			settingsprepared.setString(4, sessionbean.getCreatedBy());
			settingsprepared.setString(5, sessionbean.getinstituteid());
			settingsprepared.setString(6, sessionbean.getIpaddess());
			
			
			
			if(MonthMap.containsKey((sessionbean.getMonthstart())))
					settingsprepared.setString(7,MonthMap.get(sessionbean.getMonthstart()));
			else
				settingsprepared.setString(7,sessionbean.getMonthstart());
			
			settingsprepared.setString(8, sessionbean.getYearstart());
			
			if(MonthMap.containsKey((sessionbean.getMonthend())))
				settingsprepared.setString(9,MonthMap.get(sessionbean.getMonthend()));
			else
			settingsprepared.setString(9,sessionbean.getMonthend());
		
			
			settingsprepared.setString(10, sessionbean.getYearend());
			
			settingsprepared.setString(11,sessionid);
	System.out.println("settingsprepared"+settingsprepared);
	
			

			rs = settingsprepared.executeUpdate();
		
            }
            else
            {
            	rs=1000;
            }
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			
			if(sessioncon != null)
				sessioncon.close();
			
			if(instituteprepared != null)
				instituteprepared.close();
			
			
			if(rs1 != null)
				rs1.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionRestore.jsp
	  * change AcademicSession status as A (Restore)           - prasanth
	  @param sessionstatus that can be used to update all details to  yearofsession table by instituteid,sessionid wise
	  *
	  @param dateofcreation that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param createdby that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param instituteid that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param ipaddress that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @return the int by which result can be printed on the screen
	 */
    public int Restoreyearofsessions(AcademicSessionBean sessionbean) throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
		
    	try
    	{log.info("invoking Restoreyearofsessions from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
        	String sessionid=sessionbean.getsessionid();
            sessioncon = ConnectionManager.getKycConnection();

    			String query="update yearofsession set sessionstatus=?, dateofcreation=?,createdby=?,instituteid=?,ipaddress=?  where sessionid=? ";
    			settingsprepared = sessioncon.prepareStatement(query);
    			settingsprepared.setString(1, "N");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, sessionbean.getCreatedBy());
    			settingsprepared.setString(4, sessionbean.getinstituteid());
    			settingsprepared.setString(5, sessionbean.getIpaddess());

    			settingsprepared.setString(6,sessionid);

    			rs = settingsprepared.executeUpdate();
    			
    			
    			

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(sessioncon != null)
				sessioncon.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionActive.jsp
	  * change AcademicSession status as A(Active)         - prasanth
	  @param dateofcreation that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param createdby that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param instituteid that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @param ipaddress that can be used to update all details to  yearofsession table by sessionid,instituteid wise
	  *
	  @return the int by which result can be printed on the screen
	 */
    public int ActiveAcademicSessions(AcademicSessionBean sessionbean) throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	int result=0;
    	
		
    	try
    	{	log.info("invoking Active Academic Sessions from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
        	String sessionid=sessionbean.getsessionid();
            sessioncon = ConnectionManager.getKycConnection();

    			String query="update yearofsession set sessionstatus=?, dateofcreation=?,createdby=?,instituteid=?,ipaddress=?  where sessionid=? ";
    			settingsprepared = sessioncon.prepareStatement(query);
    			settingsprepared.setString(1, "N");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, sessionbean.getCreatedBy());
    			settingsprepared.setString(4, sessionbean.getinstituteid());
    			settingsprepared.setString(5, sessionbean.getIpaddess());

    			settingsprepared.setString(6,sessionid);

    		
    			rs = settingsprepared.executeUpdate();
    			
    			
    			

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(sessioncon != null)
				sessioncon.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/checkDuplicate.jsp
	  * check duplicate AcademicSession           - prasanth
	  @param sessionname that can be used to check duplicate names from  yearofsession table by instituteid,sessionid,sessionname wise
	  *
	  @param createdby  that can be used to check duplicate names from  yearofsession table by instituteid,sessionid,sessionname wise
	  *
	  @param instituteid  that can be used to check duplicate names from  yearofsession table by instituteid,sessionid,sessionname wise
	  *
	  @param sessionid  that can be used to check duplicate names from  yearofsession table by instituteid,sessionid,sessionname wise
	  *
	  @return the boolean by which result can be printed on the screen
	 */
    public boolean checkDuplicateupdate(String sessionname,String sessionid,String instituteid)
    {
    	boolean return_flag = false;
    	String return_string = null;
    	try
    	{log.info("invoking checkDuplicateupdate from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");

    		String select_query = "SELECT sessionname FROM yearofsession  where sessionname='"+sessionname+"' and instituteid='"+instituteid+"' and (sessionstatus='A' or sessionstatus='N') and   sessionstatus <> 'R' and sessionid <> '"+sessionid+"' " ;
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
    		log.error(e);	
    	}
    	return return_flag;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/AcademicSession/AcademicSessionUpdateByClick.jsp
	  * To display all session    lists  - prasanth
	  @param  sessionid   that can be get all sessionname name ,description details from  yearofsession table by sessionid wise 
	  *            
	  @return  the ArrayList for    printed the details on the screen 
	 */
public ArrayList getDetailsForuadate(String sessionid)
{
		ArrayList list=null;
		try
		{log.info("invoking get_All_SessionList from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
			select_query="select sessionid,sessionname,description,startmonth,startyear,endmonth,endyear from yearofsession where sessionid='"+sessionid+"' and  (sessionstatus='N' or sessionstatus='A' or sessionstatus='R')";
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    DateTime date_object;
    Connection sessioncon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}