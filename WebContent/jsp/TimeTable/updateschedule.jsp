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
<title>Update Schedule</title>
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
	String boardname		= request.getParameter("boardname");
	
	
	
	result					= allot.scheduleUpdate(
			request.getParameter("staffschedule"),
			(String)session.getValue("userid")
	);
	
	if(result >0)
		status	= "Schedule Successfully Updated.";
	else
		status	= "Schedule Updation Failed.";

	
	%>
	
	<input type='hidden' name='standardname' 	value='<%=standardname%>'>
	<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
	<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
	<input type='hidden' name='section' 		value='<%=sectionid%>'>
	<input type='hidden' name='session' 		value='<%=sessionid%>'>
	<input type='hidden' name='standard'		value='<%=standardid%>'>
	<input type='hidden' name='status' 			value='<%=status%>'>
	<input type='hidden' name='boardname' 		value='<%=boardname%>'>
	
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./TimeTable/EditSchedule.jsp'>
	
	
	</form>
</body>
</html>