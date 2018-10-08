<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />


<%@ page language="java" import="java.util.*"%>
<%

	String roleid = request.getParameter("roleid");
String instituteid = (String)session.getValue("instituteid");
instituteBean.setinstituteid(instituteid);

	instituteBean.setRoleid(roleid);
	String LogStatus = "Deactivated";
	instituteBean.setlogstatus(LogStatus);
	int trashlist = query_object.rolesDeactivate();
	String op = "Deactivated";

	String message="";
	if(trashlist >0)
		message = "Role Successfully Deactivated";
	else
		message = " Role Deactivation  Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Role/RoleList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	


%>
