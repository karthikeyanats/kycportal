<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		alert(document.wkrkallotmentsubmit.status.value);
		document.wkrkallotmentsubmit.action = "Schedule.jsp";			
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
	import="com.iGrandee.TimeTable.PeriodTime.Schedule"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status			= null;
	int result				= 0;
	Schedule allot			= new Schedule();
	
	String sessionid		= request.getParameter("session");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	
	
	result					= allot.scheduleSection(
			request.getParameter("staffschedule"),
			"1",
			request.getRemoteHost()
	);
	
	if(result >0)
		status	= "Timetable Successfully Scheduled.";
	else
		status	= "Timetable Schedule Failed.";

	
	%>
	
	<input type='hidden' name='standardname' 	value='<%=standardname%>'>
	<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
	<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
	<input type='hidden' name='section' 		value='<%=sectionid%>'>
	<input type='hidden' name='session' 		value='<%=sessionid%>'>
	<input type='hidden' name='standard'		value='<%=standardid%>'>
	<input type='hidden' name='status' 			value='<%=status%>'>
	
	</form>
</body>
</html>