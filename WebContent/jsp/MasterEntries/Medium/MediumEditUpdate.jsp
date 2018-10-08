<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Medium.MediumBean" />

     
<%@ page import="java.io.*,java.util.*"%>
<%
	String mediumname=request.getParameter("mediumname");
	String descryption=request.getParameter("deptdescription");
	String mediumid=request.getParameter("mediumid");
String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String ipaddress = request.getRemoteAddr();

instituteBean.setcreatedby(createdby);
instituteBean.setinstituteid(instituteid);
instituteBean.setIpaddess(ipaddress);

	instituteBean.setmediumid(mediumid);
	instituteBean.setmediumname(mediumname);
	instituteBean.setDescription(descryption.replaceAll("&quot;","\""));
	int courseList = query_object.UpdateEdittmediums();
	String op = "Updated";
	
	String message="";
	if(courseList ==1)
	{
		message = "Medium Successfully Updated";
	}
	else if(courseList==0)
	{
		message = "Medium Updation Failed";	
	}
	else if(courseList==1000)
	{
		message = "Medium Name Already Exist ";	
		courseList=1000;
	}

		String return_file =request.getContextPath()+"/jsp/MasterEntries/Medium/MediumList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
