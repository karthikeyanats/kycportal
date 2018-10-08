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
public class StageAmountAction {

static Logger log = Logger.getLogger(FeesHeadQuery.class);
	
	public StageAmountAction()
	{
		 common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 Connection      = null;
		 rollbackvalue = 0;
		 select_query= "";
	}
	
	public int inserttranspotfeeshead(StageAmount amountobj) throws Exception{
		
		int result=0;
		PreparedStatement amountprepared 	= null;
		String  amountname=null;
		amountname= amountobj.getStageamount();
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null;


		try {
			Connection= ConnectionManager.getKycConnection();
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");

			checkprepared			= Connection.prepareStatement("select transportstageamountid from transportstageamount where transportfeessettingsid=? and transportfeesheadid=?");
			
			
			checkprepared.setString(1, amountobj.getStageamount());
			checkprepared.setString(2,amountobj.getTransportfeessettingsid());
			checkprepared.setString(3,amountobj.getTransportfeesheadid());
			
			checkrs				= checkprepared.executeQuery();
			
			if(!checkrs.next()){
	
			String query="select max(transportstageamountid) from transportstageamount";
			long transportstageamountid = common_data_object.maxId(query);
			transportstageamountid++;

			query="insert into transportstageamount (transportstageamountid, transportfeessettingsid, transportfeesheadid, stageamount, createdby, dateofcreation, transportstageamountstatus) values (?, ?, ?, ?, ?, ?, ?)";
			amountprepared = Connection.prepareStatement(query);
			log.info(query);
			
			amountprepared.setLong(1, transportstageamountid);
			amountprepared.setString(2, amountobj.getTransportfeessettingsid());
			amountprepared.setString(3, amountobj.getTransportfeesheadid());
			amountprepared.setString(4, amountobj.getStageamount());
			amountprepared.setString(5, amountobj.getCreatedby());
			amountprepared.setString(6, currentdate);
			amountprepared.setString(7, amountobj.getTransportstageamountstatus());
			result += amountprepared.executeUpdate();
				}
			else{
				result	= 1000;
			}
			
			
			
			if(checkrs != null)
				checkrs.close();
			
			
			Connection.commit();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(Connection!=null){
				
				Connection.rollback();
			}
		}
		 finally
			{
		 
			 if(amountprepared != null)
				 amountprepared.close();
			 
			 if(checkrs != null)
					checkrs.close();
			 
			 if(checkprepared != null)
				 checkprepared.close();			 
			 
			 
			 if(Connection != null)
				 Connection.close();
			 }
		
		return result;
	}
	
	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection Connection;
	 int rollbackvalue;
	
	
}
