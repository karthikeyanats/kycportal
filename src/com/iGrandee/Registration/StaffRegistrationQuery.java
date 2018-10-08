package com.iGrandee.Registration;

import java.util.ArrayList;
import java.util.HashMap;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.SQLException;
import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.DateTime;

import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.SendMail.SendMail;

// Referenced classes of package com.iGrandee.Common:
//            CommonDataAccess

public class StaffRegistrationQuery {
	static Logger log = Logger.getLogger(StaffRegistrationQuery.class);

	public StaffRegistrationQuery() {
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
			log.error(exception);

		}
		return i;
	}
	

	public ArrayList loadcommunity(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT c.communityid,c.communityname FROM community c where c.instituteid='"+instituteid+"' and c.commstatus='A'";
			//select_query = "SELECT a.applicantname,e.standardname,f.,b.registrationid FROM applicationissue a,registration b,studentapproval c,standardschedule d,standard e,`group` f	where a.applicationid=b.applicationid and b.registrationid=c.registrationid and a.applicationno='"+applicantid+"' and c.standardscheduleid=d.standardscheduleid and d.standardid=e.standardid and d.groupid=f.groupid	and a.status='A' and b.status='A' and c.approvalstatus='A' and d.stdschedulestatus='A' and e.standardstatus='A' and f.groupstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	public ArrayList apllicantdetails(String applicationno) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT distinct a.applicantname,e.standardname,	case when d.groupid is null then 'NoGroup' else ,a.applicationno		FROM applicationissue a,		registration b,studentapproval c,standardschedule d,standard e,		standardgroup f	where a.applicationid=b.applicationid and b.registrationid=c.registrationid and		a.applicationno='"+applicationno+"' and c.standardscheduleid=d.standardscheduleid and d.standardid=e.standardid and		a.status='A' and b.status='A' and c.approvalstatus='A' and		d.stdschedulestatus='A' and e.standardstatus='A' and f.groupstatus='A'";
			//select_query = "SELECT a.applicantname,e.standardname,f.groupname,b.registrationid FROM applicationissue a,registration b,studentapproval c,standardschedule d,standard e,`group` f	where a.applicationid=b.applicationid and b.registrationid=c.registrationid and a.applicationno='"+applicantid+"' and c.standardscheduleid=d.standardscheduleid and d.standardid=e.standardid and d.groupid=f.groupid	and a.status='A' and b.status='A' and c.approvalstatus='A' and d.stdschedulestatus='A' and e.standardstatus='A' and f.groupstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/Staff_List.jsp
 	 * This method is accessed in /Kycportal/Registration/Staff_Promotion.jsp
  	 * This method is accessed in /Kycportal/Registration/Staff_registration.jsp
   	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofileupdate.jsp
	 * Load Department List
	 * Used  by maruthu
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
	public long maxuseridcount() {
		long count = 0L;
		try {
			count = common_data_object.fmaxId("select max(userid) from login");
		} catch (Exception exception) {
			log.error(exception);

		}
		return count;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/Staff_List.jsp
 	 * This method is accessed in /Kycportal/Registration/Staff_Promotion.jsp
	 * Load No of Staff  In Department
	 * Used  by maruthu
	 */
	public String departmentvisestaffcount(String departmentid) {
		String count = null;
		try {
			select_query = "SELECT count(staffid)  FROM staffmaster where departmentid='"+departmentid+"' and staffstatus in ('A','D')";
			count = common_data_object.getSingleColumn(select_query);
		} catch (Exception exception) {
			log.error(exception);

		}
		return count;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/Staffdetailview.jsp
	 * Load Staff details
	 * Used  by maruthu
	 */
	public 		ArrayList staffdetails(String staffid) {
		ArrayList count = null;
		try {
			

			select_query = "SELECT c.subjectname,h.sessionname,f.sectionname,d.standardname FROM subjectallotment a,subjectschedule b,subject c,standard d,sectionschedule e,section f,standardschedule g,yearofsession h where a.subjectscheduleid =b.subjectscheduleid and b.subjectid =c.subjectid and c.standardid =d.standardid	and a.sectionpublishid=e.sectionscheduleid and  e.sectionid=f.sectionid	and b.standardscheduleid=g.standardscheduleid and	g.sessionid=h.sessionid and a.staffid='"+staffid+"' and a.subjectallotmentstatus='A' and b.status='A' and c.subjectstatus='A' and d.standardstatus='A' and e.sectionschedulestatus='A' and f.status='A' and g.stdschedulestatus='A' and h.sessionstatus='A'";
			count = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);

		}
		return count;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/Staff_List_View.jsp
	 * This method is accessed in /Kycportal/Registration/Staff_Promotion_View.jsp
	 * Load Staff List
	 * Used  by maruthu
	 */
	public ArrayList departmentvisestaff(String departmentid) {
		ArrayList arraylist = null;

		try {
		//hidden by rams, reason=in following query userid wrongly mapped with personid, acutally in staffmaster userid = login.userid
		//	select_query = "SELECT a.roleid,r.rolename,a.staffid,case when p.middlename='-' or p.middlename='' then concat(p.prefix,' ',p.firstname,' ',p.lastname) else concat(p.prefix,' ',p.firstname,' ',p.middlename,' ',p.lastname) end as uname,a.staffstatus,p.qualification,DATE_FORMAT(a.dateofjoin,'%d-%b-%Y') as dateofjoin,a.dateofjoin as datejoin, DATEDIFF(curdate(),a.dateofjoin) as experienceday,sc.categoryname FROM staffmaster a ,personmaster p,role r,staffcategory sc  where a.staffstatus='A' and r.roleid=a.roleid and a.userid =p.personid and r.status='A' and a.departmentid='"+departmentid+"' and sc.staffcategoryid =a.staffcategoryid order by r.rolename,sc.staffcategoryid";
			select_query = "SELECT a.roleid,r.rolename,a.staffid,case when p.middlename='-' or p.middlename='' then concat(p.prefix,' ',p.firstname,' ',p.lastname) else concat(p.prefix,' ',p.firstname,' ',p.middlename,' ',p.lastname) end as uname,a.staffstatus,p.qualification,DATE_FORMAT(a.dateofjoin,'%d-%b-%Y') as dateofjoin, a.dateofjoin as datejoin, DATEDIFF(curdate(),a.dateofjoin) as experienceday, sc.categoryname,lo.username FROM  staffmaster a ,personmaster p,role r,staffcategory sc,login lo  where a.staffstatus='A' and r.roleid=a.roleid and  a.userid =lo.userid and lo.personid=p.personid  and r.status='A' and a.departmentid='"+departmentid+"' and sc.staffcategoryid =a.staffcategoryid  order by r.rolename,sc.staffcategoryid";
			System.out.println("select_query-->"+select_query );
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	
	
	public ArrayList departmentWiseDeactiveStaff(String departmentid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT a.roleid,r.rolename,a.staffid,case when p.middlename='-' or p.middlename='' then concat(p.prefix,' ',p.firstname,' ',p.lastname) else concat(p.prefix,' ',p.firstname,' ',p.middlename,' ',p.lastname) end as uname,a.staffstatus,p.qualification,DATE_FORMAT(a.dateofjoin,'%d-%b-%Y') as dateofjoin,a.dateofjoin as datejoin, DATEDIFF(curdate(),a.dateofjoin) as experienceday,sc.categoryname FROM staffmaster a ,personmaster p,role r,staffcategory sc  where a.staffstatus='D' and r.roleid=a.roleid and a.userid =p.personid and r.status='A' and a.departmentid='"+departmentid+"' and sc.staffcategoryid =a.staffcategoryid order by r.rolename,sc.staffcategoryid";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	
	/*
	 * This method is accessed in /Kycportal/Registration/StaffProviewView.jsp
	 * Load Verification Certificate List
	 * Used  by maruthu
	 */
	public ArrayList StaffVerificationCertificate(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT documentid,documentname, documentpath , l.username, l.userid FROM staffmaster s  join credentialdocument cd on s.staffid='"+staffid+"' and s.userid=cd.userid and documentstatus='A' and s.staffstatus  in ('A','D') join login l on l.userid=cd.userid";
			arraylist = common_data_object.getListMap(select_query);  
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	public ArrayList StaffCertificate(String documentid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT documentid,documentname, documentpath FROM credentialdocument cd where documentid='"+documentid+"' and documentstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			log.error(exception);
		}
		return arraylist;
	}
	public ArrayList staffprofiledetail(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT p.personid,p.qualification,l.userid,l.username,p.prefix,p.firstname,p.middlename,p.lastname,p.landlinenumber,p.mobilenumber,p.emailid,case when p.middlename='-' or p.middlename='' then concat(p.prefix,' ',p.firstname,' ',p.lastname) else concat(p.prefix,' ',p.firstname,' ',p.middlename,' ',p.lastname) end as uname,p.fathername,p.mothername,p.age,p.sex,DATE_FORMAT(p.dob,'%d-%b-%Y') as dob,p.maritalstatus,p.imagepath,s.staffstatus FROM personmaster p,staffmaster s,login l where  p.personid=l.personid and  l.userid=s.userid and s.staffid='"+staffid+"' and p.status='A' and s.staffstatus in ('A','D')";
			arraylist = common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
//	
	/*
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofileupdate.jsp
	 * Load Staff Job details
	 * Used  by maruthu
	 */
	public ArrayList staffjobdetails(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT s.userid,sc.staffcategoryid,sc.categoryname,DATE_FORMAT(s.dateofjoin,'%d-%b-%Y') as dateofjoin,d.departmentname,d.departmentid,r.rolename,r.roleid,l.usercategory FROM staffmaster s,department d,role r,staffcategory sc,login l where l.userid=s.userid and d.departmentid=s.departmentid and sc.staffcategoryid=s.staffcategoryid and r.roleid=s.roleid and s.staffid='"+staffid+"' and d.status='A' and r.status='A' and s.staffstatus in ('A','D') and sc.staffcategorystatus='A';";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			//System.out.println(select_query);
			
		} catch (Exception exception) {
		log.error(exception);

		}
		return arraylist; 
	}
	/*
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofileupdate.jsp
	 * Load Staff Experience  details
	 * Used  by maruthu
	 */
	public ArrayList staffexperiencedetails(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT u.experienceid,u.role, u.period FROM userexperience u, staffmaster s  where  u.userid=s.userid and s.staffid='"+staffid+"' and u.uexperiencestatus='A' and s.staffstatus in ('A','D')";
			arraylist = common_data_object.getListMap(select_query);   
			//log.info("==========>>>>>"+arraylist);
			//System.out.println("==========>>>>>"+select_query);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofileupdate.jsp
	 * Load Staff Extra Activity details
	 * Used  by maruthu
	 */
	public ArrayList staffExtradetails(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT p.userid,p.areaofinterest, p.publications FROM staffextraactivity p, staffmaster s where p.userid=s.userid and s.staffid='"+staffid+"' and p.staffextrastatus='A' and s.staffstatus in ('A','D')";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofileupdate.jsp
	 * Load Staff qualification details
	 * Used  by maruthu
	 */
	public ArrayList staffqualificationdetail(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT p.staffqualificationid,p.major, p.areaofqualification, p.yearofgraduation, p.precentage, p.college FROM staffqualification p, staffmaster s where p.userid=s.userid and s.staffid='"+staffid+"' and p.staffqualificationstatus='A' and s.staffstatus in ('A','D')";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/Staffcontactprofileupdate.jsp
	 * load Staff Contact details
	 * Used  by maruthu
	 */
	public ArrayList staffaddressprofiledetail(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT pm.personid,pm.landlinenumber,pm.mobilenumber,pm.emailid,p.communicationstreet1, p.communicationstreet2, p.communicationstate, p.communicationcountry,p.communicationcity, p.communicationpin, p.permanentstreet1, p.permanentstreet2, p.permanentstate, p.permanentcountry, p.permanentcity, p.permanentpin,p.smscontactno FROM personaddress p,staffmaster s,personmaster pm where pm.personid=p.personid and p.personid=s.userid and s.staffid='"+staffid+"' and p.peraddstatus='A' and s.staffstatus in ('A','D')";
			arraylist = common_data_object.getListMap(select_query);
			log.info("==========>>>>>"+arraylist);
			log.info("==========>>>>>"+select_query);

			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
		public ArrayList departmentvisestafftrashlist(String departmentid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT a.roleid,a.staffid,case when p.middlename='-' or p.middlename='' then concat(p.firstname,' ',p.lastname) else concat(p.firstname,' ',p.middlename,' ',p.lastname) end as uname,staffstatus FROM staffmaster a ,personmaster p where a.staffstatus='T' and a.userid =p.personid and a.departmentid='"+departmentid+"'";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
		/*
		 * This method is accessed in /Kycportal/Registration/Staff_registration.jsp
		 * This method is accessed in /Kycportal/Registration/StaffExperienceprofileupdate.jsp
		 * Load Role List
		 * Used  by maruthu
		 */
	public ArrayList roleload(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "select roleid,rolename from role where status='A' and instituteid="+instituteid;
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/Staffcontactprofilesubmit.jsp
	 * update Staff Contact details
	 * Used  by maruthu
	 */
	public int Staffpersonalcontactupdate(StaffRegistrationBean beanobj) throws SQLException {
		int result = 0;
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt7 = null;

		
	 	log.info("invoking Staffpersonalcontactupdate for Student contact update");

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
			pstmt7.setString(5, beanobj.getZipCode());
			pstmt7.setString(6, beanobj.getpermanentStreet1());
			log.info("personaddressupdate================>>"+beanobj.getpermanentState());

			pstmt7.setString(7, beanobj.getpermanentState());
			pstmt7.setString(8, beanobj.getpermanentCountry());
			pstmt7.setString(9, beanobj.getpermanentCity());
			pstmt7.setString(10, beanobj.getpermanentZipCode());
			pstmt7.setString(11, beanobj.getStreet2());
			pstmt7.setString(12, beanobj.getpermanentStreet2());
			pstmt7.setString(13, beanobj.getSmsmobile()); 

			pstmt7.setString(14, beanobj.getPersonId()); 
			result += pstmt7.executeUpdate();
			log.info("personaddressupdate================>>");

			log.info("personaddressupdate================>>"+pstmt7);
			
			// connection = ConnectionManager.getKycConnection();
			Query = "update  personmaster set  landlinenumber=?,emailid=?,mobilenumber=? where personid=?";
			pstmt = connection.prepareStatement(Query);
			pstmt.setString(1, beanobj.getPhone());
			pstmt.setString(2, beanobj.getEMail());
			pstmt.setString(3, beanobj.getMobile());
			pstmt.setString(4, beanobj.getPersonId());
		    result += pstmt.executeUpdate();
			log.info("personmasterupdate================>>");
			connection.commit();
			log.info("PersonmasterUpdateCompleted");

			
		} catch (Exception exception) {
			exception.printStackTrace();
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
	public int Staffpersonalprofileupdate(StaffRegistrationBean beanobj) throws SQLException {
		int result = 0;
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt7 = null;

		
	 	log.info("invoking Staffpersonalcontactupdate for Student contact update");

		String Query = "";
		Connection connection = null;

		try {
			connection = ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			
			// connection = ConnectionManager.getKycConnection();
			Query = "update  personmaster set  firstname=?, middlename=?, lastname=?, fathername=?, mothername=?, sex=?, dob=?,maritalstatus=?,age=?,imagepath=?,prefix=?,qualification=? where personid=?";
			pstmt = connection.prepareStatement(Query);
			pstmt.setString(1, beanobj.getFirstName());
			pstmt.setString(2, beanobj.getMidName());
			pstmt.setString(3, beanobj.getLastName());
			log.info( beanobj.getMotherName()+"===="+beanobj.getQualification()+"===="+beanobj.getFatherName());
			pstmt.setString(4, beanobj.getFatherName());
			pstmt.setString(5, beanobj.getMotherName());
			pstmt.setString(6, beanobj.getGender());
			pstmt.setString(7, beanobj.getDOB());
			pstmt.setString(8, beanobj.getMStatus());
			pstmt.setString(9, beanobj.getAge());
			pstmt.setString(10, beanobj.getPhoto());
			pstmt.setString(11, beanobj.getprefix());
			pstmt.setString(12, beanobj.getQualification());
			pstmt.setString(13,  beanobj.getPersonId());

		    result += pstmt.executeUpdate();
			log.info("personmasterupdate================>>");
			connection.commit();
			log.info("PersonmasterUpdateCompleted");

			
		} catch (Exception exception) {
			exception.printStackTrace();
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
	/*
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofilesubmit.jsp
	 * update staffs Experience details 
	 * Used  by maruthu
	 */
	public int Staffverificationcertificatedelete(StaffRegistrationBean beanobj) throws SQLException {
		int result = 0;
		PreparedStatement pstmt2 = null;
		 	
		log.info("invoking Staffpersonalcontactupdate for Student contact update");
		String Query = "";
		Connection connection = null;
		String documentid  [] = null;
		try {
			connection = ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			documentid  = beanobj.getDocumentid(); 
			if(documentid.length>0)
			{
				for(int i=0;i<documentid.length;i++)
				{
					Query = "update credentialdocument set  documentstatus=?  where documentid=?";
					pstmt2 = connection.prepareStatement(Query);
					pstmt2.setString(1, "X");
					pstmt2.setString(2, documentid[i]);
					result += pstmt2.executeUpdate();
				}
			}
							
			connection.commit();
						
		} catch (Exception exception) {
			exception.printStackTrace();
				log.error(exception);
			return 0;
		} finally {
			if (pstmt2 != null)
				pstmt2.close();
									
			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofilesubmit.jsp
	 * update staffs Experience details 
	 * Used  by maruthu
	 */
	public int Staffverificationcertificateupdate(StaffRegistrationBean beanobj) throws SQLException {
		int result = 0;
		PreparedStatement pstmt2 = null;
			 	
		log.info("invoking Staffverificationcertificateupdate for Student certificate update");
		String Query = "";
		Connection connection = null;
		String documentname = beanobj.getDocumentName();
		String documentpath = beanobj.getDocumentpath();
		String documentid  [] = beanobj.getDocumentid();
	  
		try {
			connection = ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
				Query = "update credentialdocument set  documentname=?,documentpath=?  where documentid=?";
				pstmt2 = connection.prepareStatement(Query);
				pstmt2.setString(1, documentname);
				pstmt2.setString(2, documentpath);
				pstmt2.setString(3, documentid[0]);
				result += pstmt2.executeUpdate();  
			connection.commit();
		} catch (Exception exception) {
			exception.printStackTrace();
				log.error(exception);
			return 0;
		} finally {
			if (pstmt2 != null)
				pstmt2.close();
									
			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofilesubmit.jsp
	 * update staffs Experience details 
	 * Used  by maruthu
	 */
	public int Staffverificationcertificateinsert(StaffRegistrationBean beanobj) throws SQLException {
		int result = 0;
		PreparedStatement pstmt2 = null;
			 	
		log.info("invoking Staffverificationcertificateupdate for Student certificate update");
		String Query = "";
		Connection connection = null;
		String documentname = beanobj.getDocumentName();
		String documentpath = beanobj.getDocumentpath();
		String max_userid = beanobj.getPersonId();
		String created = beanobj.getUserId();

		try {
			long max_documentid = common_data_object.fmaxId("select max(documentid) from credentialdocument");

			connection = ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			Query = "insert into credentialdocument(documentid, documentname, documentpath, userid, dateofcreation, createdby, documentstatus) values(?,?,?,?,?,?,?)";
			pstmt2 = connection.prepareStatement(Query);
			pstmt2.setLong(1, max_documentid);
			pstmt2.setString(2,documentname);
			pstmt2.setString(3, documentpath);
			pstmt2.setString(4, max_userid);
			pstmt2.setString(5, datetime.showTime("databaseinsert"));
			pstmt2.setString(6, created);
			pstmt2.setString(7, "A");
			result += pstmt2.executeUpdate();
			connection.commit();
		} catch (Exception exception) {
			exception.printStackTrace();
				log.error(exception);
			return 0;
		} finally {
			if (pstmt2 != null)
				pstmt2.close();
									
			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofilesubmit.jsp
	 * update staffs Experience details 
	 * Used  by maruthu
	 */
	public int Staffpersonalexperienceupdate(StaffRegistrationBean beanobj) throws SQLException {
		int result = 0;
		
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		PreparedStatement pstmt6 = null;
		PreparedStatement pstmt7 = null;

		
	 	log.info("invoking Staffpersonalcontactupdate for Student contact update");

		String Query = "";
		Connection connection = null;
		String major[] = null;
		String user_qualification[] = null;
		String Yearofgrad[] = null;
		String marks[] = null;
		String institutename[] = null;
		String created=beanobj.getUserId();
		String userid=beanobj.getPersonId();

		String departid =beanobj.getDepartment();
		String roleid =beanobj.getRole();
		long max_stafflogid = common_data_object.fmaxId("select max(stafflogid) from staffmasterlog");
		long max_staffqualificationid = common_data_object.fmaxId("select max(staffqualificationid) from staffqualification");
		long max_experienceid = common_data_object.fmaxId("select max(experienceid) from userexperience");

		String dateofjoin =beanobj.getJoiningDate();
		String role[] =beanobj.getinstRole();
		String period[] =beanobj.getinstPeriod();
		
		String areaofinterest =beanobj.getAreaOfInterest();
		String publication =beanobj.getPubliCations();
		
		String jobcategory =beanobj.getPost();
		try {
			connection = ConnectionManager.getKycConnection(); 
			connection.setAutoCommit(false);
			Query = "update staffmaster set  departmentid=?, roleid=?, dateofjoin=?,staffcategoryid=? where staffid=?";
			pstmt2 = connection.prepareStatement(Query);
			pstmt2.setString(1, departid);
			pstmt2.setString(2, roleid);
			pstmt2.setString(3, dateofjoin);
			pstmt2.setString(4, jobcategory);
			log.info("staffmaster beanobj.getStaffid()================>>"+ beanobj.getStaffid());

			pstmt2.setString(5, beanobj.getStaffid());
			
			result += pstmt2.executeUpdate();
			
			log.info("staffmaster================>>");
			
			String jobtype= common_data_object.getString("SELECT categoryname FROM staffcategory s where staffcategoryid='"+jobcategory+"'");
			String logintype= common_data_object.getString("SELECT rolename FROM role r where roleid='"+roleid+"'");

			//System.out.println("jobtype================>>"+jobtype);
			
			if(jobtype.equalsIgnoreCase("Headmaster") || jobtype.equalsIgnoreCase("HM"))
			{
				Query = "update login set  usercategory=? where userid=?";
				pstmt7 = connection.prepareStatement(Query);
				pstmt7.setString(1, "HM");
				pstmt7.setString(2, userid);
				result += pstmt7.executeUpdate();
			}
			else if(jobtype.startsWith("Library") || logintype.equalsIgnoreCase("Library Administrator"))
			{
				Query = "update login set  usercategory=? where userid=?";
				pstmt7 = connection.prepareStatement(Query);
				pstmt7.setString(1, "LA");
				pstmt7.setString(2, userid);
				result += pstmt7.executeUpdate();
			}
			else if(logintype.equalsIgnoreCase("Administrator") || logintype.equalsIgnoreCase("admin") || logintype.startsWith("Admin"))
			{
				Query = "update login set  usercategory=? where userid=?";
				pstmt7 = connection.prepareStatement(Query);
				pstmt7.setString(1, "SA");
				pstmt7.setString(2, userid);
				result += pstmt7.executeUpdate();
			}
			else
			{
				Query = "update login set  usercategory=? where userid=?";
				pstmt7 = connection.prepareStatement(Query);
				pstmt7.setString(1, "T");
				pstmt7.setString(2, userid);
				result += pstmt7.executeUpdate();
			}
			Query = "insert into  staffmasterlog(stafflogid, staffid, roleid, dateofcreation, stafflogdetail, createdby, ipaddress, stafflogstatus) values(?,?,?,?,?,?,?,?)";
			pstmt3 = connection.prepareStatement(Query);
			pstmt3.setLong(1, max_stafflogid);
			pstmt3.setString(2, beanobj.getStaffid());
			pstmt3.setString(3, roleid);
			pstmt3.setString(4, datetime.showTime("databaseinsert"));
			pstmt3.setString(5, "Updated");
			pstmt3.setString(6, created);
			pstmt3.setString(7, beanobj.getipaddress());
			pstmt3.setString(8, "A");
			result += pstmt3.executeUpdate();
			
			log.info("staffmasterlog================>>");

			
			major=beanobj.getmajor();
			user_qualification=beanobj.getuser_qualification();
			Yearofgrad=beanobj.getYearofgrad();
			marks=beanobj.getmarks();
			institutename=beanobj.getinstitutename();
			String [] Staffqualificationid=beanobj.getStaffqualificationid();
			String [] Updatestatus=beanobj.getUpdatestatus();

			if(major!=null && major.length>0)
			{
				for(int i=0;i<major.length;i++)
				{
					if(Staffqualificationid!=null && Staffqualificationid.length>0 && i<Staffqualificationid.length)
					{
					Query = "update staffqualification set major=?, areaofqualification=?, yearofgraduation=?, precentage=?, college=?,staffqualificationstatus =? where   staffqualificationid=?";
					pstmt4 = connection.prepareStatement(Query);
					pstmt4.setString(1, major[i]);
					pstmt4.setString(2, user_qualification[i]);
					pstmt4.setString(3, Yearofgrad[i]);
					pstmt4.setString(4, marks[i]);
					pstmt4.setString(5, institutename[i]);
					if(Updatestatus[i].equals("U"))
						pstmt4.setString(6, "A");
					else
						pstmt4.setString(6, "X");
					pstmt4.setString(7, Staffqualificationid[i]);
					result += pstmt4.executeUpdate();
					}
					else if(Updatestatus[i].equals("A"))
					{
						Query = "insert into staffqualification(staffqualificationid, major, areaofqualification, yearofgraduation, precentage, college, createdby, dateofcreation, userid, staffqualificationstatus) values(?,?,?,?,?,?,?,?,?,?)";
						pstmt4 = connection.prepareStatement(Query);
						pstmt4.setLong(1, max_staffqualificationid);
						pstmt4.setString(2, major[i]);
						pstmt4.setString(3, user_qualification[i]);
						pstmt4.setString(4, Yearofgrad[i]);
						pstmt4.setString(5, marks[i]);
						pstmt4.setString(6, institutename[i]);
						pstmt4.setString(7, created);
						pstmt4.setString(8, datetime.showTime("databaseinsert"));
						pstmt4.setString(9, userid);
						pstmt4.setString(10, "A");
						result += pstmt4.executeUpdate();
						max_staffqualificationid++;
					}
				}
			}
			log.info("staffqualification================>>");
			String [] Staffexperienceid=beanobj.getStaffexperienceid();
			String [] Updatestatus1=beanobj.getUpdatestatus1();
			if(role!=null && role.length>0 )
			{
			for(int i=0;i<role.length;i++)
			{
				if(Staffexperienceid!=null && Staffexperienceid.length>0 && i<Staffexperienceid.length)
				{
					Query = "update userexperience set role=?, period =?, uexperiencestatus=? where userid=? and experienceid=?";
					pstmt5 = connection.prepareStatement(Query);
					pstmt5.setString(1,role[i]);
					pstmt5.setString(2, period[i]);
					if(Updatestatus1[i].equals("U"))
						pstmt5.setString(3, "A");
					else
						pstmt5.setString(3, "X");
					pstmt5.setString(4, userid);
					pstmt5.setString(5, Staffexperienceid[i]);
					
					result += pstmt5.executeUpdate();
				}
				else if(Updatestatus1[i].equals("A"))
				{
					Query = "insert into userexperience(experienceid, role, period, createdby, dateofcreation, ipaddress, userid, uexperiencestatus) values(?,?,?,?,?,?,?,?)";
					pstmt5 = connection.prepareStatement(Query);
					pstmt5.setLong(1, max_experienceid);
					pstmt5.setString(2,role[i]);
					pstmt5.setString(3, period[i]);
					pstmt5.setString(4, created);
					pstmt5.setString(5, datetime.showTime("databaseinsert"));
					pstmt5.setString(6,  beanobj.getipaddress());
					pstmt5.setString(7, userid);
					pstmt5.setString(8, "A");
					result += pstmt5.executeUpdate();
					max_experienceid++;
				}
			}
			}
			log.info("userexperience================>>");
			Query = "update  staffextraactivity set  areaofinterest=?, publications=? where userid=?";
			pstmt6 = connection.prepareStatement(Query);
			pstmt6.setString(1, areaofinterest);
			pstmt6.setString(2, publication);
			pstmt6.setString(3, userid);
			result += pstmt6.executeUpdate();
			log.info("staffextraactivity================>>");

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
			if (pstmt5 != null)
				pstmt5.close();
			if (pstmt6 != null)
				pstmt6.close();
						
			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	/*
	 * This method is accessed in /Kycportal/Registration/Staff_registration.jsp
	 * This method is accessed in /Kycportal/Registration/StaffExperienceprofileupdate.jsp
	 * Load Job Category  List
	 * Used  by maruthu
	 */
	public ArrayList jobcategoryload(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "select staffcategoryid,categoryname from staffcategory where staffcategorystatus='A' and instituteid="+instituteid;
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	public ArrayList stafflogviewload(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT DATE_FORMAT(s.dateofcreation,'%d-%m-%Y') as dateofcreation,s.stafflogdetail,r.rolename FROM staffmasterlog s,role r where s.staffid='"+staffid+"' and s.roleid=r.roleid";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	public ArrayList checkstaffusercategory(String createdby) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT l.personid,l.userid,s.staffid FROM staffmaster s join login l on l.userid=s.userid  and l.createdby=s.createdby and l.createdby='"+createdby+"' and s.staffstatus='A' and l.loginstatus='A' and l.usercategory='HM'";
			arraylist = common_data_object.getListMap(select_query);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
	
	
	
	public int StaffStatusupdate(String Staffid,String status,String ipaddress,String created,String roleid) throws SQLException {
		String Query="";
		int result = 0;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt3 = null;

		Connection connection = null;
		try
		{
		connection = ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		long max_stafflogid = common_data_object.fmaxId("select max(stafflogid) from staffmasterlog");

		Query = "update staffmaster set staffstatus=? where staffid=?";
		pstmt = connection.prepareStatement(Query);
		pstmt.setString(1, status);
		pstmt.setString(2, Staffid);
		result += pstmt.executeUpdate();
		
		Query = "insert into staffmasterlog(stafflogid, staffid, roleid, dateofcreation, stafflogdetail, createdby, ipaddress, stafflogstatus) values(?,?,?,?,?,?,?,?)";
		pstmt3 = connection.prepareStatement(Query);
		pstmt3.setLong(1, max_stafflogid);
		pstmt3.setString(2, Staffid);
		pstmt3.setString(3, roleid);
		pstmt3.setString(4, datetime.showTime("databaseinsert"));
		pstmt3.setString(5, "Updated");
		pstmt3.setString(6, created);
		pstmt3.setString(7, ipaddress);
		pstmt3.setString(8, "A");
		result += pstmt3.executeUpdate();
		connection.commit();
		
		} catch (Exception exception) {
			connection.rollback();
			log.error(exception);
			return 0;
		}
		finally {
			if (pstmt != null)
				pstmt.close();
			
			if (pstmt3 != null)
				pstmt3.close();
									
			if (connection != null)
				connection.close();
			
		}
		return result;

	}
	public int Staffprmotionupdate(String Staffid,String Departid,String ipaddress,String created,String roleid,String status,String categoryid,String Staffuserid) throws SQLException {
		String Query="";
		int result = 0;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt2 = null;

		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt7 = null;


		Connection connection = null;
		try
		{
		connection = ConnectionManager.getKycConnection();
		connection.setAutoCommit(false);
		
		long max_stafflogid = common_data_object.fmaxId("select max(stafflogid) from staffmasterlog");

		
		
		Query = "update staffmaster set departmentid=?,roleid=?, createdby=?, dateofcreation=?, ipaddress=?, staffcategoryid=? where staffid=?";
		pstmt = connection.prepareStatement(Query);
		pstmt.setString(1, Departid);
		pstmt.setString(2, roleid);
		pstmt.setString(3, created);
		pstmt.setString(4, datetime.showTime("databaseinsert"));
		pstmt.setString(5, ipaddress);
		pstmt.setString(6, categoryid);
		pstmt.setString(7, Staffid);
		result += pstmt.executeUpdate();
		String logintype= common_data_object.getString("SELECT rolename FROM role r where roleid='"+roleid+"'");
		String jobtype= common_data_object.getString("SELECT categoryname FROM staffcategory s where staffcategoryid='"+categoryid+"'");
		//System.out.println("jobtype=========>>>>>>>>>>>>>"+jobtype);
		//System.out.println("logintype=========>>>>>>>>>>>>>"+logintype);

		if(jobtype.equalsIgnoreCase("Headmaster") || jobtype.equalsIgnoreCase("HM"))
		{
			Query = "update login set  usercategory=? where userid=?";
			pstmt7 = connection.prepareStatement(Query);
			pstmt7.setString(1, "HM");
			pstmt7.setString(2, Staffuserid);
			result += pstmt7.executeUpdate();
			//System.out.println("result=========>>>>>>>>>>>>>"+result);
		}
		else if(logintype.equalsIgnoreCase("Administrator") || logintype.equalsIgnoreCase("admin") || logintype.startsWith("Admin"))
		{
			Query = "update login set  usercategory=? where userid=?";
			pstmt7 = connection.prepareStatement(Query);
			pstmt7.setString(1, "SA");
			pstmt7.setString(2, Staffuserid);
			result += pstmt7.executeUpdate();
		}
		else
		{
			Query = "update login set  usercategory=? where userid=?";
			pstmt7 = connection.prepareStatement(Query);
			pstmt7.setString(1, "T");
			pstmt7.setString(2, Staffuserid);
			result += pstmt7.executeUpdate();
		}
		
		Query = "update staffmasterlog set stafflogstatus = ? where staffid = ? ";
		pstmt2 = connection.prepareStatement(Query);
		pstmt2.setString(1, "D");
		pstmt2.setString(2, Staffid);
		result += pstmt2.executeUpdate();
		//System.out.println("result=========>>>>>>>>>>>>>"+result);
		//System.out.println("Staffid=========>>>>>>>>>>>>>"+Staffid);

		Query = "insert into staffmasterlog(stafflogid, staffid, roleid, dateofcreation, stafflogdetail, createdby, ipaddress, stafflogstatus) values(?,?,?,?,?,?,?,?)";
		pstmt3 = connection.prepareStatement(Query);
		pstmt3.setLong(1, max_stafflogid);
		pstmt3.setString(2, Staffid);
		pstmt3.setString(3, roleid);
		pstmt3.setString(4, datetime.showTime("databaseinsert"));
	if(status.equals("P"))
		pstmt3.setString(5, "promoted");
	else if(status.equals("DP"))
		pstmt3.setString(5, "Depromoted");

		pstmt3.setString(6, created);
		pstmt3.setString(7, ipaddress);
		pstmt3.setString(8, "A");
		result += pstmt3.executeUpdate();
		//System.out.println("result=========>>>>>>>>>>>>>"+result);

		connection.commit();
		
		} catch (Exception exception) {
			connection.rollback();
			log.error(exception);
			return 0;
		}
		finally {
			if (pstmt != null)
				pstmt.close();
			
			if (pstmt3 != null)
				pstmt3.close();
									
			if (connection != null)
				connection.close();
			
		}
		return result;

	}
	
		// Modified by Subhash in order to send mail soon after the registration.
		// after finally block

		public int StaffRegistration(StaffRegistrationBean beanobj) throws SQLException {
		int result = 0;
		
		String prefix = beanobj.getprefix();
		String qualification = beanobj.getQualification();
		
		String firstname = beanobj.getFirstName();
		String midname = beanobj.getMidName();
		String lastname = beanobj.getLastName();
		
		String fathername = beanobj.getFatherName();
		String mothername = beanobj.getMotherName();
		
		String created=beanobj.getUserId();

		String username=beanobj.getUserName();
		String password =beanobj.getPassWd();
		
		String photo=beanobj.getPhoto();
		String gender = beanobj.getGender();
		
		String mstatus =beanobj.getMStatus();
		String dob =beanobj.getDOB();

		String landline =beanobj.getLandLine();
		String mobileno =beanobj.getMobile();

		String emidid =beanobj.getEMail();
		
		String ipaddress =beanobj.getipaddress();
		
		String instituteid =beanobj.getInstituteId();

		String departid =beanobj.getDepartment();
		String roleid =beanobj.getRole();

		String dateofjoin =beanobj.getJoiningDate();
		String role[] =beanobj.getinstRole();
		String period[] =beanobj.getinstPeriod();
		
		String areaofinterest =beanobj.getAreaOfInterest();
		String publication =beanobj.getPubliCations();
		
		String jobcategory =beanobj.getPost();


		String street1 =beanobj.getStreet1();
		String street2 =beanobj.getStreet2();
		String city =beanobj.getCity();
		String state =beanobj.getState();
		String country =beanobj.getCountry();
		String zipcode =beanobj.getZipCode();

		String permanentstreet1 =beanobj.getpermanentStreet1();
		String permanentstreet2 =beanobj.getpermanentStreet2();
		String permanentcity =beanobj.getpermanentCity();
		String permanentstate =beanobj.getpermanentState();
		String permanentcountry =beanobj.getpermanentCountry();
		String permanentzipcode =beanobj.getpermanentZipCode();

		String major[] = null;
		String user_qualification[] = null;
		String Yearofgrad[] = null;
		String marks[] = null;
		String institutename[] = null;
		
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;
		PreparedStatement pstmt3 = null;
		PreparedStatement pstmt4 = null;
		PreparedStatement pstmt5 = null;
		PreparedStatement pstmt6 = null;
		PreparedStatement pstmt7 = null;
		PreparedStatement pstmt8 = null;

		String Query = "";
		Connection connection = null;

		try {
			
			if(common_data_object.checkDuplicate("login","username",username))
			{
				result=1000;
			}
			else
			{
				long max_userid = common_data_object.fmaxId("select max(userid) from login");
				long max_personid = common_data_object.fmaxId("select max(personid) from personmaster");
				long max_staffid = common_data_object.fmaxId("select max(staffid) from staffmaster");
				long max_stafflogid = common_data_object.fmaxId("select max(stafflogid) from staffmasterlog");
				long max_staffqualificationid = common_data_object.fmaxId("select max(staffqualificationid) from staffqualification");
				//log.info(max_personid + "================"	+ max_instituteid);
				//log.info(beanobj.gettxt_street2()+ "===============gettxt_street2");
				long max_experienceid = common_data_object.fmaxId("select max(experienceid) from userexperience");
				long max_staffextraid = common_data_object.fmaxId("select max(staffextraid) from staffextraactivity");
				long max_addressid = common_data_object.fmaxId("select max(addressid) from personaddress");
	
				long max_documentid = common_data_object.fmaxId("select max(documentid) from credentialdocument");
	
				connection = ConnectionManager.getKycConnection();
				connection.setAutoCommit(false);
				// connection = ConnectionManager.getKycConnection();
				Query = "insert into personmaster(personid,firstname, middlename, lastname, fathername, mothername, sex, dob,maritalstatus, landlinenumber, mobilenumber, emailid, imagepath, dateofcreation, createdby, ipaddress, instituteid, status,prefix, qualification,age) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt = connection.prepareStatement(Query);
				pstmt.setLong(1, max_personid);
				pstmt.setString(2, firstname);
				pstmt.setString(3, midname);
				pstmt.setString(4, lastname);
				pstmt.setString(5, fathername);
				pstmt.setString(6, mothername);
				pstmt.setString(7, gender);
				pstmt.setString(8, dob);
				pstmt.setString(9, mstatus);
				pstmt.setString(10, landline);
				pstmt.setString(11, mobileno);
				pstmt.setString(12, emidid);
				pstmt.setString(13, photo);
				pstmt.setString(14, datetime.showTime("databaseinsert"));
				pstmt.setString(15, created);
				pstmt.setString(16, ipaddress);
				pstmt.setString(17, instituteid);
				pstmt.setString(18, "A");
				pstmt.setString(19, prefix);
				pstmt.setString(20, qualification);
				pstmt.setString(21, beanobj.getAge());
	
				result += pstmt.executeUpdate();
				log.info("personmaster================>>");
	
				Query = "insert into login(userid, username, password, usercategory, personid, dateofcreation, createdby, ipaddress, loginstatus) values(?,?,?,?,?,?,?,?,?)";
				pstmt1 = connection.prepareStatement(Query);
				pstmt1.setLong(1, max_userid);
				pstmt1.setString(2, username);
				//password encryption done here
				password 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(password);

				pstmt1.setString(3, password);
				
				String jobtype= common_data_object.getString("SELECT categoryname FROM staffcategory s where staffcategoryid='"+jobcategory+"'");
				if(jobtype.equalsIgnoreCase("Headmaster") || jobtype.equalsIgnoreCase("HM"))
				{
						pstmt1.setString(4, "HM");
				}
				else if(jobtype.startsWith("Library") || jobtype.equalsIgnoreCase("Library Administrator"))
				{
						pstmt1.setString(4, "LA");
				}
				else if(jobtype.startsWith("Financiar"))
				{
						pstmt1.setString(4, "F");
				}
				else
				{
					pstmt1.setString(4, "T");
				}
	
				pstmt1.setLong(5, max_personid);
				pstmt1.setString(6, datetime.showTime("databaseinsert"));
				pstmt1.setString(7, created);
				pstmt1.setString(8, ipaddress);
				pstmt1.setString(9, "A");
				result += pstmt1.executeUpdate();
				log.info("login================>>");
	
				
				Query = "insert into staffmaster(staffid, departmentid, roleid, dateofjoin, createdby, dateofcreation, ipaddress, userid, staffstatus,staffcategoryid) values(?,?,?,?,?,?,?,?,?,?)";
				pstmt2 = connection.prepareStatement(Query);
				pstmt2.setLong(1, max_staffid);
				pstmt2.setString(2, departid);
				pstmt2.setString(3, roleid);
				pstmt2.setString(4, dateofjoin);
				pstmt2.setString(5, created);
				pstmt2.setString(6, datetime.showTime("databaseinsert"));
				pstmt2.setString(7, ipaddress);
				pstmt2.setLong(8, max_userid);
				pstmt2.setString(9, "A");
				pstmt2.setString(10, jobcategory);
	
				result += pstmt2.executeUpdate();
				
				log.info("staffmaster================>>");
	
				Query = "insert into staffmasterlog(stafflogid, staffid, roleid, dateofcreation, stafflogdetail, createdby, ipaddress, stafflogstatus) values(?,?,?,?,?,?,?,?)";
				pstmt3 = connection.prepareStatement(Query);
				pstmt3.setLong(1, max_stafflogid);
				pstmt3.setLong(2, max_staffid);
				pstmt3.setString(3, roleid);
				pstmt3.setString(4, datetime.showTime("databaseinsert"));
				pstmt3.setString(5, "Created");
				pstmt3.setString(6, created);
				pstmt3.setString(7, ipaddress);
				pstmt3.setString(8, "A");
				result += pstmt3.executeUpdate();
				
				log.info("staffmasterlog================>>");
	
				
				major=beanobj.getmajor();
				user_qualification=beanobj.getuser_qualification();
				Yearofgrad=beanobj.getYearofgrad();
				marks=beanobj.getmarks();
				institutename=beanobj.getinstitutename();
	
				if(major.length>0)
				{
				for(int i=0;i<major.length;i++)
				{
				Query = "insert into staffqualification(staffqualificationid, major, areaofqualification, yearofgraduation, precentage, college, createdby, dateofcreation, userid, staffqualificationstatus) values(?,?,?,?,?,?,?,?,?,?)";
				pstmt4 = connection.prepareStatement(Query);
				pstmt4.setLong(1, max_staffqualificationid);
				pstmt4.setString(2, major[i]);
				pstmt4.setString(3, user_qualification[i]);
				pstmt4.setString(4, Yearofgrad[i]);
				pstmt4.setString(5, marks[i]);
				pstmt4.setString(6, institutename[i]);
				pstmt4.setString(7, created);
				pstmt4.setString(8, datetime.showTime("databaseinsert"));
				pstmt4.setLong(9, max_userid);
				pstmt4.setString(10, "A");
				result += pstmt4.executeUpdate();
				max_staffqualificationid++;
				}
				}
				log.info("staffqualification================>>");
				if(role!=null && role.length>0 )
				{
					for(int i=0;i<role.length;i++)
					{
						Query = "insert into userexperience(experienceid, role, period, createdby, dateofcreation, ipaddress, userid, uexperiencestatus) values(?,?,?,?,?,?,?,?)";
						pstmt5 = connection.prepareStatement(Query);
						pstmt5.setLong(1, max_experienceid);
						pstmt5.setString(2,role[i]);
						pstmt5.setString(3, period[i]);
						pstmt5.setString(4, created);
						pstmt5.setString(5, datetime.showTime("databaseinsert"));
						pstmt5.setString(6, ipaddress);
						pstmt5.setLong(7, max_userid);
						pstmt5.setString(8, "A");
						result += pstmt5.executeUpdate();
						max_experienceid++;
					}
				}
				log.info("userexperience================>>");
	
				String certificatename[] =beanobj.getVerficertificatename();
				String certificatepath[] =beanobj.getVerficertificatepath();   
				if(certificatepath!=null && certificatepath.length>0 && certificatename!=null && certificatename.length>0)
				{
					for(int i=0;i<certificatepath.length;i++)
					{
						Query = "insert into credentialdocument(documentid, documentname, documentpath, userid, dateofcreation, createdby, documentstatus) values(?,?,?,?,?,?,?)";
						pstmt8 = connection.prepareStatement(Query);
						pstmt8.setLong(1, max_documentid);
						pstmt8.setString(2,certificatename[i]);
						pstmt8.setString(3, certificatepath[i]);
						pstmt8.setLong(4, max_userid);
						pstmt8.setString(5, datetime.showTime("databaseinsert"));
						pstmt8.setString(6, created);
						pstmt8.setString(7, "A");
						result += pstmt8.executeUpdate();
						max_documentid++;  
					}
				}
				log.info("credentialdocument================>>");
	
				Query = "insert into staffextraactivity(staffextraid, areaofinterest, publications, userid, createdby, dateofcreation, ipaddress, staffextrastatus) values(?,?,?,?,?,?,?,?)";
				pstmt6 = connection.prepareStatement(Query);
				pstmt6.setLong(1, max_staffextraid);
				pstmt6.setString(2, areaofinterest);
				pstmt6.setString(3, publication);
				pstmt6.setLong(4, max_userid);
				pstmt6.setString(5, created);
				pstmt6.setString(6, datetime.showTime("databaseinsert"));
				pstmt6.setString(7, ipaddress);
				pstmt6.setString(8, "A");
				result += pstmt6.executeUpdate();
				log.info("staffextraactivity================>>");
	
			
				Query = "insert into personaddress(addressid, personid, communicationstreet1, communicationstreet2, communicationstate, communicationcountry, communicationcity, communicationpin, permanentstreet1, permanentstreet2, permanentstate, permanentcountry, permanentcity, permanentpin, dateofcreation, createdby, peraddstatus,smscontactno) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
				pstmt7 = connection.prepareStatement(Query);
				pstmt7.setLong(1, max_addressid);
				pstmt7.setLong(2, max_personid);
				pstmt7.setString(3, street1);
				pstmt7.setString(4, street2);
				pstmt7.setString(5, state);
				pstmt7.setString(6, country);
				pstmt7.setString(7, city);
				pstmt7.setString(8, zipcode);
				pstmt7.setString(9, permanentstreet1);
				pstmt7.setString(10, permanentstreet2);
				pstmt7.setString(11, permanentstate);
				pstmt7.setString(12, permanentcountry);
				pstmt7.setString(13, permanentcity);
				pstmt7.setString(14, permanentzipcode);
				pstmt7.setString(15, datetime.showTime("databaseinsert"));
				pstmt7.setString(16, created);
				pstmt7.setString(17, "A");
				pstmt7.setString(18, beanobj.getSmsmobile());
		
				result += pstmt7.executeUpdate();
				connection.commit();

			}
			
			log.info("personaddress================>>");
			
		} catch (Exception exception) {
			exception.printStackTrace();
			connection.rollback();
			log.error(exception);
			return 0;
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
			
			if (pstmt8 != null)
				pstmt8.close();
			
			if (connection != null)
				connection.close();
			
		}
		
		if(result>0){
			String deptName = fieldValue("departmentname","department","departmentid",beanobj.getDepartment(),"status",beanobj.getInstituteId());
			String roleName = fieldValue("rolename","role","roleid",beanobj.getRole(),"status",beanobj.getInstituteId());
			String dobMail = common_data_object.getString("select date_format('"+dob+"','%d-%b-%Y') as dob");
			String dateofjoinMail = common_data_object.getString("select date_format('"+dateofjoin+"','%d-%b-%Y') as doj");
			beanobj.setDobmail(dobMail);
			beanobj.setJoiningdatemail(dateofjoinMail);
			//System.out.println("1deptName,roleName"+deptName+"--"+roleName);
			com.iGrandee.SendMail.SendMail sendMail = new com.iGrandee.SendMail.SendMail();
			String uname = firstname + midname + lastname;
			sendMail.sendStaffRegistraion(emidid,"Admin",password,uname,"",beanobj,deptName,roleName);
		}
		return result;
	}
		
	// To get the fieldname based on fieldid - Subhash
	public String fieldValue(String fieldName,String tableName,String idName,String idValue,String statusName,String instituteid)
	{
	 	log.info("invoking fieldName to get Field Name based on Fieldid ");
		String reqstr = "";
		String query =  "";
		try
		{
			query ="select "+fieldName+" from  "+tableName+" where "+idName+"='"+idValue+"' and "+statusName+"='A' and instituteid='"+instituteid+"'";
			reqstr = common_data_object.getString(query);
			log.info(query);
		}catch(Exception e){log.error(e);}
		return reqstr;
	}	



	CommonDataAccess common_data_object;
	DateTime datetime;

	String select_query;
	}