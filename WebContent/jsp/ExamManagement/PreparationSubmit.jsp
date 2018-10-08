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
<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.ExamManagement.QuestionPreparation,com.iGrandee.ExamManagement.ExamSheetmasterBean,com.iGrandee.ExamManagement.ExamSheetDetailsBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status				= null;
	int result					= 0;
	QuestionPreparation prepare	= new QuestionPreparation();
	ExamSheetmasterBean master	= new ExamSheetmasterBean();
	ExamSheetDetailsBean detail	= new ExamSheetDetailsBean();

	try {
			
		String examnames 	= request.getParameter("exam");
		String sessionid 	= request.getParameter("academicyear");
		String subjectid	= request.getParameter("subject");
		String Chapter[]	= request.getParameterValues("chap");
		String Qn[]			= request.getParameterValues("qn");
		String level[]		= request.getParameterValues("level");
		String type[]		= request.getParameterValues("type");
		String Mark[]		= request.getParameterValues("marks");
		String description	= request.getParameter("description");
		String templatetype	= request.getParameter("templatetype");
		
		master.setExamname(description);
		master.setSubjectscheduleid(subjectid);
		master.setTemplatetype(templatetype);
		
		detail.setLessonids(Chapter);
		detail.setDfs(level);
		detail.setTypes(type);
		detail.setNoqns(Qn);
		detail.setMarksperqns(Mark);
		
		result				= prepare.createTemplate(master,detail);
		
		
		//result				= prepare.createTemplate(description, subjectid,templatetype,sessionid,examnames,Chapter,level,type,Qn,Mark);
		
	}catch(Exception e){
		e.printStackTrace();
	}
	
	if(result >0)
		status	= "Template Created Successfully.";
	else
		status	= "Template Creation Failed.";

	
	%>
	
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='text'   name='returnurl' 		value='./ExamManagement/QuestionPreparation.jsp'>

	</form>
</body>
</html>