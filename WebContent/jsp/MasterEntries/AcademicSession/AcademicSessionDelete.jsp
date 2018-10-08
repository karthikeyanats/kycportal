<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />



<%@ page language="java" import="java.util.*"%>
<%

String sessionid=request.getParameter("sessionid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
instituteBean.setsessionid(sessionid);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);

	int trashlist = query_object.DeleteSession(instituteBean);
	String op = "Deleted";
	
	String message="";
	if(trashlist >0)
		message = " Academic Session  Deleted Successfully";
	else
		message = " Academic Session Deletion Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/AcademicSession/AcademicSessionTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
