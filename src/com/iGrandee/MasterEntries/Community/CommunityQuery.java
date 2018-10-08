package com.iGrandee.MasterEntries.Community;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Exam.ExamnameBean;
import com.iGrandee.Exam.ExamnameEntry;
import com.iGrandee.MasterEntries.Department.DepartmentBean;
import org.apache.log4j.Logger;
public class CommunityQuery
{
	static Logger log = Logger.getLogger(CommunityQuery.class);
	public  CommunityQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 instituteconn      = null;
		 rollbackvalue = 0;
		select_query= "";
	}

	 public ArrayList loadCommunityList(String instituteid)
	    {
		 log.info("Invoking loadCommunityList() for Loading Community Name ");
	        ArrayList arraylist = new ArrayList();
	        try
	        {
	           select_query = "select communityid,communityname,communitydescription,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation from community  where instituteid='"+instituteid+"' and  commstatus='A'";
	            arraylist = common_data_object.getListMap(select_query);
	            log.info(select_query);
	        }
	        catch(Exception exception) { }
	        return arraylist;
		}
	 public ArrayList checkDuplicateCommunityname(String communitynames,String instituteid)
	 {
	 	log.info("Invoking checkDuplicateCommunity() for checking Duplicate Community Name ");
	 	ArrayList list=null;
 	
	 	try
	 	{
	 		select_query="select communityid,communityname from community where communityname='"+communitynames+"' and instituteid='"+instituteid+"' and commstatus<>'X'";
	 		list=common_data_object.getListMap(select_query);
	 		log.info(select_query);
	 			 			
	 	}
	 	catch(Exception exception)
	 	{ 
	 		exception.printStackTrace();
	 			
	 		}
	     	finally
	 		{
	 			
	 		}
	     	return list;
	     }
	 public int UpdateEditCommunity(CommunityBean communityBean)  throws SQLException
	    {
		 
	    	PreparedStatement communityupdateprepared  = null;
	    	PreparedStatement selcetcommunitycreateprepared = null;
	    	ResultSet rs1=null;
			int rs=0;
	    	int result=0;
	    	
	    	try
	    	{
	    		
	        	String commid=communityBean.getCommunityid();
	        	String commname=communityBean.getCommunityname();
	        	String commdesc=communityBean.getCommunitydescription();
	    			        	
	            instituteconn = ConnectionManager.getKycConnection();
	            String str			= "select communityid from community where communityname=? and communityid<>? and commstatus!=?";
				
				selcetcommunitycreateprepared	= instituteconn.prepareStatement(str);
				selcetcommunitycreateprepared.setString(1,communityBean.getCommunityname().toLowerCase());
				selcetcommunitycreateprepared.setString(2,commid);
				selcetcommunitycreateprepared.setString(3, "X");
	            rs1	= selcetcommunitycreateprepared.executeQuery();
	            log.info(selcetcommunitycreateprepared);
	            
	            
	            if(!rs1.next()){
				
				String query="update community set communityname=?, dateofcreation=?,communitydescription=?,instituteid=?  where communityid=? ";
				communityupdateprepared = instituteconn.prepareStatement(query);
				
				communityupdateprepared.setString(1, commname);
				communityupdateprepared.setString(2, DateTime.showTime("MySqlWithTime"));
				communityupdateprepared.setString(3,commdesc);
				communityupdateprepared.setString(4, communityBean.getInstituteid());
				communityupdateprepared.setString(5,commid);

				rs = communityupdateprepared.executeUpdate();
		
				long l1 = common_data_object.fmaxId("select max(commlogid)from communitylog");
				String query1="insert into communitylog (commlogid,comlogdescription,communityid,dateofcreation,commlogstatus) values(?,?,?,?,?)";
       

		        communityupdateprepared = instituteconn.prepareStatement(query1);
		        communityupdateprepared.setLong(1, l1);
		        communityupdateprepared.setString(2,"Updated");
		        communityupdateprepared.setString(3,communityBean.getCommunityid());
		        communityupdateprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		        communityupdateprepared.setString(5,"A");
		        result = communityupdateprepared.executeUpdate();
	            }
	            else
	            {
	            	rs=1000;
	            }
						 		
	    	}
	    	catch(Exception exception) { 
				
				exception.printStackTrace();
				
			}
	    	finally
			{
				if(communityupdateprepared != null)
					communityupdateprepared.close();
				
				if(selcetcommunitycreateprepared!= null)
					selcetcommunitycreateprepared.close();
				
				if(rs1!= null)
					rs1.close();
				if(instituteconn != null)
					instituteconn.close();
			}
	    	return rs;
	    }	
	 public int updateTrashCommunityname(CommunityBean communityBean) throws SQLException
	 {
	 	log.info("Invoking updateTrashCommunityname() for religion Name Trash ");
	 	String commstatus=communityBean.getCommstatus();
	 	String communityid=communityBean.getCommunityid();
	 	PreparedStatement communitytrashprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	
	 	int rs=0;
	 	int result=0;
	 	try
	 	{
	 		instituteconn = ConnectionManager.getKycConnection();
	 			       
	     	String query="update community set commstatus=?,dateofcreation=?,instituteid=? where communityid=?";
	     	communitytrashprepared = instituteconn.prepareStatement(query);
	     	log.info(query);

	     	communitytrashprepared.setString(1, commstatus);
	     	communitytrashprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	     	//communitytrashprepared.setString(3, communityBean.getcreatedby());
	     	communitytrashprepared.setString(3, communityBean.getInstituteid());
	     	communitytrashprepared.setString(4,communityBean.getCommunityid());

	 		rs = communitytrashprepared.executeUpdate();
	 		
	 		long l1 = common_data_object.fmaxId("select max(commlogid)from communitylog");
	 		String query1="insert into communitylog (commlogid, comlogdescription,communityid,dateofcreation,commlogstatus) values(?,?,?,?,?)";
	 		log.info(query1);

	         communitytrashprepared = instituteconn.prepareStatement(query1);
	         communitytrashprepared.setLong(1, l1);
	         communitytrashprepared.setString(2,"Trash");
	         communitytrashprepared.setString(3,communityBean.getCommunityid());
	         communitytrashprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	         communitytrashprepared.setString(5,"A");
	         

	 		result = communitytrashprepared.executeUpdate();
	 	}
	 		
	 		catch(Exception exception)
	 		{ 
	 				
	 				exception.printStackTrace();
	 				
	 			}
	 	    	finally
	 			{
	 				if(communitytrashprepared != null)
	 					communitytrashprepared.close();
	 				
	 				if(instituteconn != null)
	 					instituteconn.close();
	 			}
	 	    	return rs;
	 	    }
	 public ArrayList get_All_CommunitynameTrashList(String instituteid)
	 {
	 	log.info("Invoking get_All_CommunitynameTrashList() for viewing the Community Name Trashlist");
	 	ArrayList list=null;
	 	try
	 	{
	 		select_query="select communityid,communityname,communitydescription,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as dateofcreation,commstatus from community where instituteid='"+instituteid+"' and commstatus='T'";
	 		list=common_data_object.getListMap(select_query);
	 		log.info(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 	}
	 	return list;
	 }
	 public int RestoreCommunity(CommunityBean communityBean) throws SQLException
	 {
	 	log.info("Invoking RestoreCommunity() for Community Restore");
	 	PreparedStatement communityRestoreprepared  = null;
	 	PreparedStatement instituteprepared = null;


	 	int rs=0;
	 	
	 	int result=0;
	 	
	 	try
	 	{
	     	String communityid=communityBean.getCommunityid();
	     	instituteconn = ConnectionManager.getKycConnection();

	 			String query="update community set commstatus=?, dateofcreation=?,instituteid=?  where communityid=? ";
	 			communityRestoreprepared = instituteconn.prepareStatement(query);
	 			communityRestoreprepared.setString(1, "A");
	 			communityRestoreprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 			//communityRestoreprepared.setString(3, examnameBean.getIpaddess());
	 			//communityRestoreprepared.setString(3, communityBean.getCreatedby());
	 			communityRestoreprepared.setString(3, communityBean.getInstituteid());
	 			communityRestoreprepared.setString(4,communityid);

	 		
	 			rs = communityRestoreprepared.executeUpdate();
	 			
	 			long l1 = common_data_object.fmaxId("select max(communitylogid)from examnamelog");
	 			String query1="insert into communitylog (commlogid, comlogdescription, communityid, dateofcreation, commlogstatus) values(?,?,?,?,?)";
	 			log.info(query1);

	 	       communityRestoreprepared = instituteconn.prepareStatement(query1);
	 	      communityRestoreprepared.setLong(1, l1);
	 	     communityRestoreprepared.setString(2,"Restore");
	 	    communityRestoreprepared.setString(3,communityBean.getCommunityid());
	 	   //communityRestoreprepared.setString(4,communityBean.getCreatedby());
	 	  communityRestoreprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	 	 communityRestoreprepared.setString(5,"A");
	 	        
	 			result = communityRestoreprepared.executeUpdate();
	 			

	 	}catch(Exception exception) { 
	 		
	 		exception.printStackTrace();
	 		
	 	}
	 	finally
	 	{
	 		if(communityRestoreprepared != null)
	 			communityRestoreprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 public int insertCommunity(CommunityBean communityBean) throws Exception
	 {
		 	int result					= 0;
		 	
			PreparedStatement communitycreateprepared = null;
			PreparedStatement communitycreateprepared1 = null;
			PreparedStatement communitylog = null;
			
			long regid					= 0l;
			String currentdate			= DateTime.showTime("MySqlWithTime");
			String querytoexecute		= null;
			ResultSet regidresult		= null;
			ResultSet rs1					= null;
			long commlogid			= 0l;
	 try
	 {
		 instituteconn = ConnectionManager.getKycConnection();
			instituteconn.setAutoCommit(false);
			
			String str			= "select communityid from community where communityname=? and instituteid=? and commstatus!=?";
			log.info(str);
			communitycreateprepared1	= instituteconn.prepareStatement(str);
			communitycreateprepared1.setString(1,communityBean.getCommunityname().toLowerCase());
			communitycreateprepared1.setString(2,communityBean.getInstituteid());
			communitycreateprepared1.setString(3, "X");
            rs1	= communitycreateprepared1.executeQuery();
            
            if(!rs1.next()){
			
			
			String query="select max(communityid) from community";
			long communityid = common_data_object.maxId(query);
			communityid++;

			query="insert into community (communityid, communityname, communitydescription, instituteid, dateofcreation, commstatus,createdby) values(?,?,?,?,?,?,?)";
			communitycreateprepared = instituteconn.prepareStatement(query);
			communitycreateprepared.setLong(1, communityid);
			communitycreateprepared.setString(2,communityBean.getCommunityname());
			communitycreateprepared.setString(3,communityBean.getCommunitydescription());
			communitycreateprepared.setString(4,communityBean.getInstituteid());
			communitycreateprepared.setString(5, currentdate);
			communitycreateprepared.setString(6,"A");
			communitycreateprepared.setString(7,communityBean.getCreatedby());
			
			result += communitycreateprepared.executeUpdate();
			
			
			querytoexecute		= "select max(commlogid) from communitylog";
			communitylog			= instituteconn.prepareStatement(querytoexecute);
			regidresult			= communitylog.executeQuery();
			
			if(regidresult.next()){
				commlogid	= regidresult.getLong(1);
			}
			
			commlogid++;
			
			querytoexecute		= "insert into communitylog(commlogid, comlogdescription, communityid,dateofcreation, commlogstatus) values(?,?,?,?,?)";
			communitylog				= instituteconn.prepareStatement(querytoexecute);
			
			communitylog.setLong(1, commlogid);
			communitylog.setString(2,"Created");
			communitylog.setLong(3,communityid);
			communitylog.setString(4, currentdate);
			communitylog.setString(5,"A");
			
			result += communitylog.executeUpdate();
			
			
			
			instituteconn.commit();
            }else
            {
            	result = 1000;
            }

		 
	 }catch(SQLException e){
		 
			e.printStackTrace();
			result	= 0;
			if(instituteconn != null)
				instituteconn.rollback();
	 }
	 finally
		{
				 if(rs1 != null)
				 rs1.close();
			
		 if(regidresult != null)
			 regidresult.close();
		 
		 if(communitycreateprepared1 != null)
			 communitycreateprepared1.close();
		 
		 if(communitycreateprepared != null)
			 communitycreateprepared.close();
		 if(communitylog != null)
			communitylog.close();
		 if(instituteconn != null)
		 instituteconn.close();
		 }
	 return result;
	 }
	 public int DeleteCommunity(CommunityBean communityBean)  throws SQLException
	 {
	 	PreparedStatement deletecommunityprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	int rs=0;
	 int result=0;
	 	
	 	try
	 	{
	     	String communityid=communityBean.getCommunityid();

	     	instituteconn = ConnectionManager.getKycConnection();

	 		String query="update community set commstatus=?,dateofcreation=?,instituteid=?  where communityid=? ";
	 		deletecommunityprepared = instituteconn.prepareStatement(query);

	 		deletecommunityprepared.setString(1, "X");
	 		deletecommunityprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 		//deletecommunityprepared.setString(3, examnameBean.getIpaddess());
	 		//deletecommunityprepared.setString(3, communityBean.getCreatedby());
	 		deletecommunityprepared.setString(3, communityBean.getInstituteid());
	 		deletecommunityprepared.setString(4,communityid);
	 		
	 		rs = deletecommunityprepared.executeUpdate();
	 		
	 		long l1 = common_data_object.fmaxId("select max(commlogid)from communitylog");
	 		String query1="insert into communitylog (commlogid,comlogdescription,communityid,dateofcreation,commlogstatus) values(?,?,?,?,?)";
	 		log.info(query1);

	 		deletecommunityprepared = instituteconn.prepareStatement(query1);
	 		deletecommunityprepared.setLong(1, l1);
	 		deletecommunityprepared.setString(2,"Deleted");
	 		deletecommunityprepared.setString(3,communityBean.getCommunityid());
	 		//deletecommunityprepared.setString(4,communityBean.getCreatedby());
	 		deletecommunityprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	 		deletecommunityprepared.setString(5,"A");
	 	

	 		result = deletecommunityprepared.executeUpdate();


	 		
	 	}
	 	catch(Exception exception) { 
	 		
	 		exception.printStackTrace();
	 		
	 	}
	 	finally
	 	{
	 		if(deletecommunityprepared != null)
	 			deletecommunityprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }	
	 public int CommunityDeactivate(CommunityBean communityBean)  throws SQLException
	 {
	 	log.info("Invoking CommunityDeactivate() for List the Deactivate  Community ");
	 	PreparedStatement communitydeactivatelistprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	int rs=0;
	 	int result=0;
	 	
	 	try
	 	{
	     	String Communityid=communityBean.getCommunityid();

	     	instituteconn = ConnectionManager.getKycConnection();

	 		String query="update community set commstatus=? ,dateofcreation=?,instituteid=?  where communityid=? ";
	 		communitydeactivatelistprepared = instituteconn.prepareStatement(query);

	 		communitydeactivatelistprepared.setString(1, "D");
	 		communitydeactivatelistprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 	  //examnamedeactivatelistprepared.setString(3, examnameBean.getIpaddess());
	 		//communitydeactivatelistprepared.setString(3, communityBean.getCreatedby());
	 		communitydeactivatelistprepared.setString(3, communityBean.getInstituteid());
	 		communitydeactivatelistprepared.setString(4,Communityid);
	 		rs = communitydeactivatelistprepared.executeUpdate();


	 		long l1 = common_data_object.fmaxId("select max(commlogid)from communitylog");
	 		String query1="insert into communitylog (commlogid,comlogdescription,communityid,dateofcreation,commlogstatus) values(?,?,?,?,?)";
	 		log.info(query1);

	         communitydeactivatelistprepared = instituteconn.prepareStatement(query1);
	         communitydeactivatelistprepared.setLong(1, l1);
	         communitydeactivatelistprepared.setString(2,"Deactive");
	         communitydeactivatelistprepared.setString(3,communityBean.getCommunityid());
	         //communitydeactivatelistprepared.setString(4, communityBean.getCreatedby());
	         communitydeactivatelistprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	         communitydeactivatelistprepared.setString(5,"A");
	         
	 		result = communitydeactivatelistprepared.executeUpdate();

	 		
	 	}
	 	catch(Exception exception) { 
	 		
	 		exception.printStackTrace();
	 		
	 	}
	 	finally
	 	{
	 		if(communitydeactivatelistprepared != null)
	 			communitydeactivatelistprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 public ArrayList checkdeactiveCommunity(String instituteid,String communityid)
	 {
	 	log.info("Invoking checkdeactiveCommunity() for checking the community deactivation");
	 	ArrayList list=null;
	 	
	 	try
	 	{
	 		select_query="select commlogid,communityid,commlogstatus from communitylog where instituteid='"+instituteid+"' and communityid='"+communityid+"' ";
	 		log.info(select_query);
	 		
	 		list=common_data_object.getListMap(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 	}
	 	return list;
	 }
	 public ArrayList DeactivatedCommunityList(String instituteid)
	 {
	 	log.info("Invoking DeactivatedCommunityList() for viewing the Community List");
	 	ArrayList list=null;
	 	try
	 	{
	 		select_query="select communityid,instituteid,communityname,communitydescription,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as dateofcreation,commstatus from community where instituteid='"+instituteid+"' and commstatus='D'";
	 		log.info(select_query);

	 		list=common_data_object.getListMap(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 	}
	 	return list;
	 }
	 public int ActivateCommunity(CommunityBean communityBean) throws SQLException
	 {
	 	log.info("Invoking ActivateCommunity() for Community Activation");
	 	
	 	PreparedStatement activatecommunityprepared  = null;
	 	PreparedStatement instituteprepared = null;


	 	int rs=0;
	 	
	 	int result=0;
	 	
	 	try
	 	{
	     	String communityid=communityBean.getCommunityid();
	     	instituteconn = ConnectionManager.getKycConnection();

	 			String query="update community set commstatus=?, dateofcreation=?,instituteid=?  where communityid=? ";
	 			activatecommunityprepared = instituteconn.prepareStatement(query);
	 			activatecommunityprepared.setString(1, "A");
	 			activatecommunityprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 			//activateexamnameprepared.setString(3, examnameBean.getIpaddess());
	 			//activatecommunityprepared.setString(3, communityBean.getCreatedby());
	 			activatecommunityprepared.setString(3, communityBean.getInstituteid());
	 			activatecommunityprepared.setString(4,communityid);

	 		
	 			rs = activatecommunityprepared.executeUpdate();
	 			
	 			long l1 = common_data_object.fmaxId("select max(commlogid)from communitylog");
	 			String query1="insert into communitylog (commlogid, comlogdescription, communityid, dateofcreation, commlogstatus) values(?,?,?,?,?)";
	 			log.info(query1);

	 	       activatecommunityprepared = instituteconn.prepareStatement(query1);
	 	      activatecommunityprepared.setLong(1, l1);
	 	     activatecommunityprepared.setString(2,"Active");
	 	    activatecommunityprepared.setString(3,communityBean.getCommunityid());
	 	   //activatecommunityprepared.setString(4, communityBean.getCreatedby());
	 	  activatecommunityprepared.setString(4, DateTime.showTime("MySqlWithTime"));
	 	 activatecommunityprepared.setString(5,"A");
	 			
	 			result = activatecommunityprepared.executeUpdate();

	 	}catch(Exception exception) { 
	 		
	 		exception.printStackTrace();
	 		
	 	}
	 	finally
	 	{
	 		if(activatecommunityprepared != null)
	 			activatecommunityprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 
	 public ArrayList loadCommunity(String instituteid)
	    {
		 log.info("Invoking loadCommunityList() for Loading Community Name ");
	        ArrayList arraylist = new ArrayList();
	        try
	        {
	           select_query = "select communityid,communityname,communitydescription,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation from community" +
	           		"  where instituteid='"+instituteid+"' and  commstatus='A' order by communityid asc";
	           //System.out.println("loadCommunity>>>>>"+select_query);
	            arraylist = common_data_object.getListMap(select_query);
	            log.info(select_query);
	        }
	        catch(Exception exception) { }
	        return arraylist;
		}
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection instituteconn;
	 CommunityBean communityBean;
	 int rollbackvalue;
}
