package com.iGrandee.MasterEntries.SubjetType;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean;
import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionInfo;
import org.apache.log4j.Logger;
public class SubjectTypeEntry
{
	static Logger log = Logger.getLogger(SubjectTypeEntry.class);

    public SubjectTypeEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        subjecttypecon      = null;


        select_query = null;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeSubmit.jsp
	    * insert subject type details     - prasanth
	    @param  subjecttypeid that can be inserted to subjecttype table
	    * 
	    @param subjectypename that can be inserted to subjecttype table
	    *
	    @param description that can be inserted to subjecttype table
	    *
	    @param dateofcreation that can be inserted to subjecttype table
	    *
	    @param createdby that can be inserted to subjecttype table
	    *
	    @param instituteid that can be inserted to subjecttype table
	    *
	    @param subjecttypestatus that can be inserted to subjecttype table
	    *
	    @return the integer by which result can be printed on the screen
	 */
    public int insertsubjecttypes(SubjectTypeBean sujecttypebean)throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

        try
        
    	{
        	log.info("invoking insert  subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
        subjecttypecon = ConnectionManager.getKycConnection();
        String str			= "select subjecttypeid,subjectypename from subjecttype where subjectypename=? and instituteid=? and subjecttypestatus <> ? ";
        instituteprepared	= subjecttypecon.prepareStatement(str);
        instituteprepared.setString(1, sujecttypebean.getsubjectypename().toLowerCase());
        instituteprepared.setString(2, sujecttypebean.getinstituteid());
        instituteprepared.setString(3, "X");
        rs1	= instituteprepared.executeQuery(); 
        if(!rs1.next()) 
        {
		long l = common_data_object.fmaxId("select max(subjecttypeid)from subjecttype");

		String query="insert into subjecttype (subjecttypeid,subjectypename,description,dateofcreation,createdby,instituteid,subjecttypestatus) values(?,?,?,?,?,?,?)";
		settingsprepared = subjecttypecon.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,sujecttypebean.getsubjectypename());
		settingsprepared.setString(3,sujecttypebean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, sujecttypebean.getCreatedBy());
		settingsprepared.setString(6, sujecttypebean.getinstituteid());
		settingsprepared.setString(7, "A");
	result = settingsprepared.executeUpdate();
	
	
	long l1 = common_data_object.fmaxId("select max(subjecttypelogid)from subjecttypelog");
	String query1="insert into subjecttypelog (subjecttypelogid,subjecttypeid,logdetails,dateofcreation,subjecttypelogstatus,createdby) values(?,?,?,?,?,?)";

	settingsprepared = subjecttypecon.prepareStatement(query1);
	settingsprepared.setLong(1, l1);
	settingsprepared.setLong(2,l);
	settingsprepared.setString(3,sujecttypebean.getsubjecttypelogstatus());
	settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	settingsprepared.setString(5,"A");
	settingsprepared.setString(6, sujecttypebean.getCreatedBy());

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
			
			if(subjecttypecon != null)
				subjecttypecon.close();
			
			if(instituteprepared != null)
				instituteprepared.close();
			
			if(rs1 != null)
				rs1.close();
		}
return result;
}
    
