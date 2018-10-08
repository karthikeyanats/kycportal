package com.iGrandee.Fees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class FeesHeadQuery   
{
	static Logger log = Logger.getLogger(FeesHeadQuery.class);
	public FeesHeadQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 feesheadConnection      = null;
		 rollbackvalue = 0;
		select_query= "";
	}
	
	
	public int insertFeesHead(FeesHeadBean feesheadBean) throws Exception
	 {
		 	log.info("invoking insertFeesHead for Stanard Fees head Insertion");
		 
		 	int result	= 0;
			PreparedStatement feesheadprepared 	= null;
			PreparedStatement checkprepared 	= null;
			ResultSet checkrs 					= null;

			String currentdate			= DateTime.showTime("MySqlWithTime");
			 try
			 {
				 	feesheadConnection = ConnectionManager.getKycConnection();
					feesheadConnection.setAutoCommit(false);
					
					checkprepared		= feesheadConnection.prepareStatement("select feesheadid from feeshead where feesheadname=? and feesheadstatus<>? and instituteid=?");
					checkprepared.setString(1, feesheadBean.getFeesheadname());
					checkprepared.setString(2, "X");
					checkprepared.setString(3,feesheadBean.getInstituteid());

					
					checkrs				= checkprepared.executeQuery();
					
					if(!checkrs.next()){
					
						String query="select max(feesheadid) from feeshead";
						long feesheadid = common_data_object.maxId(query);
						feesheadid++;
			
						query="insert into feeshead (feesheadid, feesheadname, createdby, instituteid, dateofcreation, feesheadstatus) values(?,?,?,?,?,?)";
						feesheadprepared = feesheadConnection.prepareStatement(query);
						log.info(query);
						
						feesheadprepared.setLong(1, feesheadid);
						feesheadprepared.setString(2,feesheadBean.getFeesheadname());
						feesheadprepared.setString(3,feesheadBean.getCreatedby());
						feesheadprepared.setString(4,feesheadBean.getInstituteid());
						feesheadprepared.setString(5, currentdate);
						feesheadprepared.setString(6,"A");
						result += feesheadprepared.executeUpdate();
					}
					else
						result	= 1000;
					
					if(checkrs != null)
						checkrs.close();
						
					
					feesheadConnection.commit();
		
				 
			 }catch(SQLException e){
				 
					log.error(e);
					result	= 0;
					if(feesheadConnection != null)
						feesheadConnection.rollback();
			 }
			finally
			{
		 
				if(feesheadprepared != null)
					feesheadprepared.close();
			 
				if(checkrs != null)
					checkrs.close();
			
				if(checkprepared != null)
					checkprepared.close();
			
				if(feesheadConnection != null)
					feesheadConnection.close();
			 }
	 return result;
	 }
	
	//subjectid, subjectname, subjecttypeid, subjectypename
	public ArrayList listFeesHead(String instituteid,String feesheadstatus)
    {
        ArrayList arraylist = new ArrayList();
        try
        { 
        	//select_query = "SELECT feesheadid, feesheadname, createdby, instituteid, date_format(dateofcreation,'%d-%m-%Y') as dateofcreation from feeshead where  and institueid='"+instituteid+"' and feesheadstatus='"+feesheadstatus+"'";
        	select_query = "SELECT feesheadid, feesheadname, createdby, instituteid, date_format(dateofcreation,'%d-%b-%Y') as dateofcreation from feeshead where  instituteid='"+instituteid+"' and feesheadstatus='"+feesheadstatus+"' order by dateofcreation desc";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	//update feesheadstatus
	public int updateFeeshead(FeesHeadBean feesheadBean) throws Exception
	 {
		 	log.info("invoking updateLesson for Stanard Lesson Updation");
		 
		 	int result	= 0;
			PreparedStatement feesheadprepared 	= null;
			PreparedStatement checkprepared 	= null;
			ResultSet checkrs 					= null;
			
			//String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	feesheadConnection = ConnectionManager.getKycConnection();
			feesheadConnection.setAutoCommit(false);
			
			String operationstatus = (String)feesheadBean.getFeesoperation();
			if(operationstatus.equals("updatestatus"))
			{
				select_query="update lesson set feesheadstatus=? where feesheadid=?";
				feesheadprepared = feesheadConnection.prepareStatement(select_query);
				feesheadprepared.setString(1,feesheadBean.getFeesheadstatus());
				feesheadprepared.setString(2,feesheadBean.getFeesheadid());
				result += feesheadprepared.executeUpdate();
				feesheadConnection.commit();
				
			}
			else if(operationstatus.equals("updatefeeshead"))
			{
				checkprepared		= feesheadConnection.prepareStatement("select feesheadid from feeshead where feesheadname=? and feesheadstatus<>? and instituteid=? and feesheadid<>?");
				checkprepared.setString(1, feesheadBean.getFeesheadname());
				checkprepared.setString(2, "X");
				checkprepared.setString(3,feesheadBean.getInstituteid());
				checkprepared.setString(4,feesheadBean.getFeesheadid());
				
				checkrs				= checkprepared.executeQuery();
				
				if(!checkrs.next()){
				
					select_query="update feeshead set feesheadname=? where feesheadid=?";
					feesheadprepared = feesheadConnection.prepareStatement(select_query);
					feesheadprepared.setString(1,feesheadBean.getFeesheadname());
					feesheadprepared.setString(2,feesheadBean.getFeesheadid());
					result += feesheadprepared.executeUpdate();
				}
				else
					result	= 1000;
				
				
				if(checkrs != null)
					checkrs.close();
				
				
				feesheadConnection.commit();

					
			}
			else if(operationstatus.equals("feesheadtrash"))
			{
				select_query="update feeshead set feesheadstatus=? where feesheadid=?";
				feesheadprepared = feesheadConnection.prepareStatement(select_query);
				feesheadprepared.setString(1,"T");
				feesheadprepared.setString(2,feesheadBean.getFeesheadid());
				result += feesheadprepared.executeUpdate();
				feesheadConnection.commit();
			}//
			else if(operationstatus.equals("deleteststus"))
			{
				select_query="update feeshead set feesheadstatus=? where feesheadid=?";
				feesheadprepared = feesheadConnection.prepareStatement(select_query);
				feesheadprepared.setString(1,"X");
				feesheadprepared.setString(2,feesheadBean.getFeesheadid());
				result += feesheadprepared.executeUpdate();
				feesheadConnection.commit();
			}
			else if(operationstatus.equals("restoreststus") || operationstatus.equals("activeststus"))
			{
				select_query="update feeshead set feesheadstatus=? where feesheadid=?";
				feesheadprepared = feesheadConnection.prepareStatement(select_query);
				feesheadprepared.setString(1,"A");
				feesheadprepared.setString(2,feesheadBean.getFeesheadid());
				result += feesheadprepared.executeUpdate();
				feesheadConnection.commit();
			}
			else if(operationstatus.equals("feesheaddeactive"))
			{
				select_query="update feeshead set feesheadstatus=? where feesheadid=?";
				feesheadprepared = feesheadConnection.prepareStatement(select_query);
				feesheadprepared.setString(1,"D");
				feesheadprepared.setString(2,feesheadBean.getFeesheadid());
				result += feesheadprepared.executeUpdate();
				feesheadConnection.commit();
			}
		
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(feesheadConnection != null)
				feesheadConnection.rollback();
	 }
	 finally
		{
	 
		 if(feesheadprepared != null)
			feesheadprepared.close();
		 
			if(checkrs != null)
				checkrs.close();
		
			if(checkprepared != null)
				checkprepared.close();
		
		 
		
		 if(feesheadConnection != null)
		 feesheadConnection.close();
		 }
	 return result;
	 }
	
	//load year of session
	
	public ArrayList listYearofSession(String instituteid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "SELECT feesheadid, feesheadname, createdby, instituteid, date_format(dateofcreation,'%d-%m-%Y') as dateofcreation from feeshead where  and institueid='"+instituteid+"' and feesheadstatus='"+feesheadstatus+"'";
        	select_query = "SELECT sessionid, sessionname, instituteid, createdby, dateofcreation, ipaddress, sessionstatus, description  from yearofsession where  instituteid='"+instituteid+"' and sessionstatus='A' order by dateofcreation desc";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public ArrayList loadStandard(String sessionid,String boardid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "SELECT feesheadid, feesheadname, createdby, instituteid, date_format(dateofcreation,'%d-%m-%Y') as dateofcreation from feeshead where  and institueid='"+instituteid+"' and feesheadstatus='"+feesheadstatus+"'";
        	//select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname from standardschedule a,standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' order by a.standardid";
       // 	select_query = "select sum(x1.feesscheduleamount) totalamount,b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname from standardschedule a left outer join feesschedule x1 on x1.standardscheduleid= a.standardscheduleid join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' group by a.standardscheduleid order by a.standardid";
        	select_query = "select sum(x1.feesscheduleamount) totalamount,b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname from standardschedule a left outer join feesschedule x1 on x1.standardscheduleid= a.standardscheduleid join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and standardstatus='A' and stdschedulestatus='A' group by a.standardscheduleid order by a.standardid";
        	
        	//System.out.println(select_query);
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public ArrayList loadFeesHead(String standardscheduleid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {       	
        	//select_query="select c.feesscheduleid,b.feesheadid,b.feesheadname,c.feesscheduleamount from standardschedule a join feeshead b on a.standardscheduleid='"+standardscheduleid+"' and a.instituteid=b.instituteid and b.feesheadstatus='A' left outer join feesschedule c on a.standardscheduleid=c.standardscheduleid and c.feesschedulestatus='A' and b.feesheadid=c.feesheadid order by b.feesheadid";
        	select_query="select c.feesscheduleid,b.feesheadid,b.feesheadname,c.feesscheduleamount,(SELECT count(a1.feescollectionid) FROM feescollection a1,termfees b1 where a1.termfeesid=b1.termfeesid and b1.standardscheduleid='"+standardscheduleid+"') as collectioncount from standardschedule a join feeshead b on a.standardscheduleid='"+standardscheduleid+"' and a.instituteid=b.instituteid and b.feesheadstatus='A' left outer join feesschedule c on a.standardscheduleid=c.standardscheduleid and c.feesschedulestatus='A' and b.feesheadid=c.feesheadid order by b.feesheadid";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	 /**
	   * This method is accessed from kycportal/jsp/masterentries/Fees/checkDuplicate.jsp
	   * check duplicate for feeshead  name           - prasanth
	   @param  feesheadid  that can be used to check duplicate names from examname table by feesheadname ,instituteid,feesheadid wise 
	   *
       @param  instituteid that can be used to check duplicate names from examname table by feesheadname ,instituteid,feesheadid wise
       *
       @param  feesheadname that can be used to check duplicate names from examname table by feesheadname ,instituteid,feesheadid wise
       *
       @return the boolean by which result can be printed on the screen
	 */
	 public boolean checkDuplicateupdate(String feesheadid,String feesheadname,String instituteid)
	    {
	    	boolean return_flag = false;
	    	String return_string = null;
	    	try
	    	{
	        	log.info("duplicate checking fees head from com.iGrandee.Fees.FeesHeadQuery");

	    		String select_query = "SELECT feesheadname FROM feeshead  where feesheadname='"+feesheadname+"' and feesheadstatus='A' and instituteid='"+instituteid+"' and feesheadid <> '"+feesheadid+"' " ;
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
	  * This method is accessed from kycportal/jsp/masterentries/Fees/checkDuplicate.jsp
	  * check duplicate for feesterm  name           - prasanth
	  @param  termid that can be used to check duplicate names from feestermname table by termname ,instituteid,termid wise 
	  *
      @param termname that can be used to check duplicate names from feestermname table by termname ,instituteid,termid wise 
      *
      @param instituteid that can be used to check duplicate names from feestermname table by termname ,instituteid,termid wise 
      *
      @param that can be used to check duplicate names from feestermname table by termname ,instituteid,termid wise 
      *
      @return the boolean by which result can be printed on the screen
	 */
	 public boolean checkDuplicateupdateFeesTerm(String termid,String termname,String instituteid)
	    {
	    	boolean return_flag = false;
	    	String return_string = null;
	    	try
	    	{
	    		log.info("duplicate checking fees term from com.iGrandee.Fees.FeesHeadQuery");
	    		String select_query = "SELECT termname FROM feestermname  where termname='"+termname+"' and instituteid='"+instituteid+"' and termstatus='A' and  termid <> '"+termid+"' " ;
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
	 Connection feesheadConnection;
	 int rollbackvalue;
}