<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry" />
<jsp:useBean id="facultyremarkbean" scope="page"
	class="com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusBean" />

<%@ page language="java" import="java.util.*"%>
	
	
	<%
	int courseList=0;
	String fremarkstatusid = request.getParameter("fremarkstatusid");
	String remarkstatusname = request.getParameter("remarkstatusname");
	String createdby = (String)session.getValue("userid");
	String flage=request.getParameter("flage");
	String Status="";

	String message="";
	String return_file="";
	facultyremarkbean.setFremarkstatusid(fremarkstatusid);
	facultyremarkbean.setRemarkstatusname(remarkstatusname);
	facultyremarkbean.setCreatedby(createdby);
	
	if(flage.equals("Trash"))
	{	
		Status="T";
		facultyremarkbean.setRemarkstatus(Status);
		courseList = query_object.StatusUpdate(facultyremarkbean); 
		message="Trashed"; 
		return_file =request.getContextPath()+"/jsp/Exam/Facultyremarkstatus/FacultyRemarkList.jsp";

	}
	 else if(flage.equals("Delete"))
	{	
		Status="X";
		facultyremarkbean.setRemarkstatus(Status);
		courseList = query_object.StatusUpdate(facultyremarkbean); 
		message="Deleted"; 
		 return_file =request.getContextPath()+"/jsp/Exam/Facultyremarkstatus/FacultyremarkTrashListview.jsp";

	} else if(flage.equals("Restore"))
	{	
		Status="A";
		facultyremarkbean.setRemarkstatus(Status);
		courseList = query_object.StatusUpdate(facultyremarkbean); 
		message="Restored"; 
		 return_file =request.getContextPath()+"/jsp/Exam/Facultyremarkstatus/FacultyremarkTrashListview.jsp";

	}
	
	
	if(courseList==0)
	{
		message = " Faculty Remark "+message+" failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Faculty Remark Successfully "+message;

	} 
	
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);


%>