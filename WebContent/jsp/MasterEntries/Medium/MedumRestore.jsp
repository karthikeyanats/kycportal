
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String mediumid=request.getParameter("mediumid");
String createdby = (String)session.getValue("userid");
String instituteid =(String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setmediumid(mediumid);
instituteBean.setcreatedby(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

	int courseList = query_object.Restoremediums();
	String op = "Restore";
	
	String message="";
	if(courseList >0)
		message = "Medium Successfully Restored";
	else
		message = "Medium Restore Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Medium/MediumTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
