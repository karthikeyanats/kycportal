package com.iGrandee.Fees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

import org.apache.log4j.Logger;

public class FeesTermQuery
{
	static Logger log = Logger.getLogger(FeesTermQuery.class);
	public FeesTermQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 feestermConnection      = null;
		 rollbackvalue = 0;
		select_query= "";
	}
	
	
	public int insertFeesTerm(FeesTermBean feestermBean) throws Exception
	 {
		 	log.info("invoking insertFeesHead for Stanard Fees head Insertion");
		 
		 	int result							= 0;
			PreparedStatement feestermprepared 	= null;
			String currentdate					= DateTime.showTime("MySqlWithTime");
			PreparedStatement checkprepared 	= null;
			ResultSet checkrs 					= null;

	 try
	 {
		 	feestermConnection = ConnectionManager.getKycConnection();
			feestermConnection.setAutoCommit(false);
			
			checkprepared			= feestermConnection.prepareStatement("select termid from feestermname where termname=? and termstatus<>? and instituteid=?");
			checkprepared.setString(1, feestermBean.getTermname());
			checkprepared.setString(2, "X");
			checkprepared.setString(3,feestermBean.getInstituteid());

			
			checkrs				= checkprepared.executeQuery();
			
			if(!checkrs.next()){
			
			
				String query="select max(termid) from feestermname";
				long feestermid = common_data_object.maxId(query);
				feestermid++;
				query="insert into feestermname (termid, termname, description, createdby, instituteid, termcreationdate, termstatus) values(?,?,?,?,?,?,?)";
				feestermprepared = feestermConnection.prepareStatement(query);
				feestermprepared.setLong(1, feestermid);
				feestermprepared.setString(2,feestermBean.getTermname());
				feestermprepared.setString(3,feestermBean.getDescription());
				feestermprepared.setString(4,feestermBean.getCreatedby());
				feestermprepared.setString(5,feestermBean.getInstituteid());
				feestermprepared.setString(6, currentdate);
				feestermprepared.setString(7,"A");
				result += feestermprepared.executeUpdate();
			}
			else
				result	= 1000;
			
			if(checkrs != null)
				checkrs.close();
			
			
			feestermConnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(feestermConnection != null)
				feestermConnection.rollback();
	 }
	 finally
		{
	 
		 if(feestermprepared != null)
			feestermprepared.close();
		 
			if(checkrs != null)
				checkrs.close();
		
			if(checkprepared != null)
				checkprepared.close();
		 
		
		 if(feestermConnection != null)
		 feestermConnection.close();
		 }
	 return result;
	 }
	
	//subjectid, subjectname, subjecttypeid, subjectypename
	public ArrayList listFeesTerm(String instituteid,String feesheadstatus)
    {
        ArrayList arraylist = new ArrayList();
        try
        {//termid, termname, description, createdby, instituteid, termcreationdate, termstatus
        	select_query = "SELECT termid, termname, description, createdby, instituteid, date_format(termcreationdate,'%d-%b-%Y') as termcreationdate from feestermname where  instituteid='"+instituteid+"' and termstatus='"+feesheadstatus+"' order by termcreationdate desc";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	//update feesterm
	public int updateFeesterm(FeesTermBean feestermBean) throws Exception
	 {
		 	log.info("invoking updateFeesterm for  updateFeesterm");
		 
		 	int result							= 0;
			PreparedStatement feestermprepared 	= null;
			PreparedStatement checkprepared 	= null;
			ResultSet checkrs 					= null;
			
	 try
	 {
		 	feestermConnection = ConnectionManager.getKycConnection();
			feestermConnection.setAutoCommit(false);
			
			String operationstatus = (String)feestermBean.getFeesoperation();
			if(operationstatus.equals("updatestatus"))
			{
				select_query="update feestermname set termstatus=? where termid=?";
				feestermprepared = feestermConnection.prepareStatement(select_query);
				feestermprepared.setString(1,"T");
				feestermprepared.setString(2,feestermBean.getFeestermid());
				result += feestermprepared.executeUpdate();
				feestermConnection.commit(); 
				
			}
			else if(operationstatus.equals("updatefeesterm"))
			{
				checkprepared		= feestermConnection.prepareStatement("select termid from feestermname where termname=? and termstatus<>? and instituteid=? and termid<>?");
				checkprepared.setString(1, feestermBean.getTermname());
				checkprepared.setString(2, "X");
				checkprepared.setString(3,feestermBean.getInstituteid());
				checkprepared.setString(4,feestermBean.getFeestermid());
				
				checkrs				= checkprepared.executeQuery();
				
				if(!checkrs.next()){
				
					select_query="update feestermname set termname=? where termid=?";
					feestermprepared = feestermConnection.prepareStatement(select_query);
					feestermprepared.setString(1,feestermBean.getTermname());
					feestermprepared.setString(2,feestermBean.getFeestermid());
					result += feestermprepared.executeUpdate();
				}
				else
					result	= 1000;
				
				if(checkrs != null)
					checkrs.close();
				
				feestermConnection.commit();
				
				
					
			}
			else if(operationstatus.equals("deleteststus"))
			{
				select_query="update feestermname set termstatus=? where termid=?";
				feestermprepared = feestermConnection.prepareStatement(select_query);
				feestermprepared.setString(1,"X");
				feestermprepared.setString(2,feestermBean.getFeestermid());
				result += feestermprepared.executeUpdate();
				feestermConnection.commit();
			}  
			else if(operationstatus.equals("restoreststus") || operationstatus.equals("activeststus"))
			{
				select_query="update feestermname set termstatus=? where termid=?";
				feestermprepared = feestermConnection.prepareStatement(select_query);
				feestermprepared.setString(1,"A");  
				feestermprepared.setString(2,feestermBean.getFeestermid());
				result += feestermprepared.executeUpdate();
				feestermConnection.commit();
			}     
			else if(operationstatus.equals("deactiveststus"))
			{
				select_query="update feestermname set termstatus=? where termid=?";
				feestermprepared = feestermConnection.prepareStatement(select_query);
				feestermprepared.setString(1,"D");  
				feestermprepared.setString(2,feestermBean.getFeestermid());
				result += feestermprepared.executeUpdate();
				feestermConnection.commit();
			}     
		
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(feestermConnection != null)
				feestermConnection.rollback();
	 }
	 finally
		{
	 
		 if(feestermprepared != null)
			feestermprepared.close();
			
		 	if(checkrs != null)
				checkrs.close();
		
			if(checkprepared != null)
				checkprepared.close();
			
		 if(feestermConnection != null)
		 feestermConnection.close();
		 }
	 return result;
	 }
	
	//load year of session
	
	/*public ArrayList listYearofSession(String instituteid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "SELECT feestermid, feesheadname, createdby, instituteid, date_format(dateofcreation,'%d-%m-%Y') as dateofcreation from feeshead where  and institueid='"+instituteid+"' and feesheadstatus='"+feesheadstatus+"'";
        	select_query = "SELECT sessionid, sessionname, instituteid, createdby, dateofcreation, ipaddress, sessionstatus, description  from yearofsession where  instituteid='"+instituteid+"' and sessionstatus='A'";
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
        	//select_query = "SELECT feestermid, feesheadname, createdby, instituteid, date_format(dateofcreation,'%d-%m-%Y') as dateofcreation from feeshead where  and institueid='"+instituteid+"' and feesheadstatus='"+feesheadstatus+"'";
        	//select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname from standardschedule a,standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' order by a.standardid";
        	select_query = "select sum(x1.feesscheduleamount) totalamount,b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname from standardschedule a left outer join feesschedule x1 on x1.standardscheduleid= a.standardscheduleid join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' group by a.standardscheduleid order by a.standardid";
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
        	//select_query = "SELECT feestermid, feesheadname, createdby, instituteid, date_format(dateofcreation,'%d-%m-%Y') as dateofcreation from feeshead where  and institueid='"+instituteid+"' and feesheadstatus='"+feesheadstatus+"'";
        	select_query = "select a.feesscheduleid,b.feestermid,b.feesheadname,a.feesscheduleamount from feesschedule a join  standardschedule c on a.standardscheduleid=c.standardscheduleid and a.standardscheduleid='"+standardscheduleid+"'  right outer join feeshead b on a.feestermid=b.feestermid order by b.feestermid";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	*/
	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection feestermConnection;
	 int rollbackvalue;
}