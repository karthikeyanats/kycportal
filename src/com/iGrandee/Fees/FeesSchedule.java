package com.iGrandee.Fees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Fees.FeesScheduleBean;

import org.apache.log4j.Logger;

public class FeesSchedule
{
	static Logger log = Logger.getLogger(FeesHeadQuery.class);
	public FeesSchedule()
	{
		common_data_object = new CommonDataAccess();
		connectionManager  = new ConnectionManager();
		feesstructureConnection = null;
		rollbackvalue = 0;
		select_query= "";
	}
	
	
	public int insertStandardFeesStructure(FeesScheduleBean feesscheduleBean) throws Exception
	 {
		 	log.info("invoking insertStandardFeesStructure for Stanard Fees Structure");
		 
		 	int result	= 0;
			PreparedStatement standardfeesstructureprepared = null;
			String currentdate	= DateTime.showTime("MySqlWithTime");
			
			//feesscheduleid, feesscheduleid, standardscheduleid, feesscheduleamount, dateofcreation, createdby, feesschedulestatus
	 try
	 {
		 	feesstructureConnection = ConnectionManager.getKycConnection();
			feesstructureConnection.setAutoCommit(false);
			
			
			
			String query="select max(feesscheduleid) from feesschedule";
			long feesscheduleid = common_data_object.maxId(query);
			feesscheduleid++;

			query="insert into feesschedule (feesscheduleid, feesheadid, standardscheduleid, feesscheduleamount, dateofcreation, createdby, feesschedulestatus) values(?,?,?,?,?,?,?)";
			standardfeesstructureprepared = feesstructureConnection.prepareStatement(query);
			standardfeesstructureprepared.setLong(1, feesscheduleid);
			standardfeesstructureprepared.setString(2,feesscheduleBean.getFeesheadid());
			standardfeesstructureprepared.setString(3,feesscheduleBean.getStandardscheduleid());
			standardfeesstructureprepared.setString(4,feesscheduleBean.getFeesscheduleamount());
			standardfeesstructureprepared.setString(5, currentdate);
			standardfeesstructureprepared.setString(6,feesscheduleBean.getCreatedby());
			standardfeesstructureprepared.setString(7,"A");
			result += standardfeesstructureprepared.executeUpdate();
			
			feesstructureConnection.commit();
	 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(feesstructureConnection != null)
				feesstructureConnection.rollback();
	 }
	 finally
		{
	 
		 if(standardfeesstructureprepared != null)
			standardfeesstructureprepared.close();
		
		 if(feesstructureConnection != null)
		 feesstructureConnection.close();
		 }
	 return result;
	 }
	
	//update feesschedule amount
	public int updateFeesschedule(FeesScheduleBean feesscheduleBean) throws Exception
	 {
		 	log.info("invoking updateLesson for Stanard Lesson Updation");
		 
		 	int result	= 0;
			PreparedStatement standardfeesstructureupdateprepared = null;
			//String currentdate			= DateTime.showTime("MySqlWithTime");
	 try
	 {
		 	feesstructureConnection = ConnectionManager.getKycConnection();
			feesstructureConnection.setAutoCommit(false);
			
			/*String operationstatus = (String)FeesScheduleBean.getFeesoperation();
			if(operationstatus.equals("updatestatus"))
			{
				select_query="update lesson set feesheadstatus=? where feesheadid=?";
				standardfeesstructureupdateprepared = feesstructureConnection.prepareStatement(select_query);
				standardfeesstructureupdateprepared.setString(1,FeesScheduleBean.getFeesheadstatus());
				standardfeesstructureupdateprepared.setString(2,FeesScheduleBean.getFeesheadid());
				result += standardfeesstructureupdateprepared.executeUpdate();
				feesstructureConnection.commit();
				
			}
			else if(operationstatus.equals("updatefeeshead"))
			{*/
				select_query="update feesschedule set feesscheduleamount=? where feesscheduleid=?";
				standardfeesstructureupdateprepared = feesstructureConnection.prepareStatement(select_query);
				standardfeesstructureupdateprepared.setString(1,feesscheduleBean.getFeesscheduleamount());
				standardfeesstructureupdateprepared.setString(2,feesscheduleBean.getFeesscheduleid());
				result += standardfeesstructureupdateprepared.executeUpdate();
				feesstructureConnection.commit();
			//}
		
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(feesstructureConnection != null)
				feesstructureConnection.rollback();
	 }
	 finally
		{
	 
		 if(standardfeesstructureupdateprepared != null)
			standardfeesstructureupdateprepared.close();
		
		 if(feesstructureConnection != null)
		 feesstructureConnection.close();
		 }
	 return result;
	 }
	
	public ArrayList loadFeesTermDetails(String standardscheduleid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	   	
        	//select_query = "select a.termfeesid,b.termid,b.termname,a.termfeesamount,date_format(duedate,'%d-%m-%Y') duedate from termfees a join standardschedule c on a.standardscheduleid=c.standardscheduleid and a.standardscheduleid='"+standardscheduleid+"' right outer join feestermname b on  a.termid=b.termid";
        	select_query="select c.termfeesid,b.termid,b.termname,c.termfeesamount,date_format(duedate,'%d-%b-%Y') duedate from standardschedule a join feestermname b on a.standardscheduleid='"+standardscheduleid+"' and a.instituteid=b.instituteid and b.termstatus='A' left outer join termfees c on a.standardscheduleid=c.standardscheduleid and c.termfeesstatus='A' and b.termid=c.termid order by b.termid;";
        	//System.out.println("select_query"+select_query);
	        arraylist = common_data_object.getListMap(select_query);
	      //  System.out.println("arraylist"+arraylist);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	//load term amount from termstructure
	
	
	public ArrayList loadFeesAllotedTermDetailsforUpdate(String standardscheduleid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select a.termfeesid,b.termname,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') duedate from termfees a,feestermname b where a.termid=b.termid and standardscheduleid='"+standardscheduleid+"' and a.termfeesstatus='A' and b.termstatus='A'";
        	
        	select_query = "select c.feescollectionid,a.termfeesid,b.termname,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') duedate,count(feescollectionid) as collectioncount from feestermname b,termfees a left outer join feescollection c 	on c.termfeesid=a.termfeesid where a.termid=b.termid and standardscheduleid='"+standardscheduleid+"' and a.termfeesstatus='A' and b.termstatus='A' group by a.termfeesid";
        	
        	log.info(select_query);
        	//System.out.print("select_query-->"+select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public ArrayList loadFeesAllotedTermDetails(String standardscheduleid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select a.termfeesid,b.termname,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') duedate from termfees a,feestermname b where a.termid=b.termid and standardscheduleid='"+standardscheduleid+"' and a.termfeesstatus='A' and b.termstatus='A'";
        	
        	select_query = "select a.termfeesid,b.termname,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') duedate,(SELECT count(a1.feescollectionid) FROM feescollection a1,termfees b1 where a1.termfeesid=b1.termfeesid and b1.standardscheduleid='"+standardscheduleid+"') as collectioncount from termfees a,feestermname b where a.termid=b.termid and standardscheduleid='"+standardscheduleid+"' and a.termfeesstatus='A' and b.termstatus='A'";
        	
        	log.info(select_query);
        //	System.out.print("select_query-->"+select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
	//check term fees id assigned to feescollection
	
	public boolean checkTermFeesAllocaiton(String termfeesid)
    {
        ArrayList arraylist = new ArrayList();
        boolean termfeesflag = false;
        try
        {
        	select_query = "select feescollectionid from feescollection where termfeesid='"+termfeesid+"' and feescollectionstatus='A'";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
	        if(arraylist ==null || arraylist.size() ==0)
	        	termfeesflag=false;
	        else 
	        	termfeesflag= true;
        }catch(Exception e){log.error(e);}
        return termfeesflag;
    }
	public String loadFeesAmount(String standardscheduleid)
    {
		 String returnStr = null;
        try
        {
        	select_query = "select sum(feesscheduleamount) as totalamount from feesschedule where standardscheduleid='"+standardscheduleid+"' and feesschedulestatus='A'";
        	log.info(select_query);
        	returnStr = common_data_object.getString(select_query);
        }catch(Exception e){log.error(e);}
        return returnStr;
    }
	
	public ArrayList checkandLoadStudent(String rollnumber)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A'";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public ArrayList checkandLoadStudent(String rollnumber,String instituteid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
        	select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.fathername,i.imagepath,i.prefix,h.studentapprovalid, j.userid,k.sessionname,k.sessionid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i, login j,yearofsession k where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"' and a.studentallocationstatus='A' and i.personid=j.personid and j.loginstatus='A' and k.sessionid=c.sessionid and k.sessionstatus<>'T'";
        	 
        	log.info(select_query);
        	///System.out.println("checkandLoadStudent>>"+select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
	// Get Category name for student stage allocation - Sindhu.V Sep-18-2013
	public ArrayList Categoryname(String sessionid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
          	select_query = "select tc.transportcategoryid,tc.transportcategoryname,itt.sessionid from transportcategory tc,institutetransporttype itt where tc.institutetransporttypeid=itt.institutetransporttypeid and tc.transportcategorystatus='A' and itt.institutetransporttypestatus='A' and itt.sessionid='"+sessionid+"'";
        	 
        	log.info(select_query);
        	//System.out.println("checkandLoadStudent>>"+select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
	
	public String loadPaidAmount(String studentapprovalid,String transportcategoryid)
    {
		 String s=null;
        try
        {
        	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
        	//select_query = "select b.paidamount from studentstageallocation a,transportfeescollection b where studentapprovalid='"+studentapprovalid+"' and studentstageallocationstatus<>'T' and transportcategoryid='"+transportcategoryid+"' and a.studentstageallocationid=b.studentstageallocationid;";
        	
        	//select_query = "select b.paidamount from studentstageallocation a,transportfeescollection b  where studentapprovalid='"+studentapprovalid+"' and studentstageallocationstatus<>'T'      	and b.transportcategoryid='"+transportcategoryid+"' and  a.transportcategoryid=b.transportcategoryid and a.studentstageallocationid=b.studentstageallocationid";
        	//select_query = "select b.paidamount from studentstageallocation a,transportfeescollection b  where studentapprovalid='"+studentapprovalid+"' and studentstageallocationstatus<>'T'      	and b.transportcategoryid='"+transportcategoryid+"' and a.studentstageallocationid=b.studentstageallocationid";
        //only changed stages are loading
        	//	select_query = "select sum(b.paidamount) from studentstageallocation a,transportfeescollection b  where studentapprovalid='"+studentapprovalid+"' and studentstageallocationstatus<>'T'      	and b.transportcategoryid='"+transportcategoryid+"' and a.studentstageallocationid=b.studentstageallocationid";
        	select_query = "select sum(paidamount) from studentstageallocation a,transportfeescollection b where studentapprovalid='"+studentapprovalid+"' and studentstageallocationstatus='A' and b.transportcategoryid='"+transportcategoryid+"' and a.studentstageallocationid=b.studentstageallocationid";
        	 
        	log.info(select_query);
        	//System.out.println("checkandLoadStudent>>sss"+select_query);
        	s = common_data_object.getString(select_query);
        }catch(Exception e){log.error(e);}
        return s;
    }
	
	public String loadAcutualAmount(String studentapprovalid,String transportcategoryid,String transportstageid)
    {
		 String s=null;
        try
        {
        	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
        	select_query = "select sum(allocatedamount) from transportstageamountallocation a,studentstageallocation b  where a.transportcategoryid='"+transportcategoryid+"' and b.transportstageid='"+transportstageid+"'  and a.transportstageid=b.transportstageid and transportstageamountallocationstatus='A' and studentapprovalid='"+studentapprovalid+"' and studentstageallocationstatus='A'";
        	 
        	log.info(select_query);
        	//System.out.println("loadAcutualAmount>>"+select_query);
        	s = common_data_object.getString(select_query);
        }catch(Exception e){log.error("",e);}
        return s;
    }
	
	public String loadFeescollectionid(String transportcategoryid,String rollnumber)
    {
		 String s=null;
        try
        {
        	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
        	select_query = "select transportfeescollectionid from transportfeescollection where transportcategoryid='"+transportcategoryid+"' and rollnumber='"+rollnumber+"'";
        	 
        	log.info(select_query);
        	//System.out.println("checkandLoadStudent>>"+select_query);
        	s = common_data_object.getString(select_query);
        }catch(Exception e){log.error("",e);}
        return s;
    }
	
	
	
	public ArrayList getAwardDetails(String standardscheduleid, String userid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {

        	select_query 	= "select d.scholarshipname, c.amount, d.scholarshipid, e.schemeforstudentid , (select sum(collectionamount) from feescollection where schemeforstudentid=e.schemeforstudentid and feescollectionstatus='A') as used from scholarshipamountallocation c, scholarship d, scholarshipforstudent e where c.standardscheduleid='"+standardscheduleid+"' and c.amountallocationstatus='A' and c.scholarshipid=d.scholarshipid and d.scholarshipstatus='A'  and c.scholarshipamountallocationid=e.scholarshipamountallocationid and e.scholarshipforstudentstatus='A' and e.userid='"+userid+"'";
        	log.info(select_query);
        	arraylist 		= common_data_object.getListMap(select_query);
        	
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
	
	public ArrayList LoadStudentDetails(String studentapprovalid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"'";
        	//select_query = "select c.standardscheduleid,a.sectionscheduleid,a.studentallocationid,d.sectionname,e.standardname,(select groupname from standardgroup x where x.groupid=c.groupid) as groupname,f.boardname,g.mediumname,i.firstname,i.middlename,i.lastname,i.emailid,i.imagepath,i.prefix,h.studentapprovalid from studentallocation a,sectionschedule b,standardschedule c,section d,standard e,board f,standardmedium g,candidateregister h,personmaster i where a.rollno='"+rollnumber+"' and a.sectionscheduleid=b.sectionscheduleid and b.standardscheduleid=c.standardscheduleid and c.standardid=e.standardid and d.sectionid=b.sectionid and b.sectionschedulestatus='A' and c.stdschedulestatus='A' and f.boardid=e.boardid and f.boardstatus='A' and g.mediumid=f.mediumid and mediumstatus='A' and h.candidateregisterid=a.candidateregisterid and h.personid=i.personid and h.candidateregisterstatus='A' and i.status='A' and i.instituteid='"+instituteid+"' and a.studentallocationstatus='A'";
        	select_query = " select f.standardname,g.sectionname,b.rollno,c.imagepath ,"
        	+" (select gn.groupname from standardgroup gn where gn.groupid=d.groupid) as groupname, "
        	+" case when c.middlename='-' or c.middlename='' or c.middlename  is null then concat(c.prefix,c.firstname,' ',c.lastname) else concat(c.prefix,c.firstname,' ',c.middlename,' ',c.lastname) end as uname "
        	+" from candidateregister a join studentallocation b on a.studentapprovalid='"+studentapprovalid+"' "
        	+" and b.candidateregisterid=a.candidateregisterid "
        	+" and a.candidateregisterstatus='A' and b.studentallocationstatus='A' "
        	+" join personmaster c on c.personid=a.personid and c.status='A' join "
        	+" sectionschedule e on e.sectionscheduleid=b.sectionscheduleid "
        	+" join standardschedule d  on d.standardscheduleid=e.standardscheduleid join "
        	+" standard f on f.standardid=d.standardid join section g on g.sectionid=e.sectionid ";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        	//System.out.println(select_query+"========>>>>>>>>");
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	public ArrayList studentFeesCollectionDetails(String studentapprovalid,String feesstate)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	if(feesstate.equals("admin"))
        	{
        	//select_query = "select a.feescollectionid,b.termfeesid,c.termname,a.bankname,a.ddno,date_format(a.dddate,'%d-%m-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%m-%Y %r') as feescollectiondate,a.feescollectionstatus,d.scholarshipname from feescollection a,termfees b,feestermname c,scholarshipcreation d where a.studentapprovalid='"+studentapprovalid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.schostatus='A'";
        	//select_query = "select a.feescollectionid,b.termfeesid,c.termname,a.bankname,a.ddno,date_format(a.dddate,'%d-%m-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%m-%Y %r') as feescollectiondate,a.feescollectionstatus,d.scholarshipname from feescollection a,termfees b,feestermname c,scholarship d where a.studentapprovalid='"+studentapprovalid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A'";
        	select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as feescollectiondate,a.feescollectionstatus,d.scholarshipname from feescollection a,termfees b,feestermname c,scholarship d  where a.studentapprovalid='"+studentapprovalid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A' order by c.termid";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        	}
        	else if(feesstate.equals("parent"))
        	{
        		//send student allocation id for studentapprovalid 
        		select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as feescollectiondate,a.feescollectionstatus,d.scholarshipname from feescollection a,termfees b,feestermname c,scholarship d,studentallocation e,candidateregister f  where e.studentallocationid='"+studentapprovalid+"' and e.candidateregisterid=f.candidateregisterid and a.studentapprovalid=f.studentapprovalid and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid  and d.scholarshipstatus='A' order by c.termid";;
            	log.info(select_query);
            	arraylist = common_data_object.getListMap(select_query);
        	
        	}
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public ArrayList studentFeesCollectionDetails(String standardscheduleid,String studentapprovalid,String feesstate)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	if(feesstate.equals("admin"))
        	{
        	//select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as feescollectiondate,a.feescollectionstatus,d.scholarshipname from feescollection a,termfees b,feestermname c,scholarship d  where a.studentapprovalid='"+studentapprovalid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A' order by c.termid";
        		//select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as feescollectiondate,a.feescollectionstatus,d.scholarshipname,a.paymenttype from feescollection a,termfees b,feestermname c,scholarship d  where a.studentapprovalid='"+studentapprovalid+"' and b.standardscheduleid='"+standardscheduleid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A' order by c.termid";
        		select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y')	as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as	feescollectiondate,a.feescollectionstatus,d.scholarshipname,a.paymenttype from feescollection a join termfees b on a.studentapprovalid='"+studentapprovalid+"' and b.standardscheduleid='"+standardscheduleid+"' and a.termfeesid=b.termfeesid  join feestermname c on c.termid=b.termid  left outer join scholarship d  on d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A'	order by c.termid ";
        		log.info(select_query);
        	//	System.out.println("admin========studentFees"+select_query);
        	arraylist = common_data_object.getListMap(select_query);
        	}
        	else if(feesstate.equals("parent"))
        	{
        		//send student allocation id for studentapprovalid 
        		//select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y')	as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as	feescollectiondate,a.feescollectionstatus,d.scholarshipname,a.paymenttype from feescollection a join termfees b on a.studentapprovalid='"+studentapprovalid+"' and b.standardscheduleid='"+standardscheduleid+"' and a.termfeesid=b.termfeesid  join feestermname c on c.termid=b.termid  left outer join scholarship d  on d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A'	order by c.termid ";

        		//select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as feescollectiondate,a.feescollectionstatus,d.scholarshipname,a.paymenttype from feescollection a,termfees b,feestermname c,scholarship d,studentallocation e,candidateregister f  where e.studentallocationid='"+studentapprovalid+"' and b.standardscheduleid='"+standardscheduleid+"' and e.candidateregisterid=f.candidateregisterid and a.studentapprovalid=f.studentapprovalid and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid  and d.scholarshipstatus='A' order by c.termid";;
        		select_query=" select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y')as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r')as feescollectiondate,a.feescollectionstatus,d.scholarshipname,	a.paymenttype from feescollection a join termfees b	on b.standardscheduleid='"+standardscheduleid+"' and a.termfeesid=b.termfeesid 		join feestermname c on c.termid=b.termid     		join studentallocation e  on e.studentallocationid='"+studentapprovalid+"'		 join candidateregister f on e.candidateregisterid=f.candidateregisterid	 and a.studentapprovalid=f.studentapprovalid  		 left outer join scholarship d on d.scholarshipid = a.scholarshipid   		 and d.scholarshipstatus='A' order by c.termid";
        		System.out.println("parent========studentFees"+select_query);
        		log.info(select_query);
            	arraylist = common_data_object.getListMap(select_query);
        	
        	}
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public String getScholarshipamountdetails(String termfeesid,String userid)
	{
		String returnstr= null;
		try {
		String select_query = "select distinct group_concat(concat(c.scholarshipname,'-',b.amount)) from scholarshipforstudent a,scholarshipamountallocation b,scholarship c where a.scholarshipamountallocationid=b.scholarshipamountallocationid and a.scholarshipforstudentstatus='A' and b.amountallocationstatus='A' and termfeesid='"+termfeesid+"' and c.scholarshipid=b.scholarshipid and scholarshipstatus='A' and a.userid='"+userid+"'";
	//	System.out.println(select_query);
			returnstr = common_data_object.getString(select_query);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return returnstr;
	}
	  	  

	public ArrayList paymentreceiptdetails(String rollno)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y ') as feescollectdate,a.feescollectiondate,a.feescollectionstatus,d.scholarshipname from feescollection a,termfees b,feestermname c,scholarship d  where a.studentapprovalid='"+studentapprovalid+"' and b.standardscheduleid='"+standardscheduleid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A' group by a.feescollectiondate,b.termfeesid desc";
        	select_query="select e.termid,e.termname,c.termfeesid,c.academicfeesreceiptid,c.academicfeesreceiptno,c.paidamount,	date_format(c.dateofcreation,'%d-%M-%Y %r') as dateofpaid from studentallocation a,candidateregister b,academicfeesreceipt c,	termfees d,feestermname e  where a.rollno='"+rollno+"' and a.studentallocationstatus='A' and candidateregisterstatus='A' 	and c.studentapprovalid=b.studentapprovalid and academicfeesreceiptstatus='A' and a.candidateregisterid=b.candidateregisterid 	and c.termfeesid=d.termfeesid and d.termfeesstatus='A' and e.termid=d.termid and e.termstatus='A'"; 

        	log.info(select_query);
        	//System.out.println("select_query===========>>>>>>>>>>>>>>"+select_query);

        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
	/*
	 * this method is accessed in /kycportal/jsp/Fees/FeesPaidListStudent.jsp
	 * created by by maruthu to list fees details in date order
	*/
	/*
	 * return Student Fees Details 
	 * @param studentapprovalid used to view Fees Details For selected student
	 * @return ArrayList
	 */
	
	
	
	public ArrayList studentFeescollectionDetailsforfeescollectionid(String studentapprovalid,String standardscheduleid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y ') as feescollectdate,a.feescollectiondate,a.feescollectionstatus,d.scholarshipname from feescollection a,termfees b,feestermname c,scholarship d  where a.studentapprovalid='"+studentapprovalid+"' and b.standardscheduleid='"+standardscheduleid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A' group by a.feescollectiondate,b.termfeesid desc";
        	select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y ') as feescollectdate,a.feescollectiondate,a.feescollectionstatus,d.scholarshipname  from feescollection a join termfees b on a.studentapprovalid='"+studentapprovalid+"' and b.standardscheduleid='"+standardscheduleid+"' and a.termfeesid=b.termfeesid  join feestermname c on c.termid=b.termid  left outer join scholarship d  on d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A'	order by c.termid"; 

        	log.info(select_query);
        	//System.out.println("select_query===========>>>>>>>>>>>>>>"+select_query);

        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	/*
	 * this method is accessed in /kycportal/jsp/Fees/FeesPaidListForDate.jsp
	 * created by by maruthu to list fees details For Given date 
	*/
	/*
	 * return Student Fees Details 
	 * @param studentapprovalid used to view Fees Details For selected student
	 * @param date used to view Fees Details For Given Date
	 * @return ArrayList
	 */
	
	public ArrayList studentFeescollectionDetailsforDate(String studentapprovalid,String date)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
       	    //System.out.println(date);
        	//select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y ') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as feescollectdate,a.feescollectiondate,a.feescollectionstatus,d.scholarshipname,a.paymenttype from feescollection a,termfees b,feestermname c,scholarship d  where a.feescollectiondate between  '"+date+" 00:00:00' and '"+date+" 23:59:59' and a.studentapprovalid='"+studentapprovalid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A' order by b.termfeesid,a.feescollectiondate desc";
        	select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y ') as feescollectdate,a.feescollectiondate,a.feescollectionstatus,d.scholarshipname,a.paymenttype  from feescollection a join termfees b on  a.feescollectiondate between  '"+date+" 00:00:00' and '"+date+" 23:59:59'  and a.studentapprovalid='"+studentapprovalid+"' and a.termfeesid=b.termfeesid  join feestermname c on c.termid=b.termid  left outer join scholarship d  on d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A'	 order by b.termfeesid,a.feescollectiondate desc";
        	log.info(select_query);
       	    //System.out.println(select_query);

        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	/*
	 * this method is accessed in /kycportal/jsp/Fees/PrintPreviewFeesCollection.jsp
	 * created by by maruthu to list  fees details 
	 * 	*/
	/*
	 * return Student Fees Details 
	 * @param studentapprovalid used to view Fees Details For selected student
	 * @param studentapprovalid used to view top selected  Fees Details 
 
	 * @return ArrayList
	 */
	
	public ArrayList studentFeescollectionDetailsforprint(String studentapprovalid,String rows)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query="select a.feescollectionid,b.termfeesid,c.termname,c.termid,a.bankname,a.ddno,date_format(a.dddate,'%d-%b-%Y') as dddate,a.collectionamount,a.scholarshipid,date_format(a.feescollectiondate,'%d-%b-%Y %r') as feescollectiondate,a.feescollectionstatus,d.scholarshipname from feescollection a,termfees b,feestermname c,scholarship d  where a.studentapprovalid='"+studentapprovalid+"' and a.termfeesid=b.termfeesid and c.termid=b.termid and d.scholarshipid = a.scholarshipid and d.scholarshipstatus='A' order by a.feescollectiondate desc limit "+rows;
        	log.info(select_query);
        	//System.out.print(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        	
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	public String studenttermfeesnameDetailsforprint(String termfeesid)
    {
		 String termname = "";
        try
        {
        	select_query="SELECT termname FROM termfees  a join feestermname b on  b.termid=a.termid and  a.termfeesid='"+termfeesid+"'";
        	log.info(select_query);
        	//System.out.print(select_query);
        	termname = common_data_object.getSingleColumn(select_query);
        	//System.out.println("cfscgvxcvxvxcvxcvxcvxcv=========>>>>>>>>"+termname);
        	
        }catch(Exception e){log.error(e);}
        return termname;
    }
	
	public ArrayList loadscholarship(String instituteid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT scholarshipid, scholarshipname, scholarshipdescription FROM scholarship where scholarshipstatus='A' and instituteid='"+instituteid+"';";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public ArrayList getScholarshipDetails(String termfeesid, String userid, String studentapprovalid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select c.scholarshipid, e.scholarshipname, d.schemeforstudentid, c.amount  from scholarshipamountallocation c, scholarshipforstudent d, scholarship e where c.scholarshipamountallocationid=d.scholarshipamountallocationid and c.amountallocationstatus='A' and d.scholarshipforstudentstatus='A' and userid='"+userid+"' and c.scholarshipid=e.scholarshipid and c.termfeesid='"+termfeesid+"' and e.scholarshipstatus='A' and d.schemeforstudentid not in (select schemeforstudentid from feescollection where termfeesid='"+termfeesid+"' and feescollectionstatus='A' and studentapprovalid='"+studentapprovalid+"')";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }

	
	
	//load term wise amount details
	public ArrayList loadTermFeesDetails(String standardscheduleid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select b.termname,b.termid,a.termfeesid,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') as duedate from termfees a,feestermname b where a.termid=b.termid  and a.standardscheduleid='"+standardscheduleid+"' and termfeesstatus='A'";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        	
        	
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public ArrayList loadTermFeesDetails(String standardscheduleid, String userid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select b.termname,b.termid,a.termfeesid,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') as duedate, (select sum(c.amount) from scholarshipamountallocation c, scholarshipforstudent d where c.scholarshipamountallocationid=d.scholarshipamountallocationid and c.amountallocationstatus='A' and d.scholarshipforstudentstatus='A' and d.userid='"+userid+"' and a.termfeesid=c.termfeesid) as scholarship, (select sum(c.collectionamount) from feescollection c, login d, candidateregister e  where  c.feescollectionstatus='A' and d.userid='"+userid+"' and d.personid=e.personid and d.loginstatus='A' and e.candidateregisterstatus='A' and e.studentapprovalid=c.studentapprovalid and a.termfeesid=c.termfeesid and c.scholarshipid is not null) as paidbyscholarship from termfees a,feestermname b where a.termid=b.termid  and a.standardscheduleid='"+standardscheduleid+"' and termfeesstatus='A'";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        	
        	//System.out.println(select_query);

        	
        	
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
	//load term wise amount details
	public ArrayList loadTermFeesDetailsForSelectedTermfeesid(String standardscheduleid,String termfeesid,String studentapprovalid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select b.termname,b.termid,a.termfeesid,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') as duedate from termfees a,feestermname b where a.termid=b.termid and a.termfeesid='"+termfeesid+"' and a.standardscheduleid='"+standardscheduleid+"' and termfeesstatus='A'";
        	//select_query = "select b.termname,b.termid,a.termfeesid,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') as duedate,c.paymenttype from termfees a,feestermname b,feescollection c where a.termid=b.termid and a.termfeesid='"+termfeesid+"' and a.termfeesid=c.termfeesid and a.standardscheduleid='"+standardscheduleid+"' and termfeesstatus='A'";
        	select_query = "select b.termname,b.termid,a.termfeesid,a.termfeesamount,date_format(a.duedate,'%d-%b-%Y') as duedate,paymenttype,c.collectionamount from termfees a join feestermname b on a.termid=b.termid and a.termfeesid='"+termfeesid+"' and a.standardscheduleid='"+standardscheduleid+"' and termfeesstatus='A'  left outer join feescollection c on a.termfeesid=c.termfeesid and studentapprovalid='"+studentapprovalid+"'";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        	//System.out.println("========>>>>>>>>>>>"+select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	//load fees head  data
	public ArrayList loadFeesHeadDetails(String standardscheduleid)
    {
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select b.feesheadid,b.feesheadname,a.feesscheduleamount from feesschedule a,feeshead b where a.standardscheduleid='"+standardscheduleid+"' and a.feesheadid=b.feesheadid and a.feesschedulestatus='A' and b.feesheadstatus='A'";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public String paidTermFeesDetails(String termfeesid,String studentapprovalid)
    {
		 String returnStr = null;
        try
        {
        	select_query = "select sum(collectionamount) as paidamount from feescollection where termfeesid='"+termfeesid+"' and studentapprovalid='"+studentapprovalid+"' and feescollectionstatus='A'";
        	//System.out.println("select_query-->"+select_query);        	
        	log.info(select_query);
        	returnStr = common_data_object.getString(select_query);
        }catch(Exception e){log.error(e);}
        return returnStr;
    }
	
	
	
	//load all terms with fees details based on academic year,board,institute -- Subhash -- Drop Down 
	public ArrayList displayConsolidateFeesDetails(String sessionid,String boardid,String instituteid)
    {
	 	log.info("invoking displayConsolidateFeesDetails for loading all terms");
		ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select a.standardscheduleid,a.groupid,b.standardname,d.termname,c.termfeesid,c.termfeesamount,date_format(c.duedate,'%d-%b-%Y') as duedate,(select groupname from standardgroup where groupid=a.groupid) as groupname from standardschedule a,standard b,termfees c,feestermname d where a.standardid=b.standardid and a.standardscheduleid=c.standardscheduleid and d.termid=c.termid and a.stdschedulestatus='A' and b.standardstatus='A' and c.termfeesstatus='A' and d.termstatus='A' and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' order by standardname+0,groupid,termname";
        	select_query = "select a.standardscheduleid,a.groupid,b.standardname,d.termname,c.termfeesid,c.termfeesamount,date_format(c.duedate,'%d-%b-%Y') as duedate,(select groupname from standardgroup where groupid=a.groupid) as groupname from standardschedule a,standard b,termfees c,feestermname d where a.standardid=b.standardid and a.standardscheduleid=c.standardscheduleid and d.termid=c.termid and a.stdschedulestatus='A' and b.standardstatus='A' and c.termfeesstatus='A' and d.termstatus='A' and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"' order by b.standardid,groupid,termname";
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
    //load pending fees details -- Subhash -- Drop Down 
	public ArrayList displayPendingFeesDetails(String sectionscheduleid,String termfeesid)
    {
	 	log.info("invoking displayPendingFeesDetails for loading pending fees details");
		 ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select b.feesheadid,b.feesheadname,a.feesscheduleamount from feesschedule a,feeshead b where a.standardscheduleid='"+standardscheduleid+"' and a.feesheadid=b.feesheadid and a.feesschedulestatus='A' and b.feesheadstatus='A'";
        	select_query = "select e.studentapprovalid,k.termfeesid,case when SUM(j.collectionamount) is null then 0 else SUM(j.collectionamount) end as FeesPaid,(k.termfeesamount-SUM(j.collectionamount)) as RemAmount,k.termfeesamount,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when SUM(j.collectionamount) < k.termfeesamount then 'Pending' when SUM(j.collectionamount) > k.termfeesamount then 'Excess' when SUM(j.collectionamount) = k.termfeesamount then 'Paid' when SUM(j.collectionamount) is null then 'Pending' end as feestatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join termfees k on k.termfeesid='"+termfeesid+"' left join feescollection j on j.studentapprovalid=e.studentapprovalid and j.termfeesid = k.termfeesid and j.feescollectionstatus='A' join studentallocation g on g.sectionscheduleid='"+sectionscheduleid+"' and g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus='A' group by e.studentapprovalid"; 
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	//load all terms with fees details based on academic year,board,institute -- Subhash -- Drop Down 
	public ArrayList displayConsolidateFeesPending(String standardscheduleid,String termfeesid)
    {
	 	log.info("invoking displayConsolidateFeesPending for loading consolidated pending fees details");
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select e.studentapprovalid,k.termfeesid,g.sectionscheduleid,case when SUM(j.collectionamount) is null then 0 else SUM(j.collectionamount) end as FeesPaid,case when k.termfeesamount-SUM(j.collectionamount) is null then k.termfeesamount else k.termfeesamount-SUM(j.collectionamount) end as RemAmount,k.termfeesamount,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename, ' ',i.lastname) end as applicantname,(select a.sectionname from section a,sectionschedule b where a.sectionid=b.sectionid and b.sectionscheduleid=g.sectionscheduleid and status='A' and sectionschedulestatus='A') as sectionname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when SUM(j.collectionamount) < k.termfeesamount then 'Pending' when SUM(j.collectionamount) > k.termfeesamount then 'Excess' when SUM(j.collectionamount) = k.termfeesamount then 'Paid' when SUM(j.collectionamount) is null then 'Pending' end as feestatus,case when SUM(j.collectionamount) < k.termfeesamount or SUM(j.collectionamount) is null then 1 else 0 end as pendingstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus='A' join sectionschedule l on l.sectionscheduleid = g.sectionscheduleid join standardschedule d on d.standardscheduleid=l.standardscheduleid and d.standardscheduleid='"+standardscheduleid+"' and d.stdschedulestatus='A' join termfees k on k.termfeesid='"+termfeesid+"' and k.standardscheduleid=d.standardscheduleid and k.termfeesstatus='A' left join feescollection j on j.studentapprovalid=e.studentapprovalid and j.termfeesid = k.termfeesid and j.feescollectionstatus='A' group by e.studentapprovalid  order by rollno,sectionname";
        	//select_query = "select e.studentapprovalid,k.termfeesid,g.sectionscheduleid,case when SUM(j.collectionamount) is null then 0 else SUM(j.collectionamount) end as FeesPaid,case when k.termfeesamount-SUM(j.collectionamount) is null then k.termfeesamount else k.termfeesamount-SUM(j.collectionamount) end as RemAmount,k.termfeesamount,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename, ' ',i.lastname) end as applicantname,(select a.sectionname from section a,sectionschedule b where a.sectionid=b.sectionid and b.sectionscheduleid=g.sectionscheduleid and status='A' and sectionschedulestatus='A') as sectionname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when SUM(j.collectionamount) < k.termfeesamount then 'Pending' when SUM(j.collectionamount) > k.termfeesamount then 'Excess' when SUM(j.collectionamount) = k.termfeesamount then 'Paid' when SUM(j.collectionamount) is null then 'Pending' end as feestatus, case when SUM(case when j.collectionamount is null then '0' else j.collectionamount end)+ (select case when sum(amount) is null then '0' else sum(amount) end from scholarshipforstudent aa, scholarshipamountallocation bb, login cc where cc.personid=f.personid and aa.userid=cc.userid and aa.scholarshipamountallocationid=bb.scholarshipamountallocationid and bb.termfeesid=k.termfeesid and bb.amountallocationstatus='A' and aa.scholarshipforstudentstatus='A')- (select case when sum(ddd.collectionamount) is null then '0' else sum(ddd.collectionamount) end from feescollection ddd where  ddd.feescollectionstatus='A' and e.studentapprovalid=ddd.studentapprovalid and k.termfeesid=ddd.termfeesid and ddd.scholarshipid is not null) < k.termfeesamount then 1 else 0 end as pendingstatus, (select case when sum(amount) is null then '0' else sum(amount) end from scholarshipforstudent aa, scholarshipamountallocation bb, login cc where cc.personid=f.personid and aa.userid=cc.userid and aa.scholarshipamountallocationid=bb.scholarshipamountallocationid and bb.termfeesid=k.termfeesid and bb.amountallocationstatus='A' and aa.scholarshipforstudentstatus='A') as scholarshipamount from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus in ('A','D','C') join sectionschedule l on l.sectionscheduleid = g.sectionscheduleid join standardschedule d on d.standardscheduleid=l.standardscheduleid and d.standardscheduleid='"+standardscheduleid+"' and d.stdschedulestatus='A' join termfees k on k.termfeesid='"+termfeesid+"' and k.standardscheduleid=d.standardscheduleid and k.termfeesstatus='A' left join feescollection j on j.studentapprovalid=e.studentapprovalid and j.termfeesid = k.termfeesid and j.feescollectionstatus='A' group by e.studentapprovalid  order by rollno,sectionname";
        	//System.out.println(select_query);
      //	System.out.println("displayConsolidate"+select_query);
        	
        	
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	
	
	public String studentappamount(String studentapprovalid)
    {
	 	log.info("invoking displayConsolidateFeesPending for loading consolidated pending fees details");
		 String str= null;
        try
        {
        	select_query = "select sum(amount) from scholarshipforstudent a,scholarshipamountallocation b where studentapprovalid='"+studentapprovalid+"' and a.scholarshipamountallocationid=b.scholarshipamountallocationid and amountallocationstatus='A' and scholarshipforstudentstatus='A'";
        	//select_query = "select e.studentapprovalid,k.termfeesid,g.sectionscheduleid,case when SUM(j.collectionamount) is null then 0 else SUM(j.collectionamount) end as FeesPaid,case when k.termfeesamount-SUM(j.collectionamount) is null then k.termfeesamount else k.termfeesamount-SUM(j.collectionamount) end as RemAmount,k.termfeesamount,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename, ' ',i.lastname) end as applicantname,(select a.sectionname from section a,sectionschedule b where a.sectionid=b.sectionid and b.sectionscheduleid=g.sectionscheduleid and status='A' and sectionschedulestatus='A') as sectionname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when SUM(j.collectionamount) < k.termfeesamount then 'Pending' when SUM(j.collectionamount) > k.termfeesamount then 'Excess' when SUM(j.collectionamount) = k.termfeesamount then 'Paid' when SUM(j.collectionamount) is null then 'Pending' end as feestatus, case when SUM(case when j.collectionamount is null then '0' else j.collectionamount end)+ (select case when sum(amount) is null then '0' else sum(amount) end from scholarshipforstudent aa, scholarshipamountallocation bb, login cc where cc.personid=f.personid and aa.userid=cc.userid and aa.scholarshipamountallocationid=bb.scholarshipamountallocationid and bb.termfeesid=k.termfeesid and bb.amountallocationstatus='A' and aa.scholarshipforstudentstatus='A')- (select case when sum(ddd.collectionamount) is null then '0' else sum(ddd.collectionamount) end from feescollection ddd where  ddd.feescollectionstatus='A' and e.studentapprovalid=ddd.studentapprovalid and k.termfeesid=ddd.termfeesid and ddd.scholarshipid is not null) < k.termfeesamount then 1 else 0 end as pendingstatus, (select case when sum(amount) is null then '0' else sum(amount) end from scholarshipforstudent aa, scholarshipamountallocation bb, login cc where cc.personid=f.personid and aa.userid=cc.userid and aa.scholarshipamountallocationid=bb.scholarshipamountallocationid and bb.termfeesid=k.termfeesid and bb.amountallocationstatus='A' and aa.scholarshipforstudentstatus='A') as scholarshipamount from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus in ('A','D','C') join sectionschedule l on l.sectionscheduleid = g.sectionscheduleid join standardschedule d on d.standardscheduleid=l.standardscheduleid and d.standardscheduleid='"+standardscheduleid+"' and d.stdschedulestatus='A' join termfees k on k.termfeesid='"+termfeesid+"' and k.standardscheduleid=d.standardscheduleid and k.termfeesstatus='A' left join feescollection j on j.studentapprovalid=e.studentapprovalid and j.termfeesid = k.termfeesid and j.feescollectionstatus='A' group by e.studentapprovalid  order by rollno,sectionname";
        	//System.out.println(select_query);
      	//System.out.println("displayConsolidatenew"+select_query);
        	
        	
      	str = common_data_object.getString(select_query);
        }catch(Exception e){log.error(e);}
        return str;
    }
	
	public ArrayList displayConsolidateFeesPendingnew(String standardscheduleid,String termfeesid)
    {
	 	log.info("invoking displayConsolidateFeesPending for loading consolidated pending fees details");
		 ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select (select sum(c.amount) from scholarshipamountallocation c, scholarshipforstudent d where c.scholarshipamountallocationid=d.scholarshipamountallocationid and  c.amountallocationstatus='A' and d.scholarshipforstudentstatus='A' and d.studentapprovalid=e.studentapprovalid  and k.termfeesid=c.termfeesid) as scholarship,e.studentapprovalid,k.termfeesid,g.sectionscheduleid,case when SUM(j.collectionamount) is null then 0 else SUM(j.collectionamount) end as FeesPaid,case when k.termfeesamount-SUM(j.collectionamount) is null then k.termfeesamount else k.termfeesamount-SUM(j.collectionamount) end as RemAmount,k.termfeesamount,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename, ' ',i.lastname) end as applicantname,(select a.sectionname from section a,sectionschedule b where a.sectionid=b.sectionid and b.sectionscheduleid=g.sectionscheduleid and status='A' and sectionschedulestatus='A') as sectionname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when SUM(j.collectionamount) < k.termfeesamount then 'Pending' when SUM(j.collectionamount) > k.termfeesamount then 'Excess' when SUM(j.collectionamount) = k.termfeesamount then 'Paid' when SUM(j.collectionamount) is null then 'Pending' end as feestatus,case when SUM(j.collectionamount) < k.termfeesamount or SUM(j.collectionamount) is null then 1 else 0 end as pendingstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus='A' join sectionschedule l on l.sectionscheduleid = g.sectionscheduleid join standardschedule d on d.standardscheduleid=l.standardscheduleid and d.standardscheduleid='"+standardscheduleid+"' and d.stdschedulestatus='A' join termfees k on k.termfeesid='"+termfeesid+"' and k.standardscheduleid=d.standardscheduleid and k.termfeesstatus='A' left join feescollection j on j.studentapprovalid=e.studentapprovalid and j.termfeesid = k.termfeesid and j.feescollectionstatus='A' group by e.studentapprovalid  order by rollno,sectionname";
        	//select_query = "select e.studentapprovalid,k.termfeesid,g.sectionscheduleid,case when SUM(j.collectionamount) is null then 0 else SUM(j.collectionamount) end as FeesPaid,case when k.termfeesamount-SUM(j.collectionamount) is null then k.termfeesamount else k.termfeesamount-SUM(j.collectionamount) end as RemAmount,k.termfeesamount,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename, ' ',i.lastname) end as applicantname,(select a.sectionname from section a,sectionschedule b where a.sectionid=b.sectionid and b.sectionscheduleid=g.sectionscheduleid and status='A' and sectionschedulestatus='A') as sectionname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when SUM(j.collectionamount) < k.termfeesamount then 'Pending' when SUM(j.collectionamount) > k.termfeesamount then 'Excess' when SUM(j.collectionamount) = k.termfeesamount then 'Paid' when SUM(j.collectionamount) is null then 'Pending' end as feestatus, case when SUM(case when j.collectionamount is null then '0' else j.collectionamount end)+ (select case when sum(amount) is null then '0' else sum(amount) end from scholarshipforstudent aa, scholarshipamountallocation bb, login cc where cc.personid=f.personid and aa.userid=cc.userid and aa.scholarshipamountallocationid=bb.scholarshipamountallocationid and bb.termfeesid=k.termfeesid and bb.amountallocationstatus='A' and aa.scholarshipforstudentstatus='A')- (select case when sum(ddd.collectionamount) is null then '0' else sum(ddd.collectionamount) end from feescollection ddd where  ddd.feescollectionstatus='A' and e.studentapprovalid=ddd.studentapprovalid and k.termfeesid=ddd.termfeesid and ddd.scholarshipid is not null) < k.termfeesamount then 1 else 0 end as pendingstatus, (select case when sum(amount) is null then '0' else sum(amount) end from scholarshipforstudent aa, scholarshipamountallocation bb, login cc where cc.personid=f.personid and aa.userid=cc.userid and aa.scholarshipamountallocationid=bb.scholarshipamountallocationid and bb.termfeesid=k.termfeesid and bb.amountallocationstatus='A' and aa.scholarshipforstudentstatus='A') as scholarshipamount from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus in ('A','D','C') join sectionschedule l on l.sectionscheduleid = g.sectionscheduleid join standardschedule d on d.standardscheduleid=l.standardscheduleid and d.standardscheduleid='"+standardscheduleid+"' and d.stdschedulestatus='A' join termfees k on k.termfeesid='"+termfeesid+"' and k.standardscheduleid=d.standardscheduleid and k.termfeesstatus='A' left join feescollection j on j.studentapprovalid=e.studentapprovalid and j.termfeesid = k.termfeesid and j.feescollectionstatus='A' group by e.studentapprovalid  order by rollno,sectionname";
        	System.out.println(select_query);
      //	System.out.println("displayConsolidatenew"+select_query);
        	
        	
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	//load all terms with fees details based on academic year,board,institute for generating PDF-- Subhash -- Drop Down 
	public ArrayList displayFeesDetailsPdf(String standardscheduleid,String termfeesid)
    {
	 	log.info("invoking displayFeesDetailsPdf for loading consolidated fees details to generate PDF");
		 ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select e.studentapprovalid,k.termfeesid,g.sectionscheduleid,case when SUM(j.collectionamount) is null then 0 else SUM(j.collectionamount) end as FeesPaid,case when k.termfeesamount-SUM(j.collectionamount) is null then k.termfeesamount else k.termfeesamount-SUM(j.collectionamount) end as RemAmount,k.termfeesamount,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename, ' ',i.lastname) end as applicantname,(select a.sectionname from section a,sectionschedule b where a.sectionid=b.sectionid and b.sectionscheduleid=g.sectionscheduleid and status='A' and sectionschedulestatus='A') as sectionname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when SUM(j.collectionamount) < k.termfeesamount then 'Pending' when SUM(j.collectionamount) > k.termfeesamount then 'Excess' when SUM(j.collectionamount) = k.termfeesamount then 'Paid' when SUM(j.collectionamount) is null then 'Pending' end as feestatus,case when SUM(j.collectionamount) < k.termfeesamount or SUM(j.collectionamount) is null then 1 else 0 end as pendingstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.standardscheduleid='"+standardscheduleid+"' and d.stdschedulestatus='A' join sectionschedule l on l.standardscheduleid=d.standardscheduleid and l.sectionschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join termfees k on k.termfeesid='"+termfeesid+"' and k.standardscheduleid=d.standardscheduleid and k.termfeesstatus='A' left join feescollection j on j.studentapprovalid=e.studentapprovalid and j.termfeesid = k.termfeesid and j.feescollectionstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and l.sectionscheduleid = g.sectionscheduleid and (g.studentallocationstatus='A' or g.studentallocationstatus='D' or g.studentallocationstatus='C') group by e.studentapprovalid  order by d.standardscheduleid,g.sectionscheduleid,rollno,sectionname";
        	select_query = "select e.studentapprovalid,k.termfeesid,g.sectionscheduleid,case when SUM(j.collectionamount) is null then 0 else SUM(j.collectionamount) end as FeesPaid,case when k.termfeesamount-SUM(j.collectionamount) is null then k.termfeesamount else k.termfeesamount-SUM(j.collectionamount) end as RemAmount,k.termfeesamount,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename, ' ',i.lastname) end as applicantname,(select a.sectionname from section a,sectionschedule b where a.sectionid=b.sectionid and b.sectionscheduleid=g.sectionscheduleid and status='A' and sectionschedulestatus='A') as sectionname,g.studentallocationid,g.rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno,case when SUM(j.collectionamount) < k.termfeesamount then 'Pending' when SUM(j.collectionamount) > k.termfeesamount then 'Excess' when SUM(j.collectionamount) = k.termfeesamount then 'Paid' when SUM(j.collectionamount) is null then 'Pending' end as feestatus,case when SUM(j.collectionamount) < k.termfeesamount or SUM(j.collectionamount) is null then 1 else 0 end as pendingstatus from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.studentallocationstatus in ('A','D','C') join sectionschedule l on l.sectionscheduleid = g.sectionscheduleid join standardschedule d on d.standardscheduleid=l.standardscheduleid and d.standardscheduleid='"+standardscheduleid+"' and d.stdschedulestatus='A' join termfees k on k.termfeesid='"+termfeesid+"' and k.standardscheduleid=d.standardscheduleid and k.termfeesstatus='A' left join feescollection j on j.studentapprovalid=e.studentapprovalid and j.termfeesid = k.termfeesid and j.feescollectionstatus='A' group by e.studentapprovalid order by d.standardscheduleid,g.sectionscheduleid,rollno,sectionname";
        	
        	//System.out.println("select_query-->"+select_query);
        	log.info(select_query);
        	arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public String getRollNo(String studentallocationid)
    {
		 String returnStr = null;
        try
        {
        	select_query = "select rollno from studentallocation where studentallocationid='"+studentallocationid+"' and studentallocationstatus='A'";
        	log.info(select_query);
        	returnStr = common_data_object.getString(select_query);
        }catch(Exception e){log.error(e);}
        return returnStr;
    }
	
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection feesstructureConnection;
	 int rollbackvalue;
}