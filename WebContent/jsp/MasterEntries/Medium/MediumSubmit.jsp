<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumBean" />

<form name="MainForm" method="post" action="">
	
<%@ page language="java" import="java.util.*"%>
<%
	String mediumname = request.getParameter("mediumname");
	String descryption = request.getParameter("descryption");
	String createdby =(String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	String LogStatus = "Created";

	

	instituteBean.setmediumname(mediumname);
	instituteBean.setDescription(descryption);
	instituteBean.setcreatedby(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setStatus(Status);

	instituteBean.setlogstatus(LogStatus);

	int courseList = query_object.insertMediums();

	String op = "Inserted";
	
	String message="";
	if(courseList == 1)
	{
		message = "Medium Successfully Inserted";
	}
	if(courseList == 0)
	{
		message = "Medium Insertion Failed";	
	}
	else if(courseList==1000) 
	{ 
		message = " Medium Name Already Exist";
	      courseList=1000;  
	} 

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Medium/MediumEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
