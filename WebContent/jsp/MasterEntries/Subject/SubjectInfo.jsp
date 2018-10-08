<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="subjectQuery" scope="page" class="com.iGrandee.MasterEntries.Subject.SubjectQuery"/>

<%
	String instituteid = (String)session.getValue("instituteid");
	StringBuffer buffer=new StringBuffer();
	boolean checkString = false;
	if(request.getParameter("action").equals("duplicatesubjectname"))
	{	
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
		if((temp_str=request.getParameter("subjectname"))!=null && (temp_str1=request.getParameter("reqstandardid"))!=null && (temp_str2=request.getParameter("reqsubjectid"))!=null)
		{	

			 checkString=subjectQuery.checkDuplicate("subjectname",temp_str1,temp_str,temp_str2);
			buffer.append("<result>");
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
	}
	else if(request.getParameter("action").equals("duplicatesubjectcode"))
	{	
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
	if((temp_str=request.getParameter("subjectcode"))!=null && (temp_str1=request.getParameter("reqstandardid"))!=null && (temp_str2=request.getParameter("reqsubjectid"))!=null)
		{
		 checkString=subjectQuery.checkDuplicate("subjectcode",temp_str1,temp_str,temp_str2);
			buffer.append("<result>");   
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");

	}
	
	
	
	
	if(request.getParameter("action").equals("duplicatesubjectnameentry"))
	{	
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
		if((temp_str=request.getParameter("subjectname"))!=null && (temp_str1=request.getParameter("reqstandardid"))!=null )
		{	

			 checkString=subjectQuery.checkDuplicateentry("subjectname",temp_str1,temp_str); 
			buffer.append("<result>");
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
	}
	else if(request.getParameter("action").equals("duplicatesubjectcodeentry"))
	{	
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
	if((temp_str=request.getParameter("subjectcode"))!=null && (temp_str1=request.getParameter("reqstandardid"))!=null )
		{
		 checkString=subjectQuery.checkDuplicateentry("subjectcode",temp_str1,temp_str);
			buffer.append("<result>");   
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");

	}
	
	
%>