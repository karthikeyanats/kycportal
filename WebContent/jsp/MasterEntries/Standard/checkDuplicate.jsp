


	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String fieldname = request.getParameter("fieldname1");
String standardid = request.getParameter("reqstandardid");
String boardid=request.getParameter("standardboard_temp");
String instituteid=(String)session.getValue("instituteid"); 
String flage=request.getParameter("flage");
com.iGrandee.MasterEntries.Standard.StandardQuery extraCurricularQuery = new com.iGrandee.MasterEntries.Standard.StandardQuery();

try
{   
	if(flage.equals("standardentry"))
	{
	
		boolean aa=extraCurricularQuery.checkDuplicateentry(fieldname,boardid,instituteid); 

					    buffer.append("<result>"); 
						buffer.append("<actiondate>"+aa+"</actiondate>");

						buffer.append("</result>");
						response.setContentType("text/xml");
						response.setHeader("Cache-Control", "no-cache");
						response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
	else if(flage.equals("standardupdate"))
	{
		boolean aa=extraCurricularQuery.checkDuplicateupdate(fieldname,standardid,boardid,instituteid); 

	    buffer.append("<result>");
		buffer.append("<actiondate>"+aa+"</actiondate>");

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



