<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />


<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
String instituteid = (String)session.getValue("instituteid");
instituteBean.setinstituteid(instituteid);

	String roleid = request.getParameter("roleid");
	instituteBean.setRoleid(roleid);
	instituteBean.setStatus(curstatus);
	int trashlist = query_object.Updatetashroles();
	
	String message="";
	if(trashlist >0)
		message = "Role Successfully Trashed";
	else
		message = " Role Trash Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Role/RoleList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
