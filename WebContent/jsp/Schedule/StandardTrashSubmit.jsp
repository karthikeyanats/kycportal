<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		//alert(document.wkrkallotmentsubmit.status.value);
		document.wkrkallotmentsubmit.action = "OperationResult.jsp";			
		document.wkrkallotmentsubmit.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
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
	String boardname		= request.getParameter("boardname");
	String boardid			= request.getParameter("board");
	String standardscheduleid = request.getParameter("standardscheduleid");
	
	try{
		
		bean.setStandardscheduleid(standardscheduleid);
		bean.setStatus("T");
		result					= schedule.updateStandardScheduled(bean);
		
		
		//result					= schedule.updateStandardScheduled(
		//	standardscheduleid,
		//	"T"
		//);
	}
	catch(Exception e){
		
	}
	
	
	if(result >0)
			status	= "Scheduled Standard[s] Successfully Trashed.";
	else
			status	= "Scheduled Standard[s] Trashing Failed.";
	%>
	<input type='hidden' name='session' 			value='<%=sessionid%>'>
	<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
	<input type='hidden' name='boardname' 			value='<%=boardname%>'>
	<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid%>'>
	<input type='hidden' name='board' 				value='<%=boardid%>'>
	<input type='hidden' name='message' 			value='<%=status%>'>
	<input type='hidden' name='result' 				value='<%=result%>'>
	<input type='hidden' name='returnurl'			value='StandardSchedule.jsp'>
	
	
	</form>
</body>
</html>