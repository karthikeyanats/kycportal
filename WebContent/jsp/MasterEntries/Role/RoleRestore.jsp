<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />


<%@ page language="java" import="java.util.*"%>
<%
	String roleid=request.getParameter("roleid");
instituteBean.setRoleid(roleid);
String instituteid = (String)session.getValue("instituteid");
instituteBean.setinstituteid(instituteid);
	int courseList = query_object.Restoreroles();
	
	String message="";
	if(courseList >0)
		message = "Role Successfully Restored";
	else
		message = "Role Restore Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Role/RoleTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
