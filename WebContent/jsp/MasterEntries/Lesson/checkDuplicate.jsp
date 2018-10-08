
<jsp:useBean id="lessonQuery" scope="page" class="com.iGrandee.MasterEntries.Lesson.LessonQuery"/>

	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String reqsubjectid="";
String fieldname1 = request.getParameter("fieldname1");
reqsubjectid=request.getParameter("reqsubjectid");

boolean aa=lessonQuery.checkDuplicateentry(fieldname1,reqsubjectid);



try
{
	
					    buffer.append("<result>");
						buffer.append("<actiondate>"+aa+"</actiondate>");

						buffer.append("</result>");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
	
		

catch(Exception e)
{
}
%>



