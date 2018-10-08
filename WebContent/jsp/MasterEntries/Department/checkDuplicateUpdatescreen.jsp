<%@ page language="java"%>
<%@ page import="java.io.*,java.util.*"%>
<jsp:useBean id="deptQuery" scope="page" class="com.iGrandee.MasterEntries.Department.DepartMentEntry"/>
<%
String instituteid=(String)session.getValue("instituteid"); 

	StringBuffer buffer=new StringBuffer();
	boolean checkString = false;
	
		String temp_str=null;
		String temp_str1=null;
		String temp_str2=null;
		if((temp_str=request.getParameter("departmentnamename"))!=null && (temp_str1=request.getParameter("deptid"))!=null  )
		{
			checkString=deptQuery.checkDuplicateupdate(temp_str,temp_str1,instituteid); 
			
			buffer.append("<result>");
			buffer.append("<var>"+checkString+"</var>");
 			buffer.append("</result>");
		}
		response.setContentType("text/xml");
		response.setHeader("Cache-Control", "no-cache");
		response.getWriter().write("<duplicate>"+buffer.toString()+"</duplicate>");


%>