
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String sectionid=request.getParameter("sectionid");
String createdby =(String)session.getValue("userid");
String instituteid =  (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setsectionid(sectionid);
instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

	int courseList = query_object.Restoresections();
	String op = "Restored";
	
	String message="";
	if(courseList >0)
		message = "Section Successfully Restored";
	else
		message = "Section Restore Failed";	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Section/SectionTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
