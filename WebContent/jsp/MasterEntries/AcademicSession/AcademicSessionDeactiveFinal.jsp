<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />
<%@ page language="java" import="java.util.*"%>
<%
try
{
String sessionid=request.getParameter("sessionid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String LogStatus = "Deactive";

String ipaddress = request.getRemoteAddr();

instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setsessionid(sessionid);



instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
instituteBean.setCreatedBy(createdby);
	
	
	int trashlist = query_object.AcademicSessionDeactivate(instituteBean);
	
	String op = "Activated";
	
	String message="";
	if(trashlist >0)
		message = " Academic Session  Successfully Deactivated";
	else
		message = " Academic Session Deactivation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/AcademicSession/AcademicSessionList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
}
catch(Exception e)
{
	e.printStackTrace();
	}
%>
