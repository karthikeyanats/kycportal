/**
 * 
 */
package com.iGrandee.TransportFees.TravelAttendance;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Fees.FeesHeadQuery;
import com.iGrandee.TransportFees.TravelAttendance.TransportAttendance;

/**
 * @author sindhuja_v
 *
 */
public class TransportAttendanceAction {
	
static Logger log = Logger.getLogger(FeesHeadQuery.class);
	
	public TransportAttendanceAction()
	{
		 common_data_object = new CommonDataAccess();
		 ConnectionManager  = new ConnectionManager();
		 Connection      = null;
		 rollbackvalue = 0;		 
		 select_query= "";
	}
	
	
	
	public int inserttransportattendance(String transportcategoryid, String[] chkBoxId,
			String createdby) throws SQLException,
			Exception {
		log
				.info("Invoking insertExamAllotment() for inserting the exam allotment");
		Connection = ConnectionManager.getKycConnection();
		Connection.setAutoCommit(false);

		PreparedStatement examallot = null;
		PreparedStatement allotid = null;
		
		ResultSet allotrs = null;
		long transportattendanceid = 0l;

		String currentdate			= DateTime.showTime("MySqlWithTime");

		try {

			allotid = Connection
					.prepareStatement("select max(transportattendanceid) from transportattendance");
			allotrs = allotid.executeQuery();

			if (allotrs.next())
				transportattendanceid = allotrs.getLong(1);
			transportattendanceid++;

			examallot = Connection
					.prepareStatement("insert into transportattendance (transportattendanceid, transportcategoryid, studentstageallocationid, studentapprovalid, dateofcreation, createdby, travelledstatus, transportattendancestatus) values (?, ?, ?, ?, ?, ?, ?, ?)");

			if (chkBoxId != null && chkBoxId.length > 0) {

				for (int j = 0; j < chkBoxId.length; j++) {
					String[] studentapprovalid = chkBoxId[j].split("@");
					examallot.setLong(1, transportattendanceid);
					examallot.setString(2, transportcategoryid);
					examallot.setString(3, "1");
					examallot.setString(4, studentapprovalid[0]);
					examallot.setString(5, currentdate);
					examallot.setString(6, createdby);
					examallot.setString(7, "A");
					examallot.setString(8, "A");
					rollbackvalue += examallot.executeUpdate();
					transportattendanceid++;
				}
			}

			int temp[] = null;
			temp = examallot.executeBatch();
			if (temp != null && temp.length > 0)
				for (int y = 0; y < temp.length; y++)
					rollbackvalue += temp[y];
			Connection.commit();
		} catch (SQLException sqlexception) {

			sqlexception.printStackTrace();
			if (Connection != null)
				Connection.rollback();
			rollbackvalue = 0;

		}

		finally {

			if (allotrs != null)
				allotrs.close();

			if (allotid != null)
				allotid.close();

			if (examallot != null)
				examallot.close();

			if (Connection != null)
				Connection.close();

		}
		return rollbackvalue;
	}
	
	
public int inserttransportattendancefdfd(TransportAttendance travelattendance) throws Exception{
		
		int result=0;
		PreparedStatement travelattendanceprepared = null;
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null;

		try {
			Connection= ConnectionManager.getKycConnection(); 
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
				
			
			String query="select max(transportattendanceid) from transportattendance";
			long transportattendanceid = common_data_object.maxId(query);
			transportattendanceid++;

			query="insert into transportattendance (transportattendanceid, transportcategoryid, studentstageallocationid, studentapprovalid, dateofcreation, createdby, travelledstatus, transportattendancestatus) values (?, ?, ?, ?, ?, ?, ?, ?)";
			travelattendanceprepared = Connection.prepareStatement(query);
			log.info(query);
			
			travelattendanceprepared.setString(1, travelattendance.getTransportattendanceid()); 
			travelattendanceprepared.setString(2, travelattendance.getTransportcategoryid());
			travelattendanceprepared.setString(3, travelattendance.getStudentallocationid());
			travelattendanceprepared.setString(4, travelattendance.getStudentapprovalid());
			travelattendanceprepared.setString(5, currentdate);
			travelattendanceprepared.setString(6, travelattendance.getCreatedby());
			travelattendanceprepared.setString(6, travelattendance.getTravelledstatus());
			travelattendanceprepared.setString(6, travelattendance.getTransportattendancestatus());

			result += travelattendanceprepared.executeUpdate();
				
			System.out.println("result>>>>>>>>>>>"+result);

		
			Connection.commit();
		}	
			catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(Connection!=null){
				
				Connection.rollback();
			}
		}
		 finally
			{
		 
			 if(travelattendanceprepared != null)
				 travelattendanceprepared.close();
			 
			 if(Connection != null)
				 Connection.close();
			 }
		
		return result;
	}


	

public int updatetransportattendance(TransportAttendance travelattendance) throws Exception{
	
	int result=0;
	PreparedStatement travelattendanceprepared = null;
	ResultSet checkrs 					= null;
	PreparedStatement checkprepared 	= null;

	try {
		Connection= ConnectionManager.getKycConnection(); 
		Connection.setAutoCommit(false);
		String currentdate			= DateTime.showTime("MySqlWithTime");
			
		
		String query="select max(transportattendanceid) from transportattendance";
		long transportattendanceid = common_data_object.maxId(query);
		transportattendanceid++;

		query="update from transportattendance set transportattendanceid=?, transportcategoryid=?, studentstageallocationid=?, studentapprovalid=?, dateofcreation=?, createdby=?, travelledstatus=?, transportattendancestatus=?";
		travelattendanceprepared = Connection.prepareStatement(query);
		log.info(query);
		
		travelattendanceprepared.setString(1, travelattendance.getTransportattendanceid()); 
		travelattendanceprepared.setString(2, travelattendance.getTransportcategoryid());
		travelattendanceprepared.setString(3, travelattendance.getStudentallocationid());
		travelattendanceprepared.setString(4, travelattendance.getStudentapprovalid());
		travelattendanceprepared.setString(5, currentdate);
		travelattendanceprepared.setString(6, travelattendance.getCreatedby());
		travelattendanceprepared.setString(6, travelattendance.getTravelledstatus());
		travelattendanceprepared.setString(6, travelattendance.getTransportattendancestatus());

		result += travelattendanceprepared.executeUpdate();
			
		System.out.println("result>>>>>>>>>>>"+result);

	
		Connection.commit();
	}	
		catch (SQLException e) {
		
		e.printStackTrace();
		result	= 0;
		if(Connection!=null){
			
			Connection.rollback();
		}
	}
	 finally
		{
	 
		 if(travelattendanceprepared != null)
			 travelattendanceprepared.close();
		 
		 if(Connection != null)
			 Connection.close();
		 }
	
	return result;
}

	
	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager ConnectionManager;
	 Connection Connection;
	 int rollbackvalue;

}
