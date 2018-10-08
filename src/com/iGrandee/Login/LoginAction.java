package com.iGrandee.Login;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet; 
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import org.apache.log4j.Logger;      

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class LoginAction
{
	static Logger log = Logger.getLogger(LoginAction.class);
    public LoginAction()
    {
        common_data_object 		= new CommonDataAccess();
        select_query 			= null;
        username 				= null;	
        userid 	 				= null;	
        usercategory	 		= null;
        institutename 	 		= null;
        firstname 	 			= null;
        middlename 	 			= null;
        lastname 	 			= null;
        instituteid 	 		= null;
        prefix  				= null;
        institutelogo 			= null;
        userstatus 				= null;
        rolename				= null;
        departmentname			= null;
        roleid					= null;
        departmentid			= null;
        staffid					= null;
    }

/**
 * verfiy the user is avaiblae or not.
 * if send the username in capital letter added the validation 
 * @param s
 * @param s1
 * @return
 */
    public int checkUser(String s, String s1)
	{
	    int i = 0;
	    String dbusername = null;
	    try
	    {
	        ArrayList arraylist = null;
	        select_query = "select * from login where username='"+s+"' and loginstatus='A'";
	        
	        arraylist = common_data_object.getListMap(select_query);
	        
	        if(arraylist != null && arraylist.size() > 0)
	        { HashMap hashmap = (HashMap)arraylist.get(0);
	        	dbusername = (String)hashmap.get("username");
	        	if(dbusername.equals(s))
           	 {
           		 i = 1;
           	 }
	        }
	        select_query = null;
	    }
	    catch(Exception exception) { }
	    return i;
	}
    
    public int checkUserParent(String s, String s1)
    {
        int i 				= 0;
        String dbusername = null;
        ArrayList arraylist = null;
        try
        {
            select_query 	= "select * from parentlogin where parentusername='"+s+"'";
            arraylist 		= common_data_object.getListMap(select_query);
            if(arraylist != null && arraylist.size() > 0){
                
            	 HashMap hashmap = (HashMap)arraylist.get(0);
 	        	dbusername = (String)hashmap.get("parentusername");
 	        	if(dbusername.equals(s))
            	 {
            		 i = 1;
            	 }
            }
            
            select_query = null;
        }
        catch(Exception exception) { }
        return i;
    }    
   /**
    * verfiy the username and password is avaiblae or not.
    * if send the username/passowrd in capital letter added the validation 
    * @param username
    * @param password
    * @return
    */
 public int checkPassword(String username, String password)
 {
     int byte0 = 1;
     String dbusername = "";
     String dbpassword = "";
     ArrayList arraylist = null;
     try
     {
    	 //password encryption done here.
    	 password 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(password);
         
       	select_query="select a.username,a.userid,a.usercategory,a.loginstatus,a.password from login a where a.username='"+username+"' and a.password='"+password+"' and a.loginstatus='A'";
        
       //	System.out.print(select_query);
        
       	arraylist = common_data_object.getListMap(select_query);
         if(arraylist != null && arraylist.size() > 0)
         {
             HashMap hashmap = (HashMap)arraylist.get(0);
            // byte0 = 2;
             dbusername = (String)hashmap.get("username");
             dbpassword = (String)hashmap.get("password");
             userid = (String)hashmap.get("userid");
             usercategory = (String)hashmap.get("usercategory");
             userstatus = (String)hashmap.get("status");
             //the following logic added by rams for  checking uppercase username and password
             if(dbusername.equals(username) && dbpassword.equals(password))
        	 {
        		 byte0 = 2;
        	 }
         }
     }
     catch(Exception exception) { 
    	 
    	 exception.printStackTrace();
     }
     return byte0;
 }
 
 
 public int checkPasswordParent(String username, String password)
 {
     int byte0 = 1;
     String dbusername = "";
     String dbpassword = "";
     ArrayList arraylist = null;
     try
     {
    	 //password encryption done here.
    	 password 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(password);
        
       	select_query		= "select a.parentusername,a.parentpassword from parentlogin a where a.parentusername='"+username+"' and a.parentpassword='"+password+"'";
       	arraylist 			= common_data_object.getListMap(select_query);
       	
       	
        if(arraylist != null && arraylist.size() > 0)
        { HashMap hashmap = (HashMap)arraylist.get(0);
        	  dbusername = (String)hashmap.get("parentusername");
              dbpassword = (String)hashmap.get("parentpassword");
              if(dbusername.equals(username) && dbpassword.equals(password))
         	 {
         		 byte0 = 2;
         	 }
         }
     }
     catch(Exception exception) { 
    	 
    	 exception.printStackTrace();
     }
     return byte0;
 }
 
 
 public int getUserDetails(String username, String password, String usercategory)
 {
	 log.info("inside the getUserDetails");
     int byte0 				= 1;
     ArrayList arraylist 	= null;
     String encpassword =null;
     
     try
     {
    	 //password encryption done here.
    	 password 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(password);

       		 select_query	= "select b.staffid,a.username,a.userid,a.usercategory,c.departmentid,c.departmentname,d.roleid,d.rolename,f.firstname,f.middlename,f.lastname,f.prefix, e.instituteid,e.institutename,e.institutelogo from login a, staffmaster b,department c, role d,institution e,personmaster f where a.username='"+username+"' and a.password='"+password+"' and a.usercategory='"+usercategory+"' and a.userid=b.userid and b.departmentid=c.departmentid and b.roleid=d.roleid  and e.instituteid=f.instituteid and e.status='A' and f.personid=a.personid and a.loginstatus='A' and b.staffstatus='A' and c.status='A' and d.status='A' and f.status='A'";
       		 arraylist 		= common_data_object.getListMap(select_query);
	         log.info(select_query);
       		 if(arraylist != null && arraylist.size() > 0){
       			 
	             HashMap hashmap 	= (HashMap)arraylist.get(0);
	             byte0 				= 2;
	             username 			= (String)hashmap.get("username");
	             userid 			= (String)hashmap.get("userid");
	             usercategory 		= (String)hashmap.get("usercategory");
	             institutename 		= (String)hashmap.get("institutename");
	             firstname 			= (String)hashmap.get("firstname");
	             middlename 		= (String)hashmap.get("middlename");
	             lastname 			= (String)hashmap.get("lastname");
	             prefix 			= (String)hashmap.get("prefix");
	             instituteid 		= (String)hashmap.get("instituteid");
	             institutelogo 		= (String)hashmap.get("institutelogo");
	             rolename 			= (String)hashmap.get("rolename");
	             departmentname 	= (String)hashmap.get("departmentname");
	             roleid 			= (String)hashmap.get("roleid");
	             departmentid 		= (String)hashmap.get("departmentid");
	             staffid			= (String)hashmap.get("staffid");
	        }
     }
     catch(Exception exception) { 
    	 log.error(exception);
    	 //exception.printStackTrace();
     }
     return byte0;
 }
 
 
 
 public ArrayList getStudentDetails(String userid)
 {
     ArrayList arraylist = null;
	 
     try
     {
    	 //select_query	= "SELECT e.instituteid,e.institutename,e.institutelogo, d.sectionscheduleid,f.standardscheduleid,i.sectionname,d.studentallocationid, concat(b.firstname,' ',b.lastname) as studentname,b.prefix,case when d.rollno is null then 'Not Yet Generated' else d.rollno end as rollno,(select a1.standardname from standard a1,standardschedule b1 where a1.standardid=b1.standardid and b1.standardscheduleid=f.standardscheduleid) as standardname,(select groupname from standardgroup c1,standardschedule d1 where d1.groupid=c1.groupid and d1.standardscheduleid=f.standardscheduleid) as groupname FROM login a join personmaster b on a.personid=b.personid and a.userid='"+userid+"' join candidateregister c on c.personid=b.personid join studentallocation d on d.studentallocationstatus='A' and c.candidateregisterid=d.candidateregisterid join institution e on b.instituteid=e.instituteid join sectionschedule f on d.sectionscheduleid=f.sectionscheduleid join section i on f.sectionid=i.sectionid and i.status='A'";	
    	 select_query	= "SELECT e.instituteid,e.institutename,e.institutelogo, d.sectionscheduleid,f.standardscheduleid,i.sectionname,d.studentallocationid, concat(b.firstname,' ',b.lastname) as studentname,b.prefix,case when d.rollno is null then 'Not Yet Generated' else d.rollno end as rollno,(select case when mediumname is null or mediumname='' then c1.boardname else concat(boardname,' -',mediumname) end as boardname from standard a1,standardschedule b1,board c1,standardmedium d1 where a1.standardid=b1.standardid and b1.standardscheduleid=f.standardscheduleid and c1.boardid=a1.boardid and c1.mediumid=d1.mediumid) as boardname,(select a1.standardname from standard a1,standardschedule b1 where a1.standardid=b1.standardid and b1.standardscheduleid=f.standardscheduleid) as standardname,(select groupname from standardgroup c1,standardschedule d1 where d1.groupid=c1.groupid and d1.standardscheduleid=f.standardscheduleid) as groupname FROM login a join personmaster b on a.personid=b.personid and a.userid='"+userid+"' join candidateregister c on c.personid=b.personid join studentallocation d on d.studentallocationstatus='A' and c.candidateregisterid=d.candidateregisterid join institution e on b.instituteid=e.instituteid join sectionschedule f on d.sectionscheduleid=f.sectionscheduleid join section i on f.sectionid=i.sectionid and i.status='A' join standardschedule j on j.standardscheduleid=f.standardscheduleid and j.stdschedulestatus='A' join yearofsession k on k.sessionid=j.sessionid and k.sessionstatus='A'";
    	 
//    	 System.out.println("query==========>>>>>>>"+select_query);	  
    	 log.info(select_query);
       	 arraylist 		= common_data_object.getListMap(select_query);
       	// System.out.println("query==========>>>>>>>"+arraylist);	    

     }
     catch(Exception exception) { 
    	 
    	 exception.printStackTrace();
     }
     return arraylist;
 }
 
 /*
  * Method added by Kumaran Ramu for getting the active session name and sessionid.
 */
 
 public ArrayList getSessionDetails()
 {
     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select sessionid,sessionname from yearofsession where sessionstatus='A'";
       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 
    	 
    	 exception.printStackTrace();
     }
     return arraylist;
 }
 
 public ArrayList getSessionDetails(String instituteid)
 {
     ArrayList arraylist = null;
	 
     try
     {
       		select_query	= "select sessionid,sessionname from yearofsession where sessionstatus='A' and instituteid='"+instituteid+"'";
       		arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 
    	 
    	 exception.printStackTrace();
     }
     return arraylist;
 }
 
 
 
 public ArrayList getParentDetails(String username,String password)
 {
     ArrayList arraylist = null;
	 
     try
     {
    	 password 	= com.iGrandee.Common.PasswordService.getInstance().encrypt(password);

       		//select_query	= "select a.parentloginid,d.fathername,d.mothername,d.instituteid,e.institutename,institutelogo from parentlogin a join studentparent b on a.parentusername='"+username+"' and a.parentpassword='"+password+"' and a.parentloginid=b.parentid join login c on b.userid=c.userid join personmaster d on c.personid=d.personid join institution e on d.instituteid=e.instituteid";
    	 	select_query	= "select j.sessionname,j.sessionstatus,b.studentparentid,b.userid,a.parentloginid,d.fathername,d.mothername,d.instituteid,e.institutename,institutelogo from parentlogin a join studentparent b on a.parentusername='"+username+"' and a.parentpassword='"+password+"' and a.parentloginid=b.parentid and a.parentstatus='A' join login c on b.userid=c.userid join personmaster d on c.personid=d.personid and c.loginstatus='A' join candidateregister f on f.personid = d.personid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus='A' join sectionschedule h on h.sectionscheduleid=g.sectionscheduleid and h.sectionschedulestatus='A' join standardschedule i on i.standardscheduleid=h.standardscheduleid and i.stdschedulestatus='A' join yearofsession j on j.sessionid=i.sessionid and j.sessionstatus in ('A','R') join institution e on d.instituteid=e.instituteid and e.status='A' order by j.sessionstatus";    	 
    	 	arraylist 		= common_data_object.getListMap(select_query);
     }
     catch(Exception exception) { 
    	 
    	 exception.printStackTrace();
     }
     return arraylist;
 }
 /**
  * This method is accessed from kycportal/forgotsubmit.jsp
  * forgot password  request     - prasanth
  @param username that can be used to get password  from parentlogin for others mode
  * 
  @param emailid that can be used to get password from parentlogin for others mode
  *
  @return the int by which result can be printed on the screen
 */
 public ArrayList getpasswordforothers(String username,String emailid) {
     ArrayList arraylist = null;
		try {
		
		
			select_query = "select case when b.middlename='-' or b.middlename='' or b.middlename  is null then concat(b.prefix,b.firstname,' ',b.lastname) else concat(b.prefix,b.firstname,' ',b.middlename,' ',b.lastname) end as uname,a.password,a.userid from login a, personmaster b where a.personid=b.personid and a.username='"+username+"' and b.emailid='"+emailid+"' and a.loginstatus='A' and b.status='A'";
	    	log.info(select_query);
       		arraylist 		= common_data_object.getListMap(select_query);
		
		} catch (Exception exception)
		{
			
		}
		return arraylist;
	}
 /**
   * This method is accessed from kycportal/forgotsubmit.jsp
   * forgot password  request     - prasanth
   @param parentusername that can be used to get all details from parentlogin for parent
   * 
   @param emailid that can be used to get all details from parentlogin
   *
   @return the int by which result can be printed on the screen
 */
 public ArrayList getpasswordforparent(String parentusername,String guardianmailid) {
     ArrayList arraylist = null;
		try {
	    	
		//	select_query = "select  d.fathername as uname, a.parentpassword,c.userid from parentlogin a,studentparent b,login c,personmaster d where a.parentusername='"+parentusername+"' and a.parentstatus='A' and b.parentid=a.parentloginid and b.userid=c.userid and b.studentparentstatus='A' and c.loginstatus='A' and c.personid=d.personid and d.status='A' and d.emailid='"+emailid+"'";
			//query is changed by rams, the parent email taken from studentguardian
			select_query = "select distinct d.fathername as uname,c.userid,e.guardianmailid from parentlogin a,studentparent b,login c,personmaster d,studentguardian e where a.parentusername='"+parentusername+"' and e.guardianmailid='"+guardianmailid+"' and a.parentloginid=b.parentid and c.userid=b.userid and d.personid=c.personid and e.personid=d.personid and a.parentstatus='A' and b.studentparentstatus='A' and c.loginstatus='A' and d.status='A' and e.studentguardianstatus='A'";
			log.info(select_query);
       		arraylist 		= common_data_object.getListMap(select_query);
		
		} catch (Exception exception)
		{	
			log.info(exception);
		}
		return arraylist;
	}
 
 
 /**
  * This method is accessed from kycportal/forgotsubmit.jsp
  * forgot password  request     - prasanth
  * @param username that can be used to get all details from login
  *
  @param flage that can be used for if condition
  *
  @return the int by which result can be printed on the screen
 */
 public int checkUserForForgotpsw(String username, String flage)
	{
	    int i = 0;
	    try
	    {
	        ArrayList arraylist = null;
	        if(flage.equals("others"))
	        {
	        select_query = "select * from login where username='"+username+"' and loginstatus='A'";
	        }
	        else if(flage.equals("parent"))
	        {
		        select_query = "select * from parentlogin where parentusername='"+username+"' and parentstatus='A'";

	        }
	       // System.out.print(select_query);
	        arraylist = common_data_object.getListMap(select_query);
	        if(arraylist != null && arraylist.size() > 0)
	        {
	            i = 1;
	        }
	        select_query = null;
	    }
	    catch(Exception exception) { log.info(exception);}
	    return i;
	}
 
 /**
  * This method is accessed from kycportal/forgotsubmit.jsp
  * forgot password  request     - prasanth
  @param parentusername that can be used to get all details from parentlogin for parent
  * 
  @param emailid that can be used to get all details from parentlogin
  *
  @return the int by which result can be printed on the screen
*/
public ArrayList getInstDetailForgotPass(String username, String mailid, String flage) {
    ArrayList arraylist = null;
		try {
	        if(flage.equals("others"))
	        {
	        select_query = "select a1.city,a1.zip,a1.institutename,a1.contactaddress,a1.country,a1.state,a1.landlinenumber,a1.mobilenumber,a1.emailid,a1.fax,a1.institutelogo,a1.url from login a, personmaster b,institution a1 where a.personid=b.personid and a.username='"+username+"' and b.emailid='"+mailid+"' and a.loginstatus='A' and b.status='A' and a1.status='A' and a1.instituteid=b.instituteid"; 
	        }
	        else if(flage.equals("parent"))
	        {
		        select_query = "select a1.city,a1.zip,a1.institutename,a1.contactaddress,a1.country,a1.state,a1.landlinenumber,a1.mobilenumber,a1.emailid,a1.fax,a1.institutelogo,a1.url from parentlogin a,studentparent b,login c,personmaster d,studentguardian e,institution a1 where a.parentusername='"+username+"' and e.guardianmailid='"+mailid+"' and a.parentloginid=b.parentid and c.userid=b.userid and d.personid=c.personid and e.personid=d.personid and a.parentstatus='A' and b.studentparentstatus='A' and c.loginstatus='A' and d.status='A' and e.studentguardianstatus='A'  and a1.status='A' and a1.instituteid=d.instituteid"; 
	        }
	       // System.out.print(select_query);
	        arraylist = common_data_object.getListMap(select_query);	    	
			log.info(select_query);
      		arraylist 		= common_data_object.getListMap(select_query);
		
		} catch (Exception exception)
		{	
			log.info(exception);
		}
		return arraylist;
	}
 public String getuserid()
 {
     return userid;
 }
 public String getstaffid()
 {
     return staffid;
 }

 public String getcategory()
 {
     return usercategory;
 }
 
 public String getusername()
 {
     return username;
 }
 
 public String getinstitutename()
 {
     return institutename;
 }
 
 public String getfirstname()
 {
     return firstname;
 }
 
 public String getmiddlename()
 {
     return middlename;
 }
 
 public String getlastname()
 {
     return lastname;
 }
 public String getinstituteid()
 {
     return instituteid;
 }
 public String getprefix()
 {
     return prefix;
 }
 public String getinstitutelogo()
 {
     return institutelogo;
 }
 public String getuserstatus()
 {
     return userstatus;
 }
 
 public String getRolename()
 {
     return rolename;
 }
 

 public String getDepartmentname()
 {
     return departmentname;
 }

 public String getDepartmentid()
 {
     return departmentid;
 }

 public String getRoleid()
 {
     return roleid;
 }
 
 
	public int insertPasswordRequest(String username,String email,String requestedby,String userid)throws SQLException
	{
		PreparedStatement assignstmt 	= null;
		ResultSet idrs					= null;
		PreparedStatement idstmt 		= null;
		long  assignmenid				= 0l;

		int returnvalue					= 0;
		String sqlquery					= "";
		Connection connection			= null;



		try {

			connection 	= ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			String temptime 			= 	DateTime.showTime("MySqlWithTime");

	
			sqlquery	= "select max(forgotpassid) from forgotpassword";
			idstmt		= connection.prepareStatement(sqlquery);
			idrs 		= idstmt.executeQuery();

			if(idrs.next()) {
				assignmenid	= idrs.getLong(1);
			}
			assignmenid ++;

			sqlquery			= "insert into forgotpassword(forgotpassid, username, email, dateofrequest, userid, status, requestedby) values(?,?,?,?,?,?,?)";
			assignstmt			= connection.prepareStatement(sqlquery);

			assignstmt.setLong(1,assignmenid);
			assignstmt.setString(2,username);
			assignstmt.setString(3,email);
			assignstmt.setString(4,temptime);
			assignstmt.setString(5,userid);
			assignstmt.setString(6,"A");
			assignstmt.setString(7,requestedby);

			returnvalue 		+= assignstmt.executeUpdate();

			connection.commit();
			
			
		}
		catch(Exception exception) {
			
 			log.error(exception);
			if(connection != null)
				connection.rollback();
			returnvalue	= 0;
			
		}
		finally{

			if(idrs != null)
				idrs.close();

			if(idstmt != null)
				idstmt.close();

			if(assignstmt != null)
				assignstmt.close();

			if(connection != null)
				connection.close();
			
		}

		return returnvalue;

	}
 
 
 CommonDataAccess common_data_object;
 String select_query;
 String userid;
 String usercategory;
 String username;
 String prefix;
 String institutename;  
 String firstname;
 String middlename;
 String lastname;
 String instituteid;
 String institutelogo;
 String userstatus;
 String rolename;
 String departmentname;
 String roleid;
 String departmentid;
 String staffid;
 
 
}