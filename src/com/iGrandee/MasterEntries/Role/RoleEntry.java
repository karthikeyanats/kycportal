package com.iGrandee.MasterEntries.Role;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.iGrandee.MasterEntries.Role.RoleBean;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;

import com.iGrandee.Circular.CircularEntryQuery;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import org.apache.log4j.Logger;

public class RoleEntry
{
	static Logger log = Logger.getLogger(RoleEntry.class);

    public RoleEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        RoleBean = new RoleBean();
        rolecon      = null;


        select_query = null;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/role/RoleSubmit.jsp
	   * insert   role details      - prasanth
       * Returns an Integer  by which result can be printed on the screen. 
	    @param  roleid that can be inserted to role table
	    *
		@param rolename that can be inserted to role table
		*
		@param description that can be inserted to role table
		*
		@param instituteid that can be inserted to role table
		*
		@param dateofcreation that can be inserted to role table
		*
		@param status that can be inserted to role table
		*
               
	   @return      the integer by which result can be printed on the screen
	 */
    public int insertRoles()throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;


        try
    	{
        	log.info("invoking insertRoles from com.iGrandee.MasterEntries.Role.RoleEntry");

        rolecon = ConnectionManager.getKycConnection();
        
        
        String str			= "select roleid,rolename from role where rolename=? and instituteid=? and status <> ? ";
        instituteprepared	= rolecon.prepareStatement(str);
        instituteprepared.setString(1, RoleBean.getRolename().toLowerCase());
        instituteprepared.setString(2, RoleBean.getinstituteid());
        instituteprepared.setString(3, "X");
        rs1	= instituteprepared.executeQuery(); 
        if(!rs1.next())
        {
        	
       
		long l = common_data_object.fmaxId("select max(roleid)from role");
		String query="insert into role (roleid,rolename,description,instituteid,dateofcreation,status) values(?,?,?,?,?,?)";
		settingsprepared = rolecon.prepareStatement(query);
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,RoleBean.getRolename());
		settingsprepared.setString(3,RoleBean.getDescription());
		settingsprepared.setString(4, RoleBean.getinstituteid());
		settingsprepared.setString(5, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(6, "A");

		result = settingsprepared.executeUpdate();
		
		
		long l1 = common_data_object.fmaxId("select max(rolelogid)from rolelog");
		String query1="insert into rolelog (rolelogid,rolelog,logstatus,dateofcreation,rolelogstatus,createdby) values(?,?,?,?,?,?)";

		settingsprepared = rolecon.prepareStatement(query1);
		settingsprepared.setLong(1, l1);
		settingsprepared.setLong(2,l);
		settingsprepared.setString(3,RoleBean.getlogstatus());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5,"A");
		settingsprepared.setLong(6, 1);

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
				
				if(instituteprepared!=null)
					instituteprepared.close();
				
				if(rolecon != null)
					rolecon.close();
				
				if(rs1!=null)
				rs1.close();
			}
    return result;
}
    
   
    /**
	   * This method is accessed from kycportal/jsp/masterentries/role/RoleList.jsp
	   * list all active  role details      - prasanth
	   * Returns an Integer  by which result can be printed on the screen. 
	    @param  instituteid   that can be get all details by  instituteid wise from  role table
	    *            
	    @return      the ArrayList for  printed the details  on the screen
	 */
    public ArrayList get_All_Roles(String instituteid)
    {
		ArrayList list=null;
		try
		{
        	log.info("invoking get_All_Roles from com.iGrandee.MasterEntries.Role.RoleEntry");

			select_query="select roleid,instituteid,rolename,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,status from role where instituteid='"+instituteid+"' and status='A' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);		
		}
		return list;
	}
    /**
	 * This method is accessed from kycportal/jsp/masterentries/role/RoleTrash.jsp
	 * change   role status as T(Trash)      - prasanth
	 * Returns an int  by which result can be printed on the screen. 
     *
     @param  roleid status that can be update the details in role table by roleid wise
     * 
     @param rolename status that can be update the details in role table by roleid wise
     *
     @param description status that can be update the details in role table by roleid wise
     *
     @param instituteid status that can be update the details in role table by roleid wise
     *
     @param dateofcreation status that can be update the details in role table by roleid wise
     *
	          
	 @return  the int for  by which result can be printed on the screen
	 */
    public int Updatetashroles()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;

    	String status=RoleBean.getStatus();
    	String roleid=RoleBean.getRoleid();

    	int rs=0;
    	int result=0;
    	try
    	{
    		log.info("invoking Updatetashroles from com.iGrandee.MasterEntries.Role.RoleEntry");
    		 rolecon = ConnectionManager.getKycConnection();

 			String query="update role set status=?,dateofcreation=?,instituteid=?  WHERE roleid=?";
 			settingsprepared = rolecon.prepareStatement(query);
 			settingsprepared.setString(1, status);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, RoleBean.getinstituteid());
			settingsprepared.setString(4, roleid);



 			rs = settingsprepared.executeUpdate();
 			

 			long l1 = common_data_object.fmaxId("select max(rolelogid)from rolelog");
 			String query1="insert into rolelog (rolelogid,rolelog,logstatus,dateofcreation,rolelogstatus,createdby) values(?,?,?,?,?,?)";

 			settingsprepared = rolecon.prepareStatement(query1);
 			settingsprepared.setLong(1, l1);
 			settingsprepared.setString(2,RoleBean.getRoleid());
 			settingsprepared.setString(3,"Trash");
 			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
 			settingsprepared.setString(5,"A");
 			settingsprepared.setLong(6, 1);

 			result = settingsprepared.executeUpdate();

    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);	
			
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(rolecon != null)
				rolecon.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/role/RoleTrashListview.jsp
	  * list all trash list   role       - prasanth
	    @param  instituteid   that can be get all  details from  to role table by instituteid wise
	    *
	   @return  the ArrayList for    printed the details on the screen 
	 */
    public ArrayList get_All_RoleTrashList(String instituteid)
    {
		ArrayList list=null;
		try
		{
			log.info("invoking get_All_RoleTrashList from com.iGrandee.MasterEntries.Role.RoleEntry");
			select_query="select roleid,instituteid,rolename,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,status from role where instituteid='"+instituteid+"' and status='T' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);		
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/role/RoleDeactiveView.jsp
	   * list all Deactive roles      - prasanth
	   @param  instituteid   that can be get all deactive details from   role table by instituteid wise
	    *              
	   @return  the ArrayList for    printed the details on the screen 
	 */
    public ArrayList get_All_roleDeactivateList(String instituteid)
    {
		ArrayList list=null;
		try
		{
			log.info("invoking get_All_roleDeactivateList from com.iGrandee.MasterEntries.Role.RoleEntry");
			select_query="select roleid,instituteid,rolename,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,status from role where instituteid='"+instituteid+"' and  status='D' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);		
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/role/RoleDelete.jsp
	   * change  role status as X (Delete)      - prasanth
	   * @param  roleid that can be updated to role table by roleid wise
	   *
	   @param rolename that can be updated to role table by roleid wise
	   *
	   @param status that can be updated to role table by roleid wise
	   *
	   @param dateofcreation that can be updated to role table by roleid wise
	   *
	   @param  instituteid that can be updated to role table by roleid wise 
	   *             
	   @return  the int for    printed the result on the screen 
	 */
    public int DeleteRoles()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{
    		log.info("invoking DeleteRoles from com.iGrandee.MasterEntries.Role.RoleEntry");
        	String roleid=RoleBean.getRoleid();

            rolecon = ConnectionManager.getKycConnection();

			String query="update role set status=?,dateofcreation=?,instituteid=?  where roleid=? ";
			settingsprepared = rolecon.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, RoleBean.getinstituteid());

			settingsprepared.setString(4,roleid);
			rs = settingsprepared.executeUpdate();
			

			long l1 = common_data_object.fmaxId("select max(rolelogid)from rolelog");
			String query1="insert into rolelog (rolelogid,rolelog,logstatus,dateofcreation,rolelogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = rolecon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,RoleBean.getRoleid());
			settingsprepared.setString(3,"Deleted");
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setLong(6, 1);

			result = settingsprepared.executeUpdate();



    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);					
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(rolecon != null)
				rolecon.close();
		}
    	return rs;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/role/RoleDeactive.jsp
	   * change role status ad D(Deactive)      - prasanth
	   * @param  roleid  that can be updated to role table by roleid wise
	   *
	   @param status that can be updated to role table by roleid wise
	   *
	   @param instituteid that can be updated to role table by roleid wise
	   *
	              
	   @return  the int for    printed the result on the screen 
	 */
    public int rolesDeactivate()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	int result=0;
    	try
    	{
    		log.info("invoking rolesDeactivate from com.iGrandee.MasterEntries.Role.RoleEntry");
        	String roleid=RoleBean.getRoleid();

            rolecon = ConnectionManager.getKycConnection();

			String query="update role set status=?,dateofcreation=?,instituteid=? where roleid=? ";
			settingsprepared = rolecon.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, RoleBean.getinstituteid());

			settingsprepared.setString(4,roleid);
			rs = settingsprepared.executeUpdate();


			long l1 = common_data_object.fmaxId("select max(rolelogid)from rolelog");
			String query1="insert into rolelog (rolelogid,rolelog,logstatus,dateofcreation,rolelogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = rolecon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,RoleBean.getRoleid());
			settingsprepared.setString(3,"Deactive");
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setLong(6, 1);

			result = settingsprepared.executeUpdate();


    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);					
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(rolecon != null)
				rolecon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/role/RoleEditUpdate.jsp
	    * update  role details      - prasanth
	    @param  rolename that can be updated to role table by roleid wise
	    * 
	    @param dateofcreation that can be updated to role table by roleid wise
	    *
	    @param description that can be updated to role table by roleid wise
	    *
	    @param instituteid that can be updated to role table by roleid wise
	    *
	    @param roleid that can be updated to role table by roleid wise
	    *
	                 
	   @return  the int for    printed the result on the screen 
	 */
    public int UpdateEdittRoles()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	int result=0;
    	ResultSet rs1=null;
    	try
    	{
    		log.info("invoking UpdateEdittRoles from com.iGrandee.MasterEntries.Role.RoleEntry");
            rolecon = ConnectionManager.getKycConnection();

        	String rolename=RoleBean.getRolename();
        	String roleid=RoleBean.getRoleid();
        	String roledesi=RoleBean.getDescription();
    		
            rolecon = ConnectionManager.getKycConnection();

            
            
            String str			= "select rolename from role where rolename=? and roleid<>? and instituteid=? and status <> ?";
            instituteprepared	= rolecon.prepareStatement(str);
            instituteprepared.setString(1, rolename.toLowerCase());
            instituteprepared.setString(2, roleid); 
            instituteprepared.setString(3,RoleBean.getinstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
            
            if(!rs1.next())
            {
          
			String query="update role set rolename=?,dateofcreation=? , description=?,instituteid=?  where roleid=? ";
			settingsprepared = rolecon.prepareStatement(query);
			
			settingsprepared.setString(1, rolename);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));

			settingsprepared.setString(3,roledesi);
			settingsprepared.setString(4, RoleBean.getinstituteid());

			settingsprepared.setString(5,roleid);


			rs = settingsprepared.executeUpdate();
			

			long l1 = common_data_object.fmaxId("select max(rolelogid)from rolelog");
			String query1="insert into rolelog (rolelogid,rolelog,logstatus,dateofcreation,rolelogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = rolecon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,RoleBean.getRoleid());
			settingsprepared.setString(3,"Updated");
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setLong(6, 1);

			result = settingsprepared.executeUpdate();
    	}
			 else
			 {
	            	rs	= 1000;
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
			
			if(rolecon != null)
				rolecon.close();
			
			if(rs1!=null)
			rs1.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/role/RoleRestore.jsp
	    * change   role status as A (Restore)      - prasanth
	      @param  rolename  that can be updated to role table by roleid wise
	    * 
	    @param dateofcreation  that can be updated to role table by roleid wise
	    *
	    @param description  that can be updated to role table by roleid wise
	    *
	    @param instituteid  that can be updated to role table by roleid wise
	    *
	    @param roleid  that can be updated to role table by roleid wise
	    *
	   @return  the int for    printed the result on the screen 
	 */
    public int Restoreroles() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	int result=0;
		
    	try
    	{
    		log.info("invoking Restoreroles from com.iGrandee.MasterEntries.Role.RoleEntry");
    		String roleid=RoleBean.getRoleid();
            rolecon = ConnectionManager.getKycConnection();

    			String query="update role set status=?,dateofcreation=? ,instituteid=?   where roleid=? ";
    			settingsprepared = rolecon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, RoleBean.getinstituteid());

    			settingsprepared.setString(4,roleid);

    		
    			rs = settingsprepared.executeUpdate();
    			

    			long l1 = common_data_object.fmaxId("select max(rolelogid)from rolelog");
    			String query1="insert into rolelog (rolelogid,rolelog,logstatus,dateofcreation,rolelogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = rolecon.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,RoleBean.getRoleid());
    			settingsprepared.setString(3,"Restored");
    			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(5,"A");
    			settingsprepared.setLong(6, 1);

    			result = settingsprepared.executeUpdate();

		}catch(Exception exception) { 
			
			log.error(exception);					
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(rolecon != null)
				rolecon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/role/RoleActivate.jsp
	    * change role status ad A(Active)      - prasanth
	    * @param  status that can be updated to role table by roleid wise
	    * 
	    @param dateofcreation that can be updated to role table by roleid wise
	    *
	    @param instituteid that can be updated to role table by roleid wise 
	    *            
	   @return  the int for    printed the result on the screen 
	 */
    public int ActivateRoles() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	int result=0;
		
    	try
    	{
		        
    		log.info("invoking ActivateRoles from com.iGrandee.MasterEntries.Role.RoleEntry");
    				String roleid=RoleBean.getRoleid();
		            rolecon = ConnectionManager.getKycConnection();

    			String query="update role set status=?,dateofcreation=? ,instituteid=? where roleid=? ";
    			settingsprepared = rolecon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, RoleBean.getinstituteid());

    			settingsprepared.setString(4,roleid);

    		
    			rs = settingsprepared.executeUpdate();
    			

    			long l1 = common_data_object.fmaxId("select max(rolelogid)from rolelog");
    			String query1="insert into rolelog (rolelogid,rolelog,logstatus,dateofcreation,rolelogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = rolecon.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,RoleBean.getRoleid());
    			settingsprepared.setString(3,"Activated");
    			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(5,"A");
    			settingsprepared.setLong(6, 1);

    			result = settingsprepared.executeUpdate();

		}catch(Exception exception) { 
			
			log.error(exception);					
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(rolecon != null)
				rolecon.close();
		}
    	return rs;
    }
    
    /**
	   * This method is accessed from kycportal/jsp/masterentries/role/RoleTrashPriview.jsp
	   * for find  No of  Staff in this Role      - prasanth
	   * change role status ad A(Active)      - prasanth
	   @param  instituteid   that can be get all details from role table by instituteid wise
	   *
	   @param  roleid   that can be get all details from role table by instituteid wise
	   *
	   @return  the String for    printed the result on the screen 

	 */
    public String checkTrashRoles()
    {
    	String list=null;
		try
		{
			log.info("invoking checkTrashRoles from com.iGrandee.MasterEntries.Role.RoleEntry");
			select_query="select count(b.roleid) as rolecount from staffmaster b where  b.roleid='"+RoleBean.getRoleid()+"' and b.staffstatus='A'";

			list=common_data_object.getString(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);		
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/role/checkDuplicate.jsp
	   * for check duplicate names      - prasanth
	   * change role status ad A(Active)      - prasanth
	   @param  rolename that can be check duplicate names from role table 
	   *
	   @param roleid that can be check duplicate names from role table 
	   *
	   @param instituteid that can be check duplicate names from role table 
	   *
	   @return   boolean for    printed the result on the screen  
	 */
    public boolean checkDuplicateupdate(String rolename,String roleid,String instituteid)
    {
    	boolean return_flag = false;
    	String return_string = null;
    	try
    	{
    		log.info("invoking checkDuplicateupdate from com.iGrandee.MasterEntries.Role.RoleEntry");
    		String select_query = "SELECT rolename FROM role  where rolename='"+rolename+"' and status='A' and  instituteid='"+instituteid+"' and roleid <> '"+roleid+"' " ;
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
	   * This method is accessed from kycportal/jsp/masterentries/role/RoleUpdateByClick.jsp
	   * To display all deactive   Role lists  - prasanth
	 
	   @param  roliid   that can be get all role name ,description details from  to role table by roleid wise
	   *              
	   @return  the ArrayList for    printed the details on the screen 
	 */
  public ArrayList getDetailsForuadate(String roleid)
  {
		ArrayList list=null;
		try
		{log.info("invoking get_All_RoleList from com.iGrandee.MasterEntries.Role.RoleEntry");
			select_query="select roleid,rolename,description from role where roleid='"+roleid+"' and  status='A'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    DateTime date_object;
    Connection rolecon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    RoleBean RoleBean;
    String select_query;
    Statement stmt;
    ResultSet rs;
}