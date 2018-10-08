<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupBean" />

<%@ page language="java" import="java.util.*"%>
<%

	String groupid = request.getParameter("groupid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
instituteBean.setgroupid(groupid);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setIpaddess(ipaddress);
	
	int trashlist = query_object.Deletegroups();
	String op = "Deleted";
	
	String message="";
	if(trashlist >0)
		message = "Group Successfully Deleted";
	else
		message = "Group Deletion Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Group/GroupTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
 	%>