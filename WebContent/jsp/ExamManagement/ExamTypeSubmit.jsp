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
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.ExamManagement.QuestionEntry"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status				= null;
	int result					= 0;
	QuestionEntry qentry		= new QuestionEntry();
	String userid				= (String)session.getValue("userid");
	String operation			= request.getParameter("status");
	String examtype				= request.getParameter("examtype");
	String existing				= request.getParameter("existing");
	
	try {
			

		operation		= request.getParameter("status");
		examtype		= request.getParameter("examtype");
		existing		= request.getParameter("existing");
		
		if(operation != null && operation.equals("Add")){
			result			= qentry.addExamType(userid,examtype);
			if(result == 0)
				status	= "Exam Type Adding Failed.";
			else if(result == 1000){
				status	= "Exam Type Name already exisits.";	
				result	= 0;
			}
			else
				status	= "Exam Type Added Successfully.";			
			
			
		}else if(operation != null && operation.equals("Update")){
			result			= qentry.updateExamType(existing,examtype);
			if(result == 0)
				status	= "Exam Type Updation Failed.";
			else if(result == 1000){
				status	= "Exam Type Name already exisits.";
				result	= 0;
			}
			else
				status	= "Exam Type Updated Successfully.";			
			
			
		}else if(operation != null && operation.equals("Delete")){
			result			= qentry.deleteExamType(existing,examtype);
			
			
			if(result == 0)
				status	= "Exam Type Deletion Failed.";
			else if(result == 1000){
				status	= "Using this exam type, Questions are entered. So you can not delete.";	
				result	= 0;
			}
			else
				status	= "Exam Type Deleted Successfully.";
		}

		
	}catch(Exception e){
		
	}


	%>
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./ExamManagement/ExamType.jsp'>

	</form>
</body>
</html>