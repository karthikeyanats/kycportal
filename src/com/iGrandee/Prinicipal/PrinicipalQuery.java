package com.iGrandee.Prinicipal;

import java.util.ArrayList;
import java.util.HashMap;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import java.sql.Connection;
import java.sql.SQLException;
import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;

import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.MasterEntries.Standard.StandardQuery;
import com.iGrandee.TransportFees.TransportStage;

// Referenced classes of package com.iGrandee.Common:
//            CommonDataAccess

public class PrinicipalQuery {
	static Logger log = Logger.getLogger(PrinicipalQuery.class);

	public PrinicipalQuery() {
		common_data_object = new CommonDataAccess();
		select_query = null;
	}
	/**
	   * get Standard Name for standard pass list creation (Access by prasanth)
	   * This method is accessed from kycportal /jsp/Exam/ExamPass/principalinfo.jsp
	   @param boardid that can be used to get standard name  from standard table by 
	   *
	   @param sessionid that can be used to get standard name  from standard table by 
	   *
	   @param instituteid that can be used to get standard name  from standard table by 
	   *
	   @return the ArrayList by which result can be printed on the screen
	 */
		public ArrayList loadstandard(String boardid,String sessionid,String instituteid) {
		ArrayList arraylist = null;
		try {
			select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,(select count(cm.candidateregisterid) from  candidateregister cm,standardschedule stas,sectionschedule secs ,studentapproval s,studentallocation sa,personmaster pm where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('A') and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A'   and cm.studentapprovalid=s.studentapprovalid and (pm.sex='Male'  or pm.sex='M' ) and sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid=a.standardscheduleid) as malecount,(select  count(cm.candidateregisterid) from  candidateregister cm ,studentapproval s,studentallocation sa,personmaster pm,standardschedule stas,";
			select_query +="sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus='A' and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A' and cm.studentapprovalid=s.studentapprovalid and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid=a.standardscheduleid  and (pm.sex='Female' or pm.sex='F')) as femalecount,(select  count(cm.candidateregisterid) from  candidateregister cm ,studentapproval s,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus='A' and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A' and cm.studentapprovalid=s.studentapprovalid and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid=a.standardscheduleid ) as totalcount,(SELECT count(sectionscheduleid) FROM sectionschedule ss join section b where ss.sectionid=b.sectionid and  ss.standardscheduleid=a.standardscheduleid and ss.sectionschedulestatus='A' and b.status='A') as sectioncount from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";  
			log.info("===================>>>>>>>>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
		/**
		   * get Standard Name for standard pass list creation (Access by maruthu)
		   * This method is accessed from kycportal/jsp/Principal/standardView.jsp
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
							   "(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm,standardschedule stas,sectionschedule secs ,studentallocation sa,personmaster pm where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'  and (pm.sex='Male'  or pm.sex='M' ) and sa.sectionscheduleid=secs.sectionscheduleid   and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as malecount," + 
							   "(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm,studentallocation sa,personmaster pm,standardschedule stas,";
				select_query +="sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=secs.sectionscheduleid and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid  and (pm.sex='Female' or pm.sex='F') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as femalecount," + 
						       "(select count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm,standardschedule stas,sectionschedule secs   where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid and cm.candidateregisterstatus='A'  and  sa.sectionscheduleid=secs.sectionscheduleid  and stas.standardscheduleid=secs.standardscheduleid  and stas.standardscheduleid=a.standardscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid ) as totalcount," + 
						       		"(SELECT count(sectionscheduleid) FROM sectionschedule ss join section b where ss.sectionid=b.sectionid and  ss.standardscheduleid=a.standardscheduleid and ss.sectionschedulestatus='A' and b.status='A') as sectioncount from standardschedule a	" +
						       		"join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid,a.groupid";  
				log.info("===================>>>>>>>>>>>>"+select_query);   
//System.out.println("loadstandardwithstatus===================>>>>>>>>>>>>"+select_query);   

				arraylist = common_data_object.getListMap(select_query);
				log.info("==========>>>>>"+arraylist);  
							
			} catch (Exception exception) { 
			}
			return    arraylist;
		}
			public ArrayList loadsectionforviewwithstatus(String standardscheduleid,String status) {
				ArrayList arraylist = null;
				try {
					
					select_query = "select a.sectionscheduleid, b.sectionname," +
							"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'   and sa.sectionscheduleid=a.sectionscheduleid and (pm.sex='Male'  or pm.sex='M' ) and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as malecount," +
									"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"') and sa.candidateregisterid=cm.candidateregisterid  and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid  and (pm.sex='Female' or pm.sex='F') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as femalecount," +
											"(select  count(cm.candidateregisterid) from  applicationissue ai, registration reg,studentapproval sap,candidateregister cm ,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus in ('"+status+"')  and sa.candidateregisterid=cm.candidateregisterid   and cm.candidateregisterstatus='A'  and sa.sectionscheduleid=a.sectionscheduleid and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid) as totalcount" +
													" from sectionschedule a	join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";
					//log.info("==================fdgfgdfgfg=>>>>>>>>>>>>"+select_query);
					arraylist = common_data_object.getListMap(select_query);
					//log.info("==========>>>>>"+arraylist);
					//System.out.println("==================fdgfgdfgfg=>>>>>>>>>>>>"+select_query);
				} catch (Exception exception) { 
					exception.printStackTrace();
				}
				return    arraylist;
			}
		public ArrayList loadsectionforview(String standardscheduleid) {
			ArrayList arraylist = null;
			try {
				
				select_query = "select a.sectionscheduleid, b.sectionname,(select  count(cm.candidateregisterid) from  candidateregister cm ,studentapproval s,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus='A' and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A' and cm.studentapprovalid=s.studentapprovalid and sa.sectionscheduleid=a.sectionscheduleid and (pm.sex='Male'  or pm.sex='M' )) as malecount,(select  count(cm.candidateregisterid) from  candidateregister cm ,studentapproval s,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus='A' and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A' and cm.studentapprovalid=s.studentapprovalid and sa.sectionscheduleid=a.sectionscheduleid  and (pm.sex='Female' or pm.sex='F')) as femalecount,(select  count(cm.candidateregisterid) from  candidateregister cm ,studentapproval s,studentallocation sa,personmaster pm  where cm.personid=pm.personid and pm.status='A' and sa.studentallocationstatus='A' and sa.candidateregisterid=cm.candidateregisterid and s.approvalstatus='A' and cm.candidateregisterstatus='A' and cm.studentapprovalid=s.studentapprovalid and sa.sectionscheduleid=a.sectionscheduleid ) as totalcount from sectionschedule a	join section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and b.status='A' and a.sectionschedulestatus='A' group by a.sectionscheduleid order by b.sectionid";
				//log.info("==================fdgfgdfgfg=>>>>>>>>>>>>"+select_query);
				arraylist = common_data_object.getListMap(select_query);
				//log.info("==========>>>>>"+arraylist);
							
			} catch (Exception exception) { 
				exception.printStackTrace();
			}
			return    arraylist;
		}
		/**
		   * get section Name for section pass list creation (Access by prasanth)
		   * This method is accessed from kycportal/jsp/Exam/ExamPass/principalinfo.jsp
		   @param boardid that can be used to get standard name  from standard table by 
		   *
		   @param standardscheduleid that can be used to get section name  from section table by 
		   *
		   @param instituteid that can be used to get section name  from section table by 
		   *
		   @return the ArrayList by which result can be printed on the screen
		 */
	public ArrayList loadsection(String standardscheduleid,String instituteid) {
		ArrayList arraylist = null;
		try { 
			
			select_query = "SELECT a.sectionscheduleid,b.sectionname FROM sectionschedule a ,section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and  b.instituteid='"+instituteid+"' and a.sectionschedulestatus='A' and b.status='A' order by a.sectionid ";
			log.info("========loadsection==>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadday() {
		ArrayList arraylist = null;
		try { 
			
			select_query = "SELECT s.dayid, s.dayname FROM scheduleddays s where s.daystatus='A' order by s.dayid";
			log.info("==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList LoadGradeList(String sessionid)
	{
		log.info("Invoking LoadScheduledExamList() based on the staff");
			ArrayList academicList = null;
			try
			{
				select_query  	= "select gradesystemid, gradename, cast(rangefrom as signed) as rangefrom, rangeto FROM gradesystem where gradesystemstatus='A' and sessionid='"+sessionid+"' order by rangefrom asc"; 
				academicList 	= common_data_object.getListMap(select_query);
				log.info("select_query"+select_query);
			}
			catch(Exception exception) { 
							
				log.error(exception);
			}
			return academicList;
	}
	public ArrayList loadperiod(String instituteid) {
		ArrayList arraylist = null;
		try { 
			
			select_query = "SELECT t.periodid,t.periodname,t.periodtime FROM timetableperoid_tb t where t.instituteid='"+instituteid+"' and t.status='A' order by t.periodname";
			log.info("==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
			System.out.println("==========>>>>>select_query"+select_query);

						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	
	public ArrayList loadstudentforsectionscheduleidwithstatus(String sectionscheduleid,String sex,String status) {
		ArrayList arraylist = null;
		try { 
			if(sex.equals("T"))
			select_query = "SELECT s.rollno,pm.middlename,pm.firstname,pm.lastname,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')  and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid";
			else if(sex.equals("M"))
				select_query = "SELECT s.rollno,pm.middlename,pm.firstname,pm.lastname,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')  and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and (pm.sex='Male' or pm.sex='M')  and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid";
			else if(sex.equals("F"))
				select_query = "SELECT s.rollno,pm.middlename,pm.firstname,pm.lastname,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')  and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and (pm.sex='Female' or pm.sex='F')  and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid";

			log.info("==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);       
			//System.out.println("==========>>>>>"+select_query);

		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadstudentforsectionscheduleid(String sectionscheduleid,String sex) {
		ArrayList arraylist = null;
		try { 
			if(sex.equals("T"))
			select_query = "SELECT s.rollno,pm.middlename,pm.firstname,pm.lastname,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus='A' and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'";
			else if(sex.equals("M"))
				select_query = "SELECT s.rollno,pm.middlename,pm.firstname,pm.lastname,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus='A' and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and (pm.sex='Male' or pm.sex='M')";
			else if(sex.equals("F"))
				select_query = "SELECT s.rollno,pm.middlename,pm.firstname,pm.lastname,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus='A' and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'  and (pm.sex='Female' or pm.sex='F')";

			log.info("==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);       
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadstudentforstandardscheduleid(String standardscheduleid,String sex) {
		ArrayList arraylist = null;
		try { 
			if(sex.equals("T"))
			select_query = "SELECT secs.sectionid,sec.sectionname,s.rollno,s.sectionscheduleid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM studentallocation s ,candidateregister cm,personmaster pm,sectionschedule secs ,standardschedule stas,section sec where secs.sectionid=sec.sectionid and  s.sectionscheduleid=secs.sectionscheduleid and cm.personid=pm.personid and s.studentallocationstatus='A' and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid='"+standardscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A' and secs.sectionschedulestatus='A' and sec.status='A' order by secs.sectionid";
			else if(sex.equals("M"))
				select_query = "SELECT secs.sectionid,sec.sectionname,s.rollno,s.sectionscheduleid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM studentallocation s ,candidateregister cm,personmaster pm,sectionschedule secs ,standardschedule stas,section sec where secs.sectionid=sec.sectionid and  s.sectionscheduleid=secs.sectionscheduleid and cm.personid=pm.personid and s.studentallocationstatus='A' and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid='"+standardscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A' and secs.sectionschedulestatus='A' and sec.status='A'   and (pm.sex='Male' or pm.sex='M') order by secs.sectionid";
			else if(sex.equals("F"))
				select_query = "SELECT secs.sectionid,sec.sectionname,s.rollno,s.sectionscheduleid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM studentallocation s ,candidateregister cm,personmaster pm,sectionschedule secs ,standardschedule stas,section sec where secs.sectionid=sec.sectionid and  s.sectionscheduleid=secs.sectionscheduleid and cm.personid=pm.personid and s.studentallocationstatus='A' and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid='"+standardscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A' and secs.sectionschedulestatus='A' and sec.status='A'   and (pm.sex='Female' or pm.sex='F') order by secs.sectionid";

			log.info("==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);       
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadstudentforstandardscheduleidwithstatus(String standardscheduleid,String sex,String status) {
		ArrayList arraylist = null;
		try { 
			if(sex.equals("T"))
			select_query = "SELECT secs.sectionid,sec.sectionname,s.rollno,pm.middlename,pm.firstname,pm.lastname,s.sectionscheduleid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s ,candidateregister cm,personmaster pm,sectionschedule secs ,standardschedule stas,section sec where secs.sectionid=sec.sectionid and  s.sectionscheduleid=secs.sectionscheduleid and cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')  and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid='"+standardscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A' and secs.sectionschedulestatus='A' and sec.status='A' and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid order by secs.sectionid";
			else if(sex.equals("M"))
				select_query = "SELECT secs.sectionid,sec.sectionname,pm.middlename,pm.firstname,pm.lastname,s.rollno,s.sectionscheduleid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s ,candidateregister cm,personmaster pm,sectionschedule secs ,standardschedule stas,section sec where secs.sectionid=sec.sectionid and  s.sectionscheduleid=secs.sectionscheduleid and cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')    and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid='"+standardscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A' and secs.sectionschedulestatus='A' and sec.status='A'   and (pm.sex='Male' or pm.sex='M') and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid order by secs.sectionid";
			else if(sex.equals("F"))
				select_query = "SELECT secs.sectionid,sec.sectionname,pm.middlename,pm.firstname,pm.lastname,s.rollno,s.sectionscheduleid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid FROM applicationissue ai, registration reg,studentapproval sap,studentallocation s ,candidateregister cm,personmaster pm,sectionschedule secs ,standardschedule stas,section sec where secs.sectionid=sec.sectionid and  s.sectionscheduleid=secs.sectionscheduleid and cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"')    and stas.standardscheduleid=secs.standardscheduleid and stas.standardscheduleid='"+standardscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A' and secs.sectionschedulestatus='A' and sec.status='A'   and (pm.sex='Female' or pm.sex='F')and ai.applicationid=reg.applicationid and ai.standardpublishid=reg.standardpublishid and ai.status='A' and reg.status='A' and sap.registrationid=reg.registrationid and sap.approvalstatus='A' and sap.studentapprovalid=cm.studentapprovalid order by secs.sectionid";
			log.info("==========>>>>>"+select_query);  
			//System.out.println("==========>>>>>"+select_query);

			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);       
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadstudent(String standardscheduleidid,String sessionid,String sectionscheduleid,String instituteid) {
		ArrayList arraylist = null;
		try {
			
			select_query = "select case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,g.studentallocationid,g.rollno,f.candidateregisterid,f.personid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname,a.applicationno from applicationissue a " +
							"join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionid+"' " +
							"and b.standardpublishid='"+standardscheduleidid+"' and a.status='A' and b.status='A'" +
							" join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' " +
							"join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A'" +
							" join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' " +
							"join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' " +
							"join studentallocation g on g.candidateregisterid=f.candidateregisterid" +
							" and g.sectionscheduleid='"+sectionscheduleid+"' and g.studentallocationstatus='A' " +
							"join personmaster pm where f.personid=pm.personid and pm.status='A'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadstaffusingstandardscheduleid(String standardscheduleid) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT distinct secs.sectionscheduleid,sec.sectionname,d.departmentname,r.rolename,sm.staffid,lo.userid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,sa.sectionpublishid FROM subjectschedule s  join subjectallotment sa on sa.subjectallotmentstatus='A' and sa.subjectscheduleid=s.subjectscheduleid and  s.standardscheduleid='"+standardscheduleid+"' and s.status='A' join staffmaster sm on  sm.staffid=sa.staffid and sm.staffstatus='A' join personmaster pm on  pm.personid=sm.userid join department d on d.departmentid=sm.departmentid and d.status='A' join  role r on r.roleid=sm.roleid and r.status='A' join login lo on pm.personid=lo.personid and lo.loginstatus='A' join sectionschedule secs on secs.sectionscheduleid=sa.sectionpublishid and sectionschedulestatus='A' join section sec on sec.sectionid=secs.sectionid and sec.status='A' order by sec.sectionname";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
			//System.out.println("==========>>>>>"+select_query);

						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadstaffusingsectionscheduleid(String standardscheduleid,String sectionpublishid,String instituteid) {
		ArrayList arraylist = null; 
		try {
			select_query = "SELECT distinct d.departmentname,r.rolename,sm.staffid,lo.userid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname FROM subjectschedule s  join subjectallotment sa on sa.subjectallotmentstatus='A' and sa.subjectscheduleid=s.subjectscheduleid and  s.standardscheduleid='"+standardscheduleid+"' and s.status='A' join staffmaster sm on  sm.staffid=sa.staffid and sm.staffstatus='A' join personmaster pm on  pm.personid=sm.userid join department d on d.departmentid=sm.departmentid and d.status='A' join  role r on r.roleid=sm.roleid and r.status='A' join login lo on pm.personid=lo.personid  and pm.instituteid='"+instituteid+"' and d.instituteid=pm.instituteid and r.instituteid=pm.instituteid and lo.loginstatus='A' and sa.sectionpublishid='"+sectionpublishid+"'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
			System.out.println("==========>>>>>"+select_query);			
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	
	public ArrayList loadsubjectusingstaffid(String staffid,String standardscheduleid,String sectionscheduleid) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT s.subjectcode,sa.subjectscheduleid,s.subjectname,s.description FROM subjectallotment sa join subjectschedule ss on sa.subjectscheduleid=ss.subjectscheduleid and sa.sectionpublishid='"+sectionscheduleid+"' and sa.subjectallotmentstatus='A' and ss.status='A' 	and sa.staffid='"+staffid+"' join subject s on  s.subjectid=ss.subjectid and s.subjectstatus='A' and ss.standardscheduleid='"+standardscheduleid+"'";
			log.info("======================>>>>>>>>>>>>>>>>"+select_query);
			//System.out.println("======================>>>>>>>>>>>>>>>>"+select_query);
  
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
		} catch (Exception exception) { exception.printStackTrace();
		}
		return    arraylist;
	}
	public ArrayList loadstaffusingdepartment(String departmentid) {
		ArrayList arraylist = null;
		try {
			departmentid=departmentid.replace(",", "','");
			select_query = "SELECT d.departmentid,d.departmentname,s.staffid,(select case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname from personmaster pm,login l where pm.personid=l.personid and l.userid=s.userid and pm.status='A') as username,(SELECT r.rolename FROM role r where r.roleid=s.roleid and r.status='A') as rolename,s.roleid FROM staffmaster s,department d where s.staffstatus='A' and d.status='A' and d.departmentid=s.departmentid  and s.departmentid in ('"+departmentid+"') order by d.departmentid,s.roleid";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadprofiledetails(String userid) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT l.username,pm.emailid,pm.mobilenumber,case when pm.middlename='-' or pm.middlename='' or pm.middlename is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname ,pm.qualification,pm.imagepath  FROM login l join personmaster pm on pm.personid=l.personid and l.loginstatus='A' and pm.status='A'  and l.userid='"+userid+"'";
			log.info(select_query);
			//System.out.println("=======>>>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadparentprofiledetails(String parentloginid) {
		ArrayList arraylist = null;
		try {
			select_query = "select pl.parentusername,pm.mobilenumber,pm.fathername"  
						   +" from parentlogin pl join studentparent sp on pl.parentloginid=sp.parentid and pl.parentloginid='"+parentloginid+"' and pl.parentstatus='A' and sp.studentparentstatus='A'"
						   +" join login l on l.userid=sp.userid and l.loginstatus='A'"
						   +" join personmaster pm on pm.personid=l.personid and status='A'" ;
			log.info(select_query); 
			//System.out.println("=======>>>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
		} catch (Exception exception) {    
		}
		return    arraylist;
	}
	
	public ArrayList loadstandardusingsessionid(String sessionid,String boardid) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT ss.standardscheduleid,ss.standardid,s.standardname,(select g.groupname from standardgroup g where g.groupid=ss.groupid and g.groupstatus='A') as groupname FROM standardschedule ss,standard s where s.standardstatus='A' and ss.standardid =s.standardid and  ss.sessionid='"+sessionid+"' and s.boardid='"+boardid+"' and ss.stdschedulestatus='A' order by s.standardid";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
			//System.out.println("==========>>>>>"+select_query);
		} catch (Exception exception) { 
			log.error(exception);
		}
		return    arraylist;
	}
	/**
	 * 
	 * @param sectionpublishid
	 * @param dayid
	 * @param periodid
	 * @param sessionid
	 * @return ArrayList
	 */
	public ArrayList loadfreepoolstaffforperiod(String sectionpublishid,String dayid,String periodid,String sessionid) {
		ArrayList arraylist = null;
		try {
			//select_query = "SELECT distinct t.timetableid,d.departmentname,r.rolename,sm.staffid,lo.userid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname FROM subjectschedule s  join subjectallotment sa on sa.subjectallotmentstatus='A' and sa.subjectscheduleid=s.subjectscheduleid and  s.standardscheduleid='"+standardscheduleid+"' and sa.sectionpublishid='"+sectionpublishid+"'" +"and s.status='A' join staffmaster sm on  sm.staffid = sa.staffid and sm.staffstatus='A' join personmaster pm on  pm.personid=sm.userid join department d on d.departmentid=sm.departmentid and d.status='A' join  role r on r.roleid=sm.roleid and r.status='A' join login lo on pm.personid=lo.personid and lo.loginstatus='A' left outer join timetable t on sa.subjectallotmentid=t.subjectallotmentid and sa.subjectallotmentstatus='A' and t.dayid='"+dayid+"' and t.periodid='"+periodid+"' and t.timetablestatus='A'";
			/*select_query =   " select d.departmentname,r.rolename,"
							+" case when pm.middlename='-' or pm.middlename='' or pm.middlename is null then concat(pm.prefix,pm.firstname,' ',pm.lastname)"
							+" else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname from staffmaster sm"
							+" join personmaster pm on  pm.personid=sm.userid and pm.instituteid='"+instituteid+"'"
							+" join department d on d.departmentid=sm.departmentid and d.status='A'"
							+" join  role r on r.roleid=sm.roleid and r.status='A'"
							+" join login lo on pm.personid=lo.personid and lo.loginstatus='A'"
							+" and staffid in (select staffid from subjectallotment where sectionpublishid='"+sectionpublishid+"'"
							+" and subjectallotmentid not in (select subjectallotmentid from timetable where timetablestatus='A' and dayid='"+dayid+"' and periodid='"+periodid+"'));";*/
			/*select_query =   " select d.departmentname,r.rolename,"
							+" case when pm.middlename='-' or pm.middlename='' or pm.middlename is null then concat(pm.prefix,pm.firstname,' ',pm.lastname)"
							+" else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname from staffmaster sm"
							+" join personmaster pm on  pm.personid=sm.userid and pm.instituteid='"+instituteid+"'"
							+" join department d on d.departmentid=sm.departmentid and d.status='A'"
							+" join  role r on r.roleid=sm.roleid and r.status='A'"
							+" join login lo on pm.personid=lo.personid and lo.loginstatus='A'"
							+" and staffid in (select staffid from subjectallotment where sectionpublishid='"+sectionpublishid+"'"
							+" and subjectallotmentid not in (select subjectallotmentid from timetable where timetablestatus='A' and dayid='"+dayid+"' and periodid='"+periodid+"') and staffid not in (select staffid from timetable t1,subjectallotment s1 where t1.subjectallotmentid=s1.subjectallotmentid and t1.periodid='"+periodid+"'));";			
			*/
			select_query =   "  select distinct e.departmentname,f.rolename,"
							+"	case when d.middlename='-' or d.middlename='' or d.middlename is null then"
							+"	concat(d.prefix,d.firstname,' ',d.lastname) else"
							+"	concat(d.prefix,d.firstname,' ',d.middlename,' ',d.lastname) end as uname"
							+"	from subjectallotment a,staffmaster b,login c,personmaster d,department e,"
							+"	role f where a.sectionpublishid='"+sectionpublishid+"' and a.subjectallotmentstatus='A'"
							+"	and a.staffid=b.staffid and b.staffstatus='A' and b.userid=c.userid and c.loginstatus='A'"
							+"	and c.personid=d.personid and d.status='A' and b.departmentid=e.departmentid and"
							+"	f.roleid=b.roleid and a.staffid not in(select distinct staffid from standardschedule a,subjectschedule b,subjectallotment c,timetable d"
							+"	where a.sessionid='"+sessionid+"' and a.standardscheduleid=b.standardscheduleid and a.stdschedulestatus='A'"
							+"	and b.status='A' and c.subjectscheduleid=b.subjectscheduleid and c.subjectallotmentstatus='A'"
							+"	and c.subjectallotmentid=d.subjectallotmentid and d.periodid='"+periodid+"'"
							+"	and dayid='"+dayid+"' and d.timetablestatus='A')";
			log.info(select_query);
			log.info("select_query=============>>>>>>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
		} catch (Exception exception) {   
		}
		return    arraylist;
	}
	public ArrayList loadperiodforfreepoolstaff(String instituteid) {
		ArrayList arraylist = null;
		try {
			//select_query = "SELECT distinct t.timetableid,d.departmentname,r.rolename,sm.staffid,lo.userid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname FROM subjectschedule s  join subjectallotment sa on sa.subjectallotmentstatus='A' and sa.subjectscheduleid=s.subjectscheduleid and  s.standardscheduleid='"+standardscheduleid+"' and sa.sectionpublishid='"+sectionpublishid+"'" +"and s.status='A' join staffmaster sm on  sm.staffid = sa.staffid and sm.staffstatus='A' join personmaster pm on  pm.personid=sm.userid join department d on d.departmentid=sm.departmentid and d.status='A' join  role r on r.roleid=sm.roleid and r.status='A' join login lo on pm.personid=lo.personid and lo.loginstatus='A' left outer join timetable t on sa.subjectallotmentid=t.subjectallotmentid and sa.subjectallotmentstatus='A' and t.dayid='"+dayid+"' and t.periodid='"+periodid+"' and t.timetablestatus='A'";
			select_query = "select tt.periodid,tt.periodtime,p.periodname from timetableperoid_tb tt "
							+" join periodnames p on tt.periodnameid=p.periodnameid"
							+" and tt.instituteid='"+instituteid+"' and tt.status='A' and p.periodnamestatus='A'";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {   
		}
		return    arraylist;
	}
	public ArrayList loadfreepoolstaff(String standardscheduleid,String sectionpublishid,String dayid) {
		ArrayList arraylist = null;
		try {
			//select_query = "SELECT distinct t.timetableid,d.departmentname,r.rolename,sm.staffid,lo.userid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname FROM subjectschedule s  join subjectallotment sa on sa.subjectallotmentstatus='A' and sa.subjectscheduleid=s.subjectscheduleid and  s.standardscheduleid='"+standardscheduleid+"' and sa.sectionpublishid='"+sectionpublishid+"'" +"and s.status='A' join staffmaster sm on  sm.staffid = sa.staffid and sm.staffstatus='A' join personmaster pm on  pm.personid=sm.userid join department d on d.departmentid=sm.departmentid and d.status='A' join  role r on r.roleid=sm.roleid and r.status='A' join login lo on pm.personid=lo.personid and lo.loginstatus='A' left outer join timetable t on sa.subjectallotmentid=t.subjectallotmentid and sa.subjectallotmentstatus='A' and t.dayid='"+dayid+"' and t.periodid='"+periodid+"' and t.timetablestatus='A'";
			select_query = "SELECT distinct tp.periodid,tp.periodtime,pn.periodname,t.timetableid,d.departmentname,r.rolename,sm.staffid,lo.userid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,sm.staffid FROM subjectschedule s  join subjectallotment sa on sa.subjectallotmentstatus='A' and sa.subjectscheduleid=s.subjectscheduleid and  s.standardscheduleid='"+standardscheduleid+"' and sa.sectionpublishid='"+sectionpublishid+"'" +"and s.status='A' join staffmaster sm on  sm.staffid = sa.staffid and sm.staffstatus='A' join personmaster pm on  pm.personid=sm.userid join department d on d.departmentid=sm.departmentid and d.status='A' join  role r on r.roleid=sm.roleid and r.status='A' join login lo on pm.personid=lo.personid and lo.loginstatus='A'  join timetable t on sa.subjectallotmentid=t.subjectallotmentid right outer join timetableperoid_tb tp on tp.periodid=t.periodid and tp.status='A' and sa.subjectallotmentstatus='A' and t.dayid='"+dayid+"'  and t.timetablestatus='A' join  periodnames  pn on pn.periodnameid=tp.periodnameid and periodnamestatus='A' order by tp.periodid";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
			System.out.println("select_query========>>>>>>>>>"+select_query);
		} catch (Exception exception) {   
		}
		return    arraylist;
	}
	public ArrayList LoadExamSubjectList(String examid,String sessionid)
	{
		log.info("Invoking LoadExamSubjectList() for Loading the alloted ExamnameList");
	    ArrayList boardList = new ArrayList();
	    try
	    {
	        //select_query = "SELECT sts.standardscheduleid,date_format(es.examdate,'%d-%b-%Y') as examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and exampublishstatus in ('R','A') and  markpublishstatus in ('R','P') and examschedulestatus in ('R','A')  join standardschedule sts on sts.standardscheduleid=ss.standardscheduleid and stdschedulestatus='A' and sts.sessionid='"+sessionid+"' join examallotment e on es.examallotmentid=e.examallotmentid and  examnameid='"+examid+"' and examallotmentstatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'";
	    	select_query = "SELECT sts.standardscheduleid,date_format(es.examdate,'%d-%b-%Y') as examdate, es.examtimein, REPLACE(TIME_FORMAT(es.examtimein,'%r'),':00 ',' ') as examtimeinampm,es.examtimeout,REPLACE(TIME_FORMAT(es.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(es.examtimeout,es.examtimein),1,5) AS duration,(select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and exampublishstatus in ('R','A') and  markpublishstatus in ('R','P') and examschedulestatus in ('R','A')  join standardschedule sts on sts.standardscheduleid=ss.standardscheduleid and stdschedulestatus='A' and sts.sessionid='"+sessionid+"' join examallotment e on es.examallotmentid=e.examallotmentid and  examnameid='"+examid+"' and examallotmentstatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'";
	        boardList = common_data_object.getListMap(select_query);
	        log.info("Exam name QUERY::>>>>"+select_query);
	       // System.out.println("Exam name QUERY::>>>>"+select_query);
	    }
	    catch(Exception exception) {
	    	log.error(exception);
	    }
	    return boardList;
	}
	
	public ArrayList LoadExamSubjectListforboard(String examid,String sessionid)
	{
		log.info("Invoking LoadExamSubjectListforboard() for Loading the alloted ExamnameList");
	    ArrayList boardList = new ArrayList();
	    try
	    {
	    	select_query = "SELECT sts.standardscheduleid,date_format(es.examdate,'%d-%b-%Y') as examdate, es.examtimein, REPLACE(TIME_FORMAT(es.examtimein,'%r'),':00 ',' ') as examtimeinampm,es.examtimeout,es.examtype,REPLACE(TIME_FORMAT(es.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(es.examtimeout,es.examtimein),1,5) AS duration,(select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,st.boardid,(select concat(a.boardname,'-',b.mediumname) as boardmedium from board a,standardmedium b where a.mediumid=b.mediumid and a.boardstatus='A' and b.mediumstatus='A' and a.boardid=st.boardid) as boardmedium FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and exampublishstatus in ('R','A') and  markpublishstatus in ('R','P') and examschedulestatus in ('R','A')  join standardschedule sts on sts.standardscheduleid=ss.standardscheduleid and stdschedulestatus='A' and sts.sessionid='"+sessionid+"' join examallotment e on es.examallotmentid=e.examallotmentid and  examnameid='"+examid+"' and examallotmentstatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'";
	        boardList = common_data_object.getListMap(select_query);
	        log.info("LoadExamSubjectListforboard QUERY::>>>>"+select_query);
	       // System.out.println("Exam name QUERY::>>>>"+select_query);
	    }
	    catch(Exception exception) {
	    	log.error(exception);
	    }
	    return boardList;
	}
	
	public ArrayList LoadExamSubjectListforsession(String sessionid)
	{
		log.info("Invoking LoadAllotedExamnameList() for Loading the alloted ExamnameList");
	    ArrayList boardList = new ArrayList();
	    try
	    {
	        select_query = "SELECT en.examnameid, en.examname,sts.standardscheduleid,date_format(es.examdate,'%d-%b-%Y') as examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and exampublishstatus in ('A','R') and markpublishstatus in ('P','R') and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid=ss.standardscheduleid and stdschedulestatus='A' join examname en on en.sessionid='"+sessionid+"' and en.examnamestatus='A' join examallotment e on es.examallotmentid=e.examallotmentid and  e.examnameid=en.examnameid and examallotmentstatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'";
	        boardList = common_data_object.getListMap(select_query);
	        log.info("Exam name QUERY::>>>>"+select_query);
	        System.out.println("Exam name QUERY::>>>>"+select_query);
	    }
	    catch(Exception exception) {
	    	log.error(exception);
	    }
	    return boardList;
	}
	public int ResultPublishUpdate(String [] examscheduleid) throws SQLException {
		int result = 0;
		PreparedStatement pstmt = null;
	 	log.info("invoking ResultPublishUpdate for Result Publish update Status");
		String Query = "";
		Connection connection = null;
		try {
			connection = ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			Query = "update  examschedule set exampublishstatus=?, markpublishstatus=? ,examschedulestatus=? where examscheduleid=? ";
			pstmt = connection.prepareStatement(Query);

			
			if(examscheduleid!=null && examscheduleid.length>0)
			{
				for(int i=0;i<examscheduleid.length;i++)
				{
					pstmt.setString(1,"R");
					pstmt.setString(2,"R");
					pstmt.setString(3,"R");
					pstmt.setString(4, examscheduleid[i]);
					log.info(" examscheduleid[i]"+ examscheduleid[i]);
					log.info(pstmt);
				    pstmt.addBatch();
				}
			}

			int i[]=pstmt.executeBatch();
			for(int j=0;j<i.length;j++)
			{
				result +=i[j];
			}
			connection.commit();
			
		} catch (Exception exception) {
			connection.rollback();
				log.error(exception);
				exception.printStackTrace();
			return 0;
		} finally {
			if (pstmt != null)
				pstmt.close();
			
			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	//load the students based on the standard
	public ArrayList LoadexammarkforPublish(String examnameid,String standardscheduleid)
	{
	    ArrayList boardList = new ArrayList();
	    try
	    {
	        //select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname  FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by c.candidateregisterid,sub.subjectid ";
	    	//select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	    	//select_query = "SELECT es.examscheduleid,es.markpublishstatus,es.examallotmentid,ss.theoryexternalmin,ss.theoryexternalmax,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	    	select_query = "SELECT sec.sectionid,sec.sectionname,sa.sectionscheduleid, es.examscheduleid,es.markpublishstatus,es.examallotmentid,ss.theoryexternalmin, ss.theoryexternalmax,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as  subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno  end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname, em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'   and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A'   join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'   join candidateregister c on c.candidateregisterid=sa.candidateregisterid  and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid  and pm.status='A' join sectionschedule ssc on ssc.standardscheduleid=sts.standardscheduleid and ssc.sectionscheduleid=sa.sectionscheduleid and ssc.sectionschedulestatus='A' join section sec on sec.sectionid=ssc.sectionid and sec.status='A' order by sa.rollno,c.candidateregisterid,sub.subjectid";
	        
	        boardList = common_data_object.getListMap(select_query);
	       log.info("Exam name QUERY::>>>>"+select_query);
	       System.out.println("======>>>>>>>>"+select_query);   
	    }
	    catch(Exception exception) {log.error(exception); }
	    return boardList;
	}
	public ArrayList LoadexammarkforPublish(String examnameid,String standardscheduleid,String sectionscheduleid)
	{
	    ArrayList boardList = new ArrayList();
	    try
	    {
	        //select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname  FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by c.candidateregisterid,sub.subjectid ";
	    	//select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	    	select_query = "SELECT es.examscheduleid,es.markpublishstatus,es.examallotmentid,ss.theoryexternalmin,ss.theoryexternalmax,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  order by sa.rollno,c.candidateregisterid,sub.subjectid ";   
	        
	        boardList = common_data_object.getListMap(select_query);
	       log.info("Exam name QUERY::>>>>"+select_query);
	   //    System.out.println("======>>>>>>>>"+select_query);   
	    }
	    catch(Exception exception) {log.error(exception); }
	    return boardList;
	}
	
	public ArrayList LoadexammarkforStudentList(String examnameid,String standardscheduleid,String sectionscheduleid)
	{
	    ArrayList boardList = new ArrayList();
	    try
	    {
	    	//select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	    	select_query = "SELECT es.examscheduleid,es.markpublishstatus,es.examallotmentid,ss.theoryexternalmin,ss.theoryexternalmax,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')  and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  order by sa.rollno,c.candidateregisterid,sub.subjectid ";   
	        
	        boardList = common_data_object.getListMap(select_query);
	       log.info("Exam name QUERY::>>>>"+select_query);
	     System.out.println("======>>>>>>>>"+select_query);   
	    }
	    catch(Exception exception) {log.error(exception); }
	    return boardList;
	}
	
	public ArrayList LoadexammarkforStudentList(String examnameid,String standardscheduleid)
	{
	    ArrayList boardList = new ArrayList();
	    try
	    {
	    	//select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	    	select_query = "SELECT es.examscheduleid,es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,sub.theoryexternalmax,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')  and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  order by sa.rollno,c.candidateregisterid,sub.subjectid ";   
	        
	        boardList = common_data_object.getListMap(select_query);
	       log.info("Exam name QUERY::>>>>"+select_query);
	     //System.out.println("======>>>>>>>>"+select_query);   
	    }
	    catch(Exception exception) {log.error(exception); }
	    return boardList;
	}
	
	public ArrayList LoadexammarkforStudentListforsubjectwise(String examnameid,String standardscheduleid,String sectionscheduleid,String subjectscheduleid)
	{
	    ArrayList boardList = new ArrayList();
	    try
	    {
	        //select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname  FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by c.candidateregisterid,sub.subjectid ";
	    	//select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	    	//select_query = "SELECT es.examscheduleid,es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,sub.theoryexternalmax,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and es.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	    	select_query = "SELECT es.examscheduleid,es.markpublishstatus,es.examallotmentid,ss.theoryexternalmin,ss.theoryexternalmax,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and es.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	        
	        boardList = common_data_object.getListMap(select_query);
	       log.info("Exam name QUERY::>>>>"+select_query);
	      //System.out.println("LoadexammarkforStudentListforsubjectwise======>>>>>>>>"+select_query);   
	    }
	    catch(Exception exception) {log.error(exception); exception.printStackTrace(); }
	    return boardList;
	}
	public ArrayList LoadExamMarkForChart(String examnameid,String standardscheduleid,String sectionscheduleid)
	{
	    ArrayList boardList = new ArrayList();
	    try
	    {
	        //select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname  FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by c.candidateregisterid,sub.subjectid ";
	    	//select_query = "SELECT es.markpublishstatus,es.examallotmentid,sub.theoryexternalmin,(case when sub.subjectcode is null or '' or ' ' then '-' else sub.subjectcode end )as subjectcode,sub.subjectname,case when sa.rollno is null then '-' else sa.rollno end as rollno,c.candidateregisterid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,em.marktaken,es.examscheduleid,ss.subjectscheduleid,c.candidateregisterid,sts.standardscheduleid,es.examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname,sa.studentallocationid FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A' and examallotmentid='"+examallotmentid+"' and exampublishstatus='A' and  markpublishstatus in ('A','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A' join candidateregister c on  c.standardscheduleid=sts.standardscheduleid and c.candidateregisterstatus='A' join studentallocation sa on c.candidateregisterid=sa.candidateregisterid and sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' left outer join exammark em on  em.studentallocationid=sa.studentallocationid and em.examscheduleid=es.examscheduleid and em.markstatus='A' join personmaster pm on pm.personid=c.personid and pm.status='A' order by sa.rollno,c.candidateregisterid,sub.subjectid ";
	    	//select_query = "SELECT case when sum(em.marktaken) is null then '0' else sum(em.marktaken) end as total,es.examallotmentid,sa.studentallocationid,sum(sub.theoryexternalmax) as totalmark FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')    and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  group by studentallocationid order by total,studentallocationid ";
	    	select_query = "SELECT case when sum(em.marktaken) is null then '0' else sum(em.marktaken) end as total,es.examallotmentid,sa.studentallocationid,sum(ss.theoryexternalmax) as totalmark FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')    and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  group by studentallocationid order by total,studentallocationid ";
	        
	        boardList = common_data_object.getListMap(select_query);
	       log.info("Exam name QUERY::>>>>"+select_query);
	       //System.out.println("LoadExamMarkForChart Exam name QUERY::>>>>"+select_query);  
	    }
	    catch(Exception exception) {log.error(exception); }
	    return boardList;
	}
	public ArrayList LoadStudentgradeWise(String examnameid,String standardscheduleid,String sectionscheduleid,String gradeid,String sessionid)
	{
	    ArrayList boardList = new ArrayList();
		Connection connection;
	    try
	    {
	    	connection 	    =   ConnectionManager.getKycConnection();
	        select_query    =   " CREATE OR REPLACE view gradewise as SELECT case when sum(em.marktaken) is null then '0' else sum(em.marktaken) end as total," +
							    " case when (SELECT gradesystemid  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto and sessionid='"+sessionid+"') is null then '0' "+
							    " else (SELECT gradesystemid  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto  and sessionid='"+sessionid+"') end as gradesystemid, "+
							    " case when (SELECT gradename  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto and sessionid='"+sessionid+"') is null then 'No Grade' "+
							    " else (SELECT gradename  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto  and sessionid='"+sessionid+"') end as gradename, "+
							    " case when (SELECT rangefrom  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto and sessionid='"+sessionid+"') is null then '0' "+
							    " else (SELECT rangefrom  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto  and sessionid='"+sessionid+"') end as rangefrom, "+
							    " case when (SELECT rangeto  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto and sessionid='"+sessionid+"') is null then 'No Grade' "+
							    " else (SELECT rangeto  FROM gradesystem g where sum(em.marktaken) "+
							    " between rangefrom and rangeto  and sessionid='"+sessionid+"') end as rangeto, "+
		        			    " es.examallotmentid,sa.studentallocationid,sum(ss.theoryexternalmax) as totalmark," +
		        			    " sa.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname  FROM examschedule es  join examallotment ea on ea.examnameid='"+examnameid+"' and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')    and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on  sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  left outer join exammark em on  em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  group by studentallocationid order by gradesystemid asc,total,studentallocationid; ";   
			Statement stmt1 =   connection.createStatement(); 
	        stmt1.executeUpdate(select_query);
	        String  select_querynew = "select *  from gradewise where gradesystemid in ('"+gradeid+"')";   
	        boardList = common_data_object.getListMap(select_querynew);
	        log.info("Exam Grade  QUERY::>>>>"+select_querynew);
	        Statement stmt = connection.createStatement();
			stmt.executeUpdate("DROP VIEW IF EXISTS `kycportal`.`gradewise`");
			try {
				if(stmt1!=null)
					stmt1.close();
				if(stmt!=null)
					stmt.close();
			    if(connection!=null)
					connection.close();
			} catch (RuntimeException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	    catch(Exception exception) {log.error(exception);				exception.printStackTrace();
 }
	    return boardList;
	}
	public String LoadStudentRangeWise(String examnameid,String standardscheduleid,String rangefrom,String rangeto,String sessionid)
	{
	    String  count = "";
		Connection connection;
	    try
	    {
	    	connection 	    =   ConnectionManager.getKycConnection();
	        select_query    =   " CREATE OR REPLACE view rangewise as SELECT sa.sectionscheduleid,case when sum(em.marktaken) is null then '0'"
								+" else sum(em.marktaken) end as total,"
								+" es.examallotmentid,sa.studentallocationid,sum(sub.theoryexternalmax) as totalmark"
								+" FROM examschedule es  join examallotment ea on es.examallotmentid=ea.examallotmentid and ea.examnameid='"+examnameid+"'"
								+" and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A'"
								+" join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'"
								+" and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and"
								+" markpublishstatus in ('R')    and examschedulestatus in ('R')"
								+" join standardschedule sts on sts.standardscheduleid=ea.standardscheduleid  and sts.stdschedulestatus='A'"
								+" join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join sectionschedule scs on scs.standardscheduleid=sts.standardscheduleid and scs.sectionschedulestatus='A' "
								+" join studentallocation sa on scs.sectionscheduleid=sa.sectionscheduleid and   sa.studentallocationstatus='A'"
								+" join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'"
								+" left outer join exammark em on  em.studentallocationid=sa.studentallocationid"
								+" and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c"
								+" on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'"
								+" join personmaster pm on pm.personid=c.personid and pm.status='A'"
								+" group by studentallocationid order by total,studentallocationid;";   
			Statement stmt1 =   connection.createStatement(); 
	        stmt1.executeUpdate(select_query);  
	        String  select_querynew = "select count(studentallocationid)  from rangewise where total between "+rangefrom+" and "+rangeto+" ;";   
	        count = common_data_object.getSingleColumn(select_querynew);
	        log.info("Exam Grade  QUERY::>>>>"+select_querynew);
	        Statement stmt = connection.createStatement();  
			stmt.executeUpdate("DROP VIEW IF EXISTS `kycportal`.`gradewise`");
			try {
				if(stmt1!=null)
					stmt1.close();
				if(stmt!=null)
					stmt.close();
			    if(connection!=null)
					connection.close();
			} catch (RuntimeException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	    catch(Exception exception) {log.error(exception); }
	    return count;
	}
	public ArrayList LoadStudentListforRangeWise(String examnameid,String standardscheduleid,String rangefrom,String rangeto,String sessionid)
	{
		ArrayList  detaillist = new ArrayList();
		Connection connection;
	    try
	    {
	    	connection 	    =   ConnectionManager.getKycConnection();
	        select_query    =   " CREATE OR REPLACE view rangewise as SELECT sa.sectionscheduleid,case when sum(em.marktaken) is null then '0'"
								+" else sum(em.marktaken) end as total,"
								+" es.examallotmentid,sa.studentallocationid,sa.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,sec.sectionname "
								+" FROM examschedule es  join examallotment ea on es.examallotmentid=ea.examallotmentid and ea.examnameid='"+examnameid+"' "
								+" and ea.standardscheduleid='"+standardscheduleid+"' and  examallotmentstatus='A'"
								+" join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'"
								+" and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and"
								+" markpublishstatus in ('R')    and examschedulestatus in ('R')"
								+" join standardschedule sts on sts.standardscheduleid=ea.standardscheduleid  and sts.stdschedulestatus='A'"
								+" join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join sectionschedule scs on scs.standardscheduleid=sts.standardscheduleid and scs.sectionschedulestatus='A' "
								+" join studentallocation sa on scs.sectionscheduleid=sa.sectionscheduleid and sa.studentallocationstatus='A'"
								+" join section sec on sec.sectionid=scs.sectionid and sec.status='A' "
								+" join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'"
								+" left outer join exammark em on  em.studentallocationid=sa.studentallocationid"
								+" and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c"
								+" on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'"
								+" join personmaster pm on pm.personid=c.personid and pm.status='A'"
								+" group by studentallocationid order by scs.sectionscheduleid,total,studentallocationid;";   
			Statement stmt1 =   connection.createStatement(); 
	        stmt1.executeUpdate(select_query);
	        String  select_querynew = "select *  from rangewise where total between "+rangefrom+" and "+rangeto+" ;";   
	        detaillist = common_data_object.getListMap(select_querynew);
	        log.info("Exam Grade  QUERY::>>>>"+select_querynew);
	        Statement stmt = connection.createStatement();  
			stmt.executeUpdate("DROP VIEW IF EXISTS `kycportal`.`rangewise`");
			try {
				if(stmt1!=null)
					stmt1.close();
				if(stmt!=null)
					stmt.close();
			    if(connection!=null)
					connection.close();
			} catch (RuntimeException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	    }
	    catch(Exception exception) {log.error(exception); }
	    return detaillist;
	}
	public ArrayList loadActiveDepartments(String instituteid)
	{
	 	log.info("invoking loadActiveDepartments from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

			ArrayList DepartList = null;
			try
			{
				select_query  	= "SELECT departmentid,departmentname FROM department where instituteid='"+instituteid+"' and  status='A'"; 
				DepartList 	= common_data_object.getListMap(select_query);
				//System.out.println(select_query);
				//System.out.println(DepartList);

				log.info("DepartList"+DepartList);
			}
			catch(Exception exception) { 
				
				log.error(exception);
			}
			return DepartList;
	}
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
	public ArrayList loadboard(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "select a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b where a.mediumid=b.mediumid and a.instituteid='"+instituteid+"' and a.boardstatus='A' and b.mediumstatus='A' order by a.boardid,b.mediumid";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
	
	public ArrayList loadDeptRoleStaffsWork(String sessionid,String deptid,String roleid)
	{
	 	log.info("invoking loadDeptRoleStaffsWork from com.iGrandee.TimeTable.PeriodTime.WorkAllotment");

			ArrayList periodsList = null;
			try
			{
				select_query  	= "select a.staffid,concat(c.firstname,' ',c.lastname)as name,d.noofhours, sum(e.allottedhours) as allotted from staffmaster a join login b on a.userid=b.userid and a.departmentid='"+deptid+"' and a.roleid='"+roleid+"' and a.staffstatus='A' and b.loginstatus='A' join personmaster c on b.personid=c.personid and c.status='A' join workallotment d on a.staffid=d.staffid and d.sessionid='"+sessionid+"' left outer join subjectallotment e on e.staffid=d.staffid and e.subjectallotmentstatus='A' left outer join subjectschedule f on e.subjectscheduleid=f.subjectscheduleid left outer join standardschedule g on g.standardscheduleid=f.standardscheduleid and f.status='A' and g.stdschedulestatus='A' and d.sessionid=g.sessionid group by a.staffid order by a.staffid asc"; 
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				
				log.error(exception);
			}
			return periodsList;
	}
	public ArrayList loadyearofsession(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT sessionid,sessionname FROM yearofsession where instituteid='"+instituteid+"'  and sessionstatus='A';";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
		}
		return arraylist;
	}
	
	public ArrayList loadsubject(String standardscheduleid) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT ss.subjectscheduleid, ss.subjectid, ss.standardscheduleid, s.subjectname,s.standardid, s.subjectcode FROM subjectschedule ss ,subject s where ss.subjectid=s.subjectid and ss.standardscheduleid='"+standardscheduleid+"' and ss.status='A' and s.subjectstatus='A' order by ss.subjectid"; 
			log.info("===================>>>>>>>>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadLesson(String subjectscheduleid) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT ls.lessonscheduleid, ls.lessonid,l.lessonname, l.lessondescription  FROM lessonschedule ls,lesson l where ls.status='A' and l.lessonstatus='A' and  ls.lessonid=l.lessonid and ls.subjectscheduleid='"+subjectscheduleid+"' order by l.lessonid"; 
			log.info("===================>>>>>>>>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	
	public ArrayList loadreligion(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT religionid,religionname FROM religion r where instituteid='"+instituteid+"' and relistatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist; 
	}
	public ArrayList getattendanceforstudent(String studentallocationid,String attendancedate) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT studentattendanceid,studentstate FROM studentattendance s where studentallocationid='"+studentallocationid+"'  and attendancedate ='"+attendancedate+"' and studentattendancestatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist; 
	}
	public String toGetAllDates(String monthPick) throws Exception{
		String datee ="";
		try {
			String monthPickarray []= monthPick.split("-");
			String qry = "SELECT DAYOFMONTH(LAST_DAY('"+monthPickarray[1]+"-"+monthPickarray[0]+"-01'));";
			datee = common_data_object.getString(qry);
			//System.out.print("Select query========>>>>>"+qry);
		} catch(Exception de){
			log.info("Exception toGetAllDates=============> "+de.getMessage());
			de.printStackTrace();
		}
		return datee;
		}
	public String toGetDayfordate(String date) throws Exception{
		String datee ="";
		try {
			String qry = "SELECT  DAYNAME('"+date+"')";
			datee = common_data_object.getString(qry);
			//System.out.print("Select query========>>>>>"+qry);
		} catch(Exception de){
			log.info("Exception toGetAllDates=============> "+de.getMessage());
			de.printStackTrace();
		}
		return datee;
		}
	public ArrayList getattendanceforview(String studentallocationid,String attendancedate) {
		ArrayList arraylist = null;

		try {
			
			select_query = "SELECT studentattendanceid,studentstate FROM studentattendance s where studentallocationid='"+studentallocationid+"'  and attendancedate ='"+attendancedate+"' and studentattendancestatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			// log.info("Studentstaus========>>>>>>"+arraylist);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist; 
	}

	public ArrayList getweekdatesforgivendate(String date) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT  DATE_ADD('"+date+"', INTERVAL(1-DAYOFWEEK('"+date+"')) DAY) as date1 ,DAYNAME(DATE_ADD('"+date+"', INTERVAL(1-DAYOFWEEK('"+date+"')) DAY)) as day1,DATE_ADD('"+date+"', INTERVAL(2-DAYOFWEEK('"+date+"')) DAY) as date2,DAYNAME(DATE_ADD('"+date+"', INTERVAL(2-DAYOFWEEK('"+date+"')) DAY)) as day2,DATE_ADD('"+date+"', INTERVAL(3-DAYOFWEEK('"+date+"')) DAY) as date3, DAYNAME(DATE_ADD('"+date+"', INTERVAL(3-DAYOFWEEK('"+date+"')) DAY)) as day3,DATE_ADD('"+date+"', INTERVAL(4-DAYOFWEEK('"+date+"')) DAY) as date4, DAYNAME(DATE_ADD('"+date+"', INTERVAL(4-DAYOFWEEK('"+date+"')) DAY)) as day4,DATE_ADD('"+date+"', INTERVAL(5-DAYOFWEEK('"+date+"')) DAY) as date5, DAYNAME(DATE_ADD('"+date+"', INTERVAL(5-DAYOFWEEK('"+date+"')) DAY)) as day5,DATE_ADD('"+date+"', INTERVAL(6-DAYOFWEEK('"+date+"')) DAY) as date6,DAYNAME(DATE_ADD('"+date+"', INTERVAL(6-DAYOFWEEK('"+date+"')) DAY)) as day6,DATE_ADD('"+date+"', INTERVAL(7-DAYOFWEEK('"+date+"')) DAY) as date7,DAYNAME(DATE_ADD('"+date+"', INTERVAL(7-DAYOFWEEK('"+date+"')) DAY)) as day7";
			//select_query = "SELECT  DATE_ADD('"+date+"', INTERVAL(1-DAYOFWEEK('"+date+"')) DAY) as date1 ,DATE_ADD('"+date+"', INTERVAL(2-DAYOFWEEK('"+date+"')) DAY) as date2,DATE_ADD('"+date+"', INTERVAL(3-DAYOFWEEK('"+date+"')) DAY) as date3,  DATE_ADD('"+date+"', INTERVAL(4-DAYOFWEEK('"+date+"')) DAY) as date4,  DATE_ADD('"+date+"', INTERVAL(5-DAYOFWEEK('"+date+"')) DAY) as date5,  DATE_ADD('"+date+"', INTERVAL(6-DAYOFWEEK('"+date+"')) DAY) as date6,   DATE_ADD('"+date+"', INTERVAL(7-DAYOFWEEK('"+date+"')) DAY) as date7,DAYNAME(DATE_ADD('"+date+"', INTERVAL(1-DAYOFWEEK('"+date+"')) DAY)) as day1,DAYNAME(DATE_ADD('"+date+"', INTERVAL(2-DAYOFWEEK('"+date+"')) DAY)) as day2,DAYNAME(DATE_ADD('"+date+"', INTERVAL(3-DAYOFWEEK('"+date+"')) DAY)) as day3,DAYNAME(DATE_ADD('"+date+"', INTERVAL(4-DAYOFWEEK('"+date+"')) DAY)) as day4,DAYNAME(DATE_ADD('"+date+"', INTERVAL(5-DAYOFWEEK('"+date+"')) DAY)) as day5,DAYNAME(DATE_ADD('"+date+"', INTERVAL(6-DAYOFWEEK('"+date+"')) DAY)) as day6,DAYNAME(DATE_ADD('"+date+"', INTERVAL(7-DAYOFWEEK('"+date+"')) DAY)) as day7";
			arraylist = common_data_object.getList(select_query);
			// log.info("Studentstaus========>>>>>>"+arraylist);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist; 
	}
	public ArrayList getweekprenextdatesforgivendate(String date) {
		ArrayList arraylist = null;
		try {
			select_query = "select	DATE_ADD('"+date+"', INTERVAL(0-DAYOFWEEK('"+date+"')) DAY) as previousdate,	DATE_ADD('"+date+"', INTERVAL(8-DAYOFWEEK('"+date+"')) DAY) as nextdate";
			//select_query = "SELECT  DATE_ADD('"+date+"', INTERVAL(1-DAYOFWEEK('"+date+"')) DAY) as date1 ,DATE_ADD('"+date+"', INTERVAL(2-DAYOFWEEK('"+date+"')) DAY) as date2,DATE_ADD('"+date+"', INTERVAL(3-DAYOFWEEK('"+date+"')) DAY) as date3,  DATE_ADD('"+date+"', INTERVAL(4-DAYOFWEEK('"+date+"')) DAY) as date4,  DATE_ADD('"+date+"', INTERVAL(5-DAYOFWEEK('"+date+"')) DAY) as date5,  DATE_ADD('"+date+"', INTERVAL(6-DAYOFWEEK('"+date+"')) DAY) as date6,   DATE_ADD('"+date+"', INTERVAL(7-DAYOFWEEK('"+date+"')) DAY) as date7,DAYNAME(DATE_ADD('"+date+"', INTERVAL(1-DAYOFWEEK('"+date+"')) DAY)) as day1,DAYNAME(DATE_ADD('"+date+"', INTERVAL(2-DAYOFWEEK('"+date+"')) DAY)) as day2,DAYNAME(DATE_ADD('"+date+"', INTERVAL(3-DAYOFWEEK('"+date+"')) DAY)) as day3,DAYNAME(DATE_ADD('"+date+"', INTERVAL(4-DAYOFWEEK('"+date+"')) DAY)) as day4,DAYNAME(DATE_ADD('"+date+"', INTERVAL(5-DAYOFWEEK('"+date+"')) DAY)) as day5,DAYNAME(DATE_ADD('"+date+"', INTERVAL(6-DAYOFWEEK('"+date+"')) DAY)) as day6,DAYNAME(DATE_ADD('"+date+"', INTERVAL(7-DAYOFWEEK('"+date+"')) DAY)) as day7";
			arraylist = common_data_object.getList(select_query);
			log.info("select_query========>>>>>>"+select_query);
			 log.info("Studentstaus========>>>>>>"+arraylist);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist; 
	}
	
		
		//created by rams for topper list
		public ArrayList topperListSubjectwise(String examnameid){
			ArrayList arraylist = null;
			StringBuffer strbuffer = new StringBuffer();
			try {
				
				strbuffer.append("select b.subjectscheduleid,h.subjectname,d.rollno,");
				strbuffer.append("concat(f.firstname,");
				strbuffer.append("CASE when  f.middlename='-' or f.middlename is null then ' ' else concat(' ',f.middlename,' ') end");
				strbuffer.append(",f.lastname) as fullname,a.studentallocationid,");
				strbuffer.append("a.marktaken from exammark a,examschedule b,examallotment c,studentallocation d,");
				strbuffer.append("candidateregister e,personmaster f,subjectschedule g,subject h");
				strbuffer.append("where a.examscheduleid=b.examscheduleid and c.examallotmentid=b.examallotmentid and");
				strbuffer.append("examnameid='"+examnameid+"' and d.studentallocationid=a.studentallocationid");
				strbuffer.append("and d.candidateregisterid=e.candidateregisterid and");
				strbuffer.append("f.personid=e.personid and g.subjectscheduleid=b.subjectscheduleid and h.subjectid=g.subjectid");
				strbuffer.append("order by b.subjectscheduleid,marktaken and b.markpublishstatus='A' and g.status='A' and");
				strbuffer.append("f.status='A' and h.subjectstatus='A' and candidateregisterstatus='A'");
				strbuffer.append("and c.examallotmentstatus='A' and d.studentallocationstatus='A' and b.examschedulestatus='A' desc");
				select_query = strbuffer.toString();
				log.info(select_query);
				arraylist = common_data_object.getList(select_query);
			}catch(Exception e){log.error(e);}
			return arraylist;
		}
		//end of topper list method
		
			
		
		 /*
		  * This method loadSectionwiseStudent is accessed from kycportal/jsp/Principal/StudentReportView.jsp
		  * This method loadSectionwiseStudent is accessed from kycportal/jsp/Principal/PrintPreviewStudentReportView.jsp
		  * To Load Students based on sectionscheduleid and studentallocation status  - Subhash
		  * add imagepath field to display stuudent image modified by maruthu
		 */
	

		public ArrayList loadSectionwiseStudent(String sectionscheduleid,String status) {
			ArrayList arraylist = null;
			try {
				log.info("invoking loadSectionwiseStudent for loading students based on sectionscheduleid and studentallocation status");
				  //hidden by rams it is order by acendeing select_query = "SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,pm.fathername,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid,s.createdby FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"') and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'";
				select_query = "SELECT pm.imagepath,s.rollno,pm.prefix,pm.firstname,pm.middlename,pm.lastname,pm.fathername,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then  concat(pm.firstname,' ',pm.lastname) else concat(pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,pm.fathername,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid,s.createdby  FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and  s.studentallocationstatus in ('A') and s.sectionscheduleid='"+sectionscheduleid+"'  and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A' order by pm.firstname";
				//select_query = "SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"') and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'";
				 System.out.println("loadSectionwiseStudent>>>sss>>.."+select_query);
				arraylist = common_data_object.getListMap(select_query);  
				log.info("Query :"+select_query);
			} catch (Exception exception) { 
			}
			return    arraylist;
		}
		
		
		
		
		
		
		
	
		/**
		   * get section Name for section pass list  (Craeted by prasanth)
		   * This method is accessed from kycportal/jsp/Exam/ExamPass/sectionwisepasslistview.jsp
		   @param standardscheduleid that can be used to get section name  from section table by 
		   *
		   @param sectionscheduleid that can be used to get section name  from section table by 
		   *
		   @return the ArrayList by which result can be printed on the screen
		 */
		public ArrayList loadSectionwisePassListView(String standardscheduleid,String sectionscheduleid)
		{
		    ArrayList boardList = new ArrayList();
		    try
		    {
		    	//select_query = "SELECT distinct ea.examnameid,ss.subjectscheduleid,en.examname,sub.subjectname FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";   
		    	select_query = "SELECT distinct ea.examnameid,ss.subjectscheduleid,en.examname,sub.subjectname FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')  and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";
		    	boardList = common_data_object.getListMap(select_query);
		       log.info("Exam name QUERY::>>>>"+select_query);
		    }
		    catch(Exception exception) {log.error(exception); }
		    return boardList;
		}
		/**
		   * get section Name for section pass list  (Craeted by prasanth)
		   * This method is accessed from kycportal/jsp/Exam/ExamPass/sectionwisepasslistview.jsp
		   @param examnameid that can be used to get examnameid name  from examname table by 
		   *
		   @param sectionscheduleid that can be used to get load Sectionwise Pass List Mark View  from marktaken table
		   *
		   @param subjectscheduleid that can be used to get load Section wise Pass List MarkV iew  from marktaken table  
		   *
		   @return the ArrayList by which result can be printed on the screen
		 */
		public String loadSectionwisePassListMarkView(String examnameid,String subjectscheduleid,String standardscheduleid,String sectionscheduleid)
		{
			String boardList ="";
		    try
		    {
		    	//select_query = "SELECT (((select count(em.studentallocationid) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"+examnameid+"'  and en.examnamestatus='A' and em.marktaken > ss.theoryexternalmin)/  count(em.studentallocationid))* 100) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"+examnameid+"' and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";   
		    	select_query = "SELECT (((select count(em.studentallocationid) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')  and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"+examnameid+"'  and en.examnamestatus='A' and em.marktaken > ss.theoryexternalmin)/  count(em.studentallocationid))* 100) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A' and sa.sectionscheduleid='"+sectionscheduleid+"' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"+examnameid+"' and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";
		    	//System.out.println(select_query);
		    	boardList = common_data_object.getString(select_query);
		       log.info("Exam name QUERY::>>>>"+select_query);  
		    }
		    catch(Exception exception) {log.error(exception); }
		    return boardList;
		}/**
		   * get Standard Name for standard pass list creation (created by prasanth)
		   * This method is accessed from kycportal/jsp/Exam/ExamPass/standardpasslistview.jsp
		   @param standardscheduleid that can be used to get Standard wise PassList  from exammark table by standardscheduleid wise
		   *
		   @return the ArrayList by which result can be printed on the screen
		 */
		public ArrayList loadStandardwisePassListView(String standardscheduleid)
		{
		    ArrayList boardList = new ArrayList();
		    try
		    {
		    	//select_query = "SELECT distinct ea.examnameid,ss.subjectscheduleid,en.examname,sub.subjectname FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A'   join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";
		    	select_query = "SELECT distinct ea.examnameid,ss.subjectscheduleid,en.examname,sub.subjectname FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')  and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A'  join standard st on st.standardid=sts.standardid  and st.standardstatus='A'  join studentallocation sa on sa.studentallocationstatus='A'   join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";
		    	boardList = common_data_object.getListMap(select_query);
		       log.info("Exam name QUERY::>>>>"+select_query);
		    }
		    catch(Exception exception)
		    {
		    	log.error(exception);
		    	}
		    return boardList;
		}
		/**
		   * get Standard Name for standard pass list creation (Created by prasanth)
		   * This method is accessed from kycportal/jsp/Exam/ExamPass/standardpasslistview.jsp
		   @param standardscheduleid that can be used to get Standard wise PassList  from exammark table 
		   *
		   @param subjectscheduleid that can be used to get Standard wise PassList  from exammark table 
		   *
		   @param examnameid that can be used to get Standard wise PassList  from exammark table 
		   *
		   @return the ArrayList by which result can be printed on the screen
		 */
		public String loadStandardisePassListMarkView(String examnameid,String subjectscheduleid,String standardscheduleid)
		{
			String boardList ="";
		    try
		    {
		    	//select_query = "SELECT (((select count(em.studentallocationid) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"+examnameid+"'  and en.examnamestatus='A' and em.marktaken > ss.theoryexternalmin)/  count(em.studentallocationid))* 100) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"+examnameid+"' and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";
		    	select_query = "SELECT (((select count(em.studentallocationid) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('R') and  markpublishstatus in ('R')  and examschedulestatus in ('R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"+examnameid+"'  and en.examnamestatus='A' and cast(em.marktaken as unsigned integer) >= cast(ss.theoryexternalmin as unsigned integer))/  count(em.studentallocationid))* 100) FROM examschedule es  join examallotment ea on  ea.standardscheduleid='"+standardscheduleid+"' and examallotmentstatus='A' join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.subjectscheduleid='"+subjectscheduleid+"' and ss.status='A'  and es.examallotmentid=ea.examallotmentid and exampublishstatus in ('A','R') and  markpublishstatus in ('R','P')  and examschedulestatus in ('A','R') join standardschedule sts on sts.standardscheduleid='"+standardscheduleid+"'  and sts.stdschedulestatus='A' join standard st on st.standardid=sts.standardid  and st.standardstatus='A' join studentallocation sa on sa.studentallocationstatus='A'  join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'  join exammark em on em.studentallocationid=sa.studentallocationid  and em.examscheduleid=es.examscheduleid and em.markstatus='A'  join candidateregister c on c.candidateregisterid=sa.candidateregisterid and c.candidateregisterstatus='A'  join personmaster pm on pm.personid=c.personid and pm.status='A'  join examname en on en.examnameid=ea.examnameid and ea.examnameid='"+examnameid+"' and en.examnamestatus='A' order by ea.examnameid,c.candidateregisterid,sub.subjectid";
		    	
		    	boardList = common_data_object.getString(select_query);
		    	//System.out.print("select_query->"+select_query);
		       log.info("Exam name QUERY::>>>>"+select_query);  
		    }
		    catch(Exception exception) {log.error(exception); }
		    return boardList;
		}
		 /*
		  * This method searchStudentNameDob is accessed from kycportal/jsp/StudentSearch/StudentReportView.jsp
		  * This method loadSectionwiseStudent is accessed from kycportal/jsp/Principal/PrintPreviewStudentReportView.jsp
		  * To Load Students based on sectionscheduleid and studentallocation status  - Subhash
		  * add imagepath field to display stuudent image modified by maruthu
		 */
	

		public ArrayList searchStudentNameDob(String studentname,String fathername,String dateofbirth) {
			ArrayList arraylist = null;
			try 
			{
				log.info("invoking searchStudentNameDob for loading students based on studentname,fathername,dob");
				String dob = ((StringBuffer)datetime.getMySQLFormat(dateofbirth)).toString();
				select_query = "select  h.sessionname,c.standardscheduleid,b.personid,a.studentallocationid,case when middlename='-' or middlename='' or middlename is null then concat(prefix,firstname,' ',lastname) else concat(prefix,firstname,' ',middlename,' ',lastname) end as uname,a.rollno,g.fathername,DATE_FORMAT(g.dob,'%d-%b-%Y') as dob,g.emailid,g.imagepath,c.standardid , d.sectionid,d.sectionname,f.standardname,(select concat(a1.boardname,' - ',b1.mediumname) from board a1,standardmedium b1,standard c1 where c1.boardid=a1.boardid and b1.mediumid=a1.mediumid and c1.standardid=c.standardid) as boardname from studentallocation a,candidateregister b,standardschedule c,section d, sectionschedule e,standard f,personmaster g,yearofsession h where a.sectionscheduleid=e.sectionscheduleid and d.sectionid=e.sectionid and e.standardscheduleid=c.standardscheduleid and c.standardid=f.standardid and b.personid=g.personid and  c.sessionid=h.sessionid and (a.studentallocationstatus='A' or a.studentallocationstatus='C')  and b.candidateregisterstatus='A' and c.stdschedulestatus='A' and a.candidateregisterid=b.candidateregisterid and g.dob='"+dob+"' and g.firstname like '%"+studentname+"%' and g.fathername like '%"+fathername+"%' and d.status='A' and e.sectionschedulestatus='A' and f.standardstatus='A' and g.status='A' and (h.sessionstatus='A' or h.sessionstatus='R') order by h.sessionid,c.standardscheduleid";
				arraylist = common_data_object.getListMap(select_query);
				log.info("Query :"+select_query);
				
			} catch (Exception exception) {
				System.out.println("Exception-->"+exception);
			}
			return    arraylist;
		}
		
		/**
		   * get section Name for section pass list creation (Access by selavakumar)
		   * This method is accessed from kycportal/jsp/Exam/ExamPass/principalinfo.jsp
		   @param boardid that can be used to get standard name  from standard table by 
		   *
		   @param standardscheduleid that can be used to get section name  from section table by 
		   *
		   @param instituteid that can be used to get section name  from section table by 
		   *
		   *
		   *@param sectionscheduleid that can be used to ignore that particular section 
		   *
		   @return the ArrayList by which result can be printed on the screen
		 */
	public ArrayList sectionchageload(String standardscheduleid,String instituteid,String sectionscheduleid) {
		ArrayList arraylist = null;
		try { 
			
			select_query = "SELECT a.sectionscheduleid,b.sectionname FROM sectionschedule a ,section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and  b.instituteid='"+instituteid+"' and a.sectionschedulestatus='A' and b.status='A' and sectionscheduleid<>"+sectionscheduleid+" order by a.sectionid";
			log.info("==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
		
	public int changesection(String  studentallocationid,String sectionscheduleid,String createdby) throws Exception {
		
		int result=0;
		PreparedStatement transportstageprepared 	= null;
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null;
		PreparedStatement updatestallstmt 	= null;
		PreparedStatement copystallstmt 	= null;
		PreparedStatement nextupdatestmt 	= null;
		ResultSet copyset					=null;
		Connection connection = null;
		String insertsectionscheduleid=null;
		String insertcreatedby=null;String insertstudentallocationid=null;
		PreparedStatement insertallstmt 	= null;
		PreparedStatement sectiontransferlogkeystmt=null;
		ResultSet sectiontransferlogkeyset=null;
		PreparedStatement insertsectionstmt 	= null;
		long sectiontransferlogid						= 0l;
		try {
			
			connection = ConnectionManager.getKycConnection(); 
		   connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");

			checkprepared			= connection.prepareStatement("select studentallocationid from sectiontransferlog where transferaction='Created' and studentallocationid=?");
			checkprepared.setString(1, studentallocationid);
			checkrs				= checkprepared.executeQuery();
			
			//select_query		=	"select max(registrationid) from registration";
			sectiontransferlogkeystmt		=	connection.prepareStatement("select max(sectiontransferlogid) from sectiontransferlog");
			sectiontransferlogkeyset			=	sectiontransferlogkeystmt.executeQuery();
	
			if(sectiontransferlogkeyset.next())
				sectiontransferlogid	=	sectiontransferlogkeyset.getLong(1);
	
			sectiontransferlogid++;
			
			 
			
			System.out.println("sectiontransferlogid>>>>"+sectiontransferlogid);
			if(!checkrs.next()){
				
				System.out.println("in if>>>>>>");
	/*step 1 copy data from studentallocation */			
				copystallstmt=connection.prepareStatement("select sectionscheduleid,createdby,studentallocationid from studentallocation where studentallocationid=?");
				copystallstmt.setString(1, studentallocationid);
				System.out.println("copystallstmt>>"+copystallstmt);
				copyset=copystallstmt.executeQuery();
				if(copyset.next()){
					insertsectionscheduleid=copyset.getString(1);
					insertcreatedby=copyset.getString(2);
					insertstudentallocationid=copyset.getString(3);
					System.out.println("insertsectionscheduleid>>"+insertsectionscheduleid);
					System.out.println("sectionscheduleid>>"+sectionscheduleid);
					
	/*step 2 inserted in to sectiontransferlog  copied values */					
					insertallstmt=connection.prepareStatement("insert into sectiontransferlog ( studentallocationid, sectionscheduleid, dateofcreation, transferaction, sectiontransferlogstatus, createdby) values (?, ?, ?, ?, ?, ?)");
					//insertallstmt.setLong(1, sectiontransferlogid);
					insertallstmt.setString(1, insertstudentallocationid);
					insertallstmt.setString(2, insertsectionscheduleid);
					insertallstmt.setString(3, currentdate);
					insertallstmt.setString(4, "Created");
					insertallstmt.setString(5, "D");
					insertallstmt.setString(6, insertcreatedby);
					System.out.println("insertallstmt>>>>>"+insertallstmt);
					result+=insertallstmt.executeUpdate();
				}
				
	/*step 3 update studentallocation the sectionscheduleid */		
				updatestallstmt=connection.prepareStatement("update studentallocation set sectionscheduleid=? where studentallocationid=? and studentallocationstatus='A'");
				updatestallstmt.setString(1, sectionscheduleid);
				updatestallstmt.setString(2, studentallocationid);
				System.out.println("updatestallstmt>>>>"+updatestallstmt);
				result+=updatestallstmt.executeUpdate();
   /*step 4 update sectiontransferlog  status to D */				
				nextupdatestmt=connection.prepareStatement("update sectiontransferlog set sectiontransferlogstatus=? where studentallocationid=? ");
				nextupdatestmt.setString(1, "D");
				nextupdatestmt.setString(2, studentallocationid);
				System.out.println("nextupdatestmt>>>"+nextupdatestmt);
				result+=nextupdatestmt.executeUpdate();
	/*step 5 insert  sectiontransferlog cahnged sectionscheduleid*/				
				insertsectionstmt=connection.prepareStatement("insert into sectiontransferlog (studentallocationid, sectionscheduleid, dateofcreation, transferaction, sectiontransferlogstatus, createdby) values (?, ?, ?, ?, ?, ?)");
				//insertsectionstmt.setLong(1, sectiontransferlogid);
				insertsectionstmt.setString(1, studentallocationid);
				insertsectionstmt.setString(2, sectionscheduleid);
				insertsectionstmt.setString(3, currentdate);
				insertsectionstmt.setString(4, "Transfered");
				insertsectionstmt.setString(5, "A");
				insertsectionstmt.setString(6, createdby);
				System.out.println("insertsectionstmt>>>>"+insertsectionstmt);
				result+=insertsectionstmt.executeUpdate();
				
			} 
			else{
				
			
				
	/*step 3 update studentallocation the sectionscheduleid */		
				updatestallstmt=connection.prepareStatement("update studentallocation set sectionscheduleid=? where studentallocationid=? and studentallocationstatus='A'");
				updatestallstmt.setString(1, sectionscheduleid);
				updatestallstmt.setString(2, studentallocationid);
				System.out.println(updatestallstmt);
				result+=updatestallstmt.executeUpdate();
   /*step 4 update sectiontransferlog  status to D */				
				nextupdatestmt=connection.prepareStatement("update sectiontransferlog set sectiontransferlogstatus=? where studentallocationid=?");
				nextupdatestmt.setString(1, "D");
				nextupdatestmt.setString(2, studentallocationid);
				System.out.println(nextupdatestmt);
				result+=nextupdatestmt.executeUpdate();
	/*step 5 insert  sectiontransferlog cahnged sectionscheduleid*/				
				insertsectionstmt=connection.prepareStatement("insert into sectiontransferlog (studentallocationid, sectionscheduleid, dateofcreation, transferaction, sectiontransferlogstatus, createdby) values (?, ?, ?, ?, ?, ?)");
				//insertsectionstmt.setLong(1, sectiontransferlogid);
				insertsectionstmt.setString(1, studentallocationid);
				insertsectionstmt.setString(2, sectionscheduleid);
				insertsectionstmt.setString(3, currentdate);
				insertsectionstmt.setString(4, "Transfered");
				insertsectionstmt.setString(5, "A");
				insertsectionstmt.setString(6, createdby);
				System.out.println(insertsectionstmt);
				result+=insertsectionstmt.executeUpdate();
				
			}
			System.out.println("result>>>>>>>"+result);
			connection.commit();	
		}	
			catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(connection!=null){
				
				connection.rollback();
			}
		}
		 finally
			{
		 
			 if(transportstageprepared != null)
				 transportstageprepared.close();
			 
			 if(checkprepared != null)
				 checkprepared.close();
			 
			 if(updatestallstmt != null)
				 updatestallstmt.close();
			 
			 if(copystallstmt != null)
				 copystallstmt.close();
			 
			 if(insertallstmt != null)
				 insertallstmt.close();
			 
			 if(copystallstmt != null)
				 copystallstmt.close();
			 
			 
			 if(insertsectionstmt != null)
				 insertsectionstmt.close();
			 
			 if(connection != null)
				 connection.close();
			 }
		
		return result;
	}
	
	public ArrayList loadSectionwiseStudentwithtransfer(String sectionscheduleid,String status) {
		ArrayList arraylist = null;
		try {
			log.info("invoking loadSectionwiseStudent for loading students based on sectionscheduleid and studentallocation status");
			  select_query = "SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid,s.createdby,sectiontransferlogid,case when transferaction is null then 'Not Transfered' else 'Transfered' end as transferstatus FROM candidateregister cm,personmaster pm,studentallocation s left outer join sectiontransferlog s1 on s.studentallocationid=s1.studentallocationid and s1.sectiontransferlogstatus='A' where cm.personid=pm.personid and s.studentallocationstatus in ('A') and s.sectionscheduleid='"+sectionscheduleid+"' and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'";
			//select_query = "SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.personid=pm.personid and s.studentallocationstatus in ('"+status+"') and cm.candidateregisterid=s.candidateregisterid and cm.candidateregisterstatus='A'";
			 System.out.println("loadSectionwiseStudent>>>sss>>.."+select_query);
			arraylist = common_data_object.getListMap(select_query);  
			log.info("Query :"+select_query);
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	
	CommonDataAccess common_data_object;
	//DateTime datetime;
	DateTime	datetime				= new DateTime();

	String select_query;
	
}