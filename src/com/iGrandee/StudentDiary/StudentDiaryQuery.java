package com.iGrandee.StudentDiary;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

public class StudentDiaryQuery
{
	static Logger log = Logger.getLogger(StudentDiaryQuery.class);

    public StudentDiaryQuery()
    {
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        date_object = new DateTime();
        instituteconn      = null;
       select_query = null;
    }

    public int insertnewStudentDiary(StudentDiaryBean instituteBean)throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
 
        try
        
    	{//studentdiaryid, subject, workdetails, subjectscheduleid, ipaddress, studentdiarycreateiondate, credatedby, studentdiarystatus
		 	log.info("invoking insertStandard for Stanard Insertion");

        instituteconn = ConnectionManager.getKycConnection();
        
		long l = common_data_object.fmaxId("select max(studentdiaryid)from studentdiary");

		String query="insert into studentdiary (studentdiaryid,subject,workdetails,studentdiarycreateiondate,credatedby,subjectscheduleid,studentdiarystatus,ipaddress) values(?,?,?,?,?,?,?,?)";
		settingsprepared = instituteconn.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,instituteBean.getsubjectypename());
		settingsprepared.setString(3,instituteBean.getDescription());
		settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(5, instituteBean.getCreatedBy());
		settingsprepared.setString(6, instituteBean.getsubjectscheduleid());
		settingsprepared.setString(7, "A");
		settingsprepared.setString(8, instituteBean.getIpaddess());

