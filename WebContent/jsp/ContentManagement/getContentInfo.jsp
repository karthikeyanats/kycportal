<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="commonDataAccess" scope="page" class="com.iGrandee.Common.CommonDataAccess"/>
<jsp:useBean id="relationcheck" scope="page" class="com.iGrandee.Registration.StudentRegistrationQuery" />

<%

	StringBuffer buffer=new StringBuffer();

	if(request.getParameter("action").equals("filesize"))
	{	String temp_str=null;
		if((temp_str=request.getParameter("id"))!=null)
		{
			File f1=new File(temp_str);
			//System.out.println(temp_str);
			if(f1.exists())
				f1.length();
			buffer.append("<result>");
				buffer.append("<var>"+f1.length()+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<filesize>"+buffer.toString()+"</filesize>");
	}
	
%>


