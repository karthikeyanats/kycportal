<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
String sectionname = request.getParameter("sectionname");
String descryption = request.getParameter("descryption");
String createdby = (String)session.getValue("userid");
String instituteid =  (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
String LogStatus = "Created";

	String sectionid = request.getParameter("sectionid");

	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	
	instituteBean.setsectionid(sectionid);
	
	instituteBean.setStatus(curstatus);
	int trashlist = query_object.Updatetashsections();
	String op = "Deleted";
	

	String message="";
	if(trashlist >0)
		message = "Section Successfully Trashed";
	else
		message = "Section Trash Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Section/SectionList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
