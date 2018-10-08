<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String sectionname=request.getParameter("SectionName");
	String deptdescription=request.getParameter("deptdescription");
	String sectionid=request.getParameter("sectionid");
String createdby = (String)session.getValue("userid");
String instituteid =  (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setCreatedBy(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

	instituteBean.setsectionid(sectionid);
	instituteBean.setsectionname(sectionname);
	instituteBean.setDescription(deptdescription.replaceAll("&quot;","\""));
	int courseList = query_object.UpdateEdittsections();

	String op = "Updated";
	
	String message="";
	if(courseList ==1)
	{
		message = "Section Successfully  Updated";
	}
	else if(courseList ==0)
	{
		message = "Section Updation Failed";
	}
	else if(courseList ==1000)
	{
		message = "Section Name Already Exist";
		courseList=1000;
	}  

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Section/SectionList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
 	
%>
