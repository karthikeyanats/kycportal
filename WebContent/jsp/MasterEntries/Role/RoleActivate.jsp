<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />



<%@ page language="java" import="java.util.*"%>
<%

	String roleid = request.getParameter("roleid");

	instituteBean.setRoleid(roleid);
	String instituteid = (String)session.getValue("instituteid");
	instituteBean.setinstituteid(instituteid);
	
	int trashlist = query_object.ActivateRoles();
	String op = "Activated";
	
	String message="";
	if(trashlist >0)
		message = "Role Successfully Activated";
	else
		message = "Role Activation  Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Role/RoleDeactiveView.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
	
