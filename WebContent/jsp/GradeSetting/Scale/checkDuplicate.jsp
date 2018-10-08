


	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String fieldname = request.getParameter("fieldname1");
String scaleid = request.getParameter("reqscaleid");
String boardid=request.getParameter("standardboard_temp");
String instituteid=(String)session.getValue("instituteid"); 
String flage=request.getParameter("flage");

com.iGrandee.Application.RegistrationProcess duplicationQuery = new com.iGrandee.Application.RegistrationProcess();

try
{   
	if(flage.equals("scaleentry"))
	{
	
		boolean result=duplicationQuery.checkDuplicateentry(fieldname,boardid,instituteid); 

					    buffer.append("<result>"); 
						buffer.append("<actiondate>"+result+"</actiondate>");

						buffer.append("</result>");
						response.setContentType("text/xml");
						response.setHeader("Cache-Control", "no-cache");
						response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
	else if(flage.equals("scaleupdate"))
	{
		boolean result=duplicationQuery.checkDuplicateupdate(fieldname,scaleid,boardid,instituteid); 

	    buffer.append("<result>");
		buffer.append("<actiondate>"+result+"</actiondate>");

		buffer.append("</result>");
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
}
		

catch(Exception e)
{
}
%>



