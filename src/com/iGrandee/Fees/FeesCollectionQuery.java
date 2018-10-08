package com.iGrandee.Fees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Fees.FeesHeadBean;

import org.apache.log4j.Logger;

public class FeesCollectionQuery
{
	static Logger log = Logger.getLogger(FeesCollectionQuery.class);
	public FeesCollectionQuery()
	{
		common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 feescollectionConnection      = null;
		// rollbackvalue = 0;
		select_query= "";
		 datetime				= new DateTime();
	}
	
	
	public int insertFeesCollection(FeesCollectionBean feesCollectionBean) throws Exception
	 {
		 	log.info("invoking insertFeesCollection for Stanard Fees Collection");
		 
		 	int result	= 0;
			PreparedStatement feescollectionprepared = null;
			String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	feescollectionConnection = ConnectionManager.getKycConnection();
			feescollectionConnection.setAutoCommit(false);
			
			String query="select max(feescollectionid) from feescollection";
			long feescollectionid = common_data_object.maxId(query);
			feescollectionid++;

			query="insert into feescollection (feescollectionid, termfeesid, studentapprovalid, bankname, ddno, dddate, collectionamount, scholarshipid, pendingstatus, createdby, feescollectiondate, feescollectionstatus,paymenttype) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
			feescollectionprepared = feescollectionConnection.prepareStatement(query);
			feescollectionprepared.setLong(1, feescollectionid);
			feescollectionprepared.setString(2,feesCollectionBean.getTermfeesid());
			feescollectionprepared.setString(3,feesCollectionBean.getStudentapprovalid());
			feescollectionprepared.setString(4,feesCollectionBean.getBankname());
			feescollectionprepared.setString(5,feesCollectionBean.getDdno());
			//System.out.println((String)feesCollectionBean.getDddate());
			if(feesCollectionBean.getPaymenttype().equalsIgnoreCase("Cash"))
				feescollectionprepared.setString(6,feesCollectionBean.getDddate());
			else if (feesCollectionBean.getPaymenttype().equalsIgnoreCase("Online"))
				feescollectionprepared.setString(6,feesCollectionBean.getDddate());
			else  
			feescollectionprepared.setString(6,datetime.getMySQLFormat(feesCollectionBean.getDddate()).toString());
			
			feescollectionprepared.setString(7,feesCollectionBean.getCollectionamount());
			feescollectionprepared.setString(8,feesCollectionBean.getScholarshipid());
			feescollectionprepared.setString(9,"-");
			feescollectionprepared.setString(10,feesCollectionBean.getCreatedby());
			//feescollectionprepared.setString(4,feesCollectionBean.getFeescollectiondate());
			feescollectionprepared.setString(11, currentdate);
			feescollectionprepared.setString(12,"A");
			feescollectionprepared.setString(13,feesCollectionBean.getPaymenttype());

			result += feescollectionprepared.executeUpdate();
			feescollectionConnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			e.printStackTrace();
			result	= 0;
			if(feescollectionConnection != null)
				feescollectionConnection.rollback();
	 }
	 finally
		{
	 
		 if(feescollectionprepared != null)
			feescollectionprepared.close();
		
		 if(feescollectionConnection != null)
		 feescollectionConnection.close();
		 }
	 return result;
	 }
	
	
	public int addFeesCollection(FeesCollectionBean feesCollectionBean) throws Exception
	{
	 	log.info("invoking addFeesCollection for Fees Collection");
		 
	 	int result					= 0;

	 	PreparedStatement addstmt 	= null;
	 	
		PreparedStatement maxstmt 	= null;
		ResultSet maxrs 			= null;

		long feescollectionid 		= 0l;

	 	
		String currentdate			= DateTime.showTime("MySqlWithTime");
	
		try
		{
			 	feescollectionConnection = ConnectionManager.getKycConnection();
				feescollectionConnection.setAutoCommit(false);
				
				
				maxstmt				= feescollectionConnection.prepareStatement("select max(feescollectionid) from feescollection");
				maxrs				= maxstmt.executeQuery();
				
				if(maxrs.next())
					feescollectionid	= maxrs.getLong(1);
				feescollectionid++;
				
				
				
				
				
				addstmt				= feescollectionConnection.prepareStatement("insert into feescollection (feescollectionid, termfeesid, studentapprovalid, bankname, ddno, dddate, collectionamount, scholarshipid, pendingstatus, createdby, feescollectiondate, feescollectionstatus,paymenttype, schemeforstudentid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	
				
				if(feesCollectionBean.getScholarshipids() != null && feesCollectionBean.getScholarshipids().length>0)
				for(int y=0;y<feesCollectionBean.getScholarshipids().length;y++){
					
					addstmt.setLong(1, feescollectionid);
					addstmt.setString(2,feesCollectionBean.getTermfeesid());
					addstmt.setString(3,feesCollectionBean.getStudentapprovalid());
					addstmt.setString(4,feesCollectionBean.getBanknames()[y]);
					addstmt.setString(5,feesCollectionBean.getDdnos()[y]);
					
					if(feesCollectionBean.getDddates()[y] == null || feesCollectionBean.getDddates()[y].equals("-") )
						addstmt.setString(6,null);
					else
						addstmt.setString(6,datetime.getMySQLFormat(feesCollectionBean.getDddates()[y]).toString());
					
					addstmt.setString(7,feesCollectionBean.getCollectionamounts()[y]);
					
					if(feesCollectionBean.getScholarshipids()[y] == null || feesCollectionBean.getScholarshipids()[y].equals("") || feesCollectionBean.getScholarshipids()[y].equalsIgnoreCase("null"))
						addstmt.setString(8,null);
					else
						addstmt.setString(8,feesCollectionBean.getScholarshipids()[y]);
					
					addstmt.setString(9,"-");
					addstmt.setString(10,feesCollectionBean.getCreatedby());
					addstmt.setString(11, currentdate);
					addstmt.setString(12,"A");
					addstmt.setString(13,feesCollectionBean.getPaymenttypes()[y]);
					
					if(feesCollectionBean.getSchemeforstudentid()[y] == null || feesCollectionBean.getSchemeforstudentid()[y].equals("") || feesCollectionBean.getSchemeforstudentid()[y].equalsIgnoreCase("null"))
						addstmt.setString(14,null);
					else
						addstmt.setString(14,feesCollectionBean.getSchemeforstudentid()[y]);
					
					addstmt.addBatch();
					
					feescollectionid++;
					
				}
				
				
				int temp[]	= addstmt.executeBatch();
				
				if(temp != null && temp.length>0)
				for(int i=0;i<temp.length;i++)
					result	+= temp[i];
			
				feescollectionConnection.commit();
	
			 
		 }catch(Exception e){
			 
				log.error(e);
				e.printStackTrace();
				result	= 0;
				if(feescollectionConnection != null)
					feescollectionConnection.rollback();
		 }
		 finally
			{
		 
			 
			 if(maxrs != null)
				 maxrs.close();
			 
			 if(maxstmt != null)
				 maxstmt.close();
			 if(addstmt != null)
				 addstmt.close();
			 
			
			 if(feescollectionConnection != null)
			 feescollectionConnection.close();
			 }
		 return result;
	 }
	
	//feescollection with receipt
	
	public String addFeesCollectionwithreceipt(FeesCollectionBean feesCollectionBean) throws Exception
	{
	 	log.info("invoking addFeesCollection for Fees Collection");
		 
	 	int result					= 0;

	 	PreparedStatement addstmt 	= null;
	 	PreparedStatement acamaxstmt 	= null;
	 	
	 	
		PreparedStatement maxstmt 	= null;
		
		PreparedStatement academicstmt 	= null;
		
		ResultSet maxrs 			= null;
		ResultSet acamaxrs 			= null;
		String feesreceiptidstr  = null;

		long feescollectionid 		= 0l;
		long feesreceiptid 		= 0l;

	 	//System.out.println("ASDFASDFASDFASDFASDF");
		String currentdate			= DateTime.showTime("MySqlWithTime");
	
		try
		{
			 	feescollectionConnection = ConnectionManager.getKycConnection();
				feescollectionConnection.setAutoCommit(false);
				
				acamaxstmt				= feescollectionConnection.prepareStatement("select max(academicfeesreceiptid) from academicfeesreceipt");
				acamaxrs				= acamaxstmt.executeQuery();
				
				if(acamaxrs.next())
					feesreceiptid	= acamaxrs.getLong(1);
				feesreceiptid++;
				
				feesreceiptidstr = String.valueOf(feesreceiptid);
				
				maxstmt				= feescollectionConnection.prepareStatement("select max(feescollectionid) from feescollection");
				maxrs				= maxstmt.executeQuery();
				
				if(maxrs.next())
					feescollectionid	= maxrs.getLong(1);
				feescollectionid++;
				
				//academicstmt				= feescollectionConnection.prepareStatement("insert into academicfeesreceipt (academicfeesreceiptnumber, termfeesid, studentapprovalid, paidamount,createdby, dateofcreation, academicfeesreceiptstatus) values(?,?,?,?,?,?,?)");
				academicstmt				= feescollectionConnection.prepareStatement("insert into academicfeesreceipt (academicfeesreceiptid,academicfeesreceiptno,termfeesid, studentapprovalid, paidamount,createdby, dateofcreation, academicfeesreceiptstatus) values(?,?,?,?,?,?,?,?)");
			
				//academicstmt.setLong(1, feescollectionid);
				
				academicstmt.setLong(1,feesreceiptid);
				//academicstmt.setString(1,feesCollectionBean.getReceiptno());
				academicstmt.setString(2,feesreceiptid+"");
				academicstmt.setString(3,feesCollectionBean.getTermfeesid());
				academicstmt.setString(4,feesCollectionBean.getStudentapprovalid());
				academicstmt.setString(5,feesCollectionBean.getPaidamount());
				academicstmt.setString(6,feesCollectionBean.getCreatedby());
				academicstmt.setString(7,currentdate);
				academicstmt.setString(8,"A");
				//System.out.println("academicstmt"+academicstmt);
				result += academicstmt.executeUpdate();
				
				//addstmt				= feescollectionConnection.prepareStatement("insert into feescollection (feescollectionid, termfeesid, studentapprovalid, bankname, ddno, dddate, collectionamount, scholarshipid, pendingstatus, createdby, feescollectiondate, feescollectionstatus,paymenttype, schemeforstudentid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
				//hidden and added receipt no in feescollection table.
				addstmt				= feescollectionConnection.prepareStatement("insert into feescollection (feescollectionid, termfeesid, studentapprovalid, bankname, ddno, dddate, collectionamount, scholarshipid, pendingstatus, createdby, feescollectiondate, feescollectionstatus,paymenttype, schemeforstudentid,academicfeesreceiptid) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
	
				
				if(feesCollectionBean.getScholarshipids() != null && feesCollectionBean.getScholarshipids().length>0)
				for(int y=0;y<feesCollectionBean.getScholarshipids().length;y++){
					
					addstmt.setLong(1, feescollectionid);
					addstmt.setString(2,feesCollectionBean.getTermfeesid());
					addstmt.setString(3,feesCollectionBean.getStudentapprovalid());
					addstmt.setString(4,feesCollectionBean.getBanknames()[y]);
					addstmt.setString(5,feesCollectionBean.getDdnos()[y]);
					
					if(feesCollectionBean.getDddates()[y] == null || feesCollectionBean.getDddates()[y].equals("-") )
						addstmt.setString(6,null);
					else
						addstmt.setString(6,datetime.getMySQLFormat(feesCollectionBean.getDddates()[y]).toString());
					
					addstmt.setString(7,feesCollectionBean.getCollectionamounts()[y]);
					
					if(feesCollectionBean.getScholarshipids()[y] == null || feesCollectionBean.getScholarshipids()[y].equals("") || feesCollectionBean.getScholarshipids()[y].equalsIgnoreCase("null"))
						addstmt.setString(8,null);
					else
						addstmt.setString(8,feesCollectionBean.getScholarshipids()[y]);
					
					addstmt.setString(9,"-");
					addstmt.setString(10,feesCollectionBean.getCreatedby());
					addstmt.setString(11, currentdate);
					addstmt.setString(12,"A");
					addstmt.setString(13,feesCollectionBean.getPaymenttypes()[y]);
					
					if(feesCollectionBean.getSchemeforstudentid()[y] == null || feesCollectionBean.getSchemeforstudentid()[y].equals("") || feesCollectionBean.getSchemeforstudentid()[y].equalsIgnoreCase("null"))
						addstmt.setString(14,null);
					else
						addstmt.setString(14,feesCollectionBean.getSchemeforstudentid()[y]);
					
					addstmt.setLong(15,feesreceiptid);
					
					addstmt.addBatch();
					
					feescollectionid++;
					
				}
				
				
				int temp[]	= addstmt.executeBatch();
				
				if(temp != null && temp.length>0)
				for(int i=0;i<temp.length;i++)
					result	+= temp[i];
			
				feescollectionConnection.commit();
	
			// System.out.println("result"+result);
		 }catch(Exception e){
			 feesreceiptidstr  = null;
				log.error(e);
				e.printStackTrace();
				result	= 0;
				if(feescollectionConnection != null)
					feescollectionConnection.rollback();
		 }
		 finally
			{
			 //acamaxstmt
			 
			 if(academicstmt != null)
				 academicstmt.close();
			 
			 if(acamaxstmt != null)
				 acamaxstmt.close();
			 if(acamaxrs != null)
				 acamaxrs.close();
			
			
			 
			 if(maxrs != null)
				 maxrs.close();
			 
			 if(maxstmt != null)
				 maxstmt.close();
			 if(addstmt != null)
				 addstmt.close();
			 
			
			 if(feescollectionConnection != null)
			 feescollectionConnection.close();
			 }
		// return result;
		//System.out.println("result==>"+result);
		if(result > 0)
			feesreceiptidstr= feesreceiptidstr;
		else
			feesreceiptidstr = null;
		
			
		return feesreceiptidstr;
	 }
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection feescollectionConnection;
	// int rollbackvalue;
	 DateTime datetime;
}