	result = settingsprepared.executeUpdate();
	

    	}catch(Exception exception) { 
			
			log.error(exception);
			
		}
		
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
return result;
}
   
  
  
  
    public ArrayList getAllYearsFaculty(String userid)
    {
		ArrayList list=null;
		try
		{	
			log.info("invoking insertStandard for Stanard Insertion");
			select_query="select e.sessionid,e.sessionname from subjectallotment a,sectionschedule b,section c,standardschedule d,yearofsession e,staffmaster g where subjectallotmentstatus='A' and a.sectionpublishid=b.sectionscheduleid and b.sectionschedulestatus='A' and c.sectionid=b.sectionid and c.status='A' and b.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' and e.sessionid=d.sessionid and e.sessionstatus='A' and g.userid='"+userid+"'";

			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		return list;
	}
   
   
    public ArrayList getStaffStandards(String combonames,String userid)
    {
	 	log.info("**********"+combonames+userid);

  
		ArrayList list=null;
		try
		{		 	log.info("invoking insertStandard for Stanard Insertion");
		if(combonames!=null && combonames.equals("standard"))
		{
			select_query="select f.standardid,f.standardname from subjectallotment a,sectionschedule b,section c,standardschedule d,yearofsession e,standard f ,staffmaster g where subjectallotmentstatus='A' and a.sectionpublishid=b.sectionscheduleid and b.sectionschedulestatus='A' and c.sectionid=b.sectionid and c.status='A' and b.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' and e.sessionid=d.sessionid and e.sessionstatus='A' and d.standardid=f.standardid and g.userid='"+userid+"' and f.standardstatus='A'";

			list=common_data_object.getListMap(select_query);
		}
		if(combonames!=null && combonames.equals("section"))
		{
			select_query="select c.sectionid,c.sectionname from subjectallotment a,sectionschedule b,section c,standardschedule d,yearofsession e,standard f ,staffmaster g where subjectallotmentstatus='A' and a.sectionpublishid=b.sectionscheduleid and b.sectionschedulestatus='A' and c.sectionid=b.sectionid and c.status='A' and b.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' and e.sessionid=d.sessionid and e.sessionstatus='A' and d.standardid=f.standardid and g.userid='"+userid+"' and f.standardstatus='A'";

			list=common_data_object.getListMap(select_query);
		}
		if(combonames!=null && combonames.equals("subject"))
		{
			select_query="select a.subjectscheduleid,h.subjectname from subjectallotment a,sectionschedule b,section c,standardschedule d,yearofsession e,standard f ,staffmaster g ,subject h where subjectallotmentstatus='A' and a.sectionpublishid=b.sectionscheduleid and b.sectionschedulestatus='A' and c.sectionid=b.sectionid and c.status='A' and b.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' and e.sessionid=d.sessionid and e.sessionstatus='A' and d.standardid=f.standardid and g.userid='"+userid+"' and f.standardstatus='A' and h.subjectstatus='A' and h.standardid=d.standardid";

			list=common_data_object.getListMap(select_query);
		}
		}
		catch(Exception exception)
		{
			log.error(exception);

		}
		
		return list;
	 }	
		
   
    public ArrayList getAllExistingStudent(String userid,String subjectscheduleid)
    {
		ArrayList list=null;
		try
		{
			//select_query="select studentdiaryid,subject,workdetails,DATE_FORMAT(studentdiarycreateiondate, '%d-%b-%Y') as newdates from studentdiary";
			
			select_query="select distinct b.sectionscheduleid,i.studentdiaryid,i.subject,i.workdetails,DATE_FORMAT(i.studentdiarycreateiondate, '%d-%b-%Y') as newdates from subjectallotment a,sectionschedule b,section c,standardschedule d,yearofsession e, standard f ,staffmaster g ,studentdiary i, subject h where subjectallotmentstatus='A' and a.sectionpublishid=b.sectionscheduleid and b.sectionschedulestatus='A' and c.sectionid=b.sectionid and c.status='A' and b.standardscheduleid=d.standardscheduleid and d.stdschedulestatus='A' and e.sessionid=d.sessionid and e.sessionstatus='A' and d.standardid=f.standardid and g.userid='"+userid+"' and f.standardstatus='A' and h.subjectstatus='A' and h.standardid=d.standardid and i.subjectscheduleid=a.subjectscheduleid and i.studentdiarystatus='A' and a.subjectscheduleid='"+subjectscheduleid+"'";
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
	}
   
   
    public int UpdateEdittStudentDiary(StudentDiaryBean instituteBean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	int result=0;

    	try
    	{//studentdiaryid, subject, workdetails, subjectscheduleid, ipaddress, studentdiarycreateiondate, credatedby, studentdiarystatus
        	String deptname=instituteBean.getsubjectypename();
        	String subjecttypeid=instituteBean.getsubjecttypeid();
        	String deptdesi=instituteBean.getDescription();
    		
            instituteconn = ConnectionManager.getKycConnection();

			String query="update studentdiary set subject=?, workdetails=?,credatedby=?,ipaddress=?,studentdiarycreateiondate=?  where studentdiaryid=? ";
			settingsprepared = instituteconn.prepareStatement(query);
			
			settingsprepared.setString(1, deptname);
			settingsprepared.setString(2,deptdesi);
			settingsprepared.setString(3, instituteBean.getCreatedBy());
			settingsprepared.setString(4, instituteBean.getIpaddess());
			settingsprepared.setString(5, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(6,instituteBean.getstudentdiaryid());
			//System.out.println("*********"+deptname+deptdesi+instituteBean.getCreatedBy()+instituteBean.getstudentdiaryid());
			rs = settingsprepared.executeUpdate();
			
			

			result = settingsprepared.executeUpdate();
			
			



    		
    	}
    	catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	return rs;
    }
    public int updateDiaryDetails(StudentDiaryBean instituteBean)  throws SQLException
    {
    	PreparedStatement settingsprepared  = null;
		PreparedStatement instituteprepared = null;

    	int rs=0;
    	
    	int result=0;

    	try
    	{//studentdiaryid, subject, workdetails, subjectscheduleid, ipaddress, studentdiarycreateiondate, credatedby, studentdiarystatus
        	String deptname=instituteBean.getsubjectypename();
        	String deptdesi=instituteBean.getDescription();
    		
            instituteconn = ConnectionManager.getKycConnection();

			String query="update studentdiary set subject=?,workdetails=?, studentdiarycreateiondate=?,credatedby=?,ipaddress=? where studentdiaryid=? ";
			settingsprepared = instituteconn.prepareStatement(query);
			
			settingsprepared.setString(1, deptname);
			settingsprepared.setString(2, deptdesi);

			settingsprepared.setString(3, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(4, instituteBean.getCreatedBy());
			settingsprepared.setString(5, instituteBean.getIpaddess());

			settingsprepared.setString(6,instituteBean.getstudentdiaryid());
			rs = settingsprepared.executeUpdate();
			//System.out.println("******"+deptname+instituteBean.getstudentdiaryid()+deptdesi+instituteBean.getCreatedBy()+instituteBean.getIpaddess());
			
		
    	}
    	catch(Exception exception) { 
			
			exception.printStackTrace();
			
		}
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	return rs;
    }
   
    public int StudentDiaryAssign(StudentDiaryBean instituteBean)throws SQLException
    {
		int result=0;

    	PreparedStatement settingsprepared  = null;
 
        try
        
    	{//diaryallocationid, studentdiaryid, submissiondate, sectionscheduleid, allocationdate, createdby, diaryallocationstatus
		 	log.info("fgd");

        instituteconn = ConnectionManager.getKycConnection();
        String subdate=instituteBean.getsubmissiondate();
		long l = common_data_object.fmaxId("select max(diaryallocationid)from diaryallocation");

		String query="insert into diaryallocation (diaryallocationid,studentdiaryid,submissiondate,sectionscheduleid,allocationdate,createdby,diaryallocationstatus) values(?,?,?,?,?,?,?)";
		settingsprepared = instituteconn.prepareStatement(query);
		
		settingsprepared.setLong(1, l);
		settingsprepared.setString(2,instituteBean.getstudentdiaryid());
		String dateofff=date_object.getMySQLFormat(subdate)+"";
		settingsprepared.setString(3, dateofff);
		settingsprepared.setString(4, instituteBean.getsectionscheduleid());
		settingsprepared.setString(5, DateTime.showTime("MySqlWithTime"));
		settingsprepared.setString(6, instituteBean.getCreatedBy());
		settingsprepared.setString(7, "A");
		//System.out.println("*********"+instituteBean.getsubmissiondate()+instituteBean.getstudentdiaryid()+instituteBean.getsectionscheduleid()+instituteBean.getCreatedBy());
		
	result = settingsprepared.executeUpdate();
	

    	}catch(Exception exception) { 
			
			log.error(exception);
			
		}
		
    	finally
		{
			if(settingsprepared != null)
				settingsprepared.close();
			
			if(instituteconn != null)
				instituteconn.close();
		}
    	
       
return result;
}
public ArrayList StudntDiarySubjects()
 {
		ArrayList list=null;
		try
		{
			String curdat=DateTime.showTime("");
			//System.out.println("******cu***"+curdat);
			select_query="select  DATE_FORMAT(CURRENT_TIMESTAMP(), '%d-%b-%Y') as newdates, DATE_FORMAT(b.submissiondate, '%d-%b-%Y') as subdates, a.subject from studentdiary a, diaryallocation b where b.sectionscheduleid='1' and a.studentdiaryid=b.studentdiaryid and a.studentdiarycreateiondate between concat(CURRENT_DATE(),' 00:00:00') and concat(CURRENT_DATE(),' 23:59:59')";
			//System.out.println("***"+select_query);
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception exception)
		{
		}
		return list;
}
public ArrayList searchStudentDiary(String startdate,String enddate)
{
	ArrayList list=null;
	try
	{
		String Startdate=date_object.getMySQLFormat(startdate)+"";
		String Enddate=date_object.getMySQLFormat(enddate)+"";
		select_query="select  a.subject,DATE_FORMAT(b.submissiondate, '%d-%b-%Y') as subdates,b.diaryallocationid from studentdiary a, diaryallocation b where a.studentdiaryid=b.studentdiaryid and b.sectionscheduleid='1' and a.studentdiarycreateiondate between '"+Startdate+"' and '"+Enddate+"'";
		list=common_data_object.getListMap(select_query);
	}
	catch(Exception exception)
	{
	}
	return list;
}//
public int setStudentReply(StudentDiaryBean instituteBean)throws SQLException
{
	int result=0;

	PreparedStatement settingsprepared  = null;

    try
    
	{//studentdiaryreplyid, diaryallocationid, userid, studentdiaryremarks, diaryfilepath, studentreplydate, studentreplyipaddress, staffdiaryremarks, staffdiaryreplydate, dairyreplystatus
	 	log.info("invoking insert for Student Reply Insertion");

    instituteconn = ConnectionManager.getKycConnection();
    
	long l = common_data_object.fmaxId("select max(studentdiaryreplyid)from diaryreply");

	String query="insert into diaryreply (studentdiaryreplyid,diaryallocationid,userid,studentdiaryremarks,diaryfilepath,studentreplydate,studentreplyipaddress,staffdiaryremarks,staffdiaryreplydate,dairyreplystatus) values(?,?,?,?,?,?,?,?,?,?)";
	settingsprepared = instituteconn.prepareStatement(query);
	//System.out.println("*****query**"+l+instituteBean.getdiaryallocationid()+instituteBean.getuserid()+instituteBean.getstudentreplyremarks()+instituteBean.getIpaddess());

	settingsprepared.setLong(1, l);
	settingsprepared.setString(2,instituteBean.getdiaryallocationid());
	settingsprepared.setString(3,instituteBean.getuserid());
	settingsprepared.setString(4, instituteBean.getstudentreplyremarks());
	settingsprepared.setString(5, "");
	settingsprepared.setString(6, DateTime.showTime("MySqlWithTime"));
	settingsprepared.setString(7, instituteBean.getIpaddess());

	settingsprepared.setString(8, "");
	settingsprepared.setString(9,DateTime.showTime("MySqlWithTime"));
	settingsprepared.setString(10, "A");

result = settingsprepared.executeUpdate();

	}catch(Exception exception) { 
		
		//log.error(exception);
		exception.printStackTrace();
		
	}
	
	finally
	{
		if(settingsprepared != null)
			settingsprepared.close();
		
		if(instituteconn != null)
			instituteconn.close();
	}
return result;
}   //
public ArrayList getDiaryforHomeScreenScreen(String standardscheduleid)
{
	ArrayList list=null;
	try
	{
		select_query="select a.studentdiaryid,a.subject,a.workdetails  from studentdiary a,sectionschedule b,standardschedule c where a.dairysubmissiondate>=curdate() and a.studentdiarystatus = 'A' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardscheduleid='"+standardscheduleid+"' AND b.sectionschedulestatus='A' and c.stdschedulestatus='A' and a.dairysubmissiondate>=curdate();";
		list=common_data_object.getListMap(select_query);
	}
	catch(Exception exception)
	{
	}
	return list;
}
public ArrayList getDiaryforHMHomeScreenScreen(String sessionid)
{
	ArrayList list=null;
	try
	{
		select_query="select * from studentdiary a,sectionschedule b ,standardschedule c where  a.dairysubmissiondate>=curdate() and a.studentdiarystatus = 'A' and b.sectionscheduleid=a.sectionscheduleid and b.sectionschedulestatus='A'  and a.dairysubmissiondate>=curdate() and c.standardscheduleid=b.standardscheduleid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A'";
		list=common_data_object.getListMap(select_query);
	}
	catch(Exception exception)
	{
	}
	return list;
}
    DateTime date_object;
    Connection instituteconn;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}