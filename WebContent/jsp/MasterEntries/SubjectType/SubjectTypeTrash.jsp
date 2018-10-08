<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
String subjectypename=request.getParameter("subjectypename");
String subjecttypeid=request.getParameter("subjecttypeid");

	String description = request.getParameter("description");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String LogStatus = "Trash";

	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setsubjecttypeid(subjecttypeid);
	instituteBean.setsubjecttypelogstatus(LogStatus);

	
	
	int trashlist = query_object.Updatetashgroups(instituteBean);
	String op = "Trashed";
	
	String message="";
	if(trashlist >0)
		message = "Subject Type Successfully Trashed";
	else
		message = "Subject Type Trash Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/SubjectType/SubjectTypeList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
