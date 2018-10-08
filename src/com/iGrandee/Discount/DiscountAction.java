/**
 * 
 */
package com.iGrandee.Discount;

import java.util.ArrayList;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.ResourceBundle;

import org.apache.log4j.Logger;

import com.iGrandee.Application.ApplicationQuery;
import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
/**
 * @author selvakumar_v
 *
 */
public class DiscountAction {
	
	static Logger log = Logger.getLogger(ApplicationQuery.class);
	CommonDataAccess common_data_object = new CommonDataAccess();

	public String insert_query = null;
	// public String select_query = null;
	int return_value = 0;
	ResourceBundle resourcebundle;
	DateTime datetime = new DateTime();

	
	
	public ArrayList listYearofSession(String instituteid) {
		log.info("invoking listYearofSession to list all year of session");
		ArrayList courseList = new ArrayList();
		String currdate = "";
		try {
			String query = "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"
					+ instituteid
					+ "' and (sessionstatus='A' or sessionstatus='R') order by sessionname";
		 //System.out.println("query-dccc->"+query);
			courseList = common_data_object.getListMap(query);
		} catch (Exception e) {
			log.error(e);
		}
		return courseList;
	}
	
	
	public String countcategory(String sessionid){
		String result=null;
		
		try{
			/*select_query="select  (j.discountcategoryid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e," +
			"studentapproval f,studentstageallocation g,discountusers h,discountamount i,discountcategory j where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid " +
			"and b.standardscheduleid=c.standardscheduleid and c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and " +
			"e.studentapprovalid=f.studentapprovalid and f.studentapprovalid=g.studentapprovalid  and b.stdschedulestatus='A' and " +
			"g.studentapprovalid=h.studentapprovalid and h.discountcategoryid=i.discountcategoryid and i.discountcategoryid=j.discountcategoryid and" +
			" c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and " +
			"g.studentstageallocationstatus='A' and h.discountuserstatus='A' and i.discountamountstatus='A' and j.discountcategorystatus='A' group by " +
			" j.discountcategoryid";*/
select_query="select count(discountcategoryid) from  discountamount where sessionid='"+sessionid+"' and discountamountstatus='A'";

			//System.out.println("countcategory>>>>>"+select_query);
			result=common_data_object.getString(select_query);
			
		}
		catch (Exception e) {
			e.printStackTrace(); 
		}
		return result;
	}
	
	public ArrayList getCategoryname(String instituteid) {
		log.info("invoking listYearofSession to list all year of session");
		ArrayList returnlist = new ArrayList();
		String currdate = "";
		try {
			String query = "select discountcategoryname,discountcategoryid from discountcategory where instituteid='"+instituteid+"'  and discountcategorystatus='A'";
			// System.out.println("getCategoryname-->"+query);
			returnlist = common_data_object.getListMap(query);
		} catch (Exception e) {
			log.error(e);
		}
		return returnlist;
	}
	 
// insert in to discountamount
	public int insertdiscountamount(DiscountBean discountbean)
			throws Exception {
		log.info("invoking insertdiscountamount for discountamount");
		// Connection connection = null;
		PreparedStatement appstmt = null;
		PreparedStatement appidstmt = null;
		PreparedStatement recptidstmt = null;
		ResultSet appidrs = null;
		ResultSet recptidrs = null;

		long appId = 0l;
		long recptId = 0l;

		int result = 0;

		String datestr = null;
		// datestr = datetime.showTime("sqlserver");
		

		try {
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);
			datestr = datetime.showTime("MySqlWithTime");
			select_query = "select max(discountamountid) from discountamount";
			appidstmt = applicationConnection.prepareStatement(select_query);
			appidrs = appidstmt.executeQuery();

			if (appidrs.next())
				appId = appidrs.getLong(1);

			appId++;

			insert_query = "insert into discountamount (discountamountid, discountcategoryid, sessionid, discountpercentage, createdby, dateofcreation, discountamountstatus) values (?, ?, ?, ?, ?, ?, ?)";
			appstmt = applicationConnection.prepareStatement(insert_query);

			appstmt.setLong(1, appId);
			appstmt.setString(2, discountbean.getDiscountcategoryid());
			appstmt.setString(3, discountbean.getSessionid());
			appstmt.setFloat(4, Float.parseFloat(discountbean.getDiscountpercentage()));
			appstmt.setString(5, discountbean.getCreatedby());
			appstmt.setString(6, datestr);
			appstmt.setString(7, discountbean.getDiscountamountstatus());
			//System.out.println("appstmt>>>>>>>>>>>>>"+appstmt);
			result = appstmt.executeUpdate(); 
			applicationConnection.commit();
		} catch (SQLException e) {
			// System.out.println("Error in applicationInsert");
			log.error("",e);
			e.printStackTrace();

			if (applicationConnection != null)
				applicationConnection.rollback();

			result = 0;

		} finally {

			if (appidrs != null)
				appidrs.close();

			if (appidstmt != null)
				appidstmt.close();
			if (appstmt != null)
				appstmt.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}

