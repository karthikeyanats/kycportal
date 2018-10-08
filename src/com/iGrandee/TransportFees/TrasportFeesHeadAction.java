/**
 * 
 */
package com.iGrandee.TransportFees;

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

/**
 * @author sindhuja_v
 *
 */
public class TrasportFeesHeadAction {
	
	static Logger log = Logger.getLogger(FeesHeadQuery.class);
	
	public TrasportFeesHeadAction()
	{
		 common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 Connection      = null;
		 rollbackvalue = 0;
		 select_query= "";
	}
	
public int inserttranspotfeeshead(TrasportFeesHead feesheadobj, String transportfeesheadstatus) throws Exception{
		
		int result=0;
		PreparedStatement feesheadprepared = null;
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null;

		try {
			Connection= ConnectionManager.getKycConnection(); 
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
				
			
			String query="select max(transportfeesheadid) from transportfeeshead";
			long transportfeesheadid = common_data_object.maxId(query);
			transportfeesheadid++;
			
			checkprepared			= Connection.prepareStatement("select transportfeesheadid from transportfeeshead where transportfeesheadname=? and transportfeesheadstatus<>? and instituteid=? ");
			checkprepared.setString(1, feesheadobj.getTransportfeesheadname());
			checkprepared.setString(2, "X");
			checkprepared.setString(3, feesheadobj.getInstituteid());
				
			checkrs				= checkprepared.executeQuery();
			//System.out.println("checkprepared>>>in stage"+checkprepared);
			//System.out.println("checkrs>>>in stage"+checkrs);
			if(!checkrs.next()){ 
				//System.out.println("in if"+checkrs);

			query="insert into transportfeeshead (transportfeesheadid, transportfeesheadname, instituteid, dateofcreation,transportfeesheadstatus) values (?, ?, ?, ?,?)";
			feesheadprepared = Connection.prepareStatement(query);
			log.info(query);
			
			feesheadprepared.setLong(1, transportfeesheadid);
			feesheadprepared.setString(2, feesheadobj.getTransportfeesheadname());
			feesheadprepared.setString(3, feesheadobj.getInstituteid());
			feesheadprepared.setString(4, currentdate);
			feesheadprepared.setString(5, transportfeesheadstatus);

			result += feesheadprepared.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);
			}
			else{
				System.out.println("in else"+checkrs);
				result	= 1000;
			}
		
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
		 
			 if(feesheadprepared != null)
				 feesheadprepared.close();
			 
			 if(checkrs != null)
				 checkrs.close();
			 
			 if(checkprepared != null)
				 checkprepared.close();
			 
			 
			 
			 if(Connection != null)
				 Connection.close();
			 }
		
		return result;
	}
	
	
	/*public int inserttranspotfeesheaaad(TrasportFeesHead feesheadobj, String transportfeesheadstatus) throws Exception{
		
		int result=0;
		PreparedStatement feesheadprepared 	= null;
		String  feesname=null;
		feesname= feesheadobj.getTransportfeesheadname();
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null; 

		try {
			Connection= ConnectionManager.getKycConnection();
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");

			checkprepared			= Connection.prepareStatement("select transportfeesheadid from transportfeeshead where transportfeesheadname=? and transportfeesheadstatus=? and instituteid=?");
			
			
			checkprepared.setString(1, feesheadobj.getTransportfeesheadname().trim()); 
			checkprepared.setString(2,transportfeesheadstatus);
			checkprepared.setString(3,feesheadobj.getInstituteid());
			checkrs				= checkprepared.executeQuery();
			System.out.println("checkprepared query>"+checkprepared);
			
			if(!checkrs.next()){
				System.out.println("checkrs>>>if>"+checkrs);
			String query="select max(transportfeesheadid) from transportfeeshead";
			long transportfeesheadid = common_data_object.maxId(query);
			transportfeesheadid++;

			query="insert into transportfeeshead (transportfeesheadid, transportfeesheadname, instituteid, dateofcreation,transportfeesheadstatus) values (?, ?, ?, ?,?)";
			feesheadprepared = Connection.prepareStatement(query);
			log.info(query);
			
			feesheadprepared.setLong(1, transportfeesheadid);
			feesheadprepared.setString(2, feesheadobj.getTransportfeesheadname());
			feesheadprepared.setString(3, feesheadobj.getInstituteid());
			feesheadprepared.setString(4, currentdate);
			feesheadprepared.setString(5, transportfeesheadstatus);
			//result += feesheadprepared.executeUpdate();
				}
			else{
				System.out.println("checkrs>>>else>"+checkrs);

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
		 
			 if(feesheadprepared != null)
				 feesheadprepared.close();
			 
			 if(Connection != null)
				 Connection.close();
			 }
		
		return result;
	}*/
	
	
public int updatetranspotfeeshead(String transportfeesheadid,String transportfeesheadname,String instituteid) throws Exception{
		
		int result=0;
		PreparedStatement feesheadprepared 	= null;
		
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null;


		try {
			Connection= ConnectionManager.getKycConnection();
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");

			checkprepared			= Connection.prepareStatement("select transportfeesheadid from transportfeeshead where transportfeesheadname=? and instituteid=?");
			
			
			checkprepared.setString(1, transportfeesheadname.trim());
			checkprepared.setString(2, instituteid);
			
			checkrs				= checkprepared.executeQuery();
			
			if(!checkrs.next()){	
			

			String query="update transportfeeshead set  transportfeesheadname=?, instituteid=?, dateofcreation=? where transportfeesheadid=?";
			feesheadprepared = Connection.prepareStatement(query);
			log.info(query);		

			feesheadprepared.setString(1, transportfeesheadname);
			feesheadprepared.setString(2, instituteid);
			feesheadprepared.setString(3, currentdate);
			feesheadprepared.setString(4, transportfeesheadid);
			result += feesheadprepared.executeUpdate();
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
		 
			 if(feesheadprepared != null)
				 feesheadprepared.close();
			 
			 if(checkrs != null)
					checkrs.close();
			 
			 if(checkprepared != null)
				 checkprepared.close();
			
				
			 
			 if(Connection != null)
				 Connection.close();
			 }
		
		return result;
	}
	
	
	
	// Viewing All Stages Fess Head
	
		public ArrayList getstagefeeshead(String instituteid){
			ArrayList transportmonth = null;
			
			try{
				String select_query = "select transportfeesheadid,transportfeesheadname from transportfeeshead where transportfeesheadstatus='A' and instituteid='"+instituteid+"'";
				transportmonth = common_data_object.getListMap(select_query);			
			}
			
			catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			
			return transportmonth;
		}
		
		
		// Viewing All Stages in Amount Collection
		
			public ArrayList getstageamountcollection(String transportcategoryid){
				ArrayList transportmonth = null;
				
				try{
					String select_query = "select a.transportfeessettingsid,b.transportstagename,c.transportstageamountid,c.transportfeesheadid,c.stageamount from transportstage b,transportfeessettings a left outer join transportstageamount c on a.transportfeessettingsid=c.transportfeessettingsid where  transportcategoryid='"+transportcategoryid+"' and a.transportstageid=b.transportstageid and b.transportstagestatus='A' and a.transportfeessettingstatus='A' group by b.transportstageid";
					transportmonth = common_data_object.getListMap(select_query);			
				}
				
				catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
				}
				
				return transportmonth;
			}
	
	
	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection Connection;
	 int rollbackvalue;

}
