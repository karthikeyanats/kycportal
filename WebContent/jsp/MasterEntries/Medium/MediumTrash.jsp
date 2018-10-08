<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumBean" />

     
<%@ page import="java.io.*,java.util.*"%>

<%
	String curstatus = "T";
String mediumname = request.getParameter("mediumname");
String descryption = request.getParameter("descryption");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String LogStatus = "Created";

	String mediumid = request.getParameter("mediumid");

	instituteBean.setcreatedby(createdby);
	instituteBean.setIpaddess(ipaddress);
	
	instituteBean.setmediumid(mediumid);
	instituteBean.setStatus(curstatus);
	int trashlist = query_object.Updatetashmediums();
	String op = "Trashed";
	
	String message="";
	if(trashlist >0)
		message = "Medium Successfully Trashed";
	else
		message = "Medium Trash Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Medium/MediumList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
