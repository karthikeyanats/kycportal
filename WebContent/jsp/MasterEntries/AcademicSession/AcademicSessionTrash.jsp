<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />


<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
String sessionname=request.getParameter("sessionname");
String sessionid=request.getParameter("sessionid");
	String description = request.getParameter("description");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String LogStatus = "Trash";

	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setsessionid(sessionid);
	instituteBean.setIpaddess(ipaddress);


	
	
	int trashlist = query_object.UpdatetashYearOfsessions(instituteBean);
	String op = "Trashed";
	
	String message="";
	if(trashlist >0)
		message = " Academic Session Successfully Trashed";
	else
		message = " Academic Session Trash Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/AcademicSession/AcademicSessionList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
