
<jsp:useBean id="validate" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />

	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
	
<%
StringBuffer buffer=new StringBuffer();
String fieldname = request.getParameter("fieldname");
boolean aa=validate.checkDuplicate("subjectmode","subjectmodename",fieldname);
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



