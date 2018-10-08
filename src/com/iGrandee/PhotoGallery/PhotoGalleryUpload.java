package com.iGrandee.PhotoGallery;
import com.iGrandee.PhotoGallery.PhotoGalleryBean;
import com.iGrandee.PhotoGallery.PhotoGalleryQuery;

import java.io.*;
import java.sql.*;
import java.util.*;
import java.sql.Date;
import com.iGrandee.Common.DateTime;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import org.apache.log4j.Logger;
import com.iGrandee.PhotoGallery.PhotoGalleryUpload;

public class PhotoGalleryUpload {
	static Logger log = Logger.getLogger(PhotoGalleryUpload.class);

	public PhotoGalleryUpload(HttpServletRequest request) {
        date_object = new DateTime();
        instituteconn      = null;


        
        this.request = request;
        parametermap = new HashMap();
        filemap = new HashMap();
        datobj =new DateTime();
       rbundle = ResourceBundle.getBundle("resources.serversetup");
	}
	 /**
	  * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGallerySubmit.jsp     - prasanth
      @return  HashMap that can be used to get image path and image name
	 */
	public HashMap startProcess()
    {
	   String tempfilename = null;
       String FileExt = null;
       String pathaval = null;
       String temppath = null;
       HashMap mainmap=new HashMap();

       HashMap FileList=new HashMap();
       HashMap FilenameList=new HashMap();

       
        try
        {
        	
            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iter = upload.getItemIterator(request);
            String storagepath = rbundle.getString("storagepath") ;
            String contentpath="";
            String folderpath="";
            String foldername="";

            String photoname="";
            String datevalue = null;
            int uploadcount = 0;
            int filecount = 1;

            while(iter.hasNext()) 
            {
                FileItemStream item = iter.next();
                String name = item.getFieldName();

                java.io.InputStream stream = item.openStream();
                if(item.isFormField())
                {
                    if(!parametermap.containsKey(name))
                    {
                        HashMap hm = new HashMap();
                        hm.put("0", Streams.asString(stream));
                        parametermap.put(name, hm);
                    } else
                    {
                        HashMap hm = (HashMap)parametermap.get(name);

                        hm.put((new StringBuffer(String.valueOf(hm.size()))).toString(), Streams.asString(stream));
                        parametermap.put(name, hm);
                    }
                } else
                {
      	 		  String time=datobj.showTime("Time").replaceAll(":","_");

                	if(uploadcount==0)
                	{
                	  contentpath= storagepath +"photogalery/";
                	  photoname="photogalery";
                	  folderpath="/photogalery/";
                	  File openfile = new File(contentpath);
                      if(!openfile.exists())
                           openfile.mkdirs();
                  	 	log.info("openfile.exists()====>>>>"+openfile.exists());
                	}                
                  	 	String fileName = item.getName();

                    log.info("fileName"+fileName);
                    if(!fileName.equals(""))
                    {
                        tempfilename = fileName.substring(fileName.lastIndexOf("\\") + 1, fileName.lastIndexOf("."));
                        FileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
                        pathaval = contentpath+ "/" + photoname+"_"+filecount+"_"+datobj.showTime("calendar")+"_"+time+ "." + FileExt;
                        temppath = folderpath + photoname+"_"+filecount+"_"+datobj.showTime("calendar")+"_"+time+ "." + FileExt;
                        FileList.put("path_"+filecount,temppath);
                        FilenameList.put("name_"+filecount,tempfilename+"." + FileExt);
                        BufferedInputStream bis = new BufferedInputStream(stream);
                        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(pathaval));
                        for(int totalread = 0; (totalread = bis.read(tempbuf)) != -1;)
                        bos.write(tempbuf, 0, totalread);

                        bos.flush();  
                        filemap.put((new StringBuffer(String.valueOf(filemap.size()))).toString(), temppath);
                        log.info("temppath3"+temppath);
                    } else
                    {
                        filemap.put((new StringBuffer(String.valueOf(filemap.size()))).toString(), "-");
                    }
                    uploadcount++;
                    filecount++;
                }
            }
            log.info("temppath4"+temppath);
            mainmap.put("path",FileList);
            mainmap.put("name",FilenameList);


        }
        catch(Exception exception)
        {
        	log.error(exception);
        }
        return mainmap;

    }
	 /**
	  * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGallerySubmit.jsp     - prasanth
     @return  String that can be used to converted into hashmap, again hashmap converted into string   
	 */
	 public String getParameter(String name)
	    {
	    	log.info(" update institute info from com.iGrandee.Registration.InstitutionUpload");
	        if(name == null)
	            throw new IllegalArgumentException("Form's name is invalid or does not exist (1305).");
	        HashMap values = (HashMap)parametermap.get(name);

	        if(values == null)
	        {
	            return null;
	        }
	        else
	        {
	            return (String)values.get("0");
	        }

	    }
	 /**
	  * This method is accessed from kycportal/jsp/PhotoGallery/PhotoGallerySubmit.jsp     - prasanth
     @return  String[] that can be used to converted into hashmap, again hashmap converted into string []  
	 */
	 public String[] getParameterValues(String name)
	    {
	        if(name == null)
	            throw new IllegalArgumentException("Form's name is invalid or does not exist (1305).");
	        HashMap values = (HashMap)parametermap.get(name);
	        if(values == null)
	            return null;
	        String strValues[] = new String[values.size()];
	        for(int i = 0; i < values.size(); i++)
	            strValues[i] = (String)values.get((new StringBuffer(String.valueOf(i))).toString());

	        return strValues;
	    }
	
	    HttpServletRequest request;
	    DateTime date_object;
	    Connection instituteconn;
	    HashMap parametermap;
	    HashMap filemap;
		DateTime datobj ;
	    ResourceBundle rbundle;
	    static byte tempbuf[] = new byte[1024];
	    ResultSet rs;
	 
	
}