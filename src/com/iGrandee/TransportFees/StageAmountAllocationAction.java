/**
 * 
 */
package com.iGrandee.TransportFees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Fees.FeesHeadQuery;

/**
 * @author sindhuja_v
 *
 */
public class StageAmountAllocationAction {
	
static Logger log = Logger.getLogger(FeesHeadQuery.class);
	
	public StageAmountAllocationAction()
	{
		 common_data_object = new CommonDataAccess();
		 ConnectionManager  = new ConnectionManager();
		 Connection      = null;
		 rollbackvalue = 0;
		 select_query= "";
	}
	
	public int inserttranspotamount(StageAmountAllocation amountobj) throws Exception{
		
		int result=0;
		PreparedStatement transportfeestype = null;
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null;

		try {
			Connection= ConnectionManager.getKycConnection(); 
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
				
			
			String query="select max(transportstageamountallocationid) from transportstageamountallocation";
			long transportstageamountallocationid = common_data_object.maxId(query);
			transportstageamountallocationid++;

			query="insert into  transportstageamountallocation (transportstageamountallocationid, transportcategoryid, transportstageid, transportfeesheadid, allocatedamount, createdby, dateofcreation, transportstageamountallocationstatus) values (?, ?, ?, ?, ?, ?, ?, ?)";
			
			transportfeestype = Connection.prepareStatement(query);
			transportfeestype.setLong(1, transportstageamountallocationid);
			transportfeestype.setString(2,amountobj.getTransportcategoryid());
			transportfeestype.setString(3,amountobj.getTransportstageid());
			transportfeestype.setString(4,amountobj.getTransportfeesheadid());
			transportfeestype.setString(5,amountobj.getAllocatedamount());
			transportfeestype.setString(6,amountobj.getCreatedby());
			transportfeestype.setString(7, currentdate);
			transportfeestype.setString(8,amountobj.getTransportstageamountallocationstatus());
			//System.out.println("transportstageprepared>>>>>>>>>>>"+transportfeestype);

			result += transportfeestype.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);

		
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
		 
			 if(transportfeestype != null)
				 transportfeestype.close();
			 
			 if(Connection != null)
				 Connection.close();
			 }
		
		return result;
	}
	
	
	
public int Updatetranspotamount(StageAmountAllocation amountobj,String transportstageamountallocationid) throws Exception{
		
		int result=0;
		PreparedStatement transportfeestype = null;
		//ResultSet checkrs 					= null;
		//PreparedStatement checkprepared 	= null;

		try {
			Connection= ConnectionManager.getKycConnection(); 
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
			

			String query="Update transportstageamountallocation set transportcategoryid=?, transportstageid=?, transportfeesheadid=?, allocatedamount=?, createdby=?, dateofcreation=?, transportstageamountallocationstatus=? where transportstageamountallocationid=?";
			
			transportfeestype = Connection.prepareStatement(query);
			transportfeestype.setString(1,amountobj.getTransportcategoryid());
			transportfeestype.setString(2,amountobj.getTransportstageid());
			transportfeestype.setString(3,amountobj.getTransportfeesheadid());
			transportfeestype.setString(4,amountobj.getAllocatedamount());
			transportfeestype.setString(5,amountobj.getCreatedby());
			transportfeestype.setString(6, currentdate);
			transportfeestype.setString(7,amountobj.getTransportstageamountallocationstatus());
			transportfeestype.setString(8, transportstageamountallocationid);
			//System.out.println("transportstageprepared>>>>>>>>>>>"+transportfeestype);

			result += transportfeestype.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);

		
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
		 
			 if(transportfeestype != null)
				 transportfeestype.close();
			 
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
