package com.iGrandee.TCGeneration;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

import org.apache.log4j.Logger;

public class TCGenerationQuery
{
	static Logger log = Logger.getLogger(TCGenerationQuery.class);
	public TCGenerationQuery()
	{
		common_data_object 		= new CommonDataAccess();
		connectionManager  	= new ConnectionManager();
		tcgenerationConnection	= null;
		select_query= "";
		datetime				= new DateTime();
	}
	
	
	// To insert TC Generation  -- Subhash
	public int insertTCGeneration(TCGenerationBean tcGenerationBean) throws Exception
	 {
		 	log.info("invoking insertTCGeneration for TC Generation");
		 
		 	int result							= 0;
			PreparedStatement tcgenprepared 	= null;
			String currentdate					= DateTime.showTime("MySqlWithTime");
			try
			{
				tcgenerationConnection = ConnectionManager.getKycConnection();
				tcgenerationConnection.setAutoCommit(false);
				
				String query="select max(tcissueid) from tcissue";
				long tcissueid = common_data_object.maxId(query);
				tcissueid++;
							
				//tcissueid, studentallocationid, reason, tcissuedate, createdby, ipaddress, dateofcreation, tcissuestatus
				query="insert into tcissue(tcissueid,studentallocationid,reason,tcissuedate,createdby,ipaddress,dateofcreation,tcissuestatus) values(?,?,?,?,?,?,?,?)";
				tcgenprepared = tcgenerationConnection.prepareStatement(query);
				tcgenprepared.setLong(1, tcissueid);
				tcgenprepared.setLong(2,tcGenerationBean.getStudentallocationid());
				tcgenprepared.setString(3,tcGenerationBean.getReason());
				tcgenprepared.setString(4,((StringBuffer)datetime.getMySQLFormat(tcGenerationBean.getTcissuedate())).toString());
				tcgenprepared.setLong(5,tcGenerationBean.getCreatedby());
				tcgenprepared.setString(6,tcGenerationBean.getIpaddress());
				tcgenprepared.setString(7, currentdate);				
				tcgenprepared.setString(8,"A");
				result += tcgenprepared.executeUpdate();

				query="update studentallocation set studentallocationstatus=? where studentallocationid=?";
				tcgenprepared = tcgenerationConnection.prepareStatement(query);
				tcgenprepared.setString(1, "C");
				tcgenprepared.setLong(2,tcGenerationBean.getStudentallocationid());

				result += tcgenprepared.executeUpdate();				
				tcgenerationConnection.commit();
	
			 
		 }catch(SQLException e){
			 
				log.error("",e);
				result	= 0;
				if(tcgenerationConnection != null)
					tcgenerationConnection.rollback();
		 }
		 finally
		 {
		 
			 if(tcgenprepared != null)
				 tcgenprepared.close();
			
			 if(tcgenerationConnection != null)
				 tcgenerationConnection.close();
		 }
		 return result;
	 }
	
	// To list allocated students based on session,board,standardschedule after allocating section to issue TC    -- Subhash
	public ArrayList displayTCIssueDetails(String secScheduleId)
	{
	 	log.info("invoking displayTCIssueDetails to issue TC");
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when h.tcissueid is null then 'NotGenerated' else date_format(h.tcissuedate,'%d-%b-%Y') end as tcgenerationdate,h.reason from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'  join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' left outer join tcissue h on h.studentallocationid=g.studentallocationid and h.tcissuestatus='A'";
			select_query = "select i.firstname,i.middlename,i.lastname,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when h.tcissueid is null then 'NotGenerated' else date_format(h.tcissuedate,'%d-%b-%Y') end as tcgenerationdate,h.reason from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'  join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and (g.studentallocationstatus='A' or g.studentallocationstatus='C') left outer join tcissue h on h.studentallocationid=g.studentallocationid and h.tcissuestatus='A' order by firstname asc";
			valueList=common_data_object.getListMap(select_query);
			//System.out.println("student details "+select_query );
		}
		catch(Exception e)
		{
			log.error("",e);
			//System.out.println("********EXCEPTION****"+e);
		}
		return valueList;
	}
	
	// To list tc issued students based on session,board,standardschedule after allocating section   -- Subhash
	public ArrayList listTCIssuedDetails(String secScheduleId,String status)
	{
	 	log.info("invoking listTCIssuedDetails to list the TC issued students");
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation,a.applicantname,a.applicationno,case when h.tcissueid is null then 'NotGenerated' else date_format(h.dateofcreation,'%d-%m-%Y') end as tcgenerationdate from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' left outer join tcissue h on h.studentallocationid=g.studentallocationid and h.tcissuestatus='A'";
			//select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,h.tcissueid,h.reason,date_format(h.tcissuedate,'%d-%b-%Y') as tcissuedate,date_format(h.tcissuedate,'%d-%b-%Y') as tcgenerationdate,h.reason from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'  join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and (g.studentallocationstatus='A' or g.studentallocationstatus='C') join tcissue h on h.studentallocationid=g.studentallocationid and h.tcissuestatus='"+status+"'";
			select_query = "select i.firstname,i.middlename,i.lastname,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,h.tcissueid,h.reason,date_format(h.tcissuedate,'%d-%b-%Y') as tcissuedate,date_format(h.tcissuedate,'%d-%b-%Y') as tcgenerationdate,h.reason from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A'  join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and (g.studentallocationstatus='A' or g.studentallocationstatus='C') join tcissue h on h.studentallocationid=g.studentallocationid and h.tcissuestatus='"+status+"'";
			valueList=common_data_object.getListMap(select_query);
			//System.out.println("student details "+select_query );
		}
		catch(Exception e)
		{
			log.error("",e);
			//System.out.println("********EXCEPTION****"+e);
		}
		return valueList;
	}
	
	// To update TC Generation  -- Subhash
	public int updateTCGeneration(TCGenerationBean tcGenerationBean) throws Exception
	 {
		 	log.info("invoking updateTCGeneration for TC Updation");
		 
		 	int result							= 0;
			PreparedStatement tcgenprepared 	= null;
			String currentdate					= DateTime.showTime("MySqlWithTime");
			try
			{
				tcgenerationConnection = ConnectionManager.getKycConnection();
				tcgenerationConnection.setAutoCommit(false);
				
				String query;
							
				//tcissueid, studentallocationid, reason, tcissuedate, createdby, ipaddress, dateofcreation, tcissuestatus
				query="update tcissue set reason=?,tcissuedate=?,createdby=?,ipaddress=?,dateofcreation=? where tcissueid=?";
				tcgenprepared = tcgenerationConnection.prepareStatement(query);
				tcgenprepared.setString(1, tcGenerationBean.getReason());
				tcgenprepared.setString(2,((StringBuffer)datetime.getMySQLFormat(tcGenerationBean.getTcissuedate())).toString());
				tcgenprepared.setLong(3,tcGenerationBean.getCreatedby());
				tcgenprepared.setString(4,tcGenerationBean.getIpaddress());
				tcgenprepared.setString(5,currentdate);
				tcgenprepared.setLong(6,tcGenerationBean.getTcissueid());

				result += tcgenprepared.executeUpdate();
				
				tcgenerationConnection.commit();
	
			 
		 }catch(SQLException e){
			 
				log.error("",e);
				result	= 0;
				if(tcgenerationConnection != null)
					tcgenerationConnection.rollback();
		 }
		 finally
		 {
		 
			 if(tcgenprepared != null)
				 tcgenprepared.close();
			
			 if(tcgenerationConnection != null)
				 tcgenerationConnection.close();
		 }
		 return result;
	 }
	
	// To update status of TC Generation  -- Subhash
	public int updateStatusTCGeneration(TCGenerationBean tcGenerationBean) throws Exception
	 {
		 	log.info("invoking updateStatusTCGeneration to update the status of TC");
		 
		 	int result							= 0;
			PreparedStatement tcgenprepared 	= null;
			String currentdate					= DateTime.showTime("MySqlWithTime");
			try
			{
				tcgenerationConnection = ConnectionManager.getKycConnection();
				tcgenerationConnection.setAutoCommit(false);
				
				String query;
							
				//tcissueid, studentallocationid, reason, tcissuedate, createdby, ipaddress, dateofcreation, tcissuestatus
				query="update tcissue set tcissuestatus=?,createdby=?,ipaddress=?,dateofcreation=? where tcissueid=?";
				tcgenprepared = tcgenerationConnection.prepareStatement(query);
				tcgenprepared.setString(1, tcGenerationBean.getTcissuestatus());
				tcgenprepared.setLong(2,tcGenerationBean.getCreatedby());
				tcgenprepared.setString(3,tcGenerationBean.getIpaddress());
				tcgenprepared.setString(4,currentdate);
				tcgenprepared.setLong(5,tcGenerationBean.getTcissueid());

				result += tcgenprepared.executeUpdate();
				
				tcgenerationConnection.commit();
	
			 
		 }catch(SQLException e){
			 
				log.error("",e);
				result	= 0;
				if(tcgenerationConnection != null)
					tcgenerationConnection.rollback();
		 }
		 finally
		 {
		 
			 if(tcgenprepared != null)
				 tcgenprepared.close();
			
			 if(tcgenerationConnection != null)
				 tcgenerationConnection.close();
		 }
		 return result;
	 }
	
	// To list alumini students based on session,board,standardschedule after allocating section   -- Subhash
	public ArrayList listAluminiStudents(String secScheduleId,String status)
	{
	 	log.info("invoking listAluminiStudents To list alumini students");
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,a.applicantname,a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' join tcissue h on h.studentallocationid=g.studentallocationid and h.tcissuestatus='"+status+"'";
			//select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as profilename,i.mobilenumber,i.emailid,g.studentallocationid,g.rollno,f.candidateregisterid,a.applicantname,a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='C' join tcissue h on h.studentallocationid=g.studentallocationid and h.tcissuestatus='"+status+"'";
			select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as profilename,i.mobilenumber,i.emailid,g.studentallocationid,g.rollno,f.candidateregisterid,a.applicantname,a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='C' join tcissue h on h.studentallocationid=g.studentallocationid and h.tcissuestatus='"+status+"'";
			valueList=common_data_object.getListMap(select_query);
			//System.out.println("student details "+select_query );
		}
		catch(Exception e)
		{
			log.error("",e);
			//System.out.println("********EXCEPTION****"+e);
		}
		return valueList;
	}

	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection tcgenerationConnection;
	 DateTime datetime;
}