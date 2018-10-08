<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		if(document.wkrkallotmentsubmit.result.value	== "1"){
			document.wkrkallotmentsubmit.action = "./QuestionGenerateView.jsp";			
			document.wkrkallotmentsubmit.submit();
		}
		else{
			document.wkrkallotmentsubmit.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";			
			document.wkrkallotmentsubmit.submit();
		}
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Question Preparation</title>
</head>
<body onload='LoadStatus()'>
<%@ page language="java"
	import="java.util.ArrayList"%>
<%@ page language="java" import="com.iGrandee.ExamManagement.QuestionPreparation"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status				= null;
	int result					= 0;
	ArrayList returnedlist		= null;
	QuestionPreparation prepare	= new QuestionPreparation();
	String userid				= (String)session.getValue("userid");
	String examname				= request.getParameter("examname");
	String yearname				= request.getParameter("yearname");
	String standardname			= request.getParameter("standardname");
	String subjectname			= request.getParameter("subjectname");
	String boardname			= request.getParameter("boardname");
	String templatename			= request.getParameter("templatename");
	String templateid			= request.getParameter("template");
	String instruction			= request.getParameter("instruction");
	String restartingduration	= request.getParameter("restartingduration");
	String attempt				= request.getParameter("attempts");
	String examtypename			= request.getParameter("examtypename");
	String duration				= request.getParameter("duration");


	try {
			
		String repetation 		= request.getParameter("repetation");
		String examtypeid		= request.getParameter("examtype");
		returnedlist			= prepare.questionGeneration(templateid, repetation,examtypeid,instruction);
		
		if(returnedlist != null && returnedlist.size()>0)
		{
			status  = (String)returnedlist.get(0);

			if(status != null && status.equals("Success")){
				status		= "Question Generated Successfully";
				result		= 1;
			}
			else if(status != null && status.equals("Failed")){
				status		= "Question Generation Failed";
				result		= 0;
			}
			else if(status != null && status.startsWith("No Scheduled")){
				result		= 0;
			}
			else{
				
				status		= "Subject Name &nbsp;"+(String)returnedlist.get(1)+"<br>Lesson Name &nbsp;"+(String)returnedlist.get(2)+"<br>Question Type &nbsp;"+(String)returnedlist.get(5)+"<br>Exam Type &nbsp;"+examtypename+"<br>Difficulty Factor &nbsp; &nbsp;"+(String)returnedlist.get(6)+"<br>Please enter the data into Question Bank.<br>Available Data : &nbsp;"+(String)returnedlist.get(4)+"<br>But Require Data :&nbsp;"+(String)returnedlist.get(3)+"<br>Please Check Question Bank for Availability.";
				result		= 0;
			}
		}
		
		
		
	}catch(Exception e){
		e.printStackTrace();
	}
	

	%>
	<input type='hidden' name='yearname' 		value='<%=yearname%>'>
	<input type='hidden' name='standardname' 	value='<%=standardname%>'>
	<input type='hidden' name='templatename' 	value='<%=templatename%>'>
	<input type='hidden' name='subjectname' 	value='<%=subjectname%>'>
	<input type='hidden' name='template' 		value='<%=templateid%>'>
	<input type='hidden' name='boardname' 		value='<%=boardname%>'>
	<input type='hidden' name='examtypename' 	value='<%=examtypename%>'>
	<input type='hidden' name='instruction' 	value='<%=instruction%>'>
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./ExamManagement/QuestionGeneration.jsp'>

	</form>
</body>
</html>