<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />

<%@ page language="java" import="java.util.*"%>
<%

	String sectionid = request.getParameter("sectionid");
String createdby = (String)session.getValue("userid");
String instituteid =  (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();
	instituteBean.setsectionid(sectionid);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setIpaddess(ipaddress);
	
	int trashlist = query_object.Deletesections();
	String op = "Deletd";
	
	String message="";
	if(trashlist >0)
		message = "Section Successfully  Deleted";
	else
		message = "Section Deletion Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Section/SectionTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>

