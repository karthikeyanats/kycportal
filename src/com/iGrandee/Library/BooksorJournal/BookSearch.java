package com.iGrandee.Library.BooksorJournal;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class BookSearch
{
	static Logger log = Logger.getLogger(BookSearch.class);

    public BookSearch()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        booksearchconnection      = null;


        select_query = null;
    }
    /**
     * This method is accessed from kycportal/jsp/BookSearch/BookSearch.jsp
     * get date wise book details - prasanth
     @param  startdate  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  enddate  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  booktype  that can be used specify which type of book
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList get_All_Books_DateWise(String startdate,String enddate,String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			//select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a,yearofsession b where a.sessionid=b.sessionid and b.sessionstatus='A' and a.sessionid='"+sessionid+"' and  a.booktype='"+booktype+"' and a.dateofcreation between '"+startdate_temp+"' and '"+enddate_temp+"'  and b.instituteid='"+instituteid+"'  and a.bookmasterstatus='A' order by a.dateofcreation desc;";
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a ,login b,personmaster c,institution d where a.booktype='"+booktype+"' and a.dateofcreation between '"+startdate_temp+"' and '"+enddate_temp+"' and a.bookmasterstatus='A' and  a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.dateofcreation desc;";

			list=common_data_object.getListMap(select_query); 
			
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
   
    /**
     * This method is accessed from kycportal/jsp/BookSearch/BookSearch.jsp
     * get particular book details - prasanth
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  rackid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  instituteid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  booktype  that can be used specify which type of book
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList get_All_Books_RackWise(String rackid,String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
			
		
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			//select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a,yearofsession b where a.sessionid=b.sessionid and b.sessionstatus='A' and a.sessionid='"+sessionid+"' and  a.booktype='"+booktype+"' and a.rackid= '"+rackid+"'   and b.instituteid='"+instituteid+"'  and a.bookmasterstatus='A' order by a.dateofcreation desc;";
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates, a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a,login b,personmaster c,institution d where a.booktype='"+booktype+"' and a.rackid= '"+rackid+"' and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.dateofcreation desc";
System.out.println(select_query);
			list=common_data_object.getListMap(select_query); 
			
		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
	    }
    /**
     * This method is accessed from kycportal/jsp/BookSearch/BookDetails.jsp
     * get date wise book details - prasanth
     @param  sessionid  that can be used to get all details about book from bookmaster table
     *
     @param  bookmasterid  that can be used to get all details about book from bookmaster table
     *
     @param  instituteid  that can be used to get all details about book from bookmaster table
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList getBookDeatils(String bookmasterid,String sessionid,String instituteid) 
    {
		ArrayList list=null;
		

		
		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			select_query="SELECT y.sessionname,b.rackname,d.bookpurchasetypename,a.bookmasterid,a.accessno,a.codeno,a. title, a.serialtitile,a. location,a.publisher,a. price, a.remarks,a.keyword, a.donatedby,a.callno,a. author,a. corporateauthor, a.serialauthor,a.supplier, a.edition,a. typeofpurchase,a. booktype, a. bookformat,a. bookname, a.issn, a.issueno,a. country,a.frequencyid,a.deliverymode,a.validateperiod,a.supplierdetails,a. contactno, a.subcription, a.volumeno, a.bookmasterstatus,a. createdby,a.dateofcreation,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(a.validateperiod, '%d-%b-%Y') as validateperiod_temp,DATE_FORMAT(a.recddate, '%d-%b-%Y') as recddate_temp,DATE_FORMAT(a.retperiod, '%d-%b-%Y') as retperiod_temp,a.accessno, a.rackid,a.callno,a.issn, a.frequencyid,DATE_FORMAT(recddate, '%d-%b-%Y') as recddate_temp, DATE_FORMAT(a.subcription, '%d-%b-%Y') as subcription_temp  FROM bookmaster a join yearofsession y on y.sessionid=a.sessionid   and y.instituteid='"+instituteid+"' and a.bookmasterid='"+bookmasterid+"' and a.bookmasterstatus in ('A','F')   left outer join rack b on b.rackid=a.rackid and b.rackstatus='A'    left outer join bookpurchasetype d on d.bookpurchasetypeid=a.typeofpurchase and d.booktypestatus='A' and y.instituteid=b.instituteid and  b.instituteid=d.instituteid;";
        	System.out.println(select_query);
			list=common_data_object.getListMap(select_query); 
		

		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
	}
    /**
     * This method is accessed from kycportal/jsp/BookSearch/JournalBookDeatils.jsp
     * get date wise book details - prasanth
     @param  sessionid  that can be used to get all details about book from bookmaster table
     *
     @param  bookmasterid  that can be used to get all details about book from bookmaster table
     *
     @param  instituteid  that can be used to get all details about book from bookmaster table
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList getBookDeatilsJournal(String bookmasterid,String sessionid,String instituteid) 
    {
		ArrayList list=null;
		

		
		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			select_query="SELECT y.sessionname,b.rackname,c.frequencyname,a.bookmasterid,a.accessno,a.codeno,a. title, a.serialtitile,a. location,a.publisher,a. price, a.remarks,a.keyword, a.donatedby,a.callno,a. author,a. corporateauthor, a.serialauthor,a.supplier, a.edition,a. typeofpurchase,a. booktype, a. bookformat,a. bookname, a.issn, a.issueno,a. country,a.frequencyid,a.deliverymode,a.validateperiod,a.supplierdetails,a. contactno, a.subcription, a.volumeno, a.bookmasterstatus,a. createdby,a.dateofcreation,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(a.validateperiod, '%d-%b-%Y') as validateperiod_temp,DATE_FORMAT(a.recddate, '%d-%b-%Y') as recddate_temp,DATE_FORMAT(a.retperiod, '%d-%b-%Y') as retperiod_temp,a.accessno, a.rackid,a.callno,a.issn, a.frequencyid,DATE_FORMAT(recddate, '%d-%b-%Y') as recddate_temp, DATE_FORMAT(a.subcription, '%d-%b-%Y') as subcription_temp  FROM bookmaster a join yearofsession y on y.sessionid=a.sessionid  and y.instituteid='"+instituteid+"' and a.bookmasterid='"+bookmasterid+"' and a.bookmasterstatus='A'   left outer join rack b on b.rackid=a.rackid and b.rackstatus='A'  left outer join frequency c on c.frequencyid=a.frequencyid and c.frequencystatus='A'   and y.instituteid=b.instituteid and b.instituteid=c.instituteid  ;";
        	list=common_data_object.getListMap(select_query); 
		

		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
	}
   
    /**
     * This method is accessed from kycportal/jsp/BookSearch/NewArrivalBook.jsp
     * get date wise book details - prasanth
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  booktype  that can be used specify which type of book
     *
     @param  instituteid  that can be used get book detail by instituteion wise
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList get_NewArrival_Books(String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
		String list_startdate=null;
		String list_enddate=null;

		try
		{      	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");

			String startdate_temp="select DATE_SUB(curdate(), INTERVAL 7 DAY)"; 
			list_startdate=common_data_object.getString(startdate_temp); 
			list_startdate=list_startdate+" 00:00:00";
			String enddate_temp="select curdate()";
			list_enddate=common_data_object.getString(enddate_temp); 
			list_enddate=list_enddate+" 23:59:59";
			//select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a,yearofsession b where a.sessionid=b.sessionid and b.sessionstatus='A' and a.sessionid='"+sessionid+"' and  a.booktype='"+booktype+"' and a.dateofcreation between '"+list_startdate+"' and '"+list_enddate+"'  and b.instituteid='"+instituteid+"'  and a.bookmasterstatus='A' order by a.dateofcreation desc;";
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates, a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a,login b,personmaster c,institution d where  a.booktype='"+booktype+"' and a.dateofcreation between '"+list_startdate+"' and '"+list_enddate+"' and a.bookmasterstatus='A'  and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.dateofcreation desc";

			list=common_data_object.getListMap(select_query); 
		} 
		catch(Exception exception)
		{   
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    /**
     * This method is accessed from kycportal/jsp/BookSearch/ReceivedBook.jsp
     * get date wise book details - prasanth
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  booktype  that can be used specify which type of book
     *
     @param  instituteid  that can be used get book detail by instituteion wise
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList get_Received_Books(String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;

		try
		{      	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a ,login b,personmaster c,institution d where a.booktype='"+booktype+"' and (a.bookmasterstatus='A' or a.bookmasterstatus='F')  and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.dateofcreation desc;";

			list=common_data_object.getListMap(select_query); 
		} 
		catch(Exception exception)
		{   
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    /**
     * This method is accessed from kycportal/jsp/BookSearch/NewArrivalJournal.jsp
     * get date wise book details - prasanth
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  booktype  that can be used specify which type of book
     *
     @param  instituteid  that can be used get book detail by instituteion wise
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList get_NewArrival_Journals(String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
		String list_startdate="";
		String list_enddate="";

		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");

			String startdate_temp="select DATE_SUB(curdate(), INTERVAL 7 DAY)"; 
			list_startdate=common_data_object.getString(startdate_temp); 
			list_startdate=list_startdate+" 00:00:00";
			String enddate_temp="select curdate()";
			list_enddate=common_data_object.getString(enddate_temp); 
			list_enddate=list_enddate+" 23:59:59";
			//select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a,yearofsession b where a.sessionid=b.sessionid and b.sessionstatus='A' and a.sessionid='"+sessionid+"' and  a.booktype='"+booktype+"' and a.dateofcreation between '"+list_startdate+"' and '"+list_enddate+"'  and b.instituteid='"+instituteid+"'  and a.bookmasterstatus='A' order by a.dateofcreation desc;";
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a,login b,personmaster c,institution d where  a.booktype='"+booktype+"' and a.dateofcreation between '"+list_startdate+"' and '"+list_enddate+"' and a.bookmasterstatus='A'  and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A'order by a.dateofcreation desc";

			list=common_data_object.getListMap(select_query); 
			
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    /**
     * This method is accessed from kycportal/jsp/BookSearch/ReceivedBook.jsp
     * get date wise book details - prasanth
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  booktype  that can be used specify which type of book
     *
     @param  instituteid  that can be used get book detail by instituteion wise
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList get_Received_Journals(String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
		

		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a,login b,personmaster c,institution d where a.booktype='"+booktype+"' and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.dateofcreation desc;";

			list=common_data_object.getListMap(select_query); 
			
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    /**
     * This method is accessed from kycportal/jsp/BookSearch/RackWiseSearch.jsp
     * get department wise book details - prasanth
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  instituteid  that can be used specify instituteid wise
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList getBookJournalCount(String instituteid,String sessionid) 
    {
		ArrayList list=null;
		

		
		try
		{	
        	log.info("invoking get_All_Rack Names from com.iGrandee.BookSearch.BookSearch");
			//select_query="select a.rackid,a.rackname,b.booktype,b.bookmasterid,DATE_FORMAT(b.dateofcreation, '%d-%b-%Y %r') as newdates,b.price,b.author, b.edition,b.bookname,b.issueno,b.volumeno from rack a join yearofsession y on a.instituteid=y.instituteid and y.sessionid='"+sessionid+"' and y.instituteid='"+instituteid+"' and y.sessionstatus='A' and a.rackstatus='A'  left outer join bookmaster b on a.rackid=b.rackid and b.bookmasterstatus='A' order by a.rackid";
			select_query="select a.rackid,a.rackname,b.booktype,b.bookmasterid,DATE_FORMAT(b.dateofcreation, '%d-%b-%Y %r') as newdates,b.price,b.author, b.edition,b.bookname,b.issueno,b.volumeno from rack a join institution y on a.instituteid=y.instituteid  and y.instituteid='"+instituteid+"' and y.status='A' and a.rackstatus='A' left outer join bookmaster b on a.rackid=b.rackid and b.bookmasterstatus='A' order by a.rackid;";
			//System.out.print("select_query-->"+select_query);
			list=common_data_object.getListMap(select_query); 
		

		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list;
	}
    /**
     * This method is accessed from kycportal/jsp/BookSearch/NewArrivalBook.jsp
     * get department wise book details - prasanth
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  instituteid  that can be used specify instituteid wise
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public String get_StartDate(String instituteid) 
    {
		String list=null;
		String list_startdate="";
		
		try
		{	
        	log.info("invoking get_All_Rack Names from com.iGrandee.BookSearch.BookSearch");
        	String startdate_temp="select DATE_SUB(curdate(), INTERVAL 7 DAY)"; 
			list_startdate=common_data_object.getString(startdate_temp); 
		

		}
		catch(Exception exception)
		{ 
				
			log.error(exception);				
		}
	    	
	    	return list_startdate;
	}

    /**
     * This method is accessed from kycportal/jsp/BookSearch/BookNotUtilize.jsp
     * get date wise book details - Subhash
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  booktype  that can be used specify which type of book
     *
     @param  instituteid  that can be used get book detail by instituteion wise
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList get_NotUtilize_Books(String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;

		try
		{      	
        	log.info("invoking get_NotUtilize_Books from com.iGrandee.BookSearch.BookSearch");
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno FROM bookmaster a ,login b,personmaster c,institution d where a.bookmasterid not in (select bookmasterid from bookissue) and a.booktype='"+booktype+"' and a.bookmasterstatus='A'  and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.dateofcreation desc;";
			log.info("Query :"+select_query);
			list=common_data_object.getListMap(select_query); 
		} 
		catch(Exception exception)
		{   
			log.error(exception);				
		}  
	    	
	    	return list;
	  }

    /**
     * This method is accessed from kycportal/jsp/BookSearch/BookNotUtilize.jsp
     * get date wise book details - Subhash
     @param  sessionid  that can be used to get bookmasterid,title,price,edition ,author details from bookmaster table
     *
     @param  booktype  that can be used specify which type of book
     *
     @param  instituteid  that can be used get book detail by instituteion wise
     *
	 @return the ArrayList by which result can be printed on the screen
    */
    public ArrayList get_MostUtilize_Books(String sessionid,String booktype,String instituteid,String orderval,String noofbooks) throws SQLException
    {
		ArrayList list=null;

		try
		{      	
        	log.info("invoking get_MostUtilize_Books from com.iGrandee.BookSearch.BookSearch");
			//select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select count(bookmasterid) from bookissue where bookmasterid=a.bookmasterid) as accesscount FROM bookmaster a ,login b,personmaster c,institution d where a.booktype='"+booktype+"' and a.bookmasterstatus='A'  and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' group by a.bookmasterid order by accesscount "+orderval+" limit 0,"+noofbooks+"";
        	select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select count(bookmasterid) from bookissue where bookmasterid=a.bookmasterid) as accesscount FROM bookmaster a ,login b,personmaster c,institution d where a.booktype='"+booktype+"' and a.bookmasterstatus='A'  and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' group by a.bookmasterid order by accesscount "+orderval+"";
			log.info("Query :"+select_query);
			list=common_data_object.getListMap(select_query); 
		} 
		catch(Exception exception)
		{   
			log.error(exception);				
		}  
	    	
	    	return list;
	  }    
   
    DateTime date_object;
    Connection booksearchconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}