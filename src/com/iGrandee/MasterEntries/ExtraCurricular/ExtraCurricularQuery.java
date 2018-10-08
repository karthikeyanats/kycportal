package com.iGrandee.MasterEntries.ExtraCurricular;
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


public class ExtraCurricularQuery
{
	static Logger log = Logger.getLogger(ExtraCurricularQuery.class);

    public ExtraCurricularQuery()
    {
    	date_object = new DateTime();
        common_data_object = new CommonDataAccess();
        connectionManager = new ConnectionManager();
        extracurricularconnection      = null;
       select_query = null;
       insert_query 		= null;

    }
    
    public ArrayList insertExterCurricularCategory(ExtraCurricularCategoryBean extraCurricularCategoryBean)
	{
	 	log.info("invoking insertExterCurricularCategory for ExterCurricularCategory");
			PreparedStatement extercurricularinsertprepared = null;
			PreparedStatement duplicatechkprepared 		= null;
			ResultSet dupResult							= null;
			String extracurriduplicate					= "";
			String message								= "";
			int state 			= 0;
			ArrayList resultList = new ArrayList();

    	 try
    	 {
    		 extracurricularconnection = ConnectionManager.getKycConnection();
	 
			String[] curricularcategory=extraCurricularCategoryBean.getExtcurricularcategoryname();
	        String dupCheck			= "select a.extcurricularcategoryname from extracurricularcategory a,login b,personmaster c,institution d where  a.extcurricularcategoryname=?  and a.createdby=b.userid and b.loginstatus=? and b.personid=c.personid and c.status=? and c.instituteid=? and c.instituteid=d.instituteid and d.status=? and a.curricularstatus <> ? ";

			duplicatechkprepared	= extracurricularconnection.prepareStatement(dupCheck);
	        if(curricularcategory !=null && curricularcategory.length>0)
			for(int i = 0; i < curricularcategory.length; i++)
			{
				if(!curricularcategory[i].equals("")){
				//log.info("curricularcategory-->"+curricularcategory[i]);
					
		        duplicatechkprepared.setString(1, curricularcategory[i].toLowerCase());
		        duplicatechkprepared.setString(2, "A");
		        duplicatechkprepared.setString(3, "A");
		        duplicatechkprepared.setString(4, extraCurricularCategoryBean.getInstituteid());
		        duplicatechkprepared.setString(5, "A");
		        duplicatechkprepared.setString(6, "X");
		        dupResult	= duplicatechkprepared.executeQuery();

			    if(!dupResult.next())
			    {
				insert_query = "select max(extracurricularcategoryid) from extracurricularcategory";
				long l = common_data_object.fmaxId(insert_query);
				
				insert_query = "insert into extracurricularcategory (extracurricularcategoryid, extcurricularcategoryname, curriculardescription, createdby, dateofcreation, curricularstatus) values(?,?,?,?,?,?)";
				extercurricularinsertprepared = extracurricularconnection.prepareStatement(insert_query);
				extercurricularinsertprepared.setLong(1, l);
				extercurricularinsertprepared.setString(2,curricularcategory[i]);
				extercurricularinsertprepared.setString(3,"-");
				extercurricularinsertprepared.setString(4,extraCurricularCategoryBean.getCreatedby());
				extercurricularinsertprepared.setString(5, DateTime.showTime("MySqlWithTime"));
				extercurricularinsertprepared.setString(6,"A");
				state += extercurricularinsertprepared.executeUpdate();
				}
				else
				{
					extracurriduplicate	+= curricularcategory[i]+",";
				}
			    if(dupResult!=null)
			    	dupResult.close();
			}
		}
			if(state >0)
				message = "Successfully Extracurricular Category Inserted.";
			else
				message = "Extracurricular Category Insertion Failed.";
				
			if(extracurriduplicate != null && extracurriduplicate.length()>2)
				message	+= " The Following Extracurricular Category already exists. "+extracurriduplicate.substring(0,extracurriduplicate.length()-1);
			
			resultList.add(state+"");
			resultList.add(message);	
			

		}
		catch(Exception e)
		{
			e.printStackTrace();
			log.error(e);
		}
		return resultList;
	}
    
