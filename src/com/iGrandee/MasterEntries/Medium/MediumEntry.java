package com.iGrandee.MasterEntries.Medium;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import com.iGrandee.MasterEntries.Board.BoardEntry;
import com.iGrandee.MasterEntries.Medium.MediumBean;
import org.apache.log4j.Logger;

public class MediumEntry
{
	static Logger log = Logger.getLogger(MediumEntry.class);

    public MediumEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        mediumbean = new MediumBean();
        mediumcon      = null;


        select_query = null;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/medium/MediumSubmit.jsp
	   * insert  medium       - prasanth
	   @param  mediumid insert in  to standardmedium table 
	   *
	   @param mediumname insert in  to standardmedium table 
	   *
	   @param description insert in  to standardmedium table
	   * 
	   @param createdby insert in  to standardmedium table 
	   *
	   @param dateofcreation insert in  to standardmedium table 
	   *
	   @param mediumstatus insert in  to standardmedium table 
	   *
	   @param instituteid insert in  to standardmedium table 
	   *
	   @return   int for    printed the result on the screen 
	 */
    public int insertMediums()throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;


        try
    	{   
        	        	 
        	log.info("invoking insertMediums from com.iGrandee.MasterEntries.Medium.MediumEntry");
        mediumcon = ConnectionManager.getKycConnection();
		
        String str			= "select mediumid,mediumname from standardmedium where mediumname=? and instituteid=? and mediumstatus <> ? ";
        instituteprepared	= mediumcon.prepareStatement(str);
        instituteprepared.setString(1, mediumbean.getmediumname().toLowerCase());
        instituteprepared.setString(2, mediumbean.getinstituteid());
        instituteprepared.setString(3, "X");
        rs1	= instituteprepared.executeQuery(); 
        if(!rs1.next())
        {
        
        long l = common_data_object.fmaxId("select max(mediumid)from standardmedium");
		String query="insert into standardmedium (mediumid,mediumname,description,createdby,dateofcreation,mediumstatus,instituteid) values(?,?,?,?,?,?,?)";
		settingsprepared = mediumcon.prepareStatement(query);
		
		
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,mediumbean.getmediumname());
		settingsprepared.setString(3,mediumbean.getDescription());
		settingsprepared.setString(4, mediumbean.getcreatedby());
		settingsprepared.setString(5, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(6, "A");
		settingsprepared.setString(7, mediumbean.getinstituteid());


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
				if(settingsprepared != null)
					settingsprepared.close();
				
				if(mediumcon != null)
					mediumcon.close();
				
				if(instituteprepared!=null)
				instituteprepared.close();
					
			if(rs1!=null)
			rs1.close();
			
			}
    return result;
}
    
  
   
    /**
	   * This method is accessed from kycportal/jsp/masterentries/medium/MediumList.jsp
	   * list all medium active list      - prasanth
	   @param  instituteid that can be get all details from  standardmedium table by instituteid wise
	   *
	   @return   ArrayList for    printed the result on the screen 
	 */
    public ArrayList get_All_mediums(String instituteid)
    {
		ArrayList list=null;
	
		
		try
		{
			log.info("invoking get_All_mediums from com.iGrandee.MasterEntries.Medium.MediumEntry");
			select_query="select mediumid,mediumname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,mediumstatus from standardmedium where instituteid='"+instituteid+"' and mediumstatus='A' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
			
			
				
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);					
			}
	    	
	    	return list;
	    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/medium/MediumTrash.jsp
	    * change  medium status as T ()Trash   - prasanth
	    * @param  mediumstatus that can be update all details to  standardmedium table by  mediumid wise
	    *
	    @param dateofcreation that can be update all details to  standardmedium table by  mediumid wise
	    *
	    @param createdby that can be update all details to  standardmedium table by  mediumid wise
	    *
	    @param mediumid that can be update all details to  standardmedium table by  mediumid wise
	    *
	    @return   int for    printed the result on the screen 
	 */
    public int Updatetashmediums() throws SQLException
    {
    	String status=mediumbean.getStatus();
    	String mediumid=mediumbean.getmediumid();
    	PreparedStatement settingsprepared  = null;

		
    	int rs=0;
    	try
    	{
    		log.info("invoking Updatetashmediums from com.iGrandee.MasterEntries.Medium.MediumEntry");
            mediumcon = ConnectionManager.getKycConnection();

        	String query="update standardmedium set mediumstatus=?,dateofcreation=?,createdby=? where mediumid=?";
			settingsprepared = mediumcon.prepareStatement(query);

			settingsprepared.setString(1, status);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, mediumbean.getcreatedby());
			settingsprepared.setString(4,mediumid);

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
					
					if(mediumcon != null)
						mediumcon.close();
				}
		    	return rs;
		    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/medium/MediumTrashListview.jsp
	   * list all   medium Trash list   - prasanth
	   @param  instituteid that can be get all details from  standardmedium table by instituteid wise
	   *
	   @return   ArrayList for    printed the result on the screen 
	  
	 */
    public ArrayList get_All_mediumTrashList(String instituteid)
    {
		ArrayList list=null;
		try
		{
    		log.info("invoking get_All_mediumTrashList from com.iGrandee.MasterEntries.Medium.MediumEntry");

			select_query="select mediumid,mediumname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,mediumstatus from standardmedium where instituteid='"+instituteid+"' and mediumstatus='T' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);	
		}
		return list;
	}
    /**
	    * This method is accessed from kycportal/jsp/masterentries/medium/MediumDeactiveList.jsp
	    * list all medium deactivate list     - prasanth
	    @param  instituteid that can be get all details from  standardmedium table by instituteid wise
	    *
	    @return   ArrayList for    printed the result on the screen 
	 */
    public ArrayList get_All_mediumDeactivateList(String instituteid)
    {
		ArrayList list=null;
		try
		{
			log.info("invoking get_All_mediumDeactivateList from com.iGrandee.MasterEntries.Medium.MediumEntry");
			select_query="select mediumid,mediumname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,mediumstatus from standardmedium where instituteid='"+instituteid+"' and mediumstatus='D' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);	
		}
		return list;
	}
    /**
	    * This method is accessed from kycportal/jsp/masterentries/medium/MediumDelete.jsp
	    * change medium status as X (Delete)      - prasanth
	    @param   mediumstatus  that can be updated to  standardmedium table  by  mediumid wise
	    *
	    @param dateofcreation  that can be updated to  standardmedium table  by  mediumid wise
	    *
	    @param createdby  that can be updated to  standardmedium table  by  mediumid wise
	    *
	    @param mediumid  that can be updated to  standardmedium table  by  mediumid wise
	    *
	    @return   int for printed the result on the screen 
	 */
    public int Deletemediums()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	
    	try
    	{
    		log.info("invoking Deletemediums from com.iGrandee.MasterEntries.Medium.MediumEntry");
        	String mediumid=mediumbean.getmediumid();

            mediumcon = ConnectionManager.getKycConnection();

			String query="update standardmedium set mediumstatus=?,dateofcreation=?,createdby=?  where mediumid=? ";
			settingsprepared = mediumcon.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, mediumbean.getcreatedby());
			settingsprepared.setString(4,mediumid);
			
			rs = settingsprepared.executeUpdate();



    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(mediumcon != null)
				mediumcon.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/medium/MediumDeactiveFinal.jsp
	  * change status as D (Deactivate)      - prasanth
	  @param   mediumstatus  that can be updated to  standardmedium table by  mediumid wise
	  *
	  @param dateofcreation that can be updated to  standardmedium table by  mediumid wise
	  *
	  @param createdby that can be updated to  standardmedium table by  mediumid wise
	  *
	  @return  int for printed the result on the screen
	  
	 */
    public int mediumsDeactivate()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	
    	try
    	{
    		log.info("invoking mediumsDeactivate from com.iGrandee.MasterEntries.Medium.MediumEntry");
        	String mediumid=mediumbean.getmediumid();

            mediumcon = ConnectionManager.getKycConnection();

			String query="update standardmedium set mediumstatus=? ,dateofcreation=?,createdby=?  where mediumid=? ";
			settingsprepared = mediumcon.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, mediumbean.getcreatedby());
			settingsprepared.setString(4,mediumid);
			rs = settingsprepared.executeUpdate();



    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(mediumcon != null)
				mediumcon.close();
		}
    	return rs;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/medium/MediumEditUpdate.jsp
	   * update medium details      - prasanth
	   @param   mediumstatus  that can be updated to  standardmedium table by  mediumid wise
	   * 
	   @param dateofcreation that can be updated to  standardmedium table by  mediumid wise
	   *
	   @param createdby that can be updated to  standardmedium table by  mediumid wise
	   *
	   @param description that can be updated to  standardmedium table by  mediumid wise
	   *
	   @param mediumid that can be updated to  standardmedium table by  mediumid wise
	   *
	   @param that can be updated to  standardmedium table by  mediumid wise
	   *
	   @param that can be updated to  standardmedium table by  mediumid wise
	   *
	   @return   int for printed the result on the screen
	 */
    public int UpdateEdittmediums()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
		ResultSet rs1						= null;

    	
    	try
    	{
    		log.info("invoking UpdateEdittmediums from com.iGrandee.MasterEntries.Medium.MediumEntry");
        	String mediumname=mediumbean.getmediumname();
        	String mediumid=mediumbean.getmediumid();
        	String mediumdesi=mediumbean.getDescription();
    		
            mediumcon = ConnectionManager.getKycConnection();

            
            String str			= "select mediumname from standardmedium where mediumname=? and mediumid<>? and instituteid=? and mediumstatus <> ?";
            instituteprepared	= mediumcon.prepareStatement(str);
            instituteprepared.setString(1, mediumname.toLowerCase()); 
            instituteprepared.setString(2, mediumid);
            instituteprepared.setString(3,mediumbean.getinstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
            
            if(!rs1.next()){
            	
           
			String query="update standardmedium set mediumname=?, dateofcreation=?,description=?,createdby=? where mediumid=? ";
			settingsprepared = mediumcon.prepareStatement(query);
			
			settingsprepared.setString(1, mediumname);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,mediumdesi);
			settingsprepared.setString(4, mediumbean.getcreatedby());
			settingsprepared.setString(5,mediumid);


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
			
			if(instituteprepared != null)
				instituteprepared.close();
			
			if(mediumcon != null)
				mediumcon.close();
			
			if(rs1!=null)
			rs1.close();
		}
    	return rs;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/medium/MedumActive.jsp
	   * This method is accessed from kycportal/jsp/masterentries/medium/MedumRestore.jsp
	   * change Medium status as A(Active,Restore)  - prasanth
	    @param   mediumstatus that can be updated to  standardmedium table by  mediumid wise
	    *
	    @param dateofcreation that can be updated to  standardmedium table by  mediumid wise
	    *
	    @param createdby that can be updated to  standardmedium table by  mediumid wise
	    *
	    @param mediumid that can be updated to  standardmedium table by  mediumid wise
	    *
	    @return   int for printed the result on the screen
	 */
    public int Restoremediums() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	
		
    	try
    	{
    		log.info("invoking Restoremediums from com.iGrandee.MasterEntries.Medium.MediumEntry");
        	String mediumid=mediumbean.getmediumid();
            mediumcon = ConnectionManager.getKycConnection();

    			String query="update standardmedium set mediumstatus=?, dateofcreation=?,createdby=?  where mediumid=? ";
    			settingsprepared = mediumcon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, mediumbean.getcreatedby());
    			settingsprepared.setString(4,mediumid);
    		
    			rs = settingsprepared.executeUpdate();

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(mediumcon != null)
				mediumcon.close();
		}
    	return rs;
    }
   
    /**
	   * This method is accessed from kycportal/jsp/masterentries/medium/MediumTrashPriview.jsp
	   * check No of  Board in this Medium   - prasanth
	   @param  instituteid  that can be check allocated medium count from standardmedium table
	   *
	   @param  mediumid  that can be check allocated medium count from standardmedium table
	   *
	   @return   String for printed the result on the screen
	 */
    public String checkTrashMediums(String instituteid)
    {
    	String list=null;
		try
		{
			log.info("invoking checkTrashMediums from com.iGrandee.MasterEntries.Medium.MediumEntry");
			String mediumid=mediumbean.getmediumid();
			select_query="select count(b.mediumid) as mediumcount from standardmedium b,board a where a.mediumid=b.mediumid and b.instituteid='"+instituteid+"' and  a.instituteid=b.instituteid and a.mediumid='"+mediumid+"';";

			list=common_data_object.getString(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);	
		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/masterentries/medium/checkDuplicate.jsp
	  * for check duplicate names      - prasanth
	    @param  mediumname  that can be check duplicate names from standardmedium table
	  * 
	  * @param mediumid that can be check duplicate names from standardmedium table
	  * 
	  * @param instituteid that can be check duplicate names from standardmedium table
	  * 
	    @return   boolean for printed the result on the screen
	 */
    public boolean checkDuplicateupdate(String mediumname,String mediumid,String instituteid)
    {
    	boolean return_flag = false;
    	String return_string = null;
    	try
    	{
    		log.info("invoking checkDuplicateupdate from com.iGrandee.MasterEntries.Medium.MediumEntry");
    		String select_query = "SELECT mediumname FROM standardmedium  where mediumname='"+mediumname+"' and instituteid='"+instituteid+"' and mediumstatus='A' and  mediumid <> '"+mediumid+"' " ;
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
	  * This method is accessed from kycportal/jsp/masterentries/Board/BoardEntry.jsp
	  * for check duplicate names      - prasanth
	  @param  instituteid for get all details  from standardmedium table by  instituteid wise
	  *
	    @return   ArrayList for printed the result on the screen
	 */
    public ArrayList getAllMediumNames(String instituteid)
    {
		ArrayList list=null;
    	String mediumid=mediumbean.getmediumid();

		try
		{
			log.info("invoking getAllMediumNames from com.iGrandee.MasterEntries.Medium.MediumEntry");
			select_query="select mediumid,mediumname from standardmedium where mediumstatus='A' and instituteid='"+instituteid+"' ";
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);	
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Medium/MediumUpdateByClick.jsp
	   * To display all medium    lists  - prasanth
	 
	   @param  mediumid   that can be get all medium name ,description details from  to standardmedium table by mediumid wise
	   *             
	   @return  the ArrayList for    printed the details on the screen 
	 */
 public ArrayList getDetailsForuadate(String mediumid)
 {
		ArrayList list=null;
		try
		{log.info("invoking get_All_MediumList from com.iGrandee.MasterEntries.Medium.MediumEntry");
			select_query="select mediumid,mediumname,description from standardmedium where mediumid='"+mediumid+"' and  mediumstatus='A'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    DateTime date_object;
    Connection mediumcon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    MediumBean mediumbean;
    String select_query;
    Statement stmt;
    ResultSet rs;
}