<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Section.SectionBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String SectionName = request.getParameter("SectionName");
	String Description = request.getParameter("Description");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	String LogStatus = "Created";

	instituteBean.setsectionname(SectionName);
	instituteBean.setDescription(Description);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setStatus(Status);
	
	instituteBean.setlogstatus(LogStatus);

	int courseList = query_object.insertsections();
	String op = "Inserted";
	String message="";
	if(courseList == 1)
	{
		message = "Section Successfully Inserted";
	}
	else if(courseList == 0)
	{
		message = "Section Insertion Failed";	
	}
	else if(courseList == 1000)
	{
		message = " Section Name Already Exist";
	    courseList=1000;  
	} 
	

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Section/SectionEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