		return result;
	}
	//insert in to  discountuser discountuserid, discountamountid, studentapprovalid, createdby, dateofcreation, discountuserstatus
	
	public int insertdiscountuser(DiscountuserBean discountuserbean)
			throws Exception {
		log.info("invoking insertdiscountamount for discountamount");
		// Connection connection = null;
		PreparedStatement appstmt = null;
		PreparedStatement appidstmt = null;
		PreparedStatement recptidstmt = null;
		ResultSet appidrs = null;
		ResultSet recptidrs = null;

		long appId = 0l;
		long recptId = 0l;

		int result = 0;

		String datestr = null;
		// datestr = datetime.showTime("sqlserver");
		

		try {
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);
			datestr = datetime.showTime("MySqlWithTime");
			select_query = "select max(discountuserid) from discountuser";
			appidstmt = applicationConnection.prepareStatement(select_query);
			appidrs = appidstmt.executeQuery();

			if (appidrs.next())
				appId = appidrs.getLong(1);

			appId++;

			insert_query = "insert into discountamount (discountuserid, discountamountid, studentapprovalid, createdby, dateofcreation, discountuserstatus) values (?, ?, ?, ?, ?, ?)";
			appstmt = applicationConnection.prepareStatement(insert_query);

			appstmt.setLong(1, appId);
			appstmt.setString(2, discountuserbean.getDiscountamountid());
			appstmt.setString(3, discountuserbean.getStudentapprovalid());
			appstmt.setString(4, discountuserbean.getCreatedby());
			appstmt.setString(5, discountuserbean.getDateofcreation());
			appstmt.setString(6, discountuserbean.getDiscountuserstatus());
			result = appstmt.executeUpdate();
			applicationConnection.commit();
		} catch (SQLException e) {
			// System.out.println("Error in applicationInsert");
			log.error("",e);
			e.printStackTrace();

			if (applicationConnection != null)
				applicationConnection.rollback();

			result = 0;

		} finally {

			if (appidrs != null)
				appidrs.close();

			if (appidstmt != null)
				appidstmt.close();
			if (appstmt != null)
				appstmt.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}

		return result;
	}
	// insert in to discountuserlog  
	public int insertdiscountuserlog(DiscountuserlogBean discountuserlogbean)
			throws Exception {
		log.info("invoking insertdiscountamount for discountamount");
		// Connection connection = null;
		PreparedStatement appstmt = null;
		PreparedStatement appidstmt = null;
		PreparedStatement recptidstmt = null;
		ResultSet appidrs = null;
		ResultSet recptidrs = null;

		long appId = 0l;
		long recptId = 0l;

		int result = 0;

		String datestr = null;
		// datestr = datetime.showTime("sqlserver");
		

		try {
			applicationConnection = ConnectionManager.getKycConnection();
			applicationConnection.setAutoCommit(false);
			datestr = datetime.showTime("MySqlWithTime");
			select_query = "select max(discountuserlogid) from discountuserlog";
			appidstmt = applicationConnection.prepareStatement(select_query);
			appidrs = appidstmt.executeQuery();

			if (appidrs.next())
				appId = appidrs.getLong(1);

			appId++;

			insert_query = "insert into discountuserlog (discountuserlogid, discountuserid, discountuserlogaction, createdby, dateofcreation, discountuserlogstatus) values (?, ?, ?, ?, ?, ?)";
			appstmt = applicationConnection.prepareStatement(insert_query);

			appstmt.setLong(1, appId);
			appstmt.setString(2, discountuserlogbean.getDiscountuserid());
			appstmt.setString(3, discountuserlogbean.getDiscountuserlogaction());
			appstmt.setString(4, discountuserlogbean.getCreatedby());
			appstmt.setString(5, discountuserlogbean.getDateofcreation());
			appstmt.setString(6, discountuserlogbean.getDiscountuserlogstatus());
			result = appstmt.executeUpdate();
			applicationConnection.commit();
		} catch (SQLException e) {
			// System.out.println("Error in applicationInsert");
			log.error("",e);
			e.printStackTrace();

			if (applicationConnection != null)
				applicationConnection.rollback();

			result = 0;

		} finally {

			if (appidrs != null)
				appidrs.close();

			if (appidstmt != null)
				appidstmt.close();
			if (appstmt != null)
				appstmt.close();

			if (applicationConnection != null)
				applicationConnection.close();
		}

		return result;
	}
	
	
	public String checkamount(String catid,String sessionid){
		
		 String return_value=null;
		try{
			select_query="select  case when discountpercentage is null then '' else discountpercentage end as status from discountamount where discountcategoryid='"+catid+"' and sessionid='"+sessionid+"'";
		//	System.out.println("select_query..amt"+select_query);
			return_value=common_data_object.getString(select_query);
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return return_value;
	}

	public ArrayList discountedit(String sessonid){
		
		 ArrayList return_value=null;
		try{
			//select_query="select a.discountcategoryname,b.discountpercentage,b.discountamountid from discountcategory a , discountamount b where  b.sessionid='"+sessonid+"' and discountamountstatus='A' and a.discountcategoryid=b.discountcategoryid and a.discountcategorystatus='A' group by a.discountcategoryid";
			select_query="select a.discountcategoryname,b.discountpercentage,b.discountamountid,discountusersid  from discountamount b,discountcategory a " +
			"left outer join discountusers c on a.discountcategoryid=c.discountcategoryid where  b.sessionid='"+sessonid+"' and discountamountstatus='A' and " +
			"a.discountcategoryid=b.discountcategoryid and a.discountcategorystatus='A' group by  a.discountcategoryid";
			
			//System.out.println("select_query..amt"+select_query);
			return_value=common_data_object.getListMap(select_query);
		}
		catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return return_value;
	}
	 
public int updatediscount(String discountamountid,String amount)throws Exception{
	
	PreparedStatement udatediscountstmt=null;
	
	int result=0;
	try{
		
		select_query="update discountamount set discountpercentage=? where discountamountid=? and discountamountstatus='A'";
		applicationConnection = ConnectionManager.getKycConnection();
		udatediscountstmt=applicationConnection.prepareStatement(select_query);
		udatediscountstmt.setString(1, amount);
		udatediscountstmt.setString(2, discountamountid);
		//System.out.println("udatediscountstmt>>>>>."+udatediscountstmt);
		result=udatediscountstmt.executeUpdate();
		

	}
	
	catch (Exception e) {
		e.printStackTrace();
		result=0;
		if(applicationConnection!=null){
			applicationConnection.rollback();
		}
	}
	finally{
		if(udatediscountstmt!=null){
			
			udatediscountstmt.close();
		}
		
	}
	
	return result;
}

public String getsessioname(String sessionid){
	
	 String return_value=null;
	try{
		select_query="select sessionname from yearofsession where sessionid='"+sessionid+"' and (sessionstatus='A' or sessionstatus='R')";
		//System.out.println("select_query..amt"+select_query);
		return_value=common_data_object.getString(select_query);
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return return_value;
}

/**
 * This method is accessed from kycportal/jsp/Discount/Discount.jsp
 * change AcademicSession status as A (Restore)           - selvakumar
 *
  		@param  discountamountid that can be inserted to discountamount table
	  *
	  @param discountcategoryid that can be inserted to discountamount table
	  *
	  @param sessionid that can be inserted to discountamount table
	  *
	  @param discountpercentage that can be inserted to discountamount table
	  *
	  @param createdby that can be inserted to discountamount table
	  *
	  @param dateofcreation that can be inserted to discountamount table
	  *
	  @param discountamountstatus that can be inserted to discountamount table
	  *
	
 *
 
*/
//insert discount category
public int insertdiscountcategory(DiscountCategorybean categorybean)
		throws Exception {
	log.info("invoking insertdiscountamount for discountamount");
	// Connection connection = null;
	PreparedStatement appstmt = null;
	PreparedStatement appidstmt = null;
	PreparedStatement recptidstmt = null;
	ResultSet appidrs = null;
	ResultSet recptidrs = null;
	ResultSet checkrs = null;
	
	PreparedStatement checkprepared=null;

	long discountcategoryid = 0l;
	long recptId = 0l;

	int result = 0;

	String datestr = null;
	// datestr = datetime.showTime("sqlserver");
	

	try {
		applicationConnection = ConnectionManager.getKycConnection();
		applicationConnection.setAutoCommit(false);
		datestr = datetime.showTime("MySqlWithTime");
		select_query = "select max(discountcategoryid) from discountcategory";
		appidstmt = applicationConnection.prepareStatement(select_query);
		appidrs = appidstmt.executeQuery();

		if (appidrs.next())
			discountcategoryid = appidrs.getLong(1);

		discountcategoryid++;
		checkprepared			= applicationConnection.prepareStatement("select discountcategoryid from discountcategory where discountcategoryname=? and discountcategorystatus<>? and instituteid=?");
		checkprepared.setString(1, categorybean.getDiscountcategoryname());
		checkprepared.setString(2, "X");
		checkprepared.setString(3,categorybean.getInstituteid());
		
		checkrs				= checkprepared.executeQuery();
		
		if(!checkrs.next()){

		insert_query = "insert into discountcategory (discountcategoryid, discountcategoryname, discountcategorydescription, discountcategorystatus, instituteid, dateofcreation, createdby) values (?, ?, ?, ?, ?,?, ?)";
		appstmt = applicationConnection.prepareStatement(insert_query);
		appstmt.setLong(1, discountcategoryid);
		appstmt.setString(2, categorybean.getDiscountcategoryname());
		appstmt.setString(3, categorybean.getDiscountcategorydescription());
		appstmt.setString(4, categorybean.getDiscountcategorystatus());
		appstmt.setString(5, categorybean.getInstituteid());
		appstmt.setString(6, datestr);
		appstmt.setString(7, categorybean.getCreatedby());
		result = appstmt.executeUpdate();
		}
		
		else{
			
			result	= 1000;
		}
		applicationConnection.commit();
	} catch (SQLException e) {
		// System.out.println("Error in applicationInsert");
		log.error("",e);
		e.printStackTrace();

		if (applicationConnection != null)
			applicationConnection.rollback();

		result = 0;

	} finally {

		if (appstmt != null)
			appstmt.close();
		
		if (checkrs != null)
			checkrs.close();
		
		if (checkprepared != null)
			checkprepared.close();
		
		if (appidrs != null)
			appidrs.close();

		if (appidstmt != null)
			appidstmt.close();
		

		if (applicationConnection != null)
			applicationConnection.close();
	}

	return result;
}

/**
 * This method is accessed from kycportal/jsp/Discount/Discount.jsp
 * change AcademicSession status as A (Restore)           - selvakumar
 *
  	 @param sessonid,createdby that can be used to get all discountlist from  discountcategory table 
	   * 
	 @return the ArrayList by which result can be printed on the screen
	 
*/

public ArrayList discountlist(String sessonid){
	
	 ArrayList return_value=null;
	try{
		select_query="select a.discountcategoryid,a.discountcategoryname,a.discountcategorydescription,DATE_FORMAT(a.dateofcreation, '%d-%b-%Y') as newdates from discountcategory a where instituteid='"+sessonid+"'  and discountcategorystatus='A'";
		//System.out.println("select_query..amt"+select_query);
		return_value=common_data_object.getListMap(select_query);
	}
	catch (Exception e) {
		// TODO: handle exception 
		e.printStackTrace();
	}
	return return_value;
}


public ArrayList discounteditlist(String discountcategoryid){
	
	 ArrayList return_value=null;
	try{
		select_query="select discountcategoryid,discountcategoryname,discountcategorydescription from discountcategory where discountcategoryid='"+discountcategoryid+"' and discountcategorystatus='A'";
		//System.out.println("select_query..amt"+select_query);
		return_value=common_data_object.getListMap(select_query);
	}
	catch (Exception e) {
		// TODO: handle exception 
		e.printStackTrace();
	}
	return return_value;
}


public int updatediscount(String catid,String discountname,String desc) throws Exception{
	
	
	PreparedStatement updatetranspotrouteprepared 	= null;
	
	PreparedStatement checkrouteprepared = null;
	int rs=0;
	
	ResultSet rs1=null;
	
	try{
		applicationConnection= ConnectionManager.getKycConnection();
		String currentdate			= DateTime.showTime("MySqlWithTime");
		   String str			= "select discountcategoryid from discountcategory  where discountcategoryname=? and discountcategorystatus<>? and discountcategoryid<>?";
            checkrouteprepared	= applicationConnection.prepareStatement(str);
            checkrouteprepared.setString(1, discountname);
            checkrouteprepared.setString(2, "X"); 
            checkrouteprepared.setString(3,catid);
            rs1	= checkrouteprepared.executeQuery();
		//System.out.println("checkrouteprepared>>>>"+checkrouteprepared);
	//	System.out.println("rs1>>>>"+rs1);

            if(!rs1.next())
            {
        		//System.out.println("in if>>>>>>>>>>");

		select_query="update discountcategory set discountcategoryname=?,discountcategorydescription=?,dateofcreation=?  where discountcategoryid=?";
		updatetranspotrouteprepared = applicationConnection.prepareStatement(select_query);
		
		updatetranspotrouteprepared.setString(1,discountname);
		updatetranspotrouteprepared.setString(2,desc);
		updatetranspotrouteprepared.setString(3,currentdate);
		updatetranspotrouteprepared.setString(4,catid);
		rs += updatetranspotrouteprepared.executeUpdate();
            }
            else{
            	//System.out.println("in else>>>>>>>>>");
            	rs	= 1000;
            }
		
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		rs=0;
		
		if(applicationConnection!=null){
			
			applicationConnection.rollback();
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
		
		
			if(applicationConnection!=null){
			
			applicationConnection.close();
		}
			
			
	}
	
	return rs;
}



public ArrayList geteditdiscountcategory(String discountcategoryid){
	ArrayList transpotroutelist=null;
	select_query="select discountcategoryname, discountcategorydescription, discountcategorystatus, dateofcreation  from  discountcategory where discountcategorystatus='A' and discountcategoryid="+discountcategoryid+"";
	try{
		transpotroutelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) { 
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transpotroutelist;
}
	


public int changediscount(String discountcategoryid,String status) throws Exception{
	int result	= 0;
	PreparedStatement trashdiscountprepared 	= null;
	
	try{
		applicationConnection= ConnectionManager.getKycConnection();
		String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="update discountcategory set discountcategorystatus=? where discountcategoryid=?";
		trashdiscountprepared = applicationConnection.prepareStatement(select_query);
		
		trashdiscountprepared.setString(1, status);
		 
		trashdiscountprepared.setString(2,discountcategoryid);
		
		result += trashdiscountprepared.executeUpdate();

		//System.out.println("trashdiscountprepared>>>>>"+trashdiscountprepared);
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(applicationConnection!=null){
			
			applicationConnection.rollback();
		}
	}
	finally{
		if(trashdiscountprepared!=null){
			trashdiscountprepared.close();
			
		}
			if(applicationConnection!=null){
			
			applicationConnection.close();
		}
		
	}
	
	return result;
}



public ArrayList getdiscounttrashlist(String instituteid){
	ArrayList discountlist=null;
	try{
		select_query="select discountcategoryid, discountcategoryname, discountcategorydescription, discountcategorystatus from  discountcategory where instituteid='"+instituteid+"' and discountcategorystatus='T'";
		discountlist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return discountlist;
}


public ArrayList getstudentdetails(String rollnumber,String instituteid)
{
	 ArrayList arraylist = null;
    try
    {
    	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
    	select_query = "select c.sessionid,c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid, j.userid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i, login j where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"' and a.studentallocationstatus='A' and i.personid=j.personid and j.loginstatus='A'";
    	 
    	log.info(select_query);
    	//System.out.println("checkandLoadStudent>>"+select_query);
    	arraylist = common_data_object.getListMap(select_query);
    //	System.out.println("arraylist>>>>>"+arraylist);
    	if(arraylist!=null){
    		
    		//System.out.println("arraylist in if>>>"+arraylist);
    	}
    	else{
    		//System.out.println("arraylist in else>>>"+arraylist);
    	}
    	
    }catch(Exception e){log.error(e);}
    return arraylist;
}

public boolean verifyDiscountUserAllocation(String studentapprovalid,String discountuserid)
{
	 ArrayList arraylist = new ArrayList();
	 boolean req_flag = false;
    try
    {
    	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
    	String query = "select transportfeescollectiondiscountid from transportfeescollectiondiscount a,transportfeescollection b where a.transportfeescollectionid=b.transportfeescollectionid and  a.discountuserid='"+discountuserid+"' and a.transportfeescollectiondiscountstatus='A' and b.transportfeescollectionstatus='A'";  
    	System.out.println(select_query);
    	//System.out.println("checkandLoadStudent>>"+select_query);
    	arraylist = common_data_object.getListMap(select_query);
    	if(arraylist.size()>0)
    		req_flag = true;
    	else
    		req_flag = false;
    }catch(Exception e){log.error(e);}
    return req_flag;
}


public ArrayList getdiscountallocation(String stappid,String sessionid)
{
	 ArrayList arraylist = new ArrayList();
    try
    {
    	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
    	select_query = "select c.discountusersid,a.discountcategoryid, a.discountcategoryname,b.discountpercentage,c.discountusersid,c.discountuserstatus as status  from discountamount b ,discountcategory a left outer join discountusers c on a.discountcategoryid=c.discountcategoryid and  c.discountuserstatus='A'  and studentapprovalid='"+stappid+"'" +
    " where a.discountcategoryid=b.discountcategoryid and b.sessionid='"+sessionid+"' group by a.discountcategoryid,c.studentapprovalid  order by  c.discountusersid asc";
    	 
    	log.info(select_query);
    	//System.out.println("checkandLoadStudent>>"+select_query);
    	arraylist = common_data_object.getListMap(select_query);
    }catch(Exception e){log.error(e);}
    return arraylist;
}

  

public ArrayList getdiscounthistory(String stappid,String sessionid)
{
	 ArrayList arraylist = new ArrayList();
    try
    {
    	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
    	select_query = "select a.discountcategoryid, a.discountcategoryname,b.discountpercentage,c.discountusersid,case when c.discountuserstatus  = 'A'  then 'Current' else 'Closed' end as status from discountamount b ,discountcategory a  join discountusers c on a.discountcategoryid=c.discountcategoryid  and studentapprovalid='"+stappid+"'" +
    	" where a.discountcategoryid=b.discountcategoryid and b.sessionid='"+sessionid+"'  order by  c.discountusersid desc";
    	 
    	log.info(select_query);
    //	System.out.println("checkandLoadStudent>>"+select_query);
    	arraylist = common_data_object.getListMap(select_query);
    }catch(Exception e){log.error(e);}
    return arraylist;
}



//insert discount allocation created by selavakumarv
public int insertdiscountallocation(Discountallocationbean allocationbean)
		throws Exception {
	log.info("invoking insertdiscountamount for discountamount");
	// Connection connection = null;
	PreparedStatement appstmt = null;
	PreparedStatement appidstmt = null;
	//PreparedStatement recptidstmt = null;
	ResultSet appidrs = null;
	//ResultSet recptidrs = null;
	//ResultSet checkrs = null;
	
	//PreparedStatement checkprepared=null;

	long discountusersid = 0l;
	//long recptId = 0l;

	int result = 0;

	String datestr = null;
	// datestr = datetime.showTime("sqlserver");
	PreparedStatement checkrouteprepared=null;
	PreparedStatement updateprepared=null;
	ResultSet rs1=null;

	try {
		applicationConnection = ConnectionManager.getKycConnection();
		applicationConnection.setAutoCommit(false);
		datestr = datetime.showTime("MySqlWithTime");
	
		select_query = "select max(discountusersid) from discountusers";
		appidstmt = applicationConnection.prepareStatement(select_query);
		appidrs = appidstmt.executeQuery();

		if (appidrs.next())
			discountusersid = appidrs.getLong(1);

		discountusersid++;
		 String str			= "select discountcategoryid,studentapprovalid from discountusers where studentapprovalid=? and discountuserstatus=?";
         checkrouteprepared	= applicationConnection.prepareStatement(str);
         checkrouteprepared.setString(1, allocationbean.getStudentapprovalid());
         checkrouteprepared.setString(2, "A"); 
       //  System.out.println("checkrouteprepared>>>"+checkrouteprepared);
         rs1	= checkrouteprepared.executeQuery();
		
         if(!rs1.next())
         {
        	
        	 
			insert_query = "insert into  discountusers (discountusersid, discountcategoryid, studentapprovalid, createdby, dateofcreation, discountuserstatus) values (?, ?, ?, ?, ?, ?)";
			appstmt = applicationConnection.prepareStatement(insert_query);
			appstmt.setLong(1, discountusersid);
			appstmt.setString(2, allocationbean.getDiscountcategoryid());
			appstmt.setString(3, allocationbean.getStudentapprovalid());
			appstmt.setString(4, allocationbean.getCreatedby());
			appstmt.setString(5, datestr);
			appstmt.setString(6, allocationbean.getDiscountuserstatus());
			//System.out.println("appstmt discountusers> if>big"+appstmt);
			result = appstmt.executeUpdate();
         }
         else{
        	 
        	 select_query="update discountusers set discountuserstatus=? where discountcategoryid=? and  studentapprovalid=?";
        	 updateprepared=applicationConnection.prepareStatement(select_query);
        	 updateprepared.setString(1, "D");
        	 updateprepared.setString(2, rs1.getString(1));
        	 updateprepared.setString(3, rs1.getString(2));
        	// System.out.println("appstmt discountusers> else>"+updateprepared);
        	 result = updateprepared.executeUpdate();
        	 
        	 insert_query = "insert into  discountusers (discountusersid, discountcategoryid, studentapprovalid, createdby, dateofcreation, discountuserstatus) values (?, ?, ?, ?, ?, ?)";
 			appstmt = applicationConnection.prepareStatement(insert_query);
 			appstmt.setLong(1, discountusersid);
 			appstmt.setString(2, allocationbean.getDiscountcategoryid());
 			appstmt.setString(3, allocationbean.getStudentapprovalid());
 			appstmt.setString(4, allocationbean.getCreatedby());
 			appstmt.setString(5, datestr);
 			appstmt.setString(6, allocationbean.getDiscountuserstatus());
 			//System.out.println("appstmt discountusers> if>"+appstmt);
 			result = appstmt.executeUpdate();
         }
		applicationConnection.commit();
	} catch (SQLException e) {
		// System.out.println("Error in applicationInsert");
		log.error("",e);
		e.printStackTrace();

		if (applicationConnection != null)
			applicationConnection.rollback();

		result = 0;

	} finally {

		
		if (appstmt != null)
			appstmt.close();
		
		if (updateprepared != null)
			updateprepared.close();
		
		
		if (appstmt != null)
			appstmt.close();
		
		if (rs1!= null)
			rs1.close();
		
		
		
		if (checkrouteprepared != null)
			checkrouteprepared.close();
		if (appidrs != null)
			appidrs.close();

		if (appidstmt != null)
			appidstmt.close();
	

		if (applicationConnection != null)
			applicationConnection.close();
	}

	return result;
}





//update discount allocation created by selavakumarv
public int updatediscountallocation(Discountallocationbean allocationbean)
		throws Exception {
	log.info("invoking insertdiscountamount for discountamount");
	// Connection connection = null;
	PreparedStatement appstmt = null;
	PreparedStatement appidstmt = null;
	//PreparedStatement recptidstmt = null;
	ResultSet appidrs = null;
	//ResultSet recptidrs = null;
//	ResultSet checkrs = null;
	
	//PreparedStatement checkprepared=null;

//	long discountusersid = 0l;
	//long recptId = 0l;
	//PreparedStatement checkrouteprepared=null;
	PreparedStatement updateprepared=null;
	//ResultSet rs1=null;
	int result = 0;

	String datestr = null;
	// datestr = datetime.showTime("sqlserver");
	

	try {
		applicationConnection = ConnectionManager.getKycConnection();
		applicationConnection.setAutoCommit(false);
		datestr = datetime.showTime("MySqlWithTime");
	
	/*	select_query = "select max(discountusersid) from discountusers";
		appidstmt = applicationConnection.prepareStatement(select_query);
		appidrs = appidstmt.executeQuery();

		if (appidrs.next())
			discountusersid = appidrs.getLong(1);

		discountusersid++;

		 insert_query = "insert into  discountusers (discountusersid, discountcategoryid, studentapprovalid, createdby, dateofcreation, discountuserstatus) values (?, ?, ?, ?, ?, ?)";
			appstmt = applicationConnection.prepareStatement(insert_query);
			appstmt.setLong(1, discountusersid);
			appstmt.setString(2, allocationbean.getDiscountcategoryid());
			appstmt.setString(3, allocationbean.getStudentapprovalid());
			appstmt.setString(4, allocationbean.getCreatedby());
			appstmt.setString(5, datestr);
			appstmt.setString(6, allocationbean.getDiscountuserstatus());
			System.out.println("appstmt discountusers> if>"+appstmt);
			result = appstmt.executeUpdate(); */     	 
      	 select_query="update discountusers set discountuserstatus=? where discountcategoryid=? and  studentapprovalid=?";
      	 updateprepared=applicationConnection.prepareStatement(select_query);
      	 updateprepared.setString(1, "D");
      	 updateprepared.setString(2, allocationbean.getDiscountcategoryid());
      	 updateprepared.setString(3, allocationbean.getStudentapprovalid());
      //	 System.out.println("appstmt discountusers> else>"+updateprepared);
      	 result = updateprepared.executeUpdate();
      	 
      	
			
       
		applicationConnection.commit();
	} catch (SQLException e) {
		// System.out.println("Error in applicationInsert");
		log.error("",e);
		e.printStackTrace();

		if (applicationConnection != null)
			applicationConnection.rollback();

		result = 0;

	} finally {

		if (updateprepared != null)
			updateprepared.close();

		
		if (applicationConnection != null)
			applicationConnection.close();
	}

	return result;
}




//remove discount allocation created by selavakumarv
public int removediscountallocation(Discountallocationbean allocationbean,String discountusersid)
		throws Exception {
	log.info("invoking insertdiscountamount for discountamount");
	// Connection connection = null;
	PreparedStatement appstmt = null;
	PreparedStatement appidstmt = null;
//	PreparedStatement recptidstmt = null;
	ResultSet appidrs = null;
//	ResultSet recptidrs = null;
	//ResultSet checkrs = null;
	
	//PreparedStatement checkprepared=null;

//	long recptId = 0l;

	int result = 0;

	String datestr = null;
	// datestr = datetime.showTime("sqlserver");
	PreparedStatement checkrouteprepared=null;
	//PreparedStatement updateprepared=null;
	ResultSet rs1=null;

	try {	datestr = datetime.showTime("MySqlWithTime");
		applicationConnection = ConnectionManager.getKycConnection();
		applicationConnection.setAutoCommit(false);
	
	
/*		select_query = "select max(discountusersid) from discountusers";
		appidstmt = applicationConnection.prepareStatement(select_query);
		appidrs = appidstmt.executeQuery();*/

		 String str			= "select discountuserid from transportfeescollectiondiscount where discountuserid=? and transportfeescollectiondiscountstatus=?";
       checkrouteprepared	= applicationConnection.prepareStatement(str);
       checkrouteprepared.setString(1, discountusersid);
       checkrouteprepared.setString(2, "A"); 
     //  System.out.println("checkrouteprepared>remove>>"+checkrouteprepared);
       rs1	= checkrouteprepared.executeQuery();
		
       if(!rs1.next())
       {
      	 
			select_query = "delete from discountusers where discountusersid=?";
			appstmt = applicationConnection.prepareStatement(select_query);
			appstmt.setString(1, discountusersid);
			
		//	System.out.println("appstmt removeig"+appstmt);
			result = appstmt.executeUpdate();
       }
       else{ 
      	 
      	
			result = 1000;
       }
		applicationConnection.commit();
	} catch (SQLException e) {
		// System.out.println("Error in applicationInsert");
		log.error("",e);
		e.printStackTrace();

		if (applicationConnection != null)
			applicationConnection.rollback();

		result = 0;

	} finally {

		
		if (appidstmt != null)
			appidstmt.close();
		
		if (rs1 != null)
			rs1.close();
		
		if (checkrouteprepared != null)
			checkrouteprepared.close();
		

		if (applicationConnection != null)
			applicationConnection.close();
	}

	return result;
}


//get count of  students in session for discount category created by selvakumar v
public String countdiscount(String sessionid){
	String result=null;
	
	try{
	select_query="select  count(h.studentapprovalid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f,studentstageallocation g,discountusers h where a.sessionid='"+sessionid+"'" +
	" and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and f.studentapprovalid=g.studentapprovalid  and b.stdschedulestatus='A' and g.studentapprovalid=h.studentapprovalid and c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and g.studentstageallocationstatus='A' and h.discountuserstatus='A'";


//	System.out.println("select_query>countdiscount>"+select_query);
		result=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result;
}


//get  discount category per session created by selvakumar v
public ArrayList getdiscountpersession(String sessionid){
	ArrayList result=null;
	try{
	select_query="select b.discountcategoryid,b.discountcategoryname,a.sessionid  from discountamount a,discountcategory b where a.sessionid='"+sessionid+"' and " +
	"a.discountcategoryid=b.discountcategoryid and discountamountstatus='A' and b.discountcategorystatus='A' group by a.discountcategoryid";


	//System.out.println("getdiscountpersession >>>ss>"+select_query);
		result=common_data_object.getListMap(select_query);  
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}



//get count of  students in session for discount category created by selvakumar v
public int getdiscountcountpercategory(String sessionid,String discountcategoryid){
	int result=0;
	
	try{
	select_query="select count(h.studentapprovalid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f,studentstageallocation g,discountusers h where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and h.discountcategoryid='"+discountcategoryid+"' and c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and  f.studentapprovalid=g.studentapprovalid  and b.stdschedulestatus='A' and g.studentapprovalid=h.studentapprovalid and c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and g.studentstageallocationstatus='A' and h.discountuserstatus='A'";
	
	//System.out.println("adsfadsfasf>>>>>>>>>>"+select_query);
	result=Integer.parseInt(common_data_object.getString(select_query)) ;
	//System.out.println("getdiscountcountresult>>>>>>>>>"+result);

	} 
	catch (Exception e) {
		e.printStackTrace();
	}
	return result;
}


//get studentapprovalid   students in session for discount category created by selvakumar v
public ArrayList getstudentid(String sessionid,String discountcategoryid){
	ArrayList result=null;
	
	try{
	select_query="select d.studentapprovalid from yearofsession a,discountcategory b,discountamount c,discountusers d where c.sessionid='"+sessionid+"' and " +
	"b.discountcategoryid='"+discountcategoryid+"' and a.sessionid=c.sessionid and c.discountcategoryid=d.discountcategoryid and c.discountcategoryid=b.discountcategoryid" +
	" and b.discountcategorystatus='A' and d.discountuserstatus='A'";
	
	//System.out.println("getdiscountcountpercategory>>>>>>>>>>"+select_query);
	result=common_data_object.getListMap(select_query);
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result;
}



//get  student profile view  created by selvakumar v
public ArrayList getstudentprofileview(String stappid){
	ArrayList result=null;
	try{
	select_query="SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid,s.createdby FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.studentapprovalid='"+stappid+"' and cm.candidateregisterid=s.candidateregisterid and  cm.personid=pm.personid and   cm.candidateregisterstatus='A' and s.studentallocationstatus='A'";
//	System.out.println("getdiscountpersession >>>>"+select_query);
		result=common_data_object.getListMap(select_query); 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}

//get session status created by selvakumar_v 

public String getsessionstatus(String sessionid){
	String result=null;
	
	try{
	select_query="select sessionstatus from yearofsession where sessionid='"+sessionid+"'";
	
	//System.out.println("getdiscountcountpercategory>>>>>>>>>>"+select_query);
	result=common_data_object.getString(select_query);
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result;
}


//get count of  students in session for discount category in ArrayList created by selvakumar v
public ArrayList getdiscountcountpercategoryList(String sessionid,String discountcategoryid){
	ArrayList result=null;
	
	try{
	select_query="select (h.studentapprovalid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f,studentstageallocation g,discountusers h where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and h.discountcategoryid='"+discountcategoryid+"' and c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and  f.studentapprovalid=g.studentapprovalid  and b.stdschedulestatus='A' and g.studentapprovalid=h.studentapprovalid and c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and g.studentstageallocationstatus='A' and h.discountuserstatus='A'";
	
	//System.out.println("getdiscountcountpercategorygetdiscountcountpercategory>>>>>>>>>>"+select_query);
	result=common_data_object.getListMap(select_query);
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result;
}




//remove discount allocation created by selavakumarv
public int removediscountamount(String discountamountid)
		throws Exception {
	log.info("invoking insertdiscountamount for discountamount");
	// Connection connection = null;
	PreparedStatement appstmt = null;
	PreparedStatement appidstmt = null;
	//PreparedStatement recptidstmt = null;
	ResultSet appidrs = null;
//	ResultSet recptidrs = null;
	//ResultSet checkrs = null;
	
	//PreparedStatement checkprepared=null;

	//long recptId = 0l;

	int result = 0;

	String datestr = null;
	// datestr = datetime.showTime("sqlserver");
	

	try {
		applicationConnection = ConnectionManager.getKycConnection();
		applicationConnection.setAutoCommit(false);
	//	select_query = "select max(discountusersid) from discountusers";
		//appidstmt = applicationConnection.prepareStatement(select_query);
	//	appidrs = appidstmt.executeQuery();

    	 
			select_query = "delete from discountamount where discountamountid=?";
			appstmt = applicationConnection.prepareStatement(select_query);
			appstmt.setString(1, discountamountid);
			
			//System.out.println("appstmt removeig"+appstmt);
			result = appstmt.executeUpdate();

		applicationConnection.commit();
	} catch (SQLException e) {
		// System.out.println("Error in applicationInsert");
		log.error("",e);
		e.printStackTrace();

		if (applicationConnection != null)
			applicationConnection.rollback();

		result = 0;

	} finally {

	
		if (appstmt != null)
			appstmt.close();

		if (applicationConnection != null)
			applicationConnection.close();
	}

	return result;
}


//get count of  students in session for discount category in ArrayList created by selvakumar v
public ArrayList getdiscountcategoryreport(String instituteid){
	ArrayList result=null;
	
	try{
	select_query="select discountcategoryname,count(discountusersid) as count,GROUP_CONCAT(b.studentapprovalid) as studentapprovalid from discountcategory a left outer join " +
	"discountusers b on a.discountcategoryid=b.discountcategoryid and b.discountuserstatus='A' where   a.instituteid='"+instituteid+"' and " +
	"a.discountcategorystatus='A' group by a.discountcategoryid";
	
	//System.out.println("getdiscountcountpercategorygetdiscountcountpercategory>>>>>>>>>>"+select_query);
	result=common_data_object.getListMap(select_query);
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result;
}


	String select_query;
	// CommonDataAccess common_data_object;
	ConnectionManager connectionManager;
	Connection applicationConnection;

}
