package com.iGrandee.MasterEntries.Religion;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.MasterEntries.Community.CommunityBean;
import com.iGrandee.MasterEntries.Community.CommunityQuery;

import org.apache.log4j.Logger;

public class ReligionQuery
{
	static Logger log = Logger.getLogger(ReligionQuery.class);
	public  ReligionQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 instituteconn      = null;
		 rollbackvalue = 0;
		select_query= "";
	}

	 public ArrayList loadReligionList(String instituteid)
	    {
		 log.info("Invoking loadReligionList() for Loading Religion Name ");
	        ArrayList arraylist = new ArrayList();
	        try
	        {
	           select_query = "select religionid,religionname,religiondescription,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation from religion  where instituteid='"+instituteid+"' and  relistatus='A'";
	         //  System.out.println("loadReligionList>>>>"+select_query);
	            arraylist = common_data_object.getListMap(select_query);
	            log.info(select_query);
	        }
	        catch(Exception exception) {log.info(exception); }
	        return arraylist;
		}
	 public ArrayList checkDuplicateReligionname(String religionnames,String instituteid)
	 {
	 	log.info("Invoking checkDuplicateReligionname() for checking Duplicate Religion Name ");
	 	ArrayList list=null;
 	
	 	try
	 	{
	 		select_query="select religionid,religionname from religion where religionname='"+religionnames+"' and instituteid='"+instituteid+"' and relistatus<>'X'";
	 		log.info(select_query);

	 		list=common_data_object.getListMap(select_query);
	 		
	 		
	 			
	 	}
	 	catch(Exception exception)
	 	{ 
	 			
	 		log.info(exception);
	 			
	 		}
	     	finally
	 		{
	 			
	 		}
	     	return list;
	     }	 
	 
	 
	 public int insertReligion(ReligionBean religionBean) throws Exception
	 {
		 log.info("Invoking insertReligion() for insert Religion Name ");
		 	int result					= 0;
			PreparedStatement reliprepared = null;
			PreparedStatement religionlog = null;
			PreparedStatement instituteprepared = null;

			long regid					= 0l;
			String currentdate			= DateTime.showTime("MySqlWithTime");
			String querytoexecute		= null;
			ResultSet regidresult		= null;
			ResultSet rs1						= null;
			long relilogid			= 0l;
	 try
	 {
		 	instituteconn = ConnectionManager.getKycConnection();
			instituteconn.setAutoCommit(false);
		
	        String str			= "select religionid,religionname from religion where religionname=? and instituteid=? and relistatus <> ? ";
	        instituteprepared	= instituteconn.prepareStatement(str);
	        instituteprepared.setString(1, religionBean.getReligionname().toLowerCase());
	        instituteprepared.setString(2, religionBean.getInstituteid());
	        instituteprepared.setString(3, "X");
	        rs1	= instituteprepared.executeQuery(); 
	        if(!rs1.next())
	        {
			
			String query="select max(religionid) from religion";
			long religionid = common_data_object.maxId(query);
			religionid++;

			query="insert into religion (religionid, religionname, religiondescription, instituteid, dateofcreation, relistatus,createdby) values(?,?,?,?,?,?,?)";
			reliprepared = instituteconn.prepareStatement(query);
			reliprepared.setLong(1, religionid);
			reliprepared.setString(2,religionBean.getReligionname());
			reliprepared.setString(3,religionBean.getReligiondescription());
			reliprepared.setString(4,religionBean.getInstituteid());
			reliprepared.setString(5, currentdate);
			reliprepared.setString(6,"A");
			reliprepared.setString(7,religionBean.getCreatedby());
			
			result += reliprepared.executeUpdate();
			
			
			querytoexecute		= "select max(relilogid) from religionlog";
			religionlog			= instituteconn.prepareStatement(querytoexecute);
			regidresult			= religionlog.executeQuery();
			
			if(regidresult.next())
			{
				relilogid	= regidresult.getLong(1);
			}
			
			relilogid++;
			
			querytoexecute		= "insert into religionlog(relilogid, relilogdescription, religionid,dateofcreation, relilogstatus) values(?,?,?,?,?)";
			religionlog				= instituteconn.prepareStatement(querytoexecute);
			
			religionlog.setLong(1, relilogid);
			religionlog.setString(2,"Created");
			religionlog.setLong(3,religionid);
			religionlog.setString(4, currentdate);
			religionlog.setString(5,"A");
			
			result += religionlog.executeUpdate();
			
			
			
			instituteconn.commit();
	        }
	        else
	        {
	        	result=1000;
	        }
		 
	 }catch(SQLException e){
		  
			e.printStackTrace();
			result	= 0;
			if(instituteconn != null)
				instituteconn.rollback();
			
			if(instituteprepared!=null)
				instituteprepared.close();
			
			if(rs1!=null)
			rs1.close();
	 }
	 finally
		{
		 if(regidresult != null)
			 regidresult.close();
		 
		 if(reliprepared != null)
			reliprepared.close();
		 if(religionlog != null)
			 religionlog.close();
		 if(instituteconn != null)
		 instituteconn.close();
		 }
	 return result;
	 }
	 public int UpdateEditReligion(ReligionBean religionBean)  throws SQLException
	    {
		 log.info("Invoking UpdateEditReligion() for update Religion Details ");
	    	PreparedStatement religionupdateprepared  = null;
			PreparedStatement instituteprepared = null;
			ResultSet rs1						= null;

			int rs=0;
	    	int result=0;
	    	
	    
	    		
	        	try {
					String religionid=religionBean.getReligionid();
					String religionname=religionBean.getReligionname();
					String religiondesc=religionBean.getReligiondescription();
						        	
					instituteconn = ConnectionManager.getKycConnection();

					 String str			= "select religionname from religion where religionname=? and religionid<>? and instituteid=? and relistatus <> ?";
			            instituteprepared	= instituteconn.prepareStatement(str);
			            instituteprepared.setString(1, religionBean.getReligionname().toLowerCase());
			            instituteprepared.setString(2, religionBean.getReligionid()); 
			            instituteprepared.setString(3,religionBean.getInstituteid()); 
			            instituteprepared.setString(4, "X");
			            rs1	= instituteprepared.executeQuery();   
			            if(!rs1.next())
			            { 
						String query="update religion set religionname=?, dateofcreation=?,religiondescription=?,instituteid=?  where religionid=? ";
					religionupdateprepared = instituteconn.prepareStatement(query);
					
					religionupdateprepared.setString(1, religionname);
					religionupdateprepared.setString(2, DateTime.showTime("MySqlWithTime"));
					religionupdateprepared.setString(3,religiondesc);
					religionupdateprepared.setString(4, religionBean.getInstituteid());
					religionupdateprepared.setString(5,religionid);

					rs = religionupdateprepared.executeUpdate();

					long l1 = common_data_object.fmaxId("select max(relilogid)from religionlog");
					String query1="insert into religionlog (relilogid,relilogdescription,religionid,dateofcreation,relilogstatus) values(?,?,?,?,?)";
   

					religionupdateprepared = instituteconn.prepareStatement(query1);
					religionupdateprepared.setLong(1, l1);
					religionupdateprepared.setString(2,"Updated");
					religionupdateprepared.setString(3,religionBean.getReligionid());
					religionupdateprepared.setString(4, DateTime.showTime("MySqlWithTime"));
					religionupdateprepared.setString(5,"A");
					result = religionupdateprepared.executeUpdate();
		            }
		            else
		            {
		            	rs=1000;  
		            }
				} catch (Exception exception) {
					log.info(exception);
					
				}
						 		
	   
	    	finally
			{
				if(religionupdateprepared != null)
					religionupdateprepared.close();
				
				if(instituteconn != null)
					instituteconn.close();
				
				if(instituteprepared!=null)
					instituteprepared.close();
				
				if(rs1!=null)
				rs1.close();
			}
	    	return rs;
	    }
	 public int ReligionDeactivate(ReligionBean religionBean)  throws SQLException
	 {
	 	log.info("Invoking ReligionDeactivate() for List the Deactivate  Religion ");
	 	PreparedStatement religiondeactivatelistprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	int rs=0;
	 	int result=0;
	 	
	 	try
	 	{
	     	String religionid=religionBean.getReligionid();

	     	instituteconn = ConnectionManager.getKycConnection();

	 		String query="update religion set relistatus=? ,dateofcreation=?,instituteid=?  where religionid=? ";
	 		religiondeactivatelistprepared = instituteconn.prepareStatement(query);

	 		religiondeactivatelistprepared.setString(1, "D");
	 		religiondeactivatelistprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 	  //religiondeactivatelistprepared.setString(3, examnameBean.getIpaddess());
	 		//religiondeactivatelistprepared.setString(3, communityBean.getCreatedby());
	 		religiondeactivatelistprepared.setString(3, religionBean.getInstituteid());
	 		religiondeactivatelistprepared.setString(4,religionid);
	 		rs = religiondeactivatelistprepared.executeUpdate();


	 		long l1 = common_data_object.fmaxId("select max(relilogid)from religionlog");
			String query1="insert into religionlog (relilogid,relilogdescription,religionid,dateofcreation,relilogstatus) values(?,?,?,?,?)";
			log.info(query1);

	         religiondeactivatelistprepared = instituteconn.prepareStatement(query1);
	         religiondeactivatelistprepared.setLong(1, l1);
	         religiondeactivatelistprepared.setString(2,"Deactive");
	         religiondeactivatelistprepared.setString(3,religionBean.getReligionid());
	         //religiondeactivatelistprepared.setString(4, communityBean.getCreatedby());
	         religiondeactivatelistprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	         religiondeactivatelistprepared.setString(5,"A");
	         
	 		result = religiondeactivatelistprepared.executeUpdate();

	 		
	 	}
	 	catch(Exception exception) { 
	 		
	 		log.info(exception);
	 		
	 	}
	 	finally
	 	{
	 		if(religiondeactivatelistprepared != null)
	 			religiondeactivatelistprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 public ArrayList checkdeactiveReligion(String instituteid,String religionid)
	 {
	 	log.info("Invoking checkdeactiveReligion() for checking the religion deactivation");
	 	ArrayList list=null;
	 	
	 	try
	 	{
	 		select_query="select relilogid,religionid,relilogstatus from religionlog where instituteid='"+instituteid+"' and religionid='"+religionid+"' ";
	 		log.info(select_query);
	 		list=common_data_object.getListMap(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 		log.info(exception);
	 	}
	 	return list;
	 }
	 public ArrayList DeactivatedReligionList(String instituteid)
	 {
	 	log.info("Invoking DeactivatedReligionList() for viewing the Religion List");
	 	ArrayList list=null;
	 	try
	 	{
	 		select_query="select religionid,instituteid,religionname,religiondescription,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as dateofcreation,relistatus from religion where instituteid='"+instituteid+"' and relistatus='D'";
	 		log.info(select_query);
	 		list=common_data_object.getListMap(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 		log.info(exception);
	 	}
	 	return list;
	 }
	 public int ActivateReligion(ReligionBean religionBean) throws SQLException
	 {
	 	log.info("Invoking ActivateReligion() for Religion Activation");
	 	
	 	PreparedStatement activatereligionprepared  = null;
	 	PreparedStatement instituteprepared = null;


	 	int rs=0;
	 	
	 	int result=0;
	 	
	 	try
	 	{
	     	String religionid=religionBean.getReligionid();
	     	instituteconn = ConnectionManager.getKycConnection();

	 			String query="update religion set relistatus=?, dateofcreation=?,instituteid=?  where religionid=? ";
	 			activatereligionprepared = instituteconn.prepareStatement(query);
	 			activatereligionprepared.setString(1, "A");
	 			activatereligionprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 			//activateexamnameprepared.setString(3, examnameBean.getIpaddess());
	 			//activatecommunityprepared.setString(3, communityBean.getCreatedby());
	 			activatereligionprepared.setString(3, religionBean.getInstituteid());
	 			activatereligionprepared.setString(4,religionid);
	
	 			rs = activatereligionprepared.executeUpdate();
	 			
	 			long l1 = common_data_object.fmaxId("select max(relilogid)from religionlog");
				String query1="insert into religionlog (relilogid,relilogdescription,religionid,dateofcreation,relilogstatus) values(?,?,?,?,?)";
				log.info(query1);

	 	       activatereligionprepared = instituteconn.prepareStatement(query1);
	 	      activatereligionprepared.setLong(1, l1);
	 	     activatereligionprepared.setString(2,"Active");
	 	    activatereligionprepared.setString(3,religionBean.getReligionid());
	 	   //activatecommunityprepared.setString(4, communityBean.getCreatedby());
	 	   activatereligionprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	 	  activatereligionprepared.setString(5,"A");
	 			
	 			result = activatereligionprepared.executeUpdate();

	 	}catch(Exception exception) { 
	 		
	 		log.info(exception);
	 		
	 	}
	 	finally
	 	{
	 		if(activatereligionprepared != null)
	 			activatereligionprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 public ArrayList get_All_ReligionnameTrashList(String instituteid)
	 {
	 	log.info("Invoking get_All_ReligionnameTrashList() for viewing the Religion Name Trashlist");
	 	ArrayList list=null;
	 	try
	 	{
	 		select_query="select religionid,religionname,religiondescription,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as dateofcreation,relistatus from religion where instituteid='"+instituteid+"' and relistatus='T'";
	 		log.info(select_query);

	 		list=common_data_object.getListMap(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 		log.info(exception);
	 	}
	 	return list;
	 }
	 public int updateTrashReligionname(ReligionBean religionBean) throws SQLException
	 {
	 	log.info("Invoking updateTrashReligionname() for Religion Name Trash ");
	 	String relistatus=religionBean.getRelistatus();
	 	String religionid=religionBean.getReligionid();
	 	PreparedStatement religiontrashprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	
	 	int rs=0;
	 	int result=0;
	 	try
	 	{
	 		instituteconn = ConnectionManager.getKycConnection();
	 			       
	     	String query="update religion set relistatus=?,dateofcreation=?,instituteid=? where religionid=?";
	     	religiontrashprepared = instituteconn.prepareStatement(query);

	     	religiontrashprepared.setString(1, relistatus);
	     	religiontrashprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	     	//religiontrashprepared.setString(3, communityBean.getcreatedby());
	     	religiontrashprepared.setString(3, religionBean.getInstituteid());
	     	religiontrashprepared.setString(4,religionBean.getReligionid());

	 		rs = religiontrashprepared.executeUpdate();
	 		
	 		long l1 = common_data_object.fmaxId("select max(relilogid)from religionlog");
			String query1="insert into religionlog (relilogid,relilogdescription,religionid,dateofcreation,relilogstatus) values(?,?,?,?,?)";

	         religiontrashprepared = instituteconn.prepareStatement(query1);
	         religiontrashprepared.setLong(1, l1);
	         religiontrashprepared.setString(2,"Trash");
	         religiontrashprepared.setString(3,religionBean.getReligionid());
	         religiontrashprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	         religiontrashprepared.setString(5,"A");
	         

	 		result = religiontrashprepared.executeUpdate();
	 	}
	 		
	 		catch(Exception exception)
	 		{ 
	 				
	 			log.info(exception);
	 				
	 			}
	 	    	finally
	 			{
	 				if(religiontrashprepared != null)
	 					religiontrashprepared.close();
	 				
	 				if(instituteconn != null)
	 					instituteconn.close();
	 			}
	 	    	return rs;
	 	    }
	 public int RestoreReligion(ReligionBean religionBean) throws SQLException
	 {
	 	log.info("Invoking RestoreReligion() for Religion Restore");
	 	PreparedStatement religionRestoreprepared  = null;
	 	PreparedStatement instituteprepared = null;


	 	int rs=0;
	 	
	 	int result=0;
	 	
	 	try
	 	{
	     	String religionid=religionBean.getReligionid();
	     	instituteconn = ConnectionManager.getKycConnection();

	 			String query="update religion set relistatus=?, dateofcreation=?,instituteid=?  where religionid=? ";
	 			religionRestoreprepared = instituteconn.prepareStatement(query);
	 			religionRestoreprepared.setString(1, "A");
	 			religionRestoreprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 			//religionRestoreprepared.setString(3, examnameBean.getIpaddess());
	 			//religionRestoreprepared.setString(3, communityBean.getCreatedby());
	 			religionRestoreprepared.setString(3, religionBean.getInstituteid());
	 			religionRestoreprepared.setString(4,religionid);

	 		
	 			rs = religionRestoreprepared.executeUpdate();
	 			
	 			long l1 = common_data_object.fmaxId("select max(relilogid)from religionlog");
				String query1="insert into religionlog (relilogid,relilogdescription,religionid,dateofcreation,relilogstatus) values(?,?,?,?,?)";

	 	       religionRestoreprepared = instituteconn.prepareStatement(query1);
	 	      religionRestoreprepared.setLong(1, l1);
	 	     religionRestoreprepared.setString(2,"Restore");
	 	    religionRestoreprepared.setString(3,religionBean.getReligionid());
	 	   //religionRestoreprepared.setString(4,communityBean.getCreatedby());
	 	  religionRestoreprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	 	 religionRestoreprepared.setString(5,"A");
	 	        
	 			result = religionRestoreprepared.executeUpdate();
	 			

	 	}catch(Exception exception) { 
	 		
	 		log.info(exception);
	 		
	 	}
	 	finally
	 	{
	 		if(religionRestoreprepared != null)
	 			religionRestoreprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 public int DeleteReligion(ReligionBean religionBean)  throws SQLException
	 {
	 	PreparedStatement deletereligionprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	int rs=0;
	 int result=0;
	 	
	 	try
	 	{
	     	String religionid=religionBean.getReligionid();

	     	instituteconn = ConnectionManager.getKycConnection();

	 		String query="update religion set relistatus=?,dateofcreation=?,instituteid=?  where religionid=? ";
	 		deletereligionprepared = instituteconn.prepareStatement(query);

	 		deletereligionprepared.setString(1, "X");
	 		deletereligionprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 		//deletereligionprepared.setString(3, examnameBean.getIpaddess());
	 		//deletereligionprepared.setString(3, communityBean.getCreatedby());
	 		deletereligionprepared.setString(3, religionBean.getInstituteid());
	 		deletereligionprepared.setString(4,religionid);
	 		
	 		rs = deletereligionprepared.executeUpdate();
	 		
	 		long l1 = common_data_object.fmaxId("select max(relilogid)from religionlog");
			String query1="insert into religionlog (relilogid,relilogdescription,religionid,dateofcreation,relilogstatus) values(?,?,?,?,?)";

	 		deletereligionprepared = instituteconn.prepareStatement(query1);
	 		deletereligionprepared.setLong(1, l1);
	 		deletereligionprepared.setString(2,"Deleted");
	 		deletereligionprepared.setString(3,religionBean.getReligionid());
	 		//deletereligionprepared.setString(4,communityBean.getCreatedby());
	 		deletereligionprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	 		deletereligionprepared.setString(5,"A");
	 	

	 		result = deletereligionprepared.executeUpdate();


	 		
	 	}
	 	catch(Exception exception) { 
	 		
	 		log.info(exception);
	 		
	 	}
	 	finally
	 	{
	 		if(deletereligionprepared != null)
	 			deletereligionprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }	
	 
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection instituteconn;
	 int rollbackvalue;
}