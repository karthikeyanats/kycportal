package com.iGrandee.Announcement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;


import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class AnnouncementEntry
{
	static Logger log = Logger.getLogger(AnnouncementEntry.class);

    public AnnouncementEntry()
    {
    	date_object = new DateTime();
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        announcementconnection      = null;
       select_query = null;
       insert_query 		= null;

    }
    /**
	  * This method is accessed from kycportal/jsp/Announcement/SubmitAnnouncement.jsp
	  * insert Announcement details        - prasanth
	   @param  announcementid that can be used to insert details to announcement table 
	   *
	   @param annoucementdetails that can be used to insert details to announcement table
	   *
	   @param instituteid that can be used to insert details to announcement table
	   *
	   @param createdby that can be used to insert details to announcement table
	   
	   @param ipaddress that can be used to insert details to announcement table
	   @param dateofcreation that can be used to insert details to announcement table
	   @param announcementstatus that can be used to insert details to announcement table
	    @return the int by which result can be printed on the screen
	 */
    public int insertAnnouncement_multiple(AnnouncementBean announcementBean) throws SQLException
	{
	 	log.info("invoking  insert Announcement Insertion from com.iGrandee.Announcement.AnnouncementEntry");
			PreparedStatement announcementprepared = null;

			int state 			= 0;

    	 try
    	 {
    		 announcementconnection = ConnectionManager.getKycConnection();

		{
			String[] announce=announcementBean.getAnnoucementdetails();
			
				if(announce[0]!="")
				{	insert_query = "select max(announcementid) from announcement";
	
					long l = common_data_object.fmaxId(insert_query);

				insert_query = "insert into announcement (announcementid,annoucementdetails,instituteid,createdby,ipaddress,dateofcreation,announcementstatus) values(?,?,?,?,?,?,?)";
				announcementprepared = announcementconnection.prepareStatement(insert_query);
				announcementprepared.setLong(1, l);
				announcementprepared.setString(2,announce[0]);
				announcementprepared.setString(3,announcementBean.getInstituteid());
				announcementprepared.setString(4,announcementBean.getCreatedby());
				announcementprepared.setString(5,announcementBean.getIpaddress());

				announcementprepared.setString(6, DateTime.showTime("MySqlWithTime"));
				announcementprepared.setString(7,"A");
				state += announcementprepared.executeUpdate();	

				}
				 if(announce[1]!="")
				{	insert_query = "select max(announcementid) from announcement";

					long l = common_data_object.fmaxId(insert_query);

					insert_query = "insert into announcement (announcementid,annoucementdetails,instituteid,createdby,ipaddress,dateofcreation,announcementstatus) values(?,?,?,?,?,?,?)";
					announcementprepared = announcementconnection.prepareStatement(insert_query);
					announcementprepared.setLong(1, l);
					announcementprepared.setString(2,announce[1]);
					announcementprepared.setString(3,announcementBean.getInstituteid());
					announcementprepared.setString(4,announcementBean.getCreatedby());
					announcementprepared.setString(5,announcementBean.getIpaddress());

					announcementprepared.setString(6, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(7,"A");
					state += announcementprepared.executeUpdate();	

				}
				
				}

		
     }
		catch(Exception e)
		{
			log.error("",e);

		}
		finally
		{
			if(announcementconnection!=null)
				announcementconnection.close();
			
			if(announcementprepared!=null)
				announcementprepared.close();
				
		}
		return state;
	}
    
    /**
	  * This method is accessed from kycportal/jsp/Announcement/Update_Announcement.jsp
	  * List Announcement details       - prasanth
	  @param  instituteid  that can be used to get all details from announcement table by instituteid wise
	  * 
	  @return the ArrayList by which result can be printed on the screen
	 */
    public ArrayList getAnnouncement(String instituteid) throws Exception
    {
		ArrayList list=null;
		try
		{	
			log.info("invoking  List Announcement details from com.iGrandee.Announcement.AnnouncementEntry");
			select_query="select announcementid,annoucementdetails,dateofcreation,announcementstatus,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates FROM announcement where instituteid='"+instituteid+"' and  announcementstatus !='X' and announcementstatus !='T' order by dateofcreation desc ";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	    * This method is accessed from kycportal/jsp/Announcement/AnnouncementAction.jsp
	    * This method is accessed from kycportal/jsp/Announcement/updatesubmit_announce.jsp
	    * change Announcement status (A,D,X,T)       - prasanth 
	    @param  announcementstatus  that can be used to update all details to announcement table by announcementid,instituteid wise
	    *
	    @param ipaddress that can be used to update all details to announcement table by announcementid,instituteid wise
	    *
	    @param dateofcreation that can be used to update all details to announcement table by announcementid,instituteid wise
	    *
	    @param announcementid that can be used to update all details to announcement table by announcementid,instituteid wise
	    *
	    @return the int by which result can be printed on the screen
	 */
    public int udpateAnnouncement(AnnouncementBean announcementBean) throws SQLException
	{
		PreparedStatement announcementprepared = null;
		
		String[] content=announcementBean.getAnnoucementdetails();
		String[] contentid=announcementBean.getAnnouncementid();
		String mode=announcementBean.getMode();

		int state 			= 0;

		try
		{
   		 announcementconnection = ConnectionManager.getKycConnection();
   		log.info("CHANGE    Announcement Status from com.iGrandee.Announcement.AnnouncementEntry");
			if(mode.equals("ACTIVATE"))
			{
				for(int i = 0; i < content.length; i++)
				{
					
					insert_query = "update announcement set announcementstatus=?,ipaddress=?,dateofcreation=? where announcementid=?";
					announcementprepared = announcementconnection.prepareStatement(insert_query);

					announcementprepared.setString(1,"A");
					announcementprepared.setString(2,announcementBean.getIpaddress());
					announcementprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(4,contentid[i]);
					state += announcementprepared.executeUpdate();		

					insert_query = null;
				}

			} else if(mode.equals("TRASH"))
			{
				for(int i = 0; i < content.length; i++)
				{
					
					insert_query = "update announcement set announcementstatus=?,ipaddress=?,dateofcreation=? where announcementid=?";
					announcementprepared = announcementconnection.prepareStatement(insert_query);

					announcementprepared.setString(1,"T");
					announcementprepared.setString(2,announcementBean.getIpaddress());
					announcementprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(4,contentid[i]);
					state += announcementprepared.executeUpdate();		

					insert_query = null;
				}

			}
			else if(mode.equals("Restore"))
			{
				
					
					insert_query = "update announcement set announcementstatus=?,ipaddress=?,dateofcreation=? where announcementid=?";
					announcementprepared = announcementconnection.prepareStatement(insert_query);

					announcementprepared.setString(1,"A");
					announcementprepared.setString(2,announcementBean.getIpaddress());
					announcementprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(4,announcementBean.getannouncementidd());
					state += announcementprepared.executeUpdate();		

					insert_query = null;
				}
			else if(mode.equals("Active"))
			{
				
					
					insert_query = "update announcement set announcementstatus=?,ipaddress=?,dateofcreation=? where announcementid=?";
					announcementprepared = announcementconnection.prepareStatement(insert_query);

					announcementprepared.setString(1,"A");
					announcementprepared.setString(2,announcementBean.getIpaddress());
					announcementprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(4,announcementBean.getannouncementidd());
					state += announcementprepared.executeUpdate();		

					insert_query = null;
				}

			 else if(mode.equals("Delete"))
			{
				
					
					insert_query = "update announcement set announcementstatus=?,ipaddress=?,dateofcreation=? where announcementid=?";
					announcementprepared = announcementconnection.prepareStatement(insert_query);

					announcementprepared.setString(1,"X");
					announcementprepared.setString(2,announcementBean.getIpaddress());
					announcementprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(4,announcementBean.getannouncementidd());
					state += announcementprepared.executeUpdate();		

					insert_query = null;
				

			}
			
			 else if(mode.equals("DEACTIVATE"))
			{
				for(int i = 0; i < content.length; i++)
				{
					
					insert_query = "update announcement set announcementstatus=?,ipaddress=?,dateofcreation=? where announcementid=?";
					announcementprepared = announcementconnection.prepareStatement(insert_query);
					announcementprepared.setString(1,"D");
					announcementprepared.setString(2,announcementBean.getIpaddress());
					announcementprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(4,contentid[i]);
					state += announcementprepared.executeUpdate();		

					insert_query = null;
				}

			} 
			 else if(mode.equals("DELETE"))
			{
				for(int i = 0; i < content.length; i++)
				{

					
					insert_query 	= "update announcement set announcementstatus=?,ipaddress=?,dateofcreation=? where announcementid=?";
					announcementprepared = announcementconnection.prepareStatement(insert_query);
					announcementprepared.setString(1,"X");
					announcementprepared.setString(2,announcementBean.getIpaddress());
					announcementprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(4,contentid[i]);
					state += announcementprepared.executeUpdate();		

					insert_query = null;
				}

			} else
			if(mode.equals("UPDATE"))
			{
				String[] announce=announcementBean.getAnnoucementdetails();

				for(int i = 0; i < content.length; i++)
				{
					
					

					insert_query = "update announcement set ipaddress=?,dateofcreation=?,annoucementdetails=? where announcementid=?";
					announcementprepared = announcementconnection.prepareStatement(insert_query);
					announcementprepared.setString(1,announcementBean.getIpaddress());
					announcementprepared.setString(2, DateTime.showTime("MySqlWithTime"));
					announcementprepared.setString(3,announce[i]);
					announcementprepared.setString(4,contentid[i]);
					state += announcementprepared.executeUpdate();		

					insert_query = null;
				}
			}
		}
		catch(Exception exception) 
		{ 
			log.error("",exception);

		}
		finally
		{
			if(announcementconnection!=null)
				announcementconnection.close();
			
			if(announcementprepared!=null)
				announcementprepared.close();
		}
		return state;
	}
    /**
	  * This method is accessed from kycportal/jsp/Announcement/List_Announcement.jsp
	  * This method is accessed from kycportal/jsp/Announcement/List_DeactAnnouncement.jsp
	  * List status wise  Announcement Details       - prasanth
	  @param  announcementstatus  that can be used to get all details from announcement table 
	  *
	  @param instituteid that can be used to get all details from announcement table 
	  *
	  @return the ArrayList by which result can be printed on the screen
	 */
    public ArrayList listAnnouncement(AnnouncementBean announcementBean) throws Exception
    {
		ArrayList list=null;
		try
		{	
			String mode=announcementBean.getMode();
			String announcementstatus="";
			String instituteid=announcementBean.getInstituteid();
			log.info("List status wise announcement details from com.iGrandee.Announcement.AnnouncementEntry");
		if(mode.equals("TRASHlIST"))
		{
			announcementstatus="T";
		}
		else if(mode.equals("DEACTIVElIST"))
		{
			announcementstatus="D";  
		}
			log.info("invoking   Announcement list");
			select_query="select announcementid,annoucementdetails,dateofcreation,announcementstatus,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates FROM announcement where announcementstatus ='"+announcementstatus+"' and instituteid='"+instituteid+"' order by dateofcreation desc ";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
     * This method is accessed from kycportal/jsp/kycpanel/Homepage.jsp
     * This method is accessed from kycportal/jsp/Principal/PrincipalHomepage.jsp
     * This method is accessed from kycportal/jsp/Staff/StaffHomepage.jsp
     * This method is accessed from kycportal/jsp/Parent/TimeTable.jsp
     * This method is accessed from kycportal/jsp/Student/StudentHome.jsp
     * display  Announcement for Admin Page          - prasanth
     @param  instituteid  that can be used to get all details from announcement table 
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    
    
    public ArrayList getAnnouncementForHomeScreen(String instituteid) throws Exception
    {
		ArrayList list=null;
		try
		{	  
			log.info("invoking  Announcement for Homescreen from com.iGrandee.Announcement.AnnouncementEntry");
			select_query="select announcementid,annoucementdetails from announcement where announcementstatus='A' and instituteid='"+instituteid+"' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}  
		return list;
	}
   
    public String 		insert_query;

    DateTime date_object;
    Connection announcementconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}