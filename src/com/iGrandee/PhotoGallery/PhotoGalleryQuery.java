package com.iGrandee.PhotoGallery;
import com.iGrandee.PhotoGallery.PhotoGalleryBean;
import com.iGrandee.PhotoGallery.PhotoGalleryQuery;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;
import com.iGrandee.Common.ConnectionManager;
import com.iGrandee.Common.CommonDataAccess;


import java.util.HashMap;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;

public class PhotoGalleryQuery {
	static Logger log = Logger.getLogger(PhotoGalleryQuery.class);

	
	 public PhotoGalleryQuery()
	    {
	        common_data_object = new CommonDataAccess();
	        connectionManager = new ConnectionManager();
	       select_query = null;
	       

	    }
	 /**
	   * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGalleryEvent.jsp
	   * List Year of session         - prasanth
	   @param  instituteid that can be used to list session details from yearofsession table by instituteid wise
	   *
       @return  ArrayList by which result can be printed on the screen
	 */
	 public ArrayList listYearofSession(String instituteid)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
				log.info("invoking list of YearofSession   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");

	        	select_query = "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"+instituteid+"' and ( sessionstatus='A' or sessionstatus='R') ";
	        	log.info(select_query);
		        arraylist = common_data_object.getListMap(select_query);
	        }
	        catch(Exception e)
	        {
	        	log.error(e); 
	        }
	        return arraylist;
	    }
	 /**
	   * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGalleryhmview.jsp
	   * List Year of session         - prasanth
	   @param  instituteid that can be used to list session details from yearofsession table by instituteid wise
	   *
       @return  ArrayList by which result can be printed on the screen
	 */
	 public ArrayList listYearofSessionHM(String instituteid)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
				log.info("invoking list of YearofSession   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");

	        	select_query = "select sessionid,sessionname,sessionstatus from yearofsession where instituteid='"+instituteid+"' and  sessionstatus='A'  ";
	        	log.info(select_query);
		        arraylist = common_data_object.getListMap(select_query);
	        }
	        catch(Exception e)
	        {
	        	log.error(e); 
	        }
	        return arraylist;
	    }
	 /**
	  * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGalleryEvent.jsp
	  * List ExtraCurricularCategoryList         - prasanth
	  * @param  instituteid that can be used to list CurricularCategoryList from yearofsession table by instituteid wise
	  *
      @param curricularstatus that can be used to list session details from extracurricularcategory table by curricularstatus wise
      *
      @return  ArrayList by which result can be printed on the screen
	 */
	 public ArrayList listExtraCurricularCategoryList(String instituteid,String curricularstatus)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
				log.info("invoking list CurricularCategoryList   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");

	        	select_query = "SELECT a.extracurricularcategoryid, a.extcurricularcategoryname, a.curriculardescription, a.createdby, date_format(a.dateofcreation,'%d-%b-%Y') as newdates, a.curricularstatus  from extracurricularcategory a,login b,personmaster c where  a.createdby=b.userid and b.personid=c.personid and c.instituteid='"+instituteid+"' and a.curricularstatus='"+curricularstatus+"' order by a.dateofcreation desc";
	        	log.info(select_query);

		        arraylist = common_data_object.getListMap(select_query);
	        }catch(Exception e)
	        {
	        	log.error(e);
	        }
	        return arraylist;    
	    }
	 /**
	   * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGalleryEvent.jsp
	   * List listExtraCurricularEventList         - prasanth
       @param categoryid that can be used to list session details from curricularevent table by categoryid wise
       *
       @param sessionid that can be used to list session details from curricularevent table by sessionid wise
       *
       @param eventstatus that can be used to list session details from curricularevent table by eventstatus wise
       *
       @return  ArrayList by which result can be printed on the screen
	 */
	 public ArrayList listExtraCurricularEventList(String categoryid,String sessionid,String eventstatus)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
				log.info("invoking list of listExtraCurricularEventList   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");

	        	//select_query = "select curriculareventid, extracurricularcategoryid, curriculareventname,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation, venu, date_format(eventdate,'%d-%b-%Y') as eventdate from curricularevent where sessionid='"+sessionid+"' and extracurricularcategoryid='"+categoryid+"' and eventstatus='"+eventstatus+"' order by dateofcreation desc";
				//select_query = "select curriculareventid, extracurricularactivityid, curriculareventname,date_format(dateofcreation,'%d-%b-%Y') as dateofcreation, venu, date_format(eventdate,'%d-%b-%Y') as eventdate from curricularevent where sessionid='"+sessionid+"' and extracurricularactivityid='"+categoryid+"' and eventstatus='"+eventstatus+"' order by dateofcreation desc";
				select_query = "select a1.curriculareventid, a1.extracurricularactivityid, a1.curriculareventname,date_format(a1.dateofcreation,'%d-%b-%Y') as dateofcreation, a1.venu, date_format(a1.eventdate,'%d-%b-%Y') as eventdate,(select count(a2.eventphotogalleryid) from eventphotogallery a2,yearofsession b2 where a2.curriculareventid=a1.curriculareventid and a2.sessionid=b2.sessionid and b2.sessionstatus='A' and a2.gallerystatus='A') as photocount from curricularevent a1 where a1.sessionid='"+sessionid+"' and a1.extracurricularactivityid='"+categoryid+"' and a1.eventstatus='"+eventstatus+"' order by dateofcreation desc";
	        	log.info(select_query);
	        	//System.out.print("select_query-->"+select_query);
		        arraylist = common_data_object.getListMap(select_query);
	        }catch(Exception e)
	        {log.error(e);
	        }
	        return arraylist;
	    }
	 /**
	   * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGallerySubmit.jsp
	   * List listExtraCurricularEventList         - prasanth
       @param eventphotogalleryid that can be used to insert  details to eventphotogallery table 
       *
       @param curriculareventid that can be used to insert  details to eventphotogallery table 
       *
       @param caption that can be used to insert  details to eventphotogallery table 
       *
       @param gallerypath that can be used to insert  details to eventphotogallery table 
       *
       @param dateofcreation that can be used to insert  details to eventphotogallery table 
       *
       @param createdby that can be used to insert  details to eventphotogallery table 
       *
       @param sessionid that can be used to insert  details to eventphotogallery table 
       *
       @param gallerystatus that can be used to insert  details to eventphotogallery table 
       *
       @param photoname that can be used to insert  details to eventphotogallery table 
       *
       @return  int by which result can be printed on the screen
	 */
	 public int insertphotots(PhotoGalleryBean photobean)throws SQLException
	    {
			log.info("invoking insert  photogallery   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");
			int result=0;

	    	PreparedStatement settingsprepared  = null;
	 
	        try
	        
	    	{
				log.info("invoking insert  photogallery   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");

	       instituteconn = ConnectionManager.getKycConnection();
	       String [] totallen= photobean.getCaption();
	       String[] Caption=photobean.getCaption();
	       String[] Gallerypath=photobean.getGallerypath();
	       String[] photoname=photobean.getPhotoname();

	        for(int j = 0; j < totallen.length; j++)
			{       	

			
			long l = common_data_object.fmaxId("select max(eventphotogalleryid)from eventphotogallery");

			String query="insert into eventphotogallery (eventphotogalleryid,curriculareventid,caption,gallerypath,dateofcreation,createdby,sessionid,gallerystatus,photoname) values(?,?,?,?,?,?,?,?,?)";
			settingsprepared = instituteconn.prepareStatement(query);
			
			settingsprepared.setLong(1, l);
			settingsprepared.setString(2,photobean.getExtracurricularcurriculareventid());
			settingsprepared.setString(3,Caption[j]);
			settingsprepared.setString(4, Gallerypath[j]);
			settingsprepared.setString(5, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(6, photobean.getCreatedby());
			settingsprepared.setString(7, photobean.getSessionid());
			settingsprepared.setString(8, "A");
			settingsprepared.setString(9,photoname[j]);         

		    result = settingsprepared.executeUpdate();
		
			}
	    	}catch(Exception exception) 
	    	{ 
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
	 
	 /**
	   * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGalleryEdit.jsp
	   * List listExtraCurricularEventList         - prasanth
       @param eventphotogalleryid that can be used to update  details to eventphotogallery table 
       *
       @param curriculareventid that can be used to update  details to eventphotogallery table 
       *
       @param caption that can be used to update  details to eventphotogallery table 
       *
       @param gallerypath that can be used to update  details to eventphotogallery table
       * 
       @param dateofcreation that can be used to update  details to eventphotogallery table 
       *
       @param createdby that can be used to update  details to eventphotogallery table 
       *
       @param sessionid that can be used to update  details to eventphotogallery table 
       *
       @param gallerystatus that can be used to update  details to eventphotogallery table
       * 
       @param photoname that can be used to update  details to eventphotogallery table 
       *
       @return  int by which result can be printed on the screen
	 */
      
	   public int updatePhotogalley(PhotoGalleryBean photobean)throws SQLException
	    {
			log.info("invoking updatePhotogalley  from com.iGrandee.PhotoGallery.PhotoGalleryQuery");
			int result=0;

	    	PreparedStatement settingsprepared  = null;
	 
	        try
	        
	    	{

	       instituteconn = ConnectionManager.getKycConnection();
	      
	        
			String[] photoname=photobean.getPhotoname();
			String[] path=photobean.getGallerypath();
	        instituteconn = ConnectionManager.getKycConnection();

         	String query="update eventphotogallery set curriculareventid=?,caption=?,gallerypath=?,dateofcreation=?,createdby=?,sessionid=?,gallerystatus=?,photoname=? where eventphotogalleryid=?";
			settingsprepared = instituteconn.prepareStatement(query);
			settingsprepared.setString(1,photobean.getExtracurricularcurriculareventid());
			settingsprepared.setString(2, photobean.getcaption());
			settingsprepared.setString(3, path[0]);
			settingsprepared.setString(4, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(5, photobean.getCreatedby());
			settingsprepared.setString(6,photobean.getSessionid());
			settingsprepared.setString(7,"A");
			settingsprepared.setString(8,photoname[0]);  
			settingsprepared.setString(9,photobean.getEventphotogalleryid());
			result = settingsprepared.executeUpdate();

	    	}catch(Exception exception)
	    	{ 
	    		log.error(exception);	
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
	    	}
	   /**
		   * This method is accessed from kycportal/jsp/PhotoGallery/PhotoAction.jsp
		   * List listExtraCurricularEventList         - prasanth
	       @param eventphotogalleryid that can be used to update  details to eventphotogallery table 
	       *
	       @param dateofcreation that can be used to update  details to eventphotogallery table 
	       *
	       @param createdby that can be used to update  details to eventphotogallery table 
	       *
	       @param gallerystatus that can be used to update  details to eventphotogallery table 
	       *
	       @return  int by which result can be printed on the screen
		 */
	   public int updateStatus(PhotoGalleryBean photobean)throws SQLException
	    {
			log.info("invoking photon gallery  Status   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");
			int result=0;

	    	PreparedStatement settingsprepared  = null;
	 
	        try
	        
	    	{
	       instituteconn = ConnectionManager.getKycConnection();
	      
	        
			
	       instituteconn = ConnectionManager.getKycConnection();

        	String query="update eventphotogallery set dateofcreation=?,createdby=?,gallerystatus=? where eventphotogalleryid=?";
			settingsprepared = instituteconn.prepareStatement(query);
			settingsprepared.setString(1, DateTime.showTime("MySqlWithTime"));
			settingsprepared.setString(2, photobean.getCreatedby());
			settingsprepared.setString(3,photobean.getGallerystatus());
			settingsprepared.setString(4,photobean.getEventphotogalleryid());
			result = settingsprepared.executeUpdate();

	    	}catch(Exception exception)
	    	{ 
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
	   /**
		  * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGalleryEvent.jsp
		  * List listExtraCurricularEventList         - prasanth
	       @param eventphotogalleryid that can be used to delete  details from eventphotogallery table 
	       *
	       @return  int by which result can be printed on the screen
		 */
	   public int deleteStatus(PhotoGalleryBean photobean)throws SQLException
	    {
			log.info("invoking delete photo gallery   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");
			int result=0;

	    	PreparedStatement settingsprepared  = null;
	 
	        try
	        
	    	{
	       instituteconn = ConnectionManager.getKycConnection();
	      
		    String query="delete from eventphotogallery  where eventphotogalleryid=?";
			settingsprepared = instituteconn.prepareStatement(query);
			settingsprepared.setString(1,photobean.getEventphotogalleryid());
			result = settingsprepared.executeUpdate();

	    	}catch(Exception exception)
	    	{ 
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
	   /**
		  * This method is accessed from kycportal/jsp/PhotoGallery/phodetails.jsp
		  * This method is accessed from kycportal/jsp/PhotoGallery/phototrashlist.jsp 
		  * List listExtraCurricularEventList         - prasanth
	       @param status that can be used to get all  details from eventphotogallery table 
	       *
	       @param sessionid that can be used to delete  details from eventphotogallery table 
	       *
	       @param curriculareventid that can be used to delete  details from eventphotogallery table 
	       *
	       @return  ArrayList by which result can be printed on the screen
		 */
	    public ArrayList listeventphotogallery(String status,String sessionid,String curriculareventid)
	    {
	        ArrayList arraylist = new ArrayList();
	        try
	        {
				log.info("invoking list event photogallery  from com.iGrandee.PhotoGallery.PhotoGalleryQuery");

	        	select_query = "select eventphotogalleryid,curriculareventid,caption,gallerypath,DATE_FORMAT(dateofcreation, '%d-%b-%Y') as newdates,photoname from eventphotogallery where curriculareventid='"+curriculareventid+"' and sessionid='"+sessionid+"' and gallerystatus='"+status+"' order by dateofcreation desc";
	        	log.info(select_query);
		        arraylist = common_data_object.getListMap(select_query);
	        }catch(Exception e)
	        {
	        	log.error(e);
	        }
	        return arraylist;
	    }
	    /**
		  * This method is accessed from kycportal/jsp/PhotoGallery/phodetails.jsp
		  * This method is accessed from kycportal/jsp/PhotoGallery/phototrashlist.jsp 
		  * List listExtraCurricularEventList         - prasanth
	       @param status that can be used to get all  details from eventphotogallery table 
	       *
	       @param sessionid that can be used to delete  details from eventphotogallery table 
	       *
	       @param curriculareventid that can be used to delete  details from eventphotogallery table 
	       *
	       @return  ArrayList by which result can be printed on the screen
		 */
	    public ArrayList getPhotos(String curriculareventid,String instituteid)
	    {
	        ArrayList arraylist = new ArrayList();
	        try  
	        {
				log.info("invoking getPhotos   from com.iGrandee.PhotoGallery.PhotoGalleryQuery");

	        	//select_query = "select eventphotogalleryid,curriculareventid,caption,gallerypath,DATE_FORMAT(dateofcreation, '%d-%c-%Y') as newdates,photoname from eventphotogallery where curriculareventid='"+curriculareventid+"' and gallerystatus='A' order by dateofcreation desc";
	        	select_query = "select a.eventphotogalleryid,a.curriculareventid,a.caption,a.gallerypath, DATE_FORMAT(a.dateofcreation, '%d-%c-%Y') as newdates,a.photoname from eventphotogallery a,yearofsession b where a.curriculareventid='"+curriculareventid+"' and a.sessionid=b.sessionid and b.instituteid='"+instituteid+"' and b.sessionstatus='A' and a.gallerystatus='A' order by a.dateofcreation desc;";
				log.info(select_query);
		        arraylist = common_data_object.getListMap(select_query);
	        }catch(Exception e){log.error(e);}
	        return arraylist;
	    }   
	   
	    HttpServletRequest request;
	    Connection instituteconn;
	    CommonDataAccess common_data_object;
	    ConnectionManager connectionManager;
		DateTime datobj ;
	    String select_query;
	    ResultSet rs;
	 
	
}