package com.vd;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.util.ResourceBundle;

import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;

import com.iGrandee.TimeTable.PeriodTime.WorkAllotment;

public class OpenFile extends HttpServlet
{
	static Logger log = Logger.getLogger(WorkAllotment.class);
	
	private static final long serialVersionUID = 1L;
	private static final int DEFAULT_BUFFER_SIZE = 90240;


    public OpenFile()
    {
    }

    public void init(ServletConfig config)
    {

    }

    public void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException
    {
        doPost(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException
    {
        try
        {
			ResourceBundle bundle = ResourceBundle.getBundle("resources.serversetup");

            String productCode = request.getParameter("r1");
            String s1 = null;

			s1 = bundle.getString(productCode);
            String s2 = request.getParameter("r2");
            if(s2==null || s2=="")
            	s2="Empty";
            String s3 = request.getParameter("r3");
            String s4 = "txt";
            String filename = "Empty";
            


            if(s2 != null && s2.indexOf(".") != -1)
            {
                s4 = s2.substring(s2.lastIndexOf(".") + 1);
				filename=s2.substring((s2.lastIndexOf("/")+1),(s2.lastIndexOf(".")));
				filename=filename.replaceAll(" ", "_");
            }
				//System.out.println("filename"+filename); 

			s4=s4.toLowerCase();
			
			String s5 = request.getParameter("r4");
            if(s5!=null && !s5.equals(""))
            	filename=s5;

            if(s3 != null && s3.equals("download"))
            {
               		 response.setHeader("Content-Disposition", "attachment;filename="+filename+"."+ s4);
              		 if(s4 != null && s4.equals("pdf"))
			    	 {
			          	response.setContentType("application/pdf");
			   	     }
			   	     if(s4 != null && s4.equals("pps"))
			         {
			   			response.setContentType("application/vnd.ms-powerpoint");
			   		 }
					 if(s4 != null && s4.equals("ppt"))
					 {
					 	response.setContentType("application/vnd.ms-powerpoint");
					 }
					 if(s4 != null && s4.equals("pptx"))
					 {
						response.setContentType("application/vnd.ms-powerpoint");
					 }
					 if(s4 != null && s4.equals("pub"))
					 {
						response.setContentType("application/vnd.ms-publisher");
					 }
					 if(s4 != null && s4.equals("swf"))
					 {
					 	response.setContentType("application/vnd.swf");
					 }
					 if(s4 != null && s4.equals("xls"))
					 {
					 	response.setContentType("application/vnd.ms-excel");
					 }
					 if(s4 != null && s4.equals("xlsx"))
					 {
						response.setContentType("application/vnd.ms-excel");
					 }
					 if(s4 != null && s4.equals("htm"))
					 {
					 	response.setContentType("text/htm");
					 }
					 if(s4 != null && s4.equals("html"))
					 {
					 	response.setContentType("text/html");
					 }
					 if(s4 != null && s4.equals("xml"))
					 {
					 	response.setContentType("text/xml");
					 }
					 if(s4 != null && s4.equals("jsp"))
					 {
					 	response.setContentType("text/html");
					 }
					 if(s4 != null && s4.equals("doc"))
					 {
					 	response.setContentType("application/vnd.word");
					 }
					 if(s4 != null && s4.equals("docx"))
					 {
						response.setContentType("application/vnd.word");
					 }
					 if(s4 != null && s4.equals("txt"))
					 {
					 	response.setContentType("text/plain");
					 }
					 if(s4 != null && s4.equals("pdf"))
					 {
					 	response.setContentType("application/pdf");
					 }
					 if(s4 != null && s4.equals("rtf"))
					 {
					 	response.setContentType("application/vnd.rtf");
					 }
					 if(s4 != null && s4.equals("gif"))
					 {
					 	response.setContentType("image/gif");
					 }
					 if(s4 != null && s4.equals("jpg"))
					 {
					 	 response.setContentType("image/jpeg");
					 }
					 if(s4 != null && s4.equals("tif"))
					 {
					 	  //response.setContentType("image/tif");
					 	  response.setContentType("image/x-quicktime");
				     }
				     if(s4 != null && s4.equals("tiff"))
					{
					  //response.setContentType("image/tiff");
					  response.setContentType("image/x-quicktime");
					 }
				 	 if(s4 != null && s4.equals("png"))
					  {
						  response.setContentType("image/png");
				     }
					  else
					  {
					   response.setContentType("application/octet-stream");
					}
            }
            else
            {

                	response.setHeader("Content-disposition", "inline;filename="+filename+"." + s4);
              		if(s4 != null && s4.equals("pdf"))
              		{
                	    response.setContentType("application/pdf");
					}
                    if(s4 != null && s4.equals("pps"))
                    {
						response.setContentType("application/vnd.ms-powerpoint");
					}
					if(s4 != null && s4.equals("ppt"))
					{
						response.setContentType("application/vnd.ms-powerpoint");
					}
					if(s4 != null && s4.equals("pptx"))
					{
						response.setContentType("application/vnd.ms-powerpoint");
					}

					if(s4 != null && s4.equals("pub"))
					{
						response.setContentType("application/mspublisher");
					}
					if(s4 != null && s4.equals("swf"))
					{
						response.setContentType("application/swf");
					}
					if(s4 != null && s4.equals("xls"))
					{
						response.setContentType("application/vnd.ms-excel");
					}
					if(s4 != null && s4.equals("xlsx"))
					{
						response.setContentType("application/vnd.ms-excel");
					}
					if(s4 != null && s4.equals("htm"))
					{
						response.setContentType("text/html");
					}
					if(s4 != null && s4.equals("html"))
					{
						response.setContentType("text/html");
					}
					if(s4 != null && s4.equals("xml"))
					{
						response.setContentType("text/xml");
					}
					if(s4 != null && s4.equals("jsp"))
					{
						response.setContentType("text/html");
					}
					if(s4 != null && s4.equals("doc"))
					{
						response.setContentType("application/msword");
					}
					 if(s4 != null && s4.equals("docx"))
					 {
						response.setContentType("application/vnd.word");
					 }

					if(s4 != null && s4.equals("txt"))
					{
						response.setContentType("text/plain");
					}
					if(s4 != null && s4.equals("pdf"))
					{
						response.setContentType("application/pdf");
					}
					if(s4 != null && s4.equals("rtf"))
					{
						response.setContentType("application/msword");
					}
					if(s4 != null && s4.equals("gif"))
					{
						response.setContentType("image/gif");
					}
					if(s4 != null && s4.equals("jpg"))
					{
						 response.setContentType("image/jpeg");
					}
					if(s4 != null && s4.equals("tif"))
					{
					  response.setContentType("image/x-quicktime");
              	      //response.setContentType("image/tif");
				    }
				    if(s4 != null && s4.equals("tiff"))
					{
					 // response.setContentType("image/tiff");
					  response.setContentType("image/x-quicktime");
				    }
              	  if(s4 != null && s4.equals("png"))
              	  {
              	      response.setContentType("image/png");
				  }
				   if(s4 != null && s4.equals("mp3"))
				   {
					   response.setContentType("audio/mp3");
				  }
				  if(s4 != null && s4.equals("mpg"))
				  {
				  		response.setContentType("video/mpg");
				  }
				  if(s4 != null && s4.equals("wma"))
				  {
				  		response.setContentType("audio/wma");
				  }
				  if(s4 != null && s4.equals("wmv"))
				  {
					  response.setContentType("video/wmv");
				  }
				   if(s4 != null && s4.equals("wmv"))
				  {
				  	response.setContentType("video/wmv");
				  }
				  if(s4 != null && s4.equals("avi"))
				  {
				  		response.setContentType("video/avi");
				  }
            }

            BufferedInputStream  input			= null;
            BufferedOutputStream output 		= null;

            try
            {
				javax.servlet.ServletOutputStream servletoutputstream = response.getOutputStream();
                File fileFound = new File(s1 + s2);

                
                if(!fileFound.exists())
                	s2 = "NA/notavailable.gif";

                
                input				= new BufferedInputStream(new FileInputStream(s1 + s2));
                output 				= new BufferedOutputStream(response.getOutputStream(), DEFAULT_BUFFER_SIZE);

                byte[] buffer 		= new byte[DEFAULT_BUFFER_SIZE];
                int length1 		= 0;
				while ((length1 = input.read(buffer)) > 0)
				{
					output.write(buffer, 0, length1);
				}

       			output.flush();

            }
            catch(Exception e)
            {
            	log.error(e);
            }
            finally
            {
				if(output != null)
					output.close();
				if(input != null)
					input.close();
			}
        }
        catch(Exception exception)
        {
			exception.printStackTrace();
		}
    }

    public String getServletInfo()
    {
        return "OpenFile";
    }
}