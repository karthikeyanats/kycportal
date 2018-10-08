
package com.iGrandee.Fees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

import org.apache.log4j.Logger;

public class TermFeesQuery
{
	static Logger log = Logger.getLogger(TermFeesQuery.class);
	public TermFeesQuery()
	{
		common_data_object = new CommonDataAccess();
		connectionManager  = new ConnectionManager();
		termfeesConnection = null;
		rollbackvalue = 0;
		select_query= "";
		date_object = new DateTime();
	}
	
	
	public int insertTermFeesAllotment(TermFeesBean termFeesBean) throws Exception
	 {
		 	log.info("invoking insertTermFeesAllotment for  Term Fees Structure");
		 
		 	int result	= 0;
			PreparedStatement termfeesprepared = null;
			String currentdate	= DateTime.showTime("MySqlWithTime");
			
			//termfeesid, termid, standardscheduleid, termfeesamount, createdby, dateofcreation, termfeesstatus
	 try
	 {
		 	termfeesConnection = ConnectionManager.getKycConnection();
			termfeesConnection.setAutoCommit(false);
			
						
			String query="select max(termfeesid) from termfees";
			long termfeesid = common_data_object.maxId(query);
			termfeesid++;

			query="insert into termfees (termfeesid, termid, standardscheduleid, termfeesamount, createdby, dateofcreation, termfeesstatus,duedate) values(?,?,?,?,?,?,?,?)";
			termfeesprepared = termfeesConnection.prepareStatement(query);
			termfeesprepared.setLong(1, termfeesid);
			termfeesprepared.setString(2,termFeesBean.getTermid());
			termfeesprepared.setString(3,termFeesBean.getStandardscheduleid());
			termfeesprepared.setString(4,termFeesBean.getTermfeesamount());
			termfeesprepared.setString(5,termFeesBean.getCreatedby());
			termfeesprepared.setString(6, currentdate);
			termfeesprepared.setString(7,"A");
			//termFeesBean.getDuedate()
			String duedate = termFeesBean.getDuedate();
			termfeesprepared.setString(8,((StringBuffer)date_object.getMySQLFormat(duedate)).toString());

			result += termfeesprepared.executeUpdate();
			
			termfeesConnection.commit();
	 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(termfeesConnection != null)
				termfeesConnection.rollback();
	 }
	 finally
		{
	 
		 if(termfeesprepared != null)
			termfeesprepared.close();
		
		 if(termfeesConnection != null)
		 termfeesConnection.close();
		 }
	 return result;
	 }

	
	//update term fees allotment
	public int updateTermFeesallotment(TermFeesBean termFeesBean) throws Exception
	 {
		 	log.info("invoking updateTermFeesallotment for term fees allotment");
		 
		 	int result	= 0;
			PreparedStatement termfeesupdateprepared = null;
			//String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	termfeesConnection = ConnectionManager.getKycConnection();
			termfeesConnection.setAutoCommit(false);
			
			/*String operationstatus = (String)FeesScheduleBean.getFeesoperation();
			if(operationstatus.equals("updatestatus"))
			{
				select_query="update lesson set feesheadstatus=? where feesheadid=?";
				termfeesupdateprepared = termfeesConnection.prepareStatement(select_query);
				termfeesupdateprepared.setString(1,FeesScheduleBean.getFeesheadstatus());
				termfeesupdateprepared.setString(2,FeesScheduleBean.getFeesheadid());
				result += termfeesupdateprepared.executeUpdate();
				termfeesConnection.commit();
				
			}
			else if(operationstatus.equals("updatefeeshead"))
			{*/
				select_query="update termfees set termfeesamount=?,duedate=? where termfeesid=?";
				termfeesupdateprepared = termfeesConnection.prepareStatement(select_query);
				termfeesupdateprepared.setString(1,termFeesBean.getTermfeesamount());
				termfeesupdateprepared.setString(2,((StringBuffer)date_object.getMySQLFormat(termFeesBean.getDuedate())).toString());
				termfeesupdateprepared.setString(3,termFeesBean.getTermfeesid());
				result += termfeesupdateprepared.executeUpdate();
				termfeesConnection.commit();
			//}
		
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(termfeesConnection != null)
				termfeesConnection.rollback();
	 }
	 finally
		{
	 
		 if(termfeesupdateprepared != null)
			termfeesupdateprepared.close();
		
		 if(termfeesConnection != null)
		 termfeesConnection.close();
		 }
	 return result;
	 }
	
	//update term fees status
	public int updateTermFeesStatus(TermFeesBean termFeesBean) throws Exception
	 {
		 	log.info("invoking updateTermFeesallotment for term fees allotment");
		 
		 	int result	= 0;
			PreparedStatement termfeesupdatestatusprepared = null;
			
	 try
	 {
		 	termfeesConnection = ConnectionManager.getKycConnection();
			termfeesConnection.setAutoCommit(false);
			
			
			select_query="update termfees set termfeesstatus=? where termfeesid=?";
			termfeesupdatestatusprepared = termfeesConnection.prepareStatement(select_query);
			termfeesupdatestatusprepared.setString(1,termFeesBean.getTermfeesstatus());
			termfeesupdatestatusprepared.setString(2,termFeesBean.getTermfeesid());
			result += termfeesupdatestatusprepared.executeUpdate();
			//System.out.println("termfeesupdatestatusprepared>>>>>"+termfeesupdatestatusprepared);
			termfeesConnection.commit();
			
			
		
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(termfeesConnection != null)
				termfeesConnection.rollback();
	 }
	 finally
		{
	 
		 if(termfeesupdatestatusprepared != null)
			termfeesupdatestatusprepared.close();
		
		 if(termfeesConnection != null)
		 termfeesConnection.close();
		 }
	 return result;
	 }
	DateTime date_object;
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection termfeesConnection;
	 int rollbackvalue;
}