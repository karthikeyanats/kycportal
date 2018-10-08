<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String groupname=request.getParameter("groupname");
	String descryption=request.getParameter("deptdescription");
	String groupid=request.getParameter("groupid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String LogStatus = "Updated";


instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

	instituteBean.setgroupid(groupid);
	instituteBean.setgroupname(groupname);
	instituteBean.setDescription(descryption.replaceAll("&quot;","\""));
	instituteBean.setgetgrouplogdetail(LogStatus);
	int courseList = query_object.UpdateEdittgroups();
	String op = "Updated";
	
	String message="";
	if(courseList ==1)
	{
		message = "Group Successfully  Updated";
	}
	else if(courseList ==0)
	{
		message = "Group Updation failed";	
	}
	else if(courseList ==1000)
	{
		message = "Group Name Already Exists ";	
		courseList=1000;
	}

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Group/GroupList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
%>
