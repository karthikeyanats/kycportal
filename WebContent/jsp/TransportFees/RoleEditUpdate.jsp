<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String rolename=request.getParameter("rolename");
	String descryption=request.getParameter("roledescription");
	String roleid=request.getParameter("roleid");
	String instituteid = (String)session.getValue("instituteid");
	instituteBean.setinstituteid(instituteid);
	
	instituteBean.setRoleid(roleid);
	instituteBean.setRolename(rolename.replaceAll("&quot;","\""));
	instituteBean.setrDescription(descryption);
	int courseList = query_object.UpdateEdittRoles();
	
	String message="";
	if(courseList ==1)
	{
		message = "Role Successfully Updated";
	}
	else if(courseList ==0)
	{
		message = " Role Updation  Failed";	
	}
	else if(courseList ==1000)
	{
		message = " Role Name Already Exist";	
		courseList=1000;
	}

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Role/RoleList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
%>
