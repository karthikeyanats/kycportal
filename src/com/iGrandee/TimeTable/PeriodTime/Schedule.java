package com.iGrandee.TimeTable.PeriodTime;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;


public class Schedule {

	static Logger log = Logger.getLogger(Schedule.class);

 public Schedule() {
	 
     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
 }
  

 /*
   * This method is accessed from kycportal/jsp/TImeTable/Schedule.jsp
  */
 public ArrayList loadStaffForSection(String sectionid)
 {
	 	log.info("invoking loadStaffForSection from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct a.staffid,concat(c.firstname,' ',c.lastname)as name from staffmaster a join login b on a.userid=b.userid and a.staffstatus='A' and b.loginstatus='A' join personmaster c on b.personid=c.personid and c.status='A' join subjectallotment d on d.sectionpublishid='"+sectionid+"' and d.staffid=a.staffid and subjectallotmentstatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
 }
 
 
 /*
  * This method is accessed from kycportal/jsp/kycpanel/HomePage.jsp
 */
public ArrayList loadStaffSchedule(String userid,String instituteid,String sessionid)
{
 	log.info("invoking loadStaffSchedule from com.iGrandee.TimeTable.PeriodTime.Schedule");
	
		ArrayList periodsList = null;
		try
		{
			//select_query  	= "select timetableid,dayname,subjectname,sectionname,standardname,d.staffid, d.subjectallotmentid,d.subjectallotmentid,LEFT(subjectname,7)as shortsubject, LEFT(sectionname,7)as shortsection,LEFT(standardname,7)as shortstandard, b.dayid,a.periodid from timetableperoid_tb a join scheduleddays b on a.instituteid='"+instituteid+"' and a.status='A' and b.daystatus='A' join periodnames l on a.periodnameid=l.periodnameid and l.periodnamestatus='A' join staffmaster g on g.staffstatus='A' and g.userid='"+userid+"' join subjectallotment d on g.staffid=d.staffid and d.subjectallotmentstatus='A' join timetable c on c.dayid=b.dayid and c.periodid=a.periodid and c.timetablestatus='A' and d.subjectallotmentid=c.subjectallotmentid join subjectschedule e on d.subjectscheduleid=e.subjectscheduleid and e.status='A' join subject f on e.subjectid=f.subjectid and f.subjectstatus='A' join sectionschedule h on d.sectionpublishid=h.sectionscheduleid and h.sectionschedulestatus='A' join section i on h.sectionid=i.sectionid and i.status='A' join standardschedule j on h.standardscheduleid=j.standardscheduleid and stdschedulestatus='A' and j.sessionid='"+sessionid+"' join standard k on j.standardid=k.standardid and k.standardstatus='A' order by b.dayid,l.periodnameid asc";
			select_query  	= "select timetableid,dayname,subjectname,sectionname,case when m.groupname is null then standardname else concat(standardname,' - ',groupname) end as standardname,d.staffid, d.subjectallotmentid,d.subjectallotmentid,LEFT(subjectname,7)as shortsubject, LEFT(sectionname,7)as shortsection,LEFT(standardname,7)as shortstandard, b.dayid,a.periodid from timetableperoid_tb a join scheduleddays b on a.instituteid='"+instituteid+"' and a.status='A' and b.daystatus='A' join periodnames l on a.periodnameid=l.periodnameid and l.periodnamestatus='A' join staffmaster g on g.staffstatus='A' and g.userid='"+userid+"' join subjectallotment d on g.staffid=d.staffid and d.subjectallotmentstatus='A' join timetable c on c.dayid=b.dayid and c.periodid=a.periodid and c.timetablestatus='A' and d.subjectallotmentid=c.subjectallotmentid join subjectschedule e on d.subjectscheduleid=e.subjectscheduleid and e.status='A' join subject f on e.subjectid=f.subjectid and f.subjectstatus='A' join sectionschedule h on d.sectionpublishid=h.sectionscheduleid and h.sectionschedulestatus='A' join section i on h.sectionid=i.sectionid and i.status='A' join standardschedule j on h.standardscheduleid=j.standardscheduleid and stdschedulestatus='A' and j.sessionid='"+sessionid+"' join standard k on j.standardid=k.standardid and k.standardstatus='A' left join standardgroup m on m.groupid=j.groupid and m.groupstatus='A' order by b.dayid,l.ordervalue,l.periodnameid asc";
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


	/*
	 * This method is accessed from kycportal/jsp/Student/StudentHome.jsp
	*/
	public ArrayList loadStudentSchedule(String sectionscheduleid,String instituteid)
	{
	 	log.info("invoking loadStudentSchedule from com.iGrandee.TimeTable.PeriodTime.Schedule");
	
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.dayid,a.periodid,timetableid,dayname,subjectname,d.subjectallotmentid,d.subjectallotmentid,LEFT(subjectname,7)as shortsubject,LEFT(concat(m.firstname,' ',m.lastname),7)as shortstaff ,concat(m.firstname,' ',m.lastname) as staffname from timetableperoid_tb a join scheduleddays b on a.instituteid='"+instituteid+"' and a.status='A' and b.daystatus='A' join periodnames o on a.periodnameid=o.periodnameid and o.periodnamestatus='A' left outer join timetable c on c.dayid=b.dayid and c.periodid=a.periodid and c.timetablestatus='A' and c.subjectallotmentid in(select subjectallotmentid from subjectallotment where sectionpublishid='"+sectionscheduleid+"' and subjectallotmentstatus='A') left outer join subjectallotment d on d.sectionpublishid='"+sectionscheduleid+"' and d.subjectallotmentstatus='A' and d.subjectallotmentid=c.subjectallotmentid left outer join staffmaster g on g.staffstatus='A' and g.staffid=d.staffid left outer join login l on g.userid=l.userid and l.loginstatus='A' left outer join personmaster m on l.personid=m.personid and m.status='A' left outer join subjectschedule e on d.subjectscheduleid=e.subjectscheduleid and e.status='A' left outer join subject f on e.subjectid=f.subjectid and f.subjectstatus='A'  order by b.dayid,o.ordervalue,o.periodnameid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
	}

/*
  * This method is accessed from kycportal/jsp/TImeTable/Schedule.jsp
 */
public ArrayList loadPeriods(String instituteid)
{
 	log.info("invoking loadPeriods(String instituteid) from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.periodid,b.periodname,a.periodtime from timetableperoid_tb a,periodnames b where a.instituteid='"+instituteid+"' and a.periodnameid=b.periodnameid and b.periodnamestatus='A' and a.status='A' order by b.ordervalue,b.periodnameid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/Schedule.jsp
*/
public ArrayList loadPeriods(String instituteid,String userid)
{
	log.info("invoking loadPeriods(String instituteid,String userid) from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.periodid,b.periodname,a.periodtime from timetableperoid_tb a,periodnames b where a.instituteid='"+instituteid+"' and a.periodnameid=b.periodnameid and b.periodnamestatus='A' and a.status='A' and createdby='"+userid+"' order by b.ordervalue,b.periodnameid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/Student/StudentHome.jsp
*/
public ArrayList checkStandardTopperWeeker(String standardscheduleid,String status,String number)
{
	 	log.info("invoking checkStandardTopperWeeker from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select concat(firstname,' ',lastname) as studentname,b.rollno, sum(marktaken) as totalmark,  b.studentallocationid,examname from sectionschedule a join studentallocation b on  a.standardscheduleid='"+standardscheduleid+"' and a.sectionscheduleid=b.sectionscheduleid  and a.sectionschedulestatus='A' and b.studentallocationstatus='A'  join candidateregister c on b.candidateregisterid=c.candidateregisterid  and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid  and d.status='A' join examname h on h.examnameid=(select max(b.examnameid)  from standardschedule a, examname b, examallotment c,examschedule d where a.standardscheduleid='"+standardscheduleid+"' and a.sessionid=b.sessionid and b.examnamestatus='A' and b.examnameid=c.examnameid and c.examallotmentstatus='A' and c.examallotmentid=d.examallotmentid and d.examschedulestatus='A' and d.markpublishstatus='A') and h.examnamestatus='A'  join examallotment e on e.examnameid=h.examnameid  and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A'  join examschedule f on e.examallotmentid=f.examallotmentid and f.examschedulestatus='A'  left outer join exammark g  on f.examscheduleid=g.examscheduleid and g.markstatus='A'  and b.studentallocationid=g.studentallocationid group by b.studentallocationid order by totalmark "+status+" limit 0,"+number; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
	    	 log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/kycpanel/TimeTablePage.jsp
*/
public ArrayList loadTotalPeriods(String instituteid)
{
	log.info("invoking loadTotalPeriods from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.dayid,b.dayname,c.periodname,a.periodid from timetableperoid_tb a join periodnames c on a.periodnameid=c.periodnameid and c.periodnamestatus='A' join scheduleddays b on a.instituteid='"+instituteid+"' and a.status='A' and b.daystatus='A' order by b.dayid,c.ordervalue,c.periodnameid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/TImeTable/Schedule.jsp
*/
public ArrayList loadScheduless(String instituteid,String sectionpublishid)
{
 	log.info("invoking loadScheduless from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.periodid,b.dayid,b.dayname,c.timetableid,f.subjectname, d.subjectallotmentid, d.sectionpublishid, concat(i.firstname,' ',i.lastname) as staffname, LEFT(concat(i.firstname,' ',i.lastname),7) as shortstaff, LEFT(f.subjectname,7)as shortsubject,g.staffid from timetableperoid_tb a join scheduleddays b on a.instituteid='"+instituteid+"' and a.status='A' and b.daystatus='A' join periodnames j on a.periodnameid=j.periodnameid and j.periodnamestatus='A'  left outer join timetable c on c.dayid=b.dayid and c.periodid=a.periodid and c.timetablestatus='A' and c.subjectallotmentid in (select subjectallotmentid from subjectallotment where subjectallotmentstatus='A' and sectionpublishid='"+sectionpublishid+"') left outer join subjectallotment d on d.subjectallotmentid=c.subjectallotmentid and d.subjectallotmentstatus='A' and d.sectionpublishid='"+sectionpublishid+"' left outer join subjectschedule e on d.subjectscheduleid=e.subjectscheduleid and e.status='A' left outer join subject f on e.subjectid=f.subjectid and f.subjectstatus='A' left outer join staffmaster g on g.staffid=d.staffid and g.staffstatus='A' left outer join login h on g.userid=h.userid and h.loginstatus='A' left outer join personmaster i on h.personid=i.personid and i.status='A' order by b.dayid,j.ordervalue,j.periodnameid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/Schedule.jsp
*/
public ArrayList loadSchedules(String instituteid,String sectionpublishid,String userid)
{
 	log.info("invoking loadSchedules(String instituteid,String sectionpublishid,String userid) from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.periodid,b.dayid,b.dayname,c.timetableid,f.subjectname, d.subjectallotmentid, d.sectionpublishid, concat(i.firstname,' ',i.lastname) as staffname, LEFT(concat(i.firstname,' ',i.lastname),7) as shortstaff, LEFT(f.subjectname,7)as shortsubject,g.staffid from timetableperoid_tb a join scheduleddays b on a.instituteid='"+instituteid+"' and a.status='A' and b.daystatus='A' join periodnames j on a.periodnameid=j.periodnameid and j.periodnamestatus='A' and j.createdby='"+userid+"'  left outer join timetable c on c.dayid=b.dayid and c.periodid=a.periodid and c.timetablestatus='A' and c.subjectallotmentid in (select subjectallotmentid from subjectallotment where subjectallotmentstatus='A' and sectionpublishid='"+sectionpublishid+"') left outer join subjectallotment d on d.subjectallotmentid=c.subjectallotmentid and d.subjectallotmentstatus='A' and d.sectionpublishid='"+sectionpublishid+"' left outer join subjectschedule e on d.subjectscheduleid=e.subjectscheduleid and e.status='A' left outer join subject f on e.subjectid=f.subjectid and f.subjectstatus='A' left outer join staffmaster g on g.staffid=d.staffid and g.staffstatus='A' left outer join login h on g.userid=h.userid and h.loginstatus='A' left outer join personmaster i on h.personid=i.personid and i.status='A' order by b.dayid,j.ordervalue,j.periodnameid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
			//System.out.println("select_query ===>"+select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/TImeTable/ScheduleAjax.jsp
*/
public ArrayList loadSubjects(String sectionid,String staffid)
{
 	log.info("invoking loadSubjects from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select d.subjectallotmentid,f.subjectname from subjectallotment d join subjectschedule e on d.sectionpublishid='"+sectionid+"' and d.staffid='"+staffid+"' and d.subjectscheduleid=e.subjectscheduleid and  d.subjectallotmentstatus='A' and e.status='A' join  subject f on e.subjectid=f.subjectid and f.subjectstatus='A' order by f.subjectname asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/TImeTable/ScheduleAjax.jsp
*/
public ArrayList checkRemaining(String subjectallotmentid,String staffid)
{
 	log.info("invoking checkRemaining(String subjectallotmentid,String staffid) from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select case when a.allottedhours is null or a.allottedhours = '' then 'Not Yet Allotted' else a.allottedhours end as allottedhours,count(timetableid) as totalscheduled from subjectallotment a join staffmaster b on a.subjectallotmentid='"+subjectallotmentid+"' and a.staffid='"+staffid+"' and a.staffid=b.staffid and b.staffstatus='A' and a.subjectallotmentstatus='A' left outer join timetable c on a.subjectallotmentid=c.subjectallotmentid and c.timetablestatus='A' group by a.subjectallotmentid"; 
			periodsList 	= common_data_object.getListMap(select_query);
			//System.out.println("Remaining hours===>"+select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/ScheduleAjax.jsp
*/
public String checkRemainingTotalStaff(String sessionid,String staffid)
{
 	log.info("invoking checkRemainingTotalStaff(String sessionid,String staffid) from com.iGrandee.TimeTable.PeriodTime.Schedule");

		String totalhours = null;
		try
		{
			select_query  	= "select noofhours from workallotment where staffid='"+staffid+"' and sessionid='"+sessionid+"' and workallotmenstatus='A'"; 
			totalhours 	= common_data_object.getString(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return totalhours;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/ScheduleAjax.jsp
*/
public String checkRemainingScheduleStaff(String sessionid,String staffid)
{
 	log.info("invoking checkRemainingScheduleStaff(String sessionid,String staffid) from com.iGrandee.TimeTable.PeriodTime.Schedule");

		String totalhours = null;
		try
		{
			select_query  	= "select count(timetableid) from standardschedule a, subjectschedule b,subjectallotment c,timetable d where a.sessionid='"+sessionid+"' and a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A' and b.subjectscheduleid=c.subjectscheduleid and b.status='A' and c.subjectallotmentstatus='A' and c.staffid='"+staffid+"' and d.subjectallotmentid=c.subjectallotmentid and d.timetablestatus='A'"; 
			totalhours 		= common_data_object.getString(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return totalhours;
}



/*
 * This method is accessed from kycportal/jsp/TImeTable/ScheduleAjax.jsp
*/
public ArrayList checkScheduledStatus(String dayid,String sessionid,String periodid,String staffid)
{
 	log.info("invoking checkScheduledStatus from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT periodname,dayname,subjectname,standardname,sectionname FROM timetable a join subjectallotment b on a.periodid='"+periodid+"' and a.dayid='"+dayid+"' and a.timetablestatus='A' and a.subjectallotmentid=b.subjectallotmentid and b.staffid='"+staffid+"' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on  d.standardscheduleid=c.standardscheduleid and sessionid='"+sessionid+"' and d.stdschedulestatus='A' join timetableperoid_tb f on a.periodid=f.periodid and f.status='A' join periodnames m on f.periodnameid=m.periodnameid and m.periodnamestatus='A' join scheduleddays g on a.dayid=g.dayid join subject h on c.subjectid=h.subjectid  and h.subjectstatus='A' join standard j on d.standardid=j.standardid and j.standardstatus='A' join sectionschedule k on b.sectionpublishid=k.sectionscheduleid and k.sectionschedulestatus='A' join section l on l.sectionid=k.sectionid and l.status='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}



/*
 * This method is accessed from kycportal/jsp/TImeTable/ReplaceView.jsp
*/
public ArrayList loadPeriodName(String timetableid)
{
 	log.info("invoking loadPeriodName from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select dayname,periodname,periodtime from timetable a join timetableperoid_tb b on a.timetableid='"+timetableid+"' and a.periodid=b.periodid and a.timetablestatus='A' and b.status='A' join scheduleddays c on a.dayid=c.dayid and c.daystatus='A'  join periodnames d on d.periodnameid=b.periodnameid and d.periodnamestatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/TImeTable/ReplaceView.jsp
*/
public ArrayList loadLogDetails(String timetableid)
{
 	log.info("invoking loadLogDetails from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT d.subjectname,a.logdetails, date_format(a.dateofcreation,'%d-%b-%Y %h:%i %p') as dateofcreation,h.departmentname,concat(g.firstname,' ',g.lastname) as name FROM timetablelog a join subjectallotment b on a.subjectallotmentid=b.subjectallotmentid and a.timetableid='"+timetableid+"' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid join subject d on c.subjectid=d.subjectid join staffmaster e on b.staffid=e.staffid join login f on f.userid=e.userid join personmaster g on f.personid=g.personid join department h on e.departmentid=h.departmentid"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/TImeTable/ReplaceView.jsp
*/
public ArrayList loadStaffReplaceDetails(String timetableid,String sessionid,String staffid,String sectionid)
{
 	log.info("invoking loadStaffReplaceDetails from com.iGrandee.TimeTable.PeriodTime.Schedule");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct a.staffid,concat(c.firstname,' ',c.lastname)as name from staffmaster a join login b on a.userid=b.userid and a.staffstatus='A' and b.loginstatus='A' join staffcategory hh on a.staffcategoryid=hh.staffcategoryid and hh.staffcategorystatus='A' and (hh.categoryname='Teaching' or  hh.categoryname='Headmaster')join personmaster c on b.personid=c.personid and c.status='A' join subjectallotment d on d.sectionpublishid='"+sectionid+"' and d.staffid=a.staffid and subjectallotmentstatus='A' and d.staffid <> '"+staffid+"' and d.staffid not in (SELECT b.staffid FROM timetable a join subjectallotment b on a.timetableid='"+timetableid+"' and a.timetablestatus='A' and a.subjectallotmentid=b.subjectallotmentid and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on  d.standardscheduleid=c.standardscheduleid and sessionid='"+sessionid+"' and d.stdschedulestatus='A' join timetableperoid_tb e on a.periodid=e.periodid and e.status='A' join scheduleddays f on f.dayid=a.dayid and f.daystatus='A')"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}





	public int scheduleSection(String schedules,String createdby,String ipaddress)throws SQLException,Exception {
		
	 	log.info("invoking scheduleSection from com.iGrandee.TimeTable.PeriodTime.Schedule");

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		int[]	result					= null;
		String[] temp					= null;
		String curTime					= DateTime.showTime("MySqlWithTime");

		try {
			
			temp			= schedules.split(",");
			
			workstate		= connection.prepareStatement("insert into timetable(timetableid, dayid, subjectallotmentid, periodid, createdby, ipaddress, dateofcreation, timetablestatus)values(?,?,?,?,?,?,?,?)");
		
			
			if(temp != null &&  temp.length>0)
				for(int x=0;x<temp.length;x+=3){
										
					workstate.setLong(1, IdGenerator.getTimeTableId());
					workstate.setString(2,temp[x]);
					workstate.setString(3,temp[x+2]);
					workstate.setString(4,temp[x+1]);
					workstate.setString(5,createdby);
					workstate.setString(7,curTime);
					workstate.setString(6,ipaddress);
					workstate.setString(8,"A");
					workstate.addBatch();
				
				}
				
			result		= 	workstate.executeBatch();
			
			if(result != null)
			for(int y=0;y<result.length;y++)
				return_value += result[y];
			
		connection.commit();

	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
	}
	finally {
			
		if(workstate != null)
			workstate.close();
		
		ConnectionManager.closeConnection(connection);
	}
	return return_value;
}
	
public int 	checkScheduledStatusandSchedule(String dayid,String sessionid,String periodid,String staffid,String subjectallotment,String userid,String sectionid,String ipaddress) throws SQLException,Exception{
	
 	log.info("invoking checkScheduledStatusandSchedule from com.iGrandee.TimeTable.PeriodTime.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	PreparedStatement workstate 	= null;
	PreparedStatement checkstate 	= null;
	ResultSet checkrs 				= null;
	PreparedStatement checkstate3 	= null;
	ResultSet checkrs3 				= null;
	
	PreparedStatement checkstate1 	= null;
	ResultSet checkrs1 				= null;
	PreparedStatement checkstate2 	= null;
	ResultSet checkrs2 				= null;
	PreparedStatement worklog	 	= null;
	PreparedStatement workupdate 	= null;
	
	long timetableid				= 0l;
	String logdetails				= "";
	return_value					= 0;
	String curTime					= DateTime.showTime("MySqlWithTime");
	
	try {

		
		/*checkstate3		= connection.prepareStatement("select case when a.credithours is null then '0' else a.credithours end as credithours, count(distinct c.timetableid) as total from subjectschedule a join subjectallotment b on a.subjectscheduleid=b.subjectscheduleid and b.subjectallotmentstatus='A' and b.subjectallotmentid=? left outer join timetable c on b.subjectallotmentid=c.subjectallotmentid and c.timetablestatus='A' group by b.subjectallotmentid"); 
		checkstate3.setString(1, subjectallotment);
		checkrs3			= checkstate3.executeQuery();
		
		if(checkrs3.next()){
			
			if(checkrs3.getInt(1)<= checkrs3.getInt(2)){
				return_value = 4;
			}
		}*/				
		
		
		//if(return_value  == 0){
		
			checkstate		= connection.prepareStatement("SELECT b.subjectallotmentid FROM timetable a join subjectallotment b on a.periodid=? and a.dayid=? and a.timetablestatus='A' and a.subjectallotmentid=b.subjectallotmentid and b.staffid=? and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on  d.standardscheduleid=c.standardscheduleid and sessionid=? and d.stdschedulestatus='A'"); 
			checkstate.setString(1, periodid);
			checkstate.setString(2,dayid);
			checkstate.setString(3,staffid);
			checkstate.setString(4,sessionid);
			
			checkrs			= checkstate.executeQuery();
			
			if(checkrs.next()){
				
				return_value = 2;
			}		
		
		
			if(return_value  == 0){
				
				checkstate1		= connection.prepareStatement("SELECT b.allottedhours,count(timetableid) as schedule FROM timetable a join subjectallotment b on a.subjectallotmentid=? and a.subjectallotmentid=b.subjectallotmentid and a.timetablestatus='A' and b.subjectallotmentstatus='A' group by b.subjectallotmentid"); 
				checkstate1.setString(1,subjectallotment);
				checkrs1			= checkstate1.executeQuery();
				
				if(checkrs1.next()){
					if(checkrs1.getInt(1)> checkrs1.getInt(2)){
						return_value = 0;
					}
					else
						return_value = 3;
				}
	
				
				if(return_value  == 0){
					
					checkstate2		= connection.prepareStatement("select a.timetableid from timetable a join subjectallotment b on a.dayid=? and a.periodid=? and a.subjectallotmentid=b.subjectallotmentid and b.sectionpublishid=?"); 
					checkstate2.setString(1,dayid);
					checkstate2.setString(2,periodid);
					checkstate2.setString(3,sectionid);
					
					checkrs2		= checkstate2.executeQuery();
					
					if(checkrs2.next()){
						
						workstate		= connection.prepareStatement("update timetable set subjectallotmentid=?,timetablestatus=? where timetableid=?");
						timetableid		= checkrs2.getLong(1);
						workstate.setLong(3, timetableid);
						workstate.setString(2,"A");
						workstate.setString(1,subjectallotment);
						return_value 	= workstate.executeUpdate();
						logdetails		= "Updated";
	
					}
					else{
	
	
						workstate		= connection.prepareStatement("insert into timetable(timetableid, dayid, subjectallotmentid, periodid, createdby, ipaddress, dateofcreation, timetablestatus)values(?,?,?,?,?,?,?,?)");
						
						timetableid		= IdGenerator.getTimeTableId();
						workstate.setLong(1, timetableid);
						workstate.setString(2,dayid);
						workstate.setString(3,subjectallotment);
						workstate.setString(4,periodid);
						workstate.setString(5,userid);
						workstate.setString(7,curTime);
						workstate.setString(6,ipaddress);
						workstate.setString(8,"A");
						return_value = workstate.executeUpdate();
						logdetails		= "Created";
						
					}
					
					workupdate			= connection.prepareStatement("update timetablelog set status=? where timetableid=?");
					workupdate.setString(1, "D");
					workupdate.setLong(2,timetableid);
					return_value = workupdate.executeUpdate();
					
					
					worklog				= connection.prepareStatement("insert into timetablelog(timetablelogid, timetableid, subjectallotmentid, logdetails, status, createdby, dateofcreation)values(?,?,?,?,?,?,?)");
					
					worklog.setLong(1, IdGenerator.getTimeTableLogId());
					worklog.setLong(2,timetableid);
					worklog.setString(3,subjectallotment);
					worklog.setString(4,logdetails);
					worklog.setString(5,"A");
					worklog.setString(6,userid);
					worklog.setString(7,curTime);
					return_value = worklog.executeUpdate();
					
				}
				
			}
		//}
		
		connection.commit();

}
catch(SQLException sqlexception) { 
	
	log.error(sqlexception);
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
}
finally {
		
	if(workstate != null)
		workstate.close();
	
	if(checkrs != null)
		checkrs.close();
	
	if(checkstate != null)
		checkstate.close();

	if(checkrs1 != null)
		checkrs1.close();

	
	if(checkstate1 != null)
		checkstate1.close();

	if(checkrs2 != null)
		checkrs2.close();

	
	if(checkstate2 != null)
		checkstate2.close();

	if(workupdate != null)
		workupdate.close();
	
	if(worklog != null)
		worklog.close();

	
	
	
	ConnectionManager.closeConnection(connection);
}
return return_value;

}



	



public int scheduleUpdate(String schedules,String userid)throws SQLException,Exception {
	
 	log.info("invoking scheduleUpdate from com.iGrandee.TimeTable.PeriodTime.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	PreparedStatement workstate 	= null;
	PreparedStatement worklog 		= null;
	PreparedStatement workupdate 	= null;
	String curTime					= DateTime.showTime("MySqlWithTime");
	int[]	result					= null;
	String[] temp					= null;

	try {
		
		temp				= schedules.split(",");
		workstate			= connection.prepareStatement("update timetable set timetablestatus=? where timetableid=?");
		worklog				= connection.prepareStatement("insert into timetablelog(timetablelogid, timetableid, subjectallotmentid, logdetails, status, createdby, dateofcreation)values(?,?,?,?,?,?,?)");
		workupdate			= connection.prepareStatement("update timetablelog set status=? where timetableid=?");
		
		
		if(temp != null &&  temp.length>0)
			for(int x=0;x<temp.length;x=x+2){
								
				workstate.setString(1, "D");
				workstate.setString(2,temp[x]);
				workstate.addBatch();
				
				workupdate.setString(1, "D");
				workupdate.setString(2,temp[x]);
				workupdate.addBatch();
				
				worklog.setLong(1, IdGenerator.getTimeTableLogId());
				worklog.setString(2,temp[x]);
				worklog.setString(3,temp[x+1]);
				worklog.setString(4,"Deleted");
				worklog.setString(5,"A");
				worklog.setString(6,userid);
				worklog.setString(7,curTime);
				worklog.addBatch();
				
			}
			
		result		= 	workstate.executeBatch();
		
		if(result != null)
		for(int y=0;y<result.length;y++)
			return_value += result[y];
		
		result		= 	workupdate.executeBatch();
		
		if(result != null)
		for(int y=0;y<result.length;y++)
			return_value += result[y];
		
		result		= 	worklog.executeBatch();
		
		if(result != null)
		for(int y=0;y<result.length;y++)
			return_value += result[y];
		
	connection.commit();

}
catch(SQLException sqlexception) { 
	
	if(connection != null)
		connection.rollback();
	return_value = 0;
	
	log.error(sqlexception);
}
finally {
		
	if(workstate != null)
		workstate.close();
	
	ConnectionManager.closeConnection(connection);
}
return return_value;
}


public int replaceSubject(String subjectallotmentid,String userid,String timetableid)throws SQLException,Exception {
	
 	log.info("invoking replaceSubject from com.iGrandee.TimeTable.PeriodTime.Schedule");

	connection 						= ConnectionManager.getKycConnection();
	connection.setAutoCommit(false);
	PreparedStatement workstate 	= null;
	PreparedStatement worklog 		= null;
	PreparedStatement workupdate 	= null;
	String curTime					= DateTime.showTime("MySqlWithTime");

	try {
		
		workstate			= connection.prepareStatement("update timetable set subjectallotmentid=?,timetablestatus=? where timetableid=?");
		worklog				= connection.prepareStatement("insert into timetablelog(timetablelogid, timetableid, subjectallotmentid, logdetails, status, createdby, dateofcreation)values(?,?,?,?,?,?,?)");
		workupdate			= connection.prepareStatement("update timetablelog set status=? where timetableid=?");
		
		
								
			workstate.setString(1, subjectallotmentid);
			workstate.setString(2,"A");
			workstate.setString(3,timetableid);
			return_value += 	workstate.executeUpdate();
			
			workupdate.setString(1, "D");
			workupdate.setString(2,timetableid);
			return_value += 	workupdate.executeUpdate();
			
			worklog.setLong(1, IdGenerator.getTimeTableLogId());
			worklog.setString(2,timetableid);
			worklog.setString(3,subjectallotmentid);
			worklog.setString(4,"Replaced");
			worklog.setString(5,"A");
			worklog.setString(6,userid);
			worklog.setString(7,curTime);
			return_value +=		worklog.executeUpdate();
			
		
		
	connection.commit();

}
catch(SQLException sqlexception) { 
	
	if(connection != null)
		connection.rollback();
	return_value = 0;
	log.error(sqlexception);
}
finally {
		
	if(workstate != null)
		workstate.close();
	
	ConnectionManager.closeConnection(connection);
}
return return_value;
}







 
 
  

 CommonDataAccess common_data_object; 
 String insert_query;
 String select_query;
 int 	return_value;
 int[] returnvalue;
 Connection connection;

}
