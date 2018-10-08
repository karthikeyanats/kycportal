package com.iGrandee.WorkDoneRegister;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.WorkDoneRegister.WorkDoneRegisterBean;
import org.apache.log4j.Logger;


public class WorkDoneRegisterEntry {
	static Logger log = Logger.getLogger(WorkDoneRegisterEntry.class);

 public WorkDoneRegisterEntry() {
	 
     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
     datetime				= new DateTime();
 }
  


 public ArrayList loadSessionForStaff(String userid,String instituteid)
 {
		ArrayList periodsList = null;
		try
		{
			log.info("invoking loadSessionForStaff from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");

			select_query  	= "select distinct e.sessionid,e.sessionname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.stdschedulestatus='A' join yearofsession e on d.sessionid=e.sessionid and e.sessionstatus='A' and e.instituteid='"+instituteid+"'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
 }/**
  * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneReply.jsp
  * List WorkDoneRegister details  for Staff         - prasanth
  @param userid that can be used to get getWorkDoneregDailForStaff   and it can be printed on the screen by 
  *
  @param  lessonscheduleid that can be used to get getWorkDoneregDailForStaff   and it can be printed on the screen 
  *
  @return  ArrayList by which result can be printed on the screen
 */
 public ArrayList getWorkDoneregDailForStaff(String userid,String lessonscheduleid)
 {
		ArrayList periodsList = null;
		try
		{	log.info("invoking getWorkDoneregDailForStaff from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");

			select_query  	= "select workdonedetails,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates from wrokdoneregister where workdonestatus='A' and createdby='"+userid+"' and lessonscheduleid='"+lessonscheduleid+"'order by dateofcreation desc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
 }
 /**
  * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegisterView.jsp
  * Load session for HM         - prasanth
  @param instituteid that can be used to get loadSession For HM   and it can be printed on the screen by instituteid  wise
  * 
  @return  ArrayList by which result can be printed on the screen
 */
 public ArrayList loadSessionForHM(String instituteid)
 {
		ArrayList periodsList = null;
		try
		{log.info("invoking loadSessionForHM from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
			select_query  	= "select a.sessionid,a.sessionname from yearofsession a where a.sessionstatus='A' and a.instituteid='"+instituteid+"'"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			log.error(exception);

		}
		return periodsList;
 }

 
 /**
   * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegister.jsp
   * Load standard for staff         - prasanth
   @param  userid that can be used to get StandardForStaff    and it can be printed on the screen by  userid,sessionid,instituteid  wise
   *
   @param sessionid that can be used to get StandardForStaff    and it can be printed on the screen by  userid,sessionid,instituteid  wise
   *
   @param instituteid that can be used to get StandardForStaff    and it can be printed on the screen by  userid,sessionid,instituteid  wise
   *
   @return  ArrayList by which result can be printed on the screen
 */
public ArrayList loadStandardForStaff(String userid,String sessionid,String instituteid)
{
		ArrayList periodsList = null;
		try
		{
			log.info("invoking Load standard for staff from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
 			//select_query  	= "select distinct d.standardscheduleid,e.standardname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+sessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.standardstatus='A' and e.instituteid='"+instituteid+"'"; 
 			//with group  
			select_query  	= "select distinct d.standardscheduleid,e.standardname,case when d.groupid is null then 'NoGroup' else (select e.groupname from standardgroup e where d.groupid=e.groupid and e.groupstatus='A')  end as groupname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+sessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.standardstatus='A' and e.instituteid='"+instituteid+"'"; 

 			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}

/**
   * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegisterView.jsp
   * Load BOARD for HM         - prasanth
   @param  instituteid that can be used to get board and it can be printed on the screen by instituteid  wise
   *
   @return  ArrayList by which result can be printed on the screen
*/
public ArrayList loadboard(String instituteid) {
		ArrayList arraylist = null;

		try {
			log.info("invoking loadboard from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
			select_query = "select a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b where a.mediumid=b.mediumid and a.instituteid='"+instituteid+"' and a.boardstatus='A' and b.mediumstatus='A' order by a.boardid,b.mediumid";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
/**
  * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegisterView.jsp
  * Load Standard for HM         - prasanth
  @param  instituteid that can be used to get board and it can be printed on the screen 
  *
  @param boardid that can be used to get board and it can be printed on the screen
  *
  @param sessionid that can be used to get board and it can be printed on the screen 
  *
  @return  ArrayList by which result can be printed on the screen
*/
public ArrayList loadstandard(String boardid,String sessionid,String instituteid) {
	ArrayList arraylist = null;
	try {	 
		log.info("invoking loadstandard from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
		//select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,(select  count(cm.candidateregisterid) from  candidateregister cm ,studentapproval s,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus='A' and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A' and cm.studentapprovalid=s.studentapprovalid and cm.standardscheduleid=a.standardscheduleid and (pm.sex='Male'  or pm.sex='M' )) as malecount,(select  count(cm.candidateregisterid) from  candidateregister cm ,studentapproval s,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus='A' and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A' and cm.studentapprovalid=s.studentapprovalid and cm.standardscheduleid=a.standardscheduleid  and (pm.sex='Female' or pm.sex='F')) as femalecount,(select  count(cm.candidateregisterid) from  candidateregister cm ,studentapproval s,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus='A' and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A' and cm.studentapprovalid=s.studentapprovalid and cm.standardscheduleid=a.standardscheduleid ) as totalcount,(SELECT count(sectionscheduleid) FROM sectionschedule ss join section b where ss.sectionid=b.sectionid and  ss.standardscheduleid=a.standardscheduleid and ss.sectionschedulestatus='A' and b.status='A') as sectioncount from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid"; 
		String qry = "select b.standardid,b.standardname,a.standardscheduleid,a.groupid,b.groupstatus,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid and d.groupstatus='A')  end as groupname from standardschedule a,standard b where a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and b.instituteid='"+instituteid+"' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A'  order by b.standardid,groupname";
		arraylist = common_data_object.getListMap(qry);
					
	} catch (Exception exception)
	{ 
		log.error(exception);
	}
	return    arraylist;
}
/**
  * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegister.jsp
  * Load Subject for staff         - prasanth
  @param  userid that can be used to get board and it can be printed on the screen 
  *
  @param standardscheduleid that can be used to get board and it can be printed on the screen 
  *
  @param subjectscheduleid that can be used to get board and it can be printed on the screen 
  *
  @return  ArrayList by which result can be printed on the screen
*/
public ArrayList loadSubjectForStaff(String userid,String standardscheduleid,String subjectscheduleid)
{
		ArrayList periodsList = null;
		try
		{
			log.info("invoking loadSubjectForStaff from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
			select_query  	= "select distinct c.subjectscheduleid,d.subjectname,d.subjectcode,e.lessonscheduleid,f.lessonname,f.lessondescription from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid join subject d on d.subjectid=c.subjectid and d.subjectstatus='A' and c.standardscheduleid='"+standardscheduleid+"'  join lessonschedule e on b.subjectscheduleid=e.subjectscheduleid and e.status='A' join lesson f on e.lessonid=f.lessonid and  f.subjectid=c.subjectid and f.lessonstatus='A' and c.status='A'";
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}    
		return periodsList;
}
/**
   * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegisterView.jsp
   * Load Subject for HM         - prasanth
   @param  userid that can be used to get load Subject For HM and it can be printed on the screen 
   *
   @param standardscheduleid that can be used to get load Subject For HM and it can be printed on the screen 
   *
   @param  subjectscheduleid that can be used to get load Subject For HM and it can be printed on the screen 
   *
   @param  sectionscheduleid that can be used to get load Subject For HM and it can be printed on the screen 
   *
   @return  ArrayList by which result can be printed on the screen
*/
public ArrayList loadSubjectForHM(String userid,String standardscheduleid,String subjectscheduleid,String sectionscheduleid)
{  
		ArrayList periodsList = null;
		try
		{	
			log.info("invoking loadSubjectForHM from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
			//old query
		
			//select_query  	= "select distinct e.userid,g.lessonname,h.lessonscheduleid,e.personid,(select case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname from personmaster pm where pm.personid=a.userid and pm.status='A') as username,f.firstname,c.subjectscheduleid,d.subjectname,d.subjectcode from staffmaster a join subjectallotment b on  a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join subject d on d.subjectid=c.subjectid and d.subjectstatus='A' and c.standardscheduleid='"+standardscheduleid+"' and c.status='A'join login e on e.userid=a.userid and e.loginstatus='A'  join personmaster f on f.personid=e.personid and f.status='A' join lessonschedule h on c.subjectscheduleid=h.subjectscheduleid and h.status='A' join lesson g on h.lessonid=g.lessonid and  g.subjectid=c.subjectid and g.lessonstatus='A' join department i on  i.status='A' and a.departmentid=i.departmentid ";
//new query
			select_query  	= "select distinct c.subjectscheduleid,j.sectionscheduleid,e.userid,g.lessonname,h.lessonscheduleid,e.personid,(select case when pm.middlename='-' or pm.middlename='' or pm.middlename is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname from personmaster pm where pm.personid=a.userid and pm.status='A') as username,f.firstname,c.subjectscheduleid,d.subjectname,d.subjectcode from staffmaster a join subjectallotment b on  a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join subject d on d.subjectid=c.subjectid and d.subjectstatus='A' and c.status='A' join sectionschedule j on j.standardscheduleid = c.standardscheduleid and j.sectionschedulestatus='A' and j.sectionscheduleid='"+sectionscheduleid+"' join login e on e.userid=a.userid and e.loginstatus='A'  join personmaster f on f.personid=e.personid and f.status='A' join lessonschedule h on c.subjectscheduleid=h.subjectscheduleid and h.status='A' join lesson g on h.lessonid=g.lessonid and  g.subjectid=c.subjectid and g.lessonstatus='A' join department i on  i.status='A' and a.departmentid=i.departmentid group by subjectscheduleid";

		periodsList 	= common_data_object.getListMap(select_query); 
		
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}
/**
   * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegisterView.jsp
   * Load Subject for HM         - prasanth
   @param  userid that can be used to get load Subject For HM and it can be printed on the screen 
   *
   @param standardscheduleid that can be used to get load Subject For HM and it can be printed on the screen 
   *
   @param subjectscheduleid that can be used to get load Subject For HM and it can be printed on the screen 
   *
   @param sectionscheduleid that can be used to get load Subject For HM and it can be printed on the screen 
   *
   @return  ArrayList by which result can be printed on the screen
*/
public ArrayList loadSubjectForHMFinal(String userid,String standardscheduleid,String subjectscheduleid,String sectionscheduleid)
{  
		ArrayList periodsList = null;
		try
		{	
			log.info("invoking loadSubjectForHM from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
			
		
			select_query  	= "select distinct c.subjectscheduleid,j.sectionscheduleid,e.userid,g.lessonname,h.lessonscheduleid,e.personid,(select case when pm.middlename='-' or pm.middlename='' or pm.middlename is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname from personmaster pm where pm.personid=a.userid and pm.status='A') as username,f.firstname,c.subjectscheduleid,d.subjectname,d.subjectcode from staffmaster a join subjectallotment b on  a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.subjectscheduleid='"+subjectscheduleid+"' and c.status='A' join subject d on d.subjectid=c.subjectid and d.subjectstatus='A' and c.status='A' join sectionschedule j on j.standardscheduleid = c.standardscheduleid and j.sectionschedulestatus='A' and j.sectionscheduleid='"+sectionscheduleid+"' join login e on e.userid=a.userid and e.loginstatus='A'  join personmaster f on f.personid=e.personid and f.status='A' join lessonschedule h on c.subjectscheduleid=h.subjectscheduleid and h.status='A' join lesson g on h.lessonid=g.lessonid and  g.subjectid=c.subjectid and g.lessonstatus='A' join department i on  i.status='A' and a.departmentid=i.departmentid order by userid,g.lessonid";
				
			log.info(select_query);
				
			periodsList 	= common_data_object.getListMap(select_query); 
		
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
}
/**
   * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegisterView.jsp
   * Load Subject for HM         - prasanth
   @param  standardscheduleid that can be used to get load Section For HM and it can be printed on the screen by standardscheduleid,instituteid   wise
   *
   @param instituteid that can be used to get load Section For HM and it can be printed on the screen by standardscheduleid,instituteid   wise
   *
   @return  ArrayList by which result can be printed on the screen
*/
public ArrayList loadSectionForHM(String standardscheduleid,String instituteid)
{  
		ArrayList periodsList = null;
		try
		{	
			log.info("invoking loadSectionForHM from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
		select_query  	= "select a.sectionscheduleid,b.sectionid,b.sectionname from sectionschedule a ,section b where a.standardscheduleid='"+standardscheduleid+"' and a.sectionid=b.sectionid and b.status='A' and a.sectionschedulestatus='A' and b.instituteid='"+instituteid+"';";

		periodsList 	= common_data_object.getListMap(select_query); 
		
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}
public ArrayList loadLessonForStaff(String userid,String subjectscheduleid)
{
		ArrayList periodsList = null;
		try
		{log.info("invoking loadLessonForStaff from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
			select_query  	= "select distinct c.lessonscheduleid,d.lessonname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' and b.subjectscheduleid='"+subjectscheduleid+"' join lessonschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join lesson d on c.lessonid=d.lessonid and d.lessonstatus='A'"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}
/**
 * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneList.jsp
 * List WorkDoneList for HM         - prasanth
 @param  lessonscheduleid that can be used to get lload All WorkDone for HM and it can be printed on the screen 
 *
 @param userids that can be used to get lload All WorkDone for HM and it can be printed on the screen
 *
 @return  ArrayList by which result can be printed on the screen
*/
public ArrayList loadAllWorkDoneforHM(String lessonscheduleid,String userids)
{
		ArrayList periodsList = null;
		try
		{
			log.info("invoking List WorkDoneList for HM from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
			select_query  	= "select wrokdoneregisterid,workdonedetails,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates from wrokdoneregister where workdonestatus='A' and lessonscheduleid='"+lessonscheduleid+"' and createdby='"+userids+"'order by dateofcreation desc";

			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) {  
			
			log.error(exception);

		}
		return periodsList;
}


public ArrayList loadSectionForStaff(String userid,String subjectscheduleid)
{
		ArrayList periodsList = null;
		try
		{
			log.info("invoking loadSectionForStaff from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
			select_query  	= "select distinct c.sectionscheduleid,d.sectionname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' and b.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule c on b.sectionpublishid=c.sectionscheduleid and c.sectionschedulestatus='A' join section d on c.sectionid=d.sectionid and d.status='A'"; 
			periodsList 	= common_data_object.getListMap(select_query); 
		}
		catch(Exception exception) { 
			
			log.error(exception);

		}
		return periodsList;
}


/**
   * This method is accessed from kycportal/jsp/WorkDoneRegister/WorkDoneRegisterSave.jsp
   * insert work done details          - prasanth
   @param  wrokdoneregisterid that can be used to insert in to wrokdoneregister table
   *
   @param lessonscheduleid that can be used to insert in to wrokdoneregister table
   *
   @param workdonedetails that can be used to insert in to wrokdoneregister table
   *
   @param dateofcreation that can be used to insert in to wrokdoneregister table
   *
   @param createdby that can be used to insert in to wrokdoneregister table
   *
   @param workdonestatus that can be used to insert in to wrokdoneregister table
   *
   @return  int by which result can be printed on the screen
*/
public int insertwrokdonedetails(WorkDoneRegisterBean instituteBean)throws SQLException
{
	int result=0;

	PreparedStatement settingsprepared  = null;

    try
    
	{
    	log.info("invoking insertwrokdonedetails from com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry");
    	connection 						= ConnectionManager.getKycConnection();
    	connection.setAutoCommit(false);

    	long l = common_data_object.fmaxId("select max(wrokdoneregisterid)from wrokdoneregister");

	String query="insert into wrokdoneregister (wrokdoneregisterid,lessonscheduleid,workdonedetails,dateofcreation,createdby,workdonestatus) values(?,?,?,?,?,?)";
	settingsprepared = connection.prepareStatement(query);
	
	settingsprepared.setLong(1, l);
	settingsprepared.setString(2,instituteBean.getLessonscheduleid());
	settingsprepared.setString(3,instituteBean.getWorkdonedetails());
	settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	settingsprepared.setString(5, instituteBean.getCreatedby());
	settingsprepared.setString(6, instituteBean.getWorkdonestatus());
   result = settingsprepared.executeUpdate();
   connection.commit();

	}catch(Exception exception) { 
		
		log.error(exception);
		
	}
	
	finally
	{
		if(settingsprepared != null)
			settingsprepared.close();
		
		ConnectionManager.closeConnection(connection);
	
	}
return result;
}


 CommonDataAccess common_data_object; 
 String insert_query;
 String select_query;
 int 	return_value;
 int[] returnvalue;
 Connection connection;
 DateTime datetime;

}
