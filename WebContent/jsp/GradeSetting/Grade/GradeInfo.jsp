<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="gradescaleQuery" scope="page" class="com.iGrandee.GradeSetting.GradeScaleQuery"/>

<%
	String instituteid = (String)session.getValue("instituteid");
	StringBuffer buffer=new StringBuffer();
	boolean checkString = false;
	if(request.getParameter("action").equals("duplicategradename"))
	{	
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
		if((temp_str=request.getParameter("gradename"))!=null && (temp_str1=request.getParameter("reqscaleid"))!=null && (temp_str2=request.getParameter("reqgradeid"))!=null)
		{	

			 checkString=gradescaleQuery.checkDuplicate("gradename",temp_str1,temp_str,temp_str2);
			buffer.append("<result>");
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
	}
	
	if(request.getParameter("action").equals("duplicategradenameentry"))
	{	
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
		if((temp_str=request.getParameter("gradename"))!=null && (temp_str1=request.getParameter("reqscaleid"))!=null )
		{	

			 checkString=gradescaleQuery.checkDuplicateentry("gradename",temp_str1,temp_str);
			buffer.append("<result>");
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
	}

	
%>