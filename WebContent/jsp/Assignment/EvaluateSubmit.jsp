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
	import="com.iGrandee.Assignment.Assignment,com.iGrandee.Assignment.AssignmentReplyBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status				= null;
	int result					= 0;
	Assignment allot			= new Assignment();
	AssignmentReplyBean bean	= new AssignmentReplyBean();
	String userid				= (String)session.getValue("userid");
	String trackingid			= request.getParameter("trackingid");
	
	String sessionid		= request.getParameter("session");
	String standardid		= request.getParameter("standard");
	String sectionid		= request.getParameter("section");
	String subjectid		= request.getParameter("subject");
	String lessonid			= request.getParameter("lesson");
	String sectionname		= request.getParameter("sectionname");
	String subjectname		= request.getParameter("subjectname");
	String lessonname		= request.getParameter("lessonname");
	String standardname		= request.getParameter("standardname");
	String sessionname		= request.getParameter("sessionname");
	String questionid		= request.getParameter("questionid");
	String questionname		= request.getParameter("questionname");
	String assignmentid		= request.getParameter("assignmentid");
	String studentid		= request.getParameter("studentallocationid");
	
	
	bean.setAssigntracking(trackingid);
	bean.setFacultyremarks(request.getParameter("studremarks"));
	bean.setMark(request.getParameter("studentmark"));
	result					= allot.updateFacultyRemarks(bean);
	
	//result					= allot.updateFacultyRemarks(
	//		trackingid,
	//		request.getParameter("studremarks"),
	//		request.getParameter("studentmark")
	//);
	
	if(result >0)
		status	= "Assignment Successfully Evaluated.";
	else
		status	= "Assignment Evaluation Failed.";

	
	%>
	
		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
		<input type='hidden' name='section' 			value='<%=sectionid%>'>
		<input type='hidden' name='subject' 			value='<%=subjectid%>'>
		<input type='hidden' name='lesson' 				value='<%=lessonid%>'>
		<input type='hidden' name='standard' 			value='<%=standardid%>'>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>
		<input type='hidden' name='lessonname' 			value='<%=lessonname%>'>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>
		<input type='hidden' name='sectionname' 		value='<%=sectionname%>'>
		<input type='hidden' name='questionid' 			value='<%=questionid %>'>
		<input type='hidden' name='questionname' 		value='<%=questionname %>'>
		<input type='hidden' name='assignmentid' 		value='<%=assignmentid %>'>
		<input type='hidden' name='studentallocationid' value='<%=studentid%>'>
		<input type='hidden' name='message' 			value='<%=status%>'>
		<input type='hidden' name='result' 				value='<%=result%>'>
		<input type='hidden' name='returnurl' 			value='./Assignment/EvaluateAssignment.jsp'>
		

	</form>
</body>
</html>