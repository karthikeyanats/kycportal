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
<title>Submit Question Preparation</title>
</head>
<body onload='LoadStatus()'>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.ExamManagement.QuestionPreparation"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status				= null;
	int result					= 0;
	String actionstatus			= null;
	String templateid 			= null;	
	QuestionPreparation prepare	= new QuestionPreparation();
	String userid				= (String)session.getValue("userid");
	

	try {
			
		templateid 			= request.getParameter("template");
		actionstatus		= request.getParameter("actionstatus");
		result				= prepare.updateTemplate(templateid, actionstatus);
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	if(result >0){
		
		if(actionstatus != null && actionstatus.equals("A"))
			status	= "Template Approved Successfully.";
		else
			status	= "Template Rejected Successfully.";
		
	}
	else{
		
		if(actionstatus != null && actionstatus.equals("A"))
			status	= "Template Approval Failed.";
		else
			status	= "Template Rejection Failed.";
	}

	
	%>
	
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='text'   name='returnurl' 		value='./ExamManagement/QuestionApprove.jsp'>

	</form>
</body>
</html>