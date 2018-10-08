// Decompiled by DJ v3.7.7.81 Copyright 2004 Atanas Neshkov  Date: 5/6/2011 7:59:23 PM
// Home Page : http://members.fortunecity.com/neshkov/dj.html  - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   BillionUpload.java

package com.iGrandee.Registration;

import java.io.*;
import java.util.HashMap;
import java.util.ResourceBundle;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.log4j.Logger;
import com.iGrandee.Common.DateTime;

import com.iGrandee.Registration.StaffRegistrationQuery;
public class StaffRegistrationUpload
{
	static Logger log = Logger.getLogger(StaffRegistrationUpload.class);

    public StaffRegistrationUpload(HttpServletRequest request)
    {
        this.request = request;
        parametermap = new HashMap();
        filemap = new HashMap();
        datetime = new DateTime();
       rbundle = ResourceBundle.getBundle("resources.serversetup");
    }

   public HashMap startProcess()   
    {
	   String tempfilename = null;
       String FileExt = null;
       String pathaval = null;
       String temppath = null;
       String phototemppath = null;
   	StaffRegistrationQuery objects=new StaffRegistrationQuery();

       HashMap mainmap=new HashMap();
        try
        {

            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iter = upload.getItemIterator(request);
          //  current_date_time = datetime.showTime("forfilecreation");
            String storagepath = rbundle.getString("storagepath") + "/userstorage/";
            File apps = new File( rbundle.getString("storagepath"));
            
            
            System.out.println("storagepath ===>>>>>"+storagepath);
            
            if(!apps.exists())
            	apps.mkdirs();

            if(apps.isDirectory())
            {

            String datevalue = null;
            int uploadcount = 0;
        	long count=0;

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
                	//long maxuserid=objects.maxuseridcount();
                	String userid=getParameter("personid")+"";
                	long maxuserid=0;

                	log.info(userid+"userid");
                	if(userid.equals("null"))
                	{
                	 maxuserid=objects.maxuseridcount();
                	}
                	else
                	{
                	 maxuserid=Long.parseLong(userid);
                	}
                	//System.out.print("================>>>>>>>>>>>>>>>>>>>>>>>>>>"+(getParameter("phototype")+""));
                	if((getParameter("phototype")+"").equals("local"))
                	{
		                  if(uploadcount == 0)
		                    {
		                       // datevalue = getParameter("cal");
		                        File openfile = new File(storagepath+this.getParameter("hiddenuser_id")+maxuserid);
		                        if(!openfile.exists())
		                            openfile.mkdirs();
		                  		log.info("openfile.exists()====>>>>"+openfile.exists());
		                  		
		                    }
		                  else if(uploadcount == 1)   
		                  {
		                	  File openfile = new File(storagepath+this.getParameter("hiddenuser_id")+maxuserid+"/certificate/");
		                      if(!openfile.exists())
		                          openfile.mkdirs();
		                		log.info("openfile.exists()====>>>>"+openfile.exists());
		                  }
                	}
                	else
                	{
                		if(uploadcount == 0)
		                  {
		                	  File openfile = new File(storagepath+this.getParameter("hiddenuser_id")+maxuserid+"/certificate/");
		                      if(!openfile.exists())
		                          openfile.mkdirs();
		                		log.info("openfile.exists()====>>>>"+openfile.exists());
		                  }
                	}
                	
                    String fileName = item.getName();
                    if(!fileName.equals(""))
                    {
                       
                    	tempfilename = fileName.substring(fileName.lastIndexOf("\\") + 1, fileName.lastIndexOf("."));
                        FileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
                        if((getParameter("phototype")+"").equals("local"))
                    	{
	                        if(uploadcount == 0)
	                        {
	                        pathaval = storagepath +this.getParameter("hiddenuser_id")+maxuserid+ "/" + this.getParameter("hiddenuser_id")+ "." + FileExt;
	                        temppath = "/userstorage/" + this.getParameter("hiddenuser_id")+maxuserid+ "/" + this.getParameter("hiddenuser_id")+ "." + FileExt;
	                        mainmap.put("personphoto", temppath);
	                        }
	                        else
	                        {
	                        	if(!getParameter("certificatename"+uploadcount).equals("") && getParameter("certificatename"+uploadcount)!=null)
	                        	{
			                       pathaval = storagepath +this.getParameter("hiddenuser_id")+maxuserid+ "/certificate/" + getParameter("hiddenuser_id")+"_"+datetime.showTime("for_secure")+ "." + FileExt;
			                       temppath = "/userstorage/" + this.getParameter("hiddenuser_id")+maxuserid+ "/certificate/" + getParameter("hiddenuser_id")+"_"+datetime.showTime("for_secure")+ "." + FileExt;
			                       HashMap innermap=new HashMap(); 
			                       innermap.put("certificatepath", temppath);
			                       innermap.put("certificatename", getParameter("certificatename"+uploadcount));  
			                       mainmap.put("certificatemap"+count, innermap);
			                       count++;
	                        	}
	                        }	
                    	}
                        else
                        {
                        	if(!getParameter("certificatename"+(uploadcount+1)).equals("") && getParameter("certificatename"+(uploadcount+1))!=null)
                        	{
		                       pathaval = storagepath +this.getParameter("hiddenuser_id")+maxuserid+ "/certificate/" + getParameter("hiddenuser_id")+"_"+datetime.showTime("for_secure")+ "." + FileExt;
		                       temppath = "/userstorage/" + this.getParameter("hiddenuser_id")+maxuserid+ "/certificate/" + getParameter("hiddenuser_id")+"_"+datetime.showTime("for_secure")+ "." + FileExt;
		                       HashMap innermap=new HashMap(); 
		                       innermap.put("certificatepath", temppath);
		                       innermap.put("certificatename", getParameter("certificatename"+(uploadcount+1)));  
		                       mainmap.put("certificatemap"+count, innermap);
		                       count++;
                        	}
                        }
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
            else
            {
            	temppath="storage not connected";
                mainmap.put("personphoto", temppath);

            }
            
        }
        catch(Exception exception) {exception.printStackTrace(); }

        //System.out.println("mainmap size========>>>>"+mainmap.size());
       //System.out.println("mainmap personphoto========>>>>"+mainmap.get("personphoto")); 

        if(mainmap.get("personphoto")==null && (mainmap.get("personphoto")+"").equals("null"))
        {
        	String userid=getParameter("personid")+"";
        	long maxuserid=0;

        	log.info(userid+"userid");
        	if(userid.equals("null"))
        	{
        	 maxuserid=objects.maxuseridcount();
        	}
        	else
        	{
        	 maxuserid=Long.parseLong(userid);
        	}
        	phototemppath="/userstorage/" + this.getParameter("hiddenuser_id")+maxuserid+ "/" + this.getParameter("hiddenuser_id")+ "." + "jpg";
        	mainmap.put("personphoto", phototemppath);
        }
      //  System.out.println("mainmap personphoto========>>>>"+mainmap.get("personphoto")); 

        return mainmap;

    }
   public HashMap startProcessnew()   
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
           String storagepath = rbundle.getString("storagepath") + "/userstorage/";
           File apps = new File( rbundle.getString("storagepath"));
           if(apps.isDirectory())
           {
           String datevalue = null;
           int uploadcount = 0;
       	   long count=0;
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
               	StaffRegistrationQuery objects=new StaffRegistrationQuery();
               	String userid=getParameter("personid")+"";
               	long maxuserid=0;
               	log.info(userid+"userid");
               	if(userid.equals("null"))
               	{
               	 maxuserid=objects.maxuseridcount();
               	}
               	else
               	{
               	 maxuserid=Long.parseLong(userid);
               	}
                 if(uploadcount == 0)
                   {
                	  File openfile = new File(storagepath+this.getParameter("hiddenuser_id")+maxuserid+"/certificate/");
                     if(!openfile.exists())
                         openfile.mkdirs();
               		log.info("openfile.exists()====>>>>"+openfile.exists());
                 }
                   String fileName = item.getName();
                   if(!fileName.equals(""))
                   {
                       tempfilename = fileName.substring(fileName.lastIndexOf("\\") + 1, fileName.lastIndexOf("."));
                       FileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
                       pathaval = storagepath +getParameter("hiddenuser_id")+maxuserid+ "/certificate/" + getParameter("hiddenuser_id")+"_"+datetime.showTime("for_secure")+ "." + FileExt;
                       temppath = "/userstorage/" + this.getParameter("hiddenuser_id")+maxuserid+ "/certificate/" + getParameter("hiddenuser_id")+"_"+datetime.showTime("for_secure")+ "." + FileExt;
                       HashMap innermap=new HashMap(); 
                       innermap.put("certificatepath", temppath);
                       innermap.put("certificatename", getParameter("certificatename"+uploadcount));  
                       mainmap.put("certificatemap"+count, innermap);
                       count++;
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
               if(uploadcount == 0)
               {
            		temppath="No photo Uploaded";
                    HashMap innermap=new HashMap(); 
                   	innermap.put("certificatepath", temppath);
                    innermap.put("certificatename", temppath);
                    mainmap.put("certificatemap0", innermap);
               }
           }
           }
           else
           {
           	temppath="storage not connected";
            HashMap innermap=new HashMap(); 
           	innermap.put("certificatepath", temppath);
            innermap.put("certificatename", temppath); 
            mainmap.put("certificatemap0", innermap);
           }
           
       }
       catch(Exception exception) {exception.printStackTrace(); }

       return mainmap;

   }

    public String getParameter(String name)
    {
    	//log.info("name====>>>>"+name);
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
    DateTime datetime;
    ResourceBundle rbundle;
    String current_date_time;
    static byte tempbuf[] = new byte[1024];

}