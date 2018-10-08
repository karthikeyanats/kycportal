package com.iGrandee.Circular;
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
// Referenced classes of package com.iGrandee.V_LearnTeleED.Admin:
//            CircularEntryBean

public class CircularEntryQuery
{
	static Logger log = Logger.getLogger(CircularEntryQuery.class);

    public CircularEntryQuery()
    {
        log.info("LMS-INFO : Start invoked Constructor in CircularEntryQuery()");
        usb = new CircularEntryBean();
        common_data_object = new CommonDataAccess();
        insert_query = null;
        select_query = null;
        return_value = 0;
        log.info("LMS-INFO : End invoked Constructor in CircularEntryQuery()");
    }
    public ArrayList loadinstitute()
	 {
		log.info("Invoking loadAcademicYear() for Load the Academic Session");
			ArrayList academicList = null;
			try
			{
				select_query  	= "	SELECT instituteid,institutename FROM institution i where status='A'"; 
				academicList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return academicList;
	 }


    public ArrayList loadCircular(String createdby)
	 {
		log.info("Invoking loadCircular() for Load the Circular ");
			ArrayList CircularList = null;
			try
			{
				select_query  	= "	SELECT c.circularid, c.subject, c.details, date_format(c.validityfrom,'%d-%b-%Y') as validityfrom, date_format(c.validityto,'%d-%b-%Y') as validityto, c.attachments,date_format(c.dateofcreation,'%d-%b-%Y') as dateofcreation , cd.circulardetailsid, cd.sendto, cd.mode FROM circular c join circulardetails cd on cd.circularid=c.circularid and cd.circulardetailsstatus='A' and c.circularstatus='A' and c.createdby='"+createdby+"' order by c.circularid desc"; 
				CircularList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return CircularList;
	 }
    public ArrayList loadCircularTrashList(String createdby)
	 {
		log.info("Invoking loadCircular() for Load the Circular ");
			ArrayList CircularList = null;
			try
			{
				select_query  	= "	SELECT c.circularid, c.subject, c.details, date_format(c.validityfrom,'%d-%b-%Y') as validityfrom, date_format(c.validityto,'%d-%b-%Y') as validityto, c.attachments,date_format(c.dateofcreation,'%d-%b-%Y') as dateofcreation , cd.circulardetailsid, cd.sendto, cd.mode FROM circular c join circulardetails cd on cd.circularid=c.circularid and cd.circulardetailsstatus='T' and c.circularstatus='T' and c.createdby='"+createdby+"' order by c.dateofcreation desc"; 
				CircularList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return CircularList;
	 }
    public ArrayList loadCircular()
	 {
		log.info("Invoking loadCircular() for Load the Circular ");
			ArrayList CircularList = null;
			try
			{
				select_query  	= "Select c.circularid, c.subject, c.details, date_format(c.validityfrom,'%d-%b-%Y') as validityfrom, date_format(c.validityto,'%d-%b-%Y') as validityto, c.attachments,date_format(c.dateofcreation,'%d-%b-%Y') as dateofcreation , cd.circulardetailsid, cd.sendto, cd.mode from circular c join circulardetails cd on  cd.circularid=c.circularid and  cd.circulardetailsstatus='A' and  c.circularstatus='A' and current_date() between c.validityfrom and c.validityto"; 
				CircularList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return CircularList;
	 }
    

    public ArrayList loadCircularForCircularid(String circularid)
	 {
		log.info("Invoking loadCircularForCircularid() for View the Circular Details ");
			ArrayList CircularList = null;
			try
			{
				select_query  	= "	SELECT c.circularid, c.subject, c.details, date_format(c.validityfrom,'%d-%m-%Y') as validityfrom, date_format(c.validityto,'%d-%m-%Y') as validityto, c.attachments,date_format(c.dateofcreation,'%d-%m-%Y') as dateofcreation , cd.circulardetailsid, cd.circularid, cd.sendto, cd.mode FROM circular c join circulardetails cd on cd.circularid=c.circularid and cd.circulardetailsstatus='A' and c.circularstatus='A' and c.circularid='"+circularid+"'"; 
				CircularList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return CircularList;
	 }
    public ArrayList getReceiverInfo(String mode,String receiverId)
	{

		ArrayList list=null;
		if(mode.equalsIgnoreCase("Standard"))
		{

			String qry="";
			String str[]=receiverId.split(",");
			for(int i=0;i<str.length;i++)
			{
				qry=qry+"b.standardscheduleid="+str[i]+" or ";
			}
			qry=qry.substring(0,qry.length()-4);
			select_query=" select distinct a.sessionid,a.sessionname,c.boardid,b.standardscheduleid,c.standardname from yearofsession a ";
			select_query=select_query+ "INNER JOIN standardschedule b ON a.sessionid=b.sessionid ";
			select_query=select_query+ "INNER JOIN  standard c     ON b.standardid=c.standardid  ";
 			select_query=select_query+" where  "+qry+" order by a.sessionname asc,b.standardid asc ";
			try
			{
				log.info("====>>>"+select_query);
				list=common_data_object.getListMap(select_query);
			}
			catch(Exception e)
			{
				log.error(e);
			}

		}
		else if(mode.equalsIgnoreCase("Role"))
		{

			String qry="";
			String str[]=receiverId.split(",");
			for(int i=0;i<str.length;i++)
			{
				qry=qry+"c.roleid="+str[i]+" or ";
			}
			qry=qry.substring(0,qry.length()-4);
			
			select_query="	select   c.roleid,i.institutename,a.departmentid, a.departmentname,c.rolename from department a ";
			select_query+=" INNER JOIN staffmaster b ON a.departmentid=b.departmentid ";
			select_query+="INNER JOIN role c ON b.roleid=c.roleid ";
			select_query+="inner join institution i on i.instituteid=c.instituteid and i.status='A'";
			select_query+="where "+qry+" and c.instituteid=a.instituteid and c.status='A'and b.staffstatus='A' and a.status='A' order by a.departmentid asc,c.roleid asc";
			
			try
			{
				list=common_data_object.getListMap(select_query);
				log.info("========>>>>"+select_query);
			}
			catch(Exception e)
			{
			}


		}
		else if(mode.equalsIgnoreCase("staff"))
		{


			String qry="";
			String str[]=receiverId.split(",");
			for(int i=0;i<str.length;i++)
			{
				qry=qry+"b.staffid="+str[i]+" or ";
			}

			qry=qry.substring(0,qry.length()-4);
			
			select_query="select   a.departmentid,b.staffid,(select case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end) as uname,i.institutename,a.departmentid, a.departmentname,c.rolename from department a ";
			select_query+=" INNER JOIN staffmaster b ON a.departmentid=b.departmentid ";
			select_query+=" INNER JOIN personmaster pm ON pm.personid=b.userid ";
			select_query+="INNER JOIN role c ON b.roleid=c.roleid ";
			select_query+="inner join institution i on i.instituteid=c.instituteid ";
			select_query+="where "+qry+" and c.instituteid=a.instituteid and c.status='A'and i.status='A' and b.staffstatus='A' and a.status='A' order by a.departmentid asc,c.roleid asc";

			try
			{
				list=common_data_object.getListMap(select_query);
			}
			catch(Exception e)
			{
			}

		}
		else if(mode.equalsIgnoreCase("student"))
		{
			String qry="";
			String str[]=receiverId.split(",");
			for(int i=0;i<str.length;i++)
			{
				qry=qry+"sa.studentallocationid="+str[i]+" or ";
			}
			qry=qry.substring(0,qry.length()-4);
			
			/*select_query="" +"SELECT (SELECT groupname FROM standardgroup sg  where sg.groupid=ss.groupid) as groupname,(select case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end) as uname,sec.sectionname,s.standardname,ys.sessionname FROM candidateregister c,standardschedule ss,standard s,yearofsession ys,sectionschedule secs,studentallocation sa,section sec,personmaster pm";
			select_query  +=" where "+qry+" and pm.personid=c.personid and s.standardid=ss.standardid and candidateregisterstatus='A'  and  ss.standardscheduleid=c.standardscheduleid and ss.sessionid=ys.sessionid and ss.stdschedulestatus='A' and s.standardstatus='A' and ys.sessionstatus='A' and sa.candidateregisterid=c.candidateregisterid and secs.sectionscheduleid=sa.sectionscheduleid and sec.sectionid=secs.sectionid and sec.status='A' and secs.sectionschedulestatus='A' and sa.studentallocationstatus='A' and pm.status='A'"; 
			select_query  +=" order by ss.standardid,sec.sectionid";
			log.info("=========>>>>"+select_query);*/
			select_query="SELECT s.boardid,c.standardscheduleid,ys.sessionid,secs.sectionscheduleid,sa.studentallocationid,(SELECT groupname FROM standardgroup sg  where sg.groupid=ss.groupid) as groupname,(select case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname) end) as uname,sec.sectionname,s.standardname,ys.sessionname FROM candidateregister c join  studentallocation sa on  c.candidateregisterid=sa.candidateregisterid join personmaster pm 	on pm.personid=c.personid join  standardschedule ss on  ss.standardscheduleid=c.standardscheduleid 	join standard s on s.standardid=ss.standardid join sectionschedule secs on secs.sectionscheduleid=sa.sectionscheduleid 	join section sec on sec.sectionid=secs.sectionid join yearofsession ys on ys.sessionid=ss.sessionid and  ys.sessionstatus='A' and c.candidateregisterstatus='A' and sa.studentallocationstatus='A' and pm.status='A' and ss.stdschedulestatus='A'  and s.standardstatus='A' and secs.sectionschedulestatus='A' and sec.status='A' and ("+qry+") order by s.standardid";
			log.info("====>>>>"+select_query);
			}
		else
		{

		}
		try
		{
			list=common_data_object.getListMap(select_query);
		}
		catch(Exception e)
		{
		}
		return list;

 	}
    public int dataManipulation(CircularEntryBean circularEntryBean) throws SQLException
    {
    	int result = 0;
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		Connection connection = null;
		String Query="";
        try
        {
        	
            String s = circularEntryBean.getOperation();
            if(s.equals("Insert"))
            {
                log.info("LMS-INFO : The Value of select_query is in dataManipulation()" + select_query);
                long l = common_data_object.fmaxId("select max(circularid) from circular");
                long circulardetailsid = common_data_object.fmaxId("select max(circulardetailsid) from circulardetails");
    			connection = ConnectionManager.getKycConnection();
    			connection.setAutoCommit(false);
                Query = "insert into circular (circularid, subject, details, validityfrom, validityto, attachments, createdby, dateofcreation, dateofmodification, ipaddress, circularstatus) values(?,?,?,?,?,?,?,?,?,?,?)";
    			pstmt = connection.prepareStatement(Query);
    			pstmt.setLong(1, l);
    			pstmt.setString(2, circularEntryBean.getSubject());
    			pstmt.setString(3, circularEntryBean.getContent());
    			pstmt.setString(4, circularEntryBean.getStartdate());
    			pstmt.setString(5, circularEntryBean.getEndDate());
    			pstmt.setString(6, circularEntryBean.getAttachfile());
    			pstmt.setString(7, circularEntryBean.getCreatedby());
    			pstmt.setString(8, datetime.showTime("MySqlWithTime"));
    			pstmt.setString(9, datetime.showTime("MySqlWithTime"));
    			pstmt.setString(10, circularEntryBean.getIpaddress());
    			pstmt.setString(11, circularEntryBean.getStatus());
    			result += pstmt.executeUpdate();
    			
    			
    			Query = "insert into circulardetails (circulardetailsid, circularid, sendto, mode, circulardetailsstatus) values(?,?,?,?,?)";
    			pstmt1 = connection.prepareStatement(Query);
    			pstmt1.setLong(1, circulardetailsid);
    			pstmt1.setLong(2, l);
    			pstmt1.setString(3, circularEntryBean.getReceiverid());
    			pstmt1.setString(4, circularEntryBean.getMode());
    			pstmt1.setString(5, "A");
    			result += pstmt1.executeUpdate();

                log.info("LMS-INFO : The Value of insert_query is in dataManipulation()" + insert_query);

            }
            if(s.equals("Edit"))
            {
            	log.info("LMS-INFO : The Value of select_query is in dataManipulation()" + select_query);
                connection = ConnectionManager.getKycConnection();
    			connection.setAutoCommit(false);
                Query = "update circular set subject=?, details=?, validityfrom=?, validityto=?, attachments=?,dateofmodification=?, ipaddress=? where circularid=?";
    			pstmt = connection.prepareStatement(Query);
    			pstmt.setString(1, circularEntryBean.getSubject());
    			pstmt.setString(2, circularEntryBean.getContent());
    			pstmt.setString(3, circularEntryBean.getStartdate());
    			pstmt.setString(4, circularEntryBean.getEndDate());
    			pstmt.setString(5, circularEntryBean.getAttachfile());
    			pstmt.setString(6, datetime.showTime("MySqlWithTime"));
    			pstmt.setString(7, circularEntryBean.getIpaddress());
    			pstmt.setString(8, circularEntryBean.getCircularid());
    			result += pstmt.executeUpdate();
    			
    			
    			Query = "update circulardetails set  sendto=?, mode=? where  circularid=?";
    			pstmt1 = connection.prepareStatement(Query);
    			pstmt1.setString(1, circularEntryBean.getReceiverid());
    			pstmt1.setString(2, circularEntryBean.getMode());
    			pstmt1.setString(3, circularEntryBean.getCircularid());
    			result += pstmt1.executeUpdate();

                log.info("LMS-INFO : The Value of update_query is in dataManipulation()" + Query);
            }
            if(s.equals("Trash"))
            {
            	connection = ConnectionManager.getKycConnection();
    			connection.setAutoCommit(false);
    			Query = "update circulardetails set  circulardetailsstatus = 'T' where circularid=?";
    			pstmt = connection.prepareStatement(Query);
    			pstmt.setString(1,circularEntryBean.getCircularid());
    			result += pstmt.executeUpdate();
    			
    			Query = "update circular set  circularstatus = 'T' where circularid=?";
    			pstmt1 = connection.prepareStatement(Query);
    			pstmt1.setString(1, circularEntryBean.getCircularid());
    			
    			result += pstmt1.executeUpdate();

                log.info("LMS-INFO : The Value of Trash is in dataManipulation()" + insert_query);
            }
            if(s.equals("Active"))
            {
            	connection = ConnectionManager.getKycConnection();
    			connection.setAutoCommit(false);
    			Query = "update circulardetails set  circulardetailsstatus = 'A' where circularid=?";
    			pstmt = connection.prepareStatement(Query);
    			pstmt.setString(1,circularEntryBean.getCircularid());
    			result += pstmt.executeUpdate();
    			
    			Query = "update circular set  circularstatus = 'A' where circularid=?";
    			pstmt1 = connection.prepareStatement(Query);
    			pstmt1.setString(1, circularEntryBean.getCircularid());
    			
    			result += pstmt1.executeUpdate();

                log.info("LMS-INFO : The Value of restore is in dataManipulation()" + insert_query);
            }
            if(s.equals("Delete"))
            {
            	connection = ConnectionManager.getKycConnection();
    			connection.setAutoCommit(false);
    			Query = "update circulardetails set  circulardetailsstatus = 'X' where circularid=?";
    			pstmt = connection.prepareStatement(Query);
    			pstmt.setString(1,circularEntryBean.getCircularid());
    			result += pstmt.executeUpdate();
    			
    			Query = "update circular set  circularstatus = 'X' where circularid=?";
    			pstmt1 = connection.prepareStatement(Query);
    			pstmt1.setString(1, circularEntryBean.getCircularid());
    			
    			result += pstmt1.executeUpdate();

                log.info("LMS-INFO : The Value of delete is in dataManipulation()" + insert_query);
            }
			connection.commit();
        }
        catch(Exception exception)
        {
        	exception.printStackTrace();
        	log.error(exception);
            log.info("LMS-INFO : Exception thrown in insertion()");
			return 0;
        }
        finally {
			if (pstmt != null)
				pstmt.close();
			
			if (connection != null)
				connection.close();

			if (pstmt1 != null)
				pstmt1.close();
        }
        return result;
    }
    public ArrayList loadyearofsession(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "SELECT sessionid,sessionname FROM yearofsession where instituteid='"+instituteid+"'  and sessionstatus='A';";
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
			
		} catch (Exception exception) {
		}
		return arraylist;
	}
    /**
     * This method is accessed from kycportal/jsp/Circular/CircularEntrySubmit.jsp
     * circular details send by sms    in Admin login  - prasanth
     @param  standardscheduleid  that can be used to get student names and mobilenos from personmaster 
     *
	 @return the ArrayList by  result can be send to mobile phones
    */
    
    public ArrayList smsforcircular(String standardscheduleid) {
		ArrayList arraylist = null;

		try {
			select_query = "select d.standardscheduleid,case when i.middlename='-' or i.middlename='' or i.middlename is null then concat(i.firstname,' ',i.lastname) else concat(i.firstname,' ',i.middlename,' ',i.lastname) end as applicantname,pa.smscontactno,g.studentallocationid,g.rollno, f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,a.applicantname as applicationname,a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and (c.sessionstatus='A' or c.sessionstatus='R') join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join personmaster i on i.personid=f.personid and i.status='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid  and g.studentallocationstatus='A' and d.standardscheduleid in ('"+standardscheduleid+"')  join personaddress pa on pa.personid=i.personid and pa.peraddstatus='A' order by rollno,applicantname;";
			log.info("=========satndard=>>>>>"+select_query);

			arraylist = common_data_object.getListMap(select_query);
			
		} catch (Exception exception) 
		{
			log.error(exception);
		}
		return arraylist;
	}
    
    /**
     * This method is accessed from kycportal/jsp/Circular/CircularEntrySubmit.jsp
     * circular details send by sms   for Admin login  - prasanth
     @param  roleid  that can be used to get  name from personmaster 
     *
     @param  departmentid  that can be used to get  name from personmaster 
     *
	 @return the ArrayList by  result can be send to mobile phones
    */
    
    public ArrayList smsforcircularRolewise(String roleid,String departmentid) {
		ArrayList arraylist = null;

		try {
			select_query = "select case when c.middlename='-' or c.middlename='' or c.middlename is null then concat(c.firstname,' ',c.lastname) else concat(c.firstname,' ',c.middlename,' ',c.lastname) end as applicantname,pa.smscontactno,a.userid from staffmaster a   join login b on b.userid=a.userid and a.staffstatus='A' and b.loginstatus='A' join personmaster c on c.status='A' and c.personid=b.personid and a.departmentid in ('"+departmentid+"') and a.roleid in ('"+roleid+"') join personaddress pa on pa.personid=c.personid and pa.peraddstatus='A'";
			arraylist = common_data_object.getListMap(select_query);
			log.info("=========role=>>>>>"+select_query);

			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
    /**
     * This method is accessed from kycportal/jsp/Circular/CircularEntrySubmit.jsp
     * circular details send by sms    for Admin login  - prasanth
     @param  staffid  that can be used to get staffid name from personmaster 
     *
  	 @return the ArrayList by  result can be send to mobile phones
    */
    public ArrayList smsforcircularStaffwise(String staffid) {
		ArrayList arraylist = null;

		try {
			select_query = "select case when c.middlename='-' or c.middlename='' or c.middlename is null then concat(c.firstname,' ',c.lastname) else concat(c.firstname,' ',c.middlename,' ',c.lastname) end as applicantname,a.staffid,pa.smscontactno,a.userid from staffmaster a   join login b on b.userid=a.userid and a.staffstatus='A' and b.loginstatus='A' join personmaster c on c.status='A' and c.personid=b.personid and a.staffid in ('"+staffid+"')   join personaddress pa on pa.personid=c.personid and pa.peraddstatus='A';";
			arraylist = common_data_object.getListMap(select_query);
			log.info("=========staff=>>>>>"+select_query);
			
		} catch (Exception exception) {
			log.error(exception);

		}
		return arraylist;
	}
    /**
     * This method is accessed from kycportal/jsp/Circular/CircularEntrySubmit.jsp
     * circular details send by sms  to partent's  for Admin login  - prasanth
     @param  studentallocationid  that can be used to get student name,mobileno  from personmaster 
     *
  	 @return the ArrayList by  result can be send to mobile phones
    */    public ArrayList smsforcircularStudentwise(String studentallocationid) {
		ArrayList arraylist = null;

		try {
			select_query = "select a.studentallocationid,case when c.middlename='-' or c.middlename='' or c.middlename is null then concat(c.firstname,' ',c.lastname) else concat(c.firstname,' ',c.middlename,' ',c.lastname) end as applicantname,pa.smscontactno from studentallocation a join candidateregister b on a.studentallocationstatus='A' and b.candidateregisterstatus='A' and a.candidateregisterid=b.candidateregisterid join personmaster c on c.status='A' and c.personid=b.personid and a.studentallocationid in ('"+studentallocationid+"')  join personaddress pa on pa.personid=c.personid and pa.peraddstatus='A'; ";
			arraylist = common_data_object.getListMap(select_query);
			log.info("=========stud=>>>>>"+select_query);
			
		} catch (Exception exception) 
		{
			log.error(exception);
		}
		return arraylist;
	}
    CircularEntryBean usb;
    CommonDataAccess common_data_object;
    public String insert_query;
	DateTime datetime;

    public String select_query;
    int return_value;
}