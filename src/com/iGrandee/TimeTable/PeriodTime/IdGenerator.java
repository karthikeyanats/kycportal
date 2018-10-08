package com.iGrandee.TimeTable.PeriodTime;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

import com.iGrandee.Common.ConnectionManager;

public class IdGenerator {
	
	static Logger log = Logger.getLogger(IdGenerator.class);

	public IdGenerator() {
		
	}
	
	public static synchronized long getUniqueBroadCastId()throws SQLException {
		
	 	log.info("invoking getUniqueBroadCastId from com.iGrandee.TimeTable.PeriodTime.IdGenerator");

		Connection connection		= null;
		PreparedStatement pstate	= null;
		ResultSet resultset			= null;
		
		try {
			
			if(BroadCastId == 0) {
				
				connection 	= ConnectionManager.getKycConnection();
				pstate		= connection.prepareStatement("select max(periodid) from timetableperoid_tb");
				resultset	= pstate.executeQuery();
				if(resultset.next())
					BroadCastId = resultset.getLong(1);
			}
			BroadCastId++;
		}
		catch(SQLException sqlexception){
			
			log.error(sqlexception);
		}
		finally {
			
			if(resultset != null)
				resultset.close();
			
			if(pstate != null)
				pstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		return BroadCastId;
	}
	
	public static synchronized long getWorkAllotmentId()throws SQLException {
		
	 	log.info("invoking getWorkAllotmentId from com.iGrandee.TimeTable.PeriodTime.IdGenerator");

		Connection connection		= null;
		PreparedStatement pstate	= null;
		ResultSet resultset			= null;

		try {
			
			if(WorkId == 0) {
				
				connection 	= ConnectionManager.getKycConnection();
				pstate		= connection.prepareStatement("select max(workallotmentid) from workallotment");
				resultset	= pstate.executeQuery();
				if(resultset.next())
					WorkId = resultset.getLong(1);
			}
			WorkId++;
		}
		catch(SQLException sqlexception){
			
			log.error(sqlexception);
		}
		finally {
			
			if(resultset != null)
				resultset.close();
			
			if(pstate != null)
				pstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		return WorkId;
	}	
	
	public static synchronized long getSubjectAllotmentId()throws SQLException {

	 	log.info("invoking getSubjectAllotmentId from com.iGrandee.TimeTable.PeriodTime.IdGenerator");

		Connection connection		= null;
		PreparedStatement pstate	= null;
		ResultSet resultset			= null;

		try {
			
			if(SubjectId == 0) {
				
				connection 	= ConnectionManager.getKycConnection();
				pstate		= connection.prepareStatement("select max(subjectallotmentid) from subjectallotment");
				resultset	= pstate.executeQuery();
				if(resultset.next())
					SubjectId = resultset.getLong(1);
			}
			SubjectId++;
		}
		catch(SQLException sqlexception){
			
			log.error(sqlexception);
		}
		finally {
			
			if(resultset != null)
				resultset.close();
			
			if(pstate != null)
				pstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		return SubjectId;
	}	
	
	
	public static synchronized long getTimeTableId()throws SQLException {
		
	 	log.info("invoking getTimeTableId from com.iGrandee.TimeTable.PeriodTime.IdGenerator");
		
		Connection connection		= null;
		PreparedStatement pstate	= null;
		ResultSet resultset			= null;

		try {
			
			if(TimeTableId == 0) {
				
				connection 	= ConnectionManager.getKycConnection();
				pstate		= connection.prepareStatement("select max(timetableid) from timetable");
				resultset	= pstate.executeQuery();
				if(resultset.next())
					TimeTableId = resultset.getLong(1);
			}
			TimeTableId++;
		}
		catch(SQLException sqlexception){
			
			log.error(sqlexception);
		}
		finally {
			
			if(resultset != null)
				resultset.close();
			
			if(pstate != null)
				pstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		return TimeTableId;
	}	
	
	
	public static synchronized long getTimeTableLogId()throws SQLException {
		
	 	log.info("invoking getTimeTableLogId from com.iGrandee.TimeTable.PeriodTime.IdGenerator");
		
		Connection connection		= null;
		PreparedStatement pstate	= null;
		ResultSet resultset			= null;

		try {
			
			if(TimeTableLogId == 0) {
				
				connection 	= ConnectionManager.getKycConnection();
				pstate		= connection.prepareStatement("select max(timetablelogid) from timetablelog");
				resultset	= pstate.executeQuery();
				if(resultset.next())
					TimeTableLogId = resultset.getLong(1);
			}
			TimeTableLogId++;
		}
		catch(SQLException sqlexception){
			
			log.error(sqlexception);
		}
		finally {
			
			if(resultset != null)
				resultset.close();
			
			if(pstate != null)
				pstate.close();
			
			ConnectionManager.closeConnection(connection);
		}
		return TimeTableLogId;
	}	
	

	static long BroadCastId 	= 0l;
	static long WorkId 			= 0l;
	static long SubjectId 		= 0l;
	static long TimeTableId 	= 0l;
	static long TimeTableLogId 	= 0l;

}