    public int insertExterCurricularCategory1(ExtraCurricularCategoryBean extraCurricularCategoryBean)
	{
	 	log.info("invoking insertExterCurricularCategory for ExterCurricularCategory");
			PreparedStatement extercurricularinsertprepared = null;

			int state 			= 0;

    	 try
    	 {
    		 extracurricularconnection = ConnectionManager.getKycConnection();
	 
			String[] curricularcategory=extraCurricularCategoryBean.getExtcurricularcategoryname();
			
			for(int i = 0; i < curricularcategory.length; i++)
			{
				if(!curricularcategory[i].equals("")){
				//log.info("curricularcategory-->"+curricularcategory[i]);
				insert_query = "select max(extracurricularcategoryid) from extracurricularcategory";
				long l = common_data_object.fmaxId(insert_query);
				
				insert_query = "insert into extracurricularcategory (extracurricularcategoryid, extcurricularcategoryname, curriculardescription, createdby, dateofcreation, curricularstatus) values(?,?,?,?,?,?)";
				extercurricularinsertprepared = extracurricularconnection.prepareStatement(insert_query);
				extercurricularinsertprepared.setLong(1, l);
				extercurricularinsertprepared.setString(2,curricularcategory[i]);
				extercurricularinsertprepared.setString(3,"-");
				extercurricularinsertprepared.setString(4,extraCurricularCategoryBean.getCreatedby());
				extercurricularinsertprepared.setString(5, DateTime.showTime("MySqlWithTime"));
				extercurricularinsertprepared.setString(6,"A");
				state += extercurricularinsertprepared.executeUpdate();
				}
			}
		}
		catch(Exception e)
		{
			log.error(e);
		}
		return state;
	}
    
    public int insertCurricularEventAward(CurricularEventBean Curricularevent) throws SQLException
	{
	 	log.info("invoking insertCurricularEventAllocation for Curriculareventallocation");
			PreparedStatement curriculareventinsertprepared = null;

			int state 			= 0;

    	 try
    	 {
    		 	String Studentallocationid []=Curricularevent.getStudentallocationid();
    		 	String awarddetails []=Curricularevent.getAwarddetails();
    		 	for(int i=0;i<Studentallocationid.length;i++)
		 		{
		 			//System.out.println("====>>>>"+awarddetails[i]);
		 		}
    		 	extracurricularconnection = ConnectionManager.getKycConnection();
    		 	if(Studentallocationid.length>0 && awarddetails.length>0)
    		 	{
    		 		for(int i=0;i<Studentallocationid.length;i++)
    		 		{
    		 			//System.out.println("====>>>>"+awarddetails[i]+"====>>>>"+Studentallocationid[i]+"Curricularevent.getCurriculareventid()"+Curricularevent.getCurriculareventid());
						insert_query = "update eventparticipants  set awarddetails=? , dateofcreation=? where curriculareventid=? and  studentallocationid =? and eventparticipantstatus='A'";
						curriculareventinsertprepared = extracurricularconnection.prepareStatement(insert_query);
						curriculareventinsertprepared.setString(1, awarddetails[i]);
						curriculareventinsertprepared.setString(2,DateTime.showTime("MySqlWithTime"));
						curriculareventinsertprepared.setString(3,Curricularevent.getCurriculareventid());
						curriculareventinsertprepared.setString(4,Studentallocationid[i]);
						state += curriculareventinsertprepared.executeUpdate();
    		 		}
    		 	}
		}
		catch(Exception e)
		{
			//System.out.println(e);
			log.error(e);
		}
		finally
		{
			if(curriculareventinsertprepared!=null)
				curriculareventinsertprepared.close();
			if(extracurricularconnection!=null)
				extracurricularconnection.close();
		}
		return state;
	}
    public int CurricularEventActivityDeallocation(CurricularEventBean Curricularevent) throws SQLException
  	{
  	 	log.info("invoking CurricularEventActivityDeallocation for CurriculareventDeallocation");
  			PreparedStatement curriculareventinsertprepared = null;

  			int state 			= 0;

      	 try
      	 {
      		 	extracurricularconnection = ConnectionManager.getKycConnection();
      		 	insert_query = "update eventparticipants  set eventparticipantstatus=? where eventparticipantsid=?";
  				curriculareventinsertprepared = extracurricularconnection.prepareStatement(insert_query);
  				curriculareventinsertprepared.setString(1, "X");
  				curriculareventinsertprepared.setString(2,Curricularevent.getEventparticipantsid());
				state += curriculareventinsertprepared.executeUpdate();
      		 	
  		}
  		catch(Exception e)
  		{
  			//System.out.println(e);
  			e.printStackTrace();
  			log.error(e);
  		}
  		finally
  		{
  			if(curriculareventinsertprepared!=null)
  				curriculareventinsertprepared.close();
  			if(extracurricularconnection!=null)
  				extracurricularconnection.close();
  		}
  		return state;
  	}
    public int insertCurricularEventAllocation(CurricularEventBean Curricularevent) throws SQLException
	{
	 	log.info("invoking insertCurricularEventAllocation for Curriculareventallocation");
			PreparedStatement curriculareventinsertprepared = null;

			int state 			= 0;

    	 try
    	 {
    		 	String Studentallocationid []=Curricularevent.getStudentallocationid();
    		 	extracurricularconnection = ConnectionManager.getKycConnection();
	 			long l = common_data_object.fmaxId("select max(eventparticipantsid) from eventparticipants");
    		 	if(Studentallocationid.length>0)
    		 	{
    		 		for(int i=0;i<Studentallocationid.length;i++)
    		 		{
						insert_query = "insert into eventparticipants (eventparticipantsid, curriculareventid, studentallocationid, awarddetails, dateofcreation, createdby, eventparticipantstatus) values(?,?,?,?,?,?,?)";
						curriculareventinsertprepared = extracurricularconnection.prepareStatement(insert_query);
						curriculareventinsertprepared.setLong(1, l);
						curriculareventinsertprepared.setString(2,Curricularevent.getCurriculareventid());
						//System.out.println("Curricularevent.getCurriculareventid()===========>>>>"+Curricularevent.getCurriculareventid());
						//System.out.println("Studentallocationid[i]===========>>>>"+Studentallocationid[i]);
						curriculareventinsertprepared.setString(3,Studentallocationid[i]);
						curriculareventinsertprepared.setString(4,"-");
						curriculareventinsertprepared.setString(5,DateTime.showTime("MySqlWithTime"));
						curriculareventinsertprepared.setString(6, Curricularevent.getCreatedby());
						curriculareventinsertprepared.setString(7,"A");
						state += curriculareventinsertprepared.executeUpdate();
						l++;
    		 		}
    		 	}
		}
		catch(Exception e)
		{
			//System.out.println(e);
			log.error(e);
		}
		finally
		{
			if(curriculareventinsertprepared!=null)
				curriculareventinsertprepared.close();
			if(extracurricularconnection!=null)
				extracurricularconnection.close();
		}
		return state;
	}
    
