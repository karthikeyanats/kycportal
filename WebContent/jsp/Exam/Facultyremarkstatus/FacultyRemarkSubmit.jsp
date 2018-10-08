<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusEntry" />
<jsp:useBean id="facultyremarkbean" scope="page"
	class="com.iGrandee.Exam.Facultyremarkstatus.FacultyremarkstatusBean" />

<%@ page language="java" import="java.util.*"%>
<%
String message = "";
ArrayList courseList=new ArrayList();
	//String facultyremarkname = request.getParameter("facultyremarkname");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String Status = "A";
	int no_of_rows = 0;
	String op="";
	String return_file ="";
	String[] facultyremarkname=request.getParameterValues("facultyremarkname");

	facultyremarkbean.setRemarkstatusname_temp(facultyremarkname);
	facultyremarkbean.setCreatedby(createdby);
	facultyremarkbean.setRemarkstatus(Status);
	facultyremarkbean.setInstituteid(instituteid);
	ArrayList resultList = query_object.insertFacultyRemark(facultyremarkbean); 
	
	if(resultList!=null && resultList.size()>0)
	{
		no_of_rows = Integer.parseInt((String)resultList.get(0));
		op = (String)resultList.get(1);
	}
		
	
	

		 return_file =request.getContextPath()+"/jsp/Exam/Facultyremarkstatus/FacultyremarksstatusEntry.jsp";
			response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+no_of_rows+"&returnurl="+return_file);
	
	 	
 	%>
