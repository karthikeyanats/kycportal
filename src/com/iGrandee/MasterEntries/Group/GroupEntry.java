package com.iGrandee.MasterEntries.Group;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.iGrandee.MasterEntries.Group.GroupBean;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import org.apache.log4j.Logger;

public class GroupEntry
{
	static Logger log = Logger.getLogger(GroupEntry.class);

    public GroupEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        groupbean = new GroupBean();
        groupcon      = null;


        select_query = null;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/GroupSubmit.jsp
	    * INSERT group details     - prasanth
	    * Returns an Integer  by which result can be printed on the screen. 
        @param  groupid  that can be inserted to standardgroup table
        *
		@param groupname that can be inserted to standardgroup table
		*
		@param description that can be inserted to standardgroup table
		*
		@param dateofcreation that can be inserted to standardgroup table
		*
		@param createdby that can be inserted to standardgroup table
		*
		@param ipaddress that can be inserted to standardgroup table
		*
		@param instituteid that can be inserted to standardgroup table
		*
		@param groupstatus that can be inserted to standardgroup table
		*                     
	   @return      the integer by which result can be printed on the screen
	 */
    public int insertgroups()throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

        try
        
    	{
        	
        	log.info("invoking insertgroups from com.iGrandee.MasterEntries.Group.GroupEntry");
        groupcon = ConnectionManager.getKycConnection();
       
        
        String str			= "select groupid,groupname from standardgroup where groupname=? and instituteid=? and groupstatus <> ? ";
        instituteprepared	= groupcon.prepareStatement(str);
        instituteprepared.setString(1, groupbean.getgroupname().toLowerCase());
        instituteprepared.setString(2, groupbean.getinstituteid());
        instituteprepared.setString(3, "X"); 
        rs1	= instituteprepared.executeQuery(); 
        if(!rs1.next())
        {
        	
       
		long l = common_data_object.fmaxId("select max(groupid)from standardgroup");

				String query="insert into standardgroup (groupid,groupname,description,dateofcreation,createdby,ipaddress,instituteid,groupstatus) values(?,?,?,?,?,?,?,?)";
		settingsprepared = groupcon.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,groupbean.getgroupname());
		settingsprepared.setString(3,groupbean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, groupbean.getCreatedBy());
		settingsprepared.setString(6, groupbean.getIpaddess());
		settingsprepared.setString(7, groupbean.getinstituteid());
		settingsprepared.setString(8, "A");
	   result = settingsprepared.executeUpdate();
	   
	   
	long l1 = common_data_object.fmaxId("select max(grouplogid)from grouplog");
	String query1="insert into grouplog (grouplogid,groupid,grouplogdetail,dateofcreation,grouplogstatus,createdby) values(?,?,?,?,?,?)";

	settingsprepared = groupcon.prepareStatement(query1);
	settingsprepared.setLong(1, l1);
	settingsprepared.setLong(2,l);
	settingsprepared.setString(3,groupbean.getgetgrouplogdetail());
	settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	settingsprepared.setString(5,"A");
	settingsprepared.setString(6, groupbean.getCreatedBy());

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
			
			if(groupcon != null)
				groupcon.close();
			
			if(instituteprepared != null)
				instituteprepared.close();
			
			if(rs1 != null)
				rs1.close();
		}
return result;
}
    
    /**
	  * This method is accessed from kycportal/jsp/masterentries/Board/GroupList.jsp
	  * get all active group list     - prasanth
	  @param  instituteid  that can be used to display all details from standardgroup table by instituteid wise
	  *                
	  @return      the ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_groups(String instituteid)
    {
		ArrayList list=null;
	
		
		try
		{log.info("invoking get_All_groups from com.iGrandee.MasterEntries.Group.GroupEntry");
			select_query="select groupid,instituteid,groupname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,groupstatus,ipaddress from standardgroup where instituteid='"+instituteid+"' and groupstatus='A' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
			
				
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);					
			}
	    	
	    	return list;
	    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/GroupTrash.jsp
	    * change group status as T(Trash) group details     - prasanth
	    @param  instituteid  that can be used to update all details to standardgroup table by groupid wise
	    *
		@param groupname that can be used to update all details to standardgroup table
		*
		@param dateofcreation that can be used to update all details to standardgroup table
		*
		@param createdby that can be used to update all details to standardgroup table
		*
		@param ipaddress that can be used to update all details to standardgroup table
		*
		@param instituteid that can be used to update all details to standardgroup table
		*                    
	   @return  int by which result can be printed on the screen
	 */
    public int Updatetashgroups() throws SQLException
    {
    	String groupstatus=groupbean.getgroupstatus();
    	String groupid=groupbean.getgroupid();
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

		
    	int rs=0;
    	int result=0;
    	try
    	{log.info("invoking Updatetashgroups from com.iGrandee.MasterEntries.Group.GroupEntry");
            groupcon = ConnectionManager.getKycConnection();

            
        	String query="update standardgroup set groupstatus=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=? where groupid=?";
			settingsprepared = groupcon.prepareStatement(query);
			settingsprepared.setString(1, groupstatus);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, groupbean.getIpaddess());
			settingsprepared.setString(4, groupbean.getCreatedBy());
			settingsprepared.setString(5, groupbean.getinstituteid());
			settingsprepared.setString(6,groupid);
			rs = settingsprepared.executeUpdate();
			
			long l1 = common_data_object.fmaxId("select max(grouplogid)from grouplog");
			String query1="insert into grouplog (grouplogid,groupid,grouplogdetail,dateofcreation,grouplogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = groupcon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,groupid);
			settingsprepared.setString(3,groupbean.getgetgrouplogdetail());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, groupbean.getCreatedBy());

			result = settingsprepared.executeUpdate();
			
    	}
    		
			catch(Exception exception)
			{ 
					
				log.error(exception);						
				}
		    	finally
				{
					if(settingsprepared != null)
						settingsprepared.close();
					
					if(groupcon != null)
						groupcon.close();
				}
		    	return rs;
		    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/Board/GroupTrashListview.jsp
	  * get all group trash list    - prasanth
	  * change group status as T(Trash) group details     - prasanth
	  @param  instituteid, that can be used to display all details from standardgroup table by instituteid wise
	  *     
	   @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_groupTrashList(String instituteid)
    {
		ArrayList list=null;
		try
		{log.info("invoking get_All_groupTrashList from com.iGrandee.MasterEntries.Group.GroupEntry");
			select_query="select groupid,instituteid,groupname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,groupstatus from standardgroup where instituteid='"+instituteid+"' and groupstatus='T' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/Board/GroupDeactiveList.jsp
	   * get all group Deactivate list    - prasanth
	   @param  instituteid, that can be used to display all details from standardgroup table by instituteid wise
	   *                    
	   @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_groupDeactivateList(String instituteid)
    {
		ArrayList list=null;
		try
		{log.info("invoking get_All_groupDeactivateList from com.iGrandee.MasterEntries.Group.GroupEntry");
			select_query="select groupid,instituteid,groupname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,groupstatus from standardgroup where instituteid='"+instituteid+"' and groupstatus='D' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);	
		}
		return list;
	}
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/GroupDelete.jsp
	    * change group status X(Delete)    - prasanth
	    @param  groupstatus that can be used to update all details to standardgroup table by groupid,instituteid wise
	    * 
	    @param groupname that can be used to update all details to standardgroup table
	    *
		@param dateofcreation that can be used to update all details to standardgroup table
		*
		@param createdby that can be used to update all details to standardgroup table
		*
		@param ipaddress that can be used to update all details to standardgroup table
		*
		@param instituteid that can be used to update all details to standardgroup table 
		*
		@param group id that can be used to update all details to standardgroup table   
		*               
	   @return  int by which result can be printed on the screen
	 */
    public int Deletegroups()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	int result=0;
    	try
    	{
    		log.info("invoking Deletegroups com.iGrandee.MasterEntries.Group.GroupEntry");
        	String groupid=groupbean.getgroupid();

            groupcon = ConnectionManager.getKycConnection();

			String query="update standardgroup set groupstatus=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where groupid=? ";
			settingsprepared = groupcon.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, groupbean.getIpaddess());
			settingsprepared.setString(4, groupbean.getCreatedBy());
			settingsprepared.setString(5, groupbean.getinstituteid());
			settingsprepared.setString(6,groupid);
			
			rs = settingsprepared.executeUpdate();

			long l1 = common_data_object.fmaxId("select max(grouplogid)from grouplog");
			String query1="insert into grouplog (grouplogid,groupid,grouplogdetail,dateofcreation,grouplogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = groupcon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,groupid);
			settingsprepared.setString(3,"X");
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, groupbean.getCreatedBy());

			result = settingsprepared.executeUpdate();

    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(groupcon != null)
				groupcon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/GroupDeactiveFinal.jsp
	    * change group status as  D(Deactivate)    - prasanth
	    @param  groupstatus that can be used to update all details to standardgroup table by groupid,instituteid wise
	    *
	    @param groupname that can be used to update all details to standardgroup table
	    *
		@param dateofcreation that can be used to update all details to standardgroup table
		*
		@param createdby that can be used to update all details to standardgroup table
		*
		@param ipaddress that can be used to update all details to standardgroup table
		*
		@param instituteid that can be used to update all details to standardgroup table 
		*
		@param group id that can be used to update all details to standardgroup table  
		*                     
	   @return  int by which result can be printed on the screen
	 */
    public int groupsDeactivate()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{
    		log.info("invoking groupsDeactivate com.iGrandee.MasterEntries.Group.GroupEntry");
        	String groupid=groupbean.getgroupid();
            groupcon = ConnectionManager.getKycConnection();

			String query="update standardgroup set groupstatus=? ,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where groupid=? ";
			settingsprepared = groupcon.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, groupbean.getIpaddess());
			settingsprepared.setString(4, groupbean.getCreatedBy());
			settingsprepared.setString(5, groupbean.getinstituteid());
			settingsprepared.setString(6,groupid);
			rs = settingsprepared.executeUpdate();

			long l1 = common_data_object.fmaxId("select max(grouplogid)from grouplog");
			String query1="insert into grouplog (grouplogid,groupid,grouplogdetail,dateofcreation,grouplogstatus,createdby) values(?,?,?,?,?,?)";
			settingsprepared = groupcon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,groupid);
			settingsprepared.setString(3,groupbean.getgetgrouplogdetail());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, groupbean.getCreatedBy());

			result = settingsprepared.executeUpdate();

    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(groupcon != null)
				groupcon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/GroupEditUpdate.jsp
	    * update group details     - prasanth
	    @param  groupname that can be used to update all details to standardgroup table by groupid,instituteid wise
	    *
	    @param groupname that can be used to update all details to standardgroup table
	    *
		@param dateofcreation that can be used to update all details to standardgroup table
		*
		@param createdby that can be used to update all details to standardgroup table
		*
		@param description that can be used to update all details to standardgroup table
		*
		@param ipaddress that can be used to update all details to standardgroup table
		*
		@param instituteid that can be used to update all details to standardgroup table 
		*
		@param group id that can be used to update all details to standardgroup table 
		*                      
	    @return  int by which result can be printed on the screen
	 */
    public int UpdateEdittgroups()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

    	int rs=0;
    	
    	int result=0;

    	try
    	{
    		log.info("invoking UpdateEdittgroups com.iGrandee.MasterEntries.Group.GroupEntry");
        	String groupname=groupbean.getgroupname();
        	String groupid=groupbean.getgroupid();
        	String groupdesi=groupbean.getDescription();
    		
            groupcon = ConnectionManager.getKycConnection();

            
            
            
            String str			= "select groupname from standardgroup where groupname=? and groupid<>? and instituteid=? and groupstatus <> ?";
            instituteprepared	= groupcon.prepareStatement(str);
            instituteprepared.setString(1, groupname.toLowerCase());
            instituteprepared.setString(2, groupid);
            instituteprepared.setString(3,groupbean.getinstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
            
            if(!rs1.next()){
            	
            
			String query="update standardgroup set groupname=?, dateofcreation=?,description=?,ipaddress=?,createdby=?,instituteid=?  where groupid=? ";
			settingsprepared = groupcon.prepareStatement(query);
			
			settingsprepared.setString(1, groupname);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,groupdesi);
			settingsprepared.setString(4, groupbean.getIpaddess());
			settingsprepared.setString(5, groupbean.getCreatedBy());
			settingsprepared.setString(6, groupbean.getinstituteid());
			settingsprepared.setString(7,groupid);
			rs = settingsprepared.executeUpdate();
			
			long l1 = common_data_object.fmaxId("select max(grouplogid)from grouplog");
			String query1="insert into grouplog (grouplogid,groupid,grouplogdetail,dateofcreation,grouplogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = groupcon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,groupid);
			settingsprepared.setString(3,groupbean.getgetgrouplogdetail());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, groupbean.getCreatedBy());

			result = settingsprepared.executeUpdate();
			
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
			
			if(groupcon != null)
				groupcon.close();
			
			if(instituteprepared != null)
				instituteprepared.close();
			
			if(rs1 != null)
				rs1.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/GroupRestore.jsp
	    * change group status as A (restore)     - prasanth
	    @param  groupname that can be used to update all details to standardgroup table by groupid,instituteid wise
	    * 
	    @param dateofcreation that can be used to update all details to standardgroup table
	    *
		@param createdby that can be used to update all details to standardgroup table
		*
		@param ipaddress that can be used to update all details to standardgroup table
		*
		@param instituteid that can be used to update all details to standardgroup table 
		*
		@param group id that can be used to update all details to standardgroup table 
		*     
	    @return  int by which result can be printed on the screen
	 */
    public int Restoregroups() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	int result=0;
		
    	try
    	{
    		log.info("invoking Restoregroups com.iGrandee.MasterEntries.Group.GroupEntry");
        	String groupid=groupbean.getgroupid();
            groupcon = ConnectionManager.getKycConnection();

    			String query="update standardgroup set groupstatus=?, dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where groupid=? ";
    			settingsprepared = groupcon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, groupbean.getIpaddess());
    			settingsprepared.setString(4, groupbean.getCreatedBy());
    			settingsprepared.setString(5, groupbean.getinstituteid());
    			settingsprepared.setString(6,groupid);

    			rs = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(grouplogid)from grouplog");
    			String query1="insert into grouplog (grouplogid,groupid,grouplogdetail,dateofcreation,grouplogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = groupcon.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,groupid);
    			settingsprepared.setString(3,"Restore");
    			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(5,"A");
    			settingsprepared.setString(6, groupbean.getCreatedBy());

    			result = settingsprepared.executeUpdate();
    			

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(groupcon != null)
				groupcon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/GroupActive.jsp
	    * change group status as  A(Active)    - prasanth
	    @param  groupname, dateofcreation,description,ipaddress,createdby,instituteid that can be used to update all details to standardgroup table by groupid,instituteid wise
	    *
	    @param dateofcreation that can be used to update all details to standardgroup table
	    *
		@param createdby that can be used to update all details to standardgroup table
		*
		@param ipaddress that can be used to update all details to standardgroup table
		*
		@param instituteid that can be used to update all details to standardgroup table 
		*
		@param group id that can be used to update all details to standardgroup table 
		*                        
	   @return  int by which result can be printed on the screen
	 */
    public int Activegroups() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	int result=0;
    	
		
    	try
    	{
    		log.info("invoking Activegroups com.iGrandee.MasterEntries.Group.GroupEntry");
        	String groupid=groupbean.getgroupid();
            groupcon = ConnectionManager.getKycConnection();

    			String query="update standardgroup set groupstatus=?, dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where groupid=? ";
    			settingsprepared = groupcon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, groupbean.getIpaddess());
    			settingsprepared.setString(4, groupbean.getCreatedBy());
    			settingsprepared.setString(5, groupbean.getinstituteid());
    			settingsprepared.setString(6,groupid);

    		
    			rs = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(grouplogid)from grouplog");
    			String query1="insert into grouplog (grouplogid,groupid,grouplogdetail,dateofcreation,grouplogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = groupcon.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,groupid);
    			settingsprepared.setString(3,"Active");
    			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(5,"A");
    			settingsprepared.setString(6, groupbean.getCreatedBy());

    			result = settingsprepared.executeUpdate();
    			

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(groupcon != null)
				groupcon.close();
		}
    	return rs;
    }
    /**
   	    * This method is accessed from kycportal/jsp/masterentries/Board/GroupTrashPriview.jsp
   	    * check No of  Standard in this Group: - prasanth
   	    @param  instituteid that can be used to count the alocated group from standardgroup table by groupid,instituteid wise
   	    *
	 	@param group id that can be used to count the alocated group from standardgroup table by groupid,instituteid wise  
	 	*                     
	   @return  String by which result can be printed on the screen
   	 */
    public String checkTrashgroup(String instituteid)
    {
    	String list=null;
		try
		{log.info("invoking checkTrashgroup com.iGrandee.MasterEntries.Group.GroupEntry");
			String groupid=groupbean.getgroupid();
			select_query="select count(b.groupid) as groupcount from standardschedule b,standardgroup a where a.groupid=b.groupid and a.instituteid=b.instituteid and a.groupid='"+groupid+"' and a.instituteid='"+instituteid+"'";
			list=common_data_object.getString(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);	
		}
		return list;
	}
    /**
	    * This method is accessed from kycportal/jsp/masterentries/Board/checkDuplicate.jsp
	    * check duplicate group  (update)    - prasanth
	    @param  instituteid that can be used to check duplicate names from standardgroup table by groupid,instituteid wise
	    *
	    @param  groupname that can be used to check duplicate names from standardgroup table by groupid,instituteid wise
	    *
	 	@param groupid that can be used to check duplicate names from standardgroup table by groupid,instituteid wise     
	 	*                                   
	   @return  boolean by which result can be printed on the screen
	 */
    public boolean checkDuplicateupdate(String groupname,String groupid,String instituteid)
    {
    	boolean return_flag = false;
    	String return_string = null;
    	try
    	{
    		log.info("invoking checkDuplicateupdate com.iGrandee.MasterEntries.Group.GroupEntry");
    		String select_query = "SELECT groupname FROM standardgroup  where groupname='"+groupname+"' and instituteid='"+instituteid+"' and groupstatus='A' and  groupid <> '"+groupid+"' " ;
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
	   * This method is accessed from kycportal/jsp/masterentries/Group/GroupUpdateByClick.jsp
	   * To display all    group lists  - prasanth
	   @param  groupid   that can be get all group name ,description details from  to standardgroup table by groupid wise
	   *               
	   @return  the ArrayList for    printed the details on the screen 
	 */
 public ArrayList getDetailsForuadate(String groupid)
 {
		ArrayList list=null;
		try
		{log.info("invoking get_All_Group List from com.iGrandee.MasterEntries.Group.GroupEntry");
			select_query="select groupid,groupname,description from standardgroup where groupid='"+groupid+"' and  groupstatus='A'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    DateTime date_object;
    Connection groupcon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    GroupBean groupbean;
    String select_query;
    Statement stmt;
    ResultSet rs;
}