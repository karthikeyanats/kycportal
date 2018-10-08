package com.iGrandee.Application;

//Import Libraries From Packages
/*import com.iGrandee.Common.*;
import java.util.*;
import java.sql.*;
import java.lang.*;
import java.lang.Integer.*;*/
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

import java.util.ResourceBundle;
import org.apache.log4j.Logger;

public class RegistrationProcess
{
	//Bean Object Creation
	static Logger log = Logger.getLogger(RegistrationProcess.class);
	CommonDataAccess common_data_object = new CommonDataAccess();
	

	public String insert_query 			= null;
	public String select_query 			= null;
	int return_value 					= 0;
	ResourceBundle resourcebundle;
	DateTime	datetime				= new DateTime();
	

	
	//To check whether the  Application No. is available based on Application No. only- Subhash
	public String checkAppNo(String appno)
	{
		log.info("invoking checkAppNo for loading subject for checking whether the  Application No. is available");
		String temp=null;
		try
		{
			String select_query = "select applicationno from applicationissue where applicationno='"+appno+"' and status='A'";
			temp=common_data_object.getRecordsAsString(select_query);
		}
		catch(Exception e)
		{
			//System.out.println("********EXCEPTION****"+e);
			log.error("",e);			
		}
		return temp;
	}

	//To check whether the  Application No. is available in Registration based on Application No. only- Subhash
	public String checkAppNoInReg(String appno)
	{
		log.info("invoking checkAppNoInReg  for checking whether the  Application No. is available in Registration");
		String temp=null;
		try
		{
			String select_query = "select applicationno from applicationissue a join registration b on a.applicationid=b.applicationid where a.applicationno='"+appno+"' and a.status='A' and b.status='A'";
			temp=common_data_object.getRecordsAsString(select_query);
		}
		catch(Exception e)
		{
			//System.out.println("********EXCEPTION****"+e);
			log.error("",e);			
		}
		return temp;
	}

	//To check whether the  Application No. is available in Approval based on Application No. only- Subhash
	public String checkAppNoInApprv(String appno)
	{
		log.info("invoking checkAppNoInApprv  for checking whether the  Application No. is available in Registration");
		String temp=null;
		try
		{
			String select_query = "select applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and a.applicationno='"+appno+"' and a.status='A' and b.status='A' join studentapproval c on c.registrationid=b.registrationid and c.approvalstatus='A'";
			temp=common_data_object.getRecordsAsString(select_query);
		}
		catch(Exception e)
		{
			//System.out.println("********EXCEPTION****"+e);
			log.error("",e);			
		}
		return temp;
	}
	
	//To check whether the  Application No. is available - Subhash
	public String checkAppNo(String appno,String standardpublishid)
	{
		log.info("invoking checkAppNo(appno,standardpublishid) for checking whether the  Application No. is available");
		String temp=null;
		try
		{
			String select_query = "select applicationno from applicationissue where applicationno='"+appno+"' and standardpublishid='"+standardpublishid+"' and status='A'";
			//System.out.println("checkAppNo() ==>"+select_query);
			temp=common_data_object.getRecordsAsString(select_query);
		}
		catch(Exception e)
		{
			//System.out.println("********EXCEPTION****"+e);
			log.error("",e);
		}
		return temp;
	}
	// To get the Applicant Details for the valid App no. - Subhash
	public ArrayList getApplicantDetails(String applicationno)throws Exception
		{
		log.info("invoking getApplicantDetails to get the Applicant Details for the valid App no.");
			ArrayList valueList = null;
			try
			{
				String qry = "select a.applicationid,a.applicantname,a.applicationno,a.cost,a.receiptno,date_format(a.dateofcreation,'%d-%b-%Y %r') as dateofcreation,d.standardname,c.standardscheduleid from applicationissue a,standardschedule c,standard d where a.standardpublishid=c.standardscheduleid and c.standardid=d.standardid and a.status='A' and c.stdschedulestatus='A' and d.standardstatus='A' and a.applicationno='"+applicationno+"'";	
				//System.out.println("getApplicantDetails ==>"+qry);
				valueList = common_data_object.getListMap(qry);
			}
			catch(Exception e)
			{
				//System.out.println("IGST EXCEPTION ON INTRAPORTAL:::::::"+e.getMessage());
				log.error("",e);
			}
				return valueList;
	}
	// To get the Applicant Details if it is already registered - Subhash
	public ArrayList getRegApplicantDetails(String applicationno)throws Exception
	{
		log.info("invoking getRegApplicantDetails to get the Registered Applicant Details");
				ArrayList valueList = null;
				try
				{
					String qry = "select a.applicationid,a.applicantname,a.Applicationno,a.cost,a.receiptno,date_format(a.dateofcreation,'%d-%b-%Y %r') as dateofcreation,'-' as standardname,'-' as standardscheduleid from applicationissue a where a.status='A' and a.applicationno='"+applicationno+"'"; 
					//System.out.println("getRegApplicantDetails ==>"+qry);
					valueList = common_data_object.getListMap(qry);
				}
				catch(Exception e)
				{
					//System.out.println("IGST EXCEPTION ON INTRAPORTAL:::::::"+e.getMessage());
					log.error("",e);
				}
					return valueList;
	}
	
	//to insert registration - Subhash
	public int registrationInsert(RegistrationBean registrationBean) throws Exception
	{
		log.info("invoking registrationInsert for Admission Insertion");
		Connection connection 			= null;
		PreparedStatement regstmt		= null;
		PreparedStatement regidstmt		= null;
		ResultSet regidrs				= null;
		long regId						= 0l;
		int result						= 0;
		String datestr					= null;
		datestr							= datetime.showTime("MySqlWithTime");
		try
		{
			connection		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			
			select_query		=	"select max(registrationid) from registration";
			regidstmt		=	connection.prepareStatement(select_query);
			regidrs			=	regidstmt.executeQuery();
	
			if(regidrs.next())
				regId	=	regidrs.getLong(1);
	
			regId++;
			
			insert_query		= 	"insert into registration(registrationid,applicationid,registrationamount,standardpublishid,createdby,dateofcreation,status) values(?,?,?,?,?,?,?)";
			regstmt		=	connection.prepareStatement(insert_query);

			regstmt.setLong(1,regId);
			regstmt.setString(2,registrationBean.getApplicationid());
			regstmt.setString(3,registrationBean.getRegistrationamount());
			regstmt.setLong(4,registrationBean.getStandardscheduleid());
			regstmt.setString(5,registrationBean.getCreatedby());			
			regstmt.setString(6,datestr);
			regstmt.setString(7,"A");			
			result	=	regstmt.executeUpdate();
	
			connection.commit();
			}
		catch(SQLException e)
		{
			//System.out.println("Error in applicationInsert");
			log.error("",e);

			if(connection!=null)
				connection.rollback();
	
			result =0;
	
		}
		finally{
	
			if(regidrs != null)
				regidrs.close();
	
			if(regidstmt != null)
				regidstmt.close();
			if(regstmt != null)
				regstmt.close();
	
			if(connection != null)
				connection.close();
		}
	
	    return result;
	}	
	
	// to Display Registration Details - Subhash
	public ArrayList displayforRegistrationDetails(String appno)
	{
		log.info("invoking displayforRegistrationDetails to Display Registration Details");
		ArrayList valueList = null;
		try
		{
			String select_query = "select a.registrationid,a.applicationid,a.registrationamount,date_format(a.dateofcreation,'%d-%b-%Y') as dateofcreation,b.applicationid,b.applicationno,b.applicantname,d.standardname from registration a,applicationissue b,standardschedule c,standard d where  a.applicationid=b.applicationid and b.applicationno='"+appno+"' and  c.standardscheduleid=a.standardpublishid and c.standardid=d.standardid and a.status='A' and b.status='A' and c.stdschedulestatus='A' and d.standardstatus='A'";
			
			//System.out.println("checkAppNo() ==>"+select_query);
			valueList=common_data_object.getListMap(select_query);
		}
		catch(Exception e)
		{
			//System.out.println("********EXCEPTION****"+e);
			log.error(e);
		}
		return valueList;
	}
	
	// To Display Registration Details in Print -- Subhash
	public ArrayList displayRegistrationDetailsPrint(String applicationid)
	{
		log.info("invoking displayRegistrationDetailsPrint to Display Registration Details in Print");
	ArrayList valueList = null;
		try
		{
			String select_query = "select a.registrationid,a.applicationid,a.registrationamount,date_format(a.dateofcreation,'%d-%b-%Y') as dateofcreation,b.applicationid,b.applicationno,b.applicantname,d.standardname,date_format(curdate(),'%d-%b-%Y') as currentdate from registration a,applicationissue b,standardschedule c,standard d where  a.applicationid=b.applicationid and b.applicationid='"+applicationid+"' and  c.standardscheduleid=a.standardpublishid and c.standardid=d.standardid and a.status='A' and b.status='A' and c.stdschedulestatus='A' and d.standardstatus='A'";
			
			//System.out.println("displayRegistrationDetailsPrint() ==>"+select_query);
			valueList=common_data_object.getListMap(select_query);
	
					}
					catch(Exception e)
					{
						//System.out.println("********EXCEPTION****"+e);
						log.error(e);
					}
				return valueList;
	}
	
	// To Check whether the application no is registered - Subhash
	public ArrayList checkRegistration(String applnno)
		{
		log.info("invoking checkRegistration To Check whether the application no is registered");
			ArrayList valueList = null;
			try
			{
				String qry = "select b.registrationid,date_format(b.dateofcreation,'%d-%b-%Y %r') as dateofcreation,b.registrationamount from applicationissue a,registration b where  a.applicationno='"+applnno+"' and a.applicationid=b.applicationid and a.status='A' and b.status='A'";
				valueList = common_data_object.getListMap(qry);
			}
			catch(Exception e){
				//System.out.println("IGST EXCEPTION ON INTRAPORTAL::::::: checkRegistration"+e.getMessage());
				log.error(e);	
			}
				return valueList;
	
		}

	//To list year of session for Admission - Subhash
	/*public ArrayList listYearofSession()
	{
		log.info("invoking listYearofSession To list year of session");
		ArrayList yearList = new ArrayList();
		try
		{
			String query = "select sessionid,sessionname from yearofsession where sessionstatus='A' order by sessionname";
			yearList = common_data_object.getListMap(query);
		}catch(Exception e){
			log.error(e);
		}
		return yearList;
	}*/
	
	//To list all year of session for Admission - Subhash
	public ArrayList listYearofSession(String instituteid)
	{
		log.info("invoking listYearofSession(instituteid) To list all year of session");
		ArrayList yearList = new ArrayList();
		try
		{
			String query = "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"+instituteid+"' and (sessionstatus='A' or sessionstatus='R') order by sessionname";
			yearList = common_data_object.getListMap(query);
		}catch(Exception e){log.error(e);}
		return yearList;
	}
	//To list active year of session for Admission - Subhash
	public ArrayList listActiveYearofSession(String instituteid)
	{
		log.info("invoking listActiveYearofSession(instituteid) To list active year of session");
		ArrayList yearList = new ArrayList();
		try
		{
			String query = "select sessionid,sessionname from yearofsession where instituteid='"+instituteid+"' and sessionstatus='A' order by sessionname";
			yearList = common_data_object.getListMap(query);
		}catch(Exception e){log.error(e);}
		return yearList;
	}
	
