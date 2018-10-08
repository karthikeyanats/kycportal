<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry" />
<jsp:useBean id="facultyremarkbean" scope="page"
	class="com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusBean" />


<%@ page language="java" import="java.util.*"%>
<%
String facultyremarkname = request.getParameter("facultyremarkname");
String fremarkstatusid = request.getParameter("fremarkstatusid");

String createdby = (String)session.getValue("userid");
String instituteid = (String)session.getValue("instituteid");
String Status = "A";



	facultyremarkbean.setCreatedby(createdby);
	facultyremarkbean.setRemarkstatus(Status);
	facultyremarkbean.setFremarkstatusid(fremarkstatusid);
	facultyremarkbean.setInstituteid(instituteid);
	facultyremarkbean.setRemarkstatusname(facultyremarkname.replaceAll("&quot;","\"").trim());
	

	int courseList = query_object.UpdateEdittRack(facultyremarkbean); 
	String message="";
	

	
	if(courseList==1000)
	{
		message = " Faculty Remark Already Exists";
	    courseList=1000;
	}
	else if(courseList==0)
	{
		message = " Faculty Remark Updation failed";

	}
	else if(courseList>=1)
	{
		message = "Faculty Remark Successfully Updated";

	}
		
		String return_file =request.getContextPath()+"/jsp/Exam/Facultyremarkstatus/FacultyRemarkList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
