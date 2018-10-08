package com.iGrandee.SchoolCalender;
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

public class SchoolCalenderEntry
{
	static Logger log = Logger.getLogger(SchoolCalenderEntry.class);

    public SchoolCalenderEntry()
    {
    	date_object = new DateTime();
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        studentcalendarconnection      = null;
       select_query = null;
    }
    /**
	  * This method is accessed from kycportal/jsp/SchoolCalender/SubmitCalendar.jsp
	  * insert  SchoolCalender details      - prasanth
	  @param  schoolcalendarid that can be used to insert details to  schoolcalender table 
	  *
      @param eventdate that can be used to insert details to  schoolcalender table 
      *
      @param  eventdescription that can be used to insert details to  schoolcalender table 
      *
      @param sessionid that can be used to insert details to  schoolcalender table 
      *
      @param dateofcreation that can be used to insert details to  schoolcalender table
      * 
      @param ipaddress that can be used to insert details to  schoolcalender table 
      *
      @param createdby that can be used to insert details to  schoolcalender table 
      *
      @param calendarstatus that can be used to insert details to  schoolcalender table 
      *
      @param holidaystatus that can be used to insert details to  schoolcalender table 
      *
      @return  int by which result can be printed on the screen
	*/
	
    public int insertSchoolCalendar(SchoolCalenderBean schoolCalenderBean) throws Exception
	 {
		 	log.info("invoking insertSchoolCalender details from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
		 
		 	int result					= 0;
			PreparedStatement schoolcalendarprepared = null;
			
	 try
	 {
			 studentcalendarconnection = ConnectionManager.getKycConnection();
			 studentcalendarconnection.setAutoCommit(false);
			 
			String query="select max(schoolcalendarid) from schoolcalendar";
			long schoolcalendarid = common_data_object.maxId(query);
			schoolcalendarid++;
			
			query="insert into schoolcalendar (schoolcalendarid, eventdate, eventdescription, sessionid, dateofcreation, ipaddress, createdby, calendarstatus,holidaystatus) values(?,?,?,?,?,?,?,?,?)";
			schoolcalendarprepared = studentcalendarconnection.prepareStatement(query);
			schoolcalendarprepared.setLong(1, schoolcalendarid);
			log.info(schoolCalenderBean.getEventdate());
			String sss=schoolCalenderBean.getEventdate();
			
			String dateofff=date_object.getMySQLFormat(sss).toString();
		
			schoolcalendarprepared.setString(2,dateofff);
			schoolcalendarprepared.setString(3,schoolCalenderBean.getEventdescription());
			schoolcalendarprepared.setString(4,schoolCalenderBean.getSessionid());
			schoolcalendarprepared.setString(5, DateTime.showTime("MySqlWithTime"));
			schoolcalendarprepared.setString(6,schoolCalenderBean.getIpaddress());
			schoolcalendarprepared.setString(7,schoolCalenderBean.getCreatedby());
			schoolcalendarprepared.setString(8,"A");
			schoolcalendarprepared.setString(9,schoolCalenderBean.getEventholidaystatus());

			result += schoolcalendarprepared.executeUpdate();
								

			studentcalendarconnection.commit();
	 }catch(SQLException e){
			log.error(e);
			result	= 0;
			if(studentcalendarconnection != null)
				studentcalendarconnection.rollback();
	 }
	 finally
		{
	
		 if(schoolcalendarprepared != null)
			schoolcalendarprepared.close();
		
		 if(studentcalendarconnection != null)
		 studentcalendarconnection.close();
		 }
	 return result;
	 }
    /**
	  * This method is accessed from kycportal/jsp/SchoolCalender/SchoolCalenderEntry.jsp
	  * to view all active yearofsession             - prasanth
	   @param  instituteid that can be used to display all details from  schoolcalender table by instituteid wise 
	   *
       @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList listYearofSession(String instituteid) throws Exception
    {
		ArrayList list=null;
		try
		{	
			log.info("invoking list year of sessions for SchoolCalender from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			
			select_query="select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"+instituteid+"'  and ( sessionstatus='A'   or sessionstatus='R' )";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/SchoolCalender/SchoolCalenderEntry.jsp
	  * to view all active yearofsession             - prasanth
	   @param  instituteid that can be used to display all archival details from  schoolcalender table by instituteid wise 
	   *
      @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList listYearofSessionRK(String instituteid) throws Exception
    {
		ArrayList list=null;
		try
		{	
			log.info("invoking list year of sessions for SchoolCalender from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			
			select_query="select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"+instituteid+"'  and  sessionstatus='R'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/SchoolCalender/SchoolCalendarView.jsp
	   * to view all active SchoolCalender  details           - prasanth
	   @param  sessionid that can be used to display all event details from  schoolcalender table by sessionid wise 
	   *
       @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList eventList(SchoolCalenderBean schoolCalenderBean) throws Exception
    {
		ArrayList list=null;
		try
		{	String sessionid=schoolCalenderBean.getSessionid();
			log.info("invoking to view all active SchoolCalender  details from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			
			select_query="select a.holidaystatus,b.sessionstatus,a.schoolcalendarid,a.eventdate,a.eventdescription,a.sessionid,a.calendarstatus, DATE_FORMAT(a.eventdate, '%d-%b-%Y') as newdates,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates1 from schoolcalendar a,yearofsession b where a.calendarstatus='A' and a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and (b.sessionstatus='A' or b.sessionstatus='R') order by a.eventdate desc";
				//System.out.println("select_query"+select_query);
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
      * This method is accessed from com/igrandee/Calenderpdf.java
	  * get all eventListRK  details           - prasanth
	  @param  sessionid that can be used to display all details from  schoolcalender table 
	  *
      @param boardid that can be used to display all details from  schoolcalender table 
      *
      @param instituteid that can be used to display all details from  schoolcalender 
      *
      @param sessionid that can be used to display all details from  schoolcalender 

      @return  ArrayList by which result can be printed on the screen
     */
    public ArrayList eventListRK(SchoolCalenderBean schoolCalenderBean) throws Exception
    {
		ArrayList list=null;
		try
		{	String sessionid=schoolCalenderBean.getSessionid();
		String boardid=schoolCalenderBean.getboardid();
		String instituteid=schoolCalenderBean.getinstituteid();
			log.info("invoking to view all active SchoolCalender  details from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			
			select_query="select distinct b.sessionstatus,a.schoolcalendarid,a.eventdate,a.eventdescription,a.sessionid, a.calendarstatus, DATE_FORMAT(a.eventdate, '%d-%b-%Y') as newdates,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates1,a.holidaystatus from schoolcalendar a,yearofsession b,board c,standard d,standardschedule e where a.calendarstatus='A' and a.sessionid='"+sessionid+"' and c.boardid='"+boardid+"' and c.instituteid='"+instituteid+"' and c.boardid=d.boardid and  e.standardid=d.standardid and d.instituteid=d.instituteid and a.sessionid=b.sessionid  and e.stdschedulestatus='A' and   b.sessionstatus='R' and c.boardstatus='A' and d.standardstatus='A' order by a.eventdate desc";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/SchoolCalender/SchoolCalendarTrashList.jsp
	  * get all SchoolCalender trash list details           - prasanth
	  @param  sessionid that can be used to display all tash list details from  schoolcalender table by sessionid wise
	  * 
      @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList eventListTrashList(SchoolCalenderBean schoolCalenderBean) throws Exception
    {
		ArrayList list=null;
		try
		{	String sessionid=schoolCalenderBean.getSessionid();
			log.info("invoking to get all  for SchoolCalender trash list details from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			select_query="select b.sessionstatus,a.schoolcalendarid,a.eventdate,a.eventdescription,a.sessionid,a.calendarstatus, DATE_FORMAT(a.eventdate, '%d-%b-%Y') as newdates,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates1 from schoolcalendar a ,yearofsession b where a.calendarstatus='T' and a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid order by a.eventdate desc;";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/SchoolCalender/SchoolCalendarEdit.jsp
	   * update SchoolCalender details           - prasanth
	   @param  schoolcalendarid that can be used to display event detail from  schoolcalender table by schoolcalendarid wise 
	   *
       @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList getCalendarListForEdit(SchoolCalenderBean schoolCalenderBean) throws Exception
    {
		ArrayList list=null;
		try
		{	log.info("invoking to update school calender from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			String schoolcalendarid=schoolCalenderBean.getSchoolcalendarid();

			select_query="select holidaystatus,schoolcalendarid,DATE_FORMAT(eventdate, '%d-%b-%Y') as newdates,eventdate,eventdescription,sessionid,calendarstatus from schoolcalendar where  schoolcalendarid='"+schoolcalendarid+"'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	  * This method is accessed from kycportal/jsp/SchoolCalender/calendaractivity.jsp
	  * update SchoolCalender details           - prasanth
	  * @param  eventdate  that can be used to update all details to  schoolcalender table by schoolcalendarid wise 
	  * 
      @param eventdescription that can be used to update all details to  schoolcalender table by schoolcalendarid wise
      *
      @param ipaddress that can be used to update all details to  schoolcalender table by schoolcalendarid wise
      *
      @param dateofcreation that can be used to update all details to  schoolcalender table by schoolcalendarid wise
      *
      @param holidaystatus that can be used to update all details to  schoolcalender table by schoolcalendarid wise
      *
      @param schoolcalendarid that can be used to update all details to  schoolcalender table by schoolcalendarid wise
      *
      @return  int by which result can be printed on the screen
	 */
    public int modify(SchoolCalenderBean schoolCalenderBean) throws Exception
    {
    	PreparedStatement settingsprepared  = null;

    	
    	int result=0;
		PreparedStatement schoolcalendarprepared = null;

    	try
    	{	log.info("to update school calender from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
    		schoolCalenderBean.getSchoolcalendarid();
    		schoolCalenderBean.getEventdate();
    		schoolCalenderBean.getEventdescription();
    		
   		    studentcalendarconnection = ConnectionManager.getKycConnection();
			String query="update schoolcalendar set eventdate=?, eventdescription=?,ipaddress=? ,dateofcreation=?,holidaystatus=? where schoolcalendarid=? ";
			schoolcalendarprepared = studentcalendarconnection.prepareStatement(query);
			String dateofff=date_object.getMySQLFormat(schoolCalenderBean.getEventdate())+"";
			schoolcalendarprepared.setString(1,dateofff);
			schoolcalendarprepared.setString(2,schoolCalenderBean.getEventdescription());
			schoolcalendarprepared.setString(3,schoolCalenderBean.getIpaddress());
			schoolcalendarprepared.setString(4,DateTime.showTime("MySqlWithTime"));
			schoolcalendarprepared.setString(5,schoolCalenderBean.getholiday_status());
			schoolcalendarprepared.setString(6,schoolCalenderBean.getSchoolcalendarid());

			result = schoolcalendarprepared.executeUpdate();
		
    	}
    	catch(Exception exception) { 
			
			log.error(exception);
			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(studentcalendarconnection!=null)
				studentcalendarconnection.close();
			
		}
    	return result;
    }
    /**
	  * This method is accessed from kycportal/jsp/SchoolCalender/calendaractivity.jsp
	  * change SchoolCalender status           - prasanth
	  * @param ipaddress that can be used to update all details to  schoolcalender table by schoolcalendarid wise 
	  * 
      @param calendarstatus that can be used to update all details to  schoolcalender table by schoolcalendarid wise
      *
      @param DateTime.showTime("MySqlWithTime") that can be used to update all details to  schoolcalender table by schoolcalendarid wise
      *
      @return  int by which result can be printed on the screen
	 */
    public int activity(SchoolCalenderBean schoolCalenderBean) throws Exception
    {
    	PreparedStatement settingsprepared  = null;

    	
    	int result=0;
		PreparedStatement schoolcalendarprepared = null;

    	try
    	{
    		log.info("to change school calender status from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
   		    studentcalendarconnection = ConnectionManager.getKycConnection();
			String query="update schoolcalendar set ipaddress=?,calendarstatus=? ,dateofcreation=? where schoolcalendarid=? ";
			schoolcalendarprepared = studentcalendarconnection.prepareStatement(query);
			schoolcalendarprepared.setString(1,schoolCalenderBean.getIpaddress());
			schoolcalendarprepared.setString(2,schoolCalenderBean.getCalendarstatus());
			schoolcalendarprepared.setString(3,DateTime.showTime("MySqlWithTime"));

			schoolcalendarprepared.setString(4,schoolCalenderBean.getSchoolcalendarid());

			result = schoolcalendarprepared.executeUpdate();
		
    	}
    	catch(Exception exception) { 
			
			log.error(exception);
			
		}
    	finally
		{
			if(schoolcalendarprepared != null)
				schoolcalendarprepared.close();
			
			if(studentcalendarconnection!=null)
				studentcalendarconnection.close();
			
			
		}
    	return result;
    }
    public ArrayList toGetDayfordatevice(String attendancedate) throws Exception
    {
		ArrayList list=null;
		try
		{	

			log.info("invoking insertStandard for Stanard Insertion from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			select_query="select eventdescription,DATE_FORMAT(eventdate, '%d-%b-%Y') as newdates from schoolcalendar where  calendarstatus='A' and eventdate='"+attendancedate+"'";
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
    /**
	   * This method is accessed from kycportal/jsp/SchoolCalender/CalenderView.jsp
	   * to get total no days per month SchoolCalender status           - prasanth
	   @param monthPick that can be used tototal no days per month by month wise 
	   * 
       @return  String by which result can be printed on the screen
	 */
    public String toGetAllDates(String monthPick) throws Exception{
		String datee ="";
		try {
			log.info("to get total no days per month from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			String monthPickarray []= monthPick.split("-");
			String qry = "SELECT DAYOFMONTH(LAST_DAY('"+monthPickarray[1]+"-"+monthPickarray[0]+"-01'));";
			datee = common_data_object.getString(qry);
		} catch(Exception de){
			log.error(de);

		}
		return datee;
		}
    /**
	  * This method is accessed from kycportal/jsp/SchoolCalender/CalenderView.jsp
	  * to get calender details between start date and end date       - prasanth
	  @param finalsdate that can be used to get calender details between start date and end date by finalsdate,finaledate wise 
	  *
      @param finaledate that can be used to get calender details between start date and end date by finalsdate,finaledate wise 
      *
      @return  ArrayList by which result can be printed on the screen
	 */
    public ArrayList getCalenderDetails(String finalsdate,String finaledate,String instituteid) {
		ArrayList arraylist = null;

		try {   
			log.info("to get calender details between start date and end date from com.iGrandee.SchoolCalender.SchoolCalenderEntry");
			select_query = "SELECT a.holidaystatus,a.schoolcalendarid,a.eventdate,DATE_FORMAT(a.eventdate, '%d-%b-%Y') as newdates,DAYNAME(a.eventdate) as dayname ,a.eventdescription,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates1 FROM schoolcalendar a,yearofsession b  where a.sessionid=b.sessionid and b.instituteid='"+instituteid+"' and b.sessionstatus='A' and  a.calendarstatus='A' and a.eventdate between '"+finalsdate+"'  and '"+finaledate+"'";

			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist; 
	}
   

    DateTime date_object;
    Connection studentcalendarconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}