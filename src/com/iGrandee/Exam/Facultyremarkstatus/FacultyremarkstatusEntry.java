package com.iGrandee.Exam.Facultyremarkstatus;
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

public class FacultyremarkstatusEntry
{
	static Logger log = Logger.getLogger(FacultyremarkstatusEntry.class);

    public FacultyremarkstatusEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        facultyremarksconnection      = null;


        select_query = null;
    }
    /**
     * This method is accessed from kycportal/jsp/Exam/Facultyremarkstatus/FacultyRemarkSubmit.jsp
 	  * insert Faculty Remark  details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  fremarkstatusid   that can be inserted to facultyremarksstatus table
 	  * 
 	  @param remarkstatusname that can be inserted to facultyremarksstatus table
 	  *
 	  @param dateofcreation that can be inserted to facultyremarksstatus table
 	  *
 	  @param createdby that can be inserted to facultyremarksstatus table
 	  *
      @param remarkstatus that can be inserted to facultyremarksstatus table  
 	  *     
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public ArrayList insertFacultyRemark(FacultyremarkstatusBean facultyremarksbean)throws SQLException
    {   
		int state=0;
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;
		String facultyremarknameduplicate					= "";
		String message="";
		ArrayList resultList = new ArrayList();

        try
    	{
        	
        	
	    log.info("invoking insert Facultyremarkstatus from com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry");
	    facultyremarksconnection = ConnectionManager.getKycConnection();
    	
	    String[]  facultyremarkname=facultyremarksbean.getRemarkstatusname_temp();
	    String dupCheck			= "select fremarkstatusid,remarkstatusname from facultyremarksstatus where remarkstatusname=?  and remarkstatus <> ? ";
	    settingsprepared	= facultyremarksconnection.prepareStatement(dupCheck);
        if(facultyremarkname !=null && facultyremarkname.length>0)
        {
        	for(int i = 0; i < facultyremarkname.length; i++)
			{
        		if(!facultyremarkname[i].equals(""))
        		{
				    	
				    	    String str			= "select a.remarkstatusname from facultyremarksstatus a,login b,personmaster c,institution d where  a.remarkstatusname=?  and a.createdby=b.userid and b.loginstatus=? and b.personid=c.personid and c.status=? and c.instituteid=? and c.instituteid=d.instituteid and d.status=? and a.remarkstatus <> ? ";
					    	settingsprepared	= facultyremarksconnection.prepareStatement(str);
						 	settingsprepared.setString(1,facultyremarkname[i].toLowerCase());
						 	settingsprepared.setString(2, "A");
						 	settingsprepared.setString(3, "A");
						 	settingsprepared.setString(4, facultyremarksbean.getInstituteid());
						 	settingsprepared.setString(5, "A");
						 	settingsprepared.setString(6, "X");
						 	rs1	= settingsprepared.executeQuery(); 
				         if(!rs1.next())
				         {
						        long l = common_data_object.fmaxId("select max(fremarkstatusid)from facultyremarksstatus");
								String query="insert into facultyremarksstatus (fremarkstatusid,remarkstatusname,dateofcreation,createdby,remarkstatus) values(?,?,?,?,?)";
								settingsprepared = facultyremarksconnection.prepareStatement(query);
								
								settingsprepared.setLong(1, l);
								settingsprepared.setString(2,facultyremarkname[i]);
								settingsprepared.setString(3, DateTime.showTime("MySqlWithTime"));
								settingsprepared.setString(4, facultyremarksbean.getCreatedby());
								settingsprepared.setString(5, "A");
								state = settingsprepared.executeUpdate();
				         }
				         else
				         {
				        	 facultyremarknameduplicate	+= facultyremarkname[i]+",";
				         }
				         if(rs1!=null)
						 rs1.close();
	            }
			}
        	if(state >0)
				message = "Successfully Faculty Remark Name Inserted.";
			else
				message = "Faculty Remark Name Insertion Failed.";
				
			if(facultyremarknameduplicate != null && facultyremarknameduplicate.length()>2)
				message	+= " The Following Faculty Remark Name already exists. "+facultyremarknameduplicate.substring(0,facultyremarknameduplicate.length()-1);
			
			resultList.add(state+"");
			resultList.add(message);	
			
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
				
				if(facultyremarksconnection != null)
					facultyremarksconnection.close();
				
				
			}
			return resultList;
			}
    /**
     * This method is accessed from kycportal/jsp/Exam/Facultyremarkstatus/FacultyRemarkList.jsp
 	  * get FacultyRemark details   - prasanth
      @param status that can be used to get FacultyRemark details from facultyremarksstatus table by status wise   
 	  *     
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public ArrayList get_All_RemarlList(String status,String createdby,String instituteid)
    {
    		ArrayList list=null;
    	
    		
    		try
    		{
            	log.info("invoking get All Faculity Remark List from com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry");
    			select_query="select a.fremarkstatusid,a.remarkstatusname,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates,a.remarkstatus from facultyremarksstatus a,login b,personmaster c,institution d where a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' and a.remarkstatus='"+status+"' order by a.dateofcreation desc;";
    			list=common_data_object.getListMap(select_query);
    		
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    	return list;
    }
    /**
     * This method is accessed from kycportal/jsp/Exam/Facultyremarkstatus/FacultyremarkUpdateByClick.jsp
 	  * get FacultyRemark details   - prasanth
      @param status that can be used to get FacultyRemark details from facultyremarksstatus table by status wise   
 	  *  
 	  @param fremarkstatusid that can be used to get FacultyRemark details from facultyremarksstatus table by fremarkstatusid wise   
 	  * 
 	  @return the ArrayList by which result can be printed on the screen
 	      
      */
    public ArrayList getDetailsForuadate(String status,String fremarkstatusid)
    {
    		ArrayList list=null;
    	
    		
    		try
    		{
            	log.info("invoking get All Faculity Remark List from com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry");
    			select_query="select fremarkstatusid,remarkstatusname,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,remarkstatus from facultyremarksstatus where fremarkstatusid='"+fremarkstatusid+"' and remarkstatus='"+status+"' order by dateofcreation desc";
    			list=common_data_object.getListMap(select_query);
    		
    		}
    		catch(Exception exception)
    		{ 
    				
    			log.error(exception);				
    		}
    	    	
    	    	return list;
    }
    /**
     * This method is accessed from kycportal/jsp/PeriodNames/FacultyRemarkEditUpdate.jsp
 	  * update FacultyRemark details    - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  remarkstatusname  that can be used to update Faculty Remark details to facultyremarksstatus table
 	  * 
  	  @param dateofcreation that can be used to update period Faculty Remark to facultyremarksstatus table
 	  *
 	  @param createdby that that can be used to update Faculty Remark details to facultyremarksstatus table
 	  *
      @param remarkstatus that can be used to update Faculty Remark details to facultyremarksstatus table
 	  *  
 	  @param fremarkstatusid that can be used to update Faculty Remark details to facultyremarksstatus table
 	  * 
 	  @return the integer by which result can be printed on the screen
 	  *  
      */
    
    public int UpdateEdittRack(FacultyremarkstatusBean facultyremarksbean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
    	PreparedStatement instituteprepared = null;
    	ResultSet rs1						= null;

    	int result=0;
    	
    	try
    	{
    			log.info("invoking Update Facultyremarkstatus  from com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry");
    			facultyremarksconnection = ConnectionManager.getKycConnection();
    			//String str			= "select remarkstatusname from facultyremarksstatus where remarkstatusname=? and fremarkstatusid <> ?  and remarkstatus <> ?";
    			String str			= "select remarkstatusname from facultyremarksstatus a,login b,personmaster c where a.remarkstatusname=? and a.fremarkstatusid <> ?  and a.remarkstatus <> ? and b.loginstatus='A' and c.status='A' and a.createdby=b.createdby and b.personid=c.personid and c.instituteid=?";
                
    			instituteprepared	= facultyremarksconnection.prepareStatement(str);
                instituteprepared.setString(1,facultyremarksbean.getRemarkstatusname().toLowerCase());
                instituteprepared.setString(2, facultyremarksbean.getFremarkstatusid());
                instituteprepared.setString(3, "X");
                instituteprepared.setString(4, facultyremarksbean.getInstituteid());
               // System.out.println("instituteprepared"+instituteprepared);
                rs1	= instituteprepared.executeQuery();
    	            
                if(!rs1.next())
                {
    	         String query="update facultyremarksstatus set remarkstatusname=?, dateofcreation=?,createdby=? where fremarkstatusid=? ";
    			settingsprepared = facultyremarksconnection.prepareStatement(query);
    		
    			settingsprepared.setString(1,facultyremarksbean.getRemarkstatusname());
    			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(3, facultyremarksbean.getCreatedby());
    			settingsprepared.setString(4,facultyremarksbean.getFremarkstatusid());
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
    		
    		if(facultyremarksconnection != null)
    			facultyremarksconnection.close();
    		
    		if(rs1!=null)
    		rs1.close();
    	}
    	return result;
    }
    /**
     * This method is accessed from kycportal/jsp/PeriodNames/FacultyRemarkStatusUpdate.jsp
 	  * update FacultyRemark status     - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

  	  @param dateofcreation that can be used to update period Faculty Remark to facultyremarksstatus table
 	  *
 	  @param createdby that that can be used to update Faculty Remark details to facultyremarksstatus table
 	  *
      @param remarkstatus that can be used to update Faculty Remark details to facultyremarksstatus table
 	  *  
 	  @param fremarkstatusid that can be used to update Faculty Remark details to facultyremarksstatus table
 	  * 
 	  @return the integer by which result can be printed on the screen
 	  *  
      */
    public int StatusUpdate(FacultyremarkstatusBean facultyremarksbean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
    	PreparedStatement instituteprepared = null;
    	ResultSet rs1						= null;

    	int result=0;
    	
    	try
    	{
    			log.info("invoking Update Rack  from com.iGrandee.MasterEntries.Rack.RackEntry");
    			facultyremarksconnection = ConnectionManager.getKycConnection();
    			
    	         String query="update facultyremarksstatus set  dateofcreation=?,createdby=?,remarkstatus=? where fremarkstatusid=? ";
    			settingsprepared = facultyremarksconnection.prepareStatement(query);
    		
    			settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
    			settingsprepared.setString(2, facultyremarksbean.getCreatedby());
    			settingsprepared.setString(3, facultyremarksbean.getRemarkstatus());
    			settingsprepared.setString(4,facultyremarksbean.getFremarkstatusid());
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
    		
    		if(facultyremarksconnection != null)
    			facultyremarksconnection.close();
    		
    		if(rs1!=null)
    		rs1.close();
    	}
    	return result;
    }
    DateTime date_object;
    Connection facultyremarksconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}