package com.iGrandee.MasterEntries.Standard;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;       

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Fees.Allotmentbean;
import com.iGrandee.Fees.Scholarshipamountallocationbean;
import com.iGrandee.TransportFees.FeesSettings;

import org.apache.log4j.Logger;
public class StandardQuery
{
	static Logger log = Logger.getLogger(StandardQuery.class);

	public  StandardQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 standardconnection      = null;
		 rollbackvalue = 0;
		select_query= "";
	}

	 public ArrayList listStandardList(String instituteid,String boardid,String stdstate)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
	           // select_query = "select a.standardid, a.standardname,c.boardid,c.boardname,d.mediumname,d.mediumid,date_format(a.dateofcreation,'%d-%M-%Y') as stdcreateddate from standard a,standardlog b,board c, standardmedium d where a.standardid=b.standardid and a.standardstatus='A' and a.mediumid=d.mediumid and c.boardid=d.boardid and a.instituteid='"+instituteid+"' order by a.standardid,c.boardid,d.mediumid;";
	        	//select_query = "select a.standardid,a.standardname,a.groupstatus,date_format(a.dateofcreation,'%d-%m-%Y') as dateofcreation,b.boardid,b.boardname,c.mediumid,c.mediumname from standard a,board b,standardmedium c where a.instituteid='"+instituteid+"' and a.boardid=b.boardid and b.mediumid=c.mediumid and b.boardstatus='A' and a.standardstatus='A' and c.mediumstatus='A' and b.boardid='"+boardid+"'";
	        	
	        	if(stdstate.equals("A"))
	        	{
	        	select_query = "select a.standardid,a.standardname,a.description,a.groupstatus,date_format(a.dateofcreation,'%d-%b-%Y') as dateofcreation from standard a where a.instituteid='"+instituteid+"' and a.standardstatus='A' and a.boardid='"+boardid+"';";
	          log.info(select_query);
	        	arraylist = common_data_object.getListMap(select_query);
	        	}
	        	else if(stdstate.equals("T"))
	        	{
	        		select_query = "select a.standardid,a.standardname,a.description,a.groupstatus,date_format(a.dateofcreation,'%d-%b-%Y') as dateofcreation from standard a where a.instituteid='"+instituteid+"' and a.standardstatus='T' and a.boardid='"+boardid+"';";
	  	          log.info(select_query);
	  	        	arraylist = common_data_object.getListMap(select_query);
	        	}
	        }
	        catch(Exception exception) { }
	        return arraylist;
		}
	 
	 
		 public ArrayList getStandards(String scholarshipid, String sessionid, String boardid)
		 {
		    	log.info("invoking getStandards(String scholarshipid, String sessionid, String boardid)");
				ArrayList list=null;
			
				try
				{
					
					select_query="select b.standardscheduleid, concat(a.standardname,case when b.groupid is null then '' else (select concat(' - ',groupname) from standardgroup where groupid=b.groupid and groupstatus='A') end) as standardname, e.scholarshipid, e.amount, e.termfeesid from standard a join standardschedule b on b.sessionid='"+sessionid+"' and a.boardid='"+boardid+"' and a.standardid=b.standardid and a.standardstatus='A' and b.stdschedulestatus='A' left outer join scholarshipamountallocation e on b.standardscheduleid=e.standardscheduleid and e.amountallocationstatus='A' and e.scholarshipid='"+scholarshipid+"'";
					list=common_data_object.getListMap(select_query);
					
				}
				catch(Exception exception)
				{ 
					log.error(exception);					
				}
		    	return list;
		 }
		 
		 public ArrayList getScheduledStandards(String sessionid, String boardid)
		 {
		    	
				ArrayList list=null;
			try
				{
					select_query="select b.standardscheduleid,concat(a.standardname,case when b.groupid is null then '' else (select concat(' - ',groupname) from  standardgroup where groupid=b.groupid and groupstatus='A') end) as standardname  from standard a join standardschedule b on b.sessionid='"+sessionid+"' and a.boardid='"+boardid+"'	  and a.standardid=b.standardid and a.standardstatus='A' and b.stdschedulestatus='A'";
					list=common_data_object.getListMap(select_query);
					
				}
				catch(Exception exception)
				{ 
exception.printStackTrace();
}
		    	return list;
		 }		 
		 
		 
		 public ArrayList getStandardTerms(String standardscheduleid)
		 {
		    	log.info("invoking getStandardTerms(String standardscheduleid)");
				ArrayList list=null;
			
				try
				{
					
					select_query	= "select d.termname, c.termfeesamount,c.termfeesid from termfees c, feestermname d where c.standardscheduleid='"+standardscheduleid+"' and c.termfeesstatus='A' and c.termid=d.termid and d.termstatus='A'";
					list			= common_data_object.getListMap(select_query);
					
				}
				catch(Exception exception)
				{ 
					log.error(exception);					
				}
		    	return list;
		 }
		 public ArrayList getStandardwiseTerms(String standardscheduleid,String feesstate,String scholarshipid)
		 {
		    	log.info("invoking getStandardTerms(String standardscheduleid)");
				ArrayList list=null;
			
				try
				{
					//hidden by rams, because, not take the schemeforstudentid
					//select_query="select a.termfeesid,b.termname,c.scholarshipamountallocationid,c.amount,a.termfeesamount from feestermname b,termfees a left outer join scholarshipamountallocation c on a.termfeesid=c.termfeesid and scholarshipid='"+scholarshipid+"' where a.standardscheduleid='"+standardscheduleid+"' and a.termid=b.termid  and termstatus='A' and termfeesstatus='A'";
					select_query ="select a.termfeesid,b.termname,c.scholarshipamountallocationid,c.amount,a.termfeesamount, d.schemeforstudentid from feestermname b,termfees a left outer join scholarshipamountallocation c on a.termfeesid=c.termfeesid and scholarshipid='"+scholarshipid+"' left outer join scholarshipforstudent d on c.scholarshipamountallocationid=d.scholarshipamountallocationid where a.standardscheduleid='"+standardscheduleid+"'  and a.termid=b.termid  and termstatus='A' and termfeesstatus='A' group by a.termfeesid";
				//	System.out.println(select_query);
					list			= common_data_object.getListMap(select_query);
					/*if(feesstate.equals("allocate"))
					{
					
					select_query	= "select d.termname, c.termfeesamount,c.termfeesid from termfees c, feestermname d where c.standardscheduleid='"+standardscheduleid+"' and c.termfeesstatus='A' and c.termid=d.termid and d.termstatus='A'";
					list			= common_data_object.getListMap(select_query);
					select_query	= "select c.termname,b.termfeesamount,scholarshipamountallocationid from scholarshipamountallocation a,termfees b,feestermname c where scholarshipid='"+scholarshipid+"' and a.standardscheduleid='"+standardscheduleid+"' and c.termstatus='A' and b.termid=c.termid and a.termfeesid=b.termfeesid";
					}
					else if(feesstate.equals("deallocate"))
					{
					
					select_query	= "select c.termname,b.termfeesamount,scholarshipamountallocationid from scholarshipamountallocation a,termfees b,feestermname c where scholarshipid='"+scholarshipid+"' and a.standardscheduleid='"+standardscheduleid+"' and c.termstatus='A' and b.termid=c.termid and a.termfeesid=b.termfeesid";
					list			= common_data_object.getListMap(select_query);
					}*/
					
				}
				catch(Exception exception)
				{ 
					log.error(exception);					
				}
		    	return list;
		 }
		
		 
		 
	 
	 public ArrayList geteditStandards(String scholarshipid,String sessionid)
	    {
	    	log.info("invoking get_All_AcademicSessions from com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry");
			ArrayList list=null;
 			
			try
			{ 
				
				select_query="select  x.scholarshipamountallocationid,c.standardname,(select groupname from standardgroup d where a.groupid=d.groupid and groupstatus='A')" +
" as groupname,a.standardscheduleid,b.scholarshipamountallocationid,b.amount from standard c,standardschedule a left outer join scholarshipamountallocation b " +
"on a.standardscheduleid=b.standardscheduleid and b.scholarshipid='"+scholarshipid+"',scholarshipamountallocation v left outer join scholarshipforstudent x on  v.scholarshipamountallocationid=x.scholarshipamountallocationid " +
"where a.sessionid='"+sessionid+"' and a.standardid=c.standardid and c.standardstatus='A' and a.stdschedulestatus='A' and b.amount!='null' group by b.scholarshipamountallocationid";
				//System.out.println("select_query>>>editS>>"+select_query);
				list=common_data_object.getListMap(select_query);
				
					
			}
			catch(Exception exception)
			{ 
					
				log.error(exception);					
				}
		    	finally
				{
					
				}
		    	return list;
		    }
	    
	 /**
	   *  get board name for pdf creation (Access by prasanth)
	   @param instituteid that can be used to get board name  from standardboard table by instituteid  wise
	   *
	   @return the ArrayList by which result can be printed on the screen
	 */

	 
	 public String loadstandardamount(String standardscheduleid){
		 String query="";
		 String result="";
		 
		 try{
			 query="select amount from scholarshipamountallocation where standardscheduleid='"+standardscheduleid+"'";
			 result= common_data_object.getString(query);
			// System.out.println("result>>>query>>."+query);
		 }
		 
		 
		 catch(Exception e){
			 
			 e.printStackTrace();
		 }
		 
		 return result;
	 }
	 
	 
	 public ArrayList listBoard(String instituteid)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
	         //   select_query = "select a.boardid, a.boardname from board a where  a.instituteid='"+instituteid+"' and a.boardstatus='A'";
	            select_query = "select a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b where a.mediumid=b.mediumid and a.instituteid='"+instituteid+"' and a.boardstatus='A' and b.mediumstatus='A' order by a.boardid,b.mediumid";
	           log.info(select_query);
	            arraylist = common_data_object.getListMap(select_query);
	        }
	        catch(Exception exception) { }
	        return arraylist;
		}
		 public ArrayList loadStandardStatusforUpdate(String reqstandardid,String state)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
	        	if(state.equals("subject"))
	        	{
	            select_query = "select * from subject where standardid='"+reqstandardid+"' and subjectstatus!='X'";
	            arraylist = common_data_object.getListMap(select_query);
	        	}
	        	else if(state.equals("schedule"))
	        	{
	        		select_query = "select * from standardschedule where groupid='"+reqstandardid+"' and stdschedulestatus!='X'";
		            arraylist = common_data_object.getListMap(select_query);
	        	}
	        }
	        catch(Exception exception) { }
	        return arraylist;
		}
	
	  //load standard details for edit purpose
	 public ArrayList loadStandardDetails(String reqstandardid)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
	            select_query = "select a.standardid,a.standardname,a.description,a.groupstatus,a.boardid,b.boardname,c.mediumname from standard a,board b,standardmedium c where a.standardid='"+reqstandardid+"' and a.boardid=b.boardid and b.boardstatus='A' and c.mediumid=b.mediumid and c.mediumstatus='A'";
	            arraylist = common_data_object.getListMap(select_query);
	        }
	        catch(Exception exception) { }
	        return arraylist;
		}
	 
	  
	  
	 public int insertStandard(StandardBean standardBean) throws Exception
	 {
		 	log.info("invoking insertStandard for Stanard Insertion");
		 
		 	int result					= 0;
			PreparedStatement standprepared = null;
			PreparedStatement standardlog = null;
			
			long regid					= 0l;
			String currentdate			= DateTime.showTime("MySqlWithTime");
			String querytoexecute		= null;
			ResultSet regidresult		= null;
			long standardlogid			= 0l;
	 try
	 {
		 standardconnection = ConnectionManager.getKycConnection();
			standardconnection.setAutoCommit(false);
			
			String query="select max(standardid) from standard";
			long standardid = common_data_object.maxId(query);
			standardid++;
			boolean return_flag=false;
			String select_query = "SELECT standardname FROM standard  where standardname='"+standardBean.getStandardname()+"' and instituteid='"+standardBean.getInstituteid()+"' and standardstatus='A' and boardid='"+standardBean.getBoardid()+"'" ;
    		String return_string = common_data_object.getString(select_query);
    		if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
    			return_flag = true;
    		}
    		else
    		{
    			return_flag = false;
    		}
			if(return_flag)
			{
					query="insert into standard (standardid, standardname, description, instituteid, groupstatus, createdby, dateofcreation, ipaddress, standardstatus, boardid) values(?,?,?,?,?,?,?,?,?,?)";
					standprepared = standardconnection.prepareStatement(query);
					standprepared.setLong(1, standardid);
					standprepared.setString(2,standardBean.getStandardname());
					standprepared.setString(3,standardBean.getDescription());
					standprepared.setString(4,standardBean.getInstituteid());
					standprepared.setString(5,standardBean.getGroupstatus());
					standprepared.setString(6,standardBean.getCreatedby());
					standprepared.setString(7, currentdate);
					standprepared.setString(8,standardBean.getIpaddress());
					standprepared.setString(9,"A");
					standprepared.setString(10,standardBean.getBoardid());
					result += standprepared.executeUpdate();
					
					
					querytoexecute		= "select max(stdlogid) from standardlog";
					standardlog			= standardconnection.prepareStatement(querytoexecute);
					regidresult			= standardlog.executeQuery();
					
					if(regidresult.next()){
						standardlogid	= regidresult.getLong(1);
					}
					
					standardlogid++;
					
					querytoexecute		= "insert into standardlog(stdlogid, logdescription, standardid, createdby, dateofcreation, stdlogstatus) values(?,?,?,?,?,?)";
					standardlog				= standardconnection.prepareStatement(querytoexecute);
					
					standardlog.setLong(1, standardlogid);
					standardlog.setString(2,"Created");
					standardlog.setLong(3,standardid);
					standardlog.setString(4, standardBean.getCreatedby());
					standardlog.setString(5, currentdate);
					standardlog.setString(6,"A");
					
					result += standardlog.executeUpdate();
			}
			else
			{
				result =1000;
			}
			
			
			
			standardconnection.commit();

		 
	 }catch(SQLException e){
		 
		 //System.out.println("THe problem is here...");
			log.error(e);
			result	= 0;
			if(standardconnection != null)
				standardconnection.rollback();
	 }
	 finally
		{
		 if(regidresult != null)
			 regidresult.close();
		 
		 if(standprepared != null)
			standprepared.close();
		 if(standardlog != null)
			standardlog.close();
		 if(standardconnection != null)
		 standardconnection.close();
		 }
	 return result;
	 }
	 public int updatescholarshipamountallocation(Scholarshipamountallocationbean bean) throws Exception{
			
			int result=0;
			int result1=0;
			PreparedStatement updatestmt = null;
			PreparedStatement updatestmt1 = null;
			//ResultSet checkrs 					= null;
			//PreparedStatement checkprepared 	= null;

			try {
				standardconnection= ConnectionManager.getKycConnection(); 
				standardconnection.setAutoCommit(false);
				String currentdate			= DateTime.showTime("MySqlWithTime");
					
				
				String query					= "update scholarshipamountallocation set amount=? where scholarshipamountallocationid=?";
				updatestmt				= standardconnection.prepareStatement(query);
				
				String query1					= "update feescollection set collectionamount=? where termfeesid=?";
				updatestmt1				= standardconnection.prepareStatement(query1);
				
				
				updatestmt.setString(1, bean.getAmount());
				updatestmt.setString(2, bean.getScholarshipamountallocationid());
				//System.out.println("updatestmt>>>>>>>>>>>"+updatestmt);
				result = updatestmt.executeUpdate();
				
				updatestmt1.setString(1, bean.getAmount());
				updatestmt1.setString(2, bean.getTermfeesid());
				//System.out.println("updatestmt>>>>>>>>>>>"+updatestmt1);
				result1 = updatestmt1.executeUpdate();
				
				
				
				
					

			
				standardconnection.commit();
			}	
				catch (SQLException e) {
				
				e.printStackTrace();
				result	= 0;
				if(standardconnection!=null){
					
					standardconnection.rollback();
				}
			}
			 finally
				{
				 
				 
				 if(updatestmt1 != null)
					 updatestmt1.close();
				
				 if(updatestmt != null)
					 updatestmt.close();
				 
				 if(standardconnection != null)
					 standardconnection.close();
				 }
			
			return result;
		}
	 
	 
	 public int insertscholarshipallotment(Scholarshipamountallocationbean bean) throws Exception{
			
			int result=0;
			PreparedStatement scholarprepared = null;
			ResultSet checkrs 					= null;
			PreparedStatement checkprepared 	= null;

			try {
				standardconnection= ConnectionManager.getKycConnection(); 
				standardconnection.setAutoCommit(false);
				String currentdate			= DateTime.showTime("MySqlWithTime");
					
				
				String query="select max(scholarshipamountallocationid) from scholarshipamountallocation";
				long scholarshipamountallocationid = common_data_object.maxId(query);
				scholarshipamountallocationid++;

				query="insert into scholarshipamountallocation(scholarshipamountallocationid, standardscheduleid, scholarshipid, amount, createdby, dateofcreation, amountallocationstatus, termfeesid) values (?, ?, ?, ?, ?, ?, ?, ?)";
				
				scholarprepared = standardconnection.prepareStatement(query);
				scholarprepared.setLong(1, scholarshipamountallocationid);
				scholarprepared.setString(2,bean.getStandardscheduleid()); 
				scholarprepared.setString(3,bean.getScholarshipid());
				scholarprepared.setString(4,bean.getAmount());
				scholarprepared.setString(5,bean.getCreatedby());
				scholarprepared.setString(6,currentdate);
				scholarprepared.setString(7,bean.getSetAmountallocationstatus());
				scholarprepared.setString(8,bean.getTermfeesid());
				//System.out.println("scholarprepared>>>>>>>>>>>"+scholarprepared);

				result += scholarprepared.executeUpdate();
					

			
				standardconnection.commit();
			}	
				catch (SQLException e) {
				
				e.printStackTrace();
				result	= 0;
				if(standardconnection!=null){
					
					standardconnection.rollback();
				}
			}
			 finally
				{
			 
				 if(scholarprepared != null)
					 scholarprepared.close();
				 
				 if(standardconnection != null)
					 standardconnection.close();
				 }
			
			return result;
		}
	 

	/*public int insertscholarshipallotmentold(Allotmentbean bean) throws SQLException{
		
		int result						= 0;
		
		PreparedStatement maxstmt		= null; 
		ResultSet maxrs					= null; 
		
		PreparedStatement checkstmt		= null;
		ResultSet checkrs				= null; 
		
		PreparedStatement addstmt		= null;
		
		PreparedStatement updatestmt	= null;
		
		String query					= null;
		long allocationid				= 0l;
		
		
		try{
		
			String currentdate		= DateTime.showTime("MySqlWithTime");
			standardconnection 		= ConnectionManager.getKycConnection();
			standardconnection.setAutoCommit(false);
			
			
			query					= "select max(scholarshipamountallocationid) from scholarshipamountallocation";
			maxstmt					= standardconnection.prepareStatement(query);
			maxrs					= maxstmt.executeQuery();
			
			if(maxrs.next())
				allocationid		= maxrs.getLong(1);
			
			allocationid++;
			
			//query					= "select scholarshipamountallocationid from scholarshipamountallocation where standardscheduleid=? and scholarshipid=? and amountallocationstatus='A'";
			query					= "select scholarshipamountallocationid from scholarshipamountallocation where standardscheduleid=? and scholarshipid=? and termfeesid=?  and amountallocationstatus='A'";
			checkstmt				= standardconnection.prepareStatement(query);

			
			query					= "insert into scholarshipamountallocation(scholarshipamountallocationid, standardscheduleid, scholarshipid, amount, createdby, dateofcreation, amountallocationstatus, termfeesid) values (?, ?, ?, ?, ?, ?, ?, ?)";
			addstmt					= standardconnection.prepareStatement(query);
			
			
			//query					= "update scholarshipamountallocation set amount=?, termfeesid=? where scholarshipamountallocationid=? and scholarshipamountallocationid not in(select scholarshipamountallocationid from scholarshipforstudent where scholarshipforstudentstatus='A')";
			query					= "update scholarshipamountallocation set amount=?, termfeesid=? where scholarshipamountallocationid=?";
			updatestmt				= standardconnection.prepareStatement(query);

			if(bean.getStandardscheduleid() != null && bean.getStandardscheduleid().length>0)
			for(int y=0;y<bean.getStandardscheduleid().length;y++){
				
				checkstmt.setString(1, bean.getStandardscheduleid()[y]);
				checkstmt.setString(2, bean.getScholarshipid());
				checkstmt.setString(3, bean.getTermfeesid()[y]);
				
				System.out.println("checkstmt"+checkstmt);
				
				checkrs				= checkstmt.executeQuery();
				
				if(!checkrs.next()){
					
					addstmt.setLong(1, allocationid);
					addstmt.setString(2, bean.getStandardscheduleid()[y]);
					addstmt.setString(3, bean.getScholarshipid());
					addstmt.setString(4, bean.getAmount()[y]);	
					addstmt.setString(5, bean.getCreatedby());
					addstmt.setString(6, currentdate);
					addstmt.setString(7, bean.getAmountallocationstatus());
					addstmt.setString(8, bean.getTermfeesid()[y]);
					
					
					addstmt.addBatch();
					
					allocationid++;
					
				}else{
					
					updatestmt.setString(1, bean.getAmount()[y]);
					updatestmt.setString(2, bean.getTermfeesid()[y]);
					updatestmt.setLong(3, checkrs.getLong(1));
					updatestmt.addBatch();
					System.out.println("updatestmt>>>>"+updatestmt);

				}
			}
			
			int temp[]		= addstmt.executeBatch();
			
			if(temp != null && temp.length>0)
			for(int y=0;y<temp.length;y++)
				result		+= temp[y];
			
			temp			= updatestmt.executeBatch();
			
			if(temp != null && temp.length>0)
			for(int y=0;y<temp.length;y++)
				result		+= temp[y];
			
			
			standardconnection.commit();
		}
		
		catch (Exception e) {
			
			e.printStackTrace();
			
			result	= 0;
			
			if(standardconnection != null)
				standardconnection.rollback(); 
		}
		finally{
			
			
			if(maxrs != null)
				maxrs.close(); 

			if(maxstmt != null)
				maxstmt.close(); 

			if(checkrs != null)
				checkrs.close(); 

			if(checkstmt != null)
				checkstmt.close(); 

			if(addstmt != null)
				addstmt.close(); 
			
			if(updatestmt != null)
				updatestmt.close(); 
			
			if(standardconnection != null)
				standardconnection.close(); 
			
		}
		return result;
	}
	 */
	
	 
	 
	 public int updateStandard(StandardBean standardBean) throws Exception
	 {
		 	log.info("invoking updateStandard for Stanard  Updation");
		 
		 	int result	= 0;
			PreparedStatement stanardprepared = null;
			//String currentdate = DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	standardconnection = ConnectionManager.getKycConnection();
			standardconnection.setAutoCommit(false);
			if(!checkDuplicateupdate(standardBean.getStandardname(), standardBean.getStandardid(), standardBean.getBoardid(), standardBean.getInstituteid()))
			{
				log.info(standardBean.getStandardname());
				log.info(standardBean.getDescription());
				log.info(standardBean.getGroupstatus());
				log.info(standardBean.getBoardid());
				log.info(standardBean.getStandardid());
				select_query="update standard set standardname=?,description=?,groupstatus=?,boardid=? where standardid=?";
				log.info(select_query);
				stanardprepared = standardconnection.prepareStatement(select_query);
				stanardprepared.setString(1,standardBean.getStandardname());
				stanardprepared.setString(2, standardBean.getDescription());
				stanardprepared.setString(3, standardBean.getGroupstatus());
				stanardprepared.setString(4, standardBean.getBoardid());
				stanardprepared.setString(5, standardBean.getStandardid());
				result += stanardprepared.executeUpdate();
			}
			else
			{
				result=1000;
			}
			
			standardconnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(standardconnection != null)
				standardconnection.rollback();
	 }
	 finally
		{
	 
		 if(stanardprepared != null)
			stanardprepared.close();
		
		 if(standardconnection != null)
		 standardconnection.close();
		 }
	 return result;
	 }
	
	public int updateStandardStatus(StandardBean standardBean) throws Exception
	 {
		 	log.info("invoking updateStandardStatus for Stanard Status");
		 
		 	int result	= 0;
			PreparedStatement stanardprepared = null;
			
	 try
	 {
		 	standardconnection = ConnectionManager.getKycConnection();
			standardconnection.setAutoCommit(false);
			
			
			select_query="update standard set standardstatus=? where standardid=?";
			stanardprepared = standardconnection.prepareStatement(select_query);
			stanardprepared.setString(1,standardBean.getStandardstatus());
			stanardprepared.setString(2,standardBean.getStandardid());
			result += stanardprepared.executeUpdate();
			
			standardconnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(standardconnection != null)
				standardconnection.rollback();
	 }
	 finally
		{
	 
		 if(stanardprepared != null)
			stanardprepared.close();
		
		 if(standardconnection != null)
		 standardconnection.close();
		 }
	 return result;
	 }
	 /**
	  * This method is accessed from kycportal/jsp/masterentries/standard/checkDuplicate.jsp
	  * check duplicate standards    (update screen)      - prasanth
	   @param  standardname  that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
	   *
	   @param standardid that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
	   *
	   @param boardid that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
	   *
	   @param instituteid that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
	   *
	   @return the boolean by which result can be printed on the screen
	 */
	 public boolean checkDuplicateupdate(String standardname,String standardid,String boardid,String instituteid)
	    {
	    	boolean return_flag = false;
	    	String return_string = null;
	    	try
	    	{
	    		log.info("invoke standard checkDuplicateentry update screen from com.iGrandee.MasterEntries.Standard.StandardQuery");

	    		String select_query = "SELECT standardname FROM standard  where standardname='"+standardname+"' and instituteid='"+instituteid+"' and standardstatus='A' and boardid='"+boardid+"'  and standardid <> '"+standardid+"' " ;
	    		return_string = common_data_object.getString(select_query);
	    		if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
	    			return_flag = false;
	    		}
	    		else
	    		{
	    			return_flag = true;
	    		}
	    	}
	    	catch(Exception e)
	    	{
	    		log.error(e);	
	    	}
	    	return return_flag;
	    }
	 /**
	  * This method is accessed from kycportal/jsp/masterentries/standard/checkDuplicate.jsp
	  * check duplicate standards    (entry screen)      - prasanth
	    @param  standardname that can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
	    *
	    @param  boardid hat can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
	    *
	    @param  instituteid hat can be used to check duplicate names from standard table by instituteid,standardname,boardid wise
	    *
	    @return the boolean by which result can be printed on the screen
	 */
	 public boolean checkDuplicateentry(String standardname,String boardid,String instituteid)
	    {
	    	boolean return_flag = false;
	    	String return_string = null;
	    	try
	    	{
	    		log.info("invoke standard checkDuplicateentry from com.iGrandee.MasterEntries.Standard.StandardQuery");
	    		String select_query = "SELECT standardname FROM standard  where standardname='"+standardname+"' and instituteid='"+instituteid+"' and standardstatus='A' and boardid='"+boardid+"'   and standardstatus <> 'X' " ;
	    		return_string = common_data_object.getString(select_query);
	    		if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
	    			return_flag = false;
	    		}
	    		else
	    		{
	    			return_flag = true;
	    		}
	    	}
	    	catch(Exception e)
	    	{
	    		log.error(e);	
	    	}
	    	return return_flag;
	    }
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection standardconnection;
	 int rollbackvalue;
}
