<jsp:useBean id="query_object" scope="page" class="com.iGrandee.MasterEntries.Department.DepartMentEntry" />
<jsp:useBean id="instituteBean" scope="page" class="com.iGrandee.MasterEntries.Department.DepartmentBean" />

<%@ page language="java" import="java.util.*"%>

<%
	String message = "";
	String deptname = request.getParameter("deptname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	String LogStatus = "Created";
if(descryption.equals(""))
{
	descryption="-";
}

	instituteBean.setdepartmentname(deptname);
	instituteBean.setdDescription(descryption);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setStatus(Status);
	
	instituteBean.setlogstatus(LogStatus);

	int courseList = query_object.insertDepartments();
	

	if(courseList == 1)  
	{  
		message = "Department Successfully Inserted";
	}
	else if(courseList==0)
	{  
		message = " Department Insertion Failed";	
	}  
	else if(courseList==1000) 
	{ 
		message = " Department Name  Already Exist";
	      courseList=1000;  
	} 
	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Department/DepartmentEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
	 	
	 	
 	%>
