package com.iGrandee.Library.Report;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class BookJournalReport
{
	static Logger log = Logger.getLogger(BookJournalReport.class);

    public BookJournalReport()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        booksearchconnection      = null;


        select_query = null;
    }
    
    /**
     * This method is accessed from kycportal/jsp/BookSearch/IssuedBookJournalSearch.jsp
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
    public ArrayList get_All_IssuedBooks_DateWise(String startdate,String enddate,String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.Report.BookJournalReport");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			//select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.issuedate, '%d-%b-%Y %r') as issuedate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.issuedate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.issuedate, '%d-%b-%Y %r') as issuedate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.issuedate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A')  order by rackname,newdates asc ;";
			select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.issuedate, '%d-%b-%Y %r') as issuedate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.issuedate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.issuedate, '%d-%b-%Y %r') as issuedate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.issuedate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A')  order by rackname,newdates asc ;";
			//System.out.print("select_query:"+select_query);
			log.info(select_query);     
			list=common_data_object.getListMap(select_query); 
			
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    /**
     * This method is accessed from kycportal/jsp/BookSearch/BookRenewalList.jsp
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
    public ArrayList get_All_BookRenewal(String startdate,String enddate,String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
        	log.info("invoking get_All_Books from com.iGrandee.Report.BookJournalReport");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.renewaldate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.renewaldate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A')  order by newdates asc ;";
			log.info(select_query);     
			list=common_data_object.getListMap(select_query); 
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }

    public ArrayList get_All_BookReturn(String startdate,String enddate,String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
        	log.info("invoking get_All_BookReturn from com.iGrandee.Report.BookJournalReport");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			//select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A')  order by newdates asc ;";
			select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A')  order by newdates asc ;";
			//System.out.print("select_query-->"+select_query);
			log.info(select_query);     
			list=common_data_object.getListMap(select_query); 
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }

    public ArrayList get_All_BooktobeReturn(String startdate,String enddate,String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
        	log.info("invoking get_All_BooktobeReturn from com.iGrandee.Report.BookJournalReport");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,DATE_FORMAT(il.act_returndate, '%d-%b-%Y') as expectedreturndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and bi.currentstatus=il.bookstatus  and bi.currentstatus!='Return' and il.act_returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,DATE_FORMAT(il.act_returndate, '%d-%b-%Y') as expectedreturndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and bi.currentstatus=il.bookstatus  and bi.currentstatus!='Return' and il.act_returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A')  order by newdates asc ;";
			//System.out.print("select_query-->"+select_query);
			// and bi.currentstatus=il.bookstatus  and bi.currentstatus!='Return'
			// DATE_FORMAT(il.act_returndate, '%d-%b-%Y') as expectedreturndate,
			log.info(select_query);     
			list=common_data_object.getListMap(select_query); 
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }    

    public ArrayList get_All_BookExceedDuedate(String startdate,String enddate,String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
        	log.info("invoking get_All_BookExceedDuedate from com.iGrandee.Report.BookJournalReport");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,DATE_FORMAT(il.act_returndate, '%d-%b-%Y') as expectedreturndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and bi.currentstatus=il.bookstatus  and bi.currentstatus!='Return' and il.act_returndate between '"+startdate_temp+"' and '"+enddate_temp+"'  and il.act_returndate < curdate() and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,DATE_FORMAT(il.act_returndate, '%d-%b-%Y') as expectedreturndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid and bi.currentstatus=il.bookstatus  and bi.currentstatus!='Return' and il.act_returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.act_returndate < curdate() and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A')  order by newdates asc ;";
			log.info(select_query);     
			list=common_data_object.getListMap(select_query); 
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }    

    public ArrayList get_All_BookReserveCancel(String startdate,String enddate,String sessionid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
        	log.info("invoking get_All_BookReserveCancel from com.iGrandee.Report.BookJournalReport");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			//select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.act_returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid  and il.act_returndate between '"+startdate_temp+"' and '"+enddate_temp+"' and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A')  order by newdates asc ;";
			select_query="(SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(br.dateofreserve, '%d-%b-%Y %r') as reservedate,DATE_FORMAT(br.dateofcancel, '%d-%b-%Y %r') as canceldate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b, personmaster c,institution d,bookreservation br,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=br.bookmasterid and br.dateofcreation between '"+startdate_temp+"' and '"+enddate_temp+"' and br.status='A' and  br.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') union ( SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(br.dateofreserve, '%d-%b-%Y %r') as reservedate,DATE_FORMAT(br.dateofcancel, '%d-%b-%Y %r') as canceldate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b,personmaster c,institution d,bookreservation br,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=br.bookmasterid and br.dateofcreation between '"+startdate_temp+"' and '"+enddate_temp+"' and br.status='A' and  br.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A') order by reservedate asc";
			//System.out.print("select_query-->"+select_query);
			log.info(select_query);     
			list=common_data_object.getListMap(select_query); 
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }
    
    public ArrayList get_All_BookExceedDuedateStdwise(String startdate,String enddate,String sectionscheduleid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{	
        	log.info("invoking get_All_BookExceedDuedate from com.iGrandee.Report.BookJournalReport");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			select_query="SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,case when sa.rollno is null then concat('Student ','') else concat('Student ','(',sa.rollno,')') end as rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,DATE_FORMAT(il.act_returndate, '%d-%b-%Y') as expectedreturndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b, personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,studentallocation sa,candidateregister cr,personmaster pm where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid and bi.currentstatus=il.bookstatus  and bi.currentstatus!='Return' and il.act_returndate < curdate() and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sa.studentallocationid=cm.studentallocationid and sa.sectionscheduleid='"+sectionscheduleid+"' and cm.cardmasterstatus='A' and  sa.studentallocationstatus='A' and sa.candidateregisterid=cr.candidateregisterid and cr.candidateregisterstatus='A' and cr.personid=pm.personid and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by newdates asc ;";
			//System.out.print("select_query-->"+select_query);
			log.info(select_query);     
			list=common_data_object.getListMap(select_query); 
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }

    public ArrayList get_All_BookExceedDuedateDeptwise(String startdate,String enddate,String departmentid,String booktype,String instituteid) throws SQLException
    {
		ArrayList list=null;
	
		try
		{
			// and bi.currentstatus=il.bookstatus  and bi.currentstatus!='Return'
			// DATE_FORMAT(il.act_returndate, '%d-%b-%Y') as expectedreturndate,			

        	log.info("invoking get_All_BookExceedDuedateDeptwise from com.iGrandee.Report.BookJournalReport");
			String startdate_temp=date_object.getMySQLFormatHifen(startdate)+" 00:00:00"; 
			String enddate_temp=date_object.getMySQLFormatHifen(enddate)+" 23:59:59"; 
			select_query="SELECT case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,r.rolename,cm.cardno,a.bookmasterid,a.title,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y %r') as newdates,DATE_FORMAT(il.renewaldate, '%d-%b-%Y %r') as renewaldate,DATE_FORMAT(il.returndate, '%d-%b-%Y %r') as returndate,DATE_FORMAT(il.act_returndate, '%d-%b-%Y') as expectedreturndate,cm.cardno,a.accessno,a.codeno,a.price, a.author,a.edition,a.booktype,a.bookname,a.issueno,a.volumeno,(select rackname from rack where rackid=a.rackid and rackstatus='A') as rackname  FROM bookmaster a ,login b,personmaster c,institution d,bookissue bi,issulog il,cardmaster cm,staffmaster sm,personmaster pm,role r where a.booktype='"+booktype+"'  and a.bookmasterstatus='A' and a.bookmasterid=bi.bookmasterid and bi.bookissueid=il.bookissueid and bi.currentstatus=il.bookstatus and bi.currentstatus!='Return' and sm.departmentid='"+departmentid+"' and il.act_returndate < curdate() and il.status='A' and  bi.cardmasterid=cm.cardmasterid  and sm.staffid=cm.agentid and cm.cardmasterstatus='A' and  sm.staffstatus='A' and sm.userid=b.userid and b.personid=pm.personid and sm.roleid=r.roleid and r.status='A' and pm.status='A' and a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' order by newdates asc ;";
			log.info(select_query);     
			list=common_data_object.getListMap(select_query); 
		}
		catch(Exception exception)
		{   
				
			log.error(exception);				
		}  
	    	
	    	return list;
	    }      
    
    
    /**
     * This method is accessed from kycportal/jsp/Library/Report/CardIssueStandard.jsp(created by prasanth)
     * @param instituteid that can be used to get Board and Mediums
     * @return ArrayList by which result can be printed on the screen
     */
    
    public ArrayList loadboard(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "select a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b where a.mediumid=b.mediumid and a.instituteid='"+instituteid+"' and a.boardstatus='A' and b.mediumstatus='A' order by a.boardid,b.mediumid";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
    /**
     * this method is accessed from kycportal/jsp/Library/Report/CardIssueStandard.jsp(created by prasanth)
     * @param instituteid that can be used to get Academic Session
     * @return ArrayList by which result can be printed on the screen
     */
    public ArrayList loadsession(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "select sessionname,sessionid,sessionstatus from yearofsession where ( sessionstatus='A' OR sessionstatus='R') and instituteid='"+instituteid+"'; ";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	/**
	   * 
	   * This method is accessed from kycportal/jsp/Library/Report/CardIssueStandard.jsp(created by prasanth)
	   @param boardid that can be used to get standard name  from standard table by 
	   *
	   @param sessionid that can be used to get standard name  from standard table by 
	   *
	   @param instituteid that can be used to get standard name  from standard table by 
	   *
	   @return the ArrayList by which result can be printed on the screen
	 */
		public ArrayList loadstandardwithstatus(String boardid,String sessionid,String instituteid,String status) {
		ArrayList arraylist = null;
		try {  
			select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname," +
					"(select count(cm.studentallocationid) from  cardmaster cm,studentallocation sa,sectionschedule scs,standardschedule ss where sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and sa.studentallocationstatus='A' and sa.sectionscheduleid=scs.sectionscheduleid  and ss.standardscheduleid=scs.standardscheduleid  and scs.sectionschedulestatus='A' and ss.standardscheduleid=a.standardscheduleid and ss.stdschedulestatus='A') as issuedcount,"; 
				//" (select count(cm.studentallocationid) from  cardmaster cm, studentallocation sa,standardschedule ss,candidateregister cr where  sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and sa.studentallocationstatus='A' and cr.candidateregisterid=sa.candidateregisterid  and cr.candidateregisterstatus='A' and ss.standardscheduleid=cr.standardscheduleid  and ss.standardscheduleid=a.standardscheduleid and ss.stdschedulestatus='A') as issuedcount,";
			select_query +="(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount," + 
					       	"(SELECT count(sectionscheduleid) FROM sectionschedule ss join section b where ss.sectionid=b.sectionid and  ss.standardscheduleid=a.standardscheduleid and ss.sectionschedulestatus='A' and b.status='A') as sectioncount from standardschedule a	" +
					       	"join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";  
			//System.out.print("select_query-->"+select_query);
			log.info("===================>>>>>>>>>>>>"+select_query);   
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);  
						
		} catch (Exception exception) { 
			log.error(exception);

		}
		return    arraylist;
	}
		/**
		 * This method is accessed from  kycportal/jsp/Library/Report/CardIssueSection.jsp(created by prasanth)
		 * @param standardscheduleid that can be used to get section name,sectionid,total students,total card issued students
		 * @param status that can be used to get section name,sectionid,total students,total card issued students by status wise
		 * @return ArrayList by which result can be printed on the screen
		 */
		public ArrayList loadsectionforviewwithstatus(String standardscheduleid,String status) {
			ArrayList arraylist = null;
			try {
				
				select_query = "select a.sectionscheduleid, b.sectionname," +
								"(select count(cm.studentallocationid) from  cardmaster cm,studentallocation sa,sectionschedule scs,standardschedule ss where sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and sa.studentallocationstatus='A' and sa.sectionscheduleid=scs.sectionscheduleid  and ss.standardscheduleid=scs.standardscheduleid  and scs.sectionschedulestatus='A' and scs.sectionscheduleid=a.sectionscheduleid and ss.stdschedulestatus='A') as issuedcount,"+		
								//"(select count(cm.studentallocationid)  from  cardmaster cm, studentallocation sa,standardschedule ss,candidateregister cr,sectionschedule ses where  sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and sa.studentallocationstatus='A' and cr.candidateregisterid=sa.candidateregisterid  and  cr.candidateregisterstatus='A' and ss.standardscheduleid=cr.standardscheduleid  and  ss.stdschedulestatus='A' and ss.standardscheduleid=a.standardscheduleid and ses.standardscheduleid=ss.standardscheduleid and a.sectionscheduleid=ses.sectionscheduleid and  sa.sectionscheduleid=ses.sectionscheduleid and  ses.sectionschedulestatus='A') as issuedcount," +
						"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid   and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount" +
						" from sectionschedule a	join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";
				arraylist = common_data_object.getListMap(select_query);
			} catch (Exception exception) { 
				log.error(exception);
			}
			return    arraylist;
		}
		/**
		 * This method is accessed from kycportal/jsp/Library/Report/CardIssueStudent.jsp(created by prasanth)
		 * @param sectionscheduleid that can be used to get students by section wise
		 * @param status that can be used to get students by status wise
		 * @return ArrayList by which result can be printed on the screen
		 */
		public ArrayList loadstudentforsectionscheduleidwithstatus(String sectionscheduleid,String status) {
			ArrayList arraylist = null;
			try { 
				
				select_query = "SELECT s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,cmr.studentallocationid,cm.personid,DATE_FORMAT(cmr.expirydate, '%d-%b-%Y') as issuedate FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s left outer  join cardmaster cmr on cmr.studentallocationid=s.studentallocationid and cmr.cardmasterstatus='A' ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')  and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid";
				arraylist = common_data_object.getListMap(select_query);
				log.info("==========>>>>>"+select_query);

			} catch (Exception exception) 
			{ 
				log.error(exception);

			}
			return    arraylist;
		}
		/**
		 * This method is accessed from kycportal/jsp/Library/Report/CardIssueStaff.jsp(created by prasanth)
		 * @param instituteid that can be used to get department name and department id
		 * @return ArrayList by which result can be printed on the screen
		 */
		 public ArrayList departmentload(String instituteid) {
				ArrayList arraylist = null;

				try {
					select_query = "select departmentid,departmentname from department where status='A' and instituteid="+instituteid;
					arraylist = common_data_object.getListMap(select_query);
					//log.info("==========>>>>>"+arraylist);
					
				} catch (Exception exception) {
					log.error(exception);

				}
				return arraylist;
			}
		 /**
		  * This method is accessed from kycportal/jsp/Library/Report/CardIssueStaff.jsp(created by prasanth)
		  * @param departmentid that can used to get total no of staffs under that department
		  * @return ArrayList by which result can be printed on the screen
		  */
			public String departmentvisestaffcount(String departmentid) {
				String count = null;
				try {   
					select_query = "SELECT count(staffid)  FROM staffmaster where departmentid='"+departmentid+"' and staffstatus='A'";
					count = common_data_object.getSingleColumn(select_query);
				} catch (Exception exception) {
					log.error(exception);

				}
				return count;
			}
			 /**
			  * This method is accessed from kycportal/jsp/Library/Report/CardIssueStaff.jsp(created by prasanth)
			  * @param departmentid that can used to get total no of card issued staffs under that department
			  * @return ArrayList by which result can be printed on the screen
			  */
			public String cardissuestaffcount(String departmentid) {
				String count = null;
				try {   
					select_query = "select count(cm.agentid) as issuedcount from cardmaster cm join staffmaster sm on cm.agentid=sm.staffid and cardmasterstatus='A' and sm.departmentid='"+departmentid+"' and staffstatus='A';";
					count = common_data_object.getSingleColumn(select_query);
				} catch (Exception exception) {
					log.error(exception);

				}
				return count;
			}
			/**
			 * This method is accessed from kycportal/jsp/Library/Report/CardIssueStaffList.jsp(created by prasanth)
			 * @param departmentid that can be used to get staff details under that department
			 * @return ArrayList by which result can be printed on the screen
			 */
			public ArrayList departmentvisestaff(String departmentid) {
				ArrayList arraylist = null;

				try {
					select_query = "SELECT a.roleid,r.rolename,cm.agentid,case when p.middlename='-' or p.middlename='' then concat(p.prefix,' ',p.firstname,' ',p.lastname) else concat(p.prefix,' ',p.firstname,' ',p.middlename,' ',p.lastname) end as uname,p.qualification,DATE_FORMAT(cm.expirydate,'%d-%b-%Y') as issueddate FROM staffmaster a left outer join cardmaster cm on cm.cardmasterstatus='A' and a.staffid=cm.agentid ,personmaster p,role r,staffcategory sc  where a.staffstatus='A'  and r.roleid=a.roleid and a.userid =p.personid and r.status='A' and a.departmentid='"+departmentid+"' and  sc.staffcategoryid =a.staffcategoryid and p.status='A' and sc.staffcategorystatus='A' order by r.rolename,sc.staffcategoryid;";
					arraylist = common_data_object.getListMap(select_query);
					//log.info("==========>>>>>"+arraylist);
				} catch (Exception exception) {
					log.error(exception);
				}
				return arraylist;
			}
			
			/**
			   * 
			   * This method is accessed from kycportal/jsp/Library/Report/UserNotUtilStandard.jsp(created by subhash)
			   @param boardid that can be used to get standard name  from standard table by 
			   *
			   @param sessionid that can be used to get standard name  from standard table by 
			   *
			   @param instituteid that can be used to get standard name  from standard table by 
			   *
			   @return the ArrayList by which result can be printed on the screen
			 */
				public ArrayList loadstandardNotUtilStudents(String boardid,String sessionid,String instituteid,String status) {
				ArrayList arraylist = null;
				try {  
					select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname," +
							"(select count(cm.studentallocationid) from  cardmaster cm,studentallocation sa,sectionschedule scs,standardschedule ss where sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and sa.studentallocationstatus='A' and sa.sectionscheduleid=scs.sectionscheduleid  and ss.standardscheduleid=scs.standardscheduleid  and scs.sectionschedulestatus='A' and ss.standardscheduleid=a.standardscheduleid and ss.stdschedulestatus='A' and cm.cardmasterid in (select cardmasterid from bookissue)) as utilcount,"; 
						//" (select count(cm.studentallocationid) from  cardmaster cm, studentallocation sa,standardschedule ss,candidateregister cr where  sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and sa.studentallocationstatus='A' and cr.candidateregisterid=sa.candidateregisterid  and cr.candidateregisterstatus='A' and ss.standardscheduleid=cr.standardscheduleid  and ss.standardscheduleid=a.standardscheduleid and ss.stdschedulestatus='A') as issuedcount,";
					select_query +="(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount," + 
							       	"(SELECT count(sectionscheduleid) FROM sectionschedule ss join section b where ss.sectionid=b.sectionid and  ss.standardscheduleid=a.standardscheduleid and ss.sectionschedulestatus='A' and b.status='A') as sectioncount from standardschedule a	" +
							       	"join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";  
					//System.out.print("select_query-->"+select_query);
					log.info("===================>>>>>>>>>>>>"+select_query);   
					arraylist = common_data_object.getListMap(select_query);
					log.info("==========>>>>>"+arraylist);  
								
				} catch (Exception exception) { 
					log.error(exception);

				}
				return    arraylist;
			}
				
				/**
				 * This method is accessed from  kycportal/jsp/Library/Report/UserNotUtilSection.jsp(created by Subhash)
				 * @param standardscheduleid that can be used to get section name,sectionid,total students,total card issued students
				 * @param status that can be used to get section name,sectionid,total students,total card issued students by status wise
				 * @return ArrayList by which result can be printed on the screen
				 */
				public ArrayList loadsectionNotUtilStudents(String standardscheduleid,String status) {
					ArrayList arraylist = null;
					try {
						
						select_query = "select a.sectionscheduleid, b.sectionname," +
										"(select count(cm.studentallocationid) from  cardmaster cm,studentallocation sa,sectionschedule scs,standardschedule ss where sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and sa.studentallocationstatus='A' and sa.sectionscheduleid=scs.sectionscheduleid  and ss.standardscheduleid=scs.standardscheduleid  and scs.sectionschedulestatus='A' and scs.sectionscheduleid=a.sectionscheduleid and ss.stdschedulestatus='A'and cm.cardmasterid in (select cardmasterid from bookissue)) as utilcount,"+		
									  //"(select count(cm.studentallocationid) from  cardmaster cm, studentallocation sa,standardschedule ss,candidateregister cr,sectionschedule ses where  sa.studentallocationid=cm.studentallocationid and cm.cardmasterstatus='A' and sa.studentallocationstatus='A' and cr.candidateregisterid=sa.candidateregisterid  and  cr.candidateregisterstatus='A' and ss.standardscheduleid=cr.standardscheduleid  and  ss.stdschedulestatus='A' and ss.standardscheduleid=a.standardscheduleid and ses.standardscheduleid=ss.standardscheduleid and a.sectionscheduleid=ses.sectionscheduleid and  sa.sectionscheduleid=ses.sectionscheduleid and  ses.sectionschedulestatus='A') as issuedcount," +
								"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid   and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount" +
								" from sectionschedule a	join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";
						arraylist = common_data_object.getListMap(select_query);
					} catch (Exception exception) { 
						log.error(exception);
					}
					return    arraylist;
				}

				/**
				 * This method is accessed from kycportal/jsp/Library/Report/UserNotUtilStudent.jsp(created by subhash)
				 * @param sectionscheduleid that can be used to get students by section wise
				 * @param status that can be used to get students by status wise
				 * @return ArrayList by which result can be printed on the screen
				 */
				public ArrayList loadstudentforsectionNotUtilStudents(String sectionscheduleid,String status) {
					ArrayList arraylist = null;
					try { 
						
						//select_query = "SELECT s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,cmr.studentallocationid,cm.personid,DATE_FORMAT(cmr.expirydate, '%d-%b-%Y') as issuedate FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s left outer  join cardmaster cmr on cmr.studentallocationid=s.studentallocationid and cmr.cardmasterstatus='A' ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')  and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid";
						select_query = "(SELECT s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,cmr.studentallocationid,cm.personid,DATE_FORMAT(cmr.expirydate, '%d-%b-%Y') as issuedate FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s left join cardmaster cmr on cmr.studentallocationid=s.studentallocationid and cmr.cardmasterstatus='A' ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('A')  and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid and cmr.studentallocationid is null) union (SELECT s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,cmr.studentallocationid,cm.personid,DATE_FORMAT(cmr.expirydate, '%d-%b-%Y') as issuedate FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s  left outer join cardmaster cmr on cmr.studentallocationid=s.studentallocationid and cmr.cardmasterstatus='A' ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('A')  and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid and cmr.cardmasterid not in (select cardmasterid from bookissue))";	
						
						arraylist = common_data_object.getListMap(select_query);
						log.info("==========>>>>>"+select_query);

					} catch (Exception exception) 
					{ 
						log.error(exception);

					}
					return    arraylist;
				}

				 /**
				  * This method is accessed from kycportal/jsp/Library/Report/UserNotUtilStaff.jsp(created by subhash)
				  * @param departmentid that can used to get total no of card issued staffs under that department
				  * @return ArrayList by which result can be printed on the screen
				  */
				public String loadNotUtilStaff(String departmentid) {
					String count = null;
					try {   
						select_query = "select count(distinct cm.agentid) as utilcount from bookissue bi join cardmaster cm on bi.cardmasterid=cm.cardmasterid join staffmaster sm on cm.agentid=sm.staffid and cardmasterstatus='A' and sm.departmentid='"+departmentid+"' and staffstatus='A';";
						//System.out.print("select_query-->"+select_query);
						count = common_data_object.getSingleColumn(select_query);
					} catch (Exception exception) {
						log.error(exception);

					}
					return count;
				}				

				/**
				 * This method is accessed from kycportal/jsp/Library/Report/UserNotUtilStaffList.jsp(created by subhash)
				 * @param departmentid that can be used to get staff details under that department
				 * @return ArrayList by which result can be printed on the screen
				 */
				public ArrayList departmentvisestaffNotUtil(String departmentid) {
					ArrayList arraylist = null;

					try {
						select_query = "(SELECT a.roleid,r.rolename,sc.staffcategoryid,cm.agentid,case when p.middlename='-' or p.middlename='' then concat(p.prefix,' ',p.firstname,' ',p.lastname) else concat(p.prefix,' ',p.firstname,' ',p.middlename,' ',p.lastname) end as uname,p.qualification,DATE_FORMAT(cm.expirydate,'%d-%b-%Y') as issueddate FROM staffmaster a left outer join cardmaster cm on cm.cardmasterstatus='A' and a.staffid=cm.agentid ,personmaster p,role r,staffcategory sc  where a.staffstatus='A'  and r.roleid=a.roleid and a.userid =p.personid and r.status='A' and a.departmentid='"+departmentid+"' and sc.staffcategoryid =a.staffcategoryid and p.status='A' and sc.staffcategorystatus='A' and cm.agentid is null) union (SELECT a.roleid,r.rolename,sc.staffcategoryid,cm.agentid,case when p.middlename='-' or p.middlename='' then concat(p.prefix,' ',p.firstname,' ',p.lastname) else concat(p.prefix,' ',p.firstname,' ',p.middlename,' ',p.lastname) end as uname,p.qualification,DATE_FORMAT(cm.expirydate,'%d-%b-%Y') as issueddate FROM staffmaster a left outer join cardmaster cm on cm.cardmasterstatus='A' and a.staffid=cm.agentid ,personmaster p,role r,staffcategory sc  where a.staffstatus='A'  and r.roleid=a.roleid and a.userid =p.personid and r.status='A' and a.departmentid='"+departmentid+"' and sc.staffcategoryid =a.staffcategoryid and p.status='A' and sc.staffcategorystatus='A' and cm.cardmasterid not in (select cardmasterid from bookissue)) order by rolename,staffcategoryid";
						arraylist = common_data_object.getListMap(select_query);
						//log.info("==========>>>>>"+arraylist);
					} catch (Exception exception) {
						log.error(exception);
					}
					return arraylist;
				}				
    DateTime date_object;
    Connection booksearchconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}