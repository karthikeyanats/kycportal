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
String LogStatus1 = "D";

instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
instituteBean.setgroupid(groupid);
instituteBean.setCreatedBy(createdby);
instituteBean.setgetgrouplogdetail(LogStatus1);


	
	
	int trashlist = query_object.groupsDeactivate();
	
	String op = "Deactivated";
	
	String message="";
	if(trashlist >0)
		message = "Group Successfully Deactivated";
	else
		message = "Group Deactivation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Group/GroupList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);


%>