    /**
	  * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeList.jsp
	  * get all   subject type active list    - prasanth
	  @param  instituteid   that can be get all details from   subjecttype table by instituteid wise
	  *                
	  @return   the ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_groups(String instituteid)
    {
		ArrayList list=null;
	
		
		try
		{log.info("invoking get all  subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" );
			select_query="select subjecttypeid,instituteid,subjectypename,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,subjecttypestatus from subjecttype where instituteid='"+instituteid+"' and subjecttypestatus='A' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
			
				
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);					
			}
	    	
	    	return list;
	    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeTrash.jsp
	    * change subject type status as T (Trash)     - prasanth
	    @param subjecttypestatus,dateofcreation,createdby,instituteid   that can be update the detals to   subjecttype table by subjecttypeid,instituteid wise
	    *
	    @param subjectypename that can be updated to subjecttype table
	    *
	    @param dateofcreation that can be updated to subjecttype table
	    *
	    @param createdby that can be updated to subjecttype table
	    *
	    @param instituteid that can be updated to subjecttype table
	    *
	    @param subjecttypestatus that can be updated to subjecttype table
	    *                     
	   @return   the int by which result can be printed on the screen
	 */
    public int Updatetashgroups(SubjectTypeBean sujecttypebean) throws SQLException
    {
    	String subjecttypeid=sujecttypebean.getsubjecttypeid();
    	PreparedStatement settingsprepared  = null;

		
    	int rs=0;
    	int result=0;
    	try
    	{log.info("invoking trash subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
            subjecttypecon = ConnectionManager.getKycConnection();

            
        	String query="update subjecttype set subjecttypestatus=?,dateofcreation=?,createdby=?,instituteid=? where subjecttypeid=?";
			settingsprepared = subjecttypecon.prepareStatement(query);
			settingsprepared.setString(1, "T");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sujecttypebean.getCreatedBy());
			settingsprepared.setString(4, sujecttypebean.getinstituteid());
			settingsprepared.setString(5,subjecttypeid);
			rs = settingsprepared.executeUpdate();
			
			long l1 = common_data_object.fmaxId("select max(subjecttypelogid)from subjecttypelog");
			String query1="insert into subjecttypelog (subjecttypelogid,subjecttypeid,logdetails,dateofcreation,subjecttypelogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = subjecttypecon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,subjecttypeid);
			settingsprepared.setString(3,sujecttypebean.getsubjecttypelogstatus());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, sujecttypebean.getCreatedBy());

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
					
					if(subjecttypecon != null)
						subjecttypecon.close();
				}
		    	return rs;
		    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeTrashListView.jsp
	   * get all subject type TrashLists   - prasanth
	   @param instituteid   that can be used to get all details from   subjecttype table by instituteid wise
	   *
	   @return   the ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_groupTrashList(String instituteid)
    {
		ArrayList list=null;
		try
		{log.info("invoking get_All_TrashList subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
			select_query="select subjecttypeid,instituteid,subjectypename,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,subjecttypestatus from subjecttype where instituteid='"+instituteid+"' and subjecttypestatus='T' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);	
		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeDeactiveList.jsp
	  * get all subject type DeActive list     - prasanth
	  @param instituteid   that can be used to get all details from   subjecttype table by instituteid wise
	  *
	  @return   the ArrayList by which result can be printed on the screen
	 */
    public ArrayList get_All_groupDeactivateList(String instituteid)
    {
		ArrayList list=null;
		try
		{log.info("invoking get_All_DeactivateList subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
			select_query="select subjecttypeid,instituteid,subjectypename,description,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,subjecttypestatus from subjecttype where instituteid='"+instituteid+"' and subjecttypestatus='D' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{log.error(exception);	
		}
		return list;
	}
    /**
	    * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeDelete.jsp
	    * change   subject type status as X (Delete)     - prasanth
	    @param subjecttypestatus that can be used to update  the   subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param subjectypename that can be updated to subjecttype table
	    *
	    @param dateofcreation that can be updated to subjecttype table
	    *
	    @param createdby that can be updated to subjecttype table
	    *
	    @param instituteid that can be updated to subjecttype table
	    *
	    @param subjecttypestatus that can be updated to subjecttype table
	    *
	    @return   the int by which result can be printed on the screen
	 */
    public int Deletegroups(SubjectTypeBean sujecttypebean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;

    	int result=0;
    	try
    	{log.info("invoking delete subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
        	String subjecttypeid=sujecttypebean.getsubjecttypeid();

            subjecttypecon = ConnectionManager.getKycConnection();

			String query="update subjecttype set subjecttypestatus=?,dateofcreation=?,createdby=?,instituteid=?  where subjecttypeid=? ";
			settingsprepared = subjecttypecon.prepareStatement(query);

			settingsprepared.setString(1, "X");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sujecttypebean.getCreatedBy());
			settingsprepared.setString(4, sujecttypebean.getinstituteid());
			settingsprepared.setString(5,subjecttypeid);
			
			rs = settingsprepared.executeUpdate();

			long l1 = common_data_object.fmaxId("select max(subjecttypelogid)from subjecttypelog");
			String query1="insert into subjecttypelog (subjecttypelogid,subjecttypeid,logdetails,dateofcreation,subjecttypelogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = subjecttypecon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,subjecttypeid);
			settingsprepared.setString(3,"X");
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, sujecttypebean.getCreatedBy());

			result = settingsprepared.executeUpdate();

    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(subjecttypecon != null)
				subjecttypecon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeDeactiveFinal.jsp
	    * change subject type status as D (DeActive)     - prasanth
	    @param subjecttypestatus that can be used to update  the   subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param dateofcreation that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param createdby that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param instituteid that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param subjecttypestatus that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @return   the int by which result can be printed on the screen
	 */
    public int groupsDeactivate(SubjectTypeBean sujecttypebean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	int result=0;
    	
    	try
    	{log.info("invoking deactivate subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
        	String subjecttypeid=sujecttypebean.getsubjecttypeid();
            subjecttypecon = ConnectionManager.getKycConnection();

			String query="update subjecttype set subjecttypestatus=? ,dateofcreation=?,createdby=?,instituteid=?  where subjecttypeid=? ";
			settingsprepared = subjecttypecon.prepareStatement(query);

			settingsprepared.setString(1, "D");
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3, sujecttypebean.getCreatedBy());
			settingsprepared.setString(4, sujecttypebean.getinstituteid());
			settingsprepared.setString(5,subjecttypeid);
			rs = settingsprepared.executeUpdate();

			long l1 = common_data_object.fmaxId("select max(subjecttypelogid)from subjecttypelog");
			String query1="insert into subjecttypelog (subjecttypelogid,subjecttypeid,logdetails,dateofcreation,subjecttypelogstatus,createdby) values(?,?,?,?,?,?)";
			settingsprepared = subjecttypecon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,subjecttypeid);
			settingsprepared.setString(3,sujecttypebean.getsubjecttypelogstatus());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, sujecttypebean.getCreatedBy());

			result = settingsprepared.executeUpdate();

    		
    	}
    	catch(Exception exception) { 
			
    		log.error(exception);				
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(subjecttypecon != null)
				subjecttypecon.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeEditUpdate.jsp
	    * update   subject type details    - prasanth
	    @param subjecttypestatus that can be used to update  the   subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param dateofcreation that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param createdby that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param instituteid that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param subjecttypestatus that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param description that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @return   the int by which result can be printed on the screen
	 */
    public int UpdateEdittSubjectType(SubjectTypeBean sujecttypebean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	int result=0;
		ResultSet rs1						= null;

    	try
    	{   log.info("invoking update subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
        	String subjecttypename=sujecttypebean.getsubjectypename();
        	String subjecttypeid=sujecttypebean.getsubjecttypeid();
        	String subjecttypedesi=sujecttypebean.getDescription();
    		
            subjecttypecon = ConnectionManager.getKycConnection();

            
            String str			= "select subjectypename from subjecttype where subjectypename=? and subjecttypeid<>? and instituteid=? and subjecttypestatus <> ?";
            instituteprepared	= subjecttypecon.prepareStatement(str);
            instituteprepared.setString(1, subjecttypename.toLowerCase());
            instituteprepared.setString(2, subjecttypeid);
            instituteprepared.setString(3,sujecttypebean.getinstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
            if(!rs1.next())
            {
            	
           
			String query="update subjecttype set subjectypename=?, dateofcreation=?,description=?,createdby=?,instituteid=?  where subjecttypeid=? ";
			settingsprepared = subjecttypecon.prepareStatement(query);
			
			settingsprepared.setString(1, subjecttypename);
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,subjecttypedesi);
			settingsprepared.setString(4, sujecttypebean.getCreatedBy());
			settingsprepared.setString(5, sujecttypebean.getinstituteid());
			settingsprepared.setString(6,subjecttypeid);
			rs = settingsprepared.executeUpdate();
			
			long l1 = common_data_object.fmaxId("select max(subjecttypelogid)from subjecttypelog");
			String query1="insert into subjecttypelog (subjecttypelogid,subjecttypeid,logdetails,dateofcreation,subjecttypelogstatus,createdby) values(?,?,?,?,?,?)";

			settingsprepared = subjecttypecon.prepareStatement(query1);
			settingsprepared.setLong(1, l1);
			settingsprepared.setString(2,subjecttypeid);
			settingsprepared.setString(3,sujecttypebean.getsubjecttypelogstatus());
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5,"A");
			settingsprepared.setString(6, sujecttypebean.getCreatedBy());

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
			
			if(subjecttypecon != null)
				subjecttypecon.close();
			
			if(instituteprepared != null) 
				instituteprepared.close(); 
			
			if(rs1 != null)
				rs1.close();
		}
    	return rs;
    }
    /**
	    * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeRestore.jsp
	    * change    subject type status as A (Restore)     - prasanth
	    @param subjecttypestatus,dateofcreation,createdby,instituteid that can be used to update  the   subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param dateofcreation that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param createdby that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param instituteid that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @param subjecttypestatus that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	    *
	    @return   the int by which result can be printed on the screen
	 */
    public int RestoreSubjectTypes(SubjectTypeBean sujecttypebean) throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	
    	int result=0;
		
    	try
    	{
    		log.info("invoking restore subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
        	String subjecttypeid=sujecttypebean.getsubjecttypeid();
            subjecttypecon = ConnectionManager.getKycConnection();

    			String query="update subjecttype set subjecttypestatus=?, dateofcreation=?,createdby=?,instituteid=?  where subjecttypeid=? ";
    			settingsprepared = subjecttypecon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, sujecttypebean.getCreatedBy());
    			settingsprepared.setString(4, sujecttypebean.getinstituteid());
    			settingsprepared.setString(5,subjecttypeid);

    			rs = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(subjecttypelogid)from subjecttypelog");
    			String query1="insert into subjecttypelog (subjecttypelogid,subjecttypeid,logdetails,dateofcreation,subjecttypelogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = subjecttypecon.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,subjecttypeid);
    			settingsprepared.setString(3,"Restore");
    			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(5,"A");
    			settingsprepared.setString(6, sujecttypebean.getCreatedBy());

    			result = settingsprepared.executeUpdate();
    			

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(subjecttypecon != null)
				subjecttypecon.close();
		}
    	return rs;
    }
    /**
	   * This method is accessed from kycportal/jsp/masterentries/SubjectType/SubjectTypeActive.jsp
	   * change subject type status as A (Active)     - prasanth
	   @param subjecttypestatus,dateofcreation,createdby,instituteid that can be used to update  the   subjecttype table by  subjecttypeid,instituteid wise
	   *
	   @param dateofcreation that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	   *
	   @param createdby that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	   *
	   @param instituteid that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	   *
	   @param subjecttypestatus that can be updated to subjecttype table by  subjecttypeid,instituteid wise
	   *
	   @return   the int by which result can be printed on the screen
	 */
    public int Activegroups(SubjectTypeBean sujecttypebean) throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
 

    	int rs=0;
    	int result=0;
    	
		
    	try
    	{
    		log.info("invoking active subject types from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
        	String subjecttypeid=sujecttypebean.getsubjecttypeid();
            subjecttypecon = ConnectionManager.getKycConnection();

    			String query="update subjecttype set subjecttypestatus=?, dateofcreation=?,createdby=?,instituteid=?  where subjecttypeid=? ";
    			settingsprepared = subjecttypecon.prepareStatement(query);
    			settingsprepared.setString(1, "A");
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, sujecttypebean.getCreatedBy());
    			settingsprepared.setString(4, sujecttypebean.getinstituteid());
    			settingsprepared.setString(5,subjecttypeid);

    		
    			rs = settingsprepared.executeUpdate();
    			
    			long l1 = common_data_object.fmaxId("select max(subjecttypelogid)from subjecttypelog");
    			String query1="insert into subjecttypelog (subjecttypelogid,subjecttypeid,logdetails,dateofcreation,subjecttypelogstatus,createdby) values(?,?,?,?,?,?)";

    			settingsprepared = subjecttypecon.prepareStatement(query1);
    			settingsprepared.setLong(1, l1);
    			settingsprepared.setString(2,subjecttypeid);
    			settingsprepared.setString(3,"Active");
    			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(5,"A");
    			settingsprepared.setString(6, sujecttypebean.getCreatedBy());

    			result = settingsprepared.executeUpdate();
    			

		}catch(Exception exception) { 
			
			log.error(exception);				
		}
		finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(subjecttypecon != null)
				subjecttypecon.close();
		}
    	return rs;
    }
    /**
	  * This method is accessed from kycportal/jsp/masterentries/subjecttype/SubjectTypeTrashPriview.jsp
	  * check No of  Types alloted to Subjects         - prasanth
	  @param subjecttypeid,instituteid that can be used to check  check No of  Types alloted to Subjects by  subjecttypeid,instituteid wise
	  *
	  @param instituteid that can be used to check  check No of  Types alloted to Subjects by  subjecttypeid,instituteid wise
	  *
	  @return   the String by which result can be printed on the screen
	 */
    public String checkTrashSubject(String subjecttypeid,String instituteid)
    {
    	String list=null;
		try
		{   log.info("invoking checkDuplicateupdate for check No of  Types alloted to Subjects from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
			select_query="select count(a.subjecttypeid) as subjectcount from subjecttype b,subject a where a.subjecttypeid=b.subjecttypeid and b.subjecttypestatus='A' and b.subjecttypeid='"+subjecttypeid+"' and b.instituteid='"+instituteid+"'";
			list=common_data_object.getString(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);	
		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/masterentries/subjecttype/checkDuplicate.jsp
	  * check duplicate subject type name(update screen)         - prasanth
	   @param subjectypename,subjecttypeid,instituteid that can be used to check duplicate names from subjecttype table by  subjecttypeid,instituteid,subjectypename wise
	   *
	   @param subjectypename that can be used to check duplicate names from subjecttype table by  subjecttypeid,instituteid,subjectypename wise
	   *
	   @param subjecttypeid that can be used to check duplicate names from subjecttype table by  subjecttypeid,instituteid,subjectypename wise
	   *
	   @param instituteid that can be used to check duplicate names from subjecttype table by  subjecttypeid,instituteid,subjectypename wise
	   *
	   @return   the boolean by which result can be printed on the screen
	 */
    public boolean checkDuplicateupdate(String subjectypename,String subjecttypeid,String instituteid)
    {
    	boolean return_flag = false;
    	String return_string = null;
    	try
    	{
    		log.info("invoking checkDuplicateupdate for subject type from com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry");
    		String select_query = "SELECT subjectypename FROM subjecttype  where subjectypename='"+subjectypename+"' and instituteid='"+instituteid+"' and subjecttypestatus='A' and  subjecttypeid <> '"+subjecttypeid+"' " ;
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
	  * This method is accessed from kycportal/jsp/masterentries/subjecttype/SubjectTypeUpdateByClick.jsp
	  * To display all Subject Type    lists  - prasanth
	 
	   @param  subjecttypeid   that can be get all subjecttypaname name ,description details from  subjecttype table by subjecttypeid wise
	   *               
	   @return  the ArrayList for    printed the details on the screen 
	 */
public ArrayList getDetailsForuadate(String subjectypeid)
{
		ArrayList list=null;
		try
		{log.info("invoking get_All_SubjectType from com.iGrandee.MasterEntries.subjecttype.SubjectTypeEntry");
			select_query="select subjecttypeid,subjectypename,description from subjecttype where subjecttypeid='"+subjectypeid+"' and  subjecttypestatus='A'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);
		}
		return list;
	}
    DateTime date_object;
    Connection subjecttypecon;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}