	//To list archive year of session for PDF Generation - Subhash
	//access by prasanth
	public ArrayList listArchiveYearofSession(String instituteid)
	{
		log.info("invoking listArchiveYearofSession(instituteid) To list archive year of session");
		ArrayList yearList = new ArrayList();
		try
		{
			String query = "select sessionid,sessionname from yearofsession where instituteid='"+instituteid+"' and sessionstatus='R' order by sessionname";
			yearList = common_data_object.getListMap(query);
		}catch(Exception e){log.error(e);}
		return yearList;
	}
	
	//To list Standards for Admission - Subhash
	//Access by prasanth
	public ArrayList listStandard(String sessionid,String boardid)
	{
		log.info("invoking listStandard To list Standards based on sessionid,boardid");
		ArrayList valueList = null;
		try
		{
			//String qry = "select b.standardid,b.standardname,a.standardscheduleid,a.groupid,b.groupstatus,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid and d.groupstatus='A')  end as groupname from standardschedule a,standard b where a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A'  order by b.standardid,groupname";
			String qry = "select b.standardid,b.standardname,a.standardscheduleid,a.groupid,b.groupstatus,case when a.groupid is null then 'NoGroup' else (select d.groupname from standardgroup d where a.groupid=d.groupid and d.groupstatus='A')  end as groupname,a.noofseats as totalseats,(select count(a11.studentallocationid) from studentallocation a11,sectionschedule b11,standardschedule c11 where a11.sectionscheduleid=b11.sectionscheduleid and b11.standardscheduleid=c11.standardscheduleid and c11.standardscheduleid=a.standardscheduleid and a11.studentallocationstatus='A' and b11.sectionschedulestatus='A' and c11.stdschedulestatus='A') as allocatedseats  from standardschedule a,standard b where a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.standardid=b.standardid and a.stdschedulestatus='A' and b.standardstatus='A'  order by b.standardid,groupname";
			//System.out.println("\t\t"+qry);
			valueList = common_data_object.getListMap(qry);
		}
		catch(Exception e){
			log.error(e);
			//System.out.println("IGST EXCEPTION ON INTRAPORTAL::::::: checkRegistration"+e.getMessage());}
		}
			return valueList;

	}
	
