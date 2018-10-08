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
<%@ page language="java" import="com.iGrandee.ExamManagement.QuestionEntry,com.iGrandee.ExamManagement.QuestionUpload,com.iGrandee.ExamManagement.QuestionEntryBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status				= null;
	int result					= 0;
	QuestionEntry qentry		= new QuestionEntry();
	QuestionEntryBean bean		= new QuestionEntryBean();
	QuestionUpload upload		= new QuestionUpload(request);
	upload.startProcess();
	String userid				= (String)session.getValue("userid");
	

	try {
			
			bean.setLessonid(upload.getParameter("lessonid"));
			bean.setUserid(userid);
			bean.setOccurence(upload.getParameter("occurence"));
			bean.setExamtype(upload.getParameter("examtype"));
			bean.setStartdate(upload.getParameter("startdate"));
			bean.setEnddate(upload.getParameter("enddate"));
			bean.setDifficultyfactor(upload.getParameter("difficultyfactor"));
			bean.setQuestiontype(upload.getParameter("questiontype"));
			bean.setQuestion(upload.getParameterValues("question"));
			bean.setAnswer(upload.getParameterValues("answer"));
			bean.setCorrectanswer(upload.getParameterValues("checkedanswer"));
			bean.setTotalanswer(upload.getParameterValues("totalanswer"));
			bean.setMark(upload.getParameterValues("mark"));
			bean.setTime(upload.getParameterValues("time"));
			bean.setFiles(upload.getFileNames());
			
			result					= qentry.enterQuestions(bean);

		
	}catch(Exception e){
		
	}
	
	if(result >0)
		status	= "Question(s) Created Successfully.";
	else
		status	= "Question(s) Creation Failed.";

	
	%>
	
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='text'   name='returnurl' 		value='./ExamManagement/ExamHome.jsp'>

	</form>
</body>
</html>