
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String sectionid=request.getParameter("sectionid");
String createdby = (String)session.getValue("userid");
String instituteid =(String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setsectionid(sectionid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);
	int courseList = query_object.Restoresections();
	String op = "Activated";
	
	String message="";
	if(courseList >0)
		message = "Section Successfully  Activated";
	else
		message = "Section Activation Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Section/SectionDeactiveView.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