    public ArrayList listExtraCurricularCategoryList(String instituteid,String curricularstatus)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT a.extracurricularcategoryid, a.extcurricularcategoryname, a.curriculardescription, a.createdby, date_format(a.dateofcreation,'%d-%b-%Y') as newdates, a.curricularstatus  from extracurricularcategory a,login b,personmaster c where  a.createdby=b.userid and b.personid=c.personid and c.instituteid='"+instituteid+"' and a.curricularstatus='"+curricularstatus+"' order by a.dateofcreation desc";
        	log.info(select_query);

	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e)
        {
        	log.error(e);
        }
        return arraylist;    
    }
    
    //load active and archival sessions.
    public ArrayList listAllYearofSession(String instituteid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"+instituteid+"' and sessionstatus in ('A','R')";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }
        catch(Exception e)
        {
        	log.error(e); 
        }
        return arraylist;
    }
    
    //list year of session
    public ArrayList listYearofSession(String instituteid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "select sessionid,sessionname from yearofsession where instituteid='"+instituteid+"' and sessionstatus='A'";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }
        catch(Exception e)
        {
        	log.error(e); 
        }
        return arraylist;
    }
  //list curricular Event by maruthu
    
    public ArrayList listcurricularEvent(String sessionid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "SELECT c. curriculareventid,c.curriculareventname,c.venu,date_format(c.eventdate,'%d-%b-%Y') as eventdate ,e.extracurricularcategoryid,e.extcurricularcategoryname FROM curricularevent c,extracurricularcategory e where c.eventstatus='A' and e.curricularstatus='A' and c.extracurricularcategoryid=e.extracurricularcategoryid and c.sessionid='"+sessionid+"' order by e.extcurricularcategoryname";
        	select_query = "SELECT c.curriculareventid,c.curriculareventname,c.venu,date_format(c.eventdate,'%d-%b-%Y') as eventdate ,e.extracurricularactivityid,e.extracurricularname FROM curricularevent c,extracurricularactivity e where c.eventstatus='A' and e.extracurricularstatus='A' and c.extracurricularactivityid=e.extracurricularactivityid and c.sessionid='"+sessionid+"' order by e.extracurricularname";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);} 
        return arraylist;
    }
    //list studentdetails by maruthu
    public ArrayList listEventstudentdetails(String studentallocationid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "SELECT c.curriculareventid,c.venu,ec.extcurricularcategoryname,e.awarddetails,c.curriculareventname,date_format(c.eventdate,'%d-%b-%Y') as eventdate FROM eventparticipants e,curricularevent c,extracurricularcategory ec where e.studentallocationid='"+studentallocationid+"' and e.curriculareventid=c.curriculareventid and c.extracurricularcategoryid=ec.extracurricularcategoryid and ec.curricularstatus='A' and c.eventstatus='A' and e.eventparticipantstatus='A'";
        	select_query = "SELECT c.curriculareventid,c.venu,ec.extracurricularname,e.awarddetails,c.curriculareventname,date_format(c.eventdate,'%d-%b-%Y') as eventdate FROM eventparticipants e,curricularevent c,extracurricularactivity ec where e.studentallocationid='"+studentallocationid+"' and e.curriculareventid=c.curriculareventid and c.extracurricularactivityid=ec.extracurricularactivityid and ec.extracurricularstatus='A' and c.eventstatus='A' and e.eventparticipantstatus='A'";
        	//System.out.println("select_query>>>"+select_query);

        	log.info(select_query);      
	        arraylist = common_data_object.getListMap(select_query);     
        }catch(Exception e){log.error(e);} 
        return arraylist;
    }
    
    // list board by maruthu
    public ArrayList listmark(String standardscheduleid,String rollno) {
		ArrayList arraylist = null;

		try {
			select_query = "select a.examnameid,a.examname,c.subjectscheduleid,f.marktaken from examname a join examallotment b on b.standardscheduleid='"+standardscheduleid+"' and a.examnameid=b.examnameid and b.examallotmentstatus='A' and a.examnamestatus='A' join subjectschedule c on c.standardscheduleid=b.standardscheduleid and c.status='A' join subject d on d.subjectid=c.subjectid and d.subjectstatus='A' join studentallocation g on g.rollno='"+rollno+"' left outer join examschedule e on b.examallotmentid=e.examallotmentid and c.subjectscheduleid=e.subjectscheduleid left outer join exammark f on f.examscheduleid=e.examscheduleid and f.markstatus='A' and e.examschedulestatus='A' and g.studentallocationid=f.studentallocationid order by a.examnameid,c.subjectscheduleid asc;";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
    public ArrayList loadboard(String instituteid) {
		ArrayList arraylist = null;

		try {
			select_query = "select a.boardid, a.boardname,b.mediumid,b.mediumname from board a,standardmedium b where a.mediumid=b.mediumid and a.instituteid='"+instituteid+"' and a.boardstatus='A' and b.mediumstatus='A' order by a.boardid,b.mediumid";
			arraylist = common_data_object.getListMap(select_query);
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return arraylist;
	}
    public ArrayList loadstandard(String boardid,String sessionid,String instituteid) {
		ArrayList arraylist = null;
		try {
			select_query = "select b.boardid,a.standardscheduleid,b.standardid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	and a.stdschedulestatus='A' group by a.standardscheduleid order by a.standardid"; 
			//select_query = "select a.standardscheduleid,b.standardname,(select groupname from standardgroup x where x.groupid=a.groupid) as groupname from standardschedule a	join standard b where a.standardid=b.standardid and a.sessionid='"+sessionid+"' and b.boardid='"+boardid+"' and a.instituteid='"+instituteid+"'	group by a.standardscheduleid order by a.standardid";
			//select_query = "SELECT a.standardname,b.standardscheduleid FROM standard a,standardschedule b where a.standardid =b.standardid and boardid='"+boardid+"' and b.sessionid='"+sessionid+"' and a.instituteid='"+instituteid+"' order by a.standardid ";
			//log.info("===================>>>>>>>>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
    
	public ArrayList loadsection(String standardscheduleid,String instituteid) {
		ArrayList arraylist = null;
		try { 
			
			select_query = "SELECT a.sectionscheduleid,b.sectionname FROM sectionschedule a ,section b where a.sectionid=b.sectionid and a.standardscheduleid='"+standardscheduleid+"' and  b.instituteid='"+instituteid+"' and a.sectionschedulestatus='A' order by a.sectionid ";
			//log.info("==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			//log.info("==========>>>>>"+arraylist);
						
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadstudent(String standardscheduleidid,String sessionid,String sectionscheduleid,String instituteid,String eventid) {
		ArrayList arraylist = null; 
		try {
			//select_query = "select ev.curriculareventid,g.studentallocationid,case when g.rollno is null then '-' else g.rollno end as rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%m-%Y') as dateofallocation,a.applicantname,a.applicationno from applicationissue a join registration b on a.applicationid=b.applicationid and a.standardpublishid=b.standardpublishid and a.sessionid='"+sessionid+"' and b.standardpublishid='"+standardscheduleidid+"' and a.status='A' and b.status='A' join yearofsession c on a.sessionid=c.sessionid and c.sessionstatus='A' join standardschedule d on b.standardpublishid=d.standardscheduleid and d.stdschedulestatus='A' join studentapproval e on e.registrationid=b.registrationid and e.approvalstatus='A' join candidateregister f on f.studentapprovalid=e.studentapprovalid and f.candidateregisterstatus='A' join studentallocation g on g.candidateregisterid=f.candidateregisterid and g.sectionscheduleid='"+sectionscheduleid+"' and g.studentallocationstatus='A' left join eventparticipants ev on g.studentallocationid=ev.studentallocationid and ev.curriculareventid='"+eventid+"'";
			select_query ="select ev.curriculareventid,case when pm.middlename='-' or pm.middlename='' or pm.middlename  is null then concat(pm.prefix,pm.firstname,' ',pm.lastname) else concat(pm.prefix,pm.firstname,' ',pm.middlename,' ',pm.lastname )"
				+" end as applicantname,f.personid,g.studentallocationid,case when g.rollno is null then 'NYG' else g.rollno end as rollno,f.candidateregisterid,date_format(g.dateofcreation,'%d-%b-%Y') as dateofallocation,ev.eventparticipantsid,ev.awarddetails"
				+" from studentallocation g"
				+" join candidateregister f    on g.candidateregisterid=f.candidateregisterid"
				+" join sectionschedule secs   on secs.sectionscheduleid=g.sectionscheduleid"
				+" join standardschedule d     on d.standardscheduleid=secs.standardscheduleid"
				+" join personmaster pm        on pm.personid=f.personid"
				+" and pm.status='A'           and d.stdschedulestatus='A'       and f.candidateregisterstatus='A'"
				+" and g.sectionscheduleid='"+sectionscheduleid+"' and secs.standardscheduleid='"+standardscheduleidid+"'   and d.sessionid='"+sessionid+"'"
				+" and d.instituteid='"+instituteid+"'       and g.studentallocationstatus='A' and secs.sectionschedulestatus='A'"
				+" left join eventparticipants ev on g.studentallocationid=ev.studentallocationid and ev.curriculareventid='"+eventid+"' and ev.eventparticipantstatus='A' ";
			log.info("select_query==========>>>>>"+select_query);
			//System.out.println("select_query==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("arraylist==========>>>>>"+arraylist);
						   
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
	public ArrayList loadEventAllocatedstudent(String eventid) {
		ArrayList arraylist = null; 
		try {
			select_query = "select case when p.middlename='-' or p.middlename='' or p.middlename  is null then concat(p.prefix,p.firstname,' ',p.lastname) else concat(p.prefix,p.firstname,' ',p.middlename,' ',p.lastname) end as uname,case when s.rollno is null then '-' else s.rollno end as rollno,ev.studentallocationid,ev.awarddetails from eventparticipants ev ,studentallocation s ,candidateregister c,personmaster p where s.candidateregisterid=c.candidateregisterid and s.studentallocationid=ev.studentallocationid and c.personid=p.personid and ev.curriculareventid='"+eventid+"' and ev.eventparticipantstatus='A' ";
			log.info("select_query==========>>>>>"+select_query);
			arraylist = common_data_object.getListMap(select_query);
			log.info("arraylist==========>>>>>"+arraylist);
						   
		} catch (Exception exception) { 
		}
		return    arraylist;
	}
    //check the curricularcategory
    public ArrayList trackCurricularCategory(String extracurricularcategoryid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT curriculareventid FROM curricularevent where extracurricularcategoryid='"+extracurricularcategoryid+"' and eventstatus!='X'";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
    
    //listExtraCurricularEventList by rams for list the curricular events
    
    public ArrayList listExtraCurricularEventList(String categoryid,String sessionid,String eventstatus)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select curriculareventid, extracurricularcategoryid, curriculareventname,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation, venu, date_format(eventdate,'%d-%b-%Y') as eventdate from curricularevent where sessionid='"+sessionid+"' and extracurricularcategoryid='"+categoryid+"' and eventstatus='"+eventstatus+"' order by dateofcreation desc";
        	select_query = "select curriculareventid, extracurricularactivityid, curriculareventname,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation, venu, date_format(eventdate,'%d-%b-%Y') as eventdate from curricularevent where sessionid='"+sessionid+"' and extracurricularactivityid='"+categoryid+"' and eventstatus='"+eventstatus+"' order by dateofcreation desc";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
    

    public ArrayList evenListforEventid(String eventid,String trackstatus)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	if(trackstatus.equals("EventView"))
        	{
        	select_query = "select curriculareventid, curriculareventname,venu, date_format(eventdate,'%d-%b-%Y') as eventdate from curricularevent where curriculareventid='"+eventid+"' order by eventdate desc";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        	}else if(trackstatus.equals("eventrack"))
        	{
        		select_query = "select eventparticipantsid from eventparticipants where curriculareventid='"+eventid+"' and eventparticipantstatus!='X'";
        		
            	log.info(select_query);
    	        arraylist = common_data_object.getListMap(select_query);
        	}
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
    
    //update 
    public int updateExtraCurricularCategory(ExtraCurricularCategoryBean extraCurricularCategoryBean) throws Exception
	 {
		 	log.info("invoking updateExtraCurricularCategory for Updation");
		 
		 	int result	= 0;
			PreparedStatement extercurricularupdateprepared = null;
			PreparedStatement duplicatechkprepared 		= null;
			ResultSet dupResult							= null;
			String extracurriduplicate					= "";
	 try
	 {
		 	extracurricularconnection = ConnectionManager.getKycConnection();
			extracurricularconnection.setAutoCommit(false);
			
	
			String[] curricularcategory=extraCurricularCategoryBean.getExtcurricularcategoryname();

	        String dupCheck			= "select extracurricularcategoryid from extracurricularcategory where extcurricularcategoryname=? and curricularstatus <> ? and extracurricularcategoryid<>?";
	        duplicatechkprepared	= extracurricularconnection.prepareStatement(dupCheck);
	        duplicatechkprepared.setString(1, curricularcategory[0].toLowerCase());
	        duplicatechkprepared.setString(2, "X");
	        duplicatechkprepared.setString(3, extraCurricularCategoryBean.getExtracurricularcategoryid());
	        dupResult	= duplicatechkprepared.executeQuery();
		    
		    if(!dupResult.next())
		    {
	        
			select_query="update extracurricularcategory set extcurricularcategoryname=? where extracurricularcategoryid=?";
			log.info(select_query);
			extercurricularupdateprepared = extracurricularconnection.prepareStatement(select_query);
			extercurricularupdateprepared.setString(1,curricularcategory[0]);
			extercurricularupdateprepared.setString(2, extraCurricularCategoryBean.getExtracurricularcategoryid());
						
			
			result += extercurricularupdateprepared.executeUpdate();
		    }
		    else
		    {
		    	result	= 1000;
		    }
			
			extracurricularconnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(extracurricularconnection != null)
				extracurricularconnection.rollback();
	 }
	 finally
		{
	 
		 if(extercurricularupdateprepared != null)
			extercurricularupdateprepared.close();
		
		 if(extracurricularconnection != null)
		 extracurricularconnection.close();
		 }
	 return result;
	 }
	
	public int updateExtraCurricularCategoryStatus(ExtraCurricularCategoryBean extraCurricularCategoryBean) throws Exception
	 {
		 	log.info("invoking updateExtraCurricularCategoryStatus for Update Status");
		 
		 	int result	= 0;
			PreparedStatement extercurricularupdateprepared = null;
			
	 try
	 {
		 	extracurricularconnection = ConnectionManager.getKycConnection();
			extracurricularconnection.setAutoCommit(false);
			
			
			select_query="update extracurricularcategory set curricularstatus=? where extracurricularcategoryid=?";
			extercurricularupdateprepared = extracurricularconnection.prepareStatement(select_query);
			extercurricularupdateprepared.setString(1,extraCurricularCategoryBean.getCurricularstatus());
			extercurricularupdateprepared.setString(2,extraCurricularCategoryBean.getExtracurricularcategoryid());
			result += extercurricularupdateprepared.executeUpdate();
			
			extracurricularconnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(extracurricularconnection != null)
				extracurricularconnection.rollback();
	 }
	 finally
		{
	 
		 if(extercurricularupdateprepared != null)
			extercurricularupdateprepared.close();
		
		 if(extracurricularconnection != null)
		 extracurricularconnection.close();
		 }
	 return result;
	 }
	
	
	 public int insertExtraCurricularEvent(CurricularEventBean curricularEventBean)
		{
		 	log.info("invoking insertExtraCurricularEvent for ExtraCurricularEvent");
				PreparedStatement extercurriculareventprepared = null;

				int state 			= 0;

	    	 try
	    	 {
	    		 extracurricularconnection = ConnectionManager.getKycConnection();
		 
				String[] curriculareventname=curricularEventBean.getCurriculareventname();
				String[] eventvenu=curricularEventBean.getVenu();
				String[] eventdate=curricularEventBean.getEventdate();
				
				
				for(int i = 0; i < curriculareventname.length; i++)
				{
					//log.info(curricularEventBean.getExtracurricularcategoryid());
					//log.info(curriculareventname[i]);
				
													
					if(!curriculareventname[i].equals("")){
					insert_query = "select max(curriculareventid) from curricularevent";
					long l = common_data_object.fmaxId(insert_query);
					
					//insert_query = "insert into curricularevent (curriculareventid, extracurricularcategoryid, curriculareventname, description, createdby, dateofcreation, eventstatus, venu, eventdate,sessionid) values(?,?,?,?,?,?,?,?,?,?)";
					insert_query = "insert into curricularevent (curriculareventid, extracurricularactivityid, curriculareventname, description, createdby, dateofcreation, eventstatus, venu, eventdate,sessionid) values(?,?,?,?,?,?,?,?,?,?)";
					extercurriculareventprepared = extracurricularconnection.prepareStatement(insert_query);
					extercurriculareventprepared.setLong(1, l);
					
					//extercurriculareventprepared.setString(2,curricularEventBean.getExtracurricularcategoryid());
					extercurriculareventprepared.setString(2,curricularEventBean.getExtracurricularactivityid());
					extercurriculareventprepared.setString(3,curriculareventname[i]);
					extercurriculareventprepared.setString(4,"-");
					extercurriculareventprepared.setString(5,curricularEventBean.getCreatedby());
					extercurriculareventprepared.setString(6, DateTime.showTime("MySqlWithTime"));
					extercurriculareventprepared.setString(7,"A");
					extercurriculareventprepared.setString(8,eventvenu[i]);
					extercurriculareventprepared.setString(9,((StringBuffer)date_object.getMySQLFormat(eventdate[i])).toString());
					extercurriculareventprepared.setString(10,curricularEventBean.getSessionid());
					state += extercurriculareventprepared.executeUpdate();
					}
				}
			}
			catch(Exception e)
			{
				//System.out.println(e);
				log.error(e);
				//System.out.println(e);
			}
			return state;
		}
	 //start of curricular event update by rams
	 public int updateExtraCurricularEvent(CurricularEventBean curricularEventBean) throws Exception
	 {
		 	log.info("invoking updateExtraCurricularCategory for Updation");
		 
		 	int result	= 0;
			PreparedStatement curriculareventupdateprepared = null;
	 try
	 {
		 	extracurricularconnection = ConnectionManager.getKycConnection();
			extracurricularconnection.setAutoCommit(false);
			
	
		String[] curriculareventname=curricularEventBean.getCurriculareventname();
		String[] eventvenue=curricularEventBean.getVenu();
		String[] eventdate=curricularEventBean.getEventdate();

			select_query="update curricularevent set curriculareventname=?,venu=?,eventdate=? where curriculareventid=?";
			log.info(select_query);
			curriculareventupdateprepared = extracurricularconnection.prepareStatement(select_query);
			curriculareventupdateprepared.setString(1,curriculareventname[0]);
			curriculareventupdateprepared.setString(2,eventvenue[0]);
			curriculareventupdateprepared.setString(3,((StringBuffer)date_object.getMySQLFormat(eventdate[0])).toString());
			curriculareventupdateprepared.setString(4, curricularEventBean.getCurriculareventid());
						
			
			result += curriculareventupdateprepared.executeUpdate();
			
			extracurricularconnection.commit();

		 
	 }catch(SQLException e){
		 
			log.error(e);
			result	= 0;
			if(extracurricularconnection != null)
				extracurricularconnection.rollback();
	 }
	 finally
		{
	 
		 if(curriculareventupdateprepared != null)
			curriculareventupdateprepared.close();
		
		 if(extracurricularconnection != null)
		 extracurricularconnection.close();
		 }
	 return result;
	 }
	 
	  public int updateEventStatus(CurricularEventBean curricularEventBean) throws Exception
		 {
			 	log.info("invoking updateEventStatus for Update Status");
			 
			 	int result	= 0;
				PreparedStatement curriculareventupdateprepared = null;
		 try
		 {
			 	extracurricularconnection = ConnectionManager.getKycConnection();
				extracurricularconnection.setAutoCommit(false);

				select_query="update curricularevent set eventstatus=? where curriculareventid=?";
				log.info(select_query);
				curriculareventupdateprepared = extracurricularconnection.prepareStatement(select_query);
				curriculareventupdateprepared.setString(1,curricularEventBean.getEventstatus());
				curriculareventupdateprepared.setString(2, curricularEventBean.getCurriculareventid());
							
				
				result += curriculareventupdateprepared.executeUpdate();
				
				extracurricularconnection.commit();

			 
		 }catch(SQLException e){
			// System.out.print(e);
				log.error(e);
				result	= 0;
				if(extracurricularconnection != null)
					extracurricularconnection.rollback();
		 }
		 finally
			{
		 
			 if(curriculareventupdateprepared != null)
				curriculareventupdateprepared.close();
			
			 if(extracurricularconnection != null)
			 extracurricularconnection.close();
			 }
		 return result;
		 }
	  
	  /**
		  * This method is accessed from kycportal/jsp/masterentries/ExtraCurricular/checkDuplicate.jsp
		  * check  extracurricularevent duplicate checking  (entry screen)         - prasanth
		   @param  tablename that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,extracurricularcategoryid,eventstatus wise
		   *
	       @param columnname that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,extracurricularcategoryid,eventstatus wise
	       *
	       @param fieldname that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,extracurricularcategoryid,eventstatus wise
	       *
	       @param extracurricularcategoryid that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,extracurricularcategoryid,eventstatus wise
	       *
	       @param eventstatus that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,extracurricularcategoryid,eventstatus wise
	       *
	       @return the boolean by which result can be printed on the screen 
		 */
	  public boolean checkduplicateforCurricularevent(String tablename,String columnname,String fieldname,String extracurricularcategoryid,String eventstatus,String sessionid)
		{
			boolean return_flag = false;
			String return_string = null;
			try
			{log.info("invoking extracurricularcategory for duplicate checking from com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery");
				//String select_query = "select "+columnname+" from "+tablename+" where "+columnname+"='"+fieldname+"' and extracurricularcategoryid='"+extracurricularcategoryid+"' and "+eventstatus+" <> 'X' ";
			String select_query = "select "+columnname+" from "+tablename+" where "+columnname+"='"+fieldname+"' and extracurricularactivityid='"+extracurricularcategoryid+"' and sessionid='"+sessionid+"' and "+eventstatus+" <> 'X' ";
	    		return_string = common_data_object.getString(select_query);
	    		//System.out.println("------------->"+select_query);
				if(return_string ==null || return_string.equalsIgnoreCase("null") || return_string.equals("")) {
					return_flag = false;
				}
				else {
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
		  * This method is accessed from kycportal/jsp/masterentries/ExtraCurricular/checkDuplicate.jsp
		  * check  extracurricularcategory duplicate checking  (entry screen)         - prasanth
		  @param  tablename  that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,eventstatus wise
		  * 
	      @param columnname  that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,eventstatus wise
	      *
	      @param fieldname  that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,eventstatus wise
	      *
	      @param eventstatus  that can be used to check duplicate names from extracurricularcategory table by columnname,fieldname,eventstatus wise
	      *
	      @return the boolean by which result can be printed on the screen
		 */
	  public boolean checkduplicate(String tablename,String columnname,String fieldname,String eventstatus)
		{
			boolean return_flag = false;
			String return_string = null;
			try
			{log.info("invoking extracurricularcategory for duplicate checking from com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery");
				String select_query = "select "+columnname+" from "+tablename+" where "+columnname+"='"+fieldname+"'  and "+eventstatus+" <> 'X' ";
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
				log.error(e);
			}
			return return_flag;
		}
	  /**
		  * This method is accessed from kycportal/jsp/masterentries/ExtraCurricular/checkDuplicate.jsp
		  * check  extracurricularcategory duplicate checking  (update screen)         - prasanth
		  @param  extcurricularcategoryname  that can be used to check duplicate names from extracurricularcategory table by extcurricularcategoryname,extcurricularcategoryid wise
		  *
	      @param extcurricularcategoryid   that can be used to check duplicate names from extracurricularcategory table by extcurricularcategoryname,extcurricularcategoryid wise
	      *
	      @return the boolean by which result can be printed on the screen
		 */
		 public boolean checkduplicateforCurriculareventUpdate(String extcurricularcategoryname,String extracurricularcategoryid)
		{
			boolean return_flag = false;
			String return_string = null;
			try
			{log.info("invoking extracurricularcategory for duplicate checking from com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery");
				String select_query = "SELECT extcurricularcategoryname from extracurricularcategory   where extcurricularcategoryname='"+extcurricularcategoryname+"' and curricularstatus='A' and  extracurricularcategoryid <> '"+extracurricularcategoryid+"' " ;
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
				log.error(e);
			}
			return return_flag;
		}
		 /**
		   * This method is accessed from kycportal/jsp/masterentries/ExtraCurricular/checkDuplicate.jsp
		   * check  curricularevent duplicate checking  (update screen)         - prasanth
		   @param  curriculareventname  that can be used to check duplicate names from extracurricularevent table by extracurricularcategory,fieldname,curriculareventid,curriculareventname wise
		   *
	       @param curriculareventid that can be used to check duplicate names from extracurricularevent table by extracurricularcategory,fieldname,curriculareventid,curriculareventname wise
	       *
	       @param extracurricularcategoryid that can be used to check duplicate names from extracurricularevent table by extracurricularcategory,fieldname,curriculareventid,curriculareventname wise
	       *
	       @return the boolean by which result can be printed on the screen
		 */
		 public boolean checkduplicateforCurriculareventNewUpdateCategor(String curriculareventname,String curriculareventid,String extracurricularcategoryid)
			{
				boolean return_flag = false;
				String return_string = null;
				try
				{log.info("invoking curricularevent for duplicate checking from com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery");
					//String select_query = "SELECT curriculareventname from curricularevent   where curriculareventname='"+curriculareventname+"' and eventstatus='A' and extracurricularcategoryid='"+extracurricularcategoryid+"' and  curriculareventid <> '"+curriculareventid+"' " ;
				String select_query = "SELECT curriculareventname from curricularevent   where curriculareventname='"+curriculareventname+"' and eventstatus='A' and extracurricularactivityid='"+extracurricularcategoryid+"' and  curriculareventid <> '"+curriculareventid+"' " ;
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
					log.error(e);
				}
				return return_flag;
			}
    public String insert_query;
    DateTime date_object;
    Connection extracurricularconnection;
    CommonDataAccess common_data_object;
    ConnectionManager connectionManager;
    String select_query;
    Statement stmt;
    ResultSet rs;
}