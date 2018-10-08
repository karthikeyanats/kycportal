// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 5/6/2011 7:59:23 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   BillionUpload.java

package com.iGrandee.Registration;

import java.io.*;
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




public class InstitutionUpload
{
	static Logger log = Logger.getLogger(InstitutionUpload.class);
	DateTime datobj =new DateTime();

    public InstitutionUpload(HttpServletRequest request)
    {
        this.request = request;
        parametermap = new HashMap();
        filemap = new HashMap();
        //datetime = new DateTime();
       rbundle = ResourceBundle.getBundle("resources.serversetup");
    }

   public HashMap startProcess()
    {
	   String tempfilename = null;
       String FileExt = null;
       String pathaval = null;
       String temppath = null;
       HashMap photoList=new HashMap();
   		StaffRegistrationQuery objects=new StaffRegistrationQuery();
   		InstitutionQurey instiobjects=new InstitutionQurey();
        try
        {
        	
            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iter = upload.getItemIterator(request);
          //  current_date_time = datetime.showTime("forfilecreation");
            String storagepath = rbundle.getString("storagepath") ;
            File apps = new File(storagepath);
            if(apps.isDirectory())
            {

            String photopath="";
            String folderpath="";
            String foldername="";
            String keyname="";

            String photoname="";
            String datevalue = null;
            int uploadcount = 0;
            long maxuserid=0l;
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
                    	//log.info("name=====>>>>>"+Streams.asString(stream));

                        hm.put((new StringBuffer(String.valueOf(hm.size()))).toString(), Streams.asString(stream));
                        parametermap.put(name, hm);
                    }
                } else
                {
                  if(uploadcount == 0)
                    {
                       // datevalue = getParameter("cal");
                	  long aaa= instiobjects.maxinstituteid();
                	  photopath= storagepath +"/institutionstorage/"+aaa+"logo";
                	  folderpath="/institutionstorage/";
                	  photoname=aaa+"";
                	  foldername=aaa+"logo";
                	  keyname="institution";
                        File openfile = new File(photopath);
                        if(!openfile.exists())
                            openfile.mkdirs();
                  		log.info("openfile.exists()====>>>>"+openfile.exists());
                    	}
                  if(uploadcount == 1)
                  {
                 	 maxuserid=objects.maxuseridcount();
                 	 String aaaa=this.getParameter("Schoolusername");
                 	 aaaa=aaaa.trim();
                 	 aaaa=aaaa.replaceAll(" ", "");
                	  photopath=storagepath +"/userstorage/"+aaaa;
                	  photoname=aaaa+maxuserid;
                	  folderpath="/userstorage/";
                	  foldername=aaaa;
                	  keyname="user";

                      File openfile = new File(photopath);
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
                        pathaval = photopath+ "/" + photoname+ "." + FileExt;
                        temppath = folderpath + foldername + "/" + photoname+ "." + FileExt;
                        photoList.put(keyname,temppath);
                        log.info("temppath"+temppath);
                        BufferedInputStream bis = new BufferedInputStream(stream);
                        log.info("temppath2"+temppath);
                        BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(pathaval));
                        log.info("bos===>"+bos);  
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
                }
            }
            log.info("temppath4"+temppath);
            }
            else
            {
                photoList.put("institution","storage not connected");
            }
        }
        catch(Exception exception) {exception.printStackTrace();}
        return photoList;

    }
   
   /**
     * This method is accessed from kycportal/jsp/Registration/SchoolInformationSubmit.jsp
     * update institute info           - prasanth
     @param  txt_school_name that can be used to get  current institution name for institutelogo name creation and upload image to storage
     * 
     @return  String by which location the photo presented
   */
   
   public String startProcessbystring()
   {
	   String tempfilename = null;
      String FileExt = null;
      String pathaval = null;
      String temppath = null;
       try
       {
    	   log.info("update institute info from com.iGrandee.Registration.InstitutionUpload");
           ServletFileUpload upload = new ServletFileUpload();
           FileItemIterator iter = upload.getItemIterator(request);
           String storagepath = rbundle.getString("storagepath") + "institutionstorage/";  
           String datevalue = null;
           int uploadcount = 0;
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
                 if(uploadcount == 0)
                   {
                       File openfile = new File(storagepath+this.getParameter("instituteid"));
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
                       String times=datobj.showTime("Time").replaceAll(":","_");
                       pathaval = storagepath +this.getParameter("instituteid")+ "logo/" +this.getParameter("instituteid")+"_"+datobj.showTime("calendar")+"_"+times+ "." + FileExt;
                       temppath = "/institutionstorage/" + this.getParameter("instituteid") + "logo/" +this.getParameter("instituteid")+"_"+datobj.showTime("calendar")+"_"+times+"." + FileExt;
                       System.out.print("******pathaval***"+pathaval);
                       BufferedInputStream bis = new BufferedInputStream(stream);
                       BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(pathaval));
                       for(int totalread = 0; (totalread = bis.read(tempbuf)) != -1;)
                           bos.write(tempbuf, 0, totalread);  

                       bos.flush();  
                       filemap.put((new StringBuffer(String.valueOf(filemap.size()))).toString(), temppath);
                   } else
                   {
                       filemap.put((new StringBuffer(String.valueOf(filemap.size()))).toString(), "-");
                   }
                   uploadcount++;
               }
           }
       }
       catch(Exception exception)
       {
    	   log.error(exception);
       }
       return temppath;

   }
   
   
   /**
    * This method is accessed from kycportal/jsp/Registration/SchoolInformationSubmit.jsp
    * update institute info           - prasanth
    @param  name that can be used to get  parameter action  
    *
    @return    hashmap converted to string
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
    ResourceBundle rbundle;
    String current_date_time;
    static byte tempbuf[] = new byte[1024];

}