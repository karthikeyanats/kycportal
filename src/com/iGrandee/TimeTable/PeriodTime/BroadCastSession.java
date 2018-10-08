package com.iGrandee.TimeTable.PeriodTime;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;


public class BroadCastSession {

	static Logger log = Logger.getLogger(BroadCastSession.class);

 public BroadCastSession() {
	 

     common_data_object 	= new CommonDataAccess();
     insert_query 			= null;
     select_query 			= null;
     return_value 			= 0;
     connection				= null;
 }
  
	 /*
	  * This method is accessed from kycportal/jsp/TImeTable/PeriodTime.jsp
	 */
	public ArrayList getPeriodName(String instituteid)
	{
	 	log.info("invoking getPeriodName(String instituteid) from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select periodnameid,periodname from periodnames where periodnameid not in (select periodnameid from timetableperoid_tb where instituteid='"+instituteid+"' and status='A') and periodnamestatus='A' order by periodnameid asc"; 
			System.out.println(select_query);
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
	}
	
	
	 /*
	  * This method is accessed from kycportal/jsp/TImeTable/PeriodTime.jsp
	 */
	public ArrayList getPeriodName(String instituteid,String userid)
	{
	 	log.info("invoking getPeriodName(String instituteid,String userid) from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");
		ArrayList periodsList = null;
		try
		{
			select_query  	= "select periodnameid,periodname from periodnames where periodnameid not in (select periodnameid from timetableperoid_tb where instituteid='"+instituteid+"' and status='A') and periodnamestatus='A' and createdby='"+userid+"' order by ordervalue,periodnameid asc"; 
			periodsList 	= common_data_object.getListMap(select_query);
		}
		catch(Exception exception) { 
			
			log.error(exception);
		}
		return periodsList;
	}	
 
 
 
	 /*
	   * This method is accessed from kycportal/jsp/TImeTable/PeriodTime.jsp
	  */
	 public ArrayList getDateSchedulePeriods(String instituteid)
	 {
		 	log.info("invoking getDateSchedulePeriods from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");
	
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select a.periodid,b.periodname,a.periodtime from timetableperoid_tb a,periodnames b where a.instituteid='"+instituteid+"' and a.periodnameid=b.periodnameid and b.periodnamestatus='A' and a.status='A' order by b.periodnameid asc"; 
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				
				log.error(exception);
			}
			return periodsList;
	 }
 
