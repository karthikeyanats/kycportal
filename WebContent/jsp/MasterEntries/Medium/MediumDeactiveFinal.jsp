<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumBean" />

<%@ page language="java" import="java.util.*"%>
<%

	String mediumid = request.getParameter("mediumid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
instituteBean.setmediumid(mediumid);
instituteBean.setcreatedby(createdby);


	String LogStatus = "Deactivated";
	instituteBean.setlogstatus(LogStatus);
	
	int trashlist = query_object.mediumsDeactivate();
	

	
	String op = "Deactivated";
	String message="";
	if(trashlist >0)
		message = "Medium Successfully Deactivated";
	else
		message = "Medium Deactivation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Medium/MediumList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	

%>
