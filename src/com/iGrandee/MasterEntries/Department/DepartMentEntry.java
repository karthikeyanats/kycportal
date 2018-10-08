package com.iGrandee.MasterEntries.Department;
import java.sql.PreparedStatement;

import com.iGrandee.MasterEntries.Department.DepartmentBean;
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

public class DepartMentEntry
{
	static Logger log = Logger.getLogger(DepartMentEntry.class);

    public DepartMentEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        departbean = new DepartmentBean();
        departmentcon      = null;

        select_query = null;
    }

    /**
    * This method is accessed from kycportal/jsp/masterentries/department/DepartmentSubmit.jsp
	  * insert department details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

	  * @param  departmentid   that can be inserted to department table
	  * 
	  @param departmentname that can be inserted to department table
	  *
	  @param description that can be inserted to department table
	  *
	  @param dateofcreation that can be inserted to department table
	  *
	  @param createdby that can be inserted to department table
	  *
      @param instituteid that can be inserted to department table
      *
	  @param ipaddress that can be inserted to department table
	  *
	  @param status        that can be inserted to department table  
	  *     
	  @return      the integer by which result can be printed on the screen
	      
     */
   
    public int insertDepartments()throws SQLException
    {
		int result=0;
		int rs=0;
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;


        try
    	{
        	log.info("invoking insertDepartments from com.iGrandee.MasterEntries.Department.DepartmentEntry");
        departmentcon = ConnectionManager.getKycConnection();
		
        
        String str			= "select departmentid,departmentname from department where departmentname=? and instituteid=? and status <> ? ";
        instituteprepared	= departmentcon.prepareStatement(str);
        instituteprepared.setString(1, departbean.getdepartmentname().toLowerCase());
        instituteprepared.setString(2, departbean.getinstituteid());
        instituteprepared.setString(3, "X");
        rs1	= instituteprepared.executeQuery(); 
        if(!rs1.next())
        {
        long l = common_data_object.fmaxId("select max(departmentid)from department");
		String query="insert into department (departmentid,departmentname,description,dateofcreation,createdby,instituteid,ipaddress,status) values(?,?,?,?,?,?,?,?)";
		settingsprepared = departmentcon.prepareStatement(query);		
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,departbean.getdepartmentname());
		settingsprepared.setString(3,departbean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, departbean.getCreatedBy());
		settingsprepared.setString(6, departbean.getinstituteid());
		settingsprepared.setString(7, departbean.getIpaddess());
		settingsprepared.setString(8, "A");

		result = settingsprepared.executeUpdate();

		
			long l1 = common_data_object.fmaxId("select max(departmentlogid)from departmentlog");
			String query1="insert into departmentlog (departmentlogid,departmentid,logstatus,dateofcreation,deptlogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = departmentcon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,departbean.getDepartmentid());
			settingsprepared.setString(3,departbean.getlogstatus());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setLong(6, 1);

			result = settingsprepared.executeUpdate();
        }
        else   
        {  			

        		result	= 1000;
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
				
				if(departmentcon != null)
					departmentcon.close();
				
				if(rs1!=null)
				rs1.close();
			}
    return result;
}
   
  
   
    /**
	  * This method is accessed from kycportal/jsp/masterentries/department/DepartmentList.jsp
	  * list all active  department details  - prasanth
	  * Returns an Integer  by which result can be printed on the screen.  
	   @param  instituteid   that can be get all details by  instituteid wise from  department table    
	   *          
	   @return      the ArrayList for  printed the details  on the screen
	 */
    public ArrayList get_All_Departments(String instituteid)
    {
		ArrayList list=null;
	
		
		try
		{
        	log.info("invoking get_All_Departments from com.iGrandee.MasterEntries.Department.DepartmentEntry");

			select_query="select departmentid,instituteid,departmentname,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,status from department where instituteid='"+instituteid+"' and status='A' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);					
				
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
			}
	    	
	    	return list;
	    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/department/checkDuplicate.jsp
	   * To check whether the department name already exists or not  - prasanth
	   * Returns an ArrayList  by which result can be printed on the screen. 
	   @param  names   that can be check duplicate names  from  department table
	   *
	   @param   instituteid  that can be check duplicate names  from  department table 
	   * 
	   @return  the ArrayList for  by which result can be printed on the screen
	 */
    public ArrayList checkDuplicate(String names,String instituteid)
    {
		ArrayList list=null;
	
		
		try
		{
			log.info("invoking checkDuplicate from com.iGrandee.MasterEntries.Department.DepartmentEntry");

			select_query="select departmentid,departmentname from department where departmentname='"+names+"' and instituteid='"+instituteid+"' and status <> 'X' ";

			list=common_data_object.getListMap(select_query);
			
			
				
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
	    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/department/DepartmentTrash.jsp
	  * change  department status as T (Trash)   - prasanth
	  * Returns an ArrayList  by which result can be printed on the screen. 
	  @param  departmentid that can be update to department table by departmentid wise
	  *
      @param departmentname that can be update to department table by departmentid wise
      *
      @param description that can be update to department table by departmentid wise
      *
      @param dateofcreation that can be update to department table by departmentid wise
      *
      @param createdby that can be update to department table by departmentid wise
      *
      @param   instituteid that can be update to department table by departmentid wise
      *
      @ param   ipaddress that can be update to department table by departmentid wise
      *    
      @param   status that can be update to department table by departmentid wise  
      *   
	  @return  the integer for  by which result can be printed on the screen
	 */
	
    public int UpdatetashDepartments() throws SQLException
    {
    	String status=departbean.getStatus();
    	String Deptid=departbean.getDepartmentid();
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

		
    	int rs=0;
    	int result=0;
    	try
    	{
            departmentcon = ConnectionManager.getKycConnection();

            log.info("invoking update from com.iGrandee.MasterEntries.Department.DepartmentEntry");

            
        	String query="update department set status=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=? where departmentid=?";
			settingsprepared = departmentcon.prepareStatement(query);

			settingsprepared.setString(1, status);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, departbean.getIpaddess());
			settingsprepared.setString(4, departbean.getCreatedBy());
			settingsprepared.setString(5, departbean.getinstituteid());
			settingsprepared.setString(6,Deptid);

			rs = settingsprepared.executeUpdate();
			
			long l1 = common_data_object.fmaxId("select max(departmentlogid)from departmentlog");
			String query1="insert into departmentlog (departmentlogid,departmentid,logstatus,dateofcreation,deptlogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = departmentcon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,departbean.getDepartmentid());
			settingsprepared.setString(3,"Trash");
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setLong(6, 1);

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
					
					if(departmentcon != null)
						departmentcon.close();
				}
		    	return rs;
		    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/department/DepartmantTrashListview.jsp
	  * list all department trash list    - prasanth
	  * Returns an ArrayList  by  result can be printed on the screen. 
	    @param  instituteid   that can be get all details from  to department table by instituteid wise
	  *             
	   @return  the ArrayList for    printed the details on the screen 
	 */
    public ArrayList get_All_DepartmentTrashList(String instituteid)
    {
		ArrayList list=null;
		try
		{
			log.info("invoking get_All_DepartmentTrashList from com.iGrandee.MasterEntries.Department.DepartmentEntry");

			select_query="select departmentid,instituteid,departmentname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,status from department where status='T' and  instituteid='"+instituteid+"' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/masterentries/department/DeactiveView.jsp
	  * To display all deactive   department lists  - prasanth
	 
	   @param  instituteid   that can be get all deactive details from  to department table by instituteid wise
	   *
	                 
	   @return  the ArrayList for    printed the details on the screen 
	 */
    public ArrayList get_All_DepartmentDeactivateList(String instituteid)
    {
		ArrayList list=null;
		try
		{	log.info("invoking get_All_DepartmentDeactivateList from com.iGrandee.MasterEntries.Department.DepartmentEntry");
			select_query="select departmentid,instituteid,departmentname,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,status from department where instituteid='"+instituteid+"' and  status='D' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/masterentries/department/DepartmantDelete.jsp
	   * change status as X in   department   - prasanth
	    @param  departmentid that can be updated to department table  by departmentid wise
	   * 
	    @param departmentname that can be updated to department table  by departmentid wise
	    *
	    @param description that can be updated to department table  by departmentid wise
	    *
	    @param dateofcreation that can be updated to department table  by departmentid wise
	    *
	    @param createdby that can be updated to department table  by departmentid wise
	    *
	    @param instituteid that can be updated to department table  by departmentid wise
	    *
	    @param ipaddress that can be updated to department table  by departmentid wise
	    *
	    @param status that can be updated to department table  by departmentid wise   
	    *        
	   @return  the int for    printed the result on the screen 
	 */
    public int DeleteDepartments()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{log.info("invoking DeleteDepartments from com.iGrandee.MasterEntries.Department.DepartmentEntry");
        	String Deptid=departbean.getDepartmentid();

            departmentcon = ConnectionManager.getKycConnection();

			String query="update department set status=?,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where departmentid=? ";
			settingsprepared = departmentcon.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, departbean.getIpaddess());
			settingsprepared.setString(4, departbean.getCreatedBy());
			settingsprepared.setString(5, departbean.getinstituteid());
			settingsprepared.setString(6,Deptid);
			
			rs = settingsprepared.executeUpdate();
			
			long l1 = common_data_object.fmaxId("select max(departmentlogid)from departmentlog");
			String query1="insert into departmentlog (departmentlogid,departmentid,logstatus,dateofcreation,deptlogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = departmentcon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,departbean.getDepartmentid());
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
			
			if(departmentcon != null)
				departmentcon.close();
		}
    	return rs;
    }
    /**
	 * This method is accessed from kycportal/jsp/masterentries/department/DepartmentDeactive.jsp
	 * change department status as D(Deactive)    - prasanth
	 * @param  departmentid that can be updated to department table  by departmentid wise
	 * 
     @param departmentname that can be updated to department table  by departmentid wise
     *
     @param description that can be updated to department table  by departmentid wise
     *
     @param dateofcreation that can be updated to department table  by departmentid wise
     *
     @param createdby that can be updated to department table  by departmentid wise
     *
     @param instituteid that can be updated to department table  by departmentid wise
     *
     @param ipaddress that can be updated to department table  by departmentid wise 
     *     
     @param status   that can be updated to department table  by departmentid wise 
     *   
    @return  the int for    printed the result on the screen 
	 */
    public int DepartmentsDeactivate()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{
    		log.info("invoking DepartmentsDeactivate from com.iGrandee.MasterEntries.Department.DepartmentEntry");
        	String Deptid=departbean.getDepartmentid();

            departmentcon = ConnectionManager.getKycConnection();

			String query="update department set status=? ,dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where departmentid=? ";
			settingsprepared = departmentcon.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, departbean.getIpaddess());
			settingsprepared.setString(4, departbean.getCreatedBy());
			settingsprepared.setString(5, departbean.getinstituteid());
			settingsprepared.setString(6,Deptid);
			rs = settingsprepared.executeUpdate();


			long l1 = common_data_object.fmaxId("select max(departmentlogid)from departmentlog");
			String query1="insert into departmentlog (departmentlogid,departmentid,logstatus,dateofcreation,deptlogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = departmentcon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,departbean.getDepartmentid());
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
			
			if(departmentcon != null)
				departmentcon.close();
		}
    	return rs;
    }
    
    /**
	  * This method is accessed from kycportal/jsp/masterentries/department/DepartmentEditUpdate.jsp
	  * update  department details  - prasanth
	    @param  departmentid that can be updated to department table  by departmentid wise
	    *
	    @param departmentname that can be updated to department table  by departmentid wise
	    *
	    @param description that can be updated to department table  by departmentid wise
	    *
	    @param dateofcreation that can be updated to department table  by departmentid wise
	    *
	    @param createdby that can be updated to department table  by departmentid wise
	    *
	    @param instituteid that can be updated to department table  by departmentid wise
	    *
	    @param ipaddress that can be updated to department table  by departmentid wise
	    *
	    @param status  that can be updated to department table  by departmentid wise  
	    *          
	   @return  the int for    printed the result on the screen 
	 */
    public int UpdateEdittDepartments()  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{
    		log.info("invoking UpdateEdittDepartments from com.iGrandee.MasterEntries.Department.DepartmentEntry");
        	String deptname=departbean.getdepartmentname();
        	String Deptid=departbean.getDepartmentid();
        	String deptdesi=departbean.getDescription();
    		
            departmentcon = ConnectionManager.getKycConnection();
            
            
            String str			= "select departmentname from department where departmentname=? and departmentid<>? and instituteid=? and status <> ?";
            instituteprepared	= departmentcon.prepareStatement(str);
            instituteprepared.setString(1, deptname.toLowerCase());
            instituteprepared.setString(2, Deptid);
            instituteprepared.setString(3,departbean.getinstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
            if(!rs1.next()){
			
				String query="update department set departmentname=?, dateofcreation=?,description=?,ipaddress=?,createdby=?,instituteid=?  where departmentid=? ";
				settingsprepared = departmentcon.prepareStatement(query);				
				
				settingsprepared.setString(1, deptname);
				settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
				settingsprepared.setString(3,deptdesi);
				settingsprepared.setString(4, departbean.getIpaddess());
				settingsprepared.setString(5, departbean.getCreatedBy());
				settingsprepared.setString(6, departbean.getinstituteid());
				settingsprepared.setString(7,Deptid);
	
	
				rs = settingsprepared.executeUpdate();
				
	
				long l1 = common_data_object.fmaxId("select max(departmentlogid)from departmentlog");
				String query1="insert into departmentlog (departmentlogid,departmentid,logstatus,dateofcreation,deptlogstatus,createdby) values(?,?,?,?,?,?)";
	
				settingsprepared = departmentcon.prepareStatement(query1);
				settingsprepared.setLong(1, l1);
				settingsprepared.setString(2,departbean.getDepartmentid());
				settingsprepared.setString(3,"Updated");
				settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
				settingsprepared.setString(5,"A");
				settingsprepared.setLong(6, 1);
				result = settingsprepared.executeUpdate();
				
            }
            else
            	rs	= 1000;
			
			



    		
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
			
			if(departmentcon != null)
				departmentcon.close();
			
			if(rs1!=null)
			rs1.close();
		}
    	return rs;
    }
    /**
	     * This method is accessed from kycportal/jsp/masterentries/department/DepartmantRestore.jsp
	     * change status as A(Restore) in   department   - prasanth
	     @param  departmentid that can be updated to department table  by departmentid wise
	     * 
	     @param departmentname that can be updated to department table  by departmentid wise
	     *
	     @param description that can be updated to department table  by departmentid wise
	     *
	     @param dateofcreation that can be updated to department table  by departmentid wise
	     *
	     @param createdby that can be updated to department table  by departmentid wise
	     *
	     @param instituteid that can be updated to department table  by departmentid wise
	     *
	     @param ipaddress that can be updated to department table  by departmentid wise 
	     * 
	     @param status that can be updated to department table  by departmentid wise
	     *      
	   @return  the int for    printed the result on the screen 
	 */
    public int RestoreDepartments() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	int result=0;
		
    	try
    	{
    		log.info("invoking RestoreDepartments from com.iGrandee.MasterEntries.Department.DepartmentEntry");
        	String Deptid=departbean.getDepartmentid();
            departmentcon = ConnectionManager.getKycConnection();

    			String query="update department set status=?, dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where departmentid=? ";
    			settingsprepared = departmentcon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, departbean.getIpaddess());
    			settingsprepared.setString(4, departbean.getCreatedBy());
    			settingsprepared.setString(5, departbean.getinstituteid());
    			settingsprepared.setString(6,Deptid);

    		
    			rs = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(departmentlogid)from departmentlog");
    			String query1="insert into departmentlog (departmentlogid,departmentid,logstatus,dateofcreation,deptlogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = departmentcon.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,departbean.getDepartmentid());
    			settingsprepared.setString(3,"Restore");
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
			
			if(departmentcon != null)
				departmentcon.close();
		}
    	return rs;
    }
    /**
    * This method is accessed from kycportal/jsp/masterentries/department/DepartmantActivate.jsp
	* change status as A in   department   - prasanth
	@param  departmentid that can be updated to department table  by departmentid wise
	*
    @param departmentname that can be updated to department table  by departmentid wise
    *
    @param description that can be updated to department table  by departmentid wise
    *
    @param dateofcreation that can be updated to department table  by departmentid wise
    *
    @param createdby that can be updated to department table  by departmentid wise
    *
    @param instituteid that can be updated to department table  by departmentid wise
    *
    @param ipaddress that can be updated to department table  by departmentid wise
    *
    @param status that can be updated to department table  by departmentid wise
    *
	                         
 	@return  the int for    printed the result on the screen 
	 */
    public int ActiveDepartments() throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	int result=0;
		
    	try
    	{
    		log.info("invoking ActiveDepartments from com.iGrandee.MasterEntries.Department.DepartmentEntry");
        	String Deptid=departbean.getDepartmentid();
            departmentcon = ConnectionManager.getKycConnection();

    			String query="update department set status=?, dateofcreation=?,ipaddress=?,createdby=?,instituteid=?  where departmentid=? ";
    			settingsprepared = departmentcon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, departbean.getIpaddess());
    			settingsprepared.setString(4, departbean.getCreatedBy());
    			settingsprepared.setString(5, departbean.getinstituteid());
    			settingsprepared.setString(6,Deptid);

    		
    			rs = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(departmentlogid)from departmentlog");
    			String query1="insert into departmentlog (departmentlogid,departmentid,logstatus,dateofcreation,deptlogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = departmentcon.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,departbean.getDepartmentid());
    			settingsprepared.setString(3,"Active");
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
			
			if(departmentcon != null)
				departmentcon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/department/DepartmentTrashPriview.jsp
	    * check No of  Staff in this Department present or not - prasanth
	    @param  instituteid   that can be check check No of  Staff in this Department present or not 
	    *               
	    @return  the String for    printed the result on the screen 
	 */
    public String checkTrashDepts()
    {
    	String count	= null;
		try
		{
			log.info("invoking checkTrashDepts from com.iGrandee.MasterEntries.Department.DepartmentEntry");
			select_query	= "select count(b.departmentid) as deptcount from staffmaster b where b.departmentid='"+departbean.getDepartmentid()+"' and b.staffstatus='A'";
			count			= common_data_object.getString(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return count;
	}
    /**
	    * This method is accessed from kycportal/jsp/masterentries/department/checkDuplicateUpdatescreen.jsp
	    * To check whethet the department name already exists or not  - prasanth
	    @param  departmentid   that can be check duplication from department table 
	    * 
	    @param instituteid that can be check duplication from department table 
	    *
	   @return  the boolean for    printed the result on the screen 
	 */
    public boolean checkDuplicateupdate(String department,String departmentid,String instituteid)
    {
    	boolean return_flag = false;
    	String return_string = null;
    	try
    	{
    		log.info("invoking checkDuplicateupdate from com.iGrandee.MasterEntries.Department.DepartmentEntry");
    		String select_query = "SELECT departmentname FROM department  where departmentname='"+department+"' and status='A' and instituteid='"+instituteid+"' and departmentid <> '"+departmentid+"' " ;
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
	    * This method is accessed from kycportal/jsp/masterentries/department/DepartmentUpdateByClick.jsp
	    * To display all deactive   department lists  - prasanth
	 
	    @param  departmentid   that can be get all department name,description details from  to department table by deptartmentid wise
	    *              
	    @return  the ArrayList for    printed the details on the screen 
	 */
   public ArrayList getDetailsForuadate(String departmentid)
   {
		ArrayList list=null;
		try
		{log.info("invoking get_All_DepartmentDeactivateList from com.iGrandee.MasterEntries.Department.DepartmentEntry");
			select_query="select departmentid,departmentname,description from department where departmentid='"+departmentid+"' and  status='A'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    DateTime date_object;
    Connection departmentcon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    DepartmentBean departbean;
    String select_query;
    Statement stmt;
    ResultSet rs;
}