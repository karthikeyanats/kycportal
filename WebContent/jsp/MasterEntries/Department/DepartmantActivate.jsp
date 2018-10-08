<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartmentBean" />

<%@ page import="java.io.*,java.util.*"%>


<%

	String Deptid = request.getParameter("Deptid");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String) session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();

	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);


	instituteBean.setDepartmentid(Deptid);
	int trashlist = query_object.ActiveDepartments();
	
	String message="";
	if(trashlist >0)
		message = "Department Successfully Activated";
	else
		message = "Department Activation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Department/DepartmentList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
	
%>
