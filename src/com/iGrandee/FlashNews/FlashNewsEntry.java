package com.iGrandee.FlashNews;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;


import org.apache.log4j.Logger;

import com.iGrandee.FlashNews.FlashNewsBean;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class FlashNewsEntry
{
	
	static Logger log = Logger.getLogger(FlashNewsEntry.class);

    public FlashNewsEntry()
    {
    	date_object = new DateTime();
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        flashnewsconnection      = null;
       select_query = null;
       insert_query 		= null;
       

    }

    /**
	  * This method is accessed from kycportal/jsp/FlashNews/Update_Flash.jsp
	  * List All Active FlashNews Details        - prasanth
	  @param  instituteid  that can be used to get all flash news from flash table by instituteid wise 
	  *
      @return the ArrayList by which result can be printed on the screen
	 */ 
    public ArrayList getAllFlashNews(String instituteid) throws Exception
    {

		ArrayList list=null;
		try
		{	
			log.info("invoking FlasNews list for updation from com.iGrandee.FlashNews.FlashNewsEntry");
			select_query="select flashid,flashmessage,dateofcreation,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,flashstatus FROM flash where instituteid='"+instituteid+"' and flashstatus !='X' and flashstatus !='T' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	    * This method is accessed from kycportal/jsp/FlashNews/Insert_Flash.jsp
	    * Insert FlashNews Details        - prasanth
	    @param  flashid  that can be used to insert  details to flash table   
	    * 
        @param flashmessage that can be used to insert  details to flash table 
        * 
        @param instituteid that can be used to insert  details to flash table  
        *
        @param createdby that can be used to insert  details to flash table  
        *
        @param ipaddress that can be used to insert  details to flash table 
        * 
        @param dateofcreation that can be used to insert  details to flash table 
        * 
        @param flashstatus that can be used to insert  details to flash table  
        *
        @return  int by which result can be printed on the screen
	 */
    public int insertQuery_Flash(FlashNewsBean flashBean) throws SQLException
    {
        log.info("invoking FlasNews  Insertion from com.iGrandee.FlashNews.FlashNewsEntry");
		PreparedStatement flashprepared = null;

		int state 			= 0;
		
        try
        {
   		 flashnewsconnection = ConnectionManager.getKycConnection();

          
        	insert_query = "select max(flashid) from flash";
			long l = common_data_object.fmaxId(insert_query);
			
			insert_query = "insert into flash (flashid,flashmessage,instituteid,createdby,ipaddress,dateofcreation,flashstatus) values(?,?,?,?,?,?,?)";
			flashprepared = flashnewsconnection.prepareStatement(insert_query);
			flashprepared.setLong(1, l);
			flashprepared.setString(2,flashBean.getflashmessage()+"");
			flashprepared.setString(3,flashBean.getInstituteid());
			flashprepared.setString(4,flashBean.getCreatedby());
			flashprepared.setString(5,flashBean.getIpaddress());
			flashprepared.setString(6, DateTime.showTime("MySqlWithTime"));
			flashprepared.setString(7,"A");
			state += flashprepared.executeUpdate();		
			
        }
        catch(Exception exception)
        { 
			log.error(exception);

        }
        finally
        {
        	if(flashnewsconnection!=null)
        		flashnewsconnection.close();
        	
        	if(flashprepared!=null)
        		flashprepared.close();
        }
        return state;
    }
    /**
	   * This method is accessed from kycportal/jsp/FlashNews/FlashAction.jsp
	   * This method is accessed from kycportal/jsp/FlashNews/Insert_Flash.jsp
	   * Change FlashNews Deails,Status        - prasanth
	   @param  flashid  that can be used to update  details to flash table by flashid wise
	   * 
       @param flashmessage  that can be used to update  details to flash table by flashid wise
       *
       @param instituteid  that can be used to update  details to flash table by flashid wise
       *
       @param createdby  that can be used to update  details to flash table by flashid wise
       *
       @param ipaddress  that can be used to update  details to flash table by flashid wise
       *
       @param dateofcreation  that can be used to update  details to flash table by flashid wise
       *
       @param flashstatus  that can be used to update  details to flash table by flashid wise
       *
       @return  int by which result can be printed on the screen
	 */
    public int updateDeteleQuery_Flash(FlashNewsBean flashBean) throws SQLException
	{
		int i 			= 0;
		 log.info("invoking FlasNews for  update from com.iGrandee.FlashNews.FlashNewsEntry");
			PreparedStatement flashprepared = null;
			String mode=flashBean.getMode();
			String[] flashid=flashBean.getFlashid();
			String[] message=flashBean.getFlashmessage();
		try
		{
   		 flashnewsconnection = ConnectionManager.getKycConnection();
   			if(mode.equals("UPDATE"))
			{
				for(int j = 0; j < flashid.length; j++)
				{
					
					insert_query = "update flash set ipaddress=?,dateofcreation=?,flashmessage=?  where flashid=?";
					flashprepared = flashnewsconnection.prepareStatement(insert_query);

					flashprepared.setString(1,flashBean.getIpaddress());
					flashprepared.setString(2, DateTime.showTime("MySqlWithTime"));
					flashprepared.setString(3,message[i]);
					flashprepared.setString(4,flashid[i]);

					i += flashprepared.executeUpdate();		
				}

			}
			else if(mode.equals("DELETE"))
			{
				for(int k = 0; k < flashid.length; k++)
				{
					insert_query 	= "update flash set flashstatus=?,ipaddress=?,dateofcreation=? where flashid=?";
					flashprepared = flashnewsconnection.prepareStatement(insert_query);
					flashprepared.setString(1,"X");
					flashprepared.setString(2,flashBean.getIpaddress());
					flashprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					flashprepared.setString(4,flashid[i]);
					i += flashprepared.executeUpdate();		

					insert_query = null;
					
				}
			}
			else if(mode.equals("TRASH"))
			{
				for(int k = 0; k < flashid.length; k++)
				{
					insert_query 	= "update flash set flashstatus=?,ipaddress=?,dateofcreation=? where flashid=?";
					flashprepared = flashnewsconnection.prepareStatement(insert_query);
					flashprepared.setString(1,"T");
					flashprepared.setString(2,flashBean.getIpaddress());
					flashprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					flashprepared.setString(4,flashid[i]);
					i += flashprepared.executeUpdate();		

					insert_query = null;
					
				}
			}
			else if(mode.equals("Restore"))
			{String flashidd=flashBean.getflashidd();
				
					insert_query 	= "update flash set flashstatus=?,ipaddress=?,dateofcreation=? where flashid=?";
					flashprepared = flashnewsconnection.prepareStatement(insert_query);
					flashprepared.setString(1,"A");
					flashprepared.setString(2,flashBean.getIpaddress());
					flashprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					flashprepared.setString(4,flashidd);
					i += flashprepared.executeUpdate();		

					insert_query = null;
					
				
			}
			else if(mode.equals("Active"))
			{String flashidd=flashBean.getflashidd();
				
					insert_query 	= "update flash set flashstatus=?,ipaddress=?,dateofcreation=? where flashid=?";
					flashprepared = flashnewsconnection.prepareStatement(insert_query);
					flashprepared.setString(1,"A");
					flashprepared.setString(2,flashBean.getIpaddress());
					flashprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					flashprepared.setString(4,flashidd);
					i += flashprepared.executeUpdate();		

					insert_query = null;
					
				
			}
			else if(mode.equals("Delete"))
			{				

				String flashidd=flashBean.getflashidd();

					insert_query 	= "update flash set flashstatus=?,ipaddress=?,dateofcreation=? where flashid=?";
					flashprepared = flashnewsconnection.prepareStatement(insert_query);
					flashprepared.setString(1,"X");
					flashprepared.setString(2,flashBean.getIpaddress());
					flashprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					flashprepared.setString(4,flashidd);
					i += flashprepared.executeUpdate();		

					insert_query = null;
					
				
			}
			else if(mode.equals("ACTIVATE"))
			{
				for(int m = 0; m < flashid.length; m++)
				{
					
					insert_query 	= "update flash set flashstatus=?,ipaddress=?,dateofcreation=? where flashid=?";
					flashprepared = flashnewsconnection.prepareStatement(insert_query);
					flashprepared.setString(1,"A");
					flashprepared.setString(2,flashBean.getIpaddress());
					flashprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					flashprepared.setString(4,flashid[i]);
					i += flashprepared.executeUpdate();		
					
				}
			}
			else if(mode.equals("DEACTIVATE"))
			{
			   for(int m = 0; m < flashid.length; m++)
			   {
				
				   insert_query 	= "update flash set flashstatus=?,ipaddress=?,dateofcreation=? where flashid=?";
					flashprepared = flashnewsconnection.prepareStatement(insert_query);
					flashprepared.setString(1,"D");
					flashprepared.setString(2,flashBean.getIpaddress());
					flashprepared.setString(3, DateTime.showTime("MySqlWithTime"));
					flashprepared.setString(4,flashid[i]);
					i += flashprepared.executeUpdate();
			   }

			}
		}

		catch(Exception exception)
		{
			log.error(exception);

		}
		finally
		{
			if(flashnewsconnection!=null)
				flashnewsconnection.close();
			
			if(flashprepared!=null)
				flashprepared.close();
		}
		return i;
	}
    /**
	  * This method is accessed from kycportal/jsp/FlashNews/List_Flash.jsp
	  * List Trash FlashNews         - prasanth
	  @param  instituteid that can be used to list all trashed flash news  from flash table by instituteid wise
	  * 
      @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList listTrashFlash(String instituteid) throws Exception
    {

		ArrayList list=null;
		try
		{	
			log.info("invoking Trash FlasNews list from com.iGrandee.FlashNews.FlashNewsEntry");
			select_query="select flashid,flashmessage,dateofcreation,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,flashstatus FROM flash where instituteid='"+instituteid+"' and  flashstatus ='T' order by dateofcreation desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/FlashNews/List_DeactFlash.jsp
	  * List Deactive FlashNews         - prasanth
	  @param  instituteid that can be used to list all deactivated flash news details from flash table 
      *
      @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList listDeactFlash(String instituteid) throws Exception
    {	

		ArrayList list=null;
		try
		{	
			log.info("invoking Deactive FlasNews list from com.iGrandee.FlashNews.FlashNewsEntry");
			select_query="select flashid,flashmessage,dateofcreation,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,flashstatus FROM flash where instituteid='"+instituteid+"' and flashstatus ='D' order by dateofcreation desc ";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    
 //flash news added by rams
    public ArrayList loadActiveFlashNews(String instituteid) throws Exception
    {	

		ArrayList list=null;
		try
		{	
			log.info("invoking FlasNews for  list ");
			select_query="select flashmessage  FROM flash where flashstatus ='A' and instituteid='"+instituteid+"' order by dateofcreation desc ";
			log.info(select_query);
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
Connection flashnewsconnection;
CommonDataAccess common_data_object;
ConnectionManager connectionManager;
String select_query;
Statement stmt;
ResultSet rs;
}