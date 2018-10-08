
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />


	
<%@ page language="java" import="java.util.*"%>
<%
String sessionid=request.getParameter("sessionid");
String createdby =  (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();


instituteBean.setsessionid(sessionid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

	int courseList = query_object.Restoreyearofsessions(instituteBean);
	String op = "Restored";
	
	String message="";
	if(courseList >0)
		message = " Academic Session Successfully Restored";
	else
		message = " Academic Session Restore Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/AcademicSession/AcademicSessionTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
