package com.iGrandee.Registration;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.log4j.Logger;

import com.iGrandee.Common.DateTime;

	public class ProfileUpload
	{

		static Logger log = Logger.getLogger(ProfileUpload.class);

	 public ProfileUpload(HttpServletRequest request)
	 {
	     this.request 	= request;
	     parametermap 	= new HashMap();
	     filemap 		= new HashMap();
	     datetime 		= new DateTime();
	     rbundle 		= ResourceBundle.getBundle("resources.serversetup");
	     session		= request.getSession();
	 }

	 public void startProcess()
	 {
		 	log.info("invoking startProcess from com.iGrandee.Registration.ProfileUpload");

	     try
	     {
	         
	    	 ServletFileUpload upload 	= new ServletFileUpload();
	         FileItemIterator iter 		= upload.getItemIterator(request);
	         current_date_time 			= datetime.showTime("for_secure");
	         String storagepath 		= rbundle.getString("storagepath");
	         String instituteid			= (String)session.getValue("instituteid");
	         String userid				= (String)session.getValue("userid");
	       	 storagepath  				+= "/BulkProfile/"+instituteid+"/"+userid+"/";
	         
	         File openfile = new File(storagepath);
	         if(!openfile.exists())
	             openfile.mkdirs();
	         
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
	                 String FileExt = null;
	                 String pathaval = null;
	                 String temppath = null;
	                 String fileName = item.getName();
	                 if(!fileName.equals(""))
	                 {
	                     FileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
	                     pathaval = storagepath + "/doc_" + current_date_time + uploadcount + "." + FileExt;
	                     temppath = "/BulkProfile/"+instituteid+"/"+userid+"/doc_" + current_date_time + uploadcount + "." + FileExt;
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
	 }

	 public String getParameter(String name)
	 {
		 	log.info("invoking getParameter from com.iGrandee.Registration.ProfileUpload");

	     if(name == null)
	         throw new IllegalArgumentException("Form's name is invalid or does not exist (1305).");
	     HashMap values = (HashMap)parametermap.get(name);
	     if(values == null)
	         return null;
	     else
	         return (String)values.get("0");
	 }

	 public String[] getParameterValues(String name)
	 {
		 	log.info("invoking getParameterValues from com.iGrandee.Registration.ProfileUpload");

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
		 	log.info("invoking getFileNames from com.iGrandee.Registration.ProfileUpload");

	     String strValues[] = new String[filemap.size()];
	     for(int i = 0; i < filemap.size(); i++)
	         strValues[i] = (String)filemap.get((new StringBuffer(String.valueOf(i))).toString());

	     return strValues;
	 }

	 public void clearAllObject()
	 {
		
		 log.info("invoking clearAllObject from com.iGrandee.Assignment.AssignmentUpload");

	     request 		= null;
	     parametermap 	= null;
	     filemap 		= null;
	     datetime 		= null;
	     rbundle 		= null;
	 }

	 HttpServletRequest request;
	 HashMap parametermap;
	 HashMap filemap;
	 DateTime datetime;
	 ResourceBundle rbundle;
	 String current_date_time;
	 static byte tempbuf[] = new byte[1024];
	 HttpSession session;

	}