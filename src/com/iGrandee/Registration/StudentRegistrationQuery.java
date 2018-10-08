package com.iGrandee.Registration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

// Referenced classes of package com.iGrandee.Common:
//            CommonDataAccess

public class StudentRegistrationQuery {
	static Logger log = Logger.getLogger(StudentRegistrationQuery.class);

	public StudentRegistrationQuery() {
		common_data_object = new CommonDataAccess();
		select_query = null;
		}

	public int checkUser(String s, String s1) {	
		int i = 0;
		try {
			ArrayList arraylist = null;
			select_query = "select * from login where username='" + s + "'";
			log.info(select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info(arraylist);
			if (arraylist != null && arraylist.size() > 0) {
				i = 1;
			}
			select_query = null;
		} catch (Exception exception) {
		}
		return i;
	}
	
	
	
	public ArrayList loadReligion(String instituteid) {
		ArrayList arraylist = null;

		try {
			
			select_query 	= "SELECT c.religionid,c.religionname FROM religion c where c.instituteid='"+instituteid+"' and c.relistatus='A'";
			arraylist 		= common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
	
	public ArrayList loadcommunity(String instituteid) {
		ArrayList arraylist = null;

		try {
			
			select_query 	= "SELECT c.communityid,c.communityname FROM community c where c.instituteid='"+instituteid+"' and c.commstatus='A'";
			arraylist 		= common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
	
	
	// Loaded Scholarship Name for Student bulk entry process - 08/Aug/2013  - Sindhu.V
	public ArrayList loadscholarshipname11(String standardid) {
		ArrayList arraylist = null;

		try {
			
			select_query 	= "select b.scholarshipamountallocationid, a.scholarshipname from scholarship a, scholarshipamountallocation b where b.standardscheduleid='"+standardid+"' and a.scholarshipid=b.scholarshipid and b.amountallocationstatus='A' and a.scholarshipstatus='A';";
			arraylist 		= common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
	
	public ArrayList loadscholarshipname(String termfeesid) {
		ArrayList arraylist = null;

		try {
			
			select_query 	= "select b.scholarshipname,a.scholarshipamountallocationid from scholarshipamountallocation a,scholarship b where termfeesid='"+termfeesid+"' and a.scholarshipid=b.scholarshipid";
			arraylist 		= common_data_object.getListMap(select_query);
			System.out.println("select_query in Scholardhip===>>>"+select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
	
	
	
	
	/**
	 * This method is used to check the student application status created by kumaran ramu
	 * @param applicationno
	 * @return List of details to check about the application no.
	 */
	
	public ArrayList checkStudentDetails(String applicationno) {
		ArrayList arraylist = null;

		try {

			select_query 	= "select c.studentapprovalid,c.standardscheduleid, case when (select studentapprovalid from candidateregister where studentapprovalid=c.studentapprovalid and candidateregisterstatus='A') is null then 'Not Entered' else 'Entered' end as status  from applicationissue a, registration b,studentapproval c where a.applicationno='"+applicationno+"' and a.applicationid=b.applicationid and b.registrationid=c.registrationid and a.status='A' and b.status='A' and c.approvalstatus='A'";
			arraylist 		= common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}	
	
	
	
	public String loadstudentstate(String studentapprovalid) {
		String retstring = null;

		try {
			System.out.println("i am here buddy");
			select_query = "select a.studentallocationstatus from studentallocation a,candidateregister b where a.candidateregisterid=b.candidateregisterid and b.studentapprovalid='"+studentapprovalid+"'"; 
			retstring = common_data_object.getString(select_query);
			System.out.println("select_queryselect_query==========>>>>>"+select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return retstring;
	}
	public ArrayList apllicantdetails(String applicationno) {
		ArrayList arraylist = null;

		try {
			select_query = "select distinct d.standardscheduleid,e.studentapprovalid,e1.standardname,case when d1.groupid is null then 'NoGroup' else (select a11.groupname from standardgroup a11 where a11.groupid=d1.groupid)  end as groupname,b.registrationid as regId,b.standardpublishid,date_format(b.dateofcreation,'%d-%m-%Y') as dateofregistration,a.applicantname,a.applicationno,e.registrationid,case when f.candidateregisterid is null then 'NotRegistered' else 'Registered' end as candidateregisterstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.applicationno='"+applicationno+"' and a.status='A' and b.status='A' join standardschedule d1 on d1.standardscheduleid=b.standardpublishid and d1.stdschedulestatus='A' join standard e1 on d1.standardid=e1.standardid and e1.standardstatus='A' join standardgroup f1 on f1.groupstatus='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' left outer join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'"; 
			//select_query = "SELECT distinct c.studentapprovalid,d.standardscheduleid,a.applicantname,e.standardname,	case when d.groupid is null then 'NoGroup' else (select a1.groupname from standardgroup a1 where a1.groupid=d.groupid)  end as groupname,a.applicationno		FROM applicationissue a,		registration b,studentapproval c,standardschedule d,standard e,		standardgroup f	where a.applicationid=b.applicationid and b.registrationid=c.registrationid and		a.applicationno='"+applicationno+"' and c.standardscheduleid=d.standardscheduleid and d.standardid=e.standardid and		a.status='A' and b.status='A' and c.approvalstatus='A' and		d.stdschedulestatus='A' and e.standardstatus='A' and f.groupstatus='A'";
			//select_query = "SELECT a.applicantname,e.standardname,f.groupname,b.registrationid FROM applicationissue a,registration b,studentapproval c,standardschedule d,standard e,`group` f	where a.applicationid=b.applicationid and b.registrationid=c.registrationid and a.applicationno='"+applicantid+"' and c.standardscheduleid=d.standardscheduleid and d.standardid=e.standardid and d.groupid=f.groupid	and a.status='A' and b.status='A' and c.approvalstatus='A' and d.stdschedulestatus='A' and e.standardstatus='A' and f.groupstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			log.info("select_queryselect_query==========>>>>>"+select_query);
			System.out.println(select_query);
			
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
	

	public ArrayList relationcheck(String rollno) {
		ArrayList parentlist = null;

		try {
			select_query = "SELECT c.parentid,d.parentusername,e.fathername,e.mothername,case when middlename='-' or middlename='' or middlename  is null then concat(firstname,' ',lastname) else concat(firstname,' ',middlename,' ',lastname) end as uname,imagepath FROM studentallocation a ,candidateregister b,studentparent c,parentlogin d,personmaster e,login lo where a.candidateregisterid=b.candidateregisterid and b.personid=lo.personid and c.userid=lo.userid and  c.parentid=d.parentloginid and a.rollno='"+rollno+"' and e.personid=b.personid";
			parentlist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+select_query);
			
		} catch (Exception exception) {
		}
		return parentlist;
	}
	public long maxuseridcount() {
		long count = 0L;
		try {
			count = common_data_object.fmaxId("select max(userid) from login");
		} catch (Exception exception) {
		}
		return count;
	}	

	public String getpersonidviseallocationid(String approvalid) {
		String result = "";
		try {
			//log.info("approvalid=======>>>>>>"+approvalid);
			result = common_data_object.getString("SELECT personid FROM studentallocation s,candidateregister c where s.candidateregisterid=c.candidateregisterid and s.studentallocationid='"+approvalid+"' and c.candidateregisterstatus='A' and s.studentallocationstatus='A'");
			//log.info(result);
		} catch (Exception exception) {
		}
		return result;
	}
	public String getpersonidviseapprovalid(String approvalid) {
		String result = "";
		try {
			result = common_data_object.getString("SELECT personid FROM candidateregister a where a.studentapprovalid='"+approvalid+"' and candidateregisterstatus='A'");
		} catch (Exception exception) {
		}
		return result;
	}
	public ArrayList Studentpersondetails(String personid) {
		ArrayList arraylist = null;
		try {
			
			select_query = "SELECT prefix,mobilenumber,case when middlename='-' or middlename='' or middlename  is null then concat(prefix,firstname,' ',lastname) else concat(prefix,firstname,' ',middlename,' ',lastname) end as uname,firstname,middlename,lastname, fathername, mothername,DATE_FORMAT(p.dob,'%d-%b-%Y') as dob,age,sex,landlinenumber, emailid, imagepath,nationality,case when (select r.religionname from  religion r  where  r.religionid=p.religion) is null then '-' else (select r.religionname from  religion r  where  r.religionid=p.religion) end as religion,case when (select c.communityname from community c  where c.communityid=p.community) is null then '-' else  (select c.communityname from community c  where c.communityid=p.community) end as community,language,bloodgroup,p.community as communityid,p.religion as religionid FROM personmaster p where personid='"+personid+"' and  p.status='A'";
			//System.out.println("select_query "+select_query);
			arraylist = common_data_object.getListMap(select_query);

		} catch (Exception exception) {
		}
		return    arraylist;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/RegisteredStudentList.jsp 
	 * load Standard
	 * used by maruthu
	 */
	public ArrayList loadstandard(String boardid,String sessionid,String instituteid) {
		ArrayList arraylist = null;
		try {
			
			select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	 and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid";
			arraylist = common_data_object.getListMap(select_query);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/RegisteredStudentList.jsp
	 * load Student
	 * Used  by maruthu
	 */
	
	/*modified date 5-8-2013 by V.Selvakumar
	 * allocation status had been added
	 * 
	 */
	public ArrayList loadstudentsessionandstandardvise(String standardscheduleidid,String sessionid,String instituteid) {
		ArrayList arraylist = null;
		try {
		
/*	select_query="select f.studentapprovalid, f.candidateregisterid, case when f.candidateregisterid is null then 'notallocated' else 'allocated' end as " +
	"allocationstatus,c.sessionstatus,e.studentapprovalid,b.registrationid,b.standardpublishid,date_format(b.dateofcreation,'%d-%m-%Y') as dateofregistration,a.applicantname," +
	"a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and  a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionid+"'" +
	" and b.standardpublishid='"+standardscheduleidid+"' and a.instituteid='"+instituteid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid" +
	" and c.sessionstatus in ('A','R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on " +
	"e.registrationid=b.registrationid and e.approvalstatus='A' left outer join candidateregister f on f.studentapprovalid=e.studentapprovalid and" +
	" f.candidateregisterstatus='A'";*/
			
		//	select_query = "select  a.applicationid,f.personid,g.studentallocationid,f.studentapprovalid, f.candidateregisterid,case when g.studentallocationid is null then 'notallocated' else 'Allocated' end as allocationstatus,g.studentallocationstatus,c.sessionstatus,e.studentapprovalid,b.registrationid,b.standardpublishid,date_format(b.dateofcreation,'%d-%m-%Y') as dateofregistration,a.applicantname,a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and  a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionid+"' and b.standardpublishid='"+standardscheduleidid+"' and a.instituteid='"+instituteid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus in ('A','R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on  f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'  left outer join studentallocation g on f.candidateregisterid=g.candidateregisterid and g.studentallocationstatus='A'";
			select_query = "select  a.applicationid,f.personid,g.studentallocationid,f.studentapprovalid, f.candidateregisterid,case when g.studentallocationid is null then 'notallocated' else 'Allocated' end as allocationstatus,g.studentallocationstatus,c.sessionstatus,e.studentapprovalid,b.registrationid,b.standardpublishid,date_format(b.dateofcreation,'%d-%m-%Y') as dateofregistration,a.applicantname,a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and  a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionid+"' and b.standardpublishid='"+standardscheduleidid+"' and a.instituteid='"+instituteid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus in ('A','R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on  f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'  left outer join studentallocation g on f.candidateregisterid=g.candidateregisterid";
			log.info("loadstudentsessionandstandardvise>>>"+select_query);
			System.out.println("loadstudentsessionandstandardvise>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) {  
			exception.printStackTrace();
		}
		return    arraylist;
	}
	public ArrayList Studentcontactdetails(String personid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT  communicationstreet1,communicationstreet2, communicationstate, communicationcountry, communicationcity, communicationpin, permanentstreet1,permanentstreet2,permanentstate, permanentcountry, permanentcity, permanentpin,smscontactno FROM personaddress p where p.personid='"+personid+"' and p.peraddstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
		}
		return arraylist;
	}
	
	/**
	 * load Parent Guardian profile for updation
	 * @param personid
	 * @return 
	 */
	public ArrayList parentguardianprofileupdate(String personid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT b.candidateregisterid,a.studentguardianid, a.personid, a.guardianname, a.relation, a.self, a.nameoforganization, a.annualincome,a.position, a.createdby, a.dateofcreation, a.ipaddress, a.studentguardianstatus,b.physicallyfit,b.exserviceman,b.physicalmark,a.guardianmailid FROM studentguardian a,candidateregister b where a.personid='"+personid+"' and a.studentguardianstatus='A' and a.personid=b.personid and b.candidateregisterstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
		}
		return arraylist;
	}
	
	public ArrayList Studentcontactwithemaildetails(String personid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT a.mobilenumber,b.communicationstreet1,b.communicationstreet2, b.communicationstate, b.communicationcountry, b.communicationcity, b.communicationpin, b.permanentstreet1, b.permanentstreet2,b.permanentstate, b.permanentcountry, b.permanentcity, b.permanentpin,b.smscontactno,a.landlinenumber, a.emailid FROM personaddress b ,personmaster a where a.personid=b.personid and a.personid='"+personid+"' and b.peraddstatus='A' and a.status='A'";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
		}
		return arraylist;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/RegisteredStudentList.jsp 
	 * load Academic year
	 * used by maruthu
	 */
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
	
	
		/**
	 * This method is accessed from /kycportal/jsp/Registration/StudentApplicationEntry.jsp
	 * used to access extracurricular activity for student registration 
	 * @param userid from login
	 * used by kumaran
	 */
	public ArrayList loadExtrcurricular(String userid) {
		ArrayList arraylist = null;

		try {
			select_query 	= "SELECT extracurricularactivityid,extracurricularname FROM extracurricularactivity  where createdby='"+userid+"' and extracurricularstatus='A'";
			arraylist 		= common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
		}
		return arraylist;
	}	
	
	public ArrayList loadScholarshipDetails(String personid, String standardscheduleid) {
		ArrayList arraylist = null;

		try {
			
		//	select_query 	= "select b.termfeesid,b.scholarshipamountallocationid, a.scholarshipname, b.amount, c.schemeforstudentid from scholarship a, scholarshipamountallocation b left outer join scholarshipforstudent c on b.scholarshipamountallocationid=c.scholarshipamountallocationid and c.scholarshipforstudentstatus='A' and c.userid in (select userid from login where personid='"+personid+"' and loginstatus='A') where b.standardscheduleid='"+standardscheduleid+"' and a.scholarshipid=b.scholarshipid and b.amountallocationstatus='A' and a.scholarshipstatus='A'";
		//	select_query 	= "select e.termname,b.termfeesid,b.scholarshipamountallocationid, a.scholarshipname, b.amount, c.schemeforstudentid from feestermname e,termfees d,scholarship a,scholarshipamountallocation b left outer join scholarshipforstudent c on b.scholarshipamountallocationid=c.scholarshipamountallocationid  and c.scholarshipforstudentstatus='A' and c.userid in (select userid from login where personid='"+personid+"' and loginstatus='A') where b.standardscheduleid='"+standardscheduleid+"' and a.scholarshipid=b.scholarshipid and b.amountallocationstatus='A' and a.scholarshipstatus='A' and d.termfeesid=b.termfeesid and e.termid=d.termid and e.termstatus='A'";
			select_query 	= "select x1.feescollectionid,e.termname,b.termfeesid,b.scholarshipamountallocationid, a.scholarshipname, b.amount, c.schemeforstudentid from feestermname e,termfees d,scholarship a,scholarshipamountallocation b left outer join scholarshipforstudent c on b.scholarshipamountallocationid=c.scholarshipamountallocationid and c.scholarshipforstudentstatus='A' and c.userid in (select userid from login where personid='"+personid+"' and loginstatus='A') left outer join feescollection x1 on x1.schemeforstudentid=c.schemeforstudentid where    b.standardscheduleid='"+standardscheduleid+"' and a.scholarshipid=b.scholarshipid and b.amountallocationstatus='A' and a.scholarshipstatus='A' and d.termfeesid=b.termfeesid and e.termid=d.termid and e.termstatus='A'  order by b.termfeesid";
			//System.out.println(select_query);
			arraylist 		= common_data_object.getListMap(select_query);

			
		} catch (Exception exception) {
		}
		return arraylist;
	}	
	
	/**
 * This method is accessed from /kycportal/jsp/Registration/StudentApplicationEntry.jsp
 * used to access extracurricular activity for student registration 
 * @param userid from login
 * used by kumaran
 */
public ArrayList loadScholarship(String standardscheduleid) {
	ArrayList arraylist = null;

	try {
		//select_query = "select b.termfeesid,b.amount,b.scholarshipamountallocationid, a.scholarshipname from scholarship a, scholarshipamountallocation b where b.standardscheduleid='"+standardscheduleid+"' and a.scholarshipid=b.scholarshipid and b.amountallocationstatus='A' and a.scholarshipstatus='A'";
		select_query = "select termname,b.termfeesid,b.amount,b.scholarshipamountallocationid, a.scholarshipname from scholarship a, scholarshipamountallocation b,termfees c,feestermname d where b.standardscheduleid='"+standardscheduleid+"' and a.scholarshipid=b.scholarshipid and b.amountallocationstatus='A'  and a.scholarshipstatus='A' and c.termfeesid=b.termfeesid and c.termfeesstatus='A' and c.termid=d.termid and d.termstatus='A' order by termfeesid";
		System.out.println(select_query);
		arraylist = common_data_object.getListMap(select_query);
		
	} catch (Exception exception) {
	}
	return arraylist;
}	
	
	
	
	
	/**
	 * This method is accessed from /kycportal/jsp/Registration/Studentprofileview.jsp
	 * used to access extracurricular activity for student Profile view 
	 * @param extracurricularactivityid seperated by ,
	 * used by kumaran
	 */
	public ArrayList loadExtrcurricularProfileView(String extraids) {
		ArrayList arraylist = null;
		try {
			select_query = "SELECT extracurricularname FROM extracurricularactivity  where find_in_set(extracurricularactivityid,'"+extraids+"') and extracurricularstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			//System.out.println("============="+select_query);
			
		} catch (Exception exception) {
		}
		return arraylist;
	}		

	

	public ArrayList Studentguardiandetails(String personid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT  guardianname, relation, self, nameoforganization, annualincome, position, guardianmailid FROM studentguardian s where s.personid='"+personid+"' and s.studentguardianstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
		}
		return arraylist;
	}
	public ArrayList Studentregisterdetails(String personid) {
		ArrayList arraylist = null;   

		try {
			//select_query = "SELECT physicallyfit, exserviceman, physicalmark, previousschoolname, previousschooladdress, mediumstudied, tc, cc, splcategory, medicalcertificate, marksheet, sportscertificate,studextracurricular,previousschoolhistory,sec.sectionname,s.standardname,ys.sessionname FROM candidateregister c,standardschedule ss,standard s,yearofsession ys,sectionschedule secs,studentallocation sa,section sec where c.personid='"+personid+"' and s.standardid=ss.standardid and candidateregisterstatus='A'  and  ss.standardscheduleid=secs.standardscheduleid and ss.sessionid=ys.sessionid and ss.stdschedulestatus='A' and s.standardstatus='A' and ys.sessionstatus='A' and sa.candidateregisterid=c.candidateregisterid and secs.sectionscheduleid=sa.sectionscheduleid and sec.sectionid=secs.sectionid and sec.status='A' and secs.sectionschedulestatus='A' and sa.studentallocationstatus='A'";
			select_query = "SELECT ss.standardscheduleid,physicallyfit, exserviceman, physicalmark,previousschoolname,case when  previousschooladdress is null then '-' else previousschooladdress end as previousschooladdress, mediumstudied,tc, cc, splcategory, medicalcertificate, marksheet,sportscertificate,studextracurricular,previousschoolhistory,s.standardname,ys.sessionname,case when  sec.sectionname is null then '-' else sec.sectionname end as sectionname ,b.boardname,sm.mediumname"
								+" FROM candidateregister c join studentapproval sa on  sa.studentapprovalid=c.studentapprovalid and c.personid='"+personid+"' and sa.approvalstatus='A' and c.candidateregisterstatus='A'"
								+" join standardschedule ss on ss.standardscheduleid=sa.standardscheduleid and ss.stdschedulestatus='A'"
								+" join standard s on s.standardid=ss.standardid and s.standardstatus='A'"
								+" join yearofsession ys on ss.sessionid=ys.sessionid and ys.sessionstatus in ('A','R')"
								+" join board b on b.boardid=s.boardid and b.boardstatus='A'"
								+" join standardmedium sm on sm.mediumid=b.mediumid and sm.mediumstatus='A'"
								+" left outer join  studentallocation sal on sal.candidateregisterid =c.candidateregisterid and sal.studentallocationstatus='A'"
								+" left outer join  sectionschedule secs on secs.sectionscheduleid=sal.sectionscheduleid and secs.sectionschedulestatus='A'"
								+" left outer join  section sec on sec.sectionid=secs.sectionid and sec.status='A'";
			
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	public ArrayList Studentdetails(String personid,String sessionid,String status) {
		ArrayList arraylist = null;

		try {
			//select_query = "SELECT physicallyfit, exserviceman, physicalmark, previousschoolname, previousschooladdress, mediumstudied, tc, cc, splcategory, medicalcertificate, marksheet, sportscertificate,studextracurricular,previousschoolhistory,sec.sectionname,s.standardname,ys.sessionname FROM candidateregister c,standardschedule ss,standard s,yearofsession ys,sectionschedule secs,studentallocation sa,section sec where c.personid='"+personid+"' and s.standardid=ss.standardid and candidateregisterstatus='A'  and  ss.standardscheduleid=secs.standardscheduleid and ss.sessionid=ys.sessionid and ss.stdschedulestatus='A' and s.standardstatus='A' and ys.sessionstatus='A' and sa.candidateregisterid=c.candidateregisterid and secs.sectionscheduleid=sa.sectionscheduleid and sec.sectionid=secs.sectionid and sec.status='A' and secs.sectionschedulestatus='A' and sa.studentallocationstatus='A'";
			/*select_query = "SELECT physicallyfit, exserviceman, physicalmark,previousschoolname,case when  previousschooladdress is null then '-' else previousschooladdress end as previousschooladdress, mediumstudied,tc, cc, splcategory, medicalcertificate,marksheet,sportscertificate,studextracurricular,previousschoolhistory,s.standardname,ys.sessionname,case when  sec.sectionname is null then '-' else sec.sectionname end as sectionname"
							+" FROM   candidateregister c join   studentapproval sa on  sa.studentapprovalid=c.studentapprovalid and    sa.approvalstatus='A' and c.personid='"+personid+"' and    c.candidateregisterstatus='A'"
							+" join   studentallocation sal on sal.candidateregisterid =c.candidateregisterid and   ";
			if(status.equals("R"))
			select_query +=" sal.studentallocationstatus in ('A','D','C')";
			else
				select_query +=" sal.studentallocationstatus in ('A')";

			select_query += " join   sectionschedule secs on secs.sectionscheduleid=sal.sectionscheduleid and    secs.sectionschedulestatus='A'"
							+" join   section sec on sec.sectionid=secs.sectionid and sec.status='A' join   standardschedule ss on ss.standardscheduleid =secs.standardscheduleid"
							+" and    ss.stdschedulestatus='A'  join standard s on s.standardid=ss.standardid and    s.standardstatus='A'"
							+" join   yearofsession ys on ss.sessionid=ys.sessionid and ss.sessionid='"+sessionid+"'"  
							+" and    ys.sessionstatus in ('"+status+"');";*/
			
			select_query = "SELECT ss.standardscheduleid,physicallyfit, exserviceman, physicalmark,previousschoolname,case when  previousschooladdress is null then '-' else previousschooladdress end as previousschooladdress, mediumstudied,tc, cc, splcategory, medicalcertificate,marksheet,sportscertificate,studextracurricular,previousschoolhistory,case when ss.groupid is null then s.standardname else concat(s.standardname,' - ',(select sg.groupname from standardgroup sg where sg.groupid=ss.groupid and sg.groupstatus='A')) end as standardname,ys.sessionname,case when  sec.sectionname is null then '-' else sec.sectionname end as sectionname,b.boardname,sm.mediumname"
				+" FROM   candidateregister c join   studentapproval sa on  sa.studentapprovalid=c.studentapprovalid and    sa.approvalstatus='A' and c.personid='"+personid+"' and    c.candidateregisterstatus='A'"
				+" join   studentallocation sal on sal.candidateregisterid =c.candidateregisterid and   ";
				if(status.equals("R"))
				select_query +=" sal.studentallocationstatus in ('A','D','C')";
				else
					select_query +=" sal.studentallocationstatus in ('A')";
				
				select_query += " join   sectionschedule secs on secs.sectionscheduleid=sal.sectionscheduleid and    secs.sectionschedulestatus='A'"
				+" join   section sec on sec.sectionid=secs.sectionid and sec.status='A' join   standardschedule ss on ss.standardscheduleid =secs.standardscheduleid"
				+" and    ss.stdschedulestatus='A'  join standard s on s.standardid=ss.standardid and    s.standardstatus='A'"
				+" join   yearofsession ys on ss.sessionid=ys.sessionid and ss.sessionid='"+sessionid+"'"
				+" join board b on b.boardid=s.boardid and b.boardstatus='A'"
				+" join standardmedium sm on sm.mediumid=b.mediumid and sm.mediumstatus='A'"
				+" and    ys.sessionstatus in ('"+status+"');";

			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+select_query);
			System.out.println("==========>>>>>"+select_query);

		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	public ArrayList Studentqualificationdetails(String personid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT subject, monthandyear, registrationno, marksscored, maxmarks,studentqualificationid FROM studentqualification s where s.userid='"+personid+"' and  s.studqualificationstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	public ArrayList Studentaccountdetails(String personid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT username FROM login l where personid='"+personid+"' and loginstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	
	public ArrayList Studentscholarshipdetails(String personid, String standardscheduleid) {
		ArrayList arraylist = null;

		try {
			select_query 	= "select b.scholarshipamountallocationid, a.scholarshipname, b.amount from scholarship a, scholarshipamountallocation b, scholarshipforstudent c, login d  where b.standardscheduleid='"+standardscheduleid+"' and a.scholarshipid=b.scholarshipid and b.amountallocationstatus='A' and a.scholarshipstatus='A' and b.scholarshipamountallocationid=c.scholarshipamountallocationid and c.userid=d.userid and d.personid='"+personid+"' and d.loginstatus='A' and scholarshipforstudentstatus='A'";
			arraylist 		= common_data_object.getListMap(select_query);
			System.out.println(select_query);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}	
	
	
	/*
	 * This method is accessed in /Kycportal/Registration/RegisteredStudentList.jsp
	 * load Board
	 * used  by maruthu
	 */
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

		
	
		// Modified by Subhash in order to send mail soon after the registration.
		// after finally block
		
		public int StudentRegistration(StudentRegistrationBean beanobj) throws SQLException {
		int result = 0;
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		PreparedStatement pstmt6 = null;
		PreparedStatement pstmt7 = null;
		PreparedStatement pstmt8 = null;
		PreparedStatement fessaddstmt = null;
		long max_feescolid = 0;
		PreparedStatement feescolmaxstmt 	= null;
		ResultSet feesmaxrs 				= null;
	 	log.info("invoking StudentRegistration for Student Insertion");

		String Query = "";
		Connection connection = null;

		try {
			if(common_data_object.checkDuplicate("login", "username", beanobj.getStudentusername()))
			{
				result=1000;
			}
			else if(common_data_object.checkDuplicate("parentlogin", "parentusername", beanobj.getParentusername()))
			{
				result=1001;
			}
			else
			{
				String parentid=beanobj.getParentid()+"";
				long max_parentloginid =0l;
				long max_userid = common_data_object.fmaxId("select max(userid) from login");
				long max_personid = common_data_object.fmaxId("select max(personid) from personmaster");
				long max_studentguardianid = common_data_object.fmaxId("select max(studentguardianid) from studentguardian");
				long max_candidateregisterid = common_data_object.fmaxId("select max(candidateregisterid) from candidateregister");
				long max_studentqualificationid = common_data_object.fmaxId("select max(studentqualificationid) from studentqualification");
				
				long max_scholarshipid = common_data_object.fmaxId("select max(schemeforstudentid) from scholarshipforstudent");
				
				
				
				if(parentid.equals("nodatafound") || parentid.equals("null"))
					{
					 	max_parentloginid = common_data_object.fmaxId("select max(parentloginid) from parentlogin");
					}
				else
					{
						max_parentloginid=Long.parseLong(parentid);
					}
				log.info(max_parentloginid+ "===============max_parentloginid");
				long max_studentparentid = common_data_object.fmaxId("select max(studentparentid) from studentparent");
	
				long max_addressid = common_data_object.fmaxId("select max(addressid) from personaddress");
	
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				// connection = ConnectionManager.getKycConnection();
				Query = "insert into personmaster(personid,firstname, fathername, mothername,dob, landlinenumber, emailid, imagepath, dateofcreation, createdby, ipaddress, instituteid, status,nationality, religion, community,language,bloodgroup, middlename, lastname,age,sex,prefix,mobilenumber) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = connection.prepareStatement(Query);
				pstmt.setLong(1, max_personid);
				pstmt.setString(2, beanobj.getApplicantname().trim());
				pstmt.setString(3, beanobj.getFathername().trim());
				pstmt.setString(4, beanobj.getMothername().trim());
				pstmt.setString(5, beanobj.getDob());
				pstmt.setString(6, beanobj.getLandlinenumber());
				pstmt.setString(7, beanobj.getEmailid());
				pstmt.setString(8, beanobj.getPhoto());
				pstmt.setString(9, datetime.showTime("databaseinsert"));
				pstmt.setString(10, beanobj.getCreatedby());
				pstmt.setString(11, beanobj.getIpaddress());
				pstmt.setString(12, beanobj.getInstituteid());
				pstmt.setString(13, "A");
				pstmt.setString(14, beanobj.getNationality());
				pstmt.setString(15, beanobj.getReligion());
				pstmt.setString(16, beanobj.getCommunity());
				pstmt.setString(17, beanobj.getLanguage());
				pstmt.setString(18, beanobj.getBloodgroup());
				pstmt.setString(19, beanobj.getStudmiddlename().trim());
				pstmt.setString(20, beanobj.getStudlastname().trim());
				pstmt.setString(21, beanobj.getStudage());
				pstmt.setString(22, beanobj.getStudsex());
				pstmt.setString(23, beanobj.getStudprefix());
				pstmt.setString(24, beanobj.getMobileno());
				result += pstmt.executeUpdate();
				log.info("personmaster================>>");
	
				Query = "insert into login(userid, username, password, usercategory, personid, dateofcreation, createdby, ipaddress, loginstatus) values(?,?,?,?,?,?,?,?,?)";
				pstmt1 = connection.prepareStatement(Query);
				pstmt1.setLong(1, max_userid);
				pstmt1.setString(2, beanobj.getStudentusername());
				
											
				//make the password is encrypted.
				String encpassword 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(beanobj.getStudentpassword());
				pstmt1.setString(3, encpassword);
				pstmt1.setString(4, "S");
				pstmt1.setLong(5, max_personid);
				pstmt1.setString(6, datetime.showTime("databaseinsert"));
				pstmt1.setString(7, beanobj.getCreatedby());
				pstmt1.setString(8, beanobj.getIpaddress());
				pstmt1.setString(9, "A");
				result += pstmt1.executeUpdate();
				log.info("login================>>");
	
				Query = "insert into personaddress(addressid, personid, communicationstreet1, communicationstate, communicationcountry, communicationcity, communicationpin, permanentstreet1,permanentstate, permanentcountry, permanentcity, permanentpin, dateofcreation, createdby, peraddstatus,communicationstreet2,permanentstreet2,smscontactno) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt7 = connection.prepareStatement(Query);
				pstmt7.setLong(1, max_addressid);
				pstmt7.setLong(2, max_userid);
				pstmt7.setString(3, beanobj.getStreet1());
				pstmt7.setString(4, beanobj.getState());
				pstmt7.setString(5, beanobj.getCountry());
				pstmt7.setString(6, beanobj.getCity());
				pstmt7.setString(7, beanobj.getZipcode());
				pstmt7.setString(8, beanobj.getPermanentstreet1());
				pstmt7.setString(9, beanobj.getPermanentstate());
				pstmt7.setString(10, beanobj.getPermanentcountry());
				pstmt7.setString(11, beanobj.getPermanentcity());
				pstmt7.setString(12, beanobj.getPermanentzipcode());
				pstmt7.setString(13, datetime.showTime("databaseinsert"));
				pstmt7.setString(14, beanobj.getCreatedby());
				pstmt7.setString(15, "A");
				pstmt7.setString(16, beanobj.getStreet2());
				pstmt7.setString(17, beanobj.getPermanentstreet2());
				pstmt7.setString(18, beanobj.getSmsContactNo());				

				result += pstmt7.executeUpdate();
				
				log.info("personaddress================>>");
	
				//Query = "insert into studentguardian(studentguardianid, personid, guardianname, relation, self, nameoforganization, annualincome, position, createdby, dateofcreation, ipaddress, studentguardianstatus) values(?,?,?,?,?,?,?,?,?,?,?,?)";
				//added guardian mail id
				Query = "insert into studentguardian(studentguardianid, personid, guardianname, relation, self, nameoforganization, annualincome, position, createdby, dateofcreation, ipaddress, studentguardianstatus,guardianmailid) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt2 = connection.prepareStatement(Query);
				pstmt2.setLong(1, max_studentguardianid);
				pstmt2.setLong(2, max_userid);
				pstmt2.setString(3, beanobj.getGuardianname());
				pstmt2.setString(4, beanobj.getGuardrelation());
				pstmt2.setString(5, beanobj.getGuardemployment());
				pstmt2.setString(6, beanobj.getNameoforg());
				pstmt2.setString(7, beanobj.getAnnualincome());
				pstmt2.setString(8, beanobj.getGuardposition());
				pstmt2.setString(9, beanobj.getCreatedby());
				pstmt2.setString(10, datetime.showTime("databaseinsert"));
				pstmt2.setString(11, beanobj.getIpaddress());
				pstmt2.setString(12, "A");
				pstmt2.setString(13, beanobj.getGuardianmailid());
				result += pstmt2.executeUpdate();
				log.info("studentguardian================>>");
				String schoolstatus= beanobj.getSchoolstatus();
						
				Query = "insert into candidateregister(candidateregisterid, studentapprovalid, standardscheduleid, personid, createdby, dateofcreation, ipaddress, candidateregisterstatus, physicallyfit, exserviceman, physicalmark, previousschoolname, previousschooladdress, mediumstudied, tc, cc, splcategory, medicalcertificate, marksheet, sportscertificate,studextracurricular,previousschoolhistory) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt3 = connection.prepareStatement(Query);
				pstmt3.setLong(1, max_candidateregisterid);
				pstmt3.setString(2,beanobj.getStudentapprovalid());
				pstmt3.setString(3, beanobj.getStandardscheduleid());
				pstmt3.setLong(4,max_userid);
				pstmt3.setString(5, beanobj.getCreatedby());
				pstmt3.setString(6, datetime.showTime("databaseinsert"));
				pstmt3.setString(7, beanobj.getIpaddress());
				pstmt3.setString(8, "A");
				pstmt3.setString(9, beanobj.getPhysicallyChallenge());
				pstmt3.setString(10, beanobj.getExServiceman());
				pstmt3.setString(11, beanobj.getPhysicalmarks());
				pstmt3.setString(12, beanobj.getPreviousSchoolDetails());
				pstmt3.setString(13, beanobj.getPreviousSchooladdress());
				pstmt3.setString(14, beanobj.getPreviousSchoolmedium());
				pstmt3.setString(15, beanobj.getTccheck());
				pstmt3.setString(16, beanobj.getCccheck());
				pstmt3.setString(17,beanobj.getSccheck());
				pstmt3.setString(18, beanobj.getMccheck());
				pstmt3.setString(19, beanobj.getMscheck());
				pstmt3.setString(20, beanobj.getSpccheck());
				pstmt3.setString(21, beanobj.getExtraCurricular());
				pstmt3.setString(9, beanobj.getPhysicallyChallenge());
				pstmt3.setString(10, beanobj.getExServiceman());
				pstmt3.setString(11, beanobj.getPhysicalmarks());
				pstmt3.setString(12, beanobj.getPreviousSchoolDetails());
				pstmt3.setString(13, beanobj.getPreviousSchooladdress());
				pstmt3.setString(14, beanobj.getPreviousSchoolmedium());
				pstmt3.setString(15, beanobj.getTccheck());
				pstmt3.setString(16, beanobj.getCccheck());
				pstmt3.setString(17,beanobj.getSccheck());
				pstmt3.setString(18, beanobj.getMccheck());
				pstmt3.setString(19, beanobj.getMscheck());
				pstmt3.setString(20, beanobj.getSpccheck());
				pstmt3.setString(21, beanobj.getExtraCurricular());
				pstmt3.setString(22, beanobj.getSchoolstatus());
	
				result += pstmt3.executeUpdate();
				log.info("candidateregister================>>");
				
				if(schoolstatus.equals("yes"))
				{
					String subject []= beanobj.getSubject();
					String monthyear []= beanobj.getMonthyear();
					String Registionno []= beanobj.getRegistionno();
					
					String Markscored []= beanobj.getMarkscored();
					String Maxmark []= beanobj.getMaxmark();
		
						if(subject.length>0)
						{
							for(int i=0;i<subject.length;i++)
							{
								Query = "insert into studentqualification(studentqualificationid, subject, monthandyear, registrationno, marksscored, maxmarks, userid, createdby, dateofcreation, studqualificationstatus) values(?,?,?,?,?,?,?,?,?,?)";
								pstmt4 = connection.prepareStatement(Query);
								pstmt4.setLong(1, max_studentqualificationid);
								pstmt4.setString(2, subject[i]);
								pstmt4.setString(3, monthyear[i]);
								pstmt4.setString(4, Registionno[i]);
								pstmt4.setString(5,Markscored[i]);
								pstmt4.setString(6, Maxmark[i]);
								pstmt4.setLong(7, max_userid);
								pstmt4.setString(8, beanobj.getCreatedby());
								pstmt4.setString(9, datetime.showTime("databaseinsert"));
								pstmt4.setString(10,"A");
								result += pstmt4.executeUpdate();
								max_studentqualificationid++;
							}
						}
				}
				log.info("studentqualification================>>"+result);
	
				
				log.info("max_parentloginid================>>"+max_parentloginid);
				if(parentid.equals("nodatafound") || parentid.equals("null"))
				{
				Query = "insert into parentlogin(parentloginid, parentusername, parentpassword, dateofcreation, createdby, parentstatus) values(?,?,?,?,?,?)";
				pstmt6 = connection.prepareStatement(Query);
				pstmt6.setLong(1, max_parentloginid);
				pstmt6.setString(2,beanobj.getParentusername());
				
				//pstmt6.setString(3,beanobj.getParentpassword());
				//make the password is encrypted.
				String parentpassword = com.iGrandee.Common.PasswordService.getInstance().encrypt(beanobj.getParentpassword());
				parentpassword = parentpassword;
				
				pstmt6.setString(3,parentpassword);
				pstmt6.setString(4, datetime.showTime("databaseinsert"));
				pstmt6.setString(5,beanobj.getCreatedby());
				pstmt6.setString(6,"A");
					
				result += pstmt6.executeUpdate();
				log.info("parentlogin================>>");
				}
				//log.info("max_studentparentid================>>"+max_studentparentid);
	
				Query = "insert into studentparent(studentparentid, userid, parentid, dateofcreation, studentparentstatus) values(?,?,?,?,?)";
				pstmt5 = connection.prepareStatement(Query);
				pstmt5.setLong(1, max_studentparentid);
				pstmt5.setLong(2,max_userid);
				pstmt5.setLong(3,max_parentloginid);
				pstmt5.setString(4, datetime.showTime("databaseinsert"));
				pstmt5.setString(5,"A");
						
				result += pstmt5.executeUpdate();
				
				
				
				Query		= "insert into scholarshipforstudent(schemeforstudentid, scholarshipamountallocationid, userid, createdby, dateofcreation, scholarshipforstudentstatus,studentapprovalid) values(?, ?, ?, ?, ?, ?,?)";
				pstmt8 		= connection.prepareStatement(Query);
				
				feescolmaxstmt			= connection.prepareStatement("select max(feescollectionid) from feescollection");
				feesmaxrs= feescolmaxstmt.executeQuery();
				
				if(feesmaxrs.next()){
					max_feescolid = feesmaxrs.getLong(1);
				}
				
				max_feescolid++;
				
				fessaddstmt = connection.prepareStatement("insert into feescollection(feescollectionid,termfeesid,studentapprovalid,bankname,ddno,dddate,collectionamount,scholarshipid,pendingstatus,createdby,feescollectiondate,feescollectionstatus,paymenttype,schemeforstudentid) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				if(beanobj.getScholarshipallocation() != null && beanobj.getScholarshipallocation().length>0){
					for(int y=0;y<beanobj.getScholarshipallocation().length;y++){

						pstmt8.setLong(1, max_scholarshipid);
						pstmt8.setString(2, beanobj.getScholarshipallocation()[y]);
						pstmt8.setLong(3, max_userid);
						pstmt8.setString(4,beanobj.getCreatedby());
						pstmt8.setString(5, DateTime.showTime("databaseinsert"));
						pstmt8.setString(6, "A");
						pstmt8.setString(7, beanobj.getStudentapprovalid());
						
						pstmt8.addBatch();
						
						fessaddstmt.setLong(1,max_feescolid);//feescollectionid
						fessaddstmt.setString(2,beanobj.getTermfeesid()[y]);//termfeesid
						fessaddstmt.setString(3,beanobj.getStudentapprovalid());//studentapprovalid
						fessaddstmt.setString(4,"-");//bankname
						fessaddstmt.setString(5,"-");//ddno	
						fessaddstmt.setString(6,null);//dddate
						fessaddstmt.setString(7,beanobj.getAmount()[y]);//collectionamount
						fessaddstmt.setString(8,null);//scholarshipid
						fessaddstmt.setString(9,"-");//pendingstatus
						fessaddstmt.setString(10,beanobj.getCreatedby());//createdby
						fessaddstmt.setString(11, DateTime.showTime("databaseinsert"));//feescollectiondate
						fessaddstmt.setString(12,"A");//feescollectionstatus 
						fessaddstmt.setString(13,"SCHOLAR");//paymenttype
						fessaddstmt.setLong(14,max_scholarshipid);//schemeforstudentid	
						System.out.println("fessaddstmt-->"+fessaddstmt);
						fessaddstmt.addBatch();
						
						max_feescolid++;
						
						
						max_scholarshipid++;
					}
				}
				pstmt8.executeBatch();
				fessaddstmt.executeBatch();
				
				
				
	
				connection.commit();
			}
			
		} catch (Exception exception) {
			if (connection != null)
			{
				connection.rollback();
			}
				log.error("",exception);
				exception.printStackTrace();
			return 0;
		} finally {
			
			if (feesmaxrs != null)
				feesmaxrs.close();

			if(fessaddstmt!=null)
				fessaddstmt.close();

			
			if (pstmt != null)
				pstmt.close();

			if (pstmt1 != null)
				pstmt1.close();

			if (pstmt2 != null)
				pstmt2.close();

			if (pstmt3 != null)
				pstmt3.close();
			
			if (pstmt4 != null)
				pstmt4.close();
			
			if (pstmt5 != null)
				pstmt5.close();
			
			if (pstmt6 != null)
				pstmt6.close();
			
			if (pstmt7 != null)
				pstmt7.close();
			
			if (connection != null)
				connection.close();
			
		}
		
		if(result>0){
			com.iGrandee.SendMail.SendMail sendMail = new com.iGrandee.SendMail.SendMail();
			String dobMail = "";
			dobMail = common_data_object.getString("select date_format('"+beanobj.getDob()+"','%d-%b-%Y') as dob");
			beanobj.setDobMail(dobMail);
			//String uname = firstname + midname + lastname;
			String fullName = beanobj.getApplicantname().trim()+beanobj.getStudmiddlename()+beanobj.getStudlastname();
			sendMail.sendStudentRegistraion(beanobj.getEmailid(),"Admin",beanobj.getStudentpassword(),fullName,"",beanobj);
		}
		
		return result;
	}
		public int Studentpersonalprofileupdate(StudentRegistrationBean beanobj) throws SQLException {
			int result = 0;
			
			PreparedStatement pstmt = null;
			
		 	log.info("invoking Studentpersonalprofileupdate for Student update");

			String Query = "";
			Connection connection = null;

			try {
				
				
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				// connection = ConnectionManager.getKycConnection();
				Query = "update  personmaster set firstname=?, fathername=?, mothername=?,dob=?,imagepath=?,nationality=?, religion=?, community=?,language=?,bloodgroup=?, middlename=?, lastname=? ,age=? ,sex=?,prefix=? where personid=?";
				pstmt = connection.prepareStatement(Query);
				pstmt.setString(1, beanobj.getApplicantname());
				pstmt.setString(2, beanobj.getFathername());
				pstmt.setString(3, beanobj.getMothername());
			       //log.info("beanobj.getDob()"+beanobj.getDob());

				pstmt.setString(4, beanobj.getDob());
				pstmt.setString(5, beanobj.getPhoto());
				pstmt.setString(6, beanobj.getNationality());
				pstmt.setString(7, beanobj.getReligion());
				pstmt.setString(8, beanobj.getCommunity());
				pstmt.setString(9, beanobj.getLanguage());
				//log.info("beanobj.getCreatedby()================>>"+beanobj.getCreatedby());
				pstmt.setString(10,beanobj.getBloodgroup());
				pstmt.setString(11,beanobj.getStudmiddlename());
				pstmt.setString(12,beanobj.getStudlastname());
				pstmt.setString(13,beanobj.getStudage());
				pstmt.setString(14,beanobj.getStudsex());
				pstmt.setString(15,beanobj.getStudprefix());
				pstmt.setString(16,beanobj.getUserid());

				result += pstmt.executeUpdate();
				log.info("personmaster================>>");
				connection.commit();
				
			} catch (Exception exception) {
				connection.rollback();
					log.error(exception);
				return 0;
			} finally {
				if (pstmt != null)
					pstmt.close();
				
				if (connection != null)
					connection.close();
				
			}
			return result;
		}
		
		public int Studentpersonalcontactupdate(StudentRegistrationBean beanobj) throws SQLException {
			int result = 0;
			
			PreparedStatement pstmt = null;
			PreparedStatement pstmt7 = null;

			
		 	log.info("invoking Studentpersonalcontactupdate for Student contact update");

			String Query = "";
			Connection connection = null;

			try {
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				Query = "update  personaddress set  communicationstreet1=?, communicationstate=?, communicationcountry=?, communicationcity=?, communicationpin=?, permanentstreet1=?,permanentstate=?, permanentcountry=?, permanentcity=?, permanentpin=?,communicationstreet2=?,permanentstreet2=?,smscontactno=? where personid=?";
				pstmt7 = connection.prepareStatement(Query);
				pstmt7.setString(1, beanobj.getStreet1());
				pstmt7.setString(2, beanobj.getState());
				pstmt7.setString(3, beanobj.getCountry());
				pstmt7.setString(4, beanobj.getCity());
				pstmt7.setString(5, beanobj.getZipcode());
				pstmt7.setString(6, beanobj.getPermanentstreet1());
				pstmt7.setString(7, beanobj.getPermanentstate());
				pstmt7.setString(8, beanobj.getPermanentcountry());
				pstmt7.setString(9, beanobj.getPermanentcity());
				pstmt7.setString(10, beanobj.getPermanentzipcode());
				pstmt7.setString(11, beanobj.getStreet2());
				pstmt7.setString(12, beanobj.getPermanentstreet2());
				pstmt7.setString(13, beanobj.getSmsContactNo());
				pstmt7.setString(14, beanobj.getUserid()); 
				result += pstmt7.executeUpdate();
				log.info("personaddressupdate================>>");
				
				// connection = ConnectionManager.getKycConnection();
				Query = "update  personmaster set  landlinenumber=?,emailid=?,mobilenumber=? where personid=?";
				pstmt = connection.prepareStatement(Query);
				pstmt.setString(1, beanobj.getLandlinenumber());
				pstmt.setString(2, beanobj.getEmailid());
				pstmt.setString(3, beanobj.getMobileno());
				pstmt.setString(4, beanobj.getUserid());
			    result += pstmt.executeUpdate();
				log.info("personmasterupdate================>>");
				connection.commit();
				log.info("PersonmasterUpdateCompleted");

				
			} catch (Exception exception) {log.error(exception);
			
				if (connection != null)
				connection.rollback();
					log.error(exception);
				return 0;
			} finally {
				if (pstmt != null)
					pstmt.close();
				if (pstmt7 != null)
					pstmt7.close();
				
				if (connection != null)
					connection.close();
				
			}
			return result;
		}

		 /*
		  * This method Studentregisterdetails is accessed from kycportal/jsp/Principal/StudentReportProfileView.jsp
		  * To List Students to view registered details for the principal login based on personid and status - Subhash
		 */
		public ArrayList Studentregisterdetails(String personid,String status) {
			ArrayList arraylist = null;

			try {
				log.info("invoking Studentregisterdetails(personid,status) for loading students ");
				select_query = "SELECT physicallyfit, exserviceman, physicalmark,previousschoolname, previousschooladdress, mediumstudied,tc, cc, splcategory, medicalcertificate, marksheet,sportscertificate,studextracurricular,previousschoolhistory,s.standardname,ys.sessionname,case when  sec.sectionname is null then '-' else sec.sectionname end as sectionname "
									+" FROM candidateregister c join studentapproval sa on  sa.studentapprovalid=c.studentapprovalid and c.personid='"+personid+"' and sa.approvalstatus='A' and c.candidateregisterstatus='A'"
									+" join standardschedule ss on ss.standardscheduleid=sa.standardscheduleid and ss.stdschedulestatus='A'"
									+" join standard s on s.standardid=ss.standardid and s.standardstatus='A'"
									+" join yearofsession ys on ss.sessionid=ys.sessionid and (ys.sessionstatus='A' or ys.sessionstatus='R')"
									+" left outer join  studentallocation sal on sal.candidateregisterid =c.candidateregisterid and sal.studentallocationstatus='"+status+"'"
									+" left outer join  sectionschedule secs on secs.sectionscheduleid=sal.sectionscheduleid and secs.sectionschedulestatus='A'"
									+" left outer join  section sec on sec.sectionid=secs.sectionid and sec.status='A'";
				
				arraylist = common_data_object.getListMap(select_query);
				log.info("==========>>>>>"+select_query);
				
			} catch (Exception exception) {
			}
			return arraylist;
		}
		/*
		 * This method is accessed in /Kycportal/Registration/StudentPreviousSchoolProfilesubmit.jsp
		 * update Student Previous School Details  
		 * Used  by maruthu
		 */
		/**
		 * update the Student Previous School Details
		 * @param registrationbeanobj
		 * @return if update successfully 1 if not 0
		 * @throws SQLException
		 */
		public int StudentExtraCurricularupdate(StudentRegistrationBean registrationbeanobj) throws SQLException {
			int result = 0;

			PreparedStatement pstmt2 = null;
			String Query = "";
			Connection connection = null;
			try {
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				Query="update candidateregister set studextracurricular=? where personid=?";
				pstmt2=connection.prepareStatement(Query);
				pstmt2.setString(1,registrationbeanobj.getExtraCurricular());
				pstmt2.setString(2,registrationbeanobj.getPersonid());
				result +=pstmt2.executeUpdate();
				connection.commit();

			} catch (Exception exception) {
				exception.printStackTrace();
					log.error(exception);
				return 0;
			} finally {
				if (pstmt2 != null)
					pstmt2.close();
			}
			return result;
			}
		
		/**
		 * update the Student Previous Scholarship Details
		 * @param registrationbeanobj
		 * @return if update successfully 1 if not 0
		 * @throws SQLException
		 */
		
		public int studentScholarshipUpdate(StudentRegistrationBean registrationbeanobj) throws SQLException {
			
			
			int result 						= 0;

			PreparedStatement userstmt 		= null;
			ResultSet userrs 				= null;
			
			PreparedStatement maxstmt 		= null;
			ResultSet maxrs 				= null;
			
			PreparedStatement checkstmt 	= null;
			ResultSet checkrs 				= null;
			
			PreparedStatement selectstmt 	= null;
			ResultSet selectrs 				= null;
			
			PreparedStatement feescolmaxstmt 	= null;
			ResultSet feesmaxrs 				= null;
			
			
			
			
			PreparedStatement addstmt 		= null;
			
			PreparedStatement fessaddstmt = null;

			PreparedStatement deletestmt 	= null;
			
			Connection connection 			= null;
			
			long userid						= 0;
			long studentapprovalid			= 0;
			
			long max_scholarshipid			= 0;
			long max_feescolid = 0;
			
			String totalallocation			= "";
			
			try {
				
				
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				
				userstmt		= connection.prepareStatement("select a.userid, b.studentapprovalid from login a, candidateregister b where a.personid=? and a.personid=b.personid and b.candidateregisterstatus='A' and loginstatus='A'");
				userstmt.setString(1, registrationbeanobj.getPersonid());
				
				System.out.println("userstmt"+userstmt);
				userrs			= userstmt.executeQuery();
				
				if(userrs.next()){
					userid				= userrs.getLong(1);
					studentapprovalid	= userrs.getLong(2);
				}
				
				System.out.println("studentapprovalid"+studentapprovalid);
				System.out.println("userid"+userid);
				selectstmt		= connection.prepareStatement("select b.schemeforstudentid from scholarshipamountallocation a, scholarshipforstudent b where a.standardscheduleid=? and a.amountallocationstatus='A' and a.scholarshipamountallocationid=b.scholarshipamountallocationid and b.scholarshipforstudentstatus='A' and b.userid=? and a.scholarshipamountallocationid not in(?) and b.schemeforstudentid not in(select case when h.schemeforstudentid is null then '0' else h.schemeforstudentid end from feescollection h where h.studentapprovalid=? and h.feescollectionstatus='A')");
				
				deletestmt		= connection.prepareStatement("delete from scholarshipforstudent where schemeforstudentid=?");
				
				maxstmt			= connection.prepareStatement("select max(schemeforstudentid) from scholarshipforstudent");
				
				maxrs			= maxstmt.executeQuery();
				
				if(maxrs.next()){
					max_scholarshipid		= maxrs.getLong(1);
				}
				
				max_scholarshipid++;
				
				feescolmaxstmt			= connection.prepareStatement("select max(feescollectionid) from feescollection");
				feesmaxrs= feescolmaxstmt.executeQuery();
				
				if(feesmaxrs.next()){
					max_feescolid = feesmaxrs.getLong(1);
				}
				
				max_feescolid++;
				
				checkstmt		= connection.prepareStatement("select schemeforstudentid from scholarshipforstudent where scholarshipamountallocationid=? and userid=? and scholarshipforstudentstatus='A'");
				addstmt			= connection.prepareStatement("insert into scholarshipforstudent(schemeforstudentid, scholarshipamountallocationid, userid, createdby, dateofcreation, scholarshipforstudentstatus,studentapprovalid) values(?, ?, ?, ?, ?, ?, ?)");
				
				fessaddstmt = connection.prepareStatement("insert into feescollection(feescollectionid,termfeesid,studentapprovalid,bankname,ddno,dddate,collectionamount,scholarshipid,pendingstatus,createdby,feescollectiondate,feescollectionstatus,paymenttype,schemeforstudentid) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				
				
				if(registrationbeanobj.getScholarshipallocation() != null && registrationbeanobj.getScholarshipallocation().length>0)
				for(int y=0;y<registrationbeanobj.getScholarshipallocation().length;y++){
					
					if(registrationbeanobj.getTermfeesid()[y].length()>0)
					{
					System.out.println("i am here only");
					checkstmt.setString(1, registrationbeanobj.getScholarshipallocation()[y]);
					checkstmt.setLong(2, userid);
					checkrs		= checkstmt.executeQuery();
					
					if(!checkrs.next()){
						
						addstmt.setLong(1, max_scholarshipid);
						addstmt.setString(2, registrationbeanobj.getScholarshipallocation()[y]);
						addstmt.setLong(3, userid);
						addstmt.setString(4,registrationbeanobj.getCreatedby());
						addstmt.setString(5, DateTime.showTime("databaseinsert"));
						addstmt.setString(6, "A");
						addstmt.setLong(7, studentapprovalid);
						System.out.println(addstmt);
						addstmt.addBatch(); 
						
						System.out.println("Termfeesid--->"+registrationbeanobj.getTermfeesid()[y]);
						
						fessaddstmt.setLong(1,max_feescolid);//feescollectionid
						fessaddstmt.setString(2,registrationbeanobj.getTermfeesid()[y]);//termfeesid
						fessaddstmt.setLong(3,studentapprovalid);//studentapprovalid
						fessaddstmt.setString(4,"-");//bankname
						fessaddstmt.setString(5,"-");//ddno	
						fessaddstmt.setString(6,null);//dddate
						fessaddstmt.setString(7,registrationbeanobj.getAmount()[y]);//collectionamount
						fessaddstmt.setString(8,null);//scholarshipid
						fessaddstmt.setString(9,"-");//pendingstatus
						fessaddstmt.setString(10,registrationbeanobj.getCreatedby());//createdby
						fessaddstmt.setString(11, DateTime.showTime("databaseinsert"));//feescollectiondate
						fessaddstmt.setString(12,"A");//feescollectionstatus 
						fessaddstmt.setString(13,"SCHOLAR");//paymenttype
						fessaddstmt.setLong(14,max_scholarshipid);//schemeforstudentid	
						System.out.println("fessaddstmt-->"+fessaddstmt);
						fessaddstmt.addBatch();
						
						max_feescolid++;
						max_scholarshipid++;
						
					}
					
					if(checkrs != null)
						checkrs.close();
					
					totalallocation	+=registrationbeanobj.getScholarshipallocation()[y]+",";
					}
				}
				

				if(totalallocation != null && totalallocation.length()>0)
					totalallocation		= totalallocation.substring(0,totalallocation.length()-1);

	
				
				selectstmt.setString(1, registrationbeanobj.getStandardscheduleid());
				selectstmt.setLong(2, userid);
				selectstmt.setString(3, totalallocation);
				selectstmt.setLong(4, studentapprovalid);
				
				
				selectrs	= selectstmt.executeQuery();
				
				while(selectrs.next()){
					
					deletestmt.setString(1, selectrs.getString(1));
					deletestmt.addBatch();
				}
				
				
				int resultArr[]		= deletestmt.executeBatch();

				if(resultArr != null && resultArr.length>0)
				for(int x=0;x<resultArr.length;x++)
					result		+= resultArr[x];
				

				resultArr			= addstmt.executeBatch();
				
				if(resultArr != null && resultArr.length>0)
				for(int x=0;x<resultArr.length;x++)
					result		+= resultArr[x];
				
				resultArr			= fessaddstmt.executeBatch();
				
				if(resultArr != null && resultArr.length>0)
				for(int x=0;x<resultArr.length;x++)
					result		+= resultArr[x];
				
			
				connection.commit();

			} catch (Exception exception) {
				
				if(connection != null)
					connection.rollback();
				
				exception.printStackTrace();

				log.error("",exception);
				
				result	= 0;
					
			} finally {
				
				if (checkrs != null)
					checkrs.close();

				if (maxrs != null)
					maxrs.close();
				
				if (userrs != null)
					userrs.close();

				if (selectrs != null)
					selectrs.close();
				
				if (feesmaxrs != null)
					feesmaxrs.close();
				

				if (selectstmt != null)
					selectstmt.close();
				
				if(fessaddstmt!=null)
					fessaddstmt.close();

				if (userstmt != null)
					userstmt.close();

				if (maxstmt != null)
					maxstmt.close();

				if (checkstmt != null)
					checkstmt.close();

				if (addstmt != null)
					addstmt.close();

				if (deletestmt != null)
					deletestmt.close();

				if (connection != null)
					connection.close();

			}
			return result;
		}
		
		
		
	public int studentScholarshipUpdateProcess(StudentRegistrationBean registrationbeanobj) throws SQLException {
			
			int result 						= 0;

			
			PreparedStatement feesdeletestmt = null;

			PreparedStatement deletestmt 	= null;
			
			
			Connection connection 			= null;
			try {
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
//delete from scholarshipforstudent where schemeforstudentid='"+schemeforstudentid+"'
//delete from feescollection where feescollectionid='"+feescollectionid+"'
				
				deletestmt		= connection.prepareStatement("delete from scholarshipforstudent where schemeforstudentid=?");
				feesdeletestmt		= connection.prepareStatement("delete from feescollection where feescollectionid=?");
				
			if(registrationbeanobj.getScholarshipallocation() != null && registrationbeanobj.getScholarshipallocation().length>0)
			for(int i=0;i<registrationbeanobj.getScholarshipallocation().length;i++ ){
				
				if(registrationbeanobj.getSchemeforstudentid()[i].length()>0)
				{
				deletestmt.setString(1, registrationbeanobj.getSchemeforstudentid()[i]);
				System.out.println("delete stmet"+deletestmt);
				deletestmt.addBatch();
				
				
				feesdeletestmt.setString(1, registrationbeanobj.getFeescollectionid()[i]);
				System.out.println("fees delete stmet"+feesdeletestmt);
				feesdeletestmt.addBatch();
				}
			}
				
				
				int resultArr[]		= deletestmt.executeBatch();

				if(resultArr != null && resultArr.length>0)
				for(int x=0;x<resultArr.length;x++)
					result		+= resultArr[x];
				
				
				resultArr		= feesdeletestmt.executeBatch();

				if(resultArr != null && resultArr.length>0)
				for(int x=0;x<resultArr.length;x++)
					result		+= resultArr[x];
			
				connection.commit();

			} catch (Exception exception) {
				
				if(connection != null)
					connection.rollback();
				
				exception.printStackTrace();

				log.error("",exception);
				
				result	= 0;
					
			} finally {
				
				
				if (feesdeletestmt  != null)
					feesdeletestmt.close();

				if (deletestmt != null)
					deletestmt.close();

				if (connection != null)
					connection.close();

			}
			return result;
		}
		
		
		/*
		 * This method is accessed in /Kycportal/Registration/StudentPreviousSchoolProfilesubmit.jsp
		 * update Student Previous School Details  
		 * Used  by maruthu
		 */
		/**
		 * update the Student Previous School Details
		 * @param registrationbeanobj
		 * @return if update successfully 1 if not 0
		 * @throws SQLException
		 */
		public int Studentpreviousschoolupdate(StudentRegistrationBean registrationbeanobj) throws SQLException {
			int result = 0;
			
			PreparedStatement pstmt2 = null;
			PreparedStatement pstmt3 = null;
			PreparedStatement pstmt4 = null;
					
		 	log.info("invoking Studentpreviousschoolupdate for Student School Detail update");

			String Query = "";
			Connection connection = null;
			String subject []= registrationbeanobj.getSubject();
			String monthyear []= registrationbeanobj.getMonthyear();
			String Registionno []= registrationbeanobj.getRegistionno();
			String Markscored []= registrationbeanobj.getMarkscored();
			String Maxmark []= registrationbeanobj.getMaxmark();
			String Updatestatus []= registrationbeanobj.getUpdateStatus();
			String examinfoid []= registrationbeanobj.getExaminfoid();
			long max_studentqualificationid = common_data_object.fmaxId("select max(studentqualificationid) from studentqualification");

			try {
				connection = ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				Query="update candidateregister set previousschoolname=?,previousschooladdress=?,mediumstudied=?,tc=?,cc=?,splcategory=?,medicalcertificate=?,marksheet=?,sportscertificate=?,previousschoolhistory=? where personid=?";
				pstmt2=connection.prepareStatement(Query);
				pstmt2.setString(1,registrationbeanobj.getPreviousSchoolDetails());
				pstmt2.setString(2,registrationbeanobj.getPreviousSchooladdress());
				pstmt2.setString(3,registrationbeanobj.getPreviousSchoolmedium());
				pstmt2.setString(4,registrationbeanobj.getTccheck());
				pstmt2.setString(5,registrationbeanobj.getCccheck());
				pstmt2.setString(6,registrationbeanobj.getSpccheck());
				pstmt2.setString(7,registrationbeanobj.getMccheck());
				pstmt2.setString(8,registrationbeanobj.getMscheck());
				pstmt2.setString(9,registrationbeanobj.getSccheck());
				pstmt2.setString(10,"yes");
				pstmt2.setString(11,registrationbeanobj.getPersonid());
				result +=pstmt2.executeUpdate();
				//System.out.println(pstmt2);
				if(Updatestatus!=null && Updatestatus.length>0)
				{
					for(int i=0;i<Updatestatus.length;i++)
					{
						if(Updatestatus[i].equals("U"))	
						{
							Query = "update studentqualification set subject=?, monthandyear=?, registrationno=?, marksscored=?, maxmarks=?,studqualificationstatus =?  where   studentqualificationid=?";
							pstmt4 = connection.prepareStatement(Query);
							pstmt4.setString(1, subject[i]);
							pstmt4.setString(2, monthyear[i]);
							pstmt4.setString(3, Registionno[i]);
							pstmt4.setString(4, Markscored[i]);
							pstmt4.setString(5, Maxmark[i]);
							pstmt4.setString(6, "A");
							pstmt4.setString(7, examinfoid[i]);
							result += pstmt4.executeUpdate();
						}
						else if(Updatestatus[i].equals("X"))  
						{
							Query = "update studentqualification set studqualificationstatus =?  where   studentqualificationid=?";
							pstmt4 = connection.prepareStatement(Query);
							pstmt4.setString(1, "X");
							pstmt4.setString(2, examinfoid[i]);
							result += pstmt4.executeUpdate();
							
						}
						else if(Updatestatus[i].equals("A"))
						{
							System.out.println("examinfoid[i]======>>>>>>>>"+subject.length);

							System.out.println("examinfoid[i]======>>>>>>>>"+subject[i]);

							Query = "insert into studentqualification(studentqualificationid, subject, monthandyear, registrationno, marksscored, maxmarks, userid, createdby, dateofcreation, studqualificationstatus) values(?,?,?,?,?,?,?,?,?,?)";
							pstmt4 = connection.prepareStatement(Query);
							pstmt4.setLong(1, max_studentqualificationid);
							pstmt4.setString(2, subject[i]);
							pstmt4.setString(3, monthyear[i]);
							pstmt4.setString(4, Registionno[i]);
							pstmt4.setString(5, Markscored[i]);
							pstmt4.setString(6, Maxmark[i]);
							pstmt4.setString(7, registrationbeanobj.getPersonid());
							pstmt4.setString(8, registrationbeanobj.getCreatedby());
							pstmt4.setString(9, datetime.showTime("databaseinsert"));
							pstmt4.setString(10, "A");
							result += pstmt4.executeUpdate();
							max_studentqualificationid++;
						}
					}

				}
				
				connection.commit();
				log.info("PersonmasterUpdateCompleted");

				
			} catch (Exception exception) {
				exception.printStackTrace();
					log.error(exception);
				return 0;
			} finally {
				if (pstmt3 != null)
					pstmt3.close();
				if (pstmt2 != null)
					pstmt2.close();
				if (pstmt4 != null)
					pstmt4.close();
			
				if (connection != null)
					connection.close();
				
			}
			return result;
		}
/**
 * update the parent guardian information.
 * @param registrationbeanobj
 * @return if update successfully 1 if not 0
 * @throws SQLException
 */
		public int UpdateParentGuardianInfo(StudentRegistrationBean registrationbeanobj)  throws SQLException
	    {
	    	PreparedStatement parentguardianprepared  = null;
	    	PreparedStatement physicalprepared  = null;
	    	Connection connection = null;
	    	int rs=0;
	    	
	    	try
	    	{
	    		
	    		log.info("invoking UpdateParentGuardianInfo method for update ParentGuardianInformation");
	    		connection = ConnectionManager.getKycConnection();
	        	String query=" update studentguardian set guardianname=?,relation=?,self=?,nameoforganization=?,annualincome=?,position=?,guardianmailid=? where studentguardianid=?";
	        	
	        	parentguardianprepared = connection.prepareStatement(query);
	        	parentguardianprepared.setString(1, registrationbeanobj.getGuardianname());
	        	parentguardianprepared.setString(2,registrationbeanobj.getGuardrelation());
				parentguardianprepared.setString(3,registrationbeanobj.getGuardemployment());
				parentguardianprepared.setString(4, registrationbeanobj.getNameoforg());
				parentguardianprepared.setString(5, registrationbeanobj.getAnnualincome());
				parentguardianprepared.setString(6, registrationbeanobj.getGuardposition());
				//added in guardianemailid
				parentguardianprepared.setString(7, registrationbeanobj.getGuardianmailid());

				parentguardianprepared.setString(8, registrationbeanobj.getStudentguardianid());

			
				rs = parentguardianprepared.executeUpdate();
				
				log.info(parentguardianprepared);
				
				
				String query1="update candidateregister set physicallyfit=?,exserviceman=?,physicalmark=? where candidateregisterid=?";
	        	
	        	physicalprepared = connection.prepareStatement(query1);
				physicalprepared.setString(1,registrationbeanobj.getPhysicallyChallenge());
				physicalprepared.setString(2,registrationbeanobj.getExServiceman());
				physicalprepared.setString(3,registrationbeanobj.getPhysicalmarks());
				physicalprepared.setString(4,registrationbeanobj.getCanidateregisterid());
			
				rs = physicalprepared.executeUpdate();
				log.info(physicalprepared);
				
				
				
	          }
	    	catch(Exception exception) { 
				
	    		log.error(exception);			
			}
	    	finally
			{
	    		if(physicalprepared != null)
					physicalprepared.close();
	    		
				if(parentguardianprepared != null)
					parentguardianprepared.close();
				
				
				if(connection != null)
					connection.close();
				
				
			}
	    	return rs;
	    }
		
		
		/**
		 *  This method used for registering the user through the excel file.
		 * @param beanobj
		 * @return
		 * @throws SQLException
		 */
		
		public int bulkStudentRegistration(StudentRegistrationBean beanobj) throws SQLException,Exception {
			
			int result 					= 0;
			PreparedStatement pstmt 	= null;
			PreparedStatement pstmt1 	= null;
			PreparedStatement pstmt2 	= null;
			PreparedStatement pstmt3 	= null;
			PreparedStatement pstmt4 	= null;
			PreparedStatement pstmt5 	= null;
			PreparedStatement pstmt6 	= null;
			PreparedStatement pstmt7 	= null;
			PreparedStatement pstmt8 	= null;
			ResultSet apprors			= null;

			PreparedStatement pstmt9 	= null;
			ResultSet parentrs			= null;
			int temp[]					= null;

			
		 	log.info("invoking bulkStudentRegistration for Student Insertion");

			String Query 			= "";
			Connection connection 	= null; 
			
			String appnos[]			= beanobj.getApplicationnos();
			String appids[]			= beanobj.getStudentapprovalids();

			String studentusername	= "";
			String parentusername	= "";
			String returnids		= "";
			String resultstr		= "";
			
			try {
			
				connection 	= ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				
				if(appnos != null && appnos.length>0){
					
					datetime						= new DateTime();
					
					long max_userid 				= common_data_object.fmaxId("select max(userid) from login");
					long max_personid 				= common_data_object.fmaxId("select max(personid) from personmaster");
					long max_studentguardianid 		= common_data_object.fmaxId("select max(studentguardianid) from studentguardian");
					long max_candidateregisterid 	= common_data_object.fmaxId("select max(candidateregisterid) from candidateregister");
					long max_parentloginid 			= common_data_object.fmaxId("select max(parentloginid) from parentlogin");
					long max_studentparentid 		= common_data_object.fmaxId("select max(studentparentid) from studentparent");
					long max_addressid 				= common_data_object.fmaxId("select max(addressid) from personaddress");
					

					Query 	= "insert into personmaster(personid,firstname, fathername, mothername,dob, landlinenumber, emailid, imagepath, dateofcreation, createdby, ipaddress, instituteid, status,nationality, religion, community,language,bloodgroup, middlename, lastname,age,sex,prefix,mobilenumber) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt 	= connection.prepareStatement(Query);
					
					Query 	= "insert into login(userid, username, password, usercategory, personid, dateofcreation, createdby, ipaddress, loginstatus) values(?,?,?,?,?,?,?,?,?)";
					pstmt1	= connection.prepareStatement(Query);
					
					Query 	= "insert into personaddress(addressid, personid, communicationstreet1, communicationstate, communicationcountry, communicationcity, communicationpin, permanentstreet1,permanentstate, permanentcountry, permanentcity, permanentpin, dateofcreation, createdby, peraddstatus,communicationstreet2,permanentstreet2,smscontactno) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt7 	= connection.prepareStatement(Query);
					
					Query 	= "insert into studentguardian(studentguardianid, personid, guardianname, relation, self, nameoforganization, annualincome, position, createdby, dateofcreation, ipaddress, studentguardianstatus) values(?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt2 	= connection.prepareStatement(Query);
					
					Query 	= "insert into candidateregister(candidateregisterid, studentapprovalid, standardscheduleid, personid, createdby, dateofcreation, ipaddress, candidateregisterstatus, physicallyfit, exserviceman, physicalmark, previousschoolname, previousschooladdress, mediumstudied, tc, cc, splcategory, medicalcertificate, marksheet, sportscertificate,studextracurricular,previousschoolhistory) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt3 	= connection.prepareStatement(Query);
					
					Query 	= "insert into parentlogin(parentloginid, parentusername, parentpassword, dateofcreation, createdby, parentstatus) values(?,?,?,?,?,?)";
					pstmt6 	= connection.prepareStatement(Query);
					
					Query 	= "insert into studentparent(studentparentid, userid, parentid, dateofcreation, studentparentstatus) values(?,?,?,?,?)";
					pstmt5 	= connection.prepareStatement(Query);
					
					Query	= "select d.parentid from studentallocation a,candidateregister b,login c, studentparent d where a.rollno=? and a.candidateregisterid=b.candidateregisterid and b.personid=c.personid and c.userid=d.userid";
					pstmt9	= connection.prepareStatement(Query);
					
					Query	= "select studentapprovalid from candidateregister where studentapprovalid=? and candidateregisterstatus='A'";
					pstmt8	= connection.prepareStatement(Query);
					
					for(int y=0;y<appnos.length;y++){
						
						if(beanobj.getFirstnames()[y] != null && beanobj.getFirstnames()[y].length() >5)
							studentusername	= beanobj.getFirstnames()[y].substring(0,5).toLowerCase().replaceAll(" ", "_")+"_"+appnos[y];
						else
							studentusername	= beanobj.getFirstnames()[y].toLowerCase().replaceAll(" ", "_")+"_"+appnos[y];
						
						if(beanobj.getFathernames()[y] != null && beanobj.getFathernames()[y].length() >5)
							parentusername	= beanobj.getFathernames()[y].substring(0,5).toLowerCase().replaceAll(" ", "_")+"_"+appnos[y]+"_p";
						else
							parentusername	= beanobj.getFathernames()[y].toLowerCase().replaceAll(" ", "_")+"_"+appnos[y]+"_p";
						
						
						
						if(!common_data_object.checkDuplicate("login", "username", studentusername)){
							
						
							pstmt8.setString(1, appids[y]);
							
							apprors	= pstmt8.executeQuery();
							
							if(!apprors.next()){
							
								pstmt.setLong(1, max_personid);
								pstmt.setString(2, beanobj.getFirstnames()[y].trim());
								pstmt.setString(3, beanobj.getFathernames()[y].trim());
								pstmt.setString(4, beanobj.getMothernames()[y].trim());
								pstmt.setString(5, datetime.getMySQLFormatSlash(beanobj.getDateofbirths()[y]));
								pstmt.setString(6, beanobj.getLandlinenos()[y]);
								pstmt.setString(7, beanobj.getEmails()[y]);
								pstmt.setString(8, "-");
								pstmt.setString(9, datetime.showTime("databaseinsert"));
								pstmt.setString(10, beanobj.getCreatedby());
								pstmt.setString(11, beanobj.getIpaddress());
								pstmt.setString(12, beanobj.getInstituteid());
								pstmt.setString(13, "A");
								pstmt.setString(14, beanobj.getNationalitys()[y]);
								pstmt.setString(15, beanobj.getReligion());
								pstmt.setString(16, beanobj.getCommunity());
								pstmt.setString(17, beanobj.getLanguages()[y]);
								pstmt.setString(18, beanobj.getBloodgroups()[y]);
								pstmt.setString(19, beanobj.getMiddlenames()[y].trim());
								pstmt.setString(20, beanobj.getLastnames()[y].trim());
								pstmt.setString(21, "0");
								pstmt.setString(22, beanobj.getGenders()[y]);
								pstmt.setString(23, beanobj.getPrefixs()[y]);
								pstmt.setString(24, beanobj.getMobilenos()[y]);
								pstmt.addBatch();
								
								
								
								
								pstmt1.setLong(1, max_userid);
								pstmt1.setString(2, studentusername);
								String usrpassword 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(studentusername);
								//pstmt1.setString(3, studentusername);
								pstmt1.setString(3, usrpassword);
								pstmt1.setString(4, "S");
								pstmt1.setLong(5, max_personid);
								pstmt1.setString(6, datetime.showTime("databaseinsert"));
								pstmt1.setString(7, beanobj.getCreatedby());
								pstmt1.setString(8, beanobj.getIpaddress());
								pstmt1.setString(9, "A");
								pstmt1.addBatch();
								
								
								
								pstmt7.setLong(1, max_addressid);
								pstmt7.setLong(2, max_userid);
								pstmt7.setString(3, beanobj.getStreet1s()[y]);
								pstmt7.setString(4, beanobj.getStates()[y]);
								pstmt7.setString(5, beanobj.getCountrys()[y]);
								pstmt7.setString(6, beanobj.getCitys()[y]);
								pstmt7.setString(7, beanobj.getPincodes()[y]);
								pstmt7.setString(8, beanobj.getStreet1s()[y]);
								pstmt7.setString(9, beanobj.getStates()[y]);
								pstmt7.setString(10, beanobj.getCountrys()[y]);
								pstmt7.setString(11, beanobj.getCitys()[y]);
								pstmt7.setString(12, beanobj.getPincodes()[y]);
								pstmt7.setString(13, datetime.showTime("databaseinsert"));
								pstmt7.setString(14, beanobj.getCreatedby());
								pstmt7.setString(15, "A");
								pstmt7.setString(16, beanobj.getStreet2s()[y]);
								pstmt7.setString(17, beanobj.getStreet2s()[y]);
								pstmt7.setString(18, beanobj.getSmscontacts()[y]);				
								pstmt7.addBatch();	
								
								
								
								pstmt2.setLong(1, max_studentguardianid);
								pstmt2.setLong(2, max_userid);
								pstmt2.setString(3, beanobj.getGuardiannames()[y]);
								pstmt2.setString(4, beanobj.getGuardianrelation()[y]);
								pstmt2.setString(5, beanobj.getSelfemployed()[y]);
								pstmt2.setString(6, beanobj.getOrganizationnames()[y]);
								pstmt2.setString(7, beanobj.getIncome()[y]);
								pstmt2.setString(8, beanobj.getPosition()[y]);
								pstmt2.setString(9, beanobj.getCreatedby());
								pstmt2.setString(10, datetime.showTime("databaseinsert"));
								pstmt2.setString(11, beanobj.getIpaddress());
								pstmt2.setString(12, "A");
								pstmt2.addBatch();	
								
								max_studentguardianid++;
	
								
								pstmt3.setLong(1, max_candidateregisterid);
								pstmt3.setString(2,beanobj.getStudentapprovalids()[y]);
								pstmt3.setString(3, beanobj.getStandardscheduleid());
								pstmt3.setLong(4,max_userid);
								pstmt3.setString(5, beanobj.getCreatedby());
								pstmt3.setString(6, datetime.showTime("databaseinsert"));
								pstmt3.setString(7, beanobj.getIpaddress());
								pstmt3.setString(8, "A");
								pstmt3.setString(9, beanobj.getPhysicallychallenged()[y]);
								pstmt3.setString(10, beanobj.getChildofexserviceman()[y]);
								pstmt3.setString(11, beanobj.getPersonalphysicalmarks()[y]);
								pstmt3.setString(12, beanobj.getPreviousSchoolDetails());
								pstmt3.setString(13, beanobj.getPreviousSchooladdress());
								pstmt3.setString(14, beanobj.getPreviousSchoolmedium());
								pstmt3.setString(15, beanobj.getTccheck());
								pstmt3.setString(16, beanobj.getCccheck());
								pstmt3.setString(17,beanobj.getSccheck());
								pstmt3.setString(18, beanobj.getMccheck());
								pstmt3.setString(19, beanobj.getMscheck());
								pstmt3.setString(20, beanobj.getSpccheck());
								pstmt3.setString(21, beanobj.getExtraCurricular());
								pstmt3.setString(22, "No");
								pstmt3.addBatch();
								
								
								
								if(beanobj.getExistingstudentrollnos()[y] != null && !beanobj.getExistingstudentrollnos()[y].equals("-") && !beanobj.getExistingstudentrollnos()[y].equalsIgnoreCase("Nil") && !beanobj.getExistingstudentrollnos()[y].equalsIgnoreCase("null"))
								{
									
									pstmt9.setString(1, beanobj.getExistingstudentrollnos()[y]);
									parentrs	= pstmt9.executeQuery();
									
								}
	
								if(parentrs != null && parentrs.next()){
									
									
									pstmt5.setLong(1, max_studentparentid);
									pstmt5.setLong(2,max_userid);
									pstmt5.setLong(3,parentrs.getLong(1));
									pstmt5.setString(4, datetime.showTime("databaseinsert"));
									pstmt5.setString(5,"A");
											
									pstmt5.addBatch();
									
									
									max_studentparentid++;
									
								}
								else{
									
									
									pstmt6.setLong(1, max_parentloginid);
									pstmt6.setString(2,parentusername);
									String parentpassword 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(parentusername);

								//	pstmt6.setString(3,parentusername);
									pstmt6.setString(3,parentpassword);
									pstmt6.setString(4, datetime.showTime("databaseinsert"));
									pstmt6.setString(5,beanobj.getCreatedby());
									pstmt6.setString(6,"A");
									pstmt6.addBatch();
									
									pstmt5.setLong(1, max_studentparentid);
									pstmt5.setLong(2,max_userid);
									pstmt5.setLong(3,max_parentloginid);
									pstmt5.setString(4, datetime.showTime("databaseinsert"));
									pstmt5.setString(5,"A");
											
									pstmt5.addBatch();
									
									max_studentparentid++;
									max_parentloginid++;
	
									
									
								}
								
								if(parentrs != null)
									parentrs.close();
								
								
								max_personid++;
								max_userid++;
								max_addressid++;
								max_candidateregisterid++;
							
							}
							else
								returnids	+= appnos[y]+",";
							
							if(apprors != null)
								apprors.close();
							
						}
					}
					
					
					temp		= pstmt.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					
					temp		= pstmt1.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];

					temp		= pstmt7.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];

					
					temp		= pstmt2.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt3.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt6.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt5.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];					
					
					
				}
				
				beanobj.setResultstaus(returnids);
				connection.commit();

			}catch (Exception exception) {
				
				exception.printStackTrace();
				
				beanobj.setResultstaus("");
				
				result	= 0;
				
				if (connection != null)
					connection.rollback();
				
				log.error(exception);

			} finally {
				
				if (pstmt != null)
					pstmt.close();

				if (pstmt1 != null)
					pstmt1.close();

				if (pstmt2 != null)
					pstmt2.close();

				if (pstmt3 != null)
					pstmt3.close();
				
				if (pstmt4 != null)
					pstmt4.close();
				
				if (pstmt5 != null)
					pstmt5.close();
				
				if (pstmt6 != null)
					pstmt6.close();
				
				if (pstmt7 != null)
					pstmt7.close();
				
				if(parentrs != null)
					parentrs.close();
				
				if(apprors != null)
					apprors.close();

				if (pstmt8 != null)
					pstmt8.close();
				
				if (pstmt9 != null)
					pstmt9.close();
				
				if (connection != null)
					connection.close();
				
			}
			
			return result;
		}
		
		/**
		 *  This method used for registering the user through the excel file.
		 * @param beanobj
		 * @return
		 * @throws SQLException
		 */
		
		public int bulkStudentRegistrationAuto(StudentRegistrationBean beanobj) throws SQLException,Exception {
			
			int result 					= 0;
			PreparedStatement pstmt 	= null;
			PreparedStatement pstmt1 	= null;
			PreparedStatement pstmt2 	= null;
			PreparedStatement pstmt3 	= null;
			PreparedStatement pstmt4 	= null;
			PreparedStatement pstmt5 	= null;
			PreparedStatement pstmt6 	= null;
			PreparedStatement pstmt7 	= null;
			PreparedStatement pstmt8 	= null;
			PreparedStatement amountstmt = null;
			
			PreparedStatement fessaddstmt 	= null;
			ResultSet apprors			= null;

			PreparedStatement pstmt9 	= null;
			
			PreparedStatement pstmt10 	= null;
			PreparedStatement pstmt11 	= null;
			PreparedStatement pstmt12 	= null;
			PreparedStatement pstmt13 	= null;
			PreparedStatement pstmt14 	= null;
			
			ResultSet agers			= null;
			ResultSet amountrs			= null;
			
			ResultSet parentrs			= null;
			int temp[]					= null;
			long max_feescolid = 0;
			
		 	log.info("invoking bulkStudentRegistration for Student Insertion");
			ResourceBundle bundle = ResourceBundle.getBundle("resources.serversetup");
			String applicationcost = bundle.getString("applicationcost");
			String registrationcost = bundle.getString("registrationcost");

			String Query 			= "";
			Connection connection 	= null; 
			
			//String appnos[]			= beanobj.getApplicationnos();
			//String appids[]			= beanobj.getStudentapprovalids();
			String appnames[]			= beanobj.getFirstnames();
			
			String studentusername	= "";
			String parentusername	= "";
			String returnids		= "";
			String resultstr		= "";
			
			try {
			
				connection 	= ConnectionManager.getKycConnection(); 
				connection.setAutoCommit(false);
				
				if(appnames != null && appnames.length>0){
					
					datetime						= new DateTime();
					
					long max_appissid 				= common_data_object.fmaxId("select max(applicationid) from applicationissue");
					long max_regid 					= common_data_object.fmaxId("select max(registrationid) from registration");
					long max_apprvid 				= common_data_object.fmaxId("select max(studentapprovalid) from studentapproval");
					
					long max_userid 				= common_data_object.fmaxId("select max(userid) from login");
					long max_personid 				= common_data_object.fmaxId("select max(personid) from personmaster");
					long max_studentguardianid 		= common_data_object.fmaxId("select max(studentguardianid) from studentguardian");
					long max_candidateregisterid 	= common_data_object.fmaxId("select max(candidateregisterid) from candidateregister");
					long max_parentloginid 			= common_data_object.fmaxId("select max(parentloginid) from parentlogin");
					long max_studentparentid 		= common_data_object.fmaxId("select max(studentparentid) from studentparent");
					long max_addressid 				= common_data_object.fmaxId("select max(addressid) from personaddress");
					long schemeforstudentid			= common_data_object.fmaxId("select max(schemeforstudentid) from scholarshipforstudent");
					long feescollectionid			= common_data_object.fmaxId("select max(feescollectionid) from feescollection");
					
				

					Query 	= "insert into scholarshipforstudent(schemeforstudentid, scholarshipamountallocationid,userid, createdby, dateofcreation, scholarshipforstudentstatus,studentapprovalid) values(?,?,?,?,?,?,?)";
					pstmt14	= connection.prepareStatement(Query);
					
					Query 	= "insert into applicationissue(applicationid,applicantname,applicationno,cost,contactno,emailid,standardpublishid,dateofcreation,receiptno,createdby,ipaddress,instituteid,sessionid,boardid,status) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt10	= connection.prepareStatement(Query);

					Query 	= "insert into registration(registrationid,applicationid,registrationamount,standardpublishid,createdby,dateofcreation,status) values(?,?,?,?,?,?,?)";
					pstmt11	= connection.prepareStatement(Query);

					Query 	= "insert into studentapproval(studentapprovalid,registrationid,standardscheduleid,createdby,dateofcreation,approvalstatus) values(?,?,?,?,?,?)";
					pstmt12	= connection.prepareStatement(Query);

					Query	= "SELECT TRUNCATE(DATEDIFF(?,?)/365,0)";
					pstmt13	= connection.prepareStatement(Query);
					
					Query 	= "insert into personmaster(personid,firstname, fathername, mothername,dob, landlinenumber, emailid, imagepath, dateofcreation, createdby, ipaddress, instituteid, status,nationality, religion,community,language,bloodgroup, middlename, lastname,age,sex,prefix,mobilenumber) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt 	= connection.prepareStatement(Query);
					
					Query 	= "insert into login(userid, username, password, usercategory, personid, dateofcreation, createdby, ipaddress, loginstatus) values(?,?,?,?,?,?,?,?,?)";
					pstmt1	= connection.prepareStatement(Query);
					
					Query 	= "insert into personaddress(addressid, personid, communicationstreet1, communicationstate, communicationcountry, communicationcity, communicationpin, permanentstreet1,permanentstate, permanentcountry, permanentcity, permanentpin, dateofcreation, createdby, peraddstatus,communicationstreet2,permanentstreet2,smscontactno) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt7 	= connection.prepareStatement(Query);
					
					Query 	= "insert into studentguardian(studentguardianid, personid, guardianname, relation, self, nameoforganization, annualincome, position, createdby, dateofcreation, ipaddress, studentguardianstatus,guardianmailid) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt2 	= connection.prepareStatement(Query);
					
					Query 	= "insert into candidateregister(candidateregisterid, studentapprovalid, standardscheduleid, personid, createdby, dateofcreation, ipaddress, candidateregisterstatus, physicallyfit, exserviceman, physicalmark, previousschoolname, previousschooladdress, mediumstudied, tc, cc, splcategory, medicalcertificate, marksheet, sportscertificate,studextracurricular,previousschoolhistory) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
					pstmt3 	= connection.prepareStatement(Query);
					
					Query 	= "insert into parentlogin(parentloginid, parentusername, parentpassword, dateofcreation, createdby, parentstatus) values(?,?,?,?,?,?)";
					pstmt6 	= connection.prepareStatement(Query);
					
					Query 	= "insert into studentparent(studentparentid, userid, parentid, dateofcreation, studentparentstatus) values(?,?,?,?,?)";
					pstmt5 	= connection.prepareStatement(Query);
					
					Query	= "select d.parentid from studentallocation a,candidateregister b,login c, studentparent d where a.rollno=? and a.candidateregisterid=b.candidateregisterid and b.personid=c.personid and c.userid=d.userid";
					pstmt9	= connection.prepareStatement(Query);
					
					Query	= "select studentapprovalid from candidateregister where studentapprovalid=? and candidateregisterstatus='A'";
					pstmt8	= connection.prepareStatement(Query);
					
					fessaddstmt = connection.prepareStatement("insert into feescollection(feescollectionid,termfeesid,studentapprovalid,bankname,ddno,dddate,collectionamount,scholarshipid,pendingstatus,createdby,feescollectiondate,feescollectionstatus,paymenttype,schemeforstudentid) values (?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
					
					amountstmt		= connection.prepareStatement("select amount from scholarshipamountallocation where scholarshipamountallocationid=?");

					
					for(int y=0;y<appnames.length;y++){
						
						if(beanobj.getFirstnames()[y] != null && beanobj.getFirstnames()[y].length() >5)
							studentusername	= beanobj.getFirstnames()[y].substring(0,5).toLowerCase().replaceAll(" ", "_")+"_"+max_appissid;
						else
							studentusername	= beanobj.getFirstnames()[y].toLowerCase().replaceAll(" ", "_")+"_"+max_appissid;
						
						if(beanobj.getFathernames()[y] != null && beanobj.getFathernames()[y].length() >5)
							parentusername	= beanobj.getFathernames()[y].substring(0,5).toLowerCase().replaceAll(" ", "_")+"_"+max_appissid+"_p";
						else
							parentusername	= beanobj.getFathernames()[y].toLowerCase().replaceAll(" ", "_")+"_"+max_appissid+"_p";
						
						
						
						if(!common_data_object.checkDuplicate("login", "username", studentusername)){
							
						
							pstmt8.setLong(1, max_appissid);
							apprors	= pstmt8.executeQuery();
							
							
							if(!apprors.next()){
								
								pstmt10.setLong(1, max_appissid);
								pstmt10.setString(2, beanobj.getFirstnames()[y].trim());
								pstmt10.setLong(3, max_appissid);
								pstmt10.setString(4, applicationcost);
								pstmt10.setString(5, beanobj.getMobilenos()[y]);
								pstmt10.setString(6, beanobj.getEmails()[y]);
								pstmt10.setString(7, beanobj.getStandardscheduleid());
								pstmt10.setString(8, datetime.showTime("databaseinsert"));
								pstmt10.setLong(9, max_appissid);
								pstmt10.setString(10, beanobj.getCreatedby());
								pstmt10.setString(11, beanobj.getIpaddress());
								pstmt10.setString(12, beanobj.getInstituteid());
								pstmt10.setString(13, beanobj.getSessionid());
								pstmt10.setString(14, beanobj.getBoardid());
								pstmt10.setString(15, "A");
								pstmt10.addBatch();

								pstmt11.setLong(1,max_regid);
								pstmt11.setLong(2,max_appissid);
								pstmt11.setString(3,registrationcost);
								pstmt11.setString(4,beanobj.getStandardscheduleid());
								pstmt11.setString(5,beanobj.getCreatedby());			
								pstmt11.setString(6,datetime.showTime("databaseinsert"));
								pstmt11.setString(7,"A");			
								pstmt11.addBatch();
								
								pstmt12.setLong(1,max_apprvid);
								pstmt12.setLong(2,max_regid);
								pstmt12.setString(3,beanobj.getStandardscheduleid());
								pstmt12.setString(4,beanobj.getCreatedby());
								pstmt12.setString(5,datetime.showTime("databaseinsert"));
								pstmt12.setString(6,"A");						
								pstmt12.addBatch();								
 
								pstmt13.setString(1, datetime.showTime("databaseinsert"));
								pstmt13.setString(2, datetime.getMySQLFormatSlash(beanobj.getDateofbirths()[y]));
								agers	= pstmt13.executeQuery();
														
								
								
								if(agers.next())
								{
								pstmt.setLong(1, max_personid);
								pstmt.setString(2, beanobj.getFirstnames()[y].trim());
								pstmt.setString(3, beanobj.getFathernames()[y].trim());
								pstmt.setString(4, beanobj.getMothernames()[y].trim());
								pstmt.setString(5, datetime.getMySQLFormatSlash(beanobj.getDateofbirths()[y]));
								pstmt.setString(6, beanobj.getLandlinenos()[y]);
								pstmt.setString(7, beanobj.getEmails()[y]);
								pstmt.setString(8, "-");
								pstmt.setString(9, datetime.showTime("databaseinsert"));
								pstmt.setString(10, beanobj.getCreatedby());
								pstmt.setString(11, beanobj.getIpaddress());
								pstmt.setString(12, beanobj.getInstituteid());
								pstmt.setString(13, "A");
								pstmt.setString(14, beanobj.getNationalitys()[y]);
								//pstmt.setString(15, beanobj.getReligion());
								pstmt.setString(15, beanobj.getReligions()[y]);
								pstmt.setString(16, beanobj.getCommunities()[y]);
								pstmt.setString(17, beanobj.getLanguages()[y]);
								pstmt.setString(18, beanobj.getBloodgroups()[y]);
								pstmt.setString(19, beanobj.getMiddlenames()[y].trim());
								pstmt.setString(20, beanobj.getLastnames()[y].trim());
								//pstmt.setString(21, "0");
								pstmt.setLong(21, agers.getLong(1));
								pstmt.setString(22, beanobj.getGenders()[y]);
								pstmt.setString(23, beanobj.getPrefixs()[y]);
								pstmt.setString(24, beanobj.getMobilenos()[y]);
								pstmt.addBatch();
								}
								
								
								
								String studentpasswrd 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(studentusername);
								pstmt1.setLong(1, max_userid);
								pstmt1.setString(2, studentusername);
								pstmt1.setString(3, studentpasswrd);
								pstmt1.setString(4, "S");
								pstmt1.setLong(5, max_personid);
								pstmt1.setString(6, datetime.showTime("databaseinsert"));
								pstmt1.setString(7, beanobj.getCreatedby());
								pstmt1.setString(8, beanobj.getIpaddress());
								pstmt1.setString(9, "A");
								pstmt1.addBatch();
								
								
								
								pstmt7.setLong(1, max_addressid);
								pstmt7.setLong(2, max_userid);
								pstmt7.setString(3, beanobj.getStreet1s()[y]);
								pstmt7.setString(4, beanobj.getStates()[y]);
								pstmt7.setString(5, beanobj.getCountrys()[y]);
								pstmt7.setString(6, beanobj.getCitys()[y]);
								pstmt7.setString(7, beanobj.getPincodes()[y]);
								pstmt7.setString(8, beanobj.getStreet1s()[y]);
								pstmt7.setString(9, beanobj.getStates()[y]);
								pstmt7.setString(10, beanobj.getCountrys()[y]);
								pstmt7.setString(11, beanobj.getCitys()[y]);
								pstmt7.setString(12, beanobj.getPincodes()[y]);
								pstmt7.setString(13, datetime.showTime("databaseinsert"));
								pstmt7.setString(14, beanobj.getCreatedby());
								pstmt7.setString(15, "A");
								pstmt7.setString(16, beanobj.getStreet2s()[y]);
								pstmt7.setString(17, beanobj.getStreet2s()[y]);
								pstmt7.setString(18, beanobj.getSmscontacts()[y]);				
								pstmt7.addBatch();	
								
								
								
								pstmt2.setLong(1, max_studentguardianid);
								pstmt2.setLong(2, max_userid);
								pstmt2.setString(3, beanobj.getGuardiannames()[y]);
								pstmt2.setString(4, beanobj.getGuardianrelation()[y]);
								pstmt2.setString(5, beanobj.getSelfemployed()[y]);
								pstmt2.setString(6, beanobj.getOrganizationnames()[y]);
								pstmt2.setString(7, beanobj.getIncome()[y]);
								pstmt2.setString(8, beanobj.getPosition()[y]);
								pstmt2.setString(9, beanobj.getCreatedby());
								pstmt2.setString(10, datetime.showTime("databaseinsert"));
								pstmt2.setString(11, beanobj.getIpaddress());
								pstmt2.setString(12, "A");
								pstmt2.setString(13, beanobj.getGuardianmails()[y]);
								pstmt2.addBatch();	
								
								max_studentguardianid++;
	
								
								pstmt3.setLong(1, max_candidateregisterid);
								pstmt3.setLong(2,max_apprvid);
								pstmt3.setString(3, beanobj.getStandardscheduleid());
								pstmt3.setLong(4,max_userid);
								pstmt3.setString(5, beanobj.getCreatedby());
								pstmt3.setString(6, datetime.showTime("databaseinsert"));
								pstmt3.setString(7, beanobj.getIpaddress());
								pstmt3.setString(8, "A");
								pstmt3.setString(9, beanobj.getPhysicallychallenged()[y]);
								pstmt3.setString(10, beanobj.getChildofexserviceman()[y]);
								pstmt3.setString(11, beanobj.getPersonalphysicalmarks()[y]);
								pstmt3.setString(12, beanobj.getPreviousSchoolDetails());
								pstmt3.setString(13, beanobj.getPreviousSchooladdress());
								pstmt3.setString(14, beanobj.getPreviousSchoolmedium());
								pstmt3.setString(15, beanobj.getTccheck());
								pstmt3.setString(16, beanobj.getCccheck());
								pstmt3.setString(17,beanobj.getSccheck());
								pstmt3.setString(18, beanobj.getMccheck());
								pstmt3.setString(19, beanobj.getMscheck());
								pstmt3.setString(20, beanobj.getSpccheck());
								pstmt3.setString(21, beanobj.getExtraCurricular());
								pstmt3.setString(22, "No");
								pstmt3.addBatch();
								System.out.println("getScholarshipamountallocationid-->"+beanobj.getScholarshipamountallocationid()[y]);
								if(!beanobj.getScholarshipamountallocationid()[y].equals("0"))
								{
									
								pstmt14.setLong(1,schemeforstudentid);
								pstmt14.setString(2,beanobj.getScholarshipamountallocationid()[y]);
								pstmt14.setLong(3,max_userid);
								pstmt14.setString(4,beanobj.getCreatedby());			
								pstmt14.setString(5,datetime.showTime("databaseinsert"));
								pstmt14.setString(6,"A");
								pstmt14.setLong(7,max_apprvid);
								
								System.out.println("----------->"+pstmt14);
								pstmt14.addBatch();
								
								fessaddstmt.setLong(1,feescollectionid);//feescollectionid
								fessaddstmt.setString(2,beanobj.getFeestermid());//termfeesid
								fessaddstmt.setLong(3,max_apprvid);//studentapprovalid
								fessaddstmt.setString(4,"-");//bankname
								fessaddstmt.setString(5,"-");//ddno	
								fessaddstmt.setString(6,null);//dddate
								
								
								
								
								amountstmt.setString(1, beanobj.getScholarshipamountallocationid()[y]);
								
								System.out.println("amountstmt"+amountstmt);
								amountrs			= amountstmt.executeQuery();
								String amount="0";
								if(amountrs.next()){
									amount				= amountrs.getString(1);
									
								}
								
								fessaddstmt.setString(7,amount);//collectionamount
								fessaddstmt.setString(8,null);//scholarshipid
								fessaddstmt.setString(9,"-");//pendingstatus
								fessaddstmt.setString(10,beanobj.getCreatedby());//createdby
								fessaddstmt.setString(11, DateTime.showTime("databaseinsert"));//feescollectiondate
								fessaddstmt.setString(12,"A");//feescollectionstatus 
								fessaddstmt.setString(13,"SCHOLAR");//paymenttype
								fessaddstmt.setLong(14,schemeforstudentid);//schemeforstudentid	
								System.out.println("fessaddstmt-->"+fessaddstmt);
								fessaddstmt.addBatch();
								feescollectionid++;
								schemeforstudentid++;
								}
								
								
								if(beanobj.getExistingstudentrollnos()[y] != null && !beanobj.getExistingstudentrollnos()[y].equals("-") && !beanobj.getExistingstudentrollnos()[y].equalsIgnoreCase("Nil") && !beanobj.getExistingstudentrollnos()[y].equalsIgnoreCase("null"))
								{
									
									pstmt9.setString(1, beanobj.getExistingstudentrollnos()[y]);
									System.out.println("pstmt9"+pstmt9);
									parentrs	= pstmt9.executeQuery();
									
								}
	
								if(parentrs != null && parentrs.next()){
									
									
									pstmt5.setLong(1, max_studentparentid);
									pstmt5.setLong(2,max_userid);
									pstmt5.setLong(3,parentrs.getLong(1));
									pstmt5.setString(4, datetime.showTime("databaseinsert"));
									pstmt5.setString(5,"A");
											
									pstmt5.addBatch();
									
									
									max_studentparentid++;
									
								}
								else{
									
									String parentpasswrd 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(parentusername);
									pstmt6.setLong(1, max_parentloginid);
									pstmt6.setString(2,parentusername);
									pstmt6.setString(3,parentpasswrd);
									pstmt6.setString(4, datetime.showTime("databaseinsert"));
									pstmt6.setString(5,beanobj.getCreatedby());
									pstmt6.setString(6,"A");
									pstmt6.addBatch();
									
									pstmt5.setLong(1, max_studentparentid);
									pstmt5.setLong(2,max_userid);
									pstmt5.setLong(3,max_parentloginid);
									pstmt5.setString(4, datetime.showTime("databaseinsert"));
									pstmt5.setString(5,"A");
											
									pstmt5.addBatch();
									
									max_studentparentid++;
									max_parentloginid++;
	
									
									
								}
								
								if(parentrs != null)
									parentrs.close();
								
								max_appissid++;
								max_regid++;
								max_apprvid++;
								max_personid++;
								max_userid++;
								max_addressid++;
								max_candidateregisterid++;
							
							}
							else
								returnids	+= max_appissid+",";
							
							if(apprors != null)
								apprors.close();
							
						}
					}

					temp		= pstmt10.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt11.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt12.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					
					temp		= pstmt1.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];

					temp		= pstmt7.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];

					
					temp		= pstmt2.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt3.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt6.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt5.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
					temp		= pstmt14.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];
					
temp		= fessaddstmt.executeBatch();	
					
					if(temp != null && temp.length>0)
						for(int y=0;y<temp.length;y++)
							result += temp[y];

					
					
					
					
					
				}
				
				beanobj.setResultstaus(returnids);
				connection.commit();

			}catch (Exception exception) {
				
				exception.printStackTrace();
				
				beanobj.setResultstaus("");
				
				result	= 0;
				
				if (connection != null)
					connection.rollback();
				
				//log.error(exception);

			} finally {
				
				if (pstmt != null)
					pstmt.close();

				if (pstmt1 != null)
					pstmt1.close();

				if (pstmt2 != null)
					pstmt2.close();

				if (pstmt3 != null)
					pstmt3.close();
				
				if (pstmt4 != null)
					pstmt4.close();
				
				if (pstmt5 != null)
					pstmt5.close();
				
				if (pstmt6 != null)
					pstmt6.close();
				
				if (pstmt7 != null)
					pstmt7.close();
				
				if(parentrs != null)
					parentrs.close();
				
				if(apprors != null)
					apprors.close();

				if (pstmt8 != null)
					pstmt8.close();
				
				if (pstmt9 != null)
					pstmt9.close();

				if (pstmt10 != null)
					pstmt10.close();

				if (pstmt11 != null)
					pstmt11.close();
				
				if (pstmt12 != null)
					pstmt12.close();
				
				if (pstmt14 != null)
					pstmt14.close();
				if (fessaddstmt != null)
					fessaddstmt.close();
				
				
				if (connection != null)
					connection.close();
				
			}
			
			return result;
		}		
		
		
		
		
		public int deletecandidate(String applicationid,String personid)throws SQLException,Exception {
			int result = 0;
			PreparedStatement pst=null;
			PreparedStatement personpst=null;
			Connection connection=null;
			String query=null;String personquery=null;

			try{
			
			connection=ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			query="update applicationissue set status=? where applicationid=?";
			personquery="update personmaster set status=? where personid=?";
			pst=connection.prepareStatement(query);
			pst.setString(1, "x");
			pst.setString(2,applicationid);
			result=pst.executeUpdate();
			personpst=connection.prepareStatement(personquery);
			personpst.setString(1,"x");
			personpst.setString(2,personid);
			result+=personpst.executeUpdate();
			System.out.println("personpst>>"+personpst);
			System.out.println("pst>>"+pst);
			connection.commit();
			
			
			}
			catch (Exception e) {
				if(connection!=null){
					
					
						
						connection.rollback();
				
				}
				
			}
			return result;
		}
		
		
		
		
		
	
		
	CommonDataAccess common_data_object;
	DateTime datetime;

	String select_query;
	
}