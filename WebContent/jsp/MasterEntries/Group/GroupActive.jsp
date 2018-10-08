
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String groupid=request.getParameter("groupid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setgroupid(groupid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
	int courseList = query_object.Activegroups();
	String op = "Activated";
	
	String message="";
	if(courseList >0)
		message = "Group Successfully Activated";
	else
		message = "Group Activation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Group/GroupDeactiveList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
