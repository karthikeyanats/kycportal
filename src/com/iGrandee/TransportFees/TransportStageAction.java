package com.iGrandee.TransportFees;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Fees.FeesHeadQuery;

/**
 * @author selvakumar_v
 *
 */
public class TransportStageAction {

	
	static Logger log = Logger.getLogger(FeesHeadQuery.class);
	public TransportStageAction()
	{
		 common_data_object = new CommonDataAccess();
		 connectionManager  = new ConnectionManager();
		 transportstageconnection      = null;
		 rollbackvalue = 0;
		 select_query= "";  
	}
	
	public int inserttransportstage(TransportStage routeobj) throws Exception{
		
		int result=0;
		PreparedStatement transportstageprepared 	= null;
		ResultSet checkrs 					= null;
		PreparedStatement checkprepared 	= null;

		try {
			transportstageconnection= ConnectionManager.getKycConnection();
			transportstageconnection.setAutoCommit(false);
			String currentdate			= DateTime.showTime("MySqlWithTime");

			checkprepared			= transportstageconnection.prepareStatement("select transportstageid from transportstage where transportstagename=? and transportstagestatus<>? and transportrouteid=?");
			
			
			checkprepared.setString(1, routeobj.getTransportstagename());
			checkprepared.setString(2, "X");
			checkprepared.setString(3,routeobj.getTransportrouteid());
			
			checkrs				= checkprepared.executeQuery(); 
			//System.out.println("checkprepared>>>in stage"+checkprepared);
			if(!checkrs.next()){ 			
			
			String query="select max(transportstageid) from transportstage";
			long transportstageid = common_data_object.maxId(query);
			transportstageid++;

			query="insert into  transportstage (transportstageid, transportrouteid, transportstagename, transportstagedescription, createdby, dateofcreation, transportstagestatus) values (?, ?, ?, ?, ?, ?,?)";
			transportstageprepared = transportstageconnection.prepareStatement(query);
			transportstageprepared.setLong(1, transportstageid);
			transportstageprepared.setString(2,routeobj.getTransportrouteid());
			transportstageprepared.setString(3,routeobj.getTransportstagename());
			transportstageprepared.setString(4,routeobj.getTransportstagedescription());
			transportstageprepared.setString(5,routeobj.getCreatedby());
			transportstageprepared.setString(6, currentdate);
			transportstageprepared.setString(7,routeobj.getTransportstagestatus());
			//System.out.println("transportstageprepared>>>>>>>>>>>"+transportstageprepared);

			result += transportstageprepared.executeUpdate();
				
			//System.out.println("result>>>>>>>>>>>"+result);

		}
			else{
				result	= 1000;
			}
			transportstageconnection.commit();
		}	
			catch (SQLException e) {
			
			e.printStackTrace();
			result	= 0;
			if(transportstageconnection!=null){
				
				transportstageconnection.rollback();
			}
		}
		 finally
			{
		 
			 if(transportstageprepared != null)
				 transportstageprepared.close();
			 
			 if(transportstageconnection != null)
				 transportstageconnection.close();
			 }
		
		return result;
	}
	
	
	