	// To list registered students based on session,board,standardschedule   -- Subhash
	public ArrayList displayAdmisionssDetails(String sessionid,String stdscheduleid)
	{
		log.info("invoking displayAdmisionssDetails To list registered students based on session,board,standardschedule");
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select b.registrationid as regId,b.standardpublishid,date_format(b.dateofcreation,'%d-%b-%Y') as dateofregistration,a.applicantname,a.applicationno,e.registrationid,case when e.registrationid is null then 'NotApproved' else 'Approved' end as approvalstatus,d.noofseats as totalseats,(select count(a11.studentallocationid) from studentallocation a11,sectionschedule b11,standardschedule c11 where a11.sectionscheduleid=b11.sectionscheduleid and b11.standardscheduleid=c11.standardscheduleid and c11.standardscheduleid='"+stdscheduleid+"' and a11.studentallocationstatus='A' and b11.sectionschedulestatus='A' and c11.stdschedulestatus='A') as allocatedseats from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid 	and a.sessionid='"+sessionid+"' and b.standardpublishid='"+stdscheduleid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' left outer join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' order by a.applicationno";
			select_query = "select b.registrationid as regId,b.standardpublishid,date_format(b.dateofcreation,'%d-%b-%Y') as dateofregistration,a.applicantname,a.applicationno,e.registrationid,case when e.registrationid is null then 'NotApproved' else 'Approved' end as approvalstatus,d.noofseats as totalseats,(select count(a11.studentallocationid) from studentallocation a11,sectionschedule b11,standardschedule c11 where a11.sectionscheduleid=b11.sectionscheduleid and b11.standardscheduleid=c11.standardscheduleid and c11.standardscheduleid='"+stdscheduleid+"' and a11.studentallocationstatus='A' and b11.sectionschedulestatus='A' and c11.stdschedulestatus='A' and a11.studentcurrentstatus!='newjoin') as promotedseats,(select count(studentapprovalid) from applicationissue a22 join registration b22 on a22.applicationid=b22.applicationid and a22.standardpublishid=b22.standardpublishid and b22.standardpublishid='"+stdscheduleid+"' and a22.status='A' and b22.status='A' join yearofsession c22 on a22.sessionid=c22.sessionid and c22.sessionstatus='A' join standardschedule d22 on b22.standardpublishid=d22.standardscheduleid and d22.stdschedulestatus='A' join studentapproval e22 on e22.registrationid=b22.registrationid and e22.approvalstatus='A') as approvedseats from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid 	and a.sessionid='"+sessionid+"' and b.standardpublishid='"+stdscheduleid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' left outer join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' order by a.applicationno"; 
			
			valueList=common_data_object.getListMap(select_query);
			//System.out.println("student details "+select_query );
		}
		catch(Exception e)
		{
			log.error(e);
			//System.out.println("********EXCEPTION****"+e);
		}
		return valueList;
	}
	
	// To list approved students based on standardschedule   -- Subhash
	public ArrayList loadApprovedList(String stdscheduleid,String status)
	{
		log.info("invoking loadApprovedList for loading approved students based on status-->"+status);
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select a.applicantname,a.applicationno,e.studentapprovalid,date_format(e.dateofcreation,'%d-%b-%Y') as dateofapproval from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and b.standardpublishid='"+stdscheduleid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='"+status+"' order by a.applicationno";
			select_query = "select a.applicantname,a.applicationno,e.studentapprovalid,date_format(e.dateofcreation,'%d-%b-%Y') as dateofapproval,case when (select candidateregisterid from candidateregister where studentapprovalid=e.studentapprovalid and candidateregisterstatus='A') is null then 'InActive' else 'Active' end as profilestatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and b.standardpublishid='"+stdscheduleid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='"+status+"' order by a.applicationno";
			valueList=common_data_object.getListMap(select_query);
			System.out.println("student details "+select_query );
		}
		catch(Exception e)
		{
			log.error(e);
			//System.out.println("********EXCEPTION****"+e);
		}
		return valueList;
	}

		// To approve the registered student - Subhash
	 //public int insertApprovalStudent(String[] registrationId,String stdscheduleid,String approved)  throws Exception
	 public int insertApprovalStudent(ApprovalBean approvalBean)  throws Exception
	 {
		log.info("invoking insertApprovalStudent To approve the registered student");
		 int i 							= 0;
		 String regId[]					= null;
		 String approvQry 				= null;
		 long appId						= 0l;
		 String datestr					= null;
		 datestr						= datetime.showTime("MySqlWithTime");			 
		 Connection connection 			= null;
		 
		 PreparedStatement apprvStmt	= null;
		 PreparedStatement appidStmt	= null;
		 		 
		 ResultSet appidrs				= null;
		
		 
		try
		{
			connection		= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			 
			approvQry		=	"select max(studentapprovalid) from studentapproval";
			appidStmt		=	connection.prepareStatement(approvQry);
			appidrs			=	appidStmt.executeQuery();

			 if(appidrs.next())
				 appId	=	appidrs.getLong(1);

			 appId++;

			 approvQry		= 	"insert into studentapproval(studentapprovalid,registrationid,standardscheduleid,createdby,dateofcreation,approvalstatus) values(?,?,?,?,?,?)";
			 apprvStmt		=	connection.prepareStatement(approvQry);

			String registrationId []=approvalBean.getRegistrationid();
			 
			 if(registrationId != null && registrationId.length>0)
			 {
					for(int j=0;j<registrationId.length;j++){
						//String[] var=null;
						regId=registrationId[j].split("@");

						//registrationId=regId[0];
						/*apprvStmt.setLong(1,appId);
						apprvStmt.setString(2,regId[0]);
						apprvStmt.setString(3,stdscheduleid);
						apprvStmt.setString(4,approved);
						apprvStmt.setString(5,datestr);
						apprvStmt.setString(6,"A");*/

						apprvStmt.setLong(1,appId);
						apprvStmt.setString(2,regId[0]);
						apprvStmt.setLong(3,approvalBean.getStandardscheduleid());
						apprvStmt.setString(4,approvalBean.getCreatedby());
						apprvStmt.setString(5,datestr);
						apprvStmt.setString(6,"A");						
						
						apprvStmt.addBatch();
						 appId++;
						
					}

			 }
			 int temp[]		= null;
			 temp		= apprvStmt.executeBatch();
			 if(temp != null && temp.length>0)
				 for(int y=0;y<temp.length;y++)
					 i+=temp[y];
			 
	 
			 connection.commit();

	        }
			catch(SQLException e)
			{
				//System.out.println("Error in insertApprovalStudent");
				log.error("",e);
				//e.printStackTrace();

				if(connection!=null)
					connection.rollback();

				i =0;

			}
			finally{

				if(appidrs != null)
					appidrs.close();

				if(appidStmt != null)
					appidStmt.close();
				
				if(apprvStmt != null)
					apprvStmt.close();
				
				/*if(promostmt != null)
					promostmt.close();*/

				if(connection != null)
					connection.close();
			}

	        return i;
	    }
	 
		// To list approved students based on session,board,standardschedule   -- Subhash
		public ArrayList displayApprovedDetails(String sessionid,String stdscheduleid)
		{
			log.info("invoking displayApprovedDetails To list approved students based on session,board,standardschedule");
			ArrayList valueList = null;
			String select_query = "";
			try
			{
				//select_query = "select b.registrationid,b.standardpublishid,date_format(b.dateofcreation,'%d-%m-%Y') as dateofregistration,a.applicantname,a.applicationno from applicationissue a,registration b,yearofsession c,standardschedule d where a.applicationid=b.applicationid and a.sessionid=c.sessionid and b.standardpublishid=d.standardscheduleid and b.standardpublishid='"+stdscheduleid+"' and a.sessionid='"+sessionid+"' and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' and c.sessionstatus='A' and d.stdschedulestatus='A'";
				select_query = "select b.registrationid as regId,b.standardpublishid,date_format(b.dateofcreation,'%d-%b-%Y') as dateofregistration,a.applicantname,a.applicationno,e.registrationid,case when e.registrationid is null then 'NotApproved' else 'Approved' end as approvalstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid 	and a.sessionid='"+sessionid+"' and b.standardpublishid='"+stdscheduleid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A'"; 
				valueList=common_data_object.getListMap(select_query);
				//System.out.println("student details "+select_query );
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error(e);
			}
			return valueList;
		}
		
		// To list approved students based on session,board,standardschedule   -- Subhash
		//jsp/ApplicationForm/ViewApprvStudents.jsp
		public ArrayList displayAllocatedDetails(String sessionId,String stdScheduleId)
		{
			log.info("invoking displayAllocatedDetails To list approved students based on session,board,standardschedule");
			ArrayList valueList = null; 
			String select_query = "";
			try
			{
				//select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,f.candidateregisterid,date_format(e.dateofcreation,'%d-%b-%Y') as dateofapproval,a.applicantname as applicationname,a.applicationno,case when g.studentallocationid is null then 'NotAllocated' else (select a1.sectionname from section a1,sectionschedule b1 where a1.sectionid=b1.sectionid and a1.status='A' and b1.sectionschedulestatus='A' and b1.sectionscheduleid=g.sectionscheduleid) end as allocationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.standardscheduleid='"+stdScheduleId+"' and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'  join personmaster i on i.personid=f.personid and i.status='A' left outer join studentallocation g on g.candidateregisterid=f.candidateregisterid and (g.studentallocationstatus='A' or g.studentallocationstatus='C') order by allocationstatus,a.applicationno asc";
				//select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,f.candidateregisterid,date_format(e.dateofcreation,'%d-%b-%Y') as dateofapproval,a.applicantname as applicationname,a.applicationno,case when g.studentallocationid is null then 'NotAllocated' else (select a1.sectionname from section a1,sectionschedule b1 where a1.sectionid=b1.sectionid and a1.status='A' and b1.sectionschedulestatus='A' and b1.sectionscheduleid=g.sectionscheduleid) end as allocationstatus,d.noofseats as totalseats,(select count(a11.studentallocationid) from studentallocation a11,sectionschedule b11,standardschedule c11 where a11.sectionscheduleid=b11.sectionscheduleid and b11.standardscheduleid=c11.standardscheduleid and c11.standardscheduleid='"+stdScheduleId+"' and a11.studentallocationstatus='A' and b11.sectionschedulestatus='A' and c11.stdschedulestatus='A') as allocatedseats from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.standardscheduleid='"+stdScheduleId+"' and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'  join personmaster i on i.personid=f.personid and i.status='A' left outer join studentallocation g on g.candidateregisterid=f.candidateregisterid and (g.studentallocationstatus='A' or g.studentallocationstatus='C') order by allocationstatus,a.applicationno asc";
				select_query = "select case when d.middlename='-' or d.middlename='' or d.middlename is null then concat(d.firstname,' ',d.lastname) else concat(d.firstname,' ',d.middlename,' ',d.lastname) end as applicantname,c.candidateregisterid,date_format(a.dateofcreation,'%d-%b-%Y') as dateofapproval,f.applicantname as applicationname,f.applicationno,case when g.studentallocationid is null then 'NotAllocated' else  (select a1.sectionname from section a1,sectionschedule b1 where a1.sectionid=b1.sectionid and a1.status='A' and b1.sectionschedulestatus='A' and b1.sectionscheduleid=g.sectionscheduleid) end as allocationstatus,b.noofseats as totalseats,(select count(a11.studentallocationid) from studentallocation a11,sectionschedule b11,standardschedule c11  where a11.sectionscheduleid=b11.sectionscheduleid and b11.standardscheduleid=c11.standardscheduleid and c11.standardscheduleid='"+stdScheduleId+"' and a11.studentallocationstatus='A' and b11.sectionschedulestatus='A' and c11.stdschedulestatus='A')  as allocatedseats from studentapproval a,standardschedule b,personmaster d,registration e,applicationissue f,candidateregister c left outer join studentallocation g on c.candidateregisterid=g.candidateregisterid  and (g.studentallocationstatus='A' or g.studentallocationstatus='C')  where a.standardscheduleid='"+stdScheduleId+"'  and a.approvalstatus='A' and a.standardscheduleid=b.standardscheduleid and stdschedulestatus='A' and a.studentapprovalid=c.studentapprovalid  and candidateregisterstatus='A' and d.personid=c.personid and d.status='A' and e.registrationid=a.registrationid and e.status='A' and f.applicationid=e.applicationid and f.status='A'";
				valueList=common_data_object.getListMap(select_query);
			//	System.out.println("student details "+select_query );
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error(e);
			}
			return valueList;
		}
		
		// To view Section based on the standard  -- Subhash

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
		
		// To allocate the section for approved student - Subhash
		 //public int insertAllocationStudent(String[] candidateregisterId,String secScheduleId,String approvedBy)  throws Exception
		 public int insertAllocationStudent(AllocationBean allocationBean)  throws Exception
		 {
			log.info("invoking insertAllocationStudent To allocate the section for approved student");
			 int i 							= 0;
			 String candRegId[]				= null;
			 String allocatQry 				= null;
			 long allId						= 0l;
			 String datestr					= null;
			 datestr						= datetime.showTime("MySqlWithTime");			 
			 Connection connection 			= null;
			 
			 PreparedStatement allocatStmt	= null;
			 PreparedStatement allidStmt	= null;
			 		 
			 ResultSet allidrs				= null;
			
			 
			try
			{
				connection		= ConnectionManager.getKycConnection();
				connection.setAutoCommit(false);
				 
				allocatQry		=	"select max(studentallocationid) from studentallocation";
				allidStmt		=	connection.prepareStatement(allocatQry);
				allidrs			=	allidStmt.executeQuery();

				 if(allidrs.next())
					 allId	=	allidrs.getLong(1);

				 allId++;
				 //studentallocationid, , , rollno, , dateofcreation, , registrationnumber
				 allocatQry		= 	"insert into studentallocation(studentallocationid,candidateregisterid,sectionscheduleid,studentcurrentstatus,dateofcreation,studentallocationstatus,createdby) values(?,?,?,?,?,?,?)";
				 allocatStmt		=	connection.prepareStatement(allocatQry);

				String candidateregisterId []=allocationBean.getCandidateregisterid();
					
				 if(candidateregisterId != null && candidateregisterId.length>0)
				 {
						for(int j=0;j<candidateregisterId.length;j++){
							//String[] var=null;
							candRegId=candidateregisterId[j].split("@");
							/*allocatStmt.setLong(1,allId);
							allocatStmt.setString(2,candRegId[0]);
							allocatStmt.setString(3,secScheduleId);
							allocatStmt.setString(4,"newjoin");
							allocatStmt.setString(5,datestr);
							allocatStmt.setString(6,"A");
							allocatStmt.setString(7,approvedBy);*/
							
							allocatStmt.setLong(1,allId);
							allocatStmt.setString(2,candRegId[0]);
							allocatStmt.setLong(3,allocationBean.getSectionscheduleid());
							allocatStmt.setString(4,"newjoin");
							allocatStmt.setString(5,datestr);
							allocatStmt.setString(6,"A");
							allocatStmt.setString(7,allocationBean.getCreatedby());
							
							allocatStmt.addBatch();
							allId++;
						}

				 }
				 int temp[]		= null;
				 temp		= allocatStmt.executeBatch();
				 if(temp != null && temp.length>0)
					 for(int y=0;y<temp.length;y++)
						 i+=temp[y];
				 
		 
				 connection.commit();

		        }
				catch(SQLException e)
				{
					//System.out.println("Error in insertApprovalStudent");
					//e.printStackTrace();
					log.error("",e);

					if(connection!=null)
						connection.rollback();

					i =0;

				}
				finally{

					if(allidrs != null)
						allidrs.close();

					if(allidStmt != null)
						allidStmt.close();
					
					if(allocatStmt != null)
						allocatStmt.close();

					if(connection != null)
						connection.close();
				}

		        return i;
		    }	
		 
		 // To list allocated students based on session,board,standardschedule after allocating section   -- Subhash
		public ArrayList displayAllocatedDetails(String sessionId,String stdScheduleId,String secScheduleId)
		{
			log.info("invoking displayAllocatedDetails To list allocated students based on session,board,standardschedule after allocating section");
			ArrayList valueList = null;
			String select_query = "";
			try
			{
				//select_query = "select f.candidateregisterid,date_format(e.dateofcreation,'%d-%m-%Y') as dateofapproval,a.applicantname,a.applicationno,case when g.studentallocationid is null then 'NotAllocated' else 'Allocated' end as allocationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' left outer join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus='A'";
				//select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation,a.applicantname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A'";
				  select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='R' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A'";
				valueList=common_data_object.getListMap(select_query);
				//System.out.println("student details "+select_query );
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error(e);
			}
			return valueList;
		}

		// To list allocated students based on sectionscheduleid after allocating section   -- Subhash
		public ArrayList displayAllocatedDetails(String secScheduleId)
		{
			log.info("invoking displayAllocatedDetails To list allocated students based on sectionscheduleid after allocating section");
			ArrayList valueList = null;
			String select_query = "";
			try
			{
				//select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation,a.applicantname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A'";
			//	select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus,i.emailid,i.mobilenumber,i.landlinenumber from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus in ('A','D','C') order by rollgenerationstatus,rollno,applicantname";
				select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus,i.emailid,i.mobilenumber,i.landlinenumber from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and  (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus in ('A','D','C') order by rollgenerationstatus,rollno,applicantname";
				valueList=common_data_object.getListMap(select_query);
				System.out.println("student details "+select_query );
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error(e);
			}
			return valueList;
		}
		public ArrayList displayclassmateDetails(String secScheduleId,String studentallocationid)
		{
			log.info("invoking displayclassmateDetails To list out all classmates of particular student");
			ArrayList valueList = null;
			String select_query = "";
			try
			{
				
				select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,a.applicantname as applicationname, case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus,i.emailid from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' and g.studentallocationid!='"+studentallocationid+"'";
				valueList=common_data_object.getListMap(select_query);
				log.info(select_query);
				//System.out.println("student details "+select_query );
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error(e);
			}
			return valueList;
		}

		// To list allocated students based on sectionschedule and status after allocating section   -- Subhash
		public ArrayList listAllocatedDetails(String secScheduleId,String status)
		{
			log.info("invoking listAllocatedDetails To list allocated students based on sectionschedule and status after allocating section");
			ArrayList valueList = null;
			String select_query = "";
			try
			{
				//select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation,a.applicantname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A'";
				select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='"+status+"'";
				valueList=common_data_object.getListMap(select_query);
				//System.out.println("student details "+select_query );
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return valueList;
		}

		//To check whether the  Roll No. is available based on Application No. only- Subhash
		public String checkRollNo(String rollno,String instituteid)
		{
			log.info("invoking checkRollNo To check duplication for roll no");
			String temp=null;
			try
			{
				//String select_query = "select rollno from studentallocation where rollno='"+rollno+"' and studentallocationstatus='A'";
				String select_query = "select a.rollno from studentallocation a,personmaster b,institution c where a.rollno='"+rollno+"' and a.studentallocationstatus='A' and a.createdby=b.personid and b.instituteid=c.instituteid and b.instituteid='"+instituteid+"'";
				log.info("Query : "+select_query);
				//System.out.println("********select_query****"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error(e);
				
			}
			return temp;
		}
		
		// To update or generate the roll no for allocated student - Subhash
		 public int updateRollNumberGen(String[] studentAllocationId,String secScheduleId,String approvedBy,String[] rollNo, String instituteid,Duplicatebean beanobj)  throws Exception
		 {
			 
			 log.info("invoking updateRollNumberGen for generate or update roll no");
			 int i 							= 0;
			 String rollGenQry 				= null;
			 
			 //long allId					= 0l;
			 String datestr					= null;
			 datestr						= DateTime.showTime("MySqlWithTime");			 
			 Connection connection 			= null;
			 
			 PreparedStatement rollGenStmt	= null;
			 
			 PreparedStatement checkstmt	= null;
			 ResultSet checkrs				= null;
			 		 
			 int temp[]		= null;
			 int duplicatecount=0;
			 StringBuffer duplicatecountbuff=new StringBuffer();
			 
			try
			{
				connection		= ConnectionManager.getKycConnection();
				connection.setAutoCommit(false);
				 
				 rollGenQry		= 	"update studentallocation set rollno=?,dateofrollnogen=? where studentallocationid=? and sectionscheduleid=?";
				 rollGenStmt	=	connection.prepareStatement(rollGenQry);
				 
				 checkstmt		= connection.prepareStatement("select a.rollno from studentallocation a,personmaster b,institution c where a.rollno=?  and a.createdby=b.personid and b.instituteid=c.instituteid and b.instituteid=? and a.studentallocationid<>?");
				 if(studentAllocationId != null && studentAllocationId.length>0)
				 {
						for(int j=0;j<studentAllocationId.length;j++){

							
							checkstmt.setString(1, rollNo[j]);
							checkstmt.setString(2, instituteid);
							checkstmt.setString(3, studentAllocationId[j]);
							// System.out.println("rollNo["+j+"]>>>>"+rollNo[j]);
							// System.out.println("studentAllocationId["+j+"]>>>>"+studentAllocationId[j]);
							checkrs		= checkstmt.executeQuery();
							 

							if(!checkrs.next()){
								// System.out.println("in update rollNo["+j+"]>>>>"+rollNo[j]);

								rollGenStmt.setString(1,rollNo[j]);
								rollGenStmt.setString(2,datestr);
								rollGenStmt.setString(3,studentAllocationId[j]);
								rollGenStmt.setString(4,secScheduleId);
								//rollGenStmt.setString(5,"A");
								rollGenStmt.addBatch();
								// System.out.println("rollGenStmt>>in check"+rollGenStmt);

								 
							}
							else{
								// System.out.println("in else duplicate");

								duplicatecount=-1;
								duplicatecountbuff.append(rollNo[j]+"&nbsp;");
							}
							
							if(checkrs != null)
								checkrs.close();
							 temp		= rollGenStmt.executeBatch();
						}

				 }
				 
			
				 

				 if(temp != null && temp.length>0){
					 for(int y=0;y<temp.length;y++){
						 i+=temp[y];
						 //System.out.println("temp>>>"+temp[y]);
					 }
				 } 
				 beanobj.setDuplicaterr(duplicatecountbuff.toString()); 
				 connection.commit();

		        }
				catch(SQLException e)
				{

					log.error("",e);
					
					e.printStackTrace();

					if(connection!=null)
						connection.rollback();

					i = 0;

				}
				finally{

					if(rollGenStmt != null)
						rollGenStmt.close();
					
					if(checkrs != null)
						checkrs.close();

					if(checkstmt != null)
						checkstmt.close();
					
					if(connection != null)
						connection.close();
				}
			//request.setAttribute("duplicatecountbuff", duplicatecountbuff);
			if(duplicatecount==-1)	
		        return duplicatecount;
			else
				return i;
		    }

		//To list year of session for Promotion - Subhash
		public ArrayList listYearofSessionforPromote(String instituteid)
		{
			ArrayList yearList = new ArrayList();
			try
			{
				log.info("invoking listYearofSessionforPromote To list year of session for Promotion");
				String query = "select sessionid,sessionname from yearofsession where instituteid='"+instituteid+"' and sessionstatus='R' order by sessionname";
				yearList = common_data_object.getListMap(query);
			}catch(Exception e){log.error(e);}
			return yearList;
		}
			
		//To list year of session for Promotion - Subhash
		public ArrayList listYearofSessiontoPromote(String sessionid)
		{
			log.info("Invoking listYearofSessiontoPromote() for listing year of session to promote");
			ArrayList yearList = new ArrayList();
			try
			{
				//String query = "select sessionid,sessionname from yearofsession where sessionstatus='A' and sessionid > '"+sessionid+"' order by sessionname";
				String query = "select sessionid,sessionname from yearofsession where (sessionstatus='N' or sessionstatus='R') and sessionid > '"+sessionid+"' order by sessionname";
				yearList = common_data_object.getListMap(query);
			}catch(Exception e){log.error(e);}
			return yearList;
		}
				
		// To view all the applicant list based on sessionid,boardid,standardpublishid,status (A,T,D)  - Subhash
		public ArrayList loadApplicantList(String sessionid,String boardid,String standardpublishid,String instituteid,String status)
		{
			log.info("Invoking loadApplicantList() for Loading all Applicants");
		    ArrayList arraylist = new ArrayList();
		    try
		    {
		    	select_query = "select applicationid,applicantname,applicationno,cost,contactno,emailid,receiptno,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation from applicationissue  where sessionid='"+sessionid+"' and boardid='"+boardid+"' and standardpublishid='"+standardpublishid+"' and instituteid='"+instituteid+"' and  status='"+status+"' order by applicationno";
		        arraylist = common_data_object.getListMap(select_query);
		    }
		    catch(Exception exception) {log.error(exception); }
		    return arraylist;
		}

		// To view all the admitted list based on sessionid,boardid,standardpublishid,status (A,T,D)  - Subhash
		public ArrayList loadAdmittedList(String standardpublishid,String instituteid,String status)
		{
			log.info("Invoking loadAdmittedList() for Loading all Admitted Applicants ");
		    ArrayList arraylist = new ArrayList();
		    try
		    {
		    	//select_query = "select b.registrationid,b.registrationamount,a.applicationid,a.applicantname,a.applicationno,a.receiptno,a.contactno,a.emailid,date_format(b.dateofcreation,'%d-%b-%Y') as dateofadmission from applicationissue a join registration b on b.standardpublishid='"+standardpublishid+"' and a.standardpublishid=b.standardpublishid and a.applicationid=b.applicationid and a.instituteid='"+instituteid+"' and a.status='A' and b.status='"+status+"' order by a.applicationno";
		    	select_query = "select b.registrationid,b.registrationamount,a.applicationid,a.applicantname,a.applicationno,a.receiptno,a.contactno,a.emailid,date_format(b.dateofcreation,'%d-%b-%Y') as dateofadmission,case when (select registrationid from studentapproval where registrationid=b.registrationid and approvalstatus='A') is null then 'InActive' else 'Active' end as approvestatus from applicationissue a join registration b on b.standardpublishid='"+standardpublishid+"' and a.standardpublishid=b.standardpublishid and a.applicationid=b.applicationid and a.instituteid='"+instituteid+"' and a.status='A' and b.status='"+status+"' order by a.applicationno";
		    	//System.out.print("select_query-->"+select_query);
		    	arraylist = common_data_object.getListMap(select_query);
		    }
		    catch(Exception exception) {log.error(exception); }
		    return arraylist;
		}
		
		// to update application details  --  Subhash
		public int updateRegistration(RegistrationBean registrationBean) throws Exception
		{
			 	log.info("invoking updateRegistration for Admission Updation");
			 
			 	int result							= 0;
			 	PreparedStatement updateprepared 	= null;
				String currentdate					= DateTime.showTime("MySqlWithTime");
				try
				{
					registrationConnection = ConnectionManager.getKycConnection();
					registrationConnection.setAutoCommit(false);
					//applicationid, applicantname, applicationno, cost, contactno, standardpublishid, dateofcreation, receiptno, createdby, ipaddress, instituteid, sessionid, boardid, status
					//, , , , , , , receiptno, , , , sessionid, boardid, status
					select_query  	= "update registration set registrationamount=?,createdby=?,dateofcreation=? where registrationid=?";
					updateprepared		=  registrationConnection.prepareStatement(select_query);
					updateprepared.setString(1,registrationBean.getRegistrationamount());
					updateprepared.setString(2,registrationBean.getCreatedby());
					updateprepared.setString(3,currentdate);
					updateprepared.setString(4,registrationBean.getRegistrationid());
					result 	+= updateprepared.executeUpdate();
				
					registrationConnection.commit();

				 
			 }catch(SQLException e){
				 
					log.error("",e);
					//e.printStackTrace();
					result	= 0;
					if(registrationConnection != null)
						registrationConnection.rollback();
			 }
			 finally
			 {
			 
				 if(updateprepared != null)
					 updateprepared.close();
				
				 if(registrationConnection != null)
					 registrationConnection.close();
			 }
			 return result;
		}

		// to update status of admission details  --  Subhash
		public int updateStatusRegistration(RegistrationBean registrationBean) throws Exception
		{
			 	log.info("invoking updateStatusRegistration for Updation of status");
			 
			 	int result							= 0;
			 	PreparedStatement updateprepared 	= null;
				String currentdate					= DateTime.showTime("MySqlWithTime");
				try
				{
					//System.out.println("registrationBean.getApplicationid()-->"+registrationBean.getApplicationid());
					registrationConnection = ConnectionManager.getKycConnection();
					registrationConnection.setAutoCommit(false);
					select_query  	= "update registration set status=?,dateofcreation=?,createdby=? where registrationid=?";
					updateprepared		=  registrationConnection.prepareStatement(select_query);
					updateprepared.setString(1,registrationBean.getStatus());
					updateprepared.setString(2,currentdate);
					updateprepared.setString(3,registrationBean.getCreatedby());
					updateprepared.setString(4,registrationBean.getRegistrationid());
					//updateprepared.setString(4,registrationBean.getIpaddress());
					//updateprepared.setString(5,registrationBean.getInstituteid());
					
					result 	+= updateprepared.executeUpdate();		
					registrationConnection.commit();

				 
			 }catch(SQLException e){
				 
					log.error("",e);
					//e.printStackTrace();
					result	= 0;
					if(registrationConnection != null)
						registrationConnection.rollback();
			 }
			 finally
			 {
			 
				 if(updateprepared != null)
					 updateprepared.close();
				
				 if(registrationConnection != null)
					 registrationConnection.close();
			 }
			 return result;
		}

		// to update status of Approval details  --  Subhash
		public int updateStatusApproval(ApprovalBean approvalBean) throws Exception
		{
			 	log.info("invoking updateStatusApproval for Approval Updation");
			 
			 	int result							= 0;
			 	PreparedStatement updateprepared 	= null;
				String currentdate					= DateTime.showTime("MySqlWithTime");
				try
				{
					//System.out.println("registrationBean.getApplicationid()-->"+registrationBean.getApplicationid());
					registrationConnection = ConnectionManager.getKycConnection();
					registrationConnection.setAutoCommit(false);
					select_query  		= "update studentapproval set approvalstatus=?,dateofcreation=?,createdby=? where studentapprovalid=?";
					updateprepared		=  registrationConnection.prepareStatement(select_query);
					updateprepared.setString(1,approvalBean.getStatus());
					updateprepared.setString(2,currentdate);
					updateprepared.setString(3,approvalBean.getCreatedby());
					updateprepared.setString(4,approvalBean.getStudentapprovalid());
					//updateprepared.setString(4,registrationBean.getIpaddress());
					//updateprepared.setString(5,registrationBean.getInstituteid());
					
					result 	+= updateprepared.executeUpdate();		
					registrationConnection.commit();

				 
			 }catch(SQLException e){
				 
					log.error("",e);
					//e.printStackTrace();
					result	= 0;
					if(registrationConnection != null)
						registrationConnection.rollback();
			 }
			 finally
			 {
			 
				 if(updateprepared != null)
					 updateprepared.close();
				
				 if(registrationConnection != null)
					 registrationConnection.close();
			 }
			 return result;
		}
		
		// To view the applicant list datewise based on sessionid,boardid,standardpublishid,status (A,T,D)  - Subhash
		public ArrayList loadApplicantListDatewise(String sessionid,String boardid,String standardpublishid,String status,String fromdate,String todate,String instituteid)
		{
			log.info("Invoking loadApplicantListDatewise() for Loading all Applicants Datewise");
		    ArrayList arraylist = new ArrayList();
		    try
		    {
				String fromDate = ((StringBuffer)datetime.getMySQLFormat(fromdate)).toString();
				String toDate = ((StringBuffer)datetime.getMySQLFormat(todate)).toString();
		    	select_query = "select applicationid,applicantname,applicationno,cost,contactno,receiptno,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation from applicationissue  where sessionid='"+sessionid+"' and boardid='"+boardid+"' and standardpublishid='"+standardpublishid+"' and  status='"+status+"' and instituteid='"+instituteid+"' and dateofcreation between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59' order by applicationno";
		        //System.out.print("select_query-->"+select_query);
		    	arraylist = common_data_object.getListMap(select_query);
		    }
		    catch(Exception exception) { log.error(exception);}
		    return arraylist;
		}

		// To view all the admitted list based on sessionid,boardid,standardpublishid,status (A,T,D)  - Subhash
		public ArrayList loadAdmittedListDatewise(String standardpublishid,String status,String fromdate,String todate,String instituteid)
		{
			log.info("Invoking loadAdmittedList() for Loading all Admitted Applicants Datewise");
		    ArrayList arraylist = new ArrayList();
		    try
		    {

				String fromDate = ((StringBuffer)datetime.getMySQLFormat(fromdate)).toString();
				String toDate = ((StringBuffer)datetime.getMySQLFormat(todate)).toString();
		    	//select_query = "select applicationid,applicantname,applicationno,cost,contactno,receiptno,date_format(dateofcreation,'%d-%m-%Y') as dateofcreation from applicationissue  where sessionid='"+sessionid+"' and boardid='"+boardid+"' and standardpublishid='"+standardpublishid+"' and  status='"+status+"' order by applicationno";
		    	select_query = "select b.registrationid,b.registrationamount,a.applicantname,a.applicationno,a.receiptno,date_format(b.dateofcreation,'%d-%b-%Y') as dateofadmission from applicationissue a join registration b on b.standardpublishid='"+standardpublishid+"' and a.standardpublishid=b.standardpublishid and a.applicationid=b.applicationid and a.instituteid='"+instituteid+"' and a.status='A' and b.status='"+status+"' and b.dateofcreation between '"+fromDate+" 00:00:00' and '"+toDate+" 23:59:59' order by a.applicationno";
		    	arraylist = common_data_object.getListMap(select_query);
		    }
		    catch(Exception exception) {log.error(exception); }
		    return arraylist;
		}
		
		// To get RollNoPrefix based on sectionscheduleid - Subhash
		public String loadRollNoPrefix(String secSchedId)
		{
			log.info("Invoking loadRollNoPrefix() To get RollNoPrefix based on sectionscheduleid");
			String temp=null;
			try
			{
				String select_query = "select rollnoprefix from sectionschedule where sectionscheduleid='"+secSchedId+"' and sectionschedulestatus='A'";
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error(e);
			}
			return temp;
		}
		
		// To set RollNoPrefix for sectionscheduleid - Subhash
		public int setRollNumberPrefix(String sectionSchedId,String approvedby,String rollNoPrefix) throws Exception
		{
			 	log.info("invoking setRollNumberPrefix for setting prefix for rollno");
			 	int result							= 0;
			 	PreparedStatement updateprepared 	= null;
				String currentdate					= DateTime.showTime("MySqlWithTime");
				try
				{
					//System.out.println("registrationBean.getApplicationid()-->"+registrationBean.getApplicationid());
					registrationConnection = ConnectionManager.getKycConnection();
					registrationConnection.setAutoCommit(false);
					select_query  	= "update sectionschedule set rollnoprefix=? where sectionscheduleid=? and sectionschedulestatus=?";
					updateprepared		=  registrationConnection.prepareStatement(select_query);
					updateprepared.setString(1,rollNoPrefix);
					updateprepared.setString(2,sectionSchedId);
					updateprepared.setString(3,"A");
				
					result 	+= updateprepared.executeUpdate();		
					registrationConnection.commit();

				 
			 }catch(SQLException e){
				 
					log.error("",e);
					//e.printStackTrace();
					result	= 0;
					if(registrationConnection != null)
						registrationConnection.rollback();
			 }
			 finally
			 {
			 
				 if(updateprepared != null)
					 updateprepared.close();
				
				 if(registrationConnection != null)
					 registrationConnection.close();
			 }
			 return result;
		}

		 /*
		  * This method is accessed from kycportal/jsp/Staff/MyStudentsView.jsp
		  * To Load Board to view My Students List for the staff login  - Subhash
		 */
		public ArrayList loadBoardForStaff(String userid,String instituteid,String yearofsessionid)
		{
			log.info("invoking loadBoardForStaff for loading board for staff");
				ArrayList secList = null;
				try
				{
					select_query  	= "select distinct e.boardid,f.boardname,g.mediumid,g.mediumname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+yearofsessionid+"' and d.instituteid='"+instituteid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.standardstatus='A' join board f on f.boardid=e.boardid and f.boardstatus='A' join standardmedium g on g.mediumid=f.mediumid and mediumstatus='A'";
				//	System.out.println("select_query "+select_query);
					secList		 	= common_data_object.getListMap(select_query); 
				}
				catch(Exception exception) { 
					
					log.error("",exception);
				}
				return secList;
		}
		 /*
		  * This method is accessed from kycportal/jsp/Staff/MyStudentsView.jsp
		  * To Load standard to view My Students List for the staff login  - Subhash
		 */
		public ArrayList loadStandardForStaff(String userid,String yearofsessionid,String boardid)
		{
			log.info("invoking loadStandardForStaff for loading standard for staff");
				ArrayList stdList = null;
				try
				{
					//select_query  	= "select distinct d.standardscheduleid,e.standardname,case when d.groupid is null then 'NoGroup' else (select g.groupname from standardgroup g where d.groupid=g.groupid)  end as groupname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+yearofsessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.boardid='"+boardid+"' and e.standardstatus='A'";
					select_query  	= "select distinct d.standardscheduleid,e.standardname,case when d.groupid is null then 'NoGroup' else (select g.groupname from standardgroup g where d.groupid=g.groupid)  end as groupname,date_format(d.enddate,'%d-%b-%Y') as enddate,date_format(d.startdate,'%d-%b-%Y') as startdate from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+yearofsessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.boardid='"+boardid+"' and e.standardstatus='A'";
					
					stdList 		= common_data_object.getListMap(select_query);
					//System.out.println("select_query============>>>>>>"+select_query);
				}
				catch(Exception exception) { 
					
		 			log.error("",exception);

				}
				return stdList;
		}


		 /*
		  * This method is accessed from kycportal/jsp/Staff/MyStudentsView.jsp
		  * To Load section to view My Students List for the staff login  - Subhash
		 */
		public ArrayList loadSectionForStaff(String userid,String standardscheduleid)
		{
			log.info("invoking loadSectionForStaff for loading section for staff");
				ArrayList secList = null;
				try
				{
					//select_query  	= "select distinct c.sectionscheduleid,d.sectionname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' and b.subjectscheduleid='"+subjectscheduleid+"' join sectionschedule c on b.sectionpublishid=c.sectionscheduleid and c.sectionschedulestatus='A' join section d on c.sectionid=d.sectionid and d.status='A'";
					select_query  	= "select distinct c.sectionscheduleid,d.sectionname,d.sectionid from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join sectionschedule c on c.standardscheduleid='"+standardscheduleid+"' and b.sectionpublishid=c.sectionscheduleid and c.sectionschedulestatus='A' join section d on c.sectionid=d.sectionid and d.status='A'";
					secList		 	= common_data_object.getListMap(select_query); 
				}
				catch(Exception exception) { 
					
					log.error("",exception);
				}
				return secList;
		}		

		public ArrayList loadAllotedExamforStandard(String standardscheduleid)
		{
			log.info("invoking loadAllotedExamforStandard for loading Exam for standard");
				ArrayList examList = null;
				try
				{
					//select_query  	= "select distinct c.sectionscheduleid,d.sectionname,d.sectionid from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join sectionschedule c on c.standardscheduleid='"+standardscheduleid+"' and b.sectionpublishid=c.sectionscheduleid and c.sectionschedulestatus='A' join section d on c.sectionid=d.sectionid and d.status='A'";
					//select_query  	= "select distinct a.examnameid,a.examname,b.examallotmentid from examname a,examallotment b,examschedule c where a.examnameid=b.examnameid and b.examallotmentid=c.examallotmentid and b.standardscheduleid='"+standardscheduleid+"' and a.examnamestatus='A'and b.examallotmentstatus='A' and c.exampublishstatus='A' and (c.markpublishstatus='P' or c.markpublishstatus='A') and (c.examschedulestatus='A' or c.examschedulestatus='R')";
					select_query  	= "select distinct a.examnameid,a.examname,b.examallotmentid from examname a,examallotment b,examschedule c where a.examnameid=b.examnameid and b.examallotmentid=c.examallotmentid and b.standardscheduleid='"+standardscheduleid+"' and a.examnamestatus='A'and b.examallotmentstatus='A' and c.exampublishstatus in ('A','R') and c.markpublishstatus in ('P','R') and c.examschedulestatus in ('A','R')";
					//System.out.print("select_query-->"+select_query);
					examList		= common_data_object.getListMap(select_query); 
				}
				catch(Exception exception) { 
					
					log.error("",exception);
				}
				return examList;
		}	

		public ArrayList loadAllotedExamforSession(String sessionid)
		{
			log.info("invoking loadAllotedExamforSession for loading Exam for standard");
				ArrayList examList = null;
				try
				{
					//select_query  	= "select distinct c.sectionscheduleid,d.sectionname,d.sectionid from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join sectionschedule c on c.standardscheduleid='"+standardscheduleid+"' and b.sectionpublishid=c.sectionscheduleid and c.sectionschedulestatus='A' join section d on c.sectionid=d.sectionid and d.status='A'";
					select_query  	= "select distinct a.examnameid,a.examname,b.examallotmentid from examname a,examallotment b,examschedule c where a.examnameid=b.examnameid and b.examallotmentid=c.examallotmentid and a.sessionid='"+sessionid+"' and a.examnamestatus='A'and b.examallotmentstatus='A' and c.exampublishstatus in ('A','R') and (c.markpublishstatus='P' or c.markpublishstatus='R') and (c.examschedulestatus='A' or c.examschedulestatus='R')"; 					
					examList		 	= common_data_object.getListMap(select_query); 
					//System.out.println(select_query+"<<<<<<<<<---------"); 
				}
				catch(Exception exception) { 
					exception.printStackTrace();
					log.error("",exception);
				} 
				return examList;
		}
		
		public ArrayList loadAllotedSubjectforExam(String userid,String standardscheduleid,String examallotmentid)
		{
			log.info("invoking loadAllotedSubjectforExam for loading subject for exam");
				ArrayList subList = null;
				try
				{
					//select_query  	= "select distinct c.sectionscheduleid,d.sectionname,d.sectionid from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join sectionschedule c on c.standardscheduleid='"+standardscheduleid+"' and b.sectionpublishid=c.sectionscheduleid and c.sectionschedulestatus='A' join section d on c.sectionid=d.sectionid and d.status='A'";
					//select_query  	= "select distinct b.subjectname,a.subjectscheduleid,a.subjectid,c.examscheduleid,a.theoryexternalmax,a.theoryexternalmin from subjectschedule a,subject b,examschedule c,examallotment d,subjectallotment e where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"+standardscheduleid+"' and d.examallotmentid='"+examallotmentid+"' and c.examschedulestatus in ('A','R') and c.examallotmentid=d.examallotmentid and d.examallotmentstatus='A' and a.subjectscheduleid=e.subjectscheduleid and e.staffid='"+userid+"' and e.subjectallotmentstatus='A' order by b.subjectcode";
					//select_query  	= "select distinct b.subjectname,a.subjectscheduleid,a.subjectid,c.examscheduleid,a.theoryexternalmax,a.theoryexternalmin,c.examschedulestatus,c.exampublishstatus,c.markpublishstatus from subjectschedule a,subject b,examschedule c,examallotment d,subjectallotment e where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"+standardscheduleid+"' and d.examallotmentid='"+examallotmentid+"' and (c.examschedulestatus='A' or c.examschedulestatus='P' or c.examschedulestatus='R') and c.exampublishstatus!='X' and c.examallotmentid=d.examallotmentid and d.examallotmentstatus='A' and a.subjectscheduleid=e.subjectscheduleid and e.staffid='"+userid+"' and e.subjectallotmentstatus='A' order by b.subjectcode";
					select_query  	= "select distinct b.subjectname,a.subjectscheduleid,a.subjectid,c.examscheduleid,a.theoryexternalmax,a.theoryexternalmin,c.examschedulestatus,c.exampublishstatus,c.markpublishstatus from subjectschedule a,subject b,examschedule c,examallotment d,subjectallotment e where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"+standardscheduleid+"' and d.examallotmentid='"+examallotmentid+"' and (c.examschedulestatus='A' or c.examschedulestatus='R') and c.exampublishstatus!='X' and c.examallotmentid=d.examallotmentid and d.examallotmentstatus='A' and a.subjectscheduleid=e.subjectscheduleid and e.staffid='"+userid+"' and e.subjectallotmentstatus='A' order by b.subjectcode";
					log.info("QUERY : "+select_query);
				//	System.out.println("select_query++++>"+select_query);
					
					subList		 	= common_data_object.getListMap(select_query); 
				}
				catch(Exception exception) { 
					
					log.error("",exception);
				}
				return subList;
		}	
		public ArrayList loadAllotedsectionwiseSubjectforExam(String userid,String standardscheduleid,String examallotmentid,String sectionscheduleid)
		{
			log.info("invoking loadAllotedSubjectforExam for loading subject for exam");
				ArrayList subList = null;
				try
				{
					//select_query  	= "select distinct c.sectionscheduleid,d.sectionname,d.sectionid from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join sectionschedule c on c.standardscheduleid='"+standardscheduleid+"' and b.sectionpublishid=c.sectionscheduleid and c.sectionschedulestatus='A' join section d on c.sectionid=d.sectionid and d.status='A'";
					//select_query  	= "select distinct b.subjectname,a.subjectscheduleid,a.subjectid,c.examscheduleid,a.theoryexternalmax,a.theoryexternalmin from subjectschedule a,subject b,examschedule c,examallotment d,subjectallotment e where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"+standardscheduleid+"' and d.examallotmentid='"+examallotmentid+"' and c.examschedulestatus in ('A','R') and c.examallotmentid=d.examallotmentid and d.examallotmentstatus='A' and a.subjectscheduleid=e.subjectscheduleid and e.staffid='"+userid+"' and e.subjectallotmentstatus='A' order by b.subjectcode";
					//select_query  	= "select distinct b.subjectname,a.subjectscheduleid,a.subjectid,c.examscheduleid,a.theoryexternalmax,a.theoryexternalmin,c.examschedulestatus,c.exampublishstatus,c.markpublishstatus from subjectschedule a,subject b,examschedule c,examallotment d,subjectallotment e where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"+standardscheduleid+"' and d.examallotmentid='"+examallotmentid+"' and (c.examschedulestatus='A' or c.examschedulestatus='P' or c.examschedulestatus='R') and c.exampublishstatus!='X' and c.examallotmentid=d.examallotmentid and d.examallotmentstatus='A' and a.subjectscheduleid=e.subjectscheduleid and e.staffid='"+userid+"' and e.subjectallotmentstatus='A' order by b.subjectcode";
					select_query  	= "select distinct b.subjectname,a.subjectscheduleid,a.subjectid,c.examscheduleid,a.theoryexternalmax,a.theoryexternalmin,c.examschedulestatus,c.exampublishstatus,c.markpublishstatus from subjectschedule a,subject b,examschedule c,examallotment d,subjectallotment e where a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A' and a.subjectscheduleid=c.subjectscheduleid and a.standardscheduleid='"+standardscheduleid+"' and e.sectionpublishid='"+sectionscheduleid+"' and d.examallotmentid='"+examallotmentid+"' and (c.examschedulestatus='A' or c.examschedulestatus='R') and c.exampublishstatus!='X' and c.examallotmentid=d.examallotmentid and d.examallotmentstatus='A' and a.subjectscheduleid=e.subjectscheduleid and e.staffid='"+userid+"' and e.subjectallotmentstatus='A' order by b.subjectcode";
					log.info("QUERY : "+select_query);
					//System.out.println("select_query++++>"+select_query);
					
					subList		 	= common_data_object.getListMap(select_query); 
				}
				catch(Exception exception) { 
					
					log.error("",exception);
				}
				return subList;
		}	
		
		//To check whether the  rollnoprefix is available based on sessionid - Subhash
		public String checkRollNoPrefix(String rollnoprefix,String yearofsessionid)
		{
			String temp=null;
			try
			{
				String select_query = "select rollnoprefix from sectionschedule a,standardschedule b where a.standardscheduleid=b.standardscheduleid and b.sessionid='"+yearofsessionid+"' and a.rollnoprefix='"+rollnoprefix+"' and sectionschedulestatus='A'"; 
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{				
				log.error("",e);
			}
			return temp;
		}
		
		public String checkRollNoGenStudents(String sectionscheduleid)
		{
			String temp=null;
			try
			{
				String select_query = "select distinct sectionscheduleid from studentallocation where sectionscheduleid='"+sectionscheduleid+"' and rollno IS NOT NULL"; 
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{				
				log.error("",e);
			}
			return temp;
		}
		
		
		//To check whether the  duplicate value is not available based on columnValue - Subhash
		public String checkDuplicate(String columnValue,String columnName,String tableName,String statusName)
		{
			String temp=null;
			try
			{
				String select_query = "select "+columnName+" from "+tableName+" where "+columnName+"='"+columnValue+"' and "+statusName+"='A'";
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				log.error("",e);
			}
			return temp;
		}

		// To list allocated students based on sectionscheduleid after allocating section   -- Subhash
		public ArrayList displayStudentListforPdf(String sessionId,String boardId)
		{
			log.info("invoking displayAllocatedDetails To list allocated students based on sectionscheduleid after allocating section");
			ArrayList valueList = null;
			String select_query = "";
			try
			{
				//select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' order by rollgenerationstatus,rollno,applicantname";
				//select_query = "select d.standardscheduleid,i.emailid,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus,(select standardname from standard a1,standardschedule b1 where a1.standardid=b1.standardid and b1.standardscheduleid=d.standardscheduleid and a1.standardstatus='A' and b1.stdschedulestatus='A') as standardname,(select d1.groupname from standardgroup d1 where d.groupid=d1.groupid) as groupname,(select e1.sectionname from section e1,sectionschedule f1 where f1.sectionid=e1.sectionid and f1.sectionscheduleid=g.sectionscheduleid) as sectionname,(select g1.boardname from board g1 where g1.boardid=j.boardid and boardstatus='A') as boardname from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on c.sessionid='"+sessionId+"' and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on d.stdschedulestatus='A' join standard j on j.boardid='"+boardId+"' and j.standardid=d.standardid and j.standardstatus='A' join sectionschedule h on h.standardscheduleid=d.standardscheduleid and h.sectionschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid=h.sectionscheduleid and g.studentallocationstatus='A' order by j.boardid,standardname+0,j.standardid,d.standardscheduleid,sectionname,rollno,applicantname";
				select_query = "select d.standardscheduleid,i.emailid,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus,(select standardname from standard a1,standardschedule b1 where a1.standardid=b1.standardid and b1.standardscheduleid=d.standardscheduleid and a1.standardstatus='A' and b1.stdschedulestatus='A') as standardname,(select d1.groupname from standardgroup d1 where d.groupid=d1.groupid) as groupname,(select e1.sectionname from section e1,sectionschedule f1 where f1.sectionid=e1.sectionid and f1.sectionscheduleid=g.sectionscheduleid) as sectionname,(select g1.boardname from board g1 where g1.boardid=j.boardid and boardstatus='A') as boardname from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus in ('A','D','C') join sectionschedule h on h.sectionscheduleid=g.sectionscheduleid and h.sectionschedulestatus='A' join standardschedule d on d.standardscheduleid=h.standardscheduleid and d.stdschedulestatus='A' join standard j on j.boardid='"+boardId+"' and j.standardid=d.standardid and j.standardstatus='A' join yearofsession c on c.sessionid=d.sessionid and c.sessionid='"+sessionId+"' and (c.sessionstatus='A' or c.sessionstatus='R') order by j.boardid,standardname+0,j.standardid,d.standardscheduleid,sectionname,rollno,applicantname"; 
				valueList=common_data_object.getListMap(select_query);
				//System.out.println("student details=========>>>>>>>"+select_query );
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return valueList;
		}

		// To list allocated students based on standarcscheduleid after allocating section   -- Subhash
		public ArrayList displayStdwiseStudentListforPdf(String sessionId,String boardId,String standardscheduleid)
		{
			log.info("invoking displayStdwiseStudentListforPdf To list allocated students based on standardscheduleid after allocating section");
			ArrayList valueList = null;
			String select_query = "";
			try
			{
				select_query = "select d.standardscheduleid,i.emailid,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus,(select standardname from standard a1,standardschedule b1 where a1.standardid=b1.standardid and b1.standardscheduleid=d.standardscheduleid and a1.standardstatus='A' and b1.stdschedulestatus='A') as standardname,(select d1.groupname from standardgroup d1 where d.groupid=d1.groupid) as groupname,(select e1.sectionname from section e1,sectionschedule f1 where f1.sectionid=e1.sectionid and f1.sectionscheduleid=g.sectionscheduleid) as sectionname,(select g1.boardname from board g1 where g1.boardid=j.boardid and boardstatus='A') as boardname from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus in ('A','D','C') join sectionschedule h on h.sectionscheduleid=g.sectionscheduleid and h.sectionschedulestatus='A' join standardschedule d on d.standardscheduleid=h.standardscheduleid and d.stdschedulestatus='A' join standard j on j.boardid='"+boardId+"' and j.standardid=d.standardid and j.standardstatus='A' join yearofsession c on c.sessionid=d.sessionid and d.standardscheduleid='"+standardscheduleid+"' and c.sessionid='"+sessionId+"' and (c.sessionstatus='A' or c.sessionstatus='R') order by j.boardid,standardname+0,j.standardid,d.standardscheduleid,sectionname,rollno,applicantname"; 
				valueList=common_data_object.getListMap(select_query);
				//System.out.println("student details=========>>>>>>>"+select_query );
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return valueList;
		}

		//load all terms with fees details based on academic year,board,institute -- Subhash -- Drop Down 
		public ArrayList displayStdwiseFeesDetailsforPdf(String sessionid,String boardid,String instituteid,String standardscheduleid)
	    {
		 	log.info("invoking displayConsolidateFeesDetails for loading all terms");
			ArrayList arraylist = new ArrayList();
	        try
	        {
	        	//select_query = "select a.standardscheduleid,a.groupid,b.standardname,d.termname,c.termfeesid,c.termfeesamount,date_format(c.duedate,'%d-%b-%Y') as duedate,(select groupname from standardgroup where groupid=a.groupid) as groupname from standardschedule a,standard b,termfees c,feestermname d where a.standardid=b.standardid and a.standardscheduleid=c.standardscheduleid and d.termid=c.termid and a.stdschedulestatus='A' and b.standardstatus='A' and c.termfeesstatus='A' and d.termstatus='A' and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' order by standardname+0,groupid,termname";
	        	select_query = "select a.standardscheduleid,a.groupid,b.standardname,d.termname,c.termfeesid,c.termfeesamount,date_format(c.duedate,'%d-%b-%Y') as duedate,(select groupname from standardgroup where groupid=a.groupid) as groupname from standardschedule a,standard b,termfees c,feestermname d where a.standardid=b.standardid and a.standardscheduleid=c.standardscheduleid and d.termid=c.termid and a.stdschedulestatus='A' and b.standardstatus='A' and c.termfeesstatus='A' and d.termstatus='A' and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'  and a.standardscheduleid='"+standardscheduleid+"' order by b.standardid,groupid,termname";
	        	log.info(select_query);
	        	arraylist = common_data_object.getListMap(select_query);
	        }catch(Exception e){log.error("",e);}
	        return arraylist;
	    }

		public ArrayList displayStdwiseExamnameListforPdf(String instituteid,String sessionid,String boardid,String standardscheduleid)
		{
		    ArrayList boardList = new ArrayList();
		    try
		    {      

		        //select_query = "select distinct a.examnameid,a.examname,b.sessionid from examname a, yearofsession b,standardschedule c, standard d where a.sessionid=b.sessionid and c.sessionid=b.sessionid and c.standardid=d.standardid and a.instituteid=b.instituteid and  a.sessionid='"+sessionid+"' and d.boardid='"+boardid+"'  and a.examnamestatus='A' and  b.sessionstatus='R' and c.stdschedulestatus='A' and d.standardstatus='A'";
		    	select_query = "select distinct a.examnameid,a.examname from examname a join examallotment b on a.examnameid=b.examnameid and a.sessionid='"+sessionid+"' and b.standardscheduleid='"+standardscheduleid+"' and a.examnamestatus='A' and b.examallotmentstatus='A' join examschedule c on c.examallotmentid=b.examallotmentid and c.examschedulestatus in ('A','R') and c.exampublishstatus in ('A','R') and c.markpublishstatus in ('P','R')"; 
		        boardList = common_data_object.getListMap(select_query);
		        log.info(select_query);  
		    }
		    catch(Exception exception) {log.error("",exception); }
		    return boardList;
		}
		
		// To display the allotted Exam to generate PDF   -  Subhash
		// Accessed from jsp/PDFReports/ExamReportPdf.jsp
		public ArrayList allotedStdwiseExamforPDF(String sessionid,String boardid,String instituteid,String standardscheduleid)
		{
			log.info("Invoking allotedExamforPDF() for Loading Exam List to generate PDF");
			ArrayList groupedStandardList = null;
				try
				{
					//select_query  			= "select concat(firstname,' ',lastname) as studentname,b.rollno,g.marktaken,b.studentallocationid,(select h.subjectname from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid) as subjectname,(select h.subjectcode from subject h,subjectschedule i where h.subjectid=i.subjectid and i.subjectscheduleid=f.subjectscheduleid) as subjectcode,(select sum(marktaken) from exammark a1,examschedule b1,examallotment c1 where a1.studentallocationid=b.studentallocationid and a1.examscheduleid=b1.examscheduleid and b1.examallotmentid=c1.examallotmentid and c1.examnameid='"+examid+"') as totalmark from sectionschedule a join studentallocation b on a.standardscheduleid='"+standardid+"' and a.sectionscheduleid=b.sectionscheduleid and a.sectionschedulestatus='A' and b.studentallocationstatus='A' join candidateregister c on b.candidateregisterid=c.candidateregisterid and c.candidateregisterstatus='A' join personmaster d on c.personid=d.personid and d.status='A' join examallotment e on e.examnameid='"+examid+"' and a.standardscheduleid=e.standardscheduleid and e.examallotmentstatus='A' join examschedule f on e.examallotmentid=f.examallotmentid and f.examschedulestatus='A' left outer join exammark g on f.examscheduleid=g.examscheduleid and g.markstatus='A' and b.studentallocationid=g.studentallocationid order by totalmark,rollno,subjectcode";
					select_query  			= "select distinct b.examallotmentid,b.standardscheduleid,a.examnameid,a.examname,(select a1.standardname from standard a1,standardschedule b1 where a1.standardid=b1.standardid and b1.standardscheduleid=b.standardscheduleid and a1.boardid='"+boardid+"') as standardname,(select e1.groupname from standardschedule d1,standardgroup e1 where d1.standardscheduleid=b.standardscheduleid and e1.groupid=d1.groupid) as groupname from examname a,examallotment b,examschedule c where a.examnameid=b.examnameid and b.examallotmentid=c.examallotmentid and a.sessionid='"+sessionid+"' and a.instituteid='"+instituteid+"' and b.standardscheduleid='"+standardscheduleid+"' and a.examnamestatus='A' and b.examallotmentstatus='A' and c.examschedulestatus='R' and c.exampublishstatus='R' and c.markpublishstatus='R' order by b.standardscheduleid,standardname";
					groupedStandardList 	= common_data_object.getListMap(select_query);
					log.info(select_query);
				}
				catch(Exception exception) { 
					log.error("",exception);
				}
				return groupedStandardList;
		}

		public ArrayList loadstdusingsessionid(String sessionid,String boardid,String standardscheduleid) {
			ArrayList arraylist = null;
			try {
				select_query = "SELECT ss.standardscheduleid,ss.standardid,s.standardname,(select g.groupname from standardgroup g where g.groupid=ss.groupid and g.groupstatus='A') as groupname FROM standardschedule ss,standard s where s.standardstatus='A' and ss.standardid =s.standardid and  ss.sessionid='"+sessionid+"' and s.boardid='"+boardid+"' and ss.standardscheduleid='"+standardscheduleid+"' and ss.stdschedulestatus='A' order by s.standardid";
				log.info(select_query);
				arraylist = common_data_object.getListMap(select_query);
				log.info("==========>>>>>"+arraylist);
			} catch (Exception exception) { 
				log.error("",exception);
			}
			return    arraylist;
		}		

		public ArrayList loadstdwise(String boardid,String sessionid,String instituteid,String standardscheduleid) {
			ArrayList arraylist = null;
			try {
				select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname,date_format(a.enddate,'%d-%b-%Y') as enddate,date_format(a.startdate,'%d-%b-%Y') as startdate from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	and a.standardscheduleid='"+standardscheduleid+"' and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid"; 
				log.info("===================>>>>>>>>>>>>"+select_query);
				arraylist = common_data_object.getListMap(select_query);
							
			} catch (Exception exception) { 
			}
			return    arraylist;
		}
		
		/**
		 * This method is accessed from com/igrandee/Reports/Reports/ExamDetailspdf.java
		 @param examallotmentid that can be used to get  all exam Subject details from  examname table by examallotmentid wise;
		 *
		 @return  ArrayList by which result can be printed on the screen      _prasanth
		*/

		public ArrayList loadExamSubjectListStdwise(String examid,String sessionid,String standardscheduleid)
		{
			log.info("Invoking LoadAllotedExamnameList() for Loading the alloted ExamnameList");
		    ArrayList boardList = new ArrayList();
		    try
		    {
		        //select_query = "SELECT sts.standardscheduleid,date_format(es.examdate,'%d-%b-%Y') as examdate, es.examtimein, es.examtimeout, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and exampublishstatus='R' and  markpublishstatus='R' and examschedulestatus='R' join standardschedule sts on sts.standardscheduleid=ss.standardscheduleid and stdschedulestatus='A' and sts.sessionid='"+sessionid+"' join examallotment e on es.examallotmentid=e.examallotmentid and  examnameid='"+examid+"' and examallotmentstatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'";
		    	select_query = "SELECT sts.standardscheduleid,date_format(es.examdate,'%d-%b-%Y') as examdate, es.examtimein, REPLACE(TIME_FORMAT(es.examtimein,'%r'),':00 ',' ') as examtimeinampm,es.examtimeout,REPLACE(TIME_FORMAT(es.examtimeout,'%r'),':00 ',' ') as examtimeoutampm,substring(TIMEDIFF(es.examtimeout,es.examtimein),1,5) AS duration,es.examtype, (select groupname from standardgroup sg where groupstatus='A' and sg.groupid=sts.groupid) as groupname ,st.standardname,sub.subjectname FROM examschedule es join subjectschedule ss  on es.subjectscheduleid=ss.subjectscheduleid and ss.status='A'  and exampublishstatus='R' and  markpublishstatus='R' and examschedulestatus='R' join standardschedule sts on sts.standardscheduleid=ss.standardscheduleid and stdschedulestatus='A' and sts.standardscheduleid='"+standardscheduleid+"' and sts.sessionid='"+sessionid+"' join examallotment e on es.examallotmentid=e.examallotmentid and  examnameid='"+examid+"' and examallotmentstatus='A' join standard st on st.standardid=sts.standardid and st.standardstatus='A' join subject sub on sub.subjectid=ss.subjectid and sub.subjectstatus='A'";
		        boardList = common_data_object.getListMap(select_query);
		        log.info("Exam name QUERY::>>>>"+select_query);
		    }
		    catch(Exception exception) {     
		    	log.error("",exception);
		    }
		    return boardList;
		}		
		
		//To check whether the whether the  Subject is Scheduled - Subhash
		public String checkExamSubjectSched(String examallotmentid,String subjectscheduleid)
		{
			log.info("invoking checkExamSubjectSched(examallotmentid,subjectscheduleid) for checking whether the  Subject is Scheduled");
			String temp=null;
			try
			{
				//String select_query = "select examscheduleid from examschedule where examallotmentid='"+examallotmentid+"' and subjectscheduleid='"+subjectscheduleid+"' and exampublishstatus='A' and markpublishstatus='P' and (examschedulestatus='P' or examschedulestatus='A')";
				String select_query = "select examscheduleid from examschedule where examallotmentid='"+examallotmentid+"' and subjectscheduleid='"+subjectscheduleid+"' and exampublishstatus in ('P','A','R') and markpublishstatus in ('P','A','R') and examschedulestatus in ('P','A','R')";
				log.info(select_query);
				//System.out.println("checkAppNo() ==>"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}
		
		//To check whether the whether the  Subject is in Scheduled or Published List - Subhash
		public String checkExamSubjectPublish(String examallotmentid,String subjectscheduleid)
		{
			log.info("invoking checkExamSubjectSched(examallotmentid,subjectscheduleid) for checking whether the  Subject is Scheduled");
			String temp=null;
			try
			{
				String select_query = "select examscheduleid from examschedule where examallotmentid='"+examallotmentid+"' and subjectscheduleid='"+subjectscheduleid+"' and exampublishstatus='A' and markpublishstatus='P' and (examschedulestatus='P' or examschedulestatus='A')";
				log.info(select_query);
				//System.out.println("checkAppNo() ==>"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}
		
		// To get the drop down status for entering mark in staff login - Subhash
		public ArrayList getFacultyStatus(String instituteid)throws Exception
			{
			log.info("invoking getFacultyStatus to get the drop down status for entering mark in staff login");
				ArrayList valueList = null;
				try
				{
					//String qry = "select fremarkstatusid,remarkstatusname from facultyremarksstatus where remarkstatus='A'";
					String qry = "select fremarkstatusid,remarkstatusname from facultyremarksstatus  a,login b,personmaster c,institution d where a.createdby=b.userid and b.loginstatus='A' and b.personid=c.personid and c.status='A' and c.instituteid='"+instituteid+"' and c.instituteid=d.instituteid and d.status='A' and a.remarkstatus='A'";
					log.info("Query : "+qry);
					//System.out.println("getFacultyStatus ==>"+qry);
					valueList = common_data_object.getListMap(qry);
				}
				catch(Exception e)
				{
					//System.out.println("IGST EXCEPTION ON INTRAPORTAL:::::::"+e.getMessage());
					log.error("",e);
				}
					return valueList;
		}
		
		//To check whether the whether the  Exam name is in Scheduled  List - Subhash
		public String checkExamName(String examnameid)
		{
			log.info("invoking checkExamSubjectSched(examallotmentid,subjectscheduleid) for checking whether the  Subject is Scheduled");
			String temp=null;
			try
			{
				//String select_query = "select examscheduleid from examschedule where examallotmentid='"+examallotmentid+"' and subjectscheduleid='"+subjectscheduleid+"' and exampublishstatus='A' and markpublishstatus='P' and (examschedulestatus='P' or examschedulestatus='A')";
				String select_query = "select distinct a.examnameid from examname a,examallotment b where a.examnameid=b.examnameid and a.examnameid='"+examnameid+"' and a.examnamestatus='A' and b.examallotmentstatus='A'";
				log.info(select_query);
				//System.out.println("checkAppNo() ==>"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}

		//To check whether the Community name is in registered List - Subhash
		public String checkCommunityName(String communityid)
		{
			log.info("invoking checkCommunityName(communityid) for checking whether the Community name is in registered List");
			String temp=null;
			try
			{
				String select_query = "select distinct community from personmaster where community='"+communityid+"' and status='A'";
				log.info("Query :"+select_query);
				//System.out.println("checkCommunityName() ==>"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}

		//To check whether the Religion name is in registered List - Subhash
		public String checkReligionName(String religionid)
		{
			log.info("invoking checkReligionName(religionid) for checking whether the Religion name is in registered List");
			String temp=null;
			try
			{
				String select_query = "select distinct religion from personmaster where religion='"+religionid+"' and status='A'";
				log.info("Query :"+select_query);
				//System.out.println("checkCommunityName() ==>"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}
		
		//To check whether the Scholarship name is in fees collection List - Subhash
		public String checkScholarshipName(String scholarshipid)
		{
			log.info("invoking checkScholarshipName(scholarshipid) for checking whether the Scholarship name is in fees collection List");
			String temp=null;
			try
			{
				String select_query = "select distinct scholarshipid from feescollection where scholarshipid='"+scholarshipid+"' and feescollectionstatus='A'";
				log.info("Query :"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}

		//To check whether the Fees Head name is in fees structure - Subhash
		public String checkFeesHead(String feesheadid)
		{
			log.info("invoking checkFeesHead(String feesheadid) for checking whether the Fees Head name is in fees structure");
			String temp=null;
			try
			{
				String select_query = "select distinct feesheadid from feesschedule where feesheadid='"+feesheadid+"' and feesschedulestatus='A'";
				log.info("Query :"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}
		
		//To check whether the Fees Term name is in fees structure - Subhash
		public String checkFeesTerm(String termid)
		{
			log.info("invoking checkFeesTerm(termid) for checking whether the Fees Term name is in fees structure");
			String temp=null;
			try
			{
				String select_query = "select distinct termid from termfees where termid='"+termid+"' and termfeesstatus='A'";
				log.info("Query :"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}

		//To check whether the Fees Term name is in fees structure - Subhash
		public String checkFacultyRemarks(String fremarkstatusid)
		{
			log.info("invoking checkFacultyRemarks(fremarkstatusid) for checking whether the Faculty Remark Status is in use");
			String temp=null;
			try
			{
				String select_query = "select distinct comboremarks from exammark where comboremarks='"+fremarkstatusid+"' and markstatus='A'";
				log.info("Query :"+select_query);
				temp=common_data_object.getRecordsAsString(select_query);
			}
			catch(Exception e)
			{
				//System.out.println("********EXCEPTION****"+e);
				log.error("",e);
			}
			return temp;
		}
		
		 /**
		  * This method is accessed from kycportal/jsp/GradeSetting/Scale/checkDuplicate.jsp
		  * check duplicate scales    (entry screen)      - Subhash
		    @param  scalenames that can be used to check duplicate names from scale table by instituteid,scalename,boardid wise
		    *
		    @param  boardid hat can be used to check duplicate names from scale table by instituteid,scalename,boardid wise
		    *
		    @param  instituteid hat can be used to check duplicate names from scale table by instituteid,scalename,boardid wise
		    *
		    @return the boolean by which result can be printed on the screen
		 */
		 public boolean checkDuplicateentry(String scalename,String boardid,String instituteid)
		    {
		    	boolean return_flag = false;
		    	String return_string = null;
		    	try
		    	{
		    		log.info("invoke scale checkDuplicateentry from com.iGrandee.Application.RegistrationProcess");
		    		String select_query = "SELECT scalename FROM scale where scalename='"+scalename+"' and scalestatus='A' and boardid='"+boardid+"'   and scalestatus <> 'X' " ;
		    		return_string = common_data_object.getString(select_query);
		    		if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
		    			return_flag = false;
		    		}
		    		else
		    		{
		    			return_flag = true;
		    		}
		    	}
		    	catch(Exception e)
		    	{
		    		log.error("",e);	
		    	}
		    	return return_flag;
		    }

		 /**
		  * This method is accessed from kycportal/jsp/GradeSetting/Scale/checkDuplicate.jsp
		  * check duplicate scales    (update screen)      -  Subhash
		   @param  scalename  that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
		   *
		   @param scaleid that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
		   *
		   @param boardid that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
		   *
		   @param instituteid that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
		   *
		   @return the boolean by which result can be printed on the screen
		 */
		 public boolean checkDuplicateupdate(String scalename,String scaleid,String boardid,String instituteid)
		    {
		    	boolean return_flag = false;
		    	String return_string = null;
		    	try
		    	{
		    		log.info("invoke scale checkDuplicateentry update screen from com.iGrandee.MasterEntries.Standard.StandardQuery");

		    		String select_query = "SELECT scalename FROM scale where scalename='"+scalename+"' and scalestatus='A' and boardid='"+boardid+"'  and scaleid <> "+scaleid+" " ;
		    		//System.out.print("select_query-->"+select_query);
		    		return_string = common_data_object.getString(select_query);
		    		if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
		    			return_flag = false;
		    		}
		    		else
		    		{
		    			return_flag = true;
		    		}
		    	}
		    	catch(Exception e)
		    	{
		    		log.error("",e);	
		    	}
		    	return return_flag;
		    }
		 
		//To check whether the Staff category  in fees staffmaster - Selvakumar
			public String checkStaffcategory(String staffcategoryid)
			{
				log.info("invoking checkFeesHead(String feesheadid) for checking whether the Fees Head name is in fees structure");
				String temp=null;
				try
				{
					
					String select_query = "select distinct staffcategoryid from staffmaster where staffcategoryid='"+staffcategoryid+"' and staffstatus='A'";
					log.info("Query :"+select_query);
				//	System.out.println("select_query>>>>>>>>>"+select_query);
					temp=common_data_object.getRecordsAsString(select_query);
				}
				catch(Exception e)
				{
					//System.out.println("********EXCEPTION****"+e);
					log.error("",e);
				}
				return temp;
			}
			
			public String  checkroute(String routeid){
				String checkroute=null;
				select_query="select transportrouteid from transportstage where transportstagestatus='A' and transportrouteid="+routeid+"";
				try{
					checkroute=common_data_object.getString(select_query);
					//System.out.println("select_query>>>>>>"+select_query);
				}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return checkroute;
			}

			
			public String checkfeeshead(String transportfeesheadid){
				String checkroute=null;
				select_query="select transportfeesheadid from transportstageamountallocation where transportfeesheadid='"+transportfeesheadid+"' and transportstageamountallocationstatus='A'";
				try{
					checkroute=common_data_object.getString(select_query);
					//System.out.println("select_query>>>>>>"+select_query);
				}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return checkroute;
			}
			
			
			public String checkfeescollection(String schemeforstudentid){
				String checkroute=null;
				//select_query="select termfeesid from feescollection where termfeesid='"+termfeesid+"' and feescollectionstatus='A'";
				select_query="select feescollectionid from feescollection where schemeforstudentid='"+schemeforstudentid+"' and feescollectionstatus='A'";
				try{
					checkroute=common_data_object.getString(select_query);
					//System.out.println("select_query>>>>>>"+select_query);
				}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return checkroute;
			}
			
			
			
			public String checkamountid(String transportstageamountallocationid){
				String checkroute=null;
				select_query="select transportstageamountallocationid from transportfeescollectiondetails where transportstageamountallocationid="+transportstageamountallocationid+"";
				try{
					checkroute=common_data_object.getString(select_query);
					//System.out.println("select_query>>>>>>"+select_query);
				}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return checkroute;
			}
			
			
			public String checkreduceamount(String transportstageamountallocationid){
				String checkroute=null;
				select_query="select b.transportstageamountallocationid,a.allocatedamount from transportstageamountallocation a,transportfeescollectiondetails b where b.transportfeescollectiondetailsstatus='A' and a.transportstageamountallocationstatus='A' and b.transportstageamountallocationid='"+transportstageamountallocationid+"'";
				try{
					checkroute=common_data_object.getString(select_query);
					//System.out.println("select_query>>>>>>"+select_query);
				}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return checkroute;
			}
			
			
			public String checkSamestagename(String transportrouteid, String transportstagename){
				String checkroute=null;
				select_query="select transportstagename from transportstage where transportrouteid='"+transportrouteid+"' and transportstagename='"+transportstagename+"' and transportstagestatus='A'";
				try{
					checkroute=common_data_object.getString(select_query);
					//System.out.println("select_query>>>>>>"+select_query);
				}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return checkroute;
			}
			
			
			
			public String  checkroutestage(String transportstageid){ 
				String checkroute=null;
				
				//select_query="select transportfeessettingsid from transportfeessettings where transportstageid='"+transportstageid+"' and transportfeessettingstatus='A'";
				select_query="select studentstageallocationid from studentstageallocation where transportstageid='"+transportstageid+"' and studentstageallocationstatus not in ('T','X')";
				try{
					checkroute=common_data_object.getString(select_query);
					
				}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return checkroute;
			}
			
			public String  checkdiscount(String discountamountid){ 
				String checkroute=null;
				select_query="select discountamountid from discountamount where discountcategoryid='"+discountamountid+"' and discountamountstatus='A' group by discountcategoryid";
				try{
					checkroute=common_data_object.getString(select_query);
					
				}
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return checkroute;
			}
			
//String select_query;
//CommonDataAccess common_data_object;
ConnectionManager connectionManager;
Connection registrationConnection;
		}