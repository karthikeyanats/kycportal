<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String groupname = request.getParameter("groupname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	String LogStatus = "Created";

	instituteBean.setgroupname(groupname);
	instituteBean.setDescription(descryption);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setgroupstatus(Status);
	instituteBean.setgrouplogstatus(LogStatus);
	instituteBean.setgetgrouplogdetail(LogStatus);
	

	int courseList = query_object.insertgroups();

	String op = "Inserted";
	
	String message="";
	if(courseList == 1)
	{
		message = "Group Successfully Inserted";
	}
	else if(courseList == 0)
	{
		message = "Group Insertion Failed";	
	}
	if(courseList == 1000)
	{
		message = " Group Name Already Exists";
	    courseList=1000;  
	} 


		String return_file =request.getContextPath()+"/jsp/MasterEntries/Group/GroupEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
