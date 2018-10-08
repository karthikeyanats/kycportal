<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Group.GroupBean" />


<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
String groupid = request.getParameter("groupid");
String groupname = request.getParameter("groupname");
String descryption = request.getParameter("descryption");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String LogStatus = "Trash";

	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setgroupstatus(curstatus);
	instituteBean.setgroupid(groupid);
	instituteBean.setgetgrouplogdetail(LogStatus);


	int trashlist = query_object.Updatetashgroups();
	String op = "Trashed";
	
	String message="";
	if(trashlist >0)
		message = "Group Successfully Trashed";
	else
		message = "Group Trash failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Group/GroupList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
