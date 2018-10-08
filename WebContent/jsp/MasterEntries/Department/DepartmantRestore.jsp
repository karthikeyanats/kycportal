<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartmentBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String Deptid=request.getParameter("Deptid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setDepartmentid(Deptid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

	int courseList = query_object.RestoreDepartments();
	
	String message="";
	if(courseList >0)
		message = "Department Successfully Restored";
	else
		message = " Department Restore  Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Department/DepartmentList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
%>