	public int updatetransportstage(String transportstageid,String transportstagename,String transportstagedescription,String transportrouteid) throws Exception{
		
		int result	= 0;
		PreparedStatement updatetransportstageprepared 	= null;
//PreparedStatement updatetranspotrouteprepared 	= null;
		
		PreparedStatement checkrouteprepared = null;
    	int rs=0;
    	ResultSet rs1=null;
		try{
			transportstageconnection= ConnectionManager.getKycConnection();
		//	String currentdate			= DateTime.showTime("MySqlWithTime");
			  String str			= "select transportstagename from transportstage where transportstagename=? and transportstageid<>?  and transportstagestatus <> ? and transportrouteid=?";
	            checkrouteprepared	= transportstageconnection.prepareStatement(str);
	            checkrouteprepared.setString(1, transportstagename.trim());
	            checkrouteprepared.setString(2, transportstageid); 
	            checkrouteprepared.setString(3, "X");
	            checkrouteprepared.setString(4, transportrouteid);
	            rs1	= checkrouteprepared.executeQuery();
			
	            if(!rs1.next())
	            { 

			select_query="update transportstage set transportstagename=?,transportstagedescription=? where transportstageid=?";
			updatetransportstageprepared = transportstageconnection.prepareStatement(select_query);
			updatetransportstageprepared.setString(1,transportstagename.trim());
			updatetransportstageprepared.setString(2,transportstagedescription);
			updatetransportstageprepared.setString(3,transportstageid);
			result += updatetransportstageprepared.executeUpdate();
	            }
	            else{
	            	rs	= 1000;
	            }
		}
		
		catch (SQLException e) {
			e.printStackTrace();
			result=0;
			
			if(transportstageconnection!=null){
				
				transportstageconnection.rollback();
			}
		}
		finally{
			if(updatetransportstageprepared!=null){
				updatetransportstageprepared.close();
				
			}
				if(transportstageconnection!=null){
				
				transportstageconnection.close();
			}
			
		}
		
		return result;
	}
	
public int changetransportstage(String transportstageid,String status) throws Exception{
		
		int result	= 0;
		PreparedStatement deactransportstageprepared 	= null;
		
		try{
			transportstageconnection= ConnectionManager.getKycConnection();

			//String currentdate			= DateTime.showTime("MySqlWithTime");

			select_query="update transportstage set transportstagestatus=? where transportstageid=?";
			deactransportstageprepared = transportstageconnection.prepareStatement(select_query);
			
			deactransportstageprepared.setString(1, status);
			
			deactransportstageprepared.setString(2,transportstageid);
			
			result += deactransportstageprepared.executeUpdate();

			
		}
		
		catch (SQLException e) {
			e.printStackTrace();
			result=0;
			
			if(transportstageconnection!=null){
				
				transportstageconnection.rollback();
			}
		}
		finally{
			if(deactransportstageprepared!=null){
				deactransportstageprepared.close();
				
			}
				if(transportstageconnection!=null){
				
				transportstageconnection.close();
			}
			
		}
		
		return result;
	}

public int activatetransportstage(String routeid,String routestatus) throws Exception{
	
	int result	= 0;
	PreparedStatement actransportstageprepared 	= null;
	
	//String currentdate			= DateTime.showTime("MySqlWithTime");
	try{
		select_query="update transportstage set transportstagestatus=? where transportstageid=?";
		actransportstageprepared = transportstageconnection.prepareStatement(select_query);
		
		actransportstageprepared.setString(1, routeid);
		
		actransportstageprepared.setString(2,routestatus);
		
		result += actransportstageprepared.executeUpdate();

		
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transportstageconnection!=null){
			
			transportstageconnection.rollback();
		}
	}
	finally{
		if(actransportstageprepared!=null){
			actransportstageprepared.close();
			
		}
			if(transportstageconnection!=null){
			
			transportstageconnection.close();
		}
		
	}
	
	return result;
}

public int trashtransportstage(String routeid,String routestatus) throws Exception{
	
	int result	= 0;
	PreparedStatement trashtransportstageprepared 	= null;
	
	//String currentdate			= DateTime.showTime("MySqlWithTime");
	try{
		select_query="update transportstage set transportstagestatus=? where transportstageid=?";
		trashtransportstageprepared = transportstageconnection.prepareStatement(select_query);
		
		trashtransportstageprepared.setString(1, routeid);
		
		trashtransportstageprepared.setString(2,routestatus);
		
		result += trashtransportstageprepared.executeUpdate();

		
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transportstageconnection!=null){
			
			transportstageconnection.rollback();
		}
	}
	finally{
		if(trashtransportstageprepared!=null){
			trashtransportstageprepared.close();
			
		}
			if(transportstageconnection!=null){
			
			transportstageconnection.close();
		}
		
	}
	
	return result;
}

