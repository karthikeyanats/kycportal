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
<%@ page language="java" import="com.iGrandee.ExamManagement.OnlineExam"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	
		String status			= null;
		int result				= 0;
		OnlineExam online		= new OnlineExam();
		String qsid				= request.getParameter("template");
		String passmark			= request.getParameter("passmark");
		

		result			= online.assignOnlineExam(qsid, passmark);
		if(result == 0)
			status	= "Question assigning failed.";
		else if(result == 1000){
			status	= "Question already assigned for online exam.";
			result	= 0;
		}
		else
			status	= "Question assigned for online exam successfully.";			
				


	%>
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='text'   name='returnurl' 		value='./ExamManagement/AssignOnlineExam.jsp'>

	</form>
</body>
</html>