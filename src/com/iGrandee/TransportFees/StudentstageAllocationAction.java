/**
 * 
 */
package com.iGrandee.TransportFees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

/**
 * @author sindhuja_v
 *
 */
public class StudentstageAllocationAction {

	public StudentstageAllocationAction()
	{
		 common_data_object = new CommonDataAccess();
		 ConnectionManager  = new ConnectionManager();
		 Connection      = null;
		 rollbackvalue = 0;
		 select_query= "";
	}
	
	public int insertStudentstage(StudentstageAllocation stuobj) throws Exception{
		
		int result=0;
		PreparedStatement stuprepared = null;
		PreparedStatement stulogprepared = null;
	//	ResultSet checkrs 					= null;
		//PreparedStatement checkprepared 	= null;

		try {
			Connection= ConnectionManager.getKycConnection(); 
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
				
			//long max_personid = common_data_object.fmaxId("select max(personid) from personmaster");

			String query="select max(studentstageallocationid) from studentstageallocation";
			//long studentstageallocationid = common_data_object.maxId("select max(studentstageallocationid) from studentstageallocation");
			//System.out.println("studentstageallocationid===>>"+query);
			long studentstageallocationid = common_data_object.maxId(query);
			studentstageallocationid++;

			query = "insert into  studentstageallocation (studentstageallocationid, studentapprovalid, transportstageid, dateofcreation, studentstageallocationstatus) values (?, ?, ?, ?, ?)";
			
			stuprepared = Connection.prepareStatement(query);
			stuprepared.setLong(1, studentstageallocationid);
			stuprepared.setString(2,stuobj.getStudentapprovalid());
			stuprepared.setString(3,stuobj.getTransportstageid());
			stuprepared.setString(4, currentdate);
			stuprepared.setString(5,stuobj.getStudentstageallocationstatus());
			//System.out.println("transportstageprepared>>>>>>>>>>>"+stuprepared);

			result += stuprepared.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);
			
			
			String querys="select max(studentstageallocationlogid) from studentstageallocationlog";
			long studentstageallocationlogid = common_data_object.maxId(querys);
			studentstageallocationlogid++;

			querys="insert into  studentstageallocationlog (studentstageallocationlogid, studentstageallocationid, studentstageallocationaction, dateofcreation, studentstageallocationlogstatus) values (?, ?, ?, ?, ?)";
			
			stulogprepared = Connection.prepareStatement(querys);
			stulogprepared.setLong(1, studentstageallocationlogid);
			stulogprepared.setLong(2, studentstageallocationid);
			stulogprepared.setString(3,stuobj.getStudentstageallocationaction());
			stulogprepared.setString(4, currentdate);
			stulogprepared.setString(5,stuobj.getStudentstageallocationlogstatus());
			//System.out.println("transportstageprepared>>>>>>>>>>>"+stulogprepared);

			result += stulogprepared.executeUpdate();
				
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
			 if(stulogprepared != null)
				 stulogprepared.close();
			 
			 if(stuprepared != null)
				 stuprepared.close();
			 
			
			 
			 if(Connection != null)
				 Connection.close();
			 }
		
		return result;
	}
	
	
	
public int UpdateStudentstage(StudentstageAllocation stuobj,String stuid) throws Exception{
		
		int result=0;
		PreparedStatement stuprepared = null;
		PreparedStatement stulogprepared = null;
		String query= null;
		String querys= null;
	//	ResultSet checkrs 					= null;
		//PreparedStatement checkprepared 	= null;

		try {
			Connection= ConnectionManager.getKycConnection(); 
			Connection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");
			
		/*	String query="select max(studentstageallocationid) from studentstageallocation";
			//long studentstageallocationid = common_data_object.maxId("select max(studentstageallocationid) from studentstageallocation");
			System.out.println("studentstageallocationid===>>"+query);
			long studentstageallocationid = common_data_object.maxId(query);*/
			
			query = "update studentstageallocation set studentapprovalid=?, transportstageid=?, dateofcreation=?, studentstageallocationstatus=? where studentstageallocationid=?";
			
			stuprepared = Connection.prepareStatement(query);
			stuprepared.setString(1,stuobj.getStudentapprovalid());
			stuprepared.setString(2,stuobj.getTransportstageid());
			stuprepared.setString(3, currentdate);
			stuprepared.setString(4,"C"); 
			stuprepared.setString(5, stuid);
			//System.out.println("transportstageprepared>>>>>>>>>>>"+stuprepared);

			result += stuprepared.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);			
			
			/*String querys="select max(studentstageallocationlogid) from studentstageallocationlog";
			long studentstageallocationlogid = common_data_object.maxId(querys);*/
			
			querys="update studentstageallocationlog set studentstageallocationid=?, studentstageallocationaction=?, dateofcreation=?, studentstageallocationlogstatus=? where studentstageallocationlogid=?";
			
			stulogprepared = Connection.prepareStatement(querys);
			stulogprepared.setString(1, stuid);
			stulogprepared.setString(2,"Closed");
			stulogprepared.setString(3, currentdate);
			stulogprepared.setString(4,stuobj.getStudentstageallocationlogstatus());
			stulogprepared.setString(5, stuobj.getStudentstageallocationlogid());

			//System.out.println("transportstageprepared>>>>>>>>>>>"+stulogprepared);

			result += stulogprepared.executeUpdate();
				
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
		 
			 if(stulogprepared != null)
				 stulogprepared.close();
			 if(stuprepared != null)
				 stuprepared.close();
			 
		
			 
			 if(Connection != null)
				 Connection.close();
			 }
		
		return result;
	}
	



public String getstudentallocationstatus(String studentstageallocationid){
	
	 String return_value=null;
	try{
		select_query="select studentstageallocationstatus from studentstageallocation where studentstageallocationid='"+studentstageallocationid+"'";
		//System.out.println("select_query..amt"+select_query);
		return_value=common_data_object.getString(select_query);
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return return_value;
}



public int UpdateinsertStudentstage(StudentstageAllocation stuobj, String oldstageid,String studentstageallocationids, String studentstageallocationlogids) throws Exception{
	
	int result=0;
	PreparedStatement stuprepared = null;
	PreparedStatement stuprepared1 = null;
	PreparedStatement stulogprepared = null;
	PreparedStatement stulogprepared1 = null;
	//ResultSet checkrs 					= null;
	//PreparedStatement checkprepared 	= null;

	try {
		Connection= ConnectionManager.getKycConnection(); 
		Connection.setAutoCommit(false);
		String currentdate			= DateTime.showTime("MySqlWithTime");
		
		
		String query = "update studentstageallocation set studentapprovalid=?, transportstageid=?, dateofcreation=?, studentstageallocationstatus=? where studentstageallocationid=?";
		
	//	System.out.println("studentstageallocationid>>>>>>>>>>>"+stuobj.getStudentstageallocationid());
		stuprepared = Connection.prepareStatement(query);
		stuprepared.setString(1,stuobj.getStudentapprovalid());
		stuprepared.setString(2, oldstageid);
		stuprepared.setString(3, currentdate);
		stuprepared.setString(4, "D"); 
		stuprepared.setString(5, studentstageallocationids);
		//System.out.println("transportstageprepared>>>>>>>>>>>"+stuprepared);

		result += stuprepared.executeUpdate();
			
	//	System.out.println("result>>>>>>>>>>>"+result);			
		
		
		
		String querys="update studentstageallocationlog set studentstageallocationid=?, studentstageallocationaction=?, dateofcreation=?, studentstageallocationlogstatus=? where studentstageallocationlogid=?";
		//System.out.println("studentstageallocationlogid>>>>>>>>>>>"+stuobj.getStudentstageallocationlogid());
		stulogprepared = Connection.prepareStatement(querys);
		stulogprepared.setString(1, studentstageallocationids);
		stulogprepared.setString(2, "Changed");
		stulogprepared.setString(3, currentdate);
		stulogprepared.setString(4, "D");
		stulogprepared.setString(5, studentstageallocationlogids);

		//System.out.println("transportstageprepared>>>>>>>>>>>"+stulogprepared);

		result += stulogprepared.executeUpdate();
			
	//	System.out.println("result>>>>>>>>>>>"+result);
		
		
		String query1="select max(studentstageallocationid) from studentstageallocation";
		//long studentstageallocationid = common_data_object.maxId("select max(studentstageallocationid) from studentstageallocation");
		//System.out.println("studentstageallocationid===>>"+query1);
		long studentstageallocationid = common_data_object.maxId(query1);
		studentstageallocationid++;

		query1 = "insert into  studentstageallocation (studentstageallocationid, studentapprovalid, transportstageid, dateofcreation, studentstageallocationstatus) values (?, ?, ?, ?, ?)";
		
		stuprepared1 = Connection.prepareStatement(query1);
		stuprepared1.setLong(1, studentstageallocationid);
		stuprepared1.setString(2,stuobj.getStudentapprovalid());
		stuprepared1.setString(3,stuobj.getTransportstageid());
		stuprepared1.setString(4, currentdate);
		stuprepared1.setString(5,"A");
	//	System.out.println("transportstageprepared>>>>>>>>>>>"+stuprepared1);

		result += stuprepared1.executeUpdate();
			
		//System.out.println("result>>>>>>>>>>>"+result);
		
		
		String querys1="select max(studentstageallocationlogid) from studentstageallocationlog";
		long studentstageallocationlogid = common_data_object.maxId(querys1);
		studentstageallocationlogid++;

		querys1 ="insert into  studentstageallocationlog (studentstageallocationlogid, studentstageallocationid, studentstageallocationaction, dateofcreation, studentstageallocationlogstatus) values (?, ?, ?, ?, ?)";
		
		stulogprepared1 = Connection.prepareStatement(querys1);
		stulogprepared1.setLong(1, studentstageallocationlogid);
		stulogprepared1.setLong(2, studentstageallocationid);
		stulogprepared1.setString(3,"Created");
		stulogprepared1.setString(4, currentdate);
		stulogprepared1.setString(5,"A");
		//System.out.println("transportstageprepared>>>>>>>>>>>"+stulogprepared1);

		result += stulogprepared1.executeUpdate();
			
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
		 
		 if(stulogprepared1 != null)
			 stulogprepared1.close();
		 if(stuprepared1 != null)
			 stuprepared1.close();
		 if(stulogprepared != null)
			 stulogprepared.close();
		 if(stuprepared != null)
			 stuprepared.close();
		 
		 
		 if(Connection != null)
			 Connection.close();
		 }
	
	return result;
}



public int UpdateinsertStudentstageStatus(StudentstageAllocation stuobj, String oldstageid,String studentstageallocationids, String studentstageallocationlogids) throws Exception{
	
	int result=0;
	PreparedStatement stuprepared = null;
	PreparedStatement stuprepared1 = null;
	PreparedStatement stulogprepared = null;
	PreparedStatement stulogprepared1 = null;
	//ResultSet checkrs 					= null;
	//PreparedStatement checkprepared 	= null;

	try {
		Connection= ConnectionManager.getKycConnection(); 
		Connection.setAutoCommit(false);
		String currentdate			= DateTime.showTime("MySqlWithTime");
		
		
		String query = "update studentstageallocation set studentapprovalid=?, transportstageid=?, dateofcreation=?, studentstageallocationstatus=? where studentstageallocationid=?";
		
	//	System.out.println("studentstageallocationid>>>>>>>>>>>"+stuobj.getStudentstageallocationid());
		stuprepared = Connection.prepareStatement(query);
		stuprepared.setString(1,stuobj.getStudentapprovalid());
		stuprepared.setString(2, oldstageid);
		stuprepared.setString(3, currentdate);
		stuprepared.setString(4, "C"); 
		stuprepared.setString(5, studentstageallocationids);
		//System.out.println("transportstageprepared>>>>>>>>>>>"+stuprepared);

		result += stuprepared.executeUpdate();
			
		//System.out.println("result>>>>>>>>>>>"+result);			
		
		
		
		String querys="update studentstageallocationlog set studentstageallocationid=?, studentstageallocationaction=?, dateofcreation=?, studentstageallocationlogstatus=? where studentstageallocationlogid=?";
		//System.out.println("studentstageallocationlogid>>>>>>>>>>>"+stuobj.getStudentstageallocationlogid());
		stulogprepared = Connection.prepareStatement(querys);
		stulogprepared.setString(1, studentstageallocationids);
		stulogprepared.setString(2, "Closed");
		stulogprepared.setString(3, currentdate);
		stulogprepared.setString(4, "C");
		stulogprepared.setString(5, studentstageallocationlogids);

		//System.out.println("transportstageprepared>>>>>>>>>>>"+stulogprepared);

		result += stulogprepared.executeUpdate();
			
		//System.out.println("result>>>>>>>>>>>"+result);
		
		
		String query1="select max(studentstageallocationid) from studentstageallocation";
		//long studentstageallocationid = common_data_object.maxId("select max(studentstageallocationid) from studentstageallocation");
		//System.out.println("studentstageallocationid===>>"+query1);
		long studentstageallocationid = common_data_object.maxId(query1);
		studentstageallocationid++;

		query1 = "insert into  studentstageallocation (studentstageallocationid, studentapprovalid, transportstageid, dateofcreation, studentstageallocationstatus) values (?, ?, ?, ?, ?)";
		
		stuprepared1 = Connection.prepareStatement(query1);
		stuprepared1.setLong(1, studentstageallocationid);
		stuprepared1.setString(2,stuobj.getStudentapprovalid());
		stuprepared1.setString(3,stuobj.getTransportstageid());
		stuprepared1.setString(4, currentdate);
		stuprepared1.setString(5,"A");
		//System.out.println("transportstageprepared>>>>>>>>>>>"+stuprepared1);

		result += stuprepared1.executeUpdate();
			
		//System.out.println("result>>>>>>>>>>>"+result);
		
		
		String querys1="select max(studentstageallocationlogid) from studentstageallocationlog";
		long studentstageallocationlogid = common_data_object.maxId(querys1);
		studentstageallocationlogid++;

		querys1 ="insert into  studentstageallocationlog (studentstageallocationlogid, studentstageallocationid, studentstageallocationaction, dateofcreation, studentstageallocationlogstatus) values (?, ?, ?, ?, ?)";
		
		stulogprepared1 = Connection.prepareStatement(querys1);
		stulogprepared1.setLong(1, studentstageallocationlogid);
		stulogprepared1.setLong(2, studentstageallocationid);
		stulogprepared1.setString(3,"Created");
		stulogprepared1.setString(4, currentdate);
		stulogprepared1.setString(5,"A");
		//System.out.println("transportstageprepared>>>>>>>>>>>"+stulogprepared1);

		result += stulogprepared1.executeUpdate();
			
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
		 if(stulogprepared1 != null)
			 stulogprepared1.close();
		 
		 if(stuprepared1 != null)
			 stuprepared1.close();
		 
		 if(stulogprepared != null)
			 stulogprepared.close();
		  
		 if(stuprepared != null)
			 stuprepared.close();
		
	
		
		 
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