public int delatetransportstage(String routeid,String routestatus) throws Exception{
	
	int result	= 0;
	PreparedStatement delatetransportstage 	= null;
	
//	String currentdate			= DateTime.showTime("MySqlWithTime");
	try{
		select_query="update transportstage set transportstagestatus=? where transportstageid=?";
		delatetransportstage = transportstageconnection.prepareStatement(select_query);
		
		delatetransportstage.setString(1, routestatus);
		
		delatetransportstage.setString(2,routeid);
		
		result += delatetransportstage.executeUpdate();

		
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transportstageconnection!=null){
			
			transportstageconnection.rollback();
		}
	}
	finally{
		if(delatetransportstage!=null){
			delatetransportstage.close();
			
		}
			if(transportstageconnection!=null){
			
			transportstageconnection.close();
		}
		
	}
	
	return result;
}

public ArrayList gettransportstage(String instituteid){
	ArrayList transportstagelist=null;
	select_query="select a.transportstageid, a.transportrouteid, a.transportstagename, a.transportstagedescription, a.createdby, date_format(a.dateofcreation,'%d-%b-%Y') as newdates,a.transportstagestatus from transportstage a,transportroute b where a.transportstagestatus='A' and  a.transportrouteid=b.transportrouteid and b.instituteid='"+instituteid+"' order by a.transportstageid desc;";
	//System.out.println(select_query);
	try{
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return transportstagelist;
	}

public ArrayList gettransportstage(){
	ArrayList transportstagelist=null;
	select_query="select transportstageid, transportrouteid, transportstagename, transportstagedescription, createdby, date_format(dateofcreation,'%d-%b-%Y') as newdates, transportstagestatus from transportstage where transportstagestatus='A' order by transportstageid desc";
	try{
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}
	
public ArrayList getedittransportstage(String transportstageid){
	ArrayList transportstagelist=null;
	select_query="select transportstageid, transportrouteid, transportstagename, transportstagedescription, createdby, dateofcreation, transportstagestatus from transportstage where transportstagestatus='A' and transportstageid="+transportstageid+"";
	try{
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}

public ArrayList getdeactivetransportstage(){
	ArrayList transportstagelist=null;
	
	try{
		select_query="select transportstageid, transportrouteid, transportstagename, transportstagedescription, createdby, dateofcreation, transportstagestatus from transportstage where transportstagestatus='D'";
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}


public ArrayList gettrashtransportstage(){
	ArrayList transportstagelist=null;
	
	try{
		select_query="select transportstageid, transportrouteid, transportstagename, transportstagedescription, createdby, dateofcreation, transportstagestatus from transportstage where transportstagestatus='T'";
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}

public ArrayList getdeletetransportstage(){
	ArrayList transportstagelist=null;
	
	try{
		select_query="select transportstageid, transportrouteid, transportstagename, transportstagedescription, createdby, dateofcreation, transportstagestatus from transportstage where transportstagestatus='X'";
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}


public String  duplicateroutestage(String transportstagename){
	String duplicateroute=null;
	try{
		select_query="select transportstageid from  transportstagestatus where transportstagestatus='A' and transportstagename="+transportstagename+"";

		duplicateroute=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return duplicateroute;
}


public ArrayList getallroutestage(){
	ArrayList transportstagelist=null;
	
	try{
		select_query="select transportstageid, transportrouteid, transportstagename, transportstagedescription, createdby, dateofcreation, transportstagestatus from transportstage where transportstagestatus='X'";
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}



public ArrayList getstageforroute(String transportrouteid){
	ArrayList transportstagelist=null;
	
	try{
		select_query="select transportstagename,transportstagedescription  from transportstage where transportstagestatus='A' and transportrouteid='"+transportrouteid+"' order by transportstageid desc";
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}


public ArrayList getstageonly(String transportstageid){
	ArrayList transportstagelist=null;
	
	try{
		select_query="select transportstagename,transportstagedescription,transportstageid  from transportstage where transportstagestatus='A' and transportstageid='"+transportstageid+"' order by transportstageid desc";
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}

public String  getroutename(String transportrouteid){
	String routename=null;
	try{
		select_query="select (routename) from transportroute where transportrouteid='"+transportrouteid+"'";

		routename=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return routename;
}


// get count of stage per session created by selvakumar_v


public ArrayList  getcountstagepersession(String sessionid){
	ArrayList stagecount=null;
	try{
select_query="select  count(g.transportstageid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f," +
"studentstageallocation g,transportstage h where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and " +
"c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and " +
"f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and b.stdschedulestatus='A' and c.sectionschedulestatus='A' and  " +
"d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and h.transportstagestatus='A' and g.studentstageallocationstatus='A' group by g.transportstageid";

//System.out.println("getcountstagesession.>>>>"+select_query);
	stagecount=common_data_object.getListMap(select_query);
	
	} 
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stagecount;
}




//get count of students for stage per session created by selvakumar_v


public String  getcountstagestudent(String sessionid){
	String stduntcount=null;
	try{

		select_query="select count(f.studentapprovalid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f," +
				"studentstageallocation g where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and c.sectionscheduleid=d.sectionscheduleid" +
				" and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and f.studentapprovalid=g.studentapprovalid and b.stdschedulestatus='A'" +
				" and c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and g.studentstageallocationstatus='A'";
		//System.out.println("getcountstagestudent>>>>>>"+select_query);		
	stduntcount=common_data_object.getString(select_query);
	//System.out.println("stduntcount>>>"+sessionid+">>>"+stduntcount);
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stduntcount;
}

//get session created by selvakumar_v


public ArrayList listYearofSession(String instituteid) {
	log.info("invoking listYearofSession to list all year of session");
	ArrayList courseList = new ArrayList();
	//String currdate = "";
	try {
		String query = "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"
				+ instituteid
				+ "' and (sessionstatus='A' or sessionstatus='R') order by sessionname";
	// System.out.println("query-dccc->"+query);
		courseList = common_data_object.getListMap(query);
	} catch (Exception e) {
		log.error("",e);
	}
	return courseList;
}




//get count of students for stage per session created by selvakumar_v


public int  getindividualstagecount(String sessionid,String transportstageid){
	int stduntcount=0;
	try{

		select_query="select  count(h.transportstageid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval" +
	" f,studentstageallocation g,transportstage h where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and " +
	"c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and " +
  "f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and b.stdschedulestatus='A' and c.sectionschedulestatus='A' and  " +
  "d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and transportstagestatus='A'   and h.transportstageid='"+transportstageid+"' " +
  " and g.studentstageallocationstatus='A'";
			//	System.out.println("select_query>>getindividualstagecount>"+select_query);
	stduntcount=Integer.parseInt(common_data_object.getString(select_query)) ;
		
	} 
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stduntcount;
}



//get stage name per session created by selvakumar_v


public ArrayList  getstagenamepersession(String sessionid){
	ArrayList stagecount=null;
	try{
	select_query="select  h.transportstagename,h.transportstageid from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval f,studentstageallocation g,transportstage h where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and b.stdschedulestatus='A' and c.sectionschedulestatus='A' and  d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' " +
			"and transportstagestatus='A' and g.studentstageallocationstatus='A' group by g.transportstageid";

//System.out.println("select_query>>>>getstage>>>>"+select_query);
	stagecount=common_data_object.getListMap(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stagecount;
}
//get sessionname created by selvakumar_v


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



//get count of students for stage per session created by selvakumar_v


public ArrayList  getindividualstid(String sessionid,String transportstageid){
	ArrayList stduntcount=null;
	try{

		select_query="select  (f.studentapprovalid) from yearofsession a ,standardschedule b,sectionschedule c,studentallocation d,candidateregister e,studentapproval" +
	" f,studentstageallocation g,transportstage h where a.sessionid='"+sessionid+"' and a.sessionid=b.sessionid and b.standardscheduleid=c.standardscheduleid and " +
	"c.sectionscheduleid=d.sectionscheduleid and d.candidateregisterid=e.candidateregisterid and e.studentapprovalid=f.studentapprovalid and " +
"f.studentapprovalid=g.studentapprovalid and g.transportstageid=h.transportstageid and b.stdschedulestatus='A' and c.sectionschedulestatus='A' and  " +
"d.studentallocationstatus='A' and e.candidateregisterstatus='A' and f.approvalstatus='A' and transportstagestatus='A'   and h.transportstageid='"+transportstageid+"' " +
" and g.studentstageallocationstatus='A'";
			//	System.out.println("select_query>>getindividualstagecount>"+select_query);
	stduntcount=common_data_object.getListMap(select_query);
		
	} 
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return stduntcount;
}


//get  student profile view  created by selvakumar v
public ArrayList getstudentprofileview(String stappid){
	ArrayList result=null;
	try{
	select_query="SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid,s.createdby FROM studentallocation s ,candidateregister cm,personmaster pm  where cm.studentapprovalid='"+stappid+"' and cm.candidateregisterid=s.candidateregisterid and  cm.personid=pm.personid and   cm.candidateregisterstatus='A' and s.studentallocationstatus='A'";
	//System.out.println("getdiscountpersession >>>>"+select_query);
		result=common_data_object.getListMap(select_query); 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}


//get get routename created by selvakumar v

public String  getrouteaname(String transportstageid){
	String duplicateroute=null;
	try{
		select_query="select a.routename from transportroute a,transportstage b where b.transportstageid='"+transportstageid+"' and b.transportrouteid=a.transportrouteid" +
		" and  a.transportroutestatus='A' and b.transportstagestatus='A'";

		duplicateroute=common_data_object.getString(select_query);
		
	}
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return duplicateroute;
}


//get stage name and its counts 
public ArrayList getstagecounts(String instituteid){
	ArrayList result=null;
	try{
	select_query="select c.transportrouteid,c.routename,a.transportstageid,a.transportstagename,count(studentapprovalid) as count,GROUP_CONCAT(b.studentapprovalid) as studentapprovalid from transportroute c, transportstage a left outer join studentstageallocation b " +
	"on a.transportstageid = b.transportstageid and b.studentstageallocationstatus='A' where  a.transportrouteid=c.transportrouteid and c.instituteid="+instituteid+" and a.transportstagestatus='A'  group by a.transportstageid";
//	System.out.println("getstagecounts >>>>"+select_query);
		result=common_data_object.getListMap(select_query); 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}

//get student standard view created by selvakumar_v
public ArrayList getstudentstandard(String studentapprovalid){
	ArrayList result=null;
	try{
	select_query="SELECT pm.imagepath,s.rollno,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else" +
	" concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end as uname,s.studentallocationid,cm.personid,pm.mobilenumber,pm.emailid,s.createdby,d.standardname," +
	"c.sectionname FROM studentallocation s ,candidateregister cm,personmaster pm,sectionschedule a,standardschedule b,section c,standard d where cm.studentapprovalid='"+studentapprovalid+"'" +
	" and cm.candidateregisterid=s.candidateregisterid and cm.personid=pm.personid and  s.sectionscheduleid=a.sectionscheduleid and a.standardscheduleid=b.standardscheduleid " +
	"and b.standardid=d.standardid and a.sectionid=c.sectionid and cm.candidateregisterstatus='A' and s.studentallocationstatus='A' and a.sectionschedulestatus='A' and " +
	"b.stdschedulestatus='A' and c.status='A' and d.standardstatus='A'";
	//System.out.println("getstagecounts >>>>"+select_query);
		result=common_data_object.getListMap(select_query); 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}

//get student standard alone created by selvakumar_v
public ArrayList getstudentstandardonly(String studentapprovalid){
	ArrayList result=null;
	try{
	select_query="SELECT d.standardname FROM studentallocation s ,candidateregister cm,personmaster pm,sectionschedule a,standardschedule b,section c,standard d" +
			" where cm.studentapprovalid='"+studentapprovalid+"'" +
	" and cm.candidateregisterid=s.candidateregisterid and cm.personid=pm.personid and  s.sectionscheduleid=a.sectionscheduleid and a.standardscheduleid=b.standardscheduleid " +
	"and b.standardid=d.standardid and a.sectionid=c.sectionid and cm.candidateregisterstatus='A' and s.studentallocationstatus='A' and a.sectionschedulestatus='A' and " +
	"b.stdschedulestatus='A' and c.status='A' and d.standardstatus='A'";
	//System.out.println("getstagecounts >>>>"+select_query);
		result=common_data_object.getListMap(select_query); 
		
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	return result; 
}

public int deletetransportstage(String transportstageid) throws Exception{
	
	int result	= 0;
	PreparedStatement deactransportstageprepared 	= null;
	
	try{
		transportstageconnection= ConnectionManager.getKycConnection();

		//String currentdate			= DateTime.showTime("MySqlWithTime");

		select_query="delete from  transportstage  where transportstageid=?";
		deactransportstageprepared = transportstageconnection.prepareStatement(select_query);
		deactransportstageprepared.setString(1,transportstageid);
		
		result += deactransportstageprepared.executeUpdate();

		
	}
	
	catch (SQLException e) {
		e.printStackTrace();
		result=0;
		
		if(transportstageconnection!=null){
			
			transportstageconnection.rollback();
		}
	}
	finally{
		if(deactransportstageprepared!=null){
			deactransportstageprepared.close();
			
		}
			if(transportstageconnection!=null){
			
			transportstageconnection.close();
		}
		
	}
	
	return result;
}

public ArrayList gettransportstageroutewise(String instituteid,String transportrouteid){
	ArrayList transportstagelist=null;
	select_query="select  b.routename,a.transportstageid, a.transportrouteid, a.transportstagename, a.transportstagedescription, a.createdby, date_format(a.dateofcreation,'%d-%b-%Y') " +
	"as newdates,a.transportstagestatus from transportstage a,transportroute b where a.transportstagestatus='A' and " +
	"a.transportrouteid=b.transportrouteid and b.instituteid='"+instituteid+"' and b.transportrouteid="+transportrouteid+" order by a.transportstageid desc";
	//System.out.println("gettransportstageroutewise>>"+select_query);
	try{
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return transportstagelist;
	}

public ArrayList gettrashtransportstageroutewise(){ 
	ArrayList transportstagelist=null;
	
	try{
		select_query="select transportstageid, transportrouteid, transportstagename, transportstagedescription, createdby, dateofcreation, transportstagestatus from " +
		"transportstage where transportstagestatus='T'";
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	
	return transportstagelist;
}
// created by selvakumar_v get stagetrashlis routewise
public ArrayList gettrashtransportstageroutewise(String instituteid,String transportrouteid){
	ArrayList transportstagelist=null;
	select_query="select  b.routename,a.transportstageid, a.transportrouteid, a.transportstagename, a.transportstagedescription, a.createdby, date_format(a.dateofcreation,'%d-%b-%Y') " +
	"as newdates,a.transportstagestatus from transportstage a,transportroute b where a.transportstagestatus='T' and " +
	"a.transportrouteid=b.transportrouteid and b.instituteid='"+instituteid+"' and b.transportrouteid="+transportrouteid+" order by a.transportstageid desc";
	//System.out.println("gettransportstageroutewise>>"+select_query);
	try{
		transportstagelist=common_data_object.getListMap(select_query);
		
	}
	
	catch (Exception e) {
		// TODO: handle exception
		e.printStackTrace();
	}
	return transportstagelist;
	}
	 String select_query;
	 CommonDataAccess common_data_object;
	 ConnectionManager connectionManager;
	 Connection transportstageconnection;
	 int rollbackvalue;
}
