<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		document.wkrkallotmentsubmit.action = "OperationResult.jsp";			
		document.wkrkallotmentsubmit.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Work Allotment</title>
</head>
<body onload='LoadStatus()'>

	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page language="java" import="com.iGrandee.Schedule.Schedule,com.iGrandee.Schedule.ScheduleBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%

	Schedule	schedule		= new Schedule();
	ScheduleBean bean			= new ScheduleBean();
	String status				= null;
	int result					= 0;
	String sessionid			= request.getParameter("session");
	String sessionname			= request.getParameter("sessionname");
	String boardid				= request.getParameter("board");
	String boardname			= request.getParameter("boardname");	
	String userid				= (String)session.getValue("userid");
	String standardscheduleid 	= request.getParameter("standardscheduleid");
	String subjectscheduleid 	= request.getParameter("subjectscheduleid");
	String operation			= request.getParameter("status");
	String subjectname			= request.getParameter("subjectname");
	String archival				= request.getParameter("archival");

	try{
		
		bean.setLessonid(request.getParameter("lessonid"));
		bean.setSubjectscheduletid(subjectscheduleid);
		bean.setStatus(operation);
		bean.setUserid(userid);
		bean.setLessonscheduletid(request.getParameter("lessonscheduleid"));
		
		if(operation.equals("A")){
			
			//result					= schedule.addLessons(
			//	subjectscheduleid,
			//	request.getParameter("lessonid"),
			//	userid
			//);
			
			result					= schedule.addLessons(bean);
			
			
		}
		else{
			result					= schedule.updateLessons(
					request.getParameter("lessonscheduleid"),
					operation
			);
		}
		
		if(result >0)
			if(operation.equals("A"))
				status	= "Successfully Lesson[s]Allocated.";
			else
				status	= "Successfully Lesson[s] Trashed.";
		else
			if(operation.equals("A"))
				status	= "Lesson[s] Restoration Failed.";
			else
				status	= "Lesson[s] Trashing Failed.";
	
	}
	catch(Exception e){
		
	}
	%>
	<input type='hidden' name='session' 			value='<%=sessionid%>'>
	<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
	<input type='hidden' name='board' 				value='<%=boardid%>'>
	<input type='hidden' name='boardname' 			value='<%=boardname%>'>	
	<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid%>'>
	<input type='hidden' name='subjectscheduleid' 	value='<%=subjectscheduleid%>'>
	<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>
	<input type='hidden' name='message' 			value='<%=status%>'>
	<input type='hidden' name='result' 				value='<%=result%>'>
	<input type='hidden' name='returnurl' 			value='ViewLessons.jsp'>
	<input type='hidden' name='archival' 			value='<%=archival%>'>
	
	</form>
</body>
</html>