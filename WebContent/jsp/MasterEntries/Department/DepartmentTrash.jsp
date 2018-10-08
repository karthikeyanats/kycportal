<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartmentBean" />


<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
String deptname = request.getParameter("deptname");
String descryption = request.getParameter("descryption");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String LogStatus = "Created";

	String Deptid = request.getParameter("Deptid");

	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	
	instituteBean.setDepartmentid(Deptid);
	instituteBean.setStatus(curstatus);
	int trashlist = query_object.UpdatetashDepartments();
	
	String message="";
	if(trashlist >0)
		message = "Department Successfully Trashed";
	else
		message = " Department Trash Process Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Department/DepartmentList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);

%>
