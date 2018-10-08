package com.iGrandee.Common.Parent;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Dairy.Dairy;


public class ParentHome {

	static Logger log = Logger.getLogger(ParentHome.class);


 public ParentHome() {
	 
     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
     datetime				= new DateTime();
 }
  

 public ArrayList loadChildrenDetails(String parentid)
 {
	 	log.info("invoking loadChildrenDetails from com.iGrandee.Parent.ParentHome");

 		ArrayList periodsList = null;
 		try
 		{
 			select_query  	= "SELECT e.instituteid,e.institutename,b.imagepath,a.userid, d.sectionscheduleid, f.standardscheduleid,i.sectionname,d.studentallocationid,standardname, boardname, groupname, concat(b.firstname,' ',b.lastname) as studentname,b.prefix, n.sessionname, o.mediumname,case when d.rollno is null then 'Not Yet Generated' else d.rollno end as rollno FROM login a join personmaster b on a.personid=b.personid and a.loginstatus='A' and b.status='A' join candidateregister c on c.personid=b.personid and c.candidateregisterstatus='A' join studentallocation d on c.candidateregisterid=d.candidateregisterid and studentallocationstatus='A' join institution e on b.instituteid=e.instituteid join sectionschedule f on d.sectionscheduleid=f.sectionscheduleid join section i on f.sectionid=i.sectionid and i.status='A' join studentparent j on j.parentid='"+parentid+"' and j.userid=a.userid join standardschedule k on f.standardscheduleid=k.standardscheduleid join standard l on k.standardid=l.standardid join board m on l.boardid=m.boardid join yearofsession n on k.sessionid=n.sessionid join standardmedium o on m.mediumid=o.mediumid left outer join standardgroup p on k.groupid=p.groupid"; 
 			periodsList 	= common_data_object.getListMap(select_query);
 		}
 		catch(Exception exception) { 
 			
 	    	 log.error(exception);
 		}
 		return periodsList;
 }
 
 
 public ArrayList checkStandardTopperWeeker(String standardscheduleid,String status,String number)
 {
	 	log.info("invoking checkStandardTopperWeeker from com.iGrandee.Parent.ParentHome");

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
 
 
 public ArrayList getStudentDetails(String userid)
 {
	 log.info("invoking getStudentDetails from com.iGrandee.Parent.ParentHome");

     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "SELECT e.instituteid,e.institutename,e.institutelogo, d.sectionscheduleid, f.standardscheduleid,i.sectionname,d.studentallocationid,standardname, boardname, concat(b.firstname,' ',b.lastname) as studentname,b.prefix, n.sessionname,mediumname,groupname,case when d.rollno is null then 'Not Yet Generated' else d.rollno end as rollno FROM login a join personmaster b on a.personid=b.personid and a.loginstatus='A' and b.status='A' and a.userid='"+userid+"' join candidateregister c on c.personid=b.personid and c.candidateregisterstatus='A' join studentallocation d on c.candidateregisterid=d.candidateregisterid and studentallocationstatus='A' join institution e on b.instituteid=e.instituteid join sectionschedule f on d.sectionscheduleid=f.sectionscheduleid join section i on f.sectionid=i.sectionid and i.status='A' join standardschedule k on f.standardscheduleid=k.standardscheduleid join standard l on k.standardid=l.standardid join board m on l.boardid=m.boardid join yearofsession n on k.sessionid=n.sessionid join standardmedium o on m.mediumid=o.mediumid left outer join standardgroup p on k.groupid=p.groupid";
       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }
 /*
  * This method is accessed from kycportal/jsp/Parent/TimeTable.jsp
  * This method is accessed from kycportal/jsp/Student/StudentHome.jsp

  * display  Circular for Parent Page          - prasanth
  * @param  standardscheduleid that can be used to list circulardetails from  circular table by standardscheduleid wise
    @return  ArrayList by which result can be printed on the screen
 */

 public ArrayList CircularViewForStudentPage(String standardscheduleid)
 {    //old pqrq====>String studentid
	 
	 log.info("display  Circular for Parent Page from com.iGrandee.Parent.ParentHome");

     ArrayList arraylist = null;
	 
     try
     {	
       		//select_query	= "select a.circularid,a.subject,a.details from circular a  join circulardetails b on b.circulardetailsstatus='A' and a.circularstatus='A' and b.mode='student' and b.circularid=a.circularid and curdate() between a.validityfrom and a.validityto and find_in_set('"+studentid+"',b.sendto)";
    	 	//new query
    		select_query	= "select c.circularid,c.subject,c.details,date_format(c.validityfrom,'%d-%b-%Y') as Stdate, date_format(c.validityto,'%d-%b-%Y') as eddate,date_format(c.dateofcreation,'%d-%b-%Y %r') as cdate, concat(pm.firstname,pm.middlename,pm.lastname) as name from circular c,circulardetails cd,login log,personmaster pm where c.circularstatus ='A' and cd.circularid = c.circularid and (cd.mode='Standard') and cd.circulardetailsstatus='A' and find_in_set('"+standardscheduleid+"',cd.sendto) and c.validityto >= curdate() and c.createdby =log.userid and pm.personid = log.personid";

       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }

 
 /*
  * This method is accessed from kycportal/jsp/Parent/TimeTable.jsp
  * This method is accessed from kycportal/jsp/Student/StudentHome.jsp

  * display  Circular for Parent Page          - prasanth
  * @param  studentid that can be used to list circulardetails from  circular table by studentid wise
    @return  ArrayList by which result can be printed on the screen
 */

 public ArrayList CircularViewForStudentIndividual(String studentid)
 {
	 log.info("display  Circular for Parent Page from com.iGrandee.Parent.ParentHome");
     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select c.circularid,c.subject,c.details,date_format(c.validityfrom,'%d-%b-%Y') as Stdate, date_format(c.validityto,'%d-%b-%Y') as eddate, date_format(c.dateofcreation,'%d-%b-%Y') as cdate,concat(pm.firstname,pm.middlename,pm.lastname) as name from circular c,circulardetails cd,login log,personmaster pm where c.circularstatus ='A' and cd.circularid = c.circularid and ( cd.mode='student') and cd.circulardetailsstatus='A' and find_in_set('"+studentid+"',cd.sendto)  and c.validityto >=curdate() and c.createdby =log.userid and pm.personid = log.personid";
       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }
 /*
  * This method is accessed from kycportal/jsp/Principal/PrincipalHomepage.jsp
  * This method is accessed from kycportal/jsp/Staff/StaffHomepage.jsp
  * display  circular for HM ,Staff Home Page          - prasanth
  * @param  staffid that can be used to list circulardetails from  circular table by staffid wise
    @return  ArrayList by which result can be printed on the screen
 */
 
 public ArrayList CircularViewForStaffHomePage(String staffid)
 {
	 log.info("display  circular for HM Home Page from com.iGrandee.Parent.ParentHome");

     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select c.circularid,c.subject,c.details,date_format(c.validityfrom,'%d-%b-%Y') as Stdate, date_format(c.validityto,'%d-%b-%Y') as eddate, concat(pm.firstname,pm.middlename,pm.lastname) as name from circular c,circulardetails cd,login log,personmaster pm where c.circularstatus ='A' and cd.circularid = c.circularid and ( cd.mode='staff') and cd.circulardetailsstatus='A' and find_in_set('"+staffid+"',cd.sendto)  and c.validityto >=curdate() and c.createdby =log.userid and pm.personid = log.personid";

       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }

 /*
  * This method is accessed from kycportal/jsp/Principal/PrincipalHomepage.jsp
  * This method is accessed from kycportal/jsp/Staff/StaffHomepage.jsp
  * display  circular for HM ,Staff Home Page          - prasanth
   @param  roleid that can be used to list circulardetails from  circular table by roleid wise
    @return  ArrayList by which result can be printed on the screen
 */
 public ArrayList CircularViewForStaffHomePageByRole(String roleid)
 {
	 log.info("invoking getStudentDetails from com.iGrandee.Parent.ParentHome");

     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select c.circularid,c.subject,c.details,date_format(c.validityfrom,'%d-%b-%Y') as Stdate, date_format(c.validityto,'%d-%b-%Y') as eddate, concat(pm.firstname,pm.middlename,pm.lastname) as name from circular c,circulardetails cd,login log,personmaster pm where c.circularstatus ='A' and cd.circularid = c.circularid and ( cd.mode='Role') and cd.circulardetailsstatus='A' and find_in_set('"+roleid+"',cd.sendto)  and c.validityto<=curdate() and c.createdby =log.userid and pm.personid = log.personid";

       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }
 /*
  * This method is accessed from kycportal/jsp/parent/circularViewParentHomePage.jsp
  *  This method is accessed from kycportal/jsp/Principal/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Staff/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Student/circularViewParentHomePage.jsp
  * display  circular for Student.parent,HM.Staff Pages          - prasanth
  @param  circularid that can be used to list circulardetails from  circular table by circularid wise
   @return  ArrayList by which result can be printed on the screen
 */
 public ArrayList CircularViewListForStudentPage(String circularid)
 {
	 log.info("invoking getStudentDetails from com.iGrandee.Parent.ParentHome");

     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select a.createdby,a.circularid,a.subject,a.details,a.attachments,date_format(a.dateofcreation,'%d-%b-%Y') as dateofcreation,date_format(a.validityfrom,'%d-%b-%Y') as sdate,date_format(a.validityto,'%d-%b-%Y') as edate  from circular a join circulardetails b on b.circulardetailsstatus='A' and a.circularstatus='A' and a.circularid='"+circularid+"' and b.circularid=a.circularid";

       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }
 /*
  * This method is accessed from kycportal/jsp/kycpanel/Homepage.jsp
  * display  circular for Admin Page          - prasanth
  @param  roleid that can be used to list circulardetails from  circular table by roleid wise
   @return  ArrayList by which result can be printed on the screen
 */
 public ArrayList CircularViewForAdminPageByRole(String roleid)
 {
	 log.info("invoking display  circular for Admin Page from com.iGrandee.Parent.ParentHome");

     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select c.circularid,c.subject,c.details,date_format(c.validityfrom,'%d-%b-%Y') as Stdate, date_format(c.validityto,'%d-%b-%Y') as eddate, concat(pm.firstname,pm.middlename,pm.lastname) as name from circular c,circulardetails cd,login log,personmaster pm where c.circularstatus ='A' and cd.circularid = c.circularid and ( cd.mode='Role') and cd.circulardetailsstatus='A' and find_in_set('"+roleid +"',cd.sendto)  and c.validityto<=curdate() and c.createdby =log.userid and pm.personid = log.personid";

       		arraylist 		= common_data_object.getListMap(select_query);
     }  
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }/*
  * This method is accessed from kycportal/jsp/kycpanel/Homepage.jsp
  * display  circular for Admin Page          - prasanth
   @param  staffid that can be used to list circulardetails from  circular table by staffid wise
   @return  ArrayList by which result can be printed on the screen
 */
 public ArrayList CircularViewForAdminHomePage(String staffid)
 {
	 log.info("display  circular for Admin Page from com.iGrandee.Parent.ParentHome");

     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select c.circularid,c.subject,c.details,date_format(c.validityfrom,'%d-%b-%Y') as Stdate, date_format(c.validityto,'%d-%b-%Y') as eddate, concat(pm.firstname,pm.middlename,pm.lastname) as name from circular c,circulardetails cd,login log,personmaster pm where c.circularstatus ='A' and cd.circularid = c.circularid and ( cd.mode='staff') and cd.circulardetailsstatus='A' and find_in_set('"+staffid+"',cd.sendto)  and c.validityto >=curdate() and c.createdby =log.userid and pm.personid = log.personid";

       		arraylist 		= common_data_object.getListMap(select_query);
     }  
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }


