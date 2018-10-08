<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetType.SubjectTypeBean" />


	
<%@ page language="java" import="java.util.*"%>
<%
	String subjecttypename = request.getParameter("subjecttypename");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid =(String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	String LogStatus = "Created";

	instituteBean.setsubjectypename(subjecttypename);
	instituteBean.setDescription(descryption);
	instituteBean.setCreatedBy(createdby);
	instituteBean.setinstituteid(instituteid);
	instituteBean.setIpaddess(ipaddress);
	instituteBean.setsubjecttypestatus(Status);
	instituteBean.setsubjecttypelogstatus(LogStatus);
	

	int courseList = query_object.insertsubjecttypes(instituteBean);
	String op = "Insertd";
	
	String message="";
	if(courseList ==1)
	{
		message = "Subject Type Successfully Inserted";
	}
	else if(courseList ==0)
	{
		message = " Subject Type Insertion Failed";
	}else if(courseList ==1000)
	{
		message = " Subject Type Name Already Exist";

	}

		String return_file =request.getContextPath()+"/jsp/MasterEntries/SubjectType/SubjectTypeEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
