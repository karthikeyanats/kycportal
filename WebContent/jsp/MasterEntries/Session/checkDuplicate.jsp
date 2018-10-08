<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Session.SessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Session.SessionBean" />

	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String fieldname = request.getParameter("fieldname");
String instituteid=(String)session.getValue("instituteid"); 
 
boolean aa=query_object.checkDuplicate("yearofsession","sessionname",fieldname,instituteid);
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
	//System.out.println("propactionerror"+e);
}
%>



