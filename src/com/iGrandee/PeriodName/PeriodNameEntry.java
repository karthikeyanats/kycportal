package com.iGrandee.PeriodName;
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

public class PeriodNameEntry
{
	static Logger log = Logger.getLogger(PeriodNameEntry.class);

    public PeriodNameEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        periodnameconnection      = null;


        select_query = null;
    }
    /**
     * This method is accessed from kycportal/jsp/PeriodNames/PeriodNameSubmit.jsp
 	  * insert Period Name details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  periodnameid   that can be inserted to PeriodNames table
 	  * 
 	  @param periodname that can be inserted to PeriodNames table
 	  *
 	  @param dateofcreation that can be inserted to PeriodNames table
 	  *
 	  @param createdby that can be inserted to PeriodNames table
 	  *
      @param periodnamestatus that can be inserted to PeriodNames table  
 	  *     
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int insertPeriodname(PeriodNameBean periodnamebean)throws SQLException
    {   
		int result=0;
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;
		ResultSet rs						= null;
		PreparedStatement check				= null;
		int maxordervalue					= 0;

        try
    	{
	    	log.info("invoking insert Facultyperiodnamestatus from com.iGrandee.Exam.Facultyperiodnamestatus.FacultyperiodnamestatusEntry");
	    	periodnameconnection = ConnectionManager.getKycConnection();
	    	
	    	
	    check				= periodnameconnection.prepareStatement("select max(ordervalue) from periodnames where createdby=?");
	    check.setString(1,periodnamebean.getCreatedby());
	    rs					= check.executeQuery();
	    
	    if(rs.next())
	    	maxordervalue	= rs.getInt(1);
	    
	    maxordervalue++;
	    
	    String str			= "select a.periodname from periodnames a,login b,personmaster c,institution d where  a.periodname=?  and a.createdby=b.userid and b.loginstatus=? and b.personid=c.personid and c.status=? and c.instituteid=? and c.instituteid=d.instituteid and d.status=? and a.periodnamestatus <> ? ";
    	settingsprepared	= periodnameconnection.prepareStatement(str);
	 	settingsprepared.setString(1,periodnamebean.getPeriodname().toLowerCase());
	 	settingsprepared.setString(2, "A");
	 	settingsprepared.setString(3, "A");
	 	settingsprepared.setString(4, periodnamebean.getInstituteid());
	 	settingsprepared.setString(5, "A");
	 	settingsprepared.setString(6, "X");
         rs1	= settingsprepared.executeQuery(); 
         if(!rs1.next())
         {
        long l = common_data_object.fmaxId("select max(periodnameid)from periodnames");
		String query="insert into periodnames (periodnameid,periodname,dateofcreation,createdby,periodnamestatus,ordervalue) values(?,?,?,?,?,?)";
		settingsprepared = periodnameconnection.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,periodnamebean.getPeriodname());
		settingsprepared.setString(3, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(4, periodnamebean.getCreatedby());
		settingsprepared.setString(5, "A");
		settingsprepared.setInt(6, maxordervalue);
		result = settingsprepared.executeUpdate();
		
		   
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
				
				if(rs1!=null)
					rs1.close();

				if(rs!=null)
					rs.close();
				if(check!=null)
					check.close();
				

				if(settingsprepared != null)
					settingsprepared.close();
				
				if(instituteprepared!=null)
					instituteprepared.close();
				
				if(periodnameconnection != null)
					periodnameconnection.close();
				
			}
    return result;
}
    
    
    /**
     * This method is accessed from kycportal/jsp/PeriodNames/PeriodNameSubmit.jsp
 	  * insert Period Name details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  ordervalue Array of order value  that can be inserted to PeriodNames table
 	  * 
 	  @param periodnames Array of periodnameid  that can be inserted to PeriodNames table
 	  *
 	  @return the integer by which result can be printed on the screen
      */
    public int updateOrderValue(String[] ordervalue,String[] periodnames)throws SQLException
    {   
		int result		= 0;
    	PreparedStatement settingsprepared  = null;

        try
    	{
	    	periodnameconnection = ConnectionManager.getKycConnection();
        	
	    	log.info("invoking insert Facultyperiodnamestatus from com.iGrandee.Exam.Facultyperiodnamestatus.FacultyperiodnamestatusEntry");
	    	
			String query	= "update periodnames set ordervalue=? where periodnameid=?";
			settingsprepared = periodnameconnection.prepareStatement(query);
			
			if(ordervalue != null && ordervalue.length>0){
			
				for(int y=0;y<ordervalue.length;y++){
					settingsprepared.setString(1,ordervalue[y]);
					settingsprepared.setString(2,periodnames[y]);
					settingsprepared.addBatch();
				}
			}
			
			int temp[]	= settingsprepared.executeBatch();
				
			if(temp != null && temp.length>0)
				for(int y=0;y<temp.length;y++)
					result	+= temp[y];
			
			}catch(Exception exception)
			{ 
				log.error(exception);	
			}
			finally 
			{
				if(settingsprepared != null)
					settingsprepared.close();
				
				if(periodnameconnection != null)
					periodnameconnection.close();
				
			}
		return result;
	}    
    
    /**
     * This method is accessed from kycportal/jsp/PeriodNames/PeriodNameList.jsp
 	  * get Period Name details   - prasanth
      @param status that can be used to get period details from periodnames table by status wise   
 	  *     
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public ArrayList get_All_PeriodNameList(String status,String createdby,String  instituteid)
    {
    		ArrayList list=null;
    	
    		
    		try
    		{
            	log.info("invoking get All Faculity Remark List from com.iGrandee.Exam.Facultyperiodnamestatus.FacultyperiodnamestatusEntry");
    			select_query="select a.periodnameid,a.periodname,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates,a.periodnamestatus,a.ordervalue from periodnames a ,login b,personmaster c,institution d where  a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' and a.periodnamestatus='"+status+"' order by a.ordervalue,a.periodnameid asc;";

            	list=common_data_object.getListMap(select_query);
    			//System.out.println(select_query);
    		
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    	return list;
    }
    /**
     * This method is accessed from kycportal/jsp/PeriodNames/PeriodNameUpdateByClick.jsp
 	  * get Period Name details   - prasanth
      @param status that can be used to get period details from periodnames table by status wise   
 	  *
 	  @param periodnameid that can be used to get period details from periodnames table by periodnameid wise   
 	  *
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public ArrayList getDetailsForuadate(String status,String periodnameid)
    {
    		ArrayList list=null;
    	
    		
    		try
    		{
            	log.info("invoking get All Faculity Remark List from com.iGrandee.Exam.Facultyperiodnamestatus.FacultyperiodnamestatusEntry");
    			select_query="select periodnameid,periodname,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,periodnamestatus from periodnames where periodnameid='"+periodnameid+"' and periodnamestatus='"+status+"' order by dateofcreation desc";
    			list=common_data_object.getListMap(select_query);
    		
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    	return list;
    }
    
    public String LoadPeriodNameAllocatedCount(String periodnameid,String instituteid)
    {
    		String Count="";
    	
    		
    		try
    		{
            	log.info("invoking get allocated count  from LoadPeriodNameAllocatedCount method");
    			select_query="select count(pn.periodnameid) from periodnames pn join timetableperoid_tb tp on pn.periodnameid=tp.periodnameid and tp.periodnameid='"+periodnameid+"' and tp.status='A' and pn.periodnamestatus='A'  and tp.instituteid='"+instituteid+"' join timetable tt on tt.periodid=tp.periodid and  tt.periodid=tp.periodid and tp.status='A'";
    			Count=common_data_object.getSingleColumn(select_query);
    		
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    	return Count;
    }
    /**
     * This method is accessed from kycportal/jsp/PeriodNames/PeriodNameEditUpdate.jsp
 	  * update Period Name details    - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  periodnameid  that can be used to update period details to PeriodNames table
 	  * 
 	  @param  periodname  that can be used to update period details to PeriodNames table
 	  * 
 	  @param dateofcreation that can be used to update period details to PeriodNames table
 	  *
 	  @param createdby that that can be used to update period details to PeriodNames table
 	  *
      @param periodnamestatus that can be used to update period details to PeriodNames table
 	  *     
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int UpdateEdittPeriodName(PeriodNameBean periodnamebean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
    	PreparedStatement instituteprepared = null;
    	ResultSet rs1						= null;

    	int result=0;
    	
    	try
    	{
    			log.info("invoking Update Facultyperiodnamestatus  from com.iGrandee.Exam.Facultyperiodnamestatus.FacultyperiodnamestatusEntry");
    			periodnameconnection = ConnectionManager.getKycConnection();
    			String str			= "select periodname from periodnames where periodname=? and periodnameid<>?  and periodnamestatus <> ?";
                instituteprepared	= periodnameconnection.prepareStatement(str);
                instituteprepared.setString(1,periodnamebean.getPeriodname().toLowerCase());
                instituteprepared.setString(2, periodnamebean.getPeriodnameid());
                instituteprepared.setString(3, "X");
                rs1	= instituteprepared.executeQuery();
    	            
                if(!rs1.next())
                {
    	         String query="update periodnames set periodname=?, dateofcreation=?,createdby=? where periodnameid=? ";
    			settingsprepared = periodnameconnection.prepareStatement(query);
    		
    			settingsprepared.setString(1,periodnamebean.getPeriodname());
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, periodnamebean.getCreatedby());
    			settingsprepared.setString(4,periodnamebean.getPeriodnameid());
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
    		
    		if(instituteprepared!=null)
    			instituteprepared.close();
    		
    		if(periodnameconnection != null)
    			periodnameconnection.close();
    		
    		if(rs1!=null)
    		rs1.close();
    	}
    	return result;
    }
    /**
     * This method is accessed from kycportal/jsp/PeriodNames/PeriodNameStatusUpdate.jsp
 	  * update Period Name status    - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  periodnameid  that can be used to update period details to PeriodNames table
 	  * 
 	  @param dateofcreation that can be used to update period details to PeriodNames table
 	  *
 	  @param createdby that that can be used to update period details to PeriodNames table
 	  *
      @param periodnamestatus that can be used to update period details to PeriodNames table
 	  *     
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int StatusUpdate(PeriodNameBean periodnamebean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
    	PreparedStatement instituteprepared = null;
    	ResultSet rs1						= null;

    	int result=0;
    	
    	try
    	{
    			log.info("invoking Update Rack  from com.iGrandee.MasterEntries.Rack.RackEntry");
    			periodnameconnection = ConnectionManager.getKycConnection();
    			
    	         String query="update periodnames set  dateofcreation=?,createdby=?,periodnamestatus=? where periodnameid=? ";
    			settingsprepared = periodnameconnection.prepareStatement(query);
    		
    			settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(2, periodnamebean.getCreatedby());
    			settingsprepared.setString(3, periodnamebean.getPeriodnamestatus());
    			settingsprepared.setString(4,periodnamebean.getPeriodnameid());
    			result = settingsprepared.executeUpdate();
    	
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
    		
    		if(periodnameconnection != null)
    			periodnameconnection.close();
    		
    		if(rs1!=null)
    		rs1.close();
    	}
    	return result;
    }
    DateTime date_object;
    Connection periodnameconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}