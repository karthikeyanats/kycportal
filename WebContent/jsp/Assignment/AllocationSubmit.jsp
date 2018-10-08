<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		//document.wkrkallotmentsubmit.action = "./../Operation_Result.jsp";
			
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
	String staffid				= (String)session.getValue("staffid");
	
	try {
	
		bean.setQuestionid(request.getParameter("assignment"));
		bean.setAssignmentdate(request.getParameter("startdate"));
		bean.setSubmissiondate(request.getParameter("enddate"));
		bean.setRemarks(request.getParameter("task"));
		bean.setStudentids(request.getParameter("student_hide"));
		bean.setStaffid(staffid);
		
		result 					= allot.insertAssignment(bean);
		
		//result 					= allot.insertAssignment(
		//	request.getParameter("assignment"),
		//	request.getParameter("startdate"),
		//	request.getParameter("enddate"),
		//	request.getParameter("task"),
		//	request.getParameter("student_hide"),
		//	staffid
		//);
	}
	catch(Exception e){
		
	}

	if(result >0)
		status	= "Successfully Assignment Topic[s] Allotted.";
	else
		status	= "Assignment Topic[s] Allotment Failed.";

	
	%>
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./Assignment/Allocation.jsp'>
	
	
	</form>
</body>
</html>