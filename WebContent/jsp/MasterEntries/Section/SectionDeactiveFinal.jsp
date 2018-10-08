<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />
	
<%@ page language="java" import="java.util.*"%>
<%

	String sectionid = request.getParameter("sectionid");
String createdby = (String)session.getValue("userid");

instituteBean.setsectionid(sectionid);
instituteBean.setCreatedBy(createdby);
String ipaddress = request.getRemoteAddr();
instituteBean.setIpaddess(ipaddress);


	String LogStatus = "Deactivated";
	instituteBean.setlogstatus(LogStatus);
	
	int trashlist = query_object.sectionsDeactivate();
	

	String op = "Deactivated";
	
	String message="";
	if(trashlist >0)
		message = "Section Successfully Deactivated";
	else
		message = "Section Deactivation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Section/SectionList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
