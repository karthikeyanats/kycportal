package com.iGrandee.Library.MasterEntries.Frequency;
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

public class FrequencyEntry
{ 
	static Logger log = Logger.getLogger(FrequencyEntry.class);

    public FrequencyEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        frequencyconnection      = null;


        select_query = null;
    }
    /**
     * This method is accessed from kycportal/jsp/masterentries/Frequency/FrequencySubmit.jsp
 	  * insert frequency details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  frequencyid   that can be inserted to frequency table
 	  * 
 	  @param frequencyname that can be inserted to frequency table
 	  *
 	  @param description that can be inserted to frequency table
 	  *
 	  @param dateofcreation that can be inserted to frequency table
 	  *
 	  @param createdby that can be inserted to frequency table
 	  *
      @param instituteid that can be inserted to frequency table
      *
 	  @param ipaddress that can be inserted to frequency table
 	  *
 	  @param frequencystatus that can be inserted to frequency table  
 	  *     
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int insertFrequency(FrequencyBean frequencybean)throws SQLException
    {
		int result=0;
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

        try
    	{
	    	log.info("invoking insert Frequency from com.iGrandee.MasterEntries.Frequency.FrequencyEntry");
	    	frequencyconnection = ConnectionManager.getKycConnection();
	
    	 String str			= "select frequencyid,frequencyname from frequency where frequencyname=? and instituteid=? and frequencystatus <> ? ";
    	 settingsprepared	= frequencyconnection.prepareStatement(str);
    	 settingsprepared.setString(1,frequencybean.getFrequencyname().toLowerCase());
    	 settingsprepared.setString(2, frequencybean.getInstituteid());
    	 settingsprepared.setString(3, "X");
         rs1	= settingsprepared.executeQuery(); 
         if(!rs1.next())
         {
        long l = common_data_object.fmaxId("select max(frequencyid)from frequency");
		String query="insert into frequency (frequencyid,frequencyname,description,dateofcreation,createdby,instituteid,ipaddress,frequencystatus) values(?,?,?,?,?,?,?,?)";
		settingsprepared = frequencyconnection.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,frequencybean.getFrequencyname());
		settingsprepared.setString(3,frequencybean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, frequencybean.getCreatedby());
		settingsprepared.setString(6, frequencybean.getInstituteid());
		settingsprepared.setString(7, frequencybean.getIpaddress());
		settingsprepared.setString(8, "A");
		result = settingsprepared.executeUpdate();
		
		    long l1 = common_data_object.fmaxId("select max(frequencylogid)from frequencylog");
			String query_log="insert into frequencylog (frequencylogid,frequencyid,logstatus,dateofcreation,createdby,frequencylogstatus) values(?,?,?,?,?,?)";
			instituteprepared = frequencyconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setLong(2,l);
			instituteprepared.setString(3,frequencybean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, frequencybean.getCreatedby());
			instituteprepared.setString(6, frequencybean.getFrequencylogstatus());
		
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
				
				if(frequencyconnection != null)
					frequencyconnection.close();
				
				if(rs1!=null)
				rs1.close();
			}
    return result;
}
    
/**
 * This method is accessed from kycportal/jsp/masterentries/Frequency/FrequencyList.jsp
 * get details for updation - prasanth

 @param  instituteid  that can be get frequencyid,frequencyname and description by institute wise from frequency table
 * 
 @param  frequencystatus   that can be get frequencyid,frequencyname and description by status wise from frequency table
 *
 @return  the ArrayList for    printed the result on the screen 
*/
public ArrayList get_All_Frequency(String instituteid,String status)
{
		ArrayList list=null;
	
		
		try
		{
        	log.info("invoking get All Frequency Active List from com.iGrandee.MasterEntries.Frequency.FrequencyEntry");
			select_query="select frequencyid,frequencyname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,frequencystatus from frequency where instituteid='"+instituteid+"' and frequencystatus='"+status+"' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/Frequency/FrequencyUpdateByClick.jsp
 * get details for updation - prasanth
 @param  frequencyid   that can be get frequencyid,frequencyname and description from frequency table
 *  
 @param  instituteid  that can be get frequencyid,frequencyname and description by institute wise from frequency table
 * 
 @param  status   that can be get frequencyid,frequencyname and description by frequencystatus wise from frequency table
 *
 @return  the ArrayList for    printed the result on the screen 
*/
public ArrayList getDetailsForuadate(String frequencyid,String status,String instituteid)
{
		ArrayList list=null;
		
		try
		{
        	log.info("invoking get All Rack Active List from com.iGrandee.MasterEntries.Frequency.FrequencyEntry");

			select_query="select frequencyid,frequencyname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,frequencystatus from frequency where frequencyid='"+frequencyid+"' and frequencystatus='"+status+"' and instituteid='"+instituteid+"' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/Frequency/FrequencyEditUpdate.jsp
 * update  frequency details  - prasanth
   @param  frequencyid that can be updated to frequency table  by frequencyid wise
   *
   @param frequencyname that can be updated to frequency table  by frequencyid wise
   *
   @param description that can be updated to frequency table  by frequencyid wise
   *
   @param dateofcreation that can be updated to frequency table  by frequencyid wise
   *
   @param createdby that can be updated to frequency table  by frequencyid wise
   *
   @param instituteid that can be updated to frequency table  by frequencyid wise
   *
   @param ipaddress that can be updated to frequency table  by frequencyid wise
   *
   @param status  that can be updated to frequency table  by frequencystatus wise  
   *          
  @return  the int for   printed the result on the screen 
*/
public int UpdateEdittFrequency(FrequencyBean frequencybean)  throws SQLException
{
	PreparedStatement settingsprepared  = null;
	PreparedStatement instituteprepared = null;
	ResultSet rs1						= null;

	int result=0;
	
	try
	{
		log.info("invoking Update Frequency  from com.iGrandee.MasterEntries.Frequency.FrequencyEntry");
			frequencyconnection = ConnectionManager.getKycConnection();
      
			String str			= "select frequencyname from frequency where frequencyname=? and frequencyid<>? and instituteid=? and frequencystatus <> ?";
            instituteprepared	= frequencyconnection.prepareStatement(str);
            instituteprepared.setString(1, frequencybean.getFrequencyname().toLowerCase());
            instituteprepared.setString(2, frequencybean.getFrequencyid());
            instituteprepared.setString(3,frequencybean.getInstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
	            
            if(!rs1.next())
            {
	         String query="update frequency set frequencyname=?, dateofcreation=?,description=?,ipaddress=?,createdby=?,instituteid=?  where frequencyid=? ";
			settingsprepared = frequencyconnection.prepareStatement(query);
		
			settingsprepared.setString(1, frequencybean.getFrequencyname());
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,frequencybean.getDescription());
			settingsprepared.setString(4, frequencybean.getIpaddress());
			settingsprepared.setString(5, frequencybean.getCreatedby());
			settingsprepared.setString(6, frequencybean.getInstituteid());
			settingsprepared.setString(7,frequencybean.getFrequencyid());
			result = settingsprepared.executeUpdate();
			
		    long l1 = common_data_object.fmaxId("select max(frequencylogid)from frequencylog");
			String query_log="insert into frequencylog (frequencylogid,frequencyid,logstatus,dateofcreation,createdby,frequencylogstatus) values(?,?,?,?,?,?)";
			instituteprepared = frequencyconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setString(2,frequencybean.getFrequencyid());
			instituteprepared.setString(3,frequencybean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, frequencybean.getCreatedby());
			instituteprepared.setString(6, frequencybean.getFrequencylogstatus());
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
		
		if(frequencyconnection != null)
			frequencyconnection.close();
		
		if(rs1!=null)
		rs1.close();
	}
	return result;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/Frequency/FrequencyStatusUpdate.jsp
 * update  department details  - prasanth
   @param  frequencyid that can be updated to frequency table  by frequencyid wise
   *
   @param frequencyname that can be updated to frequency table  by frequencyid wise
   *
   @param description that can be updated to frequency table  by frequencyid wise
   *
   @param dateofcreation that can be updated to frequency table  by frequencyid wise
   *
   @param createdby that can be updated to frequency table  by frequencyid wise
   *
   @param instituteid that can be updated to frequency table  by frequencyid wise
   *
   @param ipaddress that can be updated to frequency table  by frequencyid wise
   *
   @param status  that can be updated to frequency table  by frequencyid wise  
   *          
  @return  the int for   printed the result on the screen 
*/
public int FrequencyStatusUpdate(FrequencyBean frequencybean)  throws SQLException
{
	PreparedStatement settingsprepared  = null;
	PreparedStatement instituteprepared = null;
	ResultSet rs1						= null;

	int result=0;
	
	try
	{
		log.info("invoking Update Frequency  from com.iGrandee.MasterEntries.Frequency.FrequencyEntry");
			frequencyconnection = ConnectionManager.getKycConnection();
		
	        String query="update frequency set  dateofcreation=?,ipaddress=?,createdby=?,instituteid=?,frequencystatus=?  where frequencyid=? ";
			settingsprepared = frequencyconnection.prepareStatement(query);
		
			settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(2, frequencybean.getIpaddress());
			settingsprepared.setString(3, frequencybean.getCreatedby());
			settingsprepared.setString(4, frequencybean.getInstituteid());
			settingsprepared.setString(5,frequencybean.getFrequencystatus());
			settingsprepared.setString(6,frequencybean.getFrequencyid());
			result = settingsprepared.executeUpdate();
		    long l1 = common_data_object.fmaxId("select max(frequencylogid)from frequencylog");
			String query_log="insert into frequencylog (frequencylogid,frequencyid,logstatus,dateofcreation,createdby,frequencylogstatus) values(?,?,?,?,?,?)";
			instituteprepared = frequencyconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setString(2,frequencybean.getFrequencyid());
			instituteprepared.setString(3,frequencybean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, frequencybean.getCreatedby());
			instituteprepared.setString(6, frequencybean.getFrequencylogstatus());
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
		
		if(frequencyconnection != null)
			frequencyconnection.close();
		
		
	}
	return result;
}

/**
 * This method is accessed from kycportal/jsp/masterentries/Frequency/FrequencyTrashPriview.jsp
 * 
 @param  instituteid   that can be check check No of  Staff in this Frequency present or not 
 *               
 @return  the String for    printed the result on the screen 
*/
public String checkTrashFrequency(String freqid)
{
	String count	= null;
	try
	{
		log.info("invoking checkTrashRacks from com.iGrandee.MasterEntries.Rack.RackEntry");
		select_query	= "select count(frequencyid) as freqcount from bookmaster b where b.frequencyid='"+freqid+"' and b.bookmasterstatus='A'";
		count			= common_data_object.getString(select_query);
	}
	catch(Exception exception)
	{
		log.error(exception);
	}
	return count;
}

    DateTime date_object;
    Connection frequencyconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}