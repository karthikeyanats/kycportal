<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.AcademicSession.AcademicSessionBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
	String sessionname = request.getParameter("sessionname");
	String descryption = request.getParameter("descryption");
	String monthstart = request.getParameter("monthstart");
	String yearstart = request.getParameter("yearstart");
	String monthend = request.getParameter("monthend");
	String yearend = request.getParameter("yearend");
	String createdby =  (String)session.getValue("userid");
	String instituteid =(String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	String LogStatus = "Created";

	instituteBean.setsessionname(sessionname);
	instituteBean.setDescription(descryption);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setsessionstatus(Status);
	instituteBean.setsessionlogstatus(LogStatus);
	instituteBean.setMonthstart(monthstart);
	instituteBean.setMonthend(monthend);
	instituteBean.setYearstart(yearstart);
	instituteBean.setYearend(yearend);
	

	int courseList = query_object.insertsessions(instituteBean);

	String op = "Inserted";
	
	String message="";
	if(courseList == 1)
	{	
		message = " Academic Session Successfully Inserted";
	}
	
	else if(courseList == 0)
	{
		
		message = " Academic Session insertion Failed";	
	}
	else if(courseList == 1000)
	{
		message = " Academic Session Name Already Exist";	
		courseList=1000;

	}
	
	


		String return_file =request.getContextPath()+"/jsp/MasterEntries/AcademicSession/AcademicSessionEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
