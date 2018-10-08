package com.iGrandee.MasterEntries.SMSTemplate;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import org.apache.log4j.Logger;

public class SMSTemplateQuery
{
	static Logger log = Logger.getLogger(SMSTemplateQuery.class);
	public SMSTemplateQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 smstemplateConnection      = null;
		 rollbackvalue = 0;
		select_query= "";
	}
	
	
	public int insertSMSTemplate(SMSTemplateBean smsTemplateBean) throws Exception
	 {
		 	log.info("invoking SMSTemplate for SMSTemplate");
		 
		 	int result	= 0;
			PreparedStatement smstemplateprepared = null;
			String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	smstemplateConnection = ConnectionManager.getKycConnection();
			smstemplateConnection.setAutoCommit(false);
			
			String query="select max(smstemplateid) from smstemplate";
			long smstemplateid = common_data_object.maxId(query);
			smstemplateid++;

			query="insert into smstemplate (smstemplateid, smstemplatename, smsdescription, createdby, templatecreationdate, smstemplatestatus) values(?,?,?,?,?,?)";
			smstemplateprepared = smstemplateConnection.prepareStatement(query);
			smstemplateprepared.setLong(1, smstemplateid);
			smstemplateprepared.setString(2,smsTemplateBean.getSmstemplatename());
			smstemplateprepared.setString(3,smsTemplateBean.getSmsdescription());
			smstemplateprepared.setString(4,smsTemplateBean.getCreatedby());
			smstemplateprepared.setString(5,currentdate);
			smstemplateprepared.setString(6,"A");
			result += smstemplateprepared.executeUpdate();
			
			smstemplateConnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(smstemplateConnection != null)
				smstemplateConnection.rollback();
	 }
	 finally
		{
	 
		 if(smstemplateprepared != null)
			 smstemplateprepared.close();
		
		 if(smstemplateConnection != null)
		 smstemplateConnection.close();
		 }
	 return result;
	 }
	
	
	public int updateSMSTemplate(SMSTemplateBean smsTemplateBean) throws Exception
	 {
		 	log.info("invoking updateSMSTemplate for SMSTemplate Updation");
		 
		 	int result	= 0;
			PreparedStatement smstemplateprepared = null;
			String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	smstemplateConnection = ConnectionManager.getKycConnection();
			smstemplateConnection.setAutoCommit(false);
			String query="";

			query="update smstemplate set smstemplatename=?,smsdescription=? where smstemplateid=?";
			smstemplateprepared = smstemplateConnection.prepareStatement(query);
			smstemplateprepared.setString(1,smsTemplateBean.getSmstemplatename());
			smstemplateprepared.setString(2,smsTemplateBean.getSmsdescription());
			smstemplateprepared.setString(3, smsTemplateBean.getSmstemplateid());
			
			result += smstemplateprepared.executeUpdate();
			
			smstemplateConnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(smstemplateConnection != null)
				smstemplateConnection.rollback();
	 }
	 finally
		{
	 
		 if(smstemplateprepared != null)
			 smstemplateprepared.close();
		
		 if(smstemplateConnection != null)
		 smstemplateConnection.close();
		 }
	 return result;
	 }
	
	public int updateSMSTemplateStatus(SMSTemplateBean smsTemplateBean) throws Exception
	 {
		 	log.info("invoking updateSMSTemplateStatus for SMSTemplateStatus Updation");
		 
		 	int result	= 0;
			PreparedStatement smstemplateprepared = null;
	 try
	 {
		 	smstemplateConnection = ConnectionManager.getKycConnection();
			smstemplateConnection.setAutoCommit(false);
			String query="update smstemplate set smstemplatestatus=? where smstemplateid=?";
			smstemplateprepared = smstemplateConnection.prepareStatement(query);
			smstemplateprepared.setString(1,smsTemplateBean.getSmstemplatestatus());
			smstemplateprepared.setString(2,smsTemplateBean.getSmstemplateid());
			result += smstemplateprepared.executeUpdate();
			smstemplateConnection.commit();

	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(smstemplateConnection != null)
				smstemplateConnection.rollback();
	 }
	 finally
		{
	 
		 if(smstemplateprepared != null)
			 smstemplateprepared.close();
		
		 if(smstemplateConnection != null)
		 smstemplateConnection.close();
		 }
	 return result;
	 }
	
	
	public ArrayList listSMSTemplateList(String instituteid,String smstemplatestatus)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	if(smstemplatestatus.equals("All"))
        	{
        		select_query = "select smstemplateid, smstemplatename, smsdescription,date_format(templatecreationdate,'%d-%M-%Y %r') as dateofcreation ,smstemplatestatus from smstemplate a, login b,personmaster c where a.createdby=b.userid and b.personid=c.personid and c.instituteid='"+instituteid+"' ";
        	}
        	else if(smstemplatestatus.equals("Active"))
        	{
        		select_query = "select smstemplateid, smstemplatename, smsdescription,date_format(templatecreationdate,'%d-%M-%Y %r') as dateofcreation ,smstemplatestatus from smstemplate a, login b,personmaster c where a.createdby=b.userid and b.personid=c.personid and c.instituteid='"+instituteid+"' and a.smstemplatestatus='A'";
        	}
        	else if(smstemplatestatus.equals("Trash"))
        	{
        		select_query = "select smstemplateid, smstemplatename, smsdescription,date_format(templatecreationdate,'%d-%M-%Y %r') as dateofcreation ,smstemplatestatus from smstemplate a, login b,personmaster c where a.createdby=b.userid and b.personid=c.personid and c.instituteid='"+instituteid+"' and a.smstemplatestatus='T'";
        	}
        	
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public boolean checkDuplicate(String instituteid,String smstemplatename)
	{
		boolean return_flag = false;
		String return_string = null;
		try
		{
			String select_query = "SELECT smstemplateid FROM smstemplate a,login b,personmaster c where smstemplatename='"+smstemplatename+"' and a.smstemplatestatus!='X' and   a.createdby=b.userid and b.personid=c.personid and c.instituteid='"+instituteid+"'" ;
			return_string = common_data_object.getString(select_query);
			if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
				return_flag = false;
			}
			else {
				return_flag = true;
			}

		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return return_flag;
	}
	
	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection smstemplateConnection;
	 int rollbackvalue;
   
}