 /*
  * This method is accessed from kycportal/jsp/parent/circularViewParentHomePage.jsp
  *  This method is accessed from kycportal/jsp/Principal/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Staff/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Student/circularViewParentHomePage.jsp
  * display  circular for Student.parent,HM.Staff Pages          - prasanth
   @param  instituteid that can be used to list institutedetails from  institution table by instituteid wise
   @return  ArrayList by which result can be printed on the screen
 */
 public ArrayList InstituteDetailForCircularStudentPage(String instituteid)
 {
	 log.info("invoking InstituteDetailForCircularStudentPage from com.iGrandee.Parent.ParentHome");

     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select institutename,country,state,institutelogo from institution where instituteid='"+instituteid+"'";

       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 

    	 log.error(exception);
     }
     return arraylist;
 }
 /*
  * This method is accessed from kycportal/jsp/parent/circularViewParentHomePage.jsp
  *  This method is accessed from kycportal/jsp/Principal/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Staff/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Student/circularViewParentHomePage.jsp
  * display  circular for Student.parent,HM.Staff Pages          - prasanth
   @param  createdby that can be used to get createdby name for circular from  personmaster,circular,login table by createdby wise
   @return  String by which result can be printed on the screen
 */

 public String getCreatename(String createdby)
 {
 	 String returnStr = null;
     try
     {
       	 log.info("invoking getCreatename from com.iGrandee.Parent.ParentHome");

     	select_query = "select distinct case when middlename='-' or middlename='' or middlename  is null then concat(prefix,firstname,' ',lastname) else concat(prefix,firstname,' ',middlename,' ',lastname) end as uname from personmaster a,circular b,login c where b.createdby=c.createdby and c.personid=a.personid and a.status='A' and b.circularstatus='A' and c.loginstatus='A' and a.personid='"+createdby+"';";
     	returnStr = common_data_object.getString(select_query);
     }catch(Exception e){log.error(e);}
     return returnStr;
 }
 /*
  * This method is accessed from kycportal/jsp/parent/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Principal/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Staff/circularViewParentHomePage.jsp
  * This method is accessed from kycportal/jsp/Student/circularViewParentHomePage.jsp
  * display  circular for Student.parent,HM.Staff Pages          - prasanth
   @param  createdby that can be used to get department name for circular from  login,staffmaster,department table by createdby wise
   @return  String by which result can be printed on the screen
 */

 public ArrayList getDepartment(String createdby)
 {
	 ArrayList arraylist = null;
     try
     {
    	 log.info("invoking getDepartment Name from com.iGrandee.Parent.ParentHome");
    	select_query	= "select a.usercategory,c.departmentname from login a ,staffmaster b,department c where a.personid='"+createdby+"' and a.userid=b.userid and b.staffstatus='A' and b.departmentid=c.departmentid and c.status='A' and a.loginstatus='A'";
   		arraylist 		= common_data_object.getListMap(select_query);
     }catch(Exception e)
     {
    	 log.error(e);
    	 }
     return arraylist;
 }
 CommonDataAccess common_data_object; 
 String insert_query;
 String select_query;
 int 	return_value;
 int[] returnvalue;
 Connection connection;
 DateTime datetime;

}

