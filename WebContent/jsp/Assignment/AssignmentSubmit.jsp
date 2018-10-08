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
	String status				= null;
	int result					= 0;
	Assignment allot			= new Assignment();
	AssignmentBean bean			= new AssignmentBean();
	AssignmentUpload upload		= new AssignmentUpload(request);
	upload.startProcess();
	String userid				= (String)session.getValue("userid");
	String sessionid			= upload.getParameter("session");
	String sectionid			= upload.getParameter("section");
	String standardid			= upload.getParameter("standard");
	String sessionname			= upload.getParameter("sessionname");
	String sectionname			= upload.getParameter("sectionname");
	String standardname			= upload.getParameter("standardname");
	String lessonid				= upload.getParameter("lesson");
	String subjectid			= upload.getParameter("subject");
	String lessonname			= upload.getParameter("lessonname");
	String subjectname			= upload.getParameter("subjectname");
	
	try {
	
		bean.setQuestionnames(upload.getParameterValues("topic"));
		bean.setMarks(upload.getParameterValues("mark"));
		bean.setFiles(upload.getFileNames());
		bean.setCreatedby(userid);
		bean.setLessonscheduleid(lessonid);
		bean.setSectionscheduleid(sectionid);
		
		result					= allot.questionInsert(bean);
		
		//result					= allot.questionInsert(
		//		upload.getParameterValues("topic"),
		//		upload.getParameterValues("mark"),
		//		upload.getFileNames(),
		//		userid,
		//		lessonid,
		//		sectionid
		//);
		
	}catch(Exception e){
		
	}
	
	if(result >0)
		status	= "Successfully Assignment Topic[s] Created.";
	else
		status	= "Assignment Topic[s] Creation Failed.";

	
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
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./Assignment/Assignment.jsp'>

	</form>
</body>
</html>