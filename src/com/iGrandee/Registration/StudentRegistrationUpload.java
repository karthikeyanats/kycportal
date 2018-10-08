
package com.iGrandee.Registration;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.util.HashMap;
import java.util.ResourceBundle;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import org.apache.log4j.Logger;
public class StudentRegistrationUpload
{
	static Logger log = Logger.getLogger(StudentRegistrationUpload.class);

    public StudentRegistrationUpload(HttpServletRequest request)
    {
        this.request = request;
        parametermap = new HashMap();
        filemap = new HashMap();
        //datetime = new DateTime();
       rbundle = ResourceBundle.getBundle("resources.serversetup");
    }

   public String startProcess()
    {
   	   StaffRegistrationQuery objects=new StaffRegistrationQuery();

	   String tempfilename = null;
       String FileExt = null;
       String pathaval = null;
       String temppath = null;
       String storagepath ="";
   	   long maxuserid=0;

        try
        {
            ServletFileUpload upload = new ServletFileUpload();
            FileItemIterator iter = upload.getItemIterator(request);
          //  current_date_time = datetime.showTime("forfilecreation");
            storagepath = rbundle.getString("storagepath") + "/userstorage/";
            File apps = new File( rbundle.getString("storagepath"));
            if(apps.isDirectory())
            {
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
                    String userid=userid=getParameter("personid")+"";

                	//log.info(userid+"userid");
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
                      //log.info("maxuserid====>>>>"+maxuserid);
                      //log.info("this.getParameter(studusername)====>>>>"+getParameter("studusernamehidden"));

                       // datevalue = getParameter("cal");
                        File openfile = new File(storagepath+getParameter("studusernamehidden")+maxuserid);
                        if(!openfile.exists())
                            openfile.mkdirs();
                  		//log.info("openfile.exists()====>>>>"+openfile.exists());

                    	}

                   
                    String fileName = item.getName(); 
                    if(!fileName.equals(""))
                    {
                        tempfilename = fileName.substring(fileName.lastIndexOf("\\") + 1, fileName.lastIndexOf("."));
                        FileExt = fileName.substring(fileName.lastIndexOf(".") + 1);
                        pathaval = storagepath +getParameter("studusernamehidden")+maxuserid+ "/" + getParameter("studusernamehidden")+ "." + FileExt;
                        temppath = "/userstorage/" + getParameter("studusernamehidden")+maxuserid+ "/" + getParameter("studusernamehidden")+ "." + FileExt;
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
        }
        }
        catch(Exception exception) {exception.printStackTrace(); }
        //log.info("temppath====>>>>"+temppath);
        if(temppath==null)
        {
            String userid=userid=getParameter("personid")+"";

        	if(userid.equals("null"))
        	{
        	 maxuserid=objects.maxuseridcount();
        	}
        	else
        	{
        	 maxuserid=Long.parseLong(userid);
        	}
        	temppath="/userstorage/" +getParameter("studusernamehidden")+maxuserid+ "/" + getParameter("studusernamehidden")+ ".jpg";
        }
        return temppath;

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
   // DateTime datetime;
    ResourceBundle rbundle;
    String current_date_time;
    static byte tempbuf[] = new byte[1024];

}