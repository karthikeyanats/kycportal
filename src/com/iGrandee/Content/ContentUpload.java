// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 5/6/2011 7:59:23 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   BillionUpload.java

package com.iGrandee.Content;

import java.io.*;
import java.util.Calendar;
import java.util.HashMap;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.log4j.Logger;

import com.iGrandee.Common.DateTime;
import com.iGrandee.Registration.InstitutionQurey;



public class ContentUpload
{
	static Logger log = Logger.getLogger(ContentUpload.class);
	Calendar cal = Calendar.getInstance();
    public ContentUpload(HttpServletRequest request)
    {
        this.request = request;
        parametermap = new HashMap();
        filemap = new HashMap();
        datobj =new DateTime();
        rbundle = ResourceBundle.getBundle("resources.serversetup");
        
    }

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
            File apps = new File(storagepath);
            if(apps.isDirectory())
            {
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
                	if(uploadcount==0)
                	{
        	 		  String time=datobj.showTime("Time").replaceAll(":","_");
                	  contentpath= storagepath +getParameter("instituteid")+"/CMSstorage/"+getParameter("sessionid")+"/"+getParameter("standardscheduleid")+"/"+getParameter("req_subjectid")+"/"+getParameter("req_lessonid")+"/";
                	  //photoname=getParameter("req_lessonid")+"_"+filecount+"_"+datobj.showTime("calendar")+"_"+time;
                	  photoname=getParameter("req_lessonid")+"_"+filecount+"_"+cal.getTimeInMillis();
                	  
                	  folderpath="/"+getParameter("instituteid")+"/CMSstorage/"+getParameter("sessionid")+"/"+getParameter("standardscheduleid")+"/"+getParameter("req_subjectid")+"/"+getParameter("req_lessonid")+"/";
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
                        /*pathaval = contentpath+ photoname+ "." + FileExt;
                        temppath = folderpath + photoname+ "." + FileExt;*/
                        pathaval = contentpath+ photoname+"_"+filecount+ "." + FileExt;
                        temppath = folderpath + photoname+"_"+filecount+ "." + FileExt;
                       // System.out.println(pathaval+"pathaval");
                        //System.out.println(temppath+"temppath");

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
            else
            {
            	FileList.put("path_1","storage not connected");
            	FilenameList.put("name_1","storage not connected");
	        	mainmap.put("path",FileList);
	            mainmap.put("name",FilenameList);
            }
        }
        catch(Exception exception) {exception.printStackTrace();}
        return mainmap;

    }
   
   /*
    * This method is accessed from kycportal/jsp/Registration/SchoolInformationSubmit.jsp
    * update institute info           - prasanth
     @param  txt_school_name that can be used to get  current institution name for institutelogo name creation and upload image to storage 
     @return  String by which location the photo presented
   */
   
   public HashMap startProcessForSingle()
   {
	   String tempfilename = null;
       String FileExt = null;
       String pathaval = null;
       String temppath = null;
       HashMap mainmap=new HashMap();
     
        try
        {
        	 
            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iter = upload.getItemIterator(request);
            String storagepath = rbundle.getString("storagepath") ;
            File apps = new File(storagepath);
            if(apps.isDirectory())
            {
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
                	if(uploadcount==0)
                	{
        	 		  String time=datobj.showTime("Time").replaceAll(":","_");
                	  contentpath= storagepath +getParameter("instituteid")+"/CMSstorage/"+getParameter("sessionid")+"/"+getParameter("standardscheduleid")+"/"+getParameter("req_subjectid")+"/"+getParameter("req_lessonid")+"/";
                	  //photoname=getParameter("req_lessonid")+"_"+filecount+"_"+datobj.showTime("calendar")+"_"+time;
                	  photoname=getParameter("req_lessonid")+"_"+filecount+"_"+cal.getTimeInMillis();                	  
                	  folderpath="/"+getParameter("instituteid")+"/CMSstorage/"+getParameter("sessionid")+"/"+getParameter("standardscheduleid")+"/"+getParameter("req_subjectid")+"/"+getParameter("req_lessonid")+"/";
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
                        pathaval = contentpath+ "/" + photoname+ "." + FileExt;
                        temppath = folderpath + photoname+ "." + FileExt;
                        mainmap.put("path",temppath);
                        mainmap.put("name",tempfilename+"." + FileExt);

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
             }
             else
             {
            	 mainmap.put("path","storage not connected");
                 mainmap.put("name","storage not connected");
             }
        }
        catch(Exception exception) {exception.printStackTrace();}
        return mainmap;
   }
   
   
   /*
    * This method is accessed from kycportal/jsp/Registration/SchoolInformationSubmit.jsp
    * update institute info           - prasanth
    @param  name that can be used to get  parameter action  
     @return  String,  hashmap converted to string
   */
    public String getParameter(String name)
    {
    	log.info(" update institute info from com.iGrandee.Registration.InstitutionUpload");
        if(name == null)
            throw new IllegalArgumentException("Form's name is invalid or does not exist (1305).");
        HashMap values = (HashMap)parametermap.get(name);

        if(values == null)
        {
        	//log.info("values====>>>>null");
            return null;
        }
        else
        {
        	//log.info("values====>>>>"+(String)values.get("0"));
            return (String)values.get("0");
        }

    }

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

    public String[] getFileNames()
    {
        String strValues[] = new String[filemap.size()];
        for(int i = 0; i < filemap.size(); i++)
            strValues[i] = (String)filemap.get((new StringBuffer(String.valueOf(i))).toString());

        return strValues;
    }

    public void clearAllObject()
    {
        request = null;
        parametermap = null;
        filemap = null;
        //datetime = null;
        rbundle = null;
    }

    HttpServletRequest request;
    HashMap parametermap;
    HashMap filemap;
   // DateTime datetime;
	DateTime datobj ;

    ResourceBundle rbundle;
    String current_date_time;
    static byte tempbuf[] = new byte[1024];

}