package com.iGrandee.Library.MasterEntries.BookpurchaseType;
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

public class BookpurchaseTypeEntry
{
	static Logger log = Logger.getLogger(BookpurchaseTypeEntry.class);

    public BookpurchaseTypeEntry()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        bookpurchasetypeconnection      = null;


        select_query = null;
    }
    /**
     * This method is accessed from kycportal/jsp/masterentries/BookType/BookTypeSubmit.jsp
 	  * insert bookpurchasetype details   - prasanth
      * Returns an Integer  by which result can be printed on the screen. 

 	  @param  bookpurchasetypeid   that can be inserted to bookpurchasetype table
 	  * 
 	  @param bookpurchasetypename that can be inserted to bookpurchasetype table
 	  *
 	  @param description that can be inserted to bookpurchasetype table
 	  *
 	  @param dateofcreation that can be inserted to bookpurchasetype table
 	  *
 	  @param createdby that can be inserted to bookpurchasetype table
 	  *
      @param instituteid that can be inserted to bookpurchasetype table
      *
 	  @param ipaddress that can be inserted to bookpurchasetype table
 	  *
 	  @param status that can be inserted to bookpurchasetype table  
 	  *     
 	  @return the integer by which result can be printed on the screen
 	      
      */
    public int insertBookType(BookpurchaseTypeBean bookpurchasetypebean)throws SQLException
    {
		int result=0;
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;
		ResultSet rs1						= null;

        try
    	{ 
	    	log.info("invoking insert BookType from com.iGrandee.MasterEntries.BookType.BookTypeEntry");
	    	bookpurchasetypeconnection = ConnectionManager.getKycConnection();
	
    	 String str			= "select bookpurchasetypeid,bookpurchasetypename from bookpurchasetype where bookpurchasetypename=? and instituteid=? and booktypestatus <> ? ";
    	 settingsprepared	= bookpurchasetypeconnection.prepareStatement(str);
    	 settingsprepared.setString(1,bookpurchasetypebean.getBookpurchasetypename().toLowerCase());
    	 settingsprepared.setString(2, bookpurchasetypebean.getInstituteid());
    	 settingsprepared.setString(3, "X");
         rs1	= settingsprepared.executeQuery(); 
         if(!rs1.next())
         {
        long l = common_data_object.fmaxId("select max(bookpurchasetypeid)from bookpurchasetype");
		String query="insert into bookpurchasetype (bookpurchasetypeid,bookpurchasetypename,description,dateofcreation,createdby,instituteid,ipaddress,booktypestatus) values(?,?,?,?,?,?,?,?)";
		settingsprepared = bookpurchasetypeconnection.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,bookpurchasetypebean.getBookpurchasetypename());
		settingsprepared.setString(3,bookpurchasetypebean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, bookpurchasetypebean.getCreatedby());
		settingsprepared.setString(6, bookpurchasetypebean.getInstituteid());
		settingsprepared.setString(7, bookpurchasetypebean.getIpaddress());
		settingsprepared.setString(8, "A");
		result = settingsprepared.executeUpdate();
		
		    long l1 = common_data_object.fmaxId("select max(bookpurchasetypelogid)from bookpurchasetypelog");
			String query_log="insert into bookpurchasetypelog (bookpurchasetypelogid,bookpurchasetypeid,logstatus,dateofcreation,createdby,booktypelogstatus) values(?,?,?,?,?,?)";
			instituteprepared = bookpurchasetypeconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setLong(2,l);
			instituteprepared.setString(3,bookpurchasetypebean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, bookpurchasetypebean.getCreatedby());
			instituteprepared.setString(6, bookpurchasetypebean.getBooktypelogstatus());
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
				
				if(bookpurchasetypeconnection != null)
					bookpurchasetypeconnection.close();
				
				if(rs1!=null)
				rs1.close();
			}
    return result;
}
    
    /**
     * This method is accessed from kycportal/jsp/masterentries/BookType/BookTypeList.jsp
     * get details for updation - prasanth
    
     @param  instituteid  that can be get bookpurchasetypeid,bookpurchasetypename and description by institute wise from bookpurchasetype table
     * 
     @param  status   that can be get bookpurchasetypeid,bookpurchasetypename and description by status wise from bookpurchasetype table
     *
     @return  the ArrayList for printed the result on the screen 
    */