	 /*
	  * This method is accessed from kycportal/jsp/TImeTable/PeriodTime.jsp
	 */
	public ArrayList getDateSchedulePeriods(String instituteid,String userid)
	{
		 	log.info("invoking getDateSchedulePeriods(String instituteid,String userid) from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");
	
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select a.periodid,b.periodname,a.periodtime from timetableperoid_tb a,periodnames b where a.instituteid='"+instituteid+"' and a.periodnameid=b.periodnameid and b.periodnamestatus='A' and a.status='A' and createdby='"+userid+"' order by ordervalue,b.periodnameid asc"; 
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				
			log.error(exception);
		}
		return periodsList;
	}
	
	/**
	 * This method is used for inserting the period time details through java bean. It is accessed from 
	 * /jsp/TimeTable/period_settings_submit.jsp
	 * @param bean
	 * @return 0 for failuire , greater than zero for success.
	 * @throws SQLException
	 */
	
 	public int insertPeriods(PeriodBean bean)throws SQLException {
 		
	 	log.info("invoking insertPeriods from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");
	 	
	 	
	 	String period_time		= bean.getPeriodtime();
	 	String periodname		= bean.getPeriodnameid(); 
	 	String instituteid		= bean.getInstituteid();
 		
 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement periodstate 	= null;
		try {
			
			long brodcastid  	= IdGenerator.getUniqueBroadCastId();
			periodstate 		= connection.prepareStatement("insert into timetableperoid_tb(periodid, periodtime, periodnameid, instituteid,status) values(?,?,?,?,?)");
			periodstate.setLong(1, brodcastid);
			periodstate.setString(4,instituteid);
			periodstate.setString(3,periodname);
			periodstate.setString(2,period_time);
			periodstate.setString(5,"A");

			return_value 	+=periodstate.executeUpdate();
			connection.commit();

		}
		catch(SQLException sqlexception) { 
			
			log.error(sqlexception);
			if(connection != null)
				connection.rollback();
			return_value = 0;
		}
		finally {
			
			if(periodstate != null)
				periodstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		
		return return_value;
	}

	
	
	
	
 
 /*
  * This method is accessed from kycportal/jsp/TimeTable/period_settings_submit.jsp
 */
  	
 	public int insertPeriods(String period_time, String periodname, String instituteid)throws SQLException {
 		
	 	log.info("invoking insertPeriods from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");
 		
 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement periodstate 	= null;
		try {
			
			long brodcastid  	= IdGenerator.getUniqueBroadCastId();
			periodstate 		= connection.prepareStatement("insert into timetableperoid_tb(periodid, periodtime, periodnameid, instituteid,status) values(?,?,?,?,?)");
			periodstate.setLong(1, brodcastid);
			periodstate.setString(4,instituteid);
			periodstate.setString(3,periodname);
			periodstate.setString(2,period_time);
			periodstate.setString(5,"A");

			return_value 	+=periodstate.executeUpdate();
			connection.commit();

		}
		catch(SQLException sqlexception) { 
			
			log.error(sqlexception);
			if(connection != null)
				connection.rollback();
			return_value = 0;
		}
		finally {
			
			if(periodstate != null)
				periodstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		
		return return_value;
	}
 	
 	
 	/**
 	 * This method is used for updating the period time through java bean.This method is accessed from 
 	 * /jsp/TimeTable/period_settings_submit.jsp
 	 * @param bean
	 * @return 0 for failure , greater than zero for success.
 	 * @throws SQLException
 	 */
 	
 	public int updatePeriods(PeriodBean bean)throws SQLException {
 		
	 	log.info("invoking updatePeriods from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");
	 	
	 	
	 	String[] periodsId		= bean.getPeriodids();
	 	String[] periodname		= bean.getPeriodtimes();

 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement updatestate 	= null;
 		try {
 			
 			updatestate = connection.prepareStatement("update timetableperoid_tb  set periodtime=? where periodid=?");
 			if(periodsId != null && periodsId.length>0)
 				for(int t=0;t<periodsId.length;t++){
 					updatestate.setString(1,periodname[t]);
 		 			updatestate.setString(2, periodsId[t]);
 		 			updatestate.addBatch();
 				}
 			
 			returnvalue = updatestate.executeBatch();
 			if(returnvalue != null && returnvalue.length>0)
 				for(int i=0;i<returnvalue.length;i++)
 						return_value += returnvalue[i];
 			connection.commit();
		}
		catch(SQLException sqlexception) { 
			
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			log.error(sqlexception);
		}
		finally {
			
			if(updatestate != null)
				updatestate.close();
						
			ConnectionManager.closeConnection(connection);
		}
		return return_value;
	}
 	
 	
 	
 	 
	/*
  * This method is accessed from kycportal/jsp/TimeTable/period_settings_submit.jsp
	*/	
 	public int updatePeriods(String[] periodsId,String[] periodname)throws SQLException {
 		
	 	log.info("invoking updatePeriods from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");

 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement updatestate 	= null;
 		try {
 			
 			updatestate = connection.prepareStatement("update timetableperoid_tb  set periodtime=? where periodid=?");
 			if(periodsId != null && periodsId.length>0)
 				for(int t=0;t<periodsId.length;t++){
 					updatestate.setString(1,periodname[t]);
 		 			updatestate.setString(2, periodsId[t]);
 		 			updatestate.addBatch();
 				}
 			
 			returnvalue = updatestate.executeBatch();
 			if(returnvalue != null && returnvalue.length>0)
 				for(int i=0;i<returnvalue.length;i++)
 						return_value += returnvalue[i];
 			connection.commit();
		}
		catch(SQLException sqlexception) { 
			
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			log.error(sqlexception);
		}
		finally {
			
			if(updatestate != null)
				updatestate.close();
						
			ConnectionManager.closeConnection(connection);
		}
		return return_value;
	}
 	 /*
  * This method is accessed from kycportal/jsp/TimeTable/period_settings_submit.jsp
 	 */
 	public int deletePeriods(String[] periodid)throws SQLException
	{
	 	log.info("invoking deletePeriods from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");

 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement deletestate 	= null;
 		try {
 			
 			deletestate = connection.prepareStatement("update timetableperoid_tb  set status=? where periodid=?");
 			if(periodid != null && periodid.length>0)
 				for(int t=0;t<periodid.length;t++){
 					deletestate.setString(1,"D");
 					deletestate.setString(2,periodid[t]);
 					deletestate.addBatch();
 				}
 			returnvalue	= deletestate.executeBatch();
 			if(returnvalue != null && returnvalue.length>0)
 				for(int i=0;i<returnvalue.length;i++)
 						return_value += returnvalue[i];
 			connection.commit();
		}
		catch(SQLException sqlexception) { 
			
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			log.error(sqlexception);
			
		}
		finally {
			
			if(deletestate != null)
				deletestate.close();
						
			ConnectionManager.closeConnection(connection);
		}
		return return_value;
	}
 	
 	/**
 	 * This method is used for deleting the period details through java bean. It is accessed from
 	 * jsp/TimeTable/period_settings_submit.jsp
 	 * @param bean
 	 * @return
 	 * @throws SQLException
 	 */
 	
 	public int deletePeriods(PeriodBean bean)throws SQLException
	{
	 	log.info("invoking deletePeriods from com.iGrandee.TimeTable.PeriodTime.BroadCastSession");

	 	String[] periodid	= bean.getPeriodids();
 		connection 						= ConnectionManager.getKycConnection();
 		connection.setAutoCommit(false);
 		PreparedStatement deletestate 	= null;
 		try {
 			
 			deletestate = connection.prepareStatement("update timetableperoid_tb  set status=? where periodid=?");
 			if(periodid != null && periodid.length>0)
 				for(int t=0;t<periodid.length;t++){
 					deletestate.setString(1,"D");
 					deletestate.setString(2,periodid[t]);
 					deletestate.addBatch();
 				}
 			returnvalue	= deletestate.executeBatch();
 			if(returnvalue != null && returnvalue.length>0)
 				for(int i=0;i<returnvalue.length;i++)
 						return_value += returnvalue[i];
 			connection.commit();
		}
		catch(SQLException sqlexception) { 
			
			if(connection != null)
				connection.rollback();
			return_value = 0;
			
			log.error(sqlexception);
			
		}
		finally {
			
			if(deletestate != null)
				deletestate.close();
						
			ConnectionManager.closeConnection(connection);
		}
		return return_value;
	}
 	

 
 CommonDataAccess common_data_object;
 String insert_query;
 String select_query;
 int 	return_value;
 int[] returnvalue;
 Connection connection;

}