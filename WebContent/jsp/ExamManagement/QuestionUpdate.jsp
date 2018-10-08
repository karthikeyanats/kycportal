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
	String questiontype			= upload.getParameter("questiontype");
	String difficultyfactor		= upload.getParameter("difficultyfactor");
	String examtype				= upload.getParameter("examtype");
	String lesson				= upload.getParameter("lesson");
	String boardname			= upload.getParameter("boardname");
	String standardname			= upload.getParameter("standardname");
	String subjectname			= upload.getParameter("subjectname");
	String lessonname			= upload.getParameter("lessonname");
	String examtypename			= upload.getParameter("examtypename");
	String startsat_str			= upload.getParameter("startsat");
	

	try {
			
			bean.setOccurences(upload.getParameterValues("occurance"));
			bean.setQuestiontype(questiontype);
			bean.setEnddates(upload.getParameterValues("enddate"));
			bean.setQuestion(upload.getParameterValues("question"));
			bean.setAnswer(upload.getParameterValues("answer"));
			bean.setCorrectanswer(upload.getParameterValues("checkedanswer"));
			bean.setTotalanswer(upload.getParameterValues("totalanswer"));
			bean.setMark(upload.getParameterValues("mark"));
			bean.setTime(upload.getParameterValues("time"));
			bean.setQuestionid(upload.getParameterValues("questionid"));
			bean.setFiles(upload.getFileNames());
			result					= qentry.updateQuestions(bean);

		
	}catch(Exception e){
		
	}
	
	if(result >0)
		status	= "Question(s) Updated Successfully.";
	else
		status	= "Question(s) Updation Failed.";

	
	%>
	
	<input type='hidden' name='message' 			value='<%=status%>'>
	<input type='hidden' name='result' 				value='<%=result%>'>
	<input type='hidden' name='examtype' 			value='<%=examtype%>'>
	<input type='hidden' name='lesson' 				value='<%=lesson%>'>
	<input type='hidden' name='difficultyfactor' 	value='<%=difficultyfactor%>'>
	<input type='hidden' name='questiontype' 		value='<%=questiontype%>'>		
	<input type='hidden' name='boardname' 			value='<%=boardname%>'>		
	<input type='hidden' name='standardname' 		value='<%=standardname%>'>		
	<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>		
	<input type='hidden' name='lessonname' 			value='<%=lessonname%>'>		
	<input type='hidden' name='examtypename' 		value='<%=examtypename%>'>	
	<input type='hidden' name='startsat' 			value='<%=startsat_str%>'>
	<input type='text'   name='returnurl' 			value='./ExamManagement/QuestionView.jsp'>

	</form>
</body>
</html>