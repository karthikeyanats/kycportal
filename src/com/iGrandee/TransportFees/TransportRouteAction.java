/**
 * 
 */
package com.iGrandee.TransportFees;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.apache.log4j.Logger;

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
 * @author selvakumar_v 
 *
 */
public class TransportRouteAction {
	
	static Logger log = Logger.getLogger(FeesHeadQuery.class);
	public TransportRouteAction()
	{
		 common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 transpotrouteconnection      = null;
		 rollbackvalue = 0;
		 select_query= "";
	}
	
	public int inserttranspotroute(TransportRoute routeobj) throws Exception{
		
		int result=0;
		PreparedStatement transpotrouteprepared 	= null;
		String  routename=null;
		routename= routeobj.getRoutename();
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null;


		try {
			transpotrouteconnection= ConnectionManager.getKycConnection();
			transpotrouteconnection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");

			checkprepared			= transpotrouteconnection.prepareStatement("select transportrouteid from transportroute where routename=? and transportroutestatus<>? and instituteid=?");
			
			
			checkprepared.setString(1, routeobj.getRoutename());
			checkprepared.setString(2, "X"); 
			checkprepared.setString(3,routeobj.getInstituteid());
			
			checkrs				= checkprepared.executeQuery();
			
			if(!checkrs.next()){
	
			String query="select max(transportrouteid) from transportroute";
			long routeid = common_data_object.maxId(query);
			routeid++;

			query="insert into transportroute (transportrouteid, routename, routedescription, instituteid, createdby, dateofcreation, transportroutestatus) values (?, ?, ?, ?, ?, ?,?)";
			transpotrouteprepared = transpotrouteconnection.prepareStatement(query);
			log.info(query);
			
			transpotrouteprepared.setLong(1, routeid);
			transpotrouteprepared.setString(2,routeobj.getRoutename());
			transpotrouteprepared.setString(3,routeobj.getRoutedescription());
			transpotrouteprepared.setString(4,routeobj.getInstituteid());
			transpotrouteprepared.setString(5, routeobj.getCreatedby());
			transpotrouteprepared.setString(6,currentdate);
			transpotrouteprepared.setString(7,routeobj.getRoutestatus());
			result += transpotrouteprepared.executeUpdate();
				}
			else{
				result	= 1000;
			}
			
			
			
			if(checkrs != null)
				checkrs.close();
			
			
			transpotrouteconnection.commit();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(transpotrouteconnection!=null){
				
				transpotrouteconnection.rollback();
			}
		}
		 finally
			{
			 if(transpotrouteprepared != null)
				 transpotrouteprepared.close();
			 
			 if(checkrs != null)
					checkrs.close();
			 
			 if(checkprepared!= null)
				 checkprepared.close();
			
			 
			 if(transpotrouteconnection != null)
				 transpotrouteconnection.close();
			 }
		
		return result;
	}
	
	
	
	public int updatetranspotroute(String routeid,String routename,String routedescription,String instituteid ) throws Exception{
		
		
		PreparedStatement updatetranspotrouteprepared 	= null;
		
		PreparedStatement checkrouteprepared = null;
		//System.out.println("routeid>>>>>"+routeid+"routename>>>>>>"+routename+"routedescription>>>>>>"+routedescription+"instituteid>>>>>."+instituteid);
    	int rs=0;
    	
    	ResultSet rs1=null;
		String currentdate			= DateTime.showTime("MySqlWithTime");
		try{
			transpotrouteconnection= ConnectionManager.getKycConnection();

			   String str			= "select routename from transportroute where routename=? and transportrouteid<>? and instituteid=? and transportroutestatus <> ?";
	            checkrouteprepared	= transpotrouteconnection.prepareStatement(str);
	            checkrouteprepared.setString(1, routename);
	            checkrouteprepared.setString(2, routeid); 
	            checkrouteprepared.setString(3,instituteid);
	            checkrouteprepared.setString(4, "X");
	            rs1	= checkrouteprepared.executeQuery();
			
	            if(!rs1.next())
	            {
			select_query="update transportroute set routename=?,routedescription=?,dateofcreation=?  where transportrouteid=?";
			updatetranspotrouteprepared = transpotrouteconnection.prepareStatement(select_query);
			
			updatetranspotrouteprepared.setString(1,routename);
			updatetranspotrouteprepared.setString(2,routedescription);
			updatetranspotrouteprepared.setString(3,currentdate);
			updatetranspotrouteprepared.setString(4,routeid);
			rs += updatetranspotrouteprepared.executeUpdate();
	            }
	            else{
	            	rs	= 1000;
	            }
			
		}
		
		catch (SQLException e) {
			e.printStackTrace();
			rs=0;
			
			if(transpotrouteconnection!=null){
				
				transpotrouteconnection.rollback();
			}
		}
		finally{
			
			
			
			if(updatetranspotrouteprepared!=null){
				updatetranspotrouteprepared.close();
				
			}
			
			if(rs1!=null){
				rs1.close();
				
			}
			if(checkrouteprepared!=null){
				checkrouteprepared.close();
				
			}
			
			
				if(transpotrouteconnection!=null){
				
				transpotrouteconnection.close();
			}
				
				
		}
		
		return rs;
	}
	
public int deactivatetranspotroute(String routeid,String routestatus) throws Exception{
		
		int result	= 0;
		PreparedStatement deactranspotrouteprepared 	= null;
		
	//	String currentdate			= DateTime.showTime("MySqlWithTime");
		try{
			select_query="update transportroute set transportroutestatus=? where routeid=?";
			deactranspotrouteprepared = transpotrouteconnection.prepareStatement(select_query);
			
			deactranspotrouteprepared.setString(1, routestatus);
			
			deactranspotrouteprepared.setString(2,routeid);
			
			result += deactranspotrouteprepared.executeUpdate();

			
		}
		
		catch (SQLException e) {
			e.printStackTrace();
			result=0;
			
			if(transpotrouteconnection!=null){
				
				transpotrouteconnection.rollback();
			}
		}
		finally{
			if(deactranspotrouteprepared!=null){
				deactranspotrouteprepared.close();
				
			}
				if(transpotrouteconnection!=null){
				
				transpotrouteconnection.close();
			}
			
		}
		
		return result;
	}

public int activatetranspotroute(String routeid,String routestatus) throws Exception{
	
	int result	= 0;
	PreparedStatement actranspotrouteprepared 	= null;
	
	String currentdate			= DateTime.showTime("MySqlWithTime");
	try{
		select_query="update transportroute set transportroutestatus=? where routeid=?";
		actranspotrouteprepared = transpotrouteconnection.prepareStatement(select_query);
		
		actranspotrouteprepared.setString(1, routeid);
		
		actranspotrouteprepared.setString(2,routestatus);
		
		result += actranspotrouteprepared.executeUpdate();

		
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(actranspotrouteprepared!=null){
			actranspotrouteprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}

public int changetranspotroute(String routeid,String routestatus) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotrouteprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
	//	String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="update transportroute set transportroutestatus=? where transportrouteid=?";
		trashtranspotrouteprepared = transpotrouteconnection.prepareStatement(select_query);
		
		trashtranspotrouteprepared.setString(1, routestatus);
		 
		trashtranspotrouteprepared.setString(2,routeid);
		
		result += trashtranspotrouteprepared.executeUpdate();

		//System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotrouteprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotrouteprepared!=null){
			trashtranspotrouteprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}


// Restore Fees Head Name
public int restorefeesheadname(String transportfeesheadid,String transportfeesheadstatus) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
		String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="update transportfeeshead set transportfeesheadstatus=? where transportfeesheadid=?";
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);
		
		trashtranspotfeesheadprepared.setString(1, transportfeesheadstatus);
		 
		trashtranspotfeesheadprepared.setString(2,transportfeesheadid);
		
		result += trashtranspotfeesheadprepared.executeUpdate();

	//	System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}
 
public int deletetranspotFeesHeadName(String transportfeesheadid) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();

		select_query="delete from transportfeeshead where transportfeesheadid='"+transportfeesheadid+"'";
		
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);

		result += trashtranspotfeesheadprepared.executeUpdate();

	//	System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}

// Delete Fees Head Name
public int changetranspotFeesHeadName(String transportfeesheadid,String transportfeesheadstatus) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
		String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="update transportfeeshead set transportfeesheadstatus=? where transportfeesheadid=?";
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);
		
		trashtranspotfeesheadprepared.setString(1, transportfeesheadstatus);
		 
		trashtranspotfeesheadprepared.setString(2,transportfeesheadid);
		
		result += trashtranspotfeesheadprepared.executeUpdate();

		//System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}


public int changetranspotFeesHead(String transportfeesheadid,String transportfeesheadstatus) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
		String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="update transportfeeshead set transportfeesheadstatus=? where transportfeesheadid=?";
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);
		
		trashtranspotfeesheadprepared.setString(1, transportfeesheadstatus);
		 
		trashtranspotfeesheadprepared.setString(2,transportfeesheadid);
		
		result += trashtranspotfeesheadprepared.executeUpdate();

		//System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}


public int changeFeesscollectionstatus(String scholarshipamountallocationid) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
		//String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="delete from scholarshipamountallocation where scholarshipamountallocationid='"+scholarshipamountallocationid+"'";
		
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);

		result += trashtranspotfeesheadprepared.executeUpdate();

		//System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}


public int DeletetranspotAmount(String transportstageamountallocationid) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
	//	String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="delete from transportstageamountallocation where transportstageamountallocationid='"+transportstageamountallocationid+"'";
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);
		
		result += trashtranspotfeesheadprepared.executeUpdate();

	//	System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}



public int changetranspotAmountTrashStatus(String transportstageamountallocationid,String transportstageamountallocationstatus) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
		//String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="update transportstageamountallocation set transportstageamountallocationstatus=? where transportstageamountallocationid=?";
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);
		
		trashtranspotfeesheadprepared.setString(1, transportstageamountallocationstatus);
		 
		trashtranspotfeesheadprepared.setString(2,transportstageamountallocationid);
		
		result += trashtranspotfeesheadprepared.executeUpdate();

		//System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}



public int changetranspotAmountDeleteStatus(String transportstageamountallocationid,String transportstageamountallocationstatus) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
	//	String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="update transportstageamountallocation set transportstageamountallocationstatus=? where transportstageamountallocationid=?";
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);
		
		trashtranspotfeesheadprepared.setString(1, transportstageamountallocationstatus);
		 
		trashtranspotfeesheadprepared.setString(2,transportstageamountallocationid);
		
		result += trashtranspotfeesheadprepared.executeUpdate();

		//System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}


public int changetranspotAmountRestoreStatus(String transportstageamountallocationid,String transportstageamountallocationstatus) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotfeesheadprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
		//String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="update transportstageamountallocation set transportstageamountallocationstatus=? where transportstageamountallocationid=?";
		trashtranspotfeesheadprepared = transpotrouteconnection.prepareStatement(select_query);
		
		trashtranspotfeesheadprepared.setString(1, transportstageamountallocationstatus);
		 
		trashtranspotfeesheadprepared.setString(2,transportstageamountallocationid);
		
		result += trashtranspotfeesheadprepared.executeUpdate();

		//System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotfeesheadprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotfeesheadprepared!=null){
			trashtranspotfeesheadprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}



public int delatetranspotroute(String routeid,String routestatus) throws Exception{
	
	int result	= 0;
	PreparedStatement delatetranspotroute 	= null;
	
	//String currentdate			= DateTime.showTime("MySqlWithTime");
	try{
		select_query="update transportroute set transportroutestatus=? where routeid=?";
		delatetranspotroute = transpotrouteconnection.prepareStatement(select_query);
		
		delatetranspotroute.setString(1, routestatus);
		
		delatetranspotroute.setString(2,routeid);
		
		result += delatetranspotroute.executeUpdate();

		
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(delatetranspotroute!=null){
			delatetranspotroute.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}


public ArrayList gettranspotroute(String instituteid){
	ArrayList transpotroutelist=null;
	select_query="select transportrouteid, routename, routedescription, instituteid, createdby,  date_format(dateofcreation,'%d-%b-%Y') as newdates, transportroutestatus from  transportroute where transportroutestatus='A' and instituteid='"+instituteid+"' order by transportrouteid desc";
	try{
		transpotroutelist=common_data_object.getListMap(select_query);
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}
	

public ArrayList gettranspotroute(){
	ArrayList transpotroutelist=null;
	select_query="select transportrouteid, routename, routedescription, instituteid, createdby,  date_format(dateofcreation,'%d-%b-%Y') as newdates, transportroutestatus from  transportroute where transportroutestatus='A' order by transportrouteid desc";
	try{
		transpotroutelist=common_data_object.getListMap(select_query);
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}
	

// Fees Head Name

public ArrayList getFeesHeadName(String instituteid){
	ArrayList transpotroutelist=null;
	select_query="select transportfeesheadid,transportfeesheadname,instituteid,dateofcreation from transportfeeshead where instituteid='"+instituteid+"' and  transportfeesheadstatus='A'";
	try{
		transpotroutelist=common_data_object.getListMap(select_query);
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}


public ArrayList getedittranspotroute(String transportrouteid){
	ArrayList transpotroutelist=null;
	select_query="select transportrouteid, routename, routedescription, instituteid, createdby, dateofcreation, transportroutestatus from  transportroute where transportroutestatus='A' and transportrouteid="+transportrouteid+"";
	try{
		transpotroutelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) { 
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}

// Edit Transport Fees Head Name
public ArrayList getedittranspotfeeshead(String transportfeesheadid){
	ArrayList transpotroutelist=null;
	select_query="select transportfeesheadid, transportfeesheadname, instituteid, dateofcreation from  transportfeeshead where transportfeesheadid='"+transportfeesheadid+"'";
	try{
		transpotroutelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) { 
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}
	


public ArrayList getdeactivetranspotroute(){
	ArrayList transpotroutelist=null;
	
	try{
		select_query="select transportrouteid, routename, routedescription, instituteid, createdby, dateofcreation, transportroutestatus from  transportroute where transportroutestatus='D'";
		transpotroutelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}


public ArrayList gettrashtranspotroute(){
	ArrayList transpotroutelist=null;
	
	try{
		select_query="select transportrouteid, routename, routedescription, instituteid, createdby, dateofcreation, transportroutestatus from  transportroute where transportroutestatus='T'";
		transpotroutelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}

// Fees Head Name Trash List
public ArrayList gettrashtranspotFeesHead(String instituteid){
	ArrayList transpotroutelist=null;
	
	try{
		select_query="select transportfeesheadid, transportfeesheadname, instituteid, transportfeesheadstatus from transportfeeshead where  instituteid ='"+instituteid+"' and transportfeesheadstatus='T'";
		transpotroutelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}


public ArrayList getdeletetranspotroute(){
	ArrayList transpotroutelist=null;
	
	try{
		select_query="select transportrouteid, routename, routedescription, instituteid, createdby, dateofcreation, transportroutestatus from  transportroute where transportroutestatus='X'";
		transpotroutelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}


public String  duplicateroute(String routename){
	String duplicateroute=null;
	select_query="select transportrouteid from  transportroute where transportroutestatus='A' and routename="+routename+"";
	try{
		duplicateroute=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return duplicateroute;
}

public String  getRouteid(){
	String routename=null;
	try{
		select_query="select transportrouteid from transportroute where transportroutestatus='A'";

		routename=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return routename;
}

public String  getcount(String transportrouteid){
	String routename=null;
	try{
		select_query="select count(transportrouteid) from transportstage where transportrouteid='"+transportrouteid+"' and transportstagestatus='A'";

		routename=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return routename;
}

// Get Route Wise Student Count

public String  getstudentcount(String transportrouteid){
	String routename=null;
	try{
		select_query="select count(st.studentapprovalid) as studentcount from transportroute tr,transportstage ts,studentstageallocation st where tr.transportrouteid=ts.transportrouteid and ts.transportstagestatus='A' and tr.transportroutestatus='A' and ts.transportstageid=st.transportstageid and st.studentstageallocationstatus in('A','D') and tr.transportrouteid='"+transportrouteid+"'";

		routename=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return routename;
}



public String  getroutename(String transportrouteid){
	String routename=null;
	try{
		select_query="select (routename) from transportroute where transportrouteid='"+transportrouteid+"'";

		routename=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return routename;
}


public ArrayList listYearofSession(String instituteid) {
	log.info("invoking listYearofSession to list all year of session");
	ArrayList courseList = new ArrayList();
//	String currdate = "";
	try {
		String query = "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"
				+ instituteid
				+ "' and (sessionstatus='A' or sessionstatus='R') order by sessionname";
	// System.out.println("query-dccc->"+query);
		courseList = common_data_object.getListMap(query);
	} catch (Exception e) {
		log.error(e);
	}
	return courseList;
}




//get count of route per session created by selvakumar_v


public ArrayList  getcountroutepersession(String sessionid){
	ArrayList stagecount=null;
	try{
select_query="select  (h.transportrouteid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f,studentstageallocation g," +
"transportstage h,transportroute i where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and " +
"c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and " +
"f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and h.transportrouteid=i.transportrouteid and b.stdschedulestatus='A' and " +
"c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and h.transportstagestatus='A'  and " +
"g.studentstageallocationstatus='A' and i.transportroutestatus='A' group by h.transportrouteid";


//System.out.println("getcountstagesession.>>>>"+select_query);
	stagecount=common_data_object.getListMap(select_query);
	
	} 
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stagecount;
}



//get count of students for route per session created by selvakumar_v


public String  getcountroutestudent(String sessionid){
	String stduntcount=null;
	try{

		select_query="	select count(g.transportstageid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e," +
"studentapproval f,studentstageallocation g,transportstage h where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and " +
"c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and " +
"f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and b.stdschedulestatus='A' and c.sectionschedulestatus='A' and " +
" d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and transportstagestatus='A' and g.studentstageallocationstatus='A'";
	stduntcount=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stduntcount;
}



//get route name per session created by selvakumar_v


public ArrayList  getroutenamepersession(String sessionid){
	ArrayList stagecount=null;
	try{
	select_query="select  i.routename,i.transportrouteid from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f," +
	"studentstageallocation g,transportstage h,transportroute i where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and " +
	"c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and" +
	" h.transportrouteid=i.transportrouteid and f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and b.stdschedulestatus='A' and" +
	" c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and transportstagestatus='A' and" +
	" g.studentstageallocationstatus='A' and i.transportroutestatus='A' group by h.transportrouteid";

	stagecount=common_data_object.getListMap(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stagecount;
}



//get count of students for route per session created by selvakumar_v


public int  getindividualroutecount(String sessionid,String transportrouteid){
	int stduntcount=0;
	try{
select_query="select  count(i.routename) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f," +
	"studentstageallocation g,transportstage h,transportroute i where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and " +
	"c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and" +
	" h.transportrouteid=i.transportrouteid and f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and b.stdschedulestatus='A' and" +
	" c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and transportstagestatus='A' and" +
	" g.studentstageallocationstatus='A' and i.transportroutestatus='A' and i.transportrouteid='"+transportrouteid+"'";
	//System.out.println("select_query>>getindividualstagecount>"+select_query);
	stduntcount=Integer.parseInt(common_data_object.getString(select_query)) ;
		
	} 
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stduntcount;
}

//get sessionname created by selvakumar_v
 

public String getsessioname(String sessionid){
	
	 String return_value=null;
	try{
		select_query="select sessionname from yearofsession where sessionid='"+sessionid+"' and (sessionstatus='A' or sessionstatus='R')";
	//	System.out.println("select_query..amt"+select_query);
		return_value=common_data_object.getString(select_query);
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return return_value;
}



//get if for students per route per session created by selvakumar_v


public ArrayList  getstudentid(String sessionid,String transportrouteid){
	ArrayList stduntcount=null;
	try{
select_query="select  (f.studentapprovalid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f," +
	"studentstageallocation g,transportstage h,transportroute i where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and " +
	"c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and" +
	" h.transportrouteid=i.transportrouteid and f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and b.stdschedulestatus='A' and" +
	" c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and transportstagestatus='A' and" +
	" g.studentstageallocationstatus='A' and i.transportroutestatus='A' and i.transportrouteid='"+transportrouteid+"'";
	//System.out.println("select_query>>getindividualstagecount>"+select_query);
	stduntcount=common_data_object.getListMap(select_query);
		
	} 
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stduntcount;
}


//get  student profile view  created by selvakumar v
public ArrayList getstudentprofileview(String stappid){
	ArrayList result=null;
	try{
	select_query="SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid,s.createdby FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.studentapprovalid='"+stappid+"' and cm.candidateregisterid=s.candidateregisterid and  cm.personid=pm.personid and   cm.candidateregisterstatus='A' and s.studentallocationstatus='A'";
	//System.out.println("getdiscountpersession >>>>"+select_query);
		result=common_data_object.getListMap(select_query); 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}


//get  transport report created by selvakumar v
public ArrayList gettransportroutecount(String instituteid){
	ArrayList result=null;
	try{
	select_query="select c.transportrouteid,a.transportstageid,c.routename,a.transportstageid,a.transportstagename,count(studentapprovalid) as total," +
	"GROUP_CONCAT(b.studentapprovalid) as studentapprovalid from transportroute c, transportstage a left outer join studentstageallocation b on a.transportstageid = " +
	"b.transportstageid and b.studentstageallocationstatus='A' and a.transportstagestatus='A' where a.transportrouteid=c.transportrouteid  and c.instituteid="+instituteid+""+
	" and c.transportroutestatus='A' group by c.transportrouteid";
		result=common_data_object.getListMap(select_query); 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}


//get  transport Stage Student Count View created by Sindhu.V Sep-26-2013
public ArrayList gettransportstagestucount(String transportrouteid){
	ArrayList result=null;
	try{
	select_query="select a.transportstageid,a.transportstagename,a.transportstagestatus,GROUP_CONCAT(b.studentapprovalid) as studentapprovalid,b.studentstageallocationstatus, count(studentstageallocationid) as studentcount from transportstage a left outer join studentstageallocation b on a.transportstageid=b.transportstageid where a.transportstagestatus='A' and b.studentstageallocationstatus='A' and a.transportrouteid='"+transportrouteid+"' group by a.transportstageid;";
		result=common_data_object.getListMap(select_query); 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}


//get  transport report created by selvakumar v
public ArrayList gettransportroutestagecount(String transportrouteid){
	ArrayList result=null;
	try{
	select_query="select count(a.transportrouteid) as total,b.transportstagename,a.routename,GROUP_CONCAT(c.studentapprovalid) as studentapprovalid" +
" from transportroute a,transportstage b,studentstageallocation c where a.transportrouteid=b.transportrouteid and " +
"b.transportstageid=c.transportstageid and c.studentstageallocationstatus='A' and b.transportstagestatus='A' and a.transportroutestatus='A' and a.transportroutestatus='A'" +
" and a.transportrouteid='"+transportrouteid+"'" +
" group by  b.transportstageid";
	//System.out.println("gettransportroutestagecount >aa>>>"+select_query);
		result=common_data_object.getListMap(select_query); 
		
	} 
	catch (Exception e) {
		e.printStackTrace();
	}
	return result;  
}


public int deletetranspotroute(String routeid) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtranspotrouteprepared 	= null;
	
	try{
		transpotrouteconnection= ConnectionManager.getKycConnection();
		//String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="delete from  transportroute  where transportrouteid=?";
		trashtranspotrouteprepared = transpotrouteconnection.prepareStatement(select_query);
		 
		trashtranspotrouteprepared.setString(1,routeid);
		
		result += trashtranspotrouteprepared.executeUpdate(); 

		//System.out.println("trashtranspotrouteprepared>>>>>"+trashtranspotrouteprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transpotrouteconnection!=null){
			
			transpotrouteconnection.rollback();
		}
	}
	finally{
		if(trashtranspotrouteprepared!=null){
			trashtranspotrouteprepared.close();
			
		}
			if(transpotrouteconnection!=null){
			
			transpotrouteconnection.close();
		}
		
	}
	
	return result;
}

	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection transpotrouteconnection;
	 int rollbackvalue;

}
