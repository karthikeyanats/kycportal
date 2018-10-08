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

	Schedule	schedule	= new Schedule();
	ScheduleBean bean		= new ScheduleBean();
	
	String status			= null;
	int result				= 0;
	String sessionid		= request.getParameter("session");
	String sessionname		= request.getParameter("sessionname");
	String standardscheduleid = request.getParameter("standardscheduleid");
	String boardid			= request.getParameter("board");	
	String boardname		= request.getParameter("boardname");		
	String archival			= request.getParameter("archival");
	
	try{
		
		bean.setSubjectscheduleids(request.getParameterValues("subjectscheduleid"));
		bean.setTheoryinternalmin(request.getParameterValues("theoryinternalmin"));
		bean.setTheoryinternalmax(request.getParameterValues("theoryinternalmax"));
		bean.setTheoryexternalmin(request.getParameterValues("theoryexternalmin"));
		bean.setTheoryexternalmax(request.getParameterValues("theoryexternalmax"));
		bean.setPracticalinternalmin(request.getParameterValues("practicalinternalmin"));
		bean.setPracticalinternalmax(request.getParameterValues("practicalinternalmax"));
		bean.setPracticalexternalmin(request.getParameterValues("practicalexternalmin"));
		bean.setPracticalexternalmax(request.getParameterValues("practicalexternalmax"));
		bean.setProjectinternalmin(request.getParameterValues("projectinternalmin"));
		bean.setProjectinternalmax(request.getParameterValues("projectinternalmax"));
		bean.setProjectexternalmin(request.getParameterValues("projectexternalmin"));
		bean.setProjectexternalmax(request.getParameterValues("projectexternalmax"));
		bean.setCredithours(request.getParameterValues("credithours"));
		
		
		result					= schedule.markScheduleMultiple(bean);

	
			//result					= schedule.markScheduleMultiple(
			//	request.getParameterValues("subjectscheduleid"),
			//	request.getParameterValues("theoryinternalmin"),
			//	request.getParameterValues("theoryinternalmax"),
			//	request.getParameterValues("theoryexternalmin"),
			//	request.getParameterValues("theoryexternalmax"),
			//	request.getParameterValues("practicalinternalmin"),
			//	request.getParameterValues("practicalinternalmax"),
			//	request.getParameterValues("practicalexternalmin"),
			//	request.getParameterValues("practicalexternalmax"),
			//	request.getParameterValues("projectinternalmin"),
			//	request.getParameterValues("projectinternalmax"),
			//	request.getParameterValues("projectexternalmin"),
			//	request.getParameterValues("projectexternalmax"),
			//	request.getParameterValues("credithours")
			//);
		
		
		if(result >0)
			status	= "Mark Scheduled Successfully.";
		else
			status	= "Mark Scheduled Failed.";
		
	}
	catch(Exception e){
		e.printStackTrace();
	}
	%>
		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
		<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid%>'>
		<input type='hidden' name='message' 			value='<%=status%>'>
		<input type='hidden' name='board' 				value='<%=boardid%>'>
		<input type='hidden' name='boardname' 			value='<%=boardname%>'>
		<input type='hidden' name='returnurl' 			value='<%=request.getParameter("returnpage")%>'>
		<input type='hidden' name='result' 				value='<%=result%>'>
		<input type='hidden' name='archival' 			value='<%=archival%>'>

	</form>
</body>
</html>