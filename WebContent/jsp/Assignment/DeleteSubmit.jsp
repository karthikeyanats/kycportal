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
<%@ page language="java"
	import="com.iGrandee.Assignment.Assignment,com.iGrandee.Assignment.AssignmentBean,com.iGrandee.Assignment.AssignmentUpload"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status			= null;
	int result				= 0;
	Assignment allot		= new Assignment();
	AssignmentBean bean		= new AssignmentBean();
	String userid			= (String)session.getValue("userid");
	
	String sessionid		= request.getParameter("session");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	String lessonid			= request.getParameter("lesson");
	String subjectid		= request.getParameter("subject");
	String lessonname		= request.getParameter("lessonname");
	String subjectname		= request.getParameter("subjectname");
	String questionid		= request.getParameter("questionid");

	
	//result				= allot.changeStatus(
	bean.setQuestionid(questionid);
	bean.setStatus("D");
	result					= allot.deleteAssignemntQuestion(bean);
	//result					= allot.deleteAssignemntQuestion(
	//		questionid,
	//		"D"
	//);
	
	
	if(result == 1000)
		status	= "Assignment Allotted using this topic. So you can not delete.";
	else if(result >0)
		status	= "Topic Successfully Deleted.";
	else
		status	= "Topic Deletion Failed.";

	
	%>
	
	<input type='hidden' name='standardname' 	value='<%=standardname%>'>
	<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
	<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
	<input type='hidden' name='section' 		value='<%=sectionid%>'>
	<input type='hidden' name='session' 		value='<%=sessionid%>'>
	<input type='hidden' name='subject' 		value='<%=subjectid%>'>
	<input type='hidden' name='lesson' 			value='<%=lessonid%>'>
	<input type='hidden' name='subjectname'		value='<%=subjectname%>'>
	<input type='hidden' name='lessonname' 		value='<%=lessonname%>'>
	<input type='hidden' name='standard'		value='<%=standardid%>'>
	<input type='hidden' name='status' 			value='<%=status%>'>
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./Assignment/AssignmentView.jsp'>	
	
	</form>
</body>
</html>