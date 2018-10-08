
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />


<%@ page language="java" import="java.util.*"%>
<%
	
String sessionid=request.getParameter("sessionid");
String createdby =  (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");

instituteBean.setsessionid(sessionid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
String ipaddress = request.getRemoteAddr();

instituteBean.setIpaddess(ipaddress);
	int courseList = query_object.ActiveAcademicSessions(instituteBean);
	String op = "Activated";
	
	String message="";
	if(courseList >0)
		message = "Academic Session  Successfully Activated";
	else
		message = " Academic Session Activation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/AcademicSession/AcademicSessionDeactiveList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
