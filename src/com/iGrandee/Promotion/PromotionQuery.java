package com.iGrandee.Promotion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

import org.apache.log4j.Logger;

public class PromotionQuery
{
	static Logger log = Logger.getLogger(PromotionQuery.class);
	public PromotionQuery()
	{
		common_data_object 		= new CommonDataAccess();
		connectionManager  	= new ConnectionManager();
		promotionConnection	= null;
		select_query= "";
	}
	
	
	// To list students to promote based on session,board,standardschedule after or before promotion   -- Subhash
	public ArrayList displayToPromoteDetails(String sessionId,String stdScheduleId,String secScheduleId)
	{
		log.info("Invoking displayToPromoteDetails(sessionId,stdScheduleId,secScheduleId) for listing students to promote");
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation,a.applicantname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A'";
			select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname,a.applicationno,case when h.studentpromotionid is null then 'NotPromoted' else h.promotionstatus end as promotionstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' left outer join studentpromotion h on h.studentallocationid=g.studentallocationid and h.studentpromotionstatus='A'";
			
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
	
	// To list students to promote based on sectionschedule after or before promotion   -- Subhash
	public ArrayList displayToPromoteDetails(String secScheduleId)
	{
		log.info("Invoking displayToPromoteDetails(secScheduleId) for listing students to promote");
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation,a.applicantname,a.applicationno,case when g.rollno is null then 'NotGenerated' else 'Generated' end as rollgenerationstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A'";
			select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when h.studentpromotionid is null then 'NotPromoted' else h.promotionstatus end as promotionstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='R' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' left outer join studentpromotion h on h.studentallocationid=g.studentallocationid and h.studentpromotionstatus='A'";
			
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
	
	// To insert student promotion -- Subhash
	public int insertPromotion(PromotionBean promotionBean) throws Exception
	 {
		 	log.info("invoking insertPromotion for Student Promotion");
		 	int result							= 0;
			PreparedStatement promoprepared 	= null;
			String currentdate					= DateTime.showTime("MySqlWithTime");
			try
			{
				promotionConnection = ConnectionManager.getKycConnection();
				promotionConnection.setAutoCommit(false);
				
				String query="select max(studentpromotionid) from studentpromotion";
				long studentpromotionid = common_data_object.maxId(query);
				studentpromotionid++;
				
				query="insert into studentpromotion(studentpromotionid,studentallocationid,standardscheduleid,promotionstatus,dateofcreation,createdby,studentpromotionstatus,allocationafterpromotion) values(?,?,?,?,?,?,?,?)";
				promoprepared = promotionConnection.prepareStatement(query);
				promoprepared.setLong(1, studentpromotionid);
				promoprepared.setString(2,promotionBean.getStudentallocationid());
				promoprepared.setString(3,promotionBean.getStandardscheduleid());
				promoprepared.setString(4,promotionBean.getPromotionstatus());
				promoprepared.setString(5, currentdate);
				promoprepared.setString(6,promotionBean.getCreatedby());
				promoprepared.setString(7,"A");
				promoprepared.setString(8,"NO");
				result += promoprepared.executeUpdate();
				
				promotionConnection.commit();
	
			 
		 }catch(SQLException e){
			 
				log.error(e);
				result	= 0;
				if(promotionConnection != null)
					promotionConnection.rollback();
		 }
		 finally
		 {
		 
			 if(promoprepared != null)
				 promoprepared.close();
			
			 if(promotionConnection != null)
				 promotionConnection.close();
		 }
		 return result;
	 }
	
	// To list students to promote based on session,board,standardschedule after or before promotion   -- Subhash
	public ArrayList displayPromotedDetails(String sessionId,String stdScheduleId,String secScheduleId,String promotionResult)
	{
	 	log.info("invoking displayPromotedDetails(sessionId,stdScheduleId,secScheduleId,promotionResult) for listing students to promote");
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation,a.applicantname,a.applicationno,case when h.studentpromotionid is null then 'NotPromoted' else h.promotionstatus end as promotionstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"' and g.studentallocationstatus='A' left outer join studentpromotion h on h.studentallocationid=g.studentallocationid and h.studentpromotionstatus='A'";
			select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when h.studentpromotionid is null then 'NotPromoted' else h.promotionstatus end as promotionstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionId+"' and b.standardpublishid='"+stdScheduleId+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='R' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+secScheduleId+"'  join studentpromotion h on h.studentallocationid=g.studentallocationid and h.studentpromotionstatus='A' and h.promotionstatus='"+promotionResult+"'";
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
	
	// To list promoted students based on standardschedule after promotion   -- Subhash
	public ArrayList displayPromotedDetails(String stdScheduleId)
	{
	 	log.info("invoking displayPromotedDetails(stdScheduleId) for listing promoted students");
		ArrayList valueList = null;
		String select_query = "";
		try
		{
			//select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when h.studentpromotionid is null then 'NotPromoted' else h.promotionstatus end as promotionstatus,h.studentpromotionid,h.allocationafterpromotion,case when h.allocationafterpromotion='YES' then (select a1.sectionname from section a1,sectionschedule b1,studentallocation c1 where c1.candidateregisterid=f.candidateregisterid and c1.sectionscheduleid=b1.sectionscheduleid and b1.sectionid=a1.sectionid and studentallocationstatus='A') else 'No Section' end as sectionname from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid join studentpromotion h on h.studentallocationid=g.studentallocationid and h.studentpromotionstatus='A' and h.standardscheduleid='"+stdScheduleId+"' and h.studentallocationid not in (select studentallocationid from tcissue where tcissuestatus='A') order by sectionname,a.applicationno";
			select_query = "select case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,case when g.rollno is null then '-' else g.rollno end as rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when h.studentpromotionid is null then 'NotPromoted' else h.promotionstatus end as promotionstatus,h.studentpromotionid,h.allocationafterpromotion,case when h.allocationafterpromotion='YES' then (select a1.sectionname from section a1,sectionschedule b1,studentallocation c1 where c1.candidateregisterid=f.candidateregisterid and c1.sectionscheduleid=b1.sectionscheduleid and b1.sectionid=a1.sectionid and studentallocationstatus='A') else 'No Section' end as sectionname,d.noofseats as totalseats,(select count(a11.studentallocationid) from studentallocation a11,sectionschedule b11,standardschedule c11 where a11.sectionscheduleid=b11.sectionscheduleid and b11.standardscheduleid=c11.standardscheduleid and c11.standardscheduleid='"+stdScheduleId+"' and a11.studentallocationstatus='A' and b11.sectionschedulestatus='A' and c11.stdschedulestatus='A') as allocatedseats from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join standardschedule d on d.standardscheduleid='"+stdScheduleId+"' and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid join studentpromotion h on h.studentallocationid=g.studentallocationid and h.studentpromotionstatus='A' and h.standardscheduleid='"+stdScheduleId+"' and h.studentallocationid not in (select studentallocationid from tcissue where tcissuestatus='A') order by sectionname,a.applicationno";
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
	
	// To allocate the section for promoted student - Subhash
	public int insertAllocationPromotion(PromotionBean promotionBean) throws Exception
	 {
		 	log.info("invoking insertAllocationPromotion for Student Promotion");
		 
		 	int result							= 0;
		 	PreparedStatement alloprepared 		= null;
		 	PreparedStatement promoprepared 	= null;
			String currentdate					= DateTime.showTime("MySqlWithTime");
			try
			{
				promotionConnection = ConnectionManager.getKycConnection();
				promotionConnection.setAutoCommit(false);

				select_query  	= "update studentpromotion set allocationafterpromotion=? where studentpromotionid=?";
				promoprepared		=  promotionConnection.prepareStatement(select_query);
				promoprepared.setString(1,"YES");
				promoprepared.setString(2,promotionBean.getStudentpromotionid());
				result 	+= promoprepared.executeUpdate();

				select_query  	= "update studentallocation set studentallocationstatus=? where studentallocationid=?";
				promoprepared		=  promotionConnection.prepareStatement(select_query);
				promoprepared.setString(1,"D");
				promoprepared.setString(2,promotionBean.getStudentallocationid());
				result 	+= promoprepared.executeUpdate();
				
				select_query="select max(studentallocationid) from studentallocation";
				long studentallocationid = common_data_object.maxId(select_query);
				studentallocationid++;
				
				//select_query="insert into studentallocation(studentallocationid,candidateregisterid,sectionscheduleid,rollno,studentcurrentstatus,dateofcreation,studentallocationstatus,createdby) values(?,?,?,?,?,?,?,?)";
				select_query="insert into studentallocation(studentallocationid,candidateregisterid,sectionscheduleid,studentcurrentstatus,dateofcreation,studentallocationstatus,createdby) values(?,?,?,?,?,?,?)";
				promoprepared = promotionConnection.prepareStatement(select_query);
				promoprepared.setLong(1, studentallocationid);
				promoprepared.setString(2,promotionBean.getCandidateregisterid());
				promoprepared.setString(3,promotionBean.getSectionscheduleid());
				//promoprepared.setString(4,promotionBean.getRollno());
				promoprepared.setString(4,promotionBean.getPromotionstatus());
				promoprepared.setString(5, currentdate);
				promoprepared.setString(6, "A");
				promoprepared.setString(7,promotionBean.getCreatedby());
				result += promoprepared.executeUpdate();
				
				promotionConnection.commit();
	
			 
		 }catch(SQLException e){
			 
				log.error(e);
				e.printStackTrace();
				result	= 0;
				if(promotionConnection != null)
					promotionConnection.rollback();
		 }
		 finally
		 {
		 
			 if(promoprepared != null)
				 promoprepared.close();
			
			 if(promotionConnection != null)
				 promotionConnection.close();
		 }
		 return result;
	 }
	
	/*
	//subjectid, subjectname, subjecttypeid, subjectypename
	public ArrayList listFeesTerm(String instituteid,String feesheadstatus)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT termid, termname, description, createdby, instituteid, date_format(termcreationdate,'%d-%m-%Y') as termcreationdate from feestermname where  instituteid='"+instituteid+"' and termstatus='"+feesheadstatus+"'";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	//update feesterm
	public int updateFeesterm(FeesTermBean feestermBean) throws Exception
	 {
		 	log.info("invoking updateFeesterm for  updateFeesterm");
		 
		 	int result	= 0;
			PreparedStatement feestermprepared = null;
			//String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	feestermConnection = ConnectionManager.getKycConnection();
			feestermConnection.setAutoCommit(false);
			
			String operationstatus = (String)feestermBean.getFeesoperation();
			if(operationstatus.equals("updatestatus"))
			{
				select_query="update lesson set feesheadstatus=? where feestermid=?";
				feestermprepared = feestermConnection.prepareStatement(select_query);
				feestermprepared.setString(1,feestermBean.getTermstatus());
				feestermprepared.setString(2,feestermBean.getFeestermid());
				result += feestermprepared.executeUpdate();
				feestermConnection.commit();
				
			}
			else if(operationstatus.equals("updatefeesterm"))
			{
				select_query="update lesson set feesheadname=? where feestermid=?";
				feestermprepared = feestermConnection.prepareStatement(select_query);
				feestermprepared.setString(1,feestermBean.getTermname());
				feestermprepared.setString(2,feestermBean.getFeestermid());
				result += feestermprepared.executeUpdate();
				feestermConnection.commit();
			}
		
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(feestermConnection != null)
				feestermConnection.rollback();
	 }
	 finally
		{
	 
		 if(feestermprepared != null)
			feestermprepared.close();
		
		 if(feestermConnection != null)
		 feestermConnection.close();
		 }
	 return result;
	 }*/

	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection promotionConnection;
}