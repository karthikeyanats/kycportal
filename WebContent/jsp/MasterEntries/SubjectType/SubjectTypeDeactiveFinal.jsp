<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean" />


<%@ page language="java" import="java.util.*"%>
<%

String subjecttypeid=request.getParameter("subjecttypeid");
String createdby =(String)session.getValue("userid");
String instituteid =(String)session.getValue("instituteid");
String LogStatus = "Deactive";

String ipaddress = request.getRemoteAddr();

instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setsubjecttypeid(subjecttypeid);



instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
instituteBean.setCreatedBy(createdby);
	instituteBean.setsubjecttypelogstatus(LogStatus);
	
	int trashlist = query_object.groupsDeactivate(instituteBean);
	

	String op = "Deactivated";
	
	String message="";
	if(trashlist >0)
		message = "Successfully Subject Type Deactivated";
	else
		message = " Subject Type Deactivation failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/SubjectType/SubjectTypeList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
