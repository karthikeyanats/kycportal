<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String deptname = request.getParameter("deptname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid =(String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	String LogStatus = "Created";
	String message = "";
	
	instituteBean.setRolename(deptname);
	instituteBean.setrDescription(descryption);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setStatus(Status);
	
	instituteBean.setlogstatus(LogStatus);

	int courseList = query_object.insertRoles();
	
	if(courseList==1)
	{
		message = "Role Successfully Inserted";
	}
	if(courseList==0)	
	{
		message = "Role insertion Failed";	
	}
	else if(courseList==1000) 
	{ 
		message = " Role Name Already Exist";
	      courseList=1000;  
	} 

		
	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Role/RoleList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
