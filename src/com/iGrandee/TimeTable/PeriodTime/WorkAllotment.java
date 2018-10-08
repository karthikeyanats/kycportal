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
import com.iGrandee.Schedule.Schedule;


public class WorkAllotment {

	static Logger log = Logger.getLogger(WorkAllotment.class);

 public WorkAllotment() {
	 
     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
 }
  

 /*
   * This method is accessed from kycportal/jsp/TImeTable/WorkAllotment.jsp,kycportal/jsp/TImeTable/SubjectAllotment.jsp
  */
 public ArrayList loadAcadamicYear(String instituteid)
 {
	 	log.info("invoking loadAcadamicYear from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT sessionid,sessionname FROM yearofsession where instituteid='"+instituteid+"' and sessionstatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
 }
 
 /*
  * This method is accessed from kycportal/jsp/TImeTable/WorkAllotment.jsp,kycportal/jsp/TImeTable/SubjectAllotment.jsp
 */
public ArrayList loadActiveDepartments(String instituteid)
{
 	log.info("invoking loadActiveDepartments from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT departmentid,departmentname FROM department where instituteid='"+instituteid+"' and status='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/WorkAllotment.jsp,kycportal/jsp/TImeTable/SubjectAllotment.jsp
*/
public ArrayList loadActiveRoles(String instituteid)
{
 	log.info("invoking loadActiveRoles from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT roleid,rolename FROM role where instituteid='"+instituteid+"' and status='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}
/*
 * This method is accessed from
 * kycportal/jsp/TImeTable/WorkAllotment.jsp,kycportal/jsp/TImeTable/SubjectAllotment.jsp
 * created by maruthu
 */
public ArrayList loadActiveRolesnew(String instituteid, String categoryname) {
	log
			.info("invoking loadActiveRoles from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

	ArrayList periodsList = null;
	try {
		select_query = "SELECT * FROM role r where instituteid='"
				+ instituteid
				+ "' and roleid in (SELECT distinct roleid FROM staffcategory a,staffmaster b where a.instituteid='"
				+ instituteid
				+ "' and a.categoryname='"
				+ categoryname
				+ "' and a.staffcategorystatus='A' and b.staffcategoryid=a.staffcategoryid and staffstatus='A')  and status='A'";
		
		System.out.println(select_query);
		periodsList = common_data_object.getListMap(select_query);
	} catch (Exception exception) {

		log.error(exception);
	}
	return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/WorkAllotment.jsp
*/
public ArrayList loadDeptRoleStaffs(String sessionid,String deptid,String roleid)
{
 	log.info("invoking loadDeptRoleStaffs from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");
	ArrayList periodsList = null;
	try
	{
		select_query  	= "select a.staffid,concat(case when c.prefix is not null then c.prefix else '' end ,c.firstname,' ',c.lastname,case when c.qualification is not null then concat(' ',c.qualification) else '' end)as name,case when d.workallotmentid is null then 'Not Yet Allotted' else 'Already Allotted' end as status, case when d.noofhours is null then '0' else d.noofhours end as noofhours,(select count(d1.timetableid) from standardschedule a1,sectionschedule b1,subjectallotment c1, timetable d1 where a1.sessionid='"+sessionid+"' and a1.standardscheduleid=b1.standardscheduleid and c1.sectionpublishid=b1.sectionscheduleid and a.staffid=c1.staffid and c1.subjectallotmentid=d1.subjectallotmentid and c1.subjectallotmentstatus='A' and a1.stdschedulestatus='A' and d1.timetablestatus='A' group by a1.sessionid) as scheduledhours from staffmaster a join login b on a.userid=b.userid and a.departmentid='"+deptid+"' and a.roleid='"+roleid+"' and a.staffstatus='A' and b.loginstatus='A' join personmaster c on b.personid=c.personid and c.status='A' join staffcategory e on a.staffcategoryid=e.staffcategoryid and (categoryname='Teaching' or categoryname='Headmaster') left outer join workallotment d on a.staffid=d.staffid and d.sessionid='"+sessionid+"' and d.workallotmenstatus='A'"; 
		periodsList 	= common_data_object.getListMap(select_query);

	}
	catch(Exception exception) { 
		
		log.error(exception);
	}
	return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/TImeTable/SubjectAllotment.jsp
 * This method is accessed from kycportal/jsp/Reports/SubjectAllotment.jsp
 * modified by maruthu for displaying staff name with Prefix
*/
public ArrayList loadDeptRoleStaffsWork(String sessionid,String deptid,String roleid)
{
 	log.info("invoking loadDeptRoleStaffsWork from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select DATEDIFF(curdate(),a.dateofjoin) as experienceday,a.staffid,c.qualification, case when c.middlename='-' or c.middlename='' then concat(c.prefix,' ',c.firstname,' ',c.lastname) else concat(c.prefix,' ',c.firstname,' ',c.middlename,' ',c.lastname) end as  name, d.noofhours, sum(e.allottedhours) as allotted,b.userid from staffmaster a join login b on a.userid=b.userid and a.departmentid='"+deptid+"' and a.roleid='"+roleid+"' and a.staffstatus='A' and b.loginstatus='A' join personmaster c on b.personid=c.personid and c.status='A' join workallotment d on a.staffid=d.staffid and d.sessionid='"+sessionid+"' and d.workallotmenstatus='A' left outer join subjectallotment e on e.staffid=d.staffid and e.subjectallotmentstatus='A' and e.subjectscheduleid in  (select f.subjectscheduleid from subjectschedule f,standardschedule g where d.sessionid=g.sessionid and g.standardscheduleid=f.standardscheduleid and f.status='A' and g.stdschedulestatus='A') group by a.staffid order by a.staffid asc";
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/SubjectAllotment.jsp
*/
public ArrayList loadAllSubjects(String staffid,String sectionsceduleid)
{
 	log.info("invoking loadAllSubjects from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			//select_query  	= "select a.subjectscheduleid,b.subjectname,e.subjectypename, case when d.allottedhours is null then '0' else d.allottedhours end as allottedhours, case when d.subjectallotmentid is null then 'Not Allotted' else 'Allotted' end as status from subjectschedule a join subject b on a.subjectid=b.subjectid join sectionschedule c on a.standardscheduleid=c.standardscheduleid and c.sectionscheduleid='"+sectionsceduleid+"' and a.status='A' and c.sectionschedulestatus='A' join subjecttype e on b.subjecttypeid=e.subjecttypeid and e.subjecttypestatus='A' left outer join subjectallotment d on c.sectionscheduleid=d.sectionpublishid and d.staffid='"+staffid+"' and a.subjectscheduleid=d.subjectscheduleid and d.subjectallotmentstatus='A' order by d.subjectallotmentid"; 
			select_query  	= "select a.subjectscheduleid,b.subjectname,e.subjectypename, case when d.allottedhours is null then '0' else d.allottedhours end as allottedhours, case when d.subjectallotmentid is null then 'Not Allotted' else 'Allotted' end as status from subjectschedule a join subject b on a.subjectid=b.subjectid join sectionschedule c on a.standardscheduleid=c.standardscheduleid  and b.subjectstatus='A' and c.sectionscheduleid='"+sectionsceduleid+"' and a.status='A' and c.sectionschedulestatus='A' join subjecttype e on b.subjecttypeid=e.subjecttypeid and e.subjecttypestatus='A' left outer join subjectallotment d on c.sectionscheduleid=d.sectionpublishid and d.staffid='"+staffid+"' and a.subjectscheduleid=d.subjectscheduleid and d.subjectallotmentstatus='A' order by d.subjectallotmentid";
			log.info("-=-=-=-=-=-=-=-=--=-=-=-=-=-=-==-=-=-=--=-=-=-=-=-=-=--=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"+select_query);
			System.out.println("select_query"+select_query);
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/RemoveSubjects.jsp
*/
public ArrayList loadScheduledSubjects(String staffid,String sectionsceduleid)
{
 	log.info("invoking loadScheduledSubjects from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.subjectscheduleid,concat(b.subjectname,' - ',b.subjectcode) as subjectname,d.subjectallotmentid,d.allottedhours,e.subjectypename,(select count(timetableid) from timetable where d.subjectallotmentid=subjectallotmentid and timetablestatus='A' group by subjectallotmentid) as scheduledhours  from subjectschedule a join subject b on a.subjectid=b.subjectid join sectionschedule c on a.standardscheduleid=c.standardscheduleid and c.sectionscheduleid='"+sectionsceduleid+"' and a.status='A' and c.sectionschedulestatus='A' join subjecttype e on b.subjecttypeid=e.subjecttypeid and e.subjecttypestatus='A' join subjectallotment d on c.sectionscheduleid=d.sectionpublishid and d.staffid='"+staffid+"' and a.subjectscheduleid=d.subjectscheduleid and d.subjectallotmentstatus='A' order by d.subjectallotmentid"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/SubjectAllotment.jsp
*/
public ArrayList loadAllottedStaffsQualification(String sessionid,String deptid,String roleid)
{
 	log.info("invoking loadAllottedStaffsQualification from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.staffid,e.major from staffmaster a join login b on a.userid=b.userid and a.departmentid='"+deptid+"' and a.roleid='"+roleid+"' and a.staffstatus='A' and b.loginstatus='A' join workallotment d on a.staffid=d.staffid and d.sessionid='"+sessionid+"' and d.workallotmenstatus='A' join staffqualification e on b.userid=e.userid order by a.staffid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}


/*
 * This method is accessed from kycportal/jsp/TImeTable/SubjectAllotment.jsp
*/
public ArrayList loadAllottedStaffsExperience(String sessionid,String deptid,String roleid)
{
 	log.info("invoking loadAllottedStaffsExperience from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select a.staffid,e.role from staffmaster a join login b on a.userid=b.userid and a.departmentid='"+deptid+"' and a.roleid='"+roleid+"' and a.staffstatus='A' and b.loginstatus='A' join workallotment d on a.staffid=d.staffid and d.sessionid='"+sessionid+"' and d.workallotmenstatus='A' join userexperience e on b.userid=e.userid and uexperiencestatus='A' order by a.staffid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) {			
			log.error(exception);
		}
		return periodsList;
}

	/**
	 * This method is accessed from kycportal/jsp/TImeTable/SubjectAllotment.jsp
	*/

	public ArrayList boardDetails(String instituteid,String sessionid)
	{
	 	log.info("invoking boardDetails(String instituteid,String sessionid) from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");
	
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select distinct concat(boardname,'-',b.mediumname) as boardname,boardid from board a,standardmedium b where a.instituteid='"+instituteid+"' and a.boardstatus='A' and a.mediumid=b.mediumid and b.mediumstatus='A' and a.boardid in (select boardid from standard a1,standardschedule b1 where b1.sessionid='"+sessionid+"' and a1.standardstatus='A' and a1.standardid=b1.standardid and b1.stdschedulestatus='A')";  
				//System.out.println(select_query);
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				
				//System.out.println("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
				//System.out.println(exception);
			}
			return periodsList;
	} 


	public ArrayList getStandardTerms(String standardscheduleid)
	 {
	    	log.info("invoking getStandardTerms(String standardscheduleid)");
			ArrayList list=null;
		
			try
			{
				
				select_query	= "select a.termfeesid,b.termname from termfees a,feestermname b where a.termid=b.termid and termfeesstatus='A' and termstatus='A' and standardscheduleid='"+standardscheduleid+"'";
				//System.out.println("select_query"+select_query);
				list			= common_data_object.getListMap(select_query);
				
			}
			catch(Exception exception)
			{ 
				log.error(exception);					
			}
	    	return list;
	 }
	
	
	public ArrayList loadscholarship(String instituteid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT scholarshipid, scholarshipname, scholarshipdescription FROM scholarship where scholarshipstatus='A' and instituteid='"+instituteid+"';";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
/*
 * This method is accessed from kycportal/jsp/TImeTable/SubjectAllotment.jsp
 * This method is accessed from kycportal/jsp/Reports/ScheduleSelect.jsp
 * modified by maruthu for displaying Standard name with Group Name
*/
public ArrayList loadScheduledStandards(String sessionid,String instituteid,String boardid)
{
 	log.info("invoking loadScheduledStandards from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.standardscheduleid,case when c.groupname is null then a.standardname else concat(a.standardname,' ',c.groupname) end as standardname from standard a join standardschedule b on a.standardid=b.standardid and b.sessionid='"+sessionid+"' and a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.standardstatus='A' and b.stdschedulestatus='A' and a.boardid='"+boardid+"' left outer join standardgroup c on b.groupid=c.groupid and c.groupstatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);

		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}




//To view Section based on the standard  -- Sindhu

		public ArrayList listSections(String standardscheduleid)
		{
			log.info("invoking listSections To view Sections based on the standard");
				ArrayList sectionList = null;
				try
				{
					//select_query  	= "select b.sectionname,b.description,b.sectionid,null as sectionscheduleid, 'No' as status from section b where b.status='A' and b.sectionid not in (select sectionid from sectionschedule where standardscheduleid='"+standardscheduleid+"') union select b.sectionname,b.description,b.sectionid,c.sectionscheduleid,'Yes' as status from standardschedule a,section b,sectionschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardscheduleid=c.standardscheduleid and b.status='A' and b.sectionid=c.sectionid and c.sectionschedulestatus='A' order by sectionname";
					select_query  	= "select a.sectionid,a.sectionname,b.sectionscheduleid from section a,sectionschedule b,standardschedule c where a.sectionid=b.sectionid and b.standardscheduleid = c.standardscheduleid and c.standardscheduleid='"+standardscheduleid+"' and status='A' and sectionschedulestatus='A' and stdschedulestatus='A' order by a.sectionname"; 
					sectionList 	= common_data_object.getListMap(select_query);
				}
				catch(Exception exception) { 
					
					//System.out.println("SQLEXception inside com.iGrandee.Application.RegistrationProcess listSections method====>"+exception.getMessage());	
					//System.out.println(exception);
					log.error(exception);
				}
				return sectionList;
		}




/*
 * This method is accessed from kycportal/jsp/TImeTable/SubjectAllotment.jsp
 * This method is accessed from kycportal/jsp/Reports/ScheduleSelect.jsp
 * modified by maruthu for displaying Standard name with Group Name
*/
public ArrayList loadScheduledStandards(String sessionid,String instituteid)
{
 	log.info("invoking loadScheduledStandards from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select b.standardscheduleid,case when c.groupname is null then a.standardname else concat(a.standardname,' ',c.groupname) end as standardname from standard a join standardschedule b on a.standardid=b.standardid and b.sessionid='"+sessionid+"' and a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.standardstatus='A' and b.stdschedulestatus='A' left outer join standardgroup c on b.groupid=c.groupid and c.groupstatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);

		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/SubjectAllotment.jsp
*/
public ArrayList loadScheduledSections(String standardscheduleid)
{
 	log.info("invoking loadScheduledSections from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "SELECT b.sectionscheduleid,a.sectionname FROM section a join sectionschedule b on a.sectionid=b.sectionid and b.standardscheduleid='"+standardscheduleid+"' and a.status='A' and b.sectionschedulestatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

public boolean loadscheduledstatus(String sectionid)
{
	boolean ret_flag =false;

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select * from classcounselor where sectionscheduleid='"+sectionid+"' and counselorstatus='A';";
			
			System.out.println("select_query"+select_query);
			periodsList 	= common_data_object.getListMap(select_query);
			if(periodsList.size()>0)
				ret_flag=true;
			else
				ret_flag=false;
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return ret_flag;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/ClassTeacher.jsp
*/
public ArrayList loadClassTeacherSections(String sectionid)
{
 	log.info("invoking loadClassTeacherSections from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct subjectname,concat(prefix,firstname,' ',lastname)as staffname,subjectcode,a.staffid, case when g.staffid is null then 'Not Scheduled' else 'Scheduled' end as status from subjectallotment a join staffmaster b on a.sectionpublishid='"+sectionid+"' and a.staffid=b.staffid and a.subjectallotmentstatus='A' and b.staffstatus='A' join login c on b.userid=c.userid and c.loginstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join subjectschedule e on e.subjectscheduleid=a.subjectscheduleid and e.status='A' join subject f on e.subjectid=f.subjectid and f.subjectstatus='A' left outer join classcounselor g on a.sectionpublishid=g.sectionscheduleid  and g.counselorstatus='A' and a.staffid=g.staffid";
			//select_query  	= "select distinct concat(prefix,firstname,' ',lastname)as staffname,group_concat(subjectname) as subjectname,a.staffid,case when g.staffid is null then 'Not Scheduled' else 'Scheduled' end as status from subjectallotment a join staffmaster b on a.sectionpublishid='"+sectionid+"' and a.staffid=b.staffid and a.subjectallotmentstatus='A'  and b.staffstatus='A' join login c on b.userid=c.userid and c.loginstatus='A' join personmaster d  on c.personid=d.personid and d.status='A' join subjectschedule e on e.subjectscheduleid=a.subjectscheduleid 	and e.status='A' join subject f on e.subjectid=f.subjectid and f.subjectstatus='A' left outer join classcounselor g on a.sectionpublishid=g.sectionscheduleid and g.counselorstatus='A' and a.staffid=g.staffid group by staffid";
			System.out.println("select_query"+select_query);
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}

/*
 * This method is accessed from kycportal/jsp/TImeTable/ViewClassTeacher.jsp
*/
public ArrayList loadClassTeacherAllotted(String sectionid)
{
 	log.info("invoking loadClassTeacherAllotted from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		ArrayList periodsList = null;
		try
		{
			select_query  	= "select distinct subjectname,concat(prefix,'.',firstname,' ',lastname)as staffname,subjectcode,a.staffid, case when g.staffid is null then 'Not Scheduled' else 'Scheduled' end as status from subjectallotment a join staffmaster b on a.sectionpublishid='"+sectionid+"' and a.staffid=b.staffid and a.subjectallotmentstatus='A' and b.staffstatus='A' join login c on b.userid=c.userid and c.loginstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join subjectschedule e on e.subjectscheduleid=a.subjectscheduleid and e.status='A' join subject f on e.subjectid=f.subjectid and f.subjectstatus='A' join classcounselor g on a.sectionpublishid=g.sectionscheduleid  and g.counselorstatus='A' and a.staffid=g.staffid group by g.staffid"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}
public int removeClassTeacher(String staffid,String sectionid)throws SQLException,Exception {
	
 	log.info("invoking removeClassTeacher from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;


		try {
			

				
				workstate		= connection.prepareStatement("update classcounselor set counselorstatus=? where sectionscheduleid=? and staffid=?");
				
				workstate.setString(1,"R");
				workstate.setString(2,sectionid);
				workstate.setString(3,staffid);
				return_value		= 	workstate.executeUpdate();
				
			
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

	/**
	 * This method used to remove the class teacher assigned early
	 * @param bean
	 * @return 0 for failure greater than 0 for success
	 * @throws SQLException
	 * @throws Exception
	 */

	public int removeClassTeacher(ClassTeacherBean bean)throws SQLException,Exception {
		
		
		String staffid		= bean.getStaffid();
		String sectionid	= bean.getSectionscheduleid();
		
	 	log.info("invoking removeClassTeacher from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");
	
			connection 						= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			PreparedStatement workstate 	= null;
	
	
			try {
				
	
					
					workstate		= connection.prepareStatement("update classcounselor set counselorstatus=? where sectionscheduleid=? and staffid=?");
					
					workstate.setString(1,"R");
					workstate.setString(2,sectionid);
					workstate.setString(3,staffid);
					return_value		= 	workstate.executeUpdate();
					
				
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

public int setClassTeacher(String staffid,String sectionid,String userid)throws SQLException,Exception {
	
 	log.info("invoking setClassTeacher from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		PreparedStatement idworkstate 	= null;
		ResultSet idrs 					= null;
		PreparedStatement chkworkstate 	= null;
		ResultSet chkrs 				= null;
		
		long id							= 0l;
 		String curTime					= DateTime.showTime("MySqlWithTime");



		try {
			
			
			chkworkstate	= connection.prepareStatement("select classcounselorid from classcounselor where sectionscheduleid=? and staffid=? and counselorstatus=?");
			chkworkstate.setString(1,sectionid);
			chkworkstate.setString(2,staffid);
			chkworkstate.setString(3,"A");
			
			chkrs			= chkworkstate.executeQuery();
			
			if(!chkrs.next()){


				idworkstate		= connection.prepareStatement("select max(classcounselorid) from classcounselor");
				idrs			= idworkstate.executeQuery();
				if(idrs.next())
					id			= idrs.getLong(1);
				
				id++;
				
				workstate		= connection.prepareStatement("insert into classcounselor(classcounselorid, sectionscheduleid, staffid, createdby, dateofcreation, counselorstatus)values(?,?,?,?,?,?)");
				
				workstate.setLong(1,id);
				workstate.setString(2,sectionid);
				workstate.setString(3,staffid);
				workstate.setString(4,userid);
				workstate.setString(5,curTime);
				workstate.setString(6,"A");
				
				return_value		= 	workstate.executeUpdate();
				
			}	
			
			connection.commit();

	}
	catch(SQLException sqlexception) { 
		
		log.error(sqlexception);
		if(connection != null)
			connection.rollback();
		return_value = 0;
		
		
	}
	finally {
		
		
		if(idrs != null)
			idrs.close();
		
		if(idworkstate != null)
			idworkstate.close();
		
		if(workstate != null)
			workstate.close();
		
		ConnectionManager.closeConnection(connection);
	}
	
	return return_value;
}

	/**
	 * This method used to set the class teacher 
	 * @param bean
	 * @return 0 for failure greater than 0 for success
	 * @throws SQLException
	 * @throws Exception
	 */


	public int setClassTeacher(ClassTeacherBean bean)throws SQLException,Exception {
		
		String staffid		= bean.getStaffid();
		String sectionid	= bean.getSectionscheduleid();
		String userid		= bean.getCreatedby();
		
	 	log.info("invoking setClassTeacher from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");
	
			connection 						= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			PreparedStatement workstate 	= null;
			PreparedStatement idworkstate 	= null;
			ResultSet idrs 					= null;
			PreparedStatement chkworkstate 	= null;
			ResultSet chkrs 				= null;
			
			long id							= 0l;
	 		String curTime					= DateTime.showTime("MySqlWithTime");
	
	
	
			try {
				
				
				chkworkstate	= connection.prepareStatement("select classcounselorid from classcounselor where sectionscheduleid=? and staffid=? and counselorstatus=?");
				chkworkstate.setString(1,sectionid);
				chkworkstate.setString(2,staffid);
				chkworkstate.setString(3,"A");
				
				chkrs			= chkworkstate.executeQuery();
				
				if(!chkrs.next()){
	
	
					idworkstate		= connection.prepareStatement("select max(classcounselorid) from classcounselor");
					idrs			= idworkstate.executeQuery();
					if(idrs.next())
						id			= idrs.getLong(1);
					
					id++;
					
					workstate		= connection.prepareStatement("insert into classcounselor(classcounselorid, sectionscheduleid, staffid, createdby, dateofcreation, counselorstatus)values(?,?,?,?,?,?)");
					
					workstate.setLong(1,id);
					workstate.setString(2,sectionid);
					workstate.setString(3,staffid);
					workstate.setString(4,userid);
					workstate.setString(5,curTime);
					workstate.setString(6,"A");
					
					return_value		= 	workstate.executeUpdate();
					
				}	
				
				connection.commit();
	
		}
		catch(SQLException sqlexception) { 
			
			log.error(sqlexception);
			sqlexception.printStackTrace();
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			
		}
		finally {
			
			
			if(idrs != null)
				idrs.close();
			
			if(idworkstate != null)
				idworkstate.close();
			
			if(workstate != null)
				workstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		
		return return_value;
	}

public int updateAssign(String[] hours,String[] subjects)throws SQLException,Exception {
	
 	log.info("invoking updateAssign from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
		int[]	result					= null;

		try {
						
			workstate		= connection.prepareStatement("update subjectallotment set allottedhours=? where subjectallotmentid=?");
					
			if(hours != null && subjects != null && hours.length==subjects.length)
				for(int x=0;x<hours.length;x++){
										
				workstate.setString(2,subjects[x]);
				workstate.setString(1,hours[x]);
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


	public int updateAssign(SubjectAllotmentBean bean)throws SQLException,Exception {
			
		String[] hours		= bean.getAllottedhourss();
		String[] subjects	= bean.getSubjectallotmentids();
		
	 	log.info("invoking updateAssign(bean) from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");
	
			connection 						= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			PreparedStatement workstate 	= null;
			int[]	result					= null;
	
			try {
							
				workstate		= connection.prepareStatement("update subjectallotment set allottedhours=? where subjectallotmentid=?");
						
				if(hours != null && subjects != null && hours.length==subjects.length)
					for(int x=0;x<hours.length;x++){
											
					workstate.setString(2,subjects[x]);
					workstate.setString(1,hours[x]);
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
	
	public int removeAssign(String[] subjects)throws SQLException,Exception {
		
	 	log.info("invoking removeAssign from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

			connection 						= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			PreparedStatement workstate 	= null;
			int[]	result					= null;

			try {
							
				workstate		= connection.prepareStatement("update subjectallotment set subjectallotmentstatus=? where subjectallotmentid=? and subjectallotmentid not in (select subjectallotmentid from timetable where subjectallotmentid=? and timetablestatus=?)");
						
				if(subjects != null && subjects.length >0)
					for(int x=0;x<subjects.length;x++){
											
					workstate.setString(1, "D");
					workstate.setString(2,subjects[x]);
					workstate.setString(3,subjects[x]);
					workstate.setString(4,"A");
					
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
	


	public int removeAssign(SubjectAllotmentBean bean)throws SQLException,Exception {
		
		
		String[] subjects 		= bean.getSubjectallotmentids();
	 	log.info("invoking removeAssign from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");
	
			connection 						= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			PreparedStatement workstate 	= null;
			int[]	result					= null;
	
			try {
							
				workstate		= connection.prepareStatement("update subjectallotment set subjectallotmentstatus=? where subjectallotmentid=? and subjectallotmentid not in (select subjectallotmentid from timetable where subjectallotmentid=? and timetablestatus=?)");
						
				if(subjects != null && subjects.length >0)
					for(int x=0;x<subjects.length;x++){
											
					workstate.setString(1, "D");
					workstate.setString(2,subjects[x]);
					workstate.setString(3,subjects[x]);
					workstate.setString(4,"A");
					
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


public int insertWorkAssign(String[] hours,String[] subjects,String staffid,String sectionid,String createdby,String ipaddress)throws SQLException,Exception {
		
 	log.info("invoking insertWorkAssign from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

		connection 						= ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		PreparedStatement workstate 	= null;
	int[]	result					= null;
		String curTime					= DateTime.showTime("MySqlWithTime");

		try {
			
			
			workstate		= connection.prepareStatement("insert into subjectallotment(subjectallotmentid, staffid, subjectscheduleid, sectionpublishid, createdby, dateofcreation, ipaddress, subjectallotmentstatus, allottedhours)values(?,?,?,?,?,?,?,?,?)");
			
			if(hours != null && subjects != null && hours.length==subjects.length)
				for(int x=0;x<hours.length;x++){
										
				workstate.setLong(1, IdGenerator.getSubjectAllotmentId());
				workstate.setString(2,staffid);
				workstate.setString(3,subjects[x]);
				workstate.setString(4,sectionid);
				workstate.setString(5,createdby);
				workstate.setString(6,curTime);
				workstate.setString(7,ipaddress);
				workstate.setString(8,"A");
				workstate.setString(9,hours[x]);
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

	/**
	 * This method is used to insert subject allotment details through the SubjectAllotmentBean
	 * @param bean
	 * @return 0 for failure , greater than  0 for success.
	 * @throws SQLException
	 * @throws Exception
	 */

	public int insertWorkAssign(SubjectAllotmentBean bean)throws SQLException,Exception {
 		
	 	log.info("invoking insertWorkAssign(bean) from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

	 	String[] hours		= bean.getAllottedhourss();
	 	String[] subjects	= bean.getSubjectscheduleids();
	 	String staffid		= bean.getStaffid();
	 	String sectionid	= bean.getSectionpublishid();
	 	String createdby	= bean.getCreatedby();
	 	String ipaddress	= bean.getIpaddress();
	 	
 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement workstate 	= null;
		int[]	result					= null;
 		String curTime					= DateTime.showTime("MySqlWithTime");

 		try {
 			
 			
 			workstate		= connection.prepareStatement("insert into subjectallotment(subjectallotmentid, staffid, subjectscheduleid, sectionpublishid, createdby, dateofcreation, ipaddress, subjectallotmentstatus, allottedhours)values(?,?,?,?,?,?,?,?,?)");
 			
 			if(hours != null && subjects != null && hours.length==subjects.length)
 				for(int x=0;x<hours.length;x++){
 										
					workstate.setLong(1, IdGenerator.getSubjectAllotmentId());
					workstate.setString(2,staffid);
					workstate.setString(3,subjects[x]);
					workstate.setString(4,sectionid);
					workstate.setString(5,createdby);
					workstate.setString(6,curTime);
					workstate.setString(7,ipaddress);
					workstate.setString(8,"A");
					workstate.setString(9,hours[x]);
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


 	public int insertUpdateWorkHour(String[] staffs,String[] workhour,String userid,String sessionid,String ipaddress)throws SQLException,Exception {
 		
	 	log.info("invoking insertUpdateWorkHour from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement workstate 	= null;
 		PreparedStatement checkstate 	= null;
 		ResultSet checkrs				= null;
 		PreparedStatement workustate 	= null;
 		int[]	result					= null;
 		String curTime					= DateTime.showTime("MySqlWithTime");

 		try {
 			
 			
 			checkstate		= connection.prepareStatement("select workallotmentid from workallotment where sessionid=? and staffid=?");
 			workstate		= connection.prepareStatement("insert into workallotment(workallotmentid, staffid, noofhours, sessionid, createdby, dateofcreation, ipaddress, workallotmenstatus) value(?,?,?,?,?,?,?,?)");
 			workustate		= connection.prepareStatement("update workallotment set noofhours=? where workallotmentid=?");
 			
 			if(staffs != null && workhour != null && workhour.length==staffs.length)
 				for(int x=0;x<staffs.length;x++){
 					checkstate.setString(2, staffs[x]);
 					checkstate.setString(1, sessionid);
 					
 					checkrs		= checkstate.executeQuery();
 					
 					if(checkrs.next()){
 						
 						workustate.setString(1, workhour[x]);
 						workustate.setString(2, checkrs.getString(1));
 						workustate.addBatch();
 						
 					}
 					else{
 						
 						workstate.setLong(1, IdGenerator.getWorkAllotmentId());
 						workstate.setString(2,staffs[x]);
 						workstate.setString(3,workhour[x]);
 						workstate.setString(4,sessionid);
 						workstate.setString(5,userid);
 						workstate.setString(6,curTime);
 						workstate.setString(7,ipaddress);
 						workstate.setString(8,"A");
 						workstate.addBatch();
 						
 					}
 					if(checkrs != null)
 						checkrs.close();
 				}
 				
 			result		= 	workstate.executeBatch();
 			
 			if(result != null)
 			for(int y=0;y<result.length;y++)
 				return_value += result[y];
 			
 			result		= 	workustate.executeBatch();
 			
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
			
			if(checkrs != null)
				checkrs.close();
		
			if(checkstate != null)
				checkstate.close();
			
			if(workstate != null)
				workstate.close();
			
			if(workustate != null)
				workustate.close();
			
			
			ConnectionManager.closeConnection(connection);
		}
		
		return return_value;
	}
 	
 	/**
 	 * This method is used to insert the work allotment details through the java bean. It is accessed from
 	 * jsp/TimeTable/SubmitWorkAllotment.jsp
 	 * @param bean
 	 * @return 0 for failure greater than zero for success
 	 * @throws SQLException
 	 * @throws Exception
 	 */
 	
 	public int insertUpdateWorkHour(WorkAllotmentBean bean)throws SQLException,Exception {
 		
	 	log.info("invoking insertUpdateWorkHour from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");
	 	String[] staffs		= bean.getStaffids();
	 	String[] workhour	= bean.getNoofhours();
	 	String userid		= bean.getCreatedby();
	 	String sessionid	= bean.getSessionid();
	 	String ipaddress	= bean.getIpaddress();
 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement workstate 	= null;
 		PreparedStatement checkstate 	= null;
 		ResultSet checkrs				= null;
 		PreparedStatement workustate 	= null;
 		int[]	result					= null;
 		String curTime					= DateTime.showTime("MySqlWithTime");

 		try {
 			
 			
 			checkstate		= connection.prepareStatement("select workallotmentid from workallotment where sessionid=? and staffid=?");
 			workstate		= connection.prepareStatement("insert into workallotment(workallotmentid, staffid, noofhours, sessionid, createdby, dateofcreation, ipaddress, workallotmenstatus) value(?,?,?,?,?,?,?,?)");
 			workustate		= connection.prepareStatement("update workallotment set noofhours=? where workallotmentid=?");
 			
 			System.out.println("i am here");
 			if(staffs != null && workhour != null && workhour.length==staffs.length)
 				for(int x=0;x<staffs.length;x++){
 					
 					//if(!workhour[x].equals("0")){
 					System.out.println(staffs[x]+"_"+sessionid);
 					checkstate.setString(2, staffs[x]);
 					checkstate.setString(1, sessionid);
 					
 					
 					System.out.println("checkstate--->"+checkstate);
 					
 					checkrs		= checkstate.executeQuery();
 					
 					if(checkrs.next()){
 						
 						workustate.setString(1, workhour[x]);
 						workustate.setString(2, checkrs.getString(1));
 						workustate.addBatch();
 						
 					}
 					else{
 						
 						workstate.setLong(1, IdGenerator.getWorkAllotmentId());
 						workstate.setString(2,staffs[x]);
 						workstate.setString(3,workhour[x]);
 						workstate.setString(4,sessionid);
 						workstate.setString(5,userid);
 						workstate.setString(6,curTime);
 						workstate.setString(7,ipaddress);
 						workstate.setString(8,"A");
 						workstate.addBatch(); 
 						
 					}
 					if(checkrs != null)
 						checkrs.close();
 					//}
 				}
 				System.out.println("workstate"+workstate);
 			result		= 	workstate.executeBatch();
 			
 			if(result != null)
 			for(int y=0;y<result.length;y++)
 				return_value += result[y];
 			
 			result		= 	workustate.executeBatch();
 			
 			if(result != null)
 			for(int y=0;y<result.length;y++)
 				return_value += result[y];
 			
			connection.commit();

		}
		catch(SQLException sqlexception) { 
			
	sqlexception.printStackTrace();
	
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
		}
		finally {
			
			if(checkrs != null)
				checkrs.close();
		
			if(checkstate != null)
				checkstate.close();
			
			if(workstate != null)
				workstate.close();
			
			if(workustate != null)
				workustate.close();
			
			
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