public ArrayList get_All_BookType(String instituteid,String status)
{
		ArrayList list=null;
	
		
		try
		{
        	log.info("invoking get All BookType Active List from com.iGrandee.MasterEntries.BookType.BookTypeEntry");

			select_query="select bookpurchasetypeid,bookpurchasetypename,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,booktypestatus from bookpurchasetype where instituteid='"+instituteid+"' and booktypestatus='"+status+"' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/BookType/BookTypeUpdateByClick.jsp
 * get details for updation - prasanth
 @param  bookpurchasetypeid   that can be get bookpurchasetypeid,bookpurchasetypename and description from bookpurchasetype table
 *  
 @param  instituteid  that can be get bookpurchasetypeid,bookpurchasetypename and description by institute wise from bookpurchasetype table
 * 
 @param  status   that can be get bookpurchasetypeid,bookpurchasetypename and description by booktypestatus wise from bookpurchasetype table
 *
 @return  the ArrayList for    printed the result on the screen 
*/
public ArrayList getDetailsForuadate(String bookpurchasetypeid,String status,String instituteid)
{
		ArrayList list=null;
	
		
		try
		{
        	log.info("invoking get All BookType Active List from com.iGrandee.MasterEntries.BookType.BookTypeEntry");

			select_query="select bookpurchasetypeid,bookpurchasetypename,description,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,booktypestatus from bookpurchasetype where bookpurchasetypeid='"+bookpurchasetypeid+"' and booktypestatus='"+status+"' and instituteid='"+instituteid+"' order by dateofcreation desc";
			list=common_data_object.getListMap(select_query);
		
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/BookType/BookTypeEditUpdate.jsp
 * update  bookpurchasetype details  - prasanth
   @param  bookpurchasetypeid that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param bookpurchasetypename that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param description that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param dateofcreation that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param createdby that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param instituteid that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param ipaddress that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param status  that can be updated to bookpurchasetype table  by bookpurchasetypeid wise  
   *          
  @return  the int for   printed the result on the screen 
*/
public int UpdateEdittBookType(BookpurchaseTypeBean bookpurchasetypebean)  throws SQLException
{
	PreparedStatement settingsprepared  = null;
	PreparedStatement instituteprepared = null;
	ResultSet rs1						= null;

	int result=0;
	
	try
	{
		log.info("invoking Update BookType  from com.iGrandee.MasterEntries.BookType.BookTypeEntry");
			bookpurchasetypeconnection = ConnectionManager.getKycConnection();
      
			String str			= "select bookpurchasetypename from bookpurchasetype where bookpurchasetypename=? and bookpurchasetypeid<>? and instituteid=? and booktypestatus <> ?";
            instituteprepared	= bookpurchasetypeconnection.prepareStatement(str);
            instituteprepared.setString(1, bookpurchasetypebean.getBookpurchasetypename().toLowerCase());
            instituteprepared.setString(2, bookpurchasetypebean.getBookpurchasetypeid());
            instituteprepared.setString(3,bookpurchasetypebean.getInstituteid());
            instituteprepared.setString(4, "X");
            rs1	= instituteprepared.executeQuery();
	            
            if(!rs1.next())
            {
	         String query="update bookpurchasetype set bookpurchasetypename=?, dateofcreation=?,description=?,ipaddress=?,createdby=?,instituteid=?  where bookpurchasetypeid=? ";
			settingsprepared = bookpurchasetypeconnection.prepareStatement(query);
		
			settingsprepared.setString(1, bookpurchasetypebean.getBookpurchasetypename());//getBooktypename
			settingsprepared.setString(2, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(3,bookpurchasetypebean.getDescription());
			settingsprepared.setString(4, bookpurchasetypebean.getIpaddress());
			settingsprepared.setString(5, bookpurchasetypebean.getCreatedby());
			settingsprepared.setString(6, bookpurchasetypebean.getInstituteid());
			settingsprepared.setString(7,bookpurchasetypebean.getBookpurchasetypeid());
			result = settingsprepared.executeUpdate();
			

		    long l1 = common_data_object.fmaxId("select max(bookpurchasetypelogid)from bookpurchasetypelog");
			String query_log="insert into bookpurchasetypelog (bookpurchasetypelogid,bookpurchasetypeid,logstatus,dateofcreation,createdby,booktypelogstatus) values(?,?,?,?,?,?)";
			instituteprepared = bookpurchasetypeconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setString(2,bookpurchasetypebean.getBookpurchasetypeid());
			instituteprepared.setString(3,bookpurchasetypebean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, bookpurchasetypebean.getCreatedby());
			instituteprepared.setString(6, bookpurchasetypebean.getBooktypelogstatus());
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
		
		if(bookpurchasetypeconnection != null)
			bookpurchasetypeconnection.close();
		
		if(rs1!=null)
		rs1.close();
	}
	return result;
}
/**
 * This method is accessed from kycportal/jsp/masterentries/BookType/BookTypeStatusUpdate.jsp
 * update  BookType details  - prasanth
   @param  bookpurchasetypeid that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param bookpurchasetypename that can be updated to  bookpurchasetype  by bookpurchasetypeid wise
   *
   @param description that can be updated to  bookpurchasetype  by bookpurchasetypeid wise
   *
   @param dateofcreation that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param createdby that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param instituteid that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param ipaddress that can be updated to bookpurchasetype table  by bookpurchasetypeid wise
   *
   @param status  that can be updated to bookpurchasetype table  by bookpurchasetypeid wise  
   *          
  @return  the int for   printed the result on the screen 
*/
public int BookTypeStatusUpdate(BookpurchaseTypeBean bookpurchasetypebean)  throws SQLException
{
	PreparedStatement settingsprepared  = null;
	PreparedStatement instituteprepared = null;
	ResultSet rs1						= null;

	int result=0;
	
	try
	{
		log.info("invoking Update BookType  from com.iGrandee.MasterEntries.BookType.BookTypeEntry");
			bookpurchasetypeconnection = ConnectionManager.getKycConnection();
      
		
	        String query="update bookpurchasetype set  dateofcreation=?,ipaddress=?,createdby=?,instituteid=?,booktypestatus=?  where bookpurchasetypeid=? ";
			settingsprepared = bookpurchasetypeconnection.prepareStatement(query);
		
			settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(2, bookpurchasetypebean.getIpaddress());
			settingsprepared.setString(3, bookpurchasetypebean.getCreatedby());
			settingsprepared.setString(4, bookpurchasetypebean.getInstituteid());
			settingsprepared.setString(5,bookpurchasetypebean.getBooktypestatus());
			settingsprepared.setString(6,bookpurchasetypebean.getBookpurchasetypeid());
			result = settingsprepared.executeUpdate();//getBooktypeid
			System.out.println(settingsprepared);

		   long l1 = common_data_object.fmaxId("select max(bookpurchasetypelogid)from bookpurchasetypelog");
			String query_log="insert into bookpurchasetypelog (bookpurchasetypelogid,bookpurchasetypeid,logstatus,dateofcreation,createdby,booktypelogstatus) values(?,?,?,?,?,?)";
			instituteprepared = bookpurchasetypeconnection.prepareStatement(query_log);
			
			instituteprepared.setLong(1, l1);
			instituteprepared.setString(2,bookpurchasetypebean.getBookpurchasetypeid());
			instituteprepared.setString(3,bookpurchasetypebean.getLogstatus());
			instituteprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			instituteprepared.setString(5, bookpurchasetypebean.getCreatedby());
			instituteprepared.setString(6, bookpurchasetypebean.getBooktypelogstatus());
			result = instituteprepared.executeUpdate();

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
		
		if(bookpurchasetypeconnection != null)
			bookpurchasetypeconnection.close();
		
		if(rs1!=null)
		rs1.close();
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
public String checkTrashBookType(String booktypeid)
{
	String count	= null;
	try
	{
		log.info("invoking checkTrashRacks from com.iGrandee.MasterEntries.Rack.RackEntry");
		select_query	= "select count(typeofpurchase) as booktypecount from bookmaster b where b.typeofpurchase='"+booktypeid+"' and b.bookmasterstatus='A'";
		count			= common_data_object.getString(select_query);
	}
	catch(Exception exception)
	{
		log.error(exception);
	}
	return count;
}

    DateTime date_object;
    Connection bookpurchasetypeconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}