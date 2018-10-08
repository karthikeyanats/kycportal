<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		document.wkrkallotmentsubmit.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";			
		document.wkrkallotmentsubmit.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Schedule</title>
</head>
<body onload='LoadStatus()'>

	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page language="java" import="com.iGrandee.Assignment.Assignment,com.iGrandee.Assignment.AssignmentBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	
		String status				= null;
		int result					= 0;
		Assignment allot			= new Assignment();
		AssignmentBean bean			= new AssignmentBean();
		String questionid			= request.getParameter("assignment");
	
		bean.setAssignmentid(request.getParameter("assignment_hide"));
		bean.setStudentidss(request.getParameterValues("students"));
		
		result 		= allot.removeStudents(bean);
		
		//result 		= allot.removeStudents(
		//		request.getParameterValues("students"),
		//		request.getParameter("assignment_hide")
		//		);
	
		if(result >0)
			status	= "Assignment Successfully Removed.";
		else
			status	= "Assignment Removing Failed.";

	%>
	
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./Assignment/Remove_Assignment.jsp'>
 	<input type='hidden' name='sessionname'   	value='<%=request.getParameter("sessionname")%>'>
 	<input type='hidden' name='standardname'   	value='<%=request.getParameter("standardname")%>'>
 	<input type='hidden' name='subjectname'   	value='<%=request.getParameter("subjectname")%>'>
 	<input type='hidden' name='lessonname'   	value='<%=request.getParameter("lessonname")%>'>
	<input type='hidden' name='sectionname'   	value='<%=request.getParameter("sectionname")%>'>
	<input type='hidden' name='assignmentname'  value='<%=request.getParameter("assignmentname")%>'>
	<input type='hidden' name='task'   			value='<%=request.getParameter("task")%>'>
	<input type='hidden' name='startdate'   	value='<%=request.getParameter("startdate")%>'>
	<input type='hidden' name='enddate'   		value='<%=request.getParameter("enddate")%>'>
 	<input type='hidden' name='assignment'   	value='<%=questionid%>'>
 	<input type='hidden' name='assignment_hide' value='<%=request.getParameter("assignment_hide")%>'>
	</form>
</body>
</html>