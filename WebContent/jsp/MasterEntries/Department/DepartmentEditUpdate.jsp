<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Department.DepartmentBean" />


     
<%@ page language="java" import="java.util.*"%>
<%
	String deptname=request.getParameter("deptname");
	String descryption=request.getParameter("deptdescription");
	String depeid=request.getParameter("deptid");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();

	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);

	instituteBean.setDepartmentid(depeid);
	instituteBean.setdepartmentname(deptname.replaceAll("&quot;","\""));
	instituteBean.setdDescription(descryption);
	int courseList = query_object.UpdateEdittDepartments();
	
	String message="";
	if(courseList ==1)
	{
		message = "Department Successfully Updated";
	}
	else if(courseList==0)
	{
		message = " Department Updation Failed";
	}
	else if(courseList==1000)
	{
		message = " Department Name Already Exist";
	     courseList=1000;
	}
	
		String return_file =request.getContextPath()+"/jsp/MasterEntries/Department/DepartmentList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
