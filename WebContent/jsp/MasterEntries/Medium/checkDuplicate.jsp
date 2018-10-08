
<jsp:useBean id="validate" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />

	<%@ page import="java.io.*,java.util.ArrayList,java.util.HashMap"%>
		<jsp:useBean id="gradeQuery" scope="page" class="com.iGrandee.MasterEntries.Medium.MediumEntry"/>
	
<%
StringBuffer buffer=new StringBuffer();
String fieldname = request.getParameter("fieldname");
String flage = request.getParameter("flage");
String instituteid=(String)session.getValue("instituteid"); 
boolean aa=validate.checkDuplicatewithstatus("standardmedium","mediumname",fieldname,"mediumstatus",instituteid);
try
{
	if(flage.equals("entry"))
	{
	
					    buffer.append("<result>");
						buffer.append("<actiondate>"+aa+"</actiondate>");

						buffer.append("</result>");
			response.setContentType("text/xml");
			response.setHeader("Cache-Control", "no-cache");
			response.getWriter().write("<?xml version=\"1.0\" encoding=\"ISO-8859-1\"?><complaintdetails>"+buffer.toString()+"</complaintdetails>");
	}
	

else if(flage.equals("update"))
{
	

	boolean checkString = false;
	
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
		if((temp_str=request.getParameter("mediumname"))!=null && (temp_str1=request.getParameter("mediumid"))!=null  )
		{
			checkString=gradeQuery.checkDuplicateupdate(temp_str,temp_str1,instituteid);

			
			buffer.append("<result>");
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");
	
}
}

catch(Exception e)
{
	//System.out.println("propactionerror"+e);
}
%>



