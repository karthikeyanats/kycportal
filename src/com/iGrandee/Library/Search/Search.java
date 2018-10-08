package com.iGrandee.Library.Search;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class Search
{
	static Logger log = Logger.getLogger(Search.class);

    public Search()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        booksearchconnection      = null;


        select_query = null;
    }
    /**
     * This method is accessed from jycportal/jsp/Library/Search/SimpleserchList.jsp;
     * @param sessionid that can be use to get book details by Academic session wise
     * @param booktype that can be used to  specify the book or journal
     * @param instituteid that can be use to get book details by Institution wise
     * @param typedname that can be used to search the books
     * @return ArrayList by which result can be printed on the screen
     * @throws SQLException
     */
    public ArrayList get_Received_Books(String sessionid,String booktype,String instituteid,String typedname) throws SQLException
    {
		ArrayList list=null;

		try
		{      	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select bookissueid from bookissue where bookmasterid=a.bookmasterid and (currentstatus='Issue' or currentstatus='Renewal')) as avail FROM bookmaster a ,login b,personmaster c,institution d  where a.booktype='"+booktype+"' and a.title like '%"+typedname+"%'and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.title asc";

			list=common_data_object.getListMap(select_query); 
		} 
		catch(Exception exception)
		{   
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    /**
     * This method is accessed from jycportal/jsp/Library/Search/SimpleserchList.jsp;
     * @param sessionid that can be use to get book details by Academic session wise
     * @param booktype that can be used to  specify the book or journal
     * @param instituteid that can be use to get book details by Institution wise
     * @param typedname that can be used to search the books
     * @return ArrayList by which result can be printed on the screen
     * @throws SQLException
     */
    public ArrayList get_Received_Journals(String sessionid,String booktype,String instituteid,String typedname) throws SQLException
    {
		ArrayList list=null;
		

		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates, a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select bookissueid from bookissue where bookmasterid=a.bookmasterid and (currentstatus='Issue' or currentstatus='Renewal')) as avail FROM bookmaster a ,login b, personmaster c,institution d where a.booktype='"+booktype+"' and a.bookname like '%"+typedname+"%' and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.bookname asc;";
			list=common_data_object.getListMap(select_query); 

		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    
    /**
     * This method is accessed from jycportal/jsp/Library/Search/AdvancedSearchList.jsp;
     * @param sessionid that can be use to get book details by Academic session wise
     * @param booktype that can be used to  specify the book or journal
     * @param instituteid that can be use to get book details by Institution wise
     * @param title that can be used to search books by title name
     * @param publisher  that can be used to search books by publisher name
     * @param author that can be used to search books by author name
     * @param operator that can be used to specify And or Or search
     * @param Like1 that can be used to specify starts with or end with search
     * @param Like2 that can be used to specify starts with or end with search
     * @param Like3 that can be used to specify starts with or end with search
     * @return ArrayList by which result can be printed on the screen
     * @throws SQLException
     */
    public ArrayList get_Received_Books_Advance(String sessionid,String booktype,String instituteid,String title,String publisher,String author,String operator,String Like1,String Like2,String Like3) throws SQLException
    {
		ArrayList list=null;

		try
		{      	
			if(Like1.equals("1"))
			{
				title=title+"%";
			}
			else
			{
				title="%"+title;

			}
			if(Like2.equals("1"))
			{
				publisher=publisher+"%";
			}
			else
			{
				publisher="%"+publisher;

			}
			if(Like3.equals("1"))
			{
				author=author+"%";
			}
			else
			{
				author="%"+author;

			}
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
        	if(operator.equals("And"))
        	{
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select bookissueid from bookissue where bookmasterid=a.bookmasterid and (currentstatus='Issue' or currentstatus='Renewal')) as avail FROM bookmaster a ,login b,personmaster c,institution d  where a.booktype='"+booktype+"' and a.title like '"+title+"' and a.publisher like '"+publisher+"' and a.author like '"+author+"' and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.title asc";
        	}
        	else
        	{
        	//String query_temp="a.title like '%' or a.publisher like '%' or a.author like '%'";
        		String query_temp1 = "";
        		String query_temp2 = "";
        		String query_temp3 = "";
        		String query_temp4 = "";
        		int i = 0;
        		
        		 if(!title.equals("%")){
        			 query_temp1 = "a.title like '"+title+"'";
        			 i++;
        		 }
        		 if(!publisher.equals("%")){
        			 query_temp2 = "a.publisher like '"+publisher+"'";
        			 i++;
        		 }
        		 if(!author.equals("%")){
        			 query_temp3 = "a.author like '"+author+"'";
        			 i++;
        		 }
        		 if(i>1){
        		  query_temp4 = query_temp1+" or "+query_temp2+" or "+query_temp3;
        		 }
        		 else{
        			 query_temp4 = query_temp1+query_temp2+query_temp3;
        		 }
        		 
        		 
    			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select bookissueid from bookissue where bookmasterid=a.bookmasterid and (currentstatus='Issue' or currentstatus='Renewal')) as avail FROM bookmaster a ,login b,personmaster c,institution d  where a.booktype='"+booktype+"' and ( "+query_temp4+" ) and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.title asc";

        	}
			list=common_data_object.getListMap(select_query); 
		} 
		catch(Exception exception)
		{    
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    /**
     * 
     * This method is accessed from jycportal/jsp/Library/Search/AdvancedSearchList.jsp;
     * @param sessionid that can be use to get book details by Academic session wise
     * @param booktype that can be used to  specify the book or journal
     * @param instituteid that can be use to get book details by Institution wise
     * @param bookname that can be used to search books by bookname name
     * @param publisher that can be used to search books by publisher name
     * @param volumeno that can be used to search books by volume number
     * @param operator that can be used to specify And or Or search
     * @param Like1 that can be used to specify starts with or end with search
     * @param Like2 that can be used to specify starts with or end with search
     * @param Like3 that can be used to specify starts with or end with search
     * @return ArrayList by which result can be printed on the screen
     * @throws SQLException
     */
    public ArrayList get_Received_Journals_Advance(String sessionid,String booktype,String instituteid,String bookname ,String publisher,String volumeno ,String operator,String Like1,String Like2,String Like3) throws SQLException
    {
		ArrayList list=null;
		

		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
        	if(Like1.equals("1"))
			{
        		bookname=bookname+"%";
			}
			else
			{
				bookname="%"+bookname;

			}
			if(Like2.equals("1"))
			{
				publisher=publisher+"%";
			}
			else
			{
				publisher="%"+publisher;

			}
			if(Like3.equals("1"))
			{
				volumeno=volumeno+"%";
			}
			else
			{
				volumeno="%"+volumeno;

			}
        	if(operator.equals("And"))
        	{
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates, a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select bookissueid from bookissue where bookmasterid=a.bookmasterid and (currentstatus='Issue' or currentstatus='Renewal')) as avail FROM bookmaster a ,login b, personmaster c,institution d where a.booktype='"+booktype+"' and a.bookname like '"+bookname+"' and a.publisher like '"+publisher+"' and a.volumeno like '"+volumeno+"'  and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.bookname asc;";
        	}
        	else
        	{
        		String query_temp1 = "";
        		String query_temp2 = "";
        		String query_temp3 = "";
        		String query_temp4 = "";
        		int i = 0;
        		
        		 if(!bookname.equals("%")){
        			 query_temp1 = "a.bookname like '"+bookname+"'";
        			 i++;
        		 }
        		 if(!publisher.equals("%")){
        			 query_temp2 = "a.publisher like '"+publisher+"'";
        			 i++;
        		 }
        		 if(!volumeno.equals("%")){
        			 query_temp3 = "a.volumeno like '"+volumeno+"'";
        			 i++;
        		 }
        		 if(i>1){
        		  query_temp4 = query_temp1+" or "+query_temp2+" or "+query_temp3;
        		 }
        		 else{
        			 query_temp4 = query_temp1+query_temp2+query_temp3;
        		 }
    			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates, a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select bookissueid from bookissue where bookmasterid=a.bookmasterid and (currentstatus='Issue' or currentstatus='Renewal')) as avail FROM bookmaster a ,login b, personmaster c,institution d where a.booktype='"+booktype+"' and ( "+query_temp4+" ) and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.bookname asc;";
        	}
			list=common_data_object.getListMap(select_query); 

		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }

    /**
     * This method is accessed from jycportal/jsp/Library/Search/SimpleserchList.jsp;
     * @param sessionid that can be use to get book details by Academic session wise
     * @param booktype that can be used to  specify the book or journal
     * @param instituteid that can be use to get book details by Institution wise
     * @param typedname that can be used to search the books
     * @return ArrayList by which result can be printed on the screen
     * @throws SQLException
     */
    public ArrayList get_Keyword_Books(String sessionid,String booktype,String instituteid,String typedname) throws SQLException
    {
		ArrayList list=null;

		try
		{      	
        	log.info("invoking get_All_Books from com.iGrandee.BookSearch.BookSearch");
			select_query="SELECT a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,a.price,a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select bookissueid from bookissue where bookmasterid=a.bookmasterid and (currentstatus='Issue' or currentstatus='Renewal')) as avail FROM bookmaster a ,login b,personmaster c,institution d  where a.booktype='"+booktype+"' and a.keyword like '%"+typedname+"%'and a.bookmasterstatus='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by a.title asc";

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