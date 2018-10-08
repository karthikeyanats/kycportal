package com.iGrandee.MasterEntries.Section;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.iGrandee.MasterEntries.Section.SectionBean;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import org.apache.log4j.Logger;

public class SectionEntry
{
	static Logger log = Logger.getLogger(SectionEntry.class);

    public SectionEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        sectionbean = new SectionBean();
        sectioncon      = null;


        select_query = null;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/section/SectionSubmit.jsp
	    * insert section details        - prasanth
	    * Returns an Integer  by which result can be printed on the screen. 
    
	    @param  sectionid that can be inserted to section table
	    *
		@param sectionname that can be inserted to section table
		*
		@param description that can be inserted to section table
		*
		@param dateofcreation that can be inserted to section table
		*
		@param instituteid  that can be inserted to section table
		*
		@param ipaddress that can be inserted to section table
		*
		@param createdby that can be inserted to section table
		*
		@param status that can be inserted to section table
		*
	               
	   @return   the integer by which result can be printed on the screen
	 */
    public int insertsections()throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

        try
    	{
        	log.info("invoking insertsections from com.iGrandee.MasterEntries.Section.SectionEntry");
        
        	sectioncon = ConnectionManager.getKycConnection();
		
        	 String str			= "select sectionid,sectionname from section where sectionname=? and instituteid=? and status <> ? ";
             instituteprepared	= sectioncon.prepareStatement(str);
             instituteprepared.setString(1, sectionbean.getsectionname().toLowerCase());
             instituteprepared.setString(2, sectionbean.getinstituteid());
             instituteprepared.setString(3, "X");
             rs1	= instituteprepared.executeQuery(); 
             if(!rs1.next())
             {
        	long l = common_data_object.fmaxId("select max(sectionid)from section");
        	String query="insert into section (sectionid,sectionname,description,dateofcreation,instituteid,ipaddress,createdby,status) values(?,?,?,?,?,?,?,?)";
        	settingsprepared = sectioncon.prepareStatement(query);
	
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,sectionbean.getsectionname());
		settingsprepared.setString(3,sectionbean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, sectionbean.getinstituteid());
		settingsprepared.setString(6, sectionbean.getIpaddess());
		settingsprepared.setString(7, sectionbean.getCreatedBy());
		settingsprepared.setString(8, "A");

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
				
				if(sectioncon != null)
					sectioncon.close();
				
				if(instituteprepared != null)
					instituteprepared.close();
				
				if(rs1 != null)
					rs1.close();
			}
    return result;
}
   
    /**
	  * This method is accessed from kycportal/jsp/masterentries/section/SectionList.jsp
	  * get all section active list         - prasanth
	  @param  instituteid  that can be display all details from sections by instituteid wise
	  *                 
	  @return      the integer by which result can be printed on the screen
	 */
    public ArrayList get_All_sections(String instituteid)
    {
		ArrayList list=null;
	
		
		try
		{        	log.info("invoking get_All_sections from com.iGrandee.MasterEntries.Section.SectionEntry");

			select_query="select sectionid,instituteid,sectionname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,status from section where instituteid='"+instituteid+"' and  status='A' order by dateofcreation desc";

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
	    * This method is accessed from kycportal/jsp/masterentries/section/SectionTrash.jsp
	    * change  section status as T(Trash)        - prasanth
	    @param  status  that can be update all details to sections by instituteid,sectionid wise
	    *
		@param dateofcreation that can be used to update section details  to section table
		*
		@param instituteid  that can be used to update section details  to section table
		*
		@param ipaddress that can be used to update section details  to section table
		*
		@param createdby that can be used to update section details  to section table
		*
	   @return  the integer by which result can be printed on the screen
	 */
    public int Updatetashsections() throws SQLException
    {
    	String status=sectionbean.getStatus();
    	String sectionid=sectionbean.getsectionid();
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

		
    	int rs=0;
    	try
    	{log.info("invoking Updatetashsections from com.iGrandee.MasterEntries.Section.SectionEntry");
            sectioncon = ConnectionManager.getKycConnection();

    			
            
        	String query="update section set status=?,dateofcreation=?,ipaddress=?,status=?,instituteid=? where sectionid=?";
			settingsprepared = sectioncon.prepareStatement(query);

			settingsprepared.setString(1, status);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sectionbean.getIpaddess());
			settingsprepared.setString(4, sectionbean.getStatus());
			settingsprepared.setString(5, sectionbean.getinstituteid());
			settingsprepared.setString(6,sectionid);

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
					
					if(sectioncon != null)
						sectioncon.close();
				}
		    	return rs;
		    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/section/SectionTrashListView.jsp
	   * get all  section Trash lists      - prasanth
	   @param  instituteid  that can be used to display all details from sections by instituteid wise
	   *                  
	   @return      the ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_sectionTrashList(String instituteid)
    {
		ArrayList list=null;
		try
		{log.info("invoking get_All_sectionTrashList from com.iGrandee.MasterEntries.Section.SectionEntry");
			select_query="select sectionid,instituteid,sectionname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,status from section where instituteid='"+instituteid+"' and status='T' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/section/SectionDeactiveView.jsp
	   * list all Deactivate sections        - prasanth
	   @param  instituteid  that can be used to display all details from sections by instituteid wise
	   *                   
	   @return   the ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_sectionDeactivateList(String instituteid)
    {
		ArrayList list=null;
		try
		{
			log.info("invoking get_All_sectionDeactivateList from com.iGrandee.MasterEntries.Section.SectionEntry");
			select_query="select sectionid,instituteid,sectionname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,status from section where instituteid='"+instituteid+"' and status='D' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);
		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/masterentries/section/SectionDelete.jsp
	  * change section status as X(Delete)         - prasanth
	  @param  status that can be used to display all details from sections by ,sectionid wise
	  *
	  @param dateofcreation that can be used to display all details from sections by ,sectionid wise
	  *
	  @param instituteid  that can be used to display all details from sections by ,sectionid wise
	  *
	  @param ipaddress that can be used to display all details from sections by ,sectionid wise
	  *
	  @param createdby that can be used to display all details from sections by ,sectionid wise  
	  *             
	  @return the integer by which result can be printed on the screen
	 */
    public int Deletesections()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	
    	try
    	{log.info("invoking Deletesections from com.iGrandee.MasterEntries.Section.SectionEntry");
        	String sectionid=sectionbean.getsectionid();

            sectioncon = ConnectionManager.getKycConnection();

			String query="update section set status=?,dateofcreation=?,ipaddress=?,instituteid=?  where sectionid=? ";
			settingsprepared = sectioncon.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sectionbean.getIpaddess());
			settingsprepared.setString(4, sectionbean.getinstituteid());
			settingsprepared.setString(5,sectionid);
			
			rs = settingsprepared.executeUpdate();



    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(sectioncon != null)
				sectioncon.close();
		}
    	return rs;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/section/SectionDeactiveFinal.jsp
	   * change section status as D(Deactivate)        - prasanth
	    @param  status  that can be used to display all details from sections by instituteid,sectionid wise
	                
	    @param dateofcreation that can be used to display all details from sections by ,sectionid wise
	    *
		@param instituteid  that can be used to display all details from sections by ,sectionid wise
		*
		@param ipaddress that can be used to display all details from sections by ,sectionid wise
		*
		@param createdby that can be used to display all details from sections by ,sectionid wise 
		*
		@return the integer by which result can be printed on the screen
	  
	 */
    public int sectionsDeactivate()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	
    	try
    	{log.info("invoking sectionsDeactivate from com.iGrandee.MasterEntries.Section.SectionEntry");
        	String sectionid=sectionbean.getsectionid();

            sectioncon = ConnectionManager.getKycConnection();

			String query="update section set status=? ,dateofcreation=?,ipaddress=?,instituteid=?  where sectionid=? ";
			settingsprepared = sectioncon.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sectionbean.getIpaddess());
			settingsprepared.setString(4, sectionbean.getinstituteid());
			settingsprepared.setString(5,sectionid);
			rs = settingsprepared.executeUpdate();



    		
    	}
    	catch(Exception exception) { 
    		log.error(exception);			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(sectioncon != null)
				sectioncon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/section/SectionEditUpdate.jsp
	    * update section details         - prasanth
	    @param  sectionname that can be used to display all details from sections bysectionid wise
	    * 
	    @param dateofcreation that can be used to display all details from sections by ,sectionid wise
	    *
		@param instituteid  that can be used to display all details from sections by ,sectionid wise
		*
		@param ipaddress that can be used to display all details from sections by ,sectionid wise
		*
		@param createdby that can be used to display all details from sections by ,sectionid wise  
		*
		@param description that can be used to display all details from sections by ,sectionid wise
		*                  
	   @return the integer by which result can be printed on the screen
	 */
    public int UpdateEdittsections()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
    	PreparedStatement instituteprepared  = null;

    	int rs=0;
		ResultSet rs1						= null;

    	
    	try
    	{log.info("invoking UpdateEdittsections from com.iGrandee.MasterEntries.Section.SectionEntry");
        	String sectionname=sectionbean.getsectionname();
        	String sectionid=sectionbean.getsectionid();
        	String sectiondesi=sectionbean.getDescription();
    		
            sectioncon = ConnectionManager.getKycConnection();

            
            String str			= "select sectionname from section where sectionname=? and sectionid<>? and instituteid=? and status <> ?";
            instituteprepared	= sectioncon.prepareStatement(str);
            instituteprepared.setString(1, sectionname.toLowerCase()); 
            instituteprepared.setString(2, sectionid);  
            instituteprepared.setString(3,sectionbean.getinstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
            
            if(!rs1.next()){
            	
			String query="update section set sectionname=?, dateofcreation=?,description=?,ipaddress=?,status=?,instituteid=?  where sectionid=? ";
			settingsprepared = sectioncon.prepareStatement(query);
			
			settingsprepared.setString(1, sectionname);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,sectiondesi);
			settingsprepared.setString(4, sectionbean.getIpaddess());
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, sectionbean.getinstituteid());
			settingsprepared.setString(7,sectionid);


			rs = settingsprepared.executeUpdate();


            }else
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
			
			if(sectioncon != null)
				sectioncon.close();
			
			if(instituteprepared != null) 
				instituteprepared.close(); 
			
			if(rs1 != null)
				rs1.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/section/SectionActive.jsp
	    * This method is accessed from kycportal/jsp/masterentries/section/SectionRestore.jsp
	    * change section status as A(Active,Restore)        - prasanth
	    @param  status  that can be used to display all details from sections by instituteid,sectionid wise
	    *
	    @param dateofcreation that can be used to display all details from sections by ,sectionid wise
	    *
	    @param instituteid  that can be used to display all details from sections by ,sectionid wise
		*
		@param ipaddress that can be used to display all details from sections by ,sectionid wise
		*
		@param createdby that can be used to display all details from sections by ,sectionid wise
		*                    
	    @return the integer by which result can be printed on the screen 
	   
	 */
    public int Restoresections() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	
		
    	try
    	{log.info("invoking Restoresections,active from com.iGrandee.MasterEntries.Section.SectionEntry");
            sectioncon = ConnectionManager.getKycConnection();

    			String query="update section set status=?, dateofcreation=?,ipaddress=?,instituteid=?  where sectionid=? ";
    			settingsprepared = sectioncon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, sectionbean.getIpaddess());
    			settingsprepared.setString(4,sectionbean.getinstituteid());
    			settingsprepared.setString(5, sectionbean.getsectionid());


    		
    			rs = settingsprepared.executeUpdate();

		}catch(Exception exception) { 
			
			log.error(exception);			
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(sectioncon != null)
				sectioncon.close();
		}
    	return rs;
    }
   
    /**
	   * This method is accessed from kycportal/jsp/masterentries/section/SectionTrashPriview.jsp
	   * check No of  Student,staff in this Section:      - prasanth
	   @param  instituteid  that can be used to check duplicate names  from sections by instituteid,sectionid wise
	   *
	   @param sectionid that can be used to check duplicate names   from sections by instituteid,sectionid wise  
	   *                  
	   @return the integer by which result can be printed on the screen 
	 */
    public ArrayList checkTrashSection(String sectionid,String instituteid)
    {
    	
		ArrayList list=null;
		try
		{log.info("invoking checkTrashSection from com.iGrandee.MasterEntries.Section.SectionEntry");
			select_query="SELECT count(e.sectionid) as studentcount,'Student' as status FROM section c,studentallocation d,sectionschedule e where c.sectionid='"+sectionid+"' and c.instituteid='"+instituteid+"' and c.status='A' and c.sectionid=e.sectionid and d.sectionscheduleid=e.sectionscheduleid union SELECT count(e.sectionid) as studentcount,'Staff' as status FROM section c,subjectallotment d, sectionschedule e where c.sectionid='"+sectionid+"' and c.sectionid=e.sectionid and c.status='A' and d.sectionpublishid=e.sectionscheduleid order by  status";
			list=common_data_object.getListMap(select_query);
		} 
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    /**
	    * This method is accessed from kycportal/jsp/masterentries/section/checkDuplicate.jsp
	    * check duplicate section      - prasanth
	    @param  sectionname,instituteid,sectionid  that can be used to check duplicate from sections by instituteid,sectionid wise
	    *
	    @param  instituteid  that can be used to check duplicate names  from sections by instituteid,sectionid wise
	    *
		@param sectionid that can be used to check duplicate names   from sections by instituteid,sectionid wise  
		*                                    
	    @param sectionname that can be used to check duplicate names   from sections by instituteid,sectionid wise  
	    *                                    
	    @return the boolean by which result can be printed on the screen 
	 */
    public boolean checkDuplicateupdate(String sectionname,String sectionid,String instituteid)
    { 
    	boolean return_flag = false;
    	String return_string = null;
    	try
    	{
    		log.info("invoking checkDuplicateupdate from com.iGrandee.MasterEntries.Section.SectionEntry");
    		String select_query = "SELECT sectionname FROM section  where sectionname='"+sectionname+"' and status='A' and instituteid='"+instituteid+"'and  sectionid <> '"+sectionid+"' " ;
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
	  * This method is accessed from kycportal/jsp/masterentries/section/SectionUpdateByClick.jsp
	  * To display all section    lists  - prasanth
	 
	   @param  sectionid   that can be get all section name ,description details from  section table by sectionid wise
	   *              
	   @return  the ArrayList for    printed the details on the screen 
	 */
 public ArrayList getDetailsForuadate(String sectionid)
 {
		ArrayList list=null;
		try
		{log.info("invoking get_All_Section from com.iGrandee.MasterEntries.section.sectionEntry");
			select_query="select sectionid,sectionname,description from section where sectionid='"+sectionid+"' and  status='A'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    DateTime date_object;
    Connection sectioncon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    SectionBean sectionbean;
    String select_query;
    Statement stmt;
    ResultSet rs;
}