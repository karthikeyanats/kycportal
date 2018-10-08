
<%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry"%>

	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StudentSearchEntry studentquery = new StudentSearchEntry(); 

StringBuffer buffer=new StringBuffer();
String fieldname = request.getParameter("fieldname");
//boolean aa=studentquery.checkDuplicate("studentallocation","rollno",fieldname);
boolean aa=studentquery.checkDuplicate("studentallocation","rollno",fieldname,(String)session.getValue("instituteid"));
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



