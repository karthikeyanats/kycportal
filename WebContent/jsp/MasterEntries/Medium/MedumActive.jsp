
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String mediumid=request.getParameter("mediumid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
instituteBean.setmediumid(mediumid);
instituteBean.setcreatedby(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

	int courseList = query_object.Restoremediums();
	String op = "Activated";
	
	String message="";
	if(courseList >0)
		message = "Medium Successfully Activated";
	else
		message = "Medium Activation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Medium/MediumDeactiveList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
