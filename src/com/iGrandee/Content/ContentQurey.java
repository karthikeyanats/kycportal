package com.iGrandee.Content;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.ArrayList;

import org.apache.log4j.Logger;

import com.iGrandee.Common.CommonDataAccess;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.DateTime;

// Referenced classes of package com.iGrandee.Common:
//            CommonDataAccess

public class ContentQurey {     
	static Logger log = Logger.getLogger(ContentQurey.class);

	public ContentQurey() 
	{
		common_data_object = new CommonDataAccess();
		 datetime =new DateTime();
		 select_query="";
	}

	/*
	   * This method is accessed from kycportal/jsp/Contenmanagement/contenthome.jsp
	  */
	 public ArrayList sessionDetails(String instituteid)
	 {
	 		log.info("invoking sessionDetails from com.iGrandee.Content.ContentQuery");
		 
			ArrayList periodsList = null;
			try
			{
				select_query  	= "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"+instituteid+"' and sessionstatus='A'  "; 
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
				log.error(exception);
			}
			return periodsList;
	 }
	 
	 /*
	  * This method is accessed from kycportal/jsp/Contenmanagement/contenthome.jsp
	 */
	public ArrayList boardDetails(String instituteid)
	{
	 		log.info("invoking boardDetails from com.iGrandee.Content.ContentQuery");

			ArrayList periodsList = null;
			try
			{
				select_query  	= "select boardname,boardid,b.mediumname from board a,standardmedium b where a.instituteid='"+instituteid+"' and a.boardstatus='A' and a.mediumid=b.mediumid and b.mediumstatus='A'";  
				periodsList 	= common_data_object.getListMap(select_query);
			}
			catch(Exception exception) { 
				
				//log.info("SMS SQLEXception inside com.iGrandee.MasterAdmin.getDateSchedulePeriods.deletePeriods====>"+exception.getMessage());	
				log.info(exception);
			}
			return periodsList;
	} 
	 /*
	  * This method is accessed from kycportal/jsp/Staff/MyStudentsView.jsp
	  * To Load Board to view My Students List for the staff login  - Subhash
	 */
	public ArrayList loadBoardForStaff(String userid,String instituteid,String yearofsessionid)
	{
		log.info("invoking loadBoardForStaff for loading board for staff");
			ArrayList secList = null;
			try
			{
				select_query  	= "select distinct e.boardid,f.boardname,g.mediumid,g.mediumname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+yearofsessionid+"' and d.instituteid='"+instituteid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.standardstatus='A' join board f on f.boardid=e.boardid and f.boardstatus='A' join standardmedium g on g.mediumid=f.mediumid and mediumstatus='A'"; 
				secList		 	= common_data_object.getListMap(select_query); 
			}
			catch(Exception exception) { 
				
				log.error(exception);
			}
			return secList;
	}
	/*
	  * This method is accessed from kycportal/jsp/Staff/MyStudentsView.jsp
	  * To Load standard to view My Students List for the staff login  - Subhash
	 */
	public ArrayList loadStandardForStaff(String userid,String yearofsessionid,String boardid)
	{
		log.info("invoking loadStandardForStaff for loading standard for staff");
			ArrayList stdList = null;
			try
			{
				select_query  	= "select distinct d.standardscheduleid,e.standardname,case when d.groupid is null then 'NoGroup' else (select g.groupname from standardgroup g where d.groupid=g.groupid)  end as groupname from staffmaster a join subjectallotment b on a.userid='"+userid+"' and a.staffid=b.staffid and a.staffstatus='A' and b.subjectallotmentstatus='A' join subjectschedule c on b.subjectscheduleid=c.subjectscheduleid and c.status='A' join standardschedule d on d.standardscheduleid=c.standardscheduleid and d.sessionid='"+yearofsessionid+"' and d.stdschedulestatus='A' join standard e on d.standardid=e.standardid and e.boardid='"+boardid+"' and e.standardstatus='A'"; 
				stdList 		= common_data_object.getListMap(select_query);
				//System.out.println(select_query);
				//log.info("select_query============>>>>>>"+select_query);
			}
			catch(Exception exception) { 
				
	 			log.error(exception);

			}
			return stdList;
	}
	public ArrayList loadSubjectForStaff(String staffid,String standardscheduleid)
	{
		log.info("invoking loadStandardForStaff for loading standard for staff");
			ArrayList stdList = null;
			try
			{
				select_query  	= "select distinct a.subjectscheduleid,b.subjectname,e.subjectypename from subjectschedule a 	 join subject b on a.subjectid=b.subjectid	 join sectionschedule c on a.standardscheduleid=c.standardscheduleid and	 a.standardscheduleid='"+standardscheduleid+"' and b.subjectstatus='A' and  a.status='A' and c.sectionschedulestatus='A'   join subjecttype e on b.subjecttypeid=e.subjecttypeid	and e.subjecttypestatus='A' join subjectallotment d on c.sectionscheduleid=d.sectionpublishid	and d.staffid='"+staffid+"' and a.subjectscheduleid=d.subjectscheduleid and d.subjectallotmentstatus='A' order by d.subjectallotmentid"; 
				stdList 		= common_data_object.getListMap(select_query);
				//log.info("select_query============>>>>>>"+select_query);
			}
			catch(Exception exception) { 
				
	 			log.error(exception);

			}
			return stdList;
	}
	
	
	 /*
	  * This method is accessed from kycportal/jsp/Contenmanagement/contenthome.jsp
	 */
	public ArrayList standardDetails(String instituteid,String sessionid,String boardid)
	{
 		log.info("invoking StandardDetails from com.iGrandee.Content.ContentQuery");

			ArrayList periodsList = null;
			try
			{
				select_query  	= "select a.standardid,a.standardname,a.groupstatus, date_format(c.startdate,'%d-%b-%Y') as startdate, date_format(c.enddate,'%d-%b-%Y') as enddate, c.standardscheduleid,'-' as groupid,null as groupname from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' and a.groupstatus='No' and a.standardid not in (select standardid from standardschedule where sessionid='"+sessionid+"' and stdschedulestatus='T') left outer join standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' union select a.standardid,a.standardname,a.groupstatus,date_format(c.startdate,'%d-%b-%Y') as startdate, date_format(c.enddate,'%d-%b-%Y') as enddate, c.standardscheduleid,d.groupid,d.groupname from standard a join institution b on a.instituteid='"+instituteid+"' and a.instituteid=b.instituteid and a.boardid='"+boardid+"' and a.standardstatus='A' and b.status='A' and a.groupstatus='Yes' join standardgroup d on a.instituteid=d.instituteid and d.groupstatus='A' and d.groupid not in (select f.groupid from standardschedule e,standardgroup f where e.sessionid='"+sessionid+"' and a.standardid=e.standardid and e.stdschedulestatus='T' and f.groupid=e.groupid) left outer join standardschedule c on a.standardid=c.standardid and a.instituteid=c.instituteid and c.sessionid='"+sessionid+"' and c.stdschedulestatus='A' and d.groupid=c.groupid order by groupstatus,standardid,startdate";  
				periodsList 	= common_data_object.getListMap(select_query);
				//System.out.println("select_query"+select_query);
				//log.info(select_query);

			}
			catch(Exception exception) { 
				
				log.error(exception);
			}
			return periodsList;
	}
	/*
	 * This method is accessed from kycportal/jsp/Contenmanagement/contenthome.jsp
	*/
	public ArrayList viewSubjects(String standardscheduleid)
	{
 		log.info("invoking SubjectDetails from com.iGrandee.Content.ContentQuery");

			ArrayList periodsList = null;
			try
			{
				     select_query  	= "select 'Yes' as status,b.subjectname,b.subjectcode,b.description,b.subjectid,a.subjectscheduleid from subjectschedule a join subject b on    a.standardscheduleid='"+standardscheduleid+"' and a.subjectid=b.subjectid and a.status='A' and b.subjectstatus='A'";  
				//select_query  	= "select b.subjectname,b.subjectcode,b.description,b.subjectid,null as subjectscheduleid, 'No' as status from standardschedule a,subject b where a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and b.subjectstatus='A' and b.subjectid not in (select subjectid from subjectschedule where standardscheduleid='"+standardscheduleid+"' and subjectid=b.subjectid) union select b.subjectname,b.subjectcode,b.description,b.subjectid,c.subjectscheduleid, 'Yes' as status from standardschedule a,subject b,subjectschedule c where a.standardscheduleid='"+standardscheduleid+"' and a.standardid=b.standardid and b.subjectstatus='A' and b.subjectid=c.subjectid and a.standardscheduleid=c.standardscheduleid and c.status='A'";  
				periodsList 	= common_data_object.getListMap(select_query);
				//log.info("Subject::::"+select_query);
			}
			catch(Exception exception) { 
				log.error(exception);
			}
			return periodsList;
	}
	/*
	 * This method is accessed from kycportal/jsp/Contenmanagement/contenthome.jsp
	*/
	public ArrayList listLesson(String subjectscheduleid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "select lessonid,lessonname,lessondescription from lesson where lessonstatus='A' and subjectid='"+reqsubjectid+"'";
        	select_query = "SELECT lessonscheduleid,ls.lessonid,lessonname,lessondescription FROM lessonschedule ls join lesson l on ls.lessonid=l.lessonid and ls.subjectscheduleid='"+subjectscheduleid+"' and ls.status='A' and l.lessonstatus='A'" ;
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);log.error(e);}
        return arraylist;
    }
	/*
	 * This method is accessed from kycportal/jsp/Contenmanagement/ContentViewLession.jsp
	 */
	 /*
	  * Return ArrayList 
	  * This Method is Used to Load Existing Content 	
	  * @param sessionid used to load content for selected academic year
      * @param lessonid used  to  load content for selected Lession
      * @return List of content Details
	  * */
	public ArrayList LoadExistContentLesson(String sessionid,String lessonid,String status)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT cmscontentid,filepath, filename, contentnotes,DATE_FORMAT(uploadeddate,'%d-%b-%Y') as uploadeddate,ordervalue FROM cmscontent c where c.lessonid='"+lessonid+"' and c.cmscontentstatus='"+status+"' and  c.sessionid='"+sessionid+"'";
        	log.info(select_query);
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	/*
	 * This method is accessed from kycportal/jsp/Contenmanagement/ContentViewLession.jsp
	 */
	 /*
	  * Return ArrayList 
	  * This Method is Used to Load Student Details 	
	  * @param standardscheduleid used to load  academic year,boardname,standardname,gropname
      * @return List of Student  Details
	  * */
	public ArrayList Loadstudentdetails(String standardscheduleid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT sessionname,standardname,boardname,groupname FROM standardschedule ss join standard s on s.standardid=ss.standardid and  standardscheduleid='"+standardscheduleid+"' and standardstatus='A' and stdschedulestatus='A' join board b on b.boardid=s.boardid and boardstatus='A' join yearofsession ys on ys.sessionid=ss.sessionid and sessionstatus='A' left outer join standardgroup sg on sg.groupid=ss.groupid and sg.groupstatus='A'"; 
        	log.info(select_query);
        	//log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	/*
	 * This method is accessed from kycportal/jsp/ContentManagement/ContentView.jsp
	 */
	 /*
	  * Return ArrayList 
	  * This Method is Used to Load  Content 	
	  * @param cmscontentid used to load content 
      * @return selected content Details
	  * */
	public ArrayList LoadContentDetails(String cmscontentid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT c.cmscontentid, c.filepath, c.filename, c.contentnotes,DATE_FORMAT(uploadeddate,'%d-%b-%Y') as uploadeddate FROM cmscontent c where  c.cmscontentid ='"+cmscontentid+"' and c.cmscontentstatus='A' ";
        	log.info(select_query);
        	//log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	/*
	 * This method is accessed from kycportal/jsp/ContentManagement/DeployedContentViewLesson.jsp
	 */
	 /*
	  * Return ArrayList 
	  * This Method is Used to Load Deployed Content 	
	  * @param sessionid used to load content for selected academic year
      * @return List of content Details
	  * */
	public ArrayList LoadDeployedContentLesson(String lessonid,String lessonscheduleid,String status)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT  cs.cmscontentscheduleid, c.cmscontentid, cs.lessonscheduleid,  c.filepath, c.filename, c.contentnotes,DATE_FORMAT(uploadeddate,'%d-%b-%Y') as uploadeddate, c.lessonid,c.type FROM cmscontentschedule cs  join   cmscontent c on c.cmscontentid =cs.cmscontentid and c.cmscontentstatus='A' and c.lessonid='"+lessonid+"' and cs.lessonscheduleid='"+lessonscheduleid+"' and cs.cmscontentschedlestatus='"+status+"' order by c.type";
        	log.info(select_query);
        	//log.info("Content Query>>>"+select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	/*
	 * This method is accessed from kycportal/jsp/ContentManagement/DeployedContentViewLesson.jsp
	 */
	 /**
	  * Return ArrayList 
	  * This Method is Used to Load Deployed Content 	
	  * @param sessionid used to load content for selected academic year
      * @return List of content Details
	  * */
	public ArrayList LoadDeployedContentLessonList(String lessonid,String lessonscheduleid,String status,String type)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT  cs.cmscontentscheduleid, c.cmscontentid, cs.lessonscheduleid,  c.filepath, c.filename, c.contentnotes,DATE_FORMAT(uploadeddate,'%d-%b-%Y') as uploadeddate, c.lessonid,c.type FROM cmscontentschedule cs  join   cmscontent c on c.cmscontentid =cs.cmscontentid and c.cmscontentstatus='A' and c.lessonid='"+lessonid+"' and cs.lessonscheduleid='"+lessonscheduleid+"' and cs.cmscontentschedlestatus='"+status+"' and c.type in ('"+type+"') order by c.type";
        	log.info(select_query);
        	//log.info("Content Query_view>>>"+select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	/*
	 * This method is accessed from kycportal/jsp/ContentManagement/DeployedContentViewLesson.jsp
	 */
	 /**
	  * Return ArrayList 
	  * This Method is Used to Load Deployed Content 	
	  * @param sessionid used to load content for selected academic year
      * @param lessonid used  to  load content for selected Lession
      * @return List of content Details
	  * */
	public ArrayList LoadpreviousContentLesson(String sessionid,String lessonid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "SELECT ys.sessionname,cmscontentid,filepath, filename, contentnotes,DATE_FORMAT(uploadeddate,'%d-%b-%Y') as uploadeddate,ordervalue FROM cmscontent c join yearofsession ys on ys.sessionid =c.sessionid and c.lessonid='"+lessonid+"' and c.cmscontentstatus='A' and  c.sessionid<>'"+sessionid+"'";
        	log.info(select_query);
        	//log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }

	/*
	 * This method is accessed from kycportal/jsp/ContentManagement/ContentViewLession.jsp
	 */
	 /**
	  * Return ArrayList 
	  * This Method is Used to Load Existing Content PDF	
	  * @param sessionid used to load content for selected academic year
      * @param lessonid used  to  load content for selected Lession
      * @return List of content Details
	  * */
	public ArrayList LoadLessonContent(String sessionid,String lessonid,String cmscontentid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "	SELECT cmscontentid,filepath, filename, contentnotes,uploadeddate,ordervalue FROM cmscontent c where c.cmscontentid='"+cmscontentid+"' and  c.lessonid='"+lessonid+"' and c.cmscontentstatus='A' and  c.sessionid='"+sessionid+"'";
        	select_query = "SELECT a.cmscontentid,a.filepath, a.filename, a.contentnotes,a.uploadeddate,a.ordervalue,b.cmsmetainfoid,b.contenttitle,b.source,b.presentername,b.institutionname,b.referenceurl,b.licensedby,b.description FROM cmscontent a join lesson c on a.lessonid=c.lessonid and c.lessonstatus='A' and  a.cmscontentid='"+cmscontentid+"' and  a.sessionid='"+sessionid+"' and  a.lessonid='"+lessonid+"' and a.cmscontentstatus='A' left outer join  cmsmetainfo b on b.cmscontentid=a.cmscontentid and b.cmsmetainfostatus='A'";
        	log.info(select_query);
        	//log.info(select_query+"--------------------");
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	
	public ArrayList LoadLessonContentmetainfo(String cmscontentid)
    {
        ArrayList arraylist = new ArrayList();
        try
        {
        	//select_query = "	SELECT cmscontentid,filepath, filename, contentnotes,uploadeddate,ordervalue FROM cmscontent c where c.cmscontentid='"+cmscontentid+"' and  c.lessonid='"+lessonid+"' and c.cmscontentstatus='A' and  c.sessionid='"+sessionid+"'";
        	select_query = "SELECT b.cmsmetainfoid,b.contenttitle,b.source,b.presentername,b.institutionname,b.referenceurl,b.licensedby,b.description FROM cmsmetainfo b   where  b.cmscontentid='"+cmscontentid+"'  and b.cmsmetainfostatus='A'";
        	log.info(select_query);
        	//log.info(select_query+"--------------------");
	        arraylist = common_data_object.getListMap(select_query);
        }catch(Exception e){log.error(e);}
        return arraylist;
    }
	/*
	 * This method is accessed from kycportal/jsp/ContentManagement/ContentDeployForLesson.jsp
	 */
	 /**
	  * Return int 
	  * This Method is Used to check content already deployed or not 
	  * @param lessonscheduleid used to check content deployed for this lession 
      * @param cmscontentid used to check content deployed or not
      * @return 1 if already deployed else retrn 0
	  * */
	public int checkcontentalreadyalloted(String lessonscheduleid,String cmscontentid)
    {   		int i = 0;

        ArrayList arraylist = new ArrayList();
        try
        {
        	select_query = "	SELECT cmscontentscheduleid FROM cmscontentschedule c where cmscontentid='"+cmscontentid+"' and lessonscheduleid='"+lessonscheduleid+"' and cmscontentschedlestatus in ('A','T');";
        	log.info(select_query);
	        arraylist = common_data_object.getListMap(select_query);
	        if (arraylist != null && arraylist.size() > 0) {
				i = 1;
			}
        }catch(Exception e){log.error(e);}
        return i;
    }
	
	//select cmsmetainfoid,cmscontentid,contenttitle,source,presentername,institutionname,referenceurl,licensedby,description from cmsmetainfo where cmscontentid='414'
	public int ContenDataAllocation(ContentBean beanobj) throws SQLException {
		int result = 0;
		log.info("Invoke ContenDataallocation method to upload content allocation================>>");
		String cmscontentid[] = null;
		cmscontentid = beanobj.getCmscontentidforallocation();
		 		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;


		String Query = "";
		Connection connection = null;

		try {
			
			long max_cmscontentscheduleid = common_data_object.fmaxId("select max(cmscontentscheduleid) from cmscontentschedule");
			long max_cmslogid = common_data_object.fmaxId("select max(cmslogid) from cmscontentlog");

			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			if(cmscontentid.length>0)
			{

				for(int i=0;i<cmscontentid.length;i++)
					{

						Query = "insert into cmscontentschedule(cmscontentscheduleid, cmscontentid, lessonscheduleid, cmscontentschedlestatus) values(?,?,?,?)";
						pstmt1 = connection.prepareStatement(Query);
						pstmt1.setLong(1, max_cmscontentscheduleid);
						pstmt1.setString(2,cmscontentid[i] );
						pstmt1.setString(3, beanobj.getLessonscheduleid());
						pstmt1.setString(4, "A");
						
						result += pstmt1.executeUpdate();
						
						log.info("Cmscontentallocation================>>");
								
						max_cmscontentscheduleid++;
						
						Query = "insert into cmscontentlog(cmslogid, cmscontentid, logstatus, cmslogdate, bywhom, cmscontentlogstatus) values(?,?,?,?,?,?)";
						pstmt = connection.prepareStatement(Query);
						pstmt.setLong(1, max_cmslogid);
						pstmt.setString(2, cmscontentid[i]);
						pstmt.setString(3, "Deployed");
						pstmt.setString(4, datetime.showTime("databaseinsert"));
						pstmt.setString(5, beanobj.getCreatedby());
						pstmt.setString(6, "A");
						result += pstmt.executeUpdate();
						max_cmslogid++;
					}
			}

			
			connection.commit();
			
		} catch (Exception exception) {
			connection.rollback();
			log.error(exception);
			return 0;
		} finally {
				if (pstmt1 != null)
				pstmt1.close();


			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	public int ContenDataInsertion(ContentBean beanobj) throws SQLException {
		int result = 0;
		log.info("Invoke ContenDataInsertion method to upload content ================>>");
		String filepath[] = null;
		String filename[] = null;
		String slidename[] = null;
		String notes[] = null;
		String title []       	 			= beanobj.getTitle();
		String source []       	 			= beanobj.getSource();
		String presentername []       	 	= beanobj.getPresentername();
		String institutename []       	 	= beanobj.getInstitutename();
		String referenceurl []       	 	= beanobj.getReferenceurl();
		String licensedby []       	 		= beanobj.getLicensedby();
		String description []       	 	= beanobj.getDescription();
		 filepath = beanobj.getFilepath();
		 filename = beanobj.getFilename();
		 slidename = beanobj.getSlidename();
		 notes = beanobj.getNotes();
		
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;


		String Query = "";
		Connection connection = null;

		try {
			
			long max_cmscontentid = common_data_object.fmaxId("select max(cmscontentid) from cmscontent");
			long max_cmslogid = common_data_object.fmaxId("select max(cmslogid) from cmscontentlog");
			long max_cmsmetainfoid = common_data_object.fmaxId("select max(cmsmetainfoid) from cmsmetainfo");

			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			if(filename.length>0)
			{

				for(int i=0;i<filename.length;i++)
					{

						Query = "insert into cmscontent(cmscontentid, filepath, filename, contentnotes, type, author, uploadeddate, lessonid, cmscontentstatus, sessionid,  ordervalue,contenttype,slidename) values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
						pstmt1 = connection.prepareStatement(Query);
						pstmt1.setLong(1, max_cmscontentid);
						pstmt1.setString(2,filepath[i] );
						pstmt1.setString(3, filename[i]);
						pstmt1.setString(4, notes[i]);
						pstmt1.setString(5, filename[i].substring(filename[i].lastIndexOf(".")+1));
						pstmt1.setString(6, beanobj.getCreatedby());
						pstmt1.setString(7, datetime.showTime("databaseinsert"));
						pstmt1.setString(8, beanobj.getLessonid());
						pstmt1.setString(9, "A");
						pstmt1.setString(10, beanobj.getSessionid());
						pstmt1.setString(11, "1");
						pstmt1.setString(12, "browsing");
						pstmt1.setString(13, slidename[i]);

						log.info(filepath[0]);
						result += pstmt1.executeUpdate();
						
						log.info("Cmscontent================>>End");
			
						Query = "insert into cmscontentlog(cmslogid, cmscontentid, logstatus, cmslogdate, bywhom, cmscontentlogstatus) values(?,?,?,?,?,?)";
						pstmt = connection.prepareStatement(Query);
						pstmt.setLong(1, max_cmslogid);
						pstmt.setLong(2, max_cmscontentid);
						pstmt.setString(3, "Created");
						pstmt.setString(4, datetime.showTime("databaseinsert"));
						pstmt.setString(5, beanobj.getCreatedby());
						pstmt.setString(6, "A");
						result += pstmt.executeUpdate();
						log.info("Cmscontentlog================>>End");
						if(!title[i].equalsIgnoreCase("") || !source[i].equalsIgnoreCase("") || !presentername[i].equalsIgnoreCase("")  || !institutename[i].equalsIgnoreCase("")  || !referenceurl[i].equalsIgnoreCase("")  || !licensedby[i].equalsIgnoreCase("")  || !description[i].equalsIgnoreCase("") )
						{
							Query = "insert into cmsmetainfo(cmsmetainfoid,cmscontentid,contenttitle,source,presentername,institutionname,referenceurl,licensedby,description,dateofcreation,cmsmetainfostatus) values(?,?,?,?,?,?,?,?,?,?,?)";
							pstmt2 = connection.prepareStatement(Query);
							pstmt2.setLong(1, max_cmsmetainfoid);
							pstmt2.setLong(2, max_cmscontentid);
							pstmt2.setString(3, title[i]);
							pstmt2.setString(4, source[i]);
							pstmt2.setString(5, presentername[i]);
							pstmt2.setString(6, institutename[i]);
							pstmt2.setString(7, referenceurl[i]);
							pstmt2.setString(8, licensedby[i]);
							pstmt2.setString(9, description[i]);
							pstmt2.setString(10, datetime.showTime("databaseinsert"));
							pstmt2.setString(11, "A");
							//log.info("Cmsmetainfopstmt2================>>"+pstmt2);

							result += pstmt2.executeUpdate();
							//log.info("Cmsmetainfo================>>"+i+"End"+result);
							max_cmsmetainfoid++;
						}
						
						max_cmscontentid++;
						max_cmslogid++;
						
						
						
						
						
					}
			}

			
			connection.commit();
			
		} catch (Exception exception) {
			log.error(exception);
			connection.rollback();
			log.error(exception);
			
			return 0;
		} finally {
			if (pstmt != null)
				pstmt.close();

			if (pstmt1 != null)
				pstmt1.close();


			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	public int ContenDataupdation(ContentBean beanobj) throws SQLException {
		int result = 0;
		log.info("Invoke ContenDataupdation method to upload content ================>>");
		
		 		
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;
		PreparedStatement pstmt2 = null;


		String Query = "";
		Connection connection = null;
		String title []       	 			= beanobj.getTitle();
		String source []       	 			= beanobj.getSource();
		String presentername []       	 	= beanobj.getPresentername();
		String institutename []       	 	= beanobj.getInstitutename();
		String referenceurl []       	 	= beanobj.getReferenceurl();
		String licensedby []       	 		= beanobj.getLicensedby();
		String description []       	 	= beanobj.getDescription();
		try {
			
			long max_cmslogid = common_data_object.fmaxId("select max(cmslogid) from cmscontentlog");
			long max_cmsmetainfoid = common_data_object.fmaxId("select max(cmsmetainfoid) from cmsmetainfo");

			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			if(beanobj.getCmscontentid()!=null)
			{
					    Query = "update  cmscontent set  filepath=?, filename=?, contentnotes=?, uploadeddate=?  where  cmscontentid=? and sessionid=? and lessonid=?";
						pstmt1 = connection.prepareStatement(Query);
						pstmt1.setString(1, beanobj.getSfilepath());
						pstmt1.setString(2, beanobj.getSfilename());
						pstmt1.setString(3, beanobj.getSnotes());
						pstmt1.setString(4, datetime.showTime("databaseinsert"));
						pstmt1.setString(5, beanobj.getCmscontentid());
						pstmt1.setString(6, beanobj.getSessionid());
						pstmt1.setString(7, beanobj.getLessonid());
						
						result += pstmt1.executeUpdate();
						
						
						
						log.info("Cmscontent================>>");
						//log.info("Cmscontent================>>");

						if(beanobj.getCmsmetainfoid()!=null && !beanobj.getCmsmetainfoid().equalsIgnoreCase("null"))
						{
							Query = "update cmsmetainfo  set contenttitle=?,source=?,presentername=?,institutionname=?,referenceurl=?,licensedby=?,description=? where cmsmetainfoid=? and cmscontentid=? ";
							pstmt2 = connection.prepareStatement(Query);
							pstmt2.setString(1, title[0]);
							pstmt2.setString(2, source[0]);
							pstmt2.setString(3, presentername[0]);
							pstmt2.setString(4, institutename[0]);
							pstmt2.setString(5, referenceurl[0]);
							pstmt2.setString(6, licensedby[0]);
							pstmt2.setString(7, description[0]);
							pstmt2.setString(8, beanobj.getCmsmetainfoid());
							pstmt2.setString(9, beanobj.getCmscontentid());
							//log.info("Cmsmetainfopupdatestmt2================>>"+pstmt2);
							result += pstmt2.executeUpdate();
							//log.info("Cmsmetainfoupdate================>>End"+result);
							
						}
						else
						{
							Query = "insert into cmsmetainfo(cmsmetainfoid,cmscontentid,contenttitle,source,presentername,institutionname,referenceurl,licensedby,description,dateofcreation,cmsmetainfostatus) values(?,?,?,?,?,?,?,?,?,?,?)";
							pstmt2 = connection.prepareStatement(Query);
							pstmt2.setLong(1, max_cmsmetainfoid);
							pstmt2.setString(2, beanobj.getCmscontentid());
							pstmt2.setString(3, title[0]);
							pstmt2.setString(4, source[0]);
							pstmt2.setString(5, presentername[0]);
							pstmt2.setString(6, institutename[0]);
							pstmt2.setString(7, referenceurl[0]);
							pstmt2.setString(8, licensedby[0]);
							pstmt2.setString(9, description[0]);
							pstmt2.setString(10, datetime.showTime("databaseinsert"));
							pstmt2.setString(11, "A");
							//log.info("Cmsmetainfopstmt2================>>"+pstmt2);

							result += pstmt2.executeUpdate();
							//log.info("Cmsmetainfo================>>End"+result);
						}
						
						
						
						Query = "insert into cmscontentlog(cmslogid, cmscontentid, logstatus, cmslogdate, bywhom, cmscontentlogstatus) values(?,?,?,?,?,?)";
						pstmt = connection.prepareStatement(Query);
						pstmt.setLong(1, max_cmslogid);
						pstmt.setString(2, beanobj.getCmscontentid());
						pstmt.setString(3, "Updated");
						pstmt.setString(4, datetime.showTime("databaseinsert"));
						pstmt.setString(5, beanobj.getCreatedby());
						pstmt.setString(6, "A");
						result += pstmt.executeUpdate();
						//log.info("Cmscontentlog================>>");
						max_cmslogid++;
						
						
						
						
						
					}
	

			
			connection.commit();
			
		} catch (Exception exception) {
			connection.rollback();
			log.error(exception);
			return 0;
		} finally {
			if (pstmt != null)
				pstmt.close();

			if (pstmt1 != null)
				pstmt1.close();


			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	public int ContenDataStatusupdation(ContentBean beanobj) throws SQLException {
		int result = 0;
		log.info("Invoke ContenDataupdation method to upload content ================>>");
		
		 		
		
		PreparedStatement pstmt = null;
		PreparedStatement pstmt1 = null;


		String Query = "";
		Connection connection = null;

		try {
			
			long max_cmslogid = common_data_object.fmaxId("select max(cmslogid) from cmscontentlog");
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);
			if(beanobj.getCmscontentid()!=null)
			{
					    Query = "update  cmscontent set  cmscontentstatus=?  where  cmscontentid=? and sessionid=? and lessonid=?";
						pstmt1 = connection.prepareStatement(Query);
						pstmt1.setString(1, beanobj.getEditstatus());
						pstmt1.setString(2, beanobj.getCmscontentid());
						pstmt1.setString(3, beanobj.getSessionid());
						pstmt1.setString(4, beanobj.getLessonid());
						
						result += pstmt1.executeUpdate();
						
						log.info("Cmscontent================>>");
						//log.info("Cmscontent================>>");

						Query = "insert into cmscontentlog(cmslogid, cmscontentid, logstatus, cmslogdate, bywhom, cmscontentlogstatus) values(?,?,?,?,?,?)";
						pstmt = connection.prepareStatement(Query);
						pstmt.setLong(1, max_cmslogid);
						pstmt.setString(2, beanobj.getCmscontentid());
						if(beanobj.getEditstatus().equals("T"))
						pstmt.setString(3, "Trashed");
						else if(beanobj.getEditstatus().equals("X"))
							pstmt.setString(3, "Deleted");
						else
							pstmt.setString(3, "Updated");


						pstmt.setString(4, datetime.showTime("databaseinsert"));
						pstmt.setString(5, beanobj.getCreatedby());
						pstmt.setString(6, "A");
						result += pstmt.executeUpdate();
						//log.info("Cmscontentlog================>>");
						max_cmslogid++;
					}
	

			
			connection.commit();
			
		} catch (Exception exception) {
			connection.rollback();
			log.error(exception);
			log.error(exception);
			return 0;
		} finally {
			if (pstmt != null)
				pstmt.close();

			if (pstmt1 != null)
				pstmt1.close();


			if (connection != null)
				connection.close();
			
		}
		return result;
	}
	public int DeployedContentDataStatusupdation(ContentBean beanobj) throws SQLException {
		int result = 0;
		log.info("Invoke DeployedContentDataStatusupdation method to Trash /delete Deployed  content ================>>");
		 		
		
		PreparedStatement pstmt1 = null;


		String Query = "";
		Connection connection = null;

		try {
			
			long max_cmslogid = common_data_object.fmaxId("select max(cmslogid) from cmscontentlog");
			connection = ConnectionManager.getKycConnection();
			connection.setAutoCommit(false);

			if(beanobj.getCmscontentid()!=null)
			{
				Query = "Update cmscontentschedule set  cmscontentschedlestatus=? where cmscontentscheduleid=? and  cmscontentid =? and  lessonscheduleid=?";
						pstmt1 = connection.prepareStatement(Query);
						pstmt1.setString(1, beanobj.getEditstatus());
						pstmt1.setString(2, beanobj.getCmscontentscheduleid());
						pstmt1.setString(3,  beanobj.getCmscontentid());
						pstmt1.setString(4, beanobj.getLessonscheduleid());
						log.info("Cmscontent================>>");
						result += pstmt1.executeUpdate();
	
			}
	
			connection.commit();
			
		} catch (Exception exception) {
			connection.rollback();
			log.error(exception);
			return 0;
		} finally {
			
			if (pstmt1 != null)
				pstmt1.close();


			if (connection != null)
				connection.close();
			
		}
		return result;
	}


	CommonDataAccess common_data_object;
	DateTime datetime;
	String select_query;

}