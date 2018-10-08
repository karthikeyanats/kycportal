<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="lessonQuery" scope="page" class="com.iGrandee.MasterEntries.Lesson.LessonQuery"/>
<%
	StringBuffer buffer=new StringBuffer();
	boolean checkString = false;
	if(request.getParameter("action").equals("duplicateLessonname"))
		{	
		//System.out.println("============>>>>>>>>>>>>>>>"+request.getQueryString());

		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
		if((temp_str=request.getParameter("lessonname"))!=null && (temp_str1=request.getParameter("reqsubjectid"))!=null  && (temp_str2=request.getParameter("reqlessonid"))!=null)
		{
			//System.out.println("============>>>>>>>>>>>>>>>"+request.getQueryString()+"<<<<<<<<<<<<<<============");
			checkString=lessonQuery.checkDuplicate(temp_str,temp_str1,temp_str2);
			buffer.append("<result>");
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
	}
%>