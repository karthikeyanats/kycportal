package com.iGrandee.MasterEntries.Scholarship;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.MasterEntries.Community.CommunityBean;

import org.apache.log4j.Logger;

public class ScholarshipQuery
{
	static Logger log = Logger.getLogger(ScholarshipQuery.class);
	public  ScholarshipQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 instituteconn      = null;
		 rollbackvalue = 0;
		select_query= "";
	}
	
 public int insertScholarship(ScholarBean scholarBean) throws Exception
	 {
		 log.info("Invoking insertScholarship() for insert the scholarship");
		 	int result					= 0;
			PreparedStatement scholarprepared = null;
			PreparedStatement scholarcreatelog = null;
			
			long regid					= 0l;
			String currentdate			= DateTime.showTime("MySqlWithTime");
			String querytoexecute		= null;
			ResultSet regidresult		= null;
			long scholarcreatelogid			= 0l;
			boolean flag= false;
	 try
	 {
		 
		 //check for duplicate
		 
		 select_query = "select scholarshipid from scholarship   where  instituteid='"+scholarBean.getInstituteid()+"' and scholarshipname='"+scholarBean.getScholarshipname().toLowerCase()+"' and scholarshipstatus!='X'";
		 log.info(select_query);
         String retString = common_data_object.getString(select_query);
         log.info(retString);
         if(retString==null)
         {
        	 log.info("inside");
        	 flag = true;
         }
         else
         {
        	 flag=false;
        	 result =1000;
         }
         
         
         if(flag)
         {
		 instituteconn = ConnectionManager.getKycConnection();
			instituteconn.setAutoCommit(false);
			
			String query="select max(scholarshipid) from scholarship";
			long scholarshipid = common_data_object.fmaxId(query);
			query="insert into scholarship (scholarshipid, scholarshipname, scholarshipdescription, createdby, dateofcreation, ipaddress, scholarshipstatus, instituteid) values(?,?,?,?,?,?,?,?)";
			scholarprepared = instituteconn.prepareStatement(query);

			scholarprepared.setLong(1, scholarshipid);
			scholarprepared.setString(2,scholarBean.getScholarshipname());
			scholarprepared.setString(3,scholarBean.getScholarshipdescription());
			scholarprepared.setString(4,scholarBean.getCreatedby());
			scholarprepared.setString(5, currentdate);
			scholarprepared.setString(6,scholarBean.getIpaddress());
			scholarprepared.setString(7,"A");
			scholarprepared.setString(8,scholarBean.getInstituteid());
			
			result += scholarprepared.executeUpdate();
				
			querytoexecute		= "select max(scholarcreatelogid) from scholarcreatelog";
			scholarcreatelog	= instituteconn.prepareStatement(querytoexecute);
			regidresult			= scholarcreatelog.executeQuery();
			
			if(regidresult.next()){
				scholarcreatelogid	= regidresult.getLong(1);
			}
			
			scholarcreatelogid++;
			
			querytoexecute		= "insert into scholarcreatelog(scholarcreatelogid, logdescription, scholarshipid, createdby, dateofcreation, scholcreatelogstatus) values(?,?,?,?,?,?)";
			scholarcreatelog	= instituteconn.prepareStatement(querytoexecute);
			
			scholarcreatelog.setLong(1, scholarcreatelogid);
			scholarcreatelog.setString(2,"Created");
			scholarcreatelog.setLong(3,scholarshipid);
			scholarcreatelog.setString(4, scholarBean.getCreatedby());
			scholarcreatelog.setString(5, currentdate);
			scholarcreatelog.setString(6,"A");
			
			result += scholarcreatelog.executeUpdate();
			
			
			
			instituteconn.commit();
         }

		 
	 }catch(SQLException sqlexception){
		 
		 log.error(sqlexception);
		 
			sqlexception.printStackTrace();
			result	= 0;
			if(instituteconn != null)
				instituteconn.rollback();
	 }
	 finally
		{
		 if(regidresult != null)
			 regidresult.close();
		  if(scholarprepared != null)
			scholarprepared.close();
		 if(scholarcreatelog != null)
			 scholarcreatelog.close();
		 if(instituteconn != null)
		 instituteconn.close();
		 }
	 return result;
	 }
	 public ArrayList listScholarshipList(String instituteid)
	    {
		 log.info("Invoking listScholarshipList() for list the scholarship");
	        ArrayList arraylist = new ArrayList();
	        try
	        {
	           	select_query = "select scholarshipid,scholarshipname,scholarshipdescription,ipaddress from scholarship   where  instituteid='"+instituteid+"' and scholarshipstatus='A' ";
	            arraylist = common_data_object.getListMap(select_query);
	        }
	        catch(Exception exception) {
	        	log.error(exception);
	        }
	        return arraylist;
		}
	 public int UpdateEditScholarship(ScholarBean scholarBean)  throws SQLException
	    {
	    	PreparedStatement scholarupdateprepared  = null;
	    	PreparedStatement scholarshipprepared  = null;
	    	ResultSet rs1						= null;
			int rs=0;
	    	int result=0;
	    	
	    	try
	    	{
	    		
	        	String scholarid=scholarBean.getScholarshipid();
	        	String scholarname=scholarBean.getScholarshipname();
	        	String scholardesc=scholarBean.getScholarshipdescription();
	    			        	
	            instituteconn = ConnectionManager.getKycConnection();
	            
	            String str	= "select scholarshipname from scholarship where scholarshipname=? and scholarshipid<>? and instituteid=? and scholarshipstatus!=?";
	            scholarshipprepared	= instituteconn.prepareStatement(str);
	            scholarshipprepared.setString(1, scholarname.toLowerCase());
	            scholarshipprepared.setString(2, scholarid);
	            scholarshipprepared.setString(3,scholarBean.getInstituteid());
	            scholarshipprepared.setString(4, "X");
	            rs1	= scholarshipprepared.executeQuery();
	            
	            if(!rs1.next()){

				String query="update scholarship set scholarshipname=?, dateofcreation=?,scholarshipdescription=?,instituteid=?,ipaddress=?  where scholarshipid=? ";
				scholarupdateprepared = instituteconn.prepareStatement(query);
				
				scholarupdateprepared.setString(1, scholarname);
				scholarupdateprepared.setString(2, DateTime.showTime("MySqlWithTime"));
				scholarupdateprepared.setString(3,scholardesc);
				scholarupdateprepared.setString(4, scholarBean.getInstituteid());
				scholarupdateprepared.setString(5, scholarBean.getIpaddress());
				scholarupdateprepared.setString(6,scholarid);

				rs = scholarupdateprepared.executeUpdate();
		
				long l1 = common_data_object.fmaxId("select max(scholarcreatelogid)from scholarcreatelog");
				String query1="insert into scholarcreatelog(scholarcreatelogid, logdescription, scholarshipid, createdby, dateofcreation, scholcreatelogstatus) values(?,?,?,?,?,?)";
    

				scholarupdateprepared = instituteconn.prepareStatement(query1);
				scholarupdateprepared.setLong(1, l1);
				scholarupdateprepared.setString(2,"Updated");
				scholarupdateprepared.setString(3,scholarBean.getScholarshipid());
				scholarupdateprepared.setString(4, scholarBean.getCreatedby());
				scholarupdateprepared.setString(5, DateTime.showTime("MySqlWithTime"));
				scholarupdateprepared.setString(6,"A");
		        result = scholarupdateprepared.executeUpdate();
	            }
	            else
	            	rs	= 1000;
						 		
	    	}
	    	catch(Exception exception) { 
				
				exception.printStackTrace();
				
			}
	    	finally
			{
				if(scholarupdateprepared != null)
					scholarupdateprepared.close();
				
				if(scholarshipprepared!= null)
					scholarshipprepared.close();
				
				if(rs1!= null)
					rs1.close();
				
				if(instituteconn != null)
					instituteconn.close();
			}
	    	return rs;
	    }
	 public int updateTrashScholarname(ScholarBean scholarBean) throws SQLException
	 {
	 	log.info("Invoking updateTrashScholarname() for Exam Name Trash ");
	 	String scholarshipstatus=scholarBean.getScholarshipstatus();
	 	String scholarnameid=scholarBean.getScholarshipid();
	 	PreparedStatement scholartrashprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	
	 	int rs=0;
	 	int result=0;
	 	try
	 	{
	 		instituteconn = ConnectionManager.getKycConnection();
	 			       
	     	String query="update scholarship set scholarshipstatus=?,dateofcreation=?,createdby=?,instituteid=?,ipaddress=? where scholarshipid=?";
	     	scholartrashprepared = instituteconn.prepareStatement(query);

	     	scholartrashprepared.setString(1, scholarshipstatus);
	     	scholartrashprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	     	scholartrashprepared.setString(3, scholarBean.getCreatedby());
	     	scholartrashprepared.setString(4, scholarBean.getInstituteid());
	     	scholartrashprepared.setString(5, scholarBean.getIpaddress());
	     	scholartrashprepared.setString(6,scholarBean.getScholarshipid());

	 		rs = scholartrashprepared.executeUpdate();
	 		long l1 = common_data_object.fmaxId("select max(scholarcreatelogid)from scholarcreatelog");
			String query1="insert into scholarcreatelog(scholarcreatelogid, logdescription, scholarshipid, createdby, dateofcreation, scholcreatelogstatus) values(?,?,?,?,?,?)";

	            
	         scholartrashprepared = instituteconn.prepareStatement(query1);
	         scholartrashprepared.setLong(1, l1);
	         scholartrashprepared.setString(2,"Trash");
	         scholartrashprepared.setString(3,scholarBean.getScholarshipid());
	         scholartrashprepared.setString(4, scholarBean.getCreatedby());
	         scholartrashprepared.setString(5, DateTime.showTime("MySqlWithTime"));
	         scholartrashprepared.setString(6,"A");
		     
	         result = scholartrashprepared.executeUpdate();

	 		
	 	}
	 		
	 		catch(Exception exception)
	 		{ 
	 				
	 				exception.printStackTrace();
	 				
	 			}
	 	    	finally
	 			{
	 				if(scholartrashprepared != null)
	 					scholartrashprepared.close();
	 				
	 				if(instituteconn != null)
	 					instituteconn.close();
	 			}
	 	    	return rs;
	 	    }
	 public ArrayList get_All_ScholarshipnameTrashList(String instituteid)
	 {
	 	log.info("Invoking get_All_ScholarshipnameTrashList() for viewing the scholarship Name Trashlist");
	 	ArrayList list=null;
	 	try
	 	{
	 		select_query="select scholarshipid,scholarshipname,scholarshipdescription,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as dateofcreation,scholarshipstatus from scholarship where instituteid='"+instituteid+"' and scholarshipstatus='T'";

	 		list=common_data_object.getListMap(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 	}
	 	return list;
	 }
	 
	 
	 /*
	  * This method is accessed from kycportal/jsp/Master Entries/Scholarship/ScholarshipBeneficiaryStudents.jsp created by Sindhu.V
	 */
	 public ArrayList ScholarshipstdDetails(String instituteid,String sessionid,String boardid)
	 {
	 	log.info("invoking ScholarshipstdDetails from com.iGrandee.MasterEntries.Scholarship");

	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select c.standardid,a.standardscheduleid,c.standardname,case when sum(amount) is null then '0' else sum(amount) end as totamount,(select count(aa.userid) from scholarshipforstudent aa, login bb, personmaster cc where aa.scholarshipamountallocationid=b.scholarshipamountallocationid and aa.userid=bb.userid and bb.personid=cc.personid and bb.loginstatus='A' and aa.scholarshipforstudentstatus='A' and cc.status='A' and (cc.sex='F' or cc.sex='Female')) as female, (select count(aa.userid) from scholarshipforstudent aa, login bb, personmaster cc where aa.scholarshipamountallocationid=b.scholarshipamountallocationid and aa.userid=bb.userid and bb.personid=cc.personid and bb.loginstatus='A' and aa.scholarshipforstudentstatus='A' and cc.status='A' and (cc.sex='M' or cc.sex='Male'))as male from standard c,standardschedule a left outer join scholarshipamountallocation b on a.standardscheduleid=b.standardscheduleid  and b.amountallocationstatus='A' where a.sessionid='"+sessionid+"' and c.boardid='"+boardid+"' and c.instituteid='"+instituteid+"' and a.standardid=c.standardid and a.stdschedulestatus='A' and c.standardstatus='A' group by a.standardid";  
	 			periodsList 	= common_data_object.getListMap(select_query);
	 			//System.out.println(select_query);

	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	 		}
	 		return periodsList;
	 }
	 
	 
	 /*
	  * This method is accessed from kycportal/jsp/Master Entries/Scholarship/BeneficiaryStuCount.jsp created by sindhu.V
	 */
	 public ArrayList ScholarshipnameList(String instituteid,String sessionid,String boardid,String standardid)
	 {
	 	log.info("invoking ScholarshipstdDetails from com.iGrandee.MasterEntries.Scholarship");

	 		ArrayList periodsList = null;
	 		try
	 		{
	 			select_query  	= "select sc.scholarshipname,c.standardid,a.standardscheduleid,c.standardname,case when sum(amount) is null then '0' else sum(amount) end as totamount, (select count(aa.userid) from scholarshipforstudent aa, login bb, personmaster cc where aa.scholarshipamountallocationid=b.scholarshipamountallocationid and aa.userid=bb.userid and bb.personid=cc.personid and bb.loginstatus='A' and aa.scholarshipforstudentstatus='A' and cc.status='A' and (cc.sex='F' or cc.sex='Female')) as female, (select count(aa.userid) from scholarshipforstudent aa, login bb, personmaster cc where aa.scholarshipamountallocationid=b.scholarshipamountallocationid and aa.userid=bb.userid and bb.personid=cc.personid and bb.loginstatus='A' and aa.scholarshipforstudentstatus='A' and cc.status='A' and (cc.sex='M' or cc.sex='Male'))as male from standard c,standardschedule a left outer join scholarshipamountallocation b on a.standardscheduleid=b.standardscheduleid  and b.amountallocationstatus='A' join scholarship sc on b.scholarshipid=sc.scholarshipid where a.sessionid='"+sessionid+"' and c.boardid='"+boardid+"' and c.instituteid='"+instituteid+"' and a.standardid='"+standardid+"' and a.standardid=c.standardid and a.stdschedulestatus='A' and c.standardstatus='A' group by a.standardid,b.scholarshipid";  
	 			periodsList 	= common_data_object.getListMap(select_query);
	 			//System.out.println("Scholarshipname-===>>>>"+select_query);

	 		}
	 		catch(Exception exception) { 
	 			
	 			log.error(exception);
	 		}
	 		return periodsList;
	 }

	 
	 
	 public int DeleteScholarship(ScholarBean scholarBean)  throws SQLException
	 {
	 	PreparedStatement deletescholarprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	int rs=0;
	 int result=0;
	 	
	 	try
	 	{
	     	String scholarshipid=scholarBean.getScholarshipid();

	     	instituteconn = ConnectionManager.getKycConnection();

	 		String query="update scholarship set scholarshipstatus=?,dateofcreation=?,instituteid=?,ipaddress=?,createdby=?  where scholarshipid=? ";
	 		deletescholarprepared = instituteconn.prepareStatement(query);

	 		deletescholarprepared.setString(1, "X");
	 		deletescholarprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 		deletescholarprepared.setString(3, scholarBean.getInstituteid());
	 		deletescholarprepared.setString(4, scholarBean.getIpaddress());
	 		deletescholarprepared.setString(5, scholarBean.getCreatedby());
	 		deletescholarprepared.setString(6,scholarshipid);
	 		
	 		rs = deletescholarprepared.executeUpdate();
	 		
	 			
	 		long l1 = common_data_object.fmaxId("select max(scholarcreatelogid)from scholarcreatelog");
			String query1="insert into scholarcreatelog(scholarcreatelogid, logdescription, scholarshipid, createdby, dateofcreation, scholcreatelogstatus) values(?,?,?,?,?,?)";

	            
			deletescholarprepared = instituteconn.prepareStatement(query1);
			deletescholarprepared.setLong(1, l1);
			deletescholarprepared.setString(2,"Deleted");
			deletescholarprepared.setString(3,scholarBean.getScholarshipid());
			deletescholarprepared.setString(4, scholarBean.getCreatedby());
			deletescholarprepared.setString(5, DateTime.showTime("MySqlWithTime"));
			deletescholarprepared.setString(6,"A");
	 		
	 		
	 		result = deletescholarprepared.executeUpdate();


	 		
	 	}
	 	catch(Exception exception) { 
	 		
	 		exception.printStackTrace();
	 		
	 	}
	 	finally
	 	{
	 		if(deletescholarprepared != null)
	 			deletescholarprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 public int RestoreScholarship(ScholarBean scholarBean) throws SQLException
	 {
	 	log.info("Invoking RestoreCommunity() for Community Restore");
	 	PreparedStatement scholarRestoreprepared  = null;
	 	PreparedStatement instituteprepared = null;


	 	int rs=0;
	 	
	 	int result=0;
	 	
	 	try
	 	{
	     	String scholarid=scholarBean.getScholarshipid();
	     	instituteconn = ConnectionManager.getKycConnection();

	 			String query="update scholarship set scholarshipstatus=?, dateofcreation=?,instituteid=?,createdby=?,ipaddress=?  where scholarshipid=? ";
	 			scholarRestoreprepared = instituteconn.prepareStatement(query);
	 			scholarRestoreprepared.setString(1, "A");
	 			scholarRestoreprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 			scholarRestoreprepared.setString(3, scholarBean.getInstituteid());
	 			scholarRestoreprepared.setString(4, scholarBean.getCreatedby());
	 			scholarRestoreprepared.setString(5, scholarBean.getIpaddress());
	 			scholarRestoreprepared.setString(6,scholarid);

	 		
	 			rs = scholarRestoreprepared.executeUpdate();
	 			
	 			long l1 = common_data_object.fmaxId("select max(scholarcreatelogid)from scholarcreatelog");
				String query1="insert into scholarcreatelog(scholarcreatelogid, logdescription, scholarshipid, createdby, dateofcreation, scholcreatelogstatus) values(?,?,?,?,?,?)";

		            
				scholarRestoreprepared = instituteconn.prepareStatement(query1);
				scholarRestoreprepared.setLong(1, l1);
				scholarRestoreprepared.setString(2,"Restore");
				scholarRestoreprepared.setString(3,scholarBean.getScholarshipid());
				scholarRestoreprepared.setString(4, scholarBean.getCreatedby());
				scholarRestoreprepared.setString(5, DateTime.showTime("MySqlWithTime"));
				scholarRestoreprepared.setString(6,"A");
		 		
		 		
		 		result = scholarRestoreprepared.executeUpdate();
	 			

	 	}catch(Exception exception) { 
	 		
	 		exception.printStackTrace();
	 		
	 	}
	 	finally
	 	{
	 		if(scholarRestoreprepared != null)
	 			scholarRestoreprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 public int ScholarshipDeactivate(ScholarBean scholarBean)  throws SQLException
	 {
	 	log.info("Invoking ScholarshipDeactivate() for List the Deactivate  Scholarship ");
	 	PreparedStatement scholarshipdeactivatelistprepared  = null;
	 	PreparedStatement instituteprepared = null;

	 	int rs=0;
	 	int result=0;
	 	
	 	try
	 	{
	     	String Scholarshipid=scholarBean.getScholarshipid();

	     	instituteconn = ConnectionManager.getKycConnection();

	 		String query="update scholarship set scholarshipstatus=? ,dateofcreation=?,instituteid=?,createdby=?,ipaddress=?  where scholarshipid=? ";
	 		scholarshipdeactivatelistprepared = instituteconn.prepareStatement(query);

	 		scholarshipdeactivatelistprepared.setString(1, "D");
	 		scholarshipdeactivatelistprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	 	  	scholarshipdeactivatelistprepared.setString(3, scholarBean.getInstituteid());
	 		scholarshipdeactivatelistprepared.setString(4, scholarBean.getCreatedby());
	 		scholarshipdeactivatelistprepared.setString(5, scholarBean.getIpaddress());
	 		scholarshipdeactivatelistprepared.setString(6,Scholarshipid);
	 		rs = scholarshipdeactivatelistprepared.executeUpdate();


	 		long l1 = common_data_object.fmaxId("select max(scholarcreatelogid)from scholarcreatelog");
			String query1="insert into scholarcreatelog(scholarcreatelogid, logdescription, scholarshipid, createdby, dateofcreation, scholcreatelogstatus) values(?,?,?,?,?,?)";

	            
			scholarshipdeactivatelistprepared = instituteconn.prepareStatement(query1);
			scholarshipdeactivatelistprepared.setLong(1, l1);
			scholarshipdeactivatelistprepared.setString(2,"Restore");
			scholarshipdeactivatelistprepared.setString(3,scholarBean.getScholarshipid());
			scholarshipdeactivatelistprepared.setString(4, scholarBean.getCreatedby());
			scholarshipdeactivatelistprepared.setString(5, DateTime.showTime("MySqlWithTime"));
			scholarshipdeactivatelistprepared.setString(6,"A");
	         
	 		result = scholarshipdeactivatelistprepared.executeUpdate();

	 		
	 	}
	 	catch(Exception exception) { 
	 		
	 		exception.printStackTrace();
	 		
	 	}
	 	finally
	 	{
	 		if(scholarshipdeactivatelistprepared != null)
	 			scholarshipdeactivatelistprepared.close();
	 		
	 		if(instituteconn != null)
	 			instituteconn.close();
	 	}
	 	return rs;
	 }
	 public ArrayList checkdeactiveScholarship(String instituteid,String scholarshipid)
	 {
	 	log.info("Invoking checkdeactiveScholarship() for checking the scholarship deactivation");
	 	ArrayList list=null;
	 	
	 	try
	 	{
	 		select_query="select scholarcreatelogid,scholarshipid,scholcreatelogstatus from scholarcreatelog where instituteid='"+instituteid+"' and communityid='"+scholarshipid+"' ";
	 		
	 		list=common_data_object.getListMap(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 	}
	 	return list;
	 }
	 public ArrayList DeactivatedScholarshipList(String instituteid)
	 {
	 	log.info("Invoking DeactivatedScholarshipList() for viewing the Scholarship List");
	 	ArrayList list=null;
	 	try
	 	{
	 		select_query="select scholarshipid,instituteid,scholarshipname,scholarshipdescription,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as dateofcreation,scholarshipstatus from scholarship where instituteid='"+instituteid+"' and scholarshipstatus='D'";

	 		list=common_data_object.getListMap(select_query);
	 	}
	 	catch(Exception exception)
	 	{
	 	}
	 	return list;
	 }
	 public ArrayList checkDuplicateScholarshipname(String scholarshipnames,String instituteid)
	 {
	 	log.info("Invoking checkDuplicateReligionname() for checking Duplicate Religion Name ");
	 	ArrayList list=null;
 	
	 	try
	 	{
	 		select_query="select scholarshipid,scholarshipname from scholarship where scholarshipname='"+scholarshipnames+"' and instituteid='"+instituteid+"' and scholarshipstatus<>'X'";
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
	 public int ActivateScholarship(ScholarBean scholarBean) throws SQLException
	 {
	 	log.info("Invoking ActivateScholarship() for Scholarship Activation");
	 	
	 	PreparedStatement activatescholarshipprepared  = null;
	 	PreparedStatement instituteprepared = null;


	 	int rs=0;
	 	
	 	int result=0;
	 	
	 	try
	 	{
	     	String scholarshipid=scholarBean.getScholarshipid();
	     	instituteconn = ConnectionManager.getKycConnection();

	     	String query="update scholarship set scholarshipstatus=? ,dateofcreation=?,instituteid=?,createdby=?,ipaddress=?  where scholarshipid=? ";
	     	activatescholarshipprepared = instituteconn.prepareStatement(query);

	     	activatescholarshipprepared.setString(1, "A");
	     	activatescholarshipprepared.setString(2, DateTime.showTime("MySqlWithTime"));
	     	activatescholarshipprepared.setString(3, scholarBean.getInstituteid());
	     	activatescholarshipprepared.setString(4, scholarBean.getCreatedby());
	     	activatescholarshipprepared.setString(5, scholarBean.getIpaddress());
	     	activatescholarshipprepared.setString(6,scholarshipid);
	 		rs = activatescholarshipprepared.executeUpdate();
	 			
	 		long l1 = common_data_object.fmaxId("select max(scholarcreatelogid)from scholarcreatelog");
			String query1="insert into scholarcreatelog(scholarcreatelogid, logdescription, scholarshipid, createdby, dateofcreation, scholcreatelogstatus) values(?,?,?,?,?,?)";

	            
			activatescholarshipprepared = instituteconn.prepareStatement(query1);
			activatescholarshipprepared.setLong(1, l1);
			activatescholarshipprepared.setString(2,"Active");
			activatescholarshipprepared.setString(3,scholarBean.getScholarshipid());
			activatescholarshipprepared.setString(4, scholarBean.getCreatedby());
			activatescholarshipprepared.setString(5, DateTime.showTime("MySqlWithTime"));
			activatescholarshipprepared.setString(6,"A");
	         
	 			
	 			result = activatescholarshipprepared.executeUpdate();

	 	}catch(Exception exception) { 
	 		
	 		exception.printStackTrace();
	 		
	 	}
	 	finally
	 	{
	 		if(activatescholarshipprepared != null)
	 			activatescholarshipprepared.close();
	 		
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

