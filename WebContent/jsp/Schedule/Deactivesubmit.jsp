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
		String standardscheduleid 	= request.getParameter("standardscheduleid");
		String operation			= request.getParameter("status");
		String boardid				= request.getParameter("board");	
		String boardname			= request.getParameter("boardname");	
		String archival				= request.getParameter("archival");
	
		try{
			
			
			bean.setSubjectscheduletid(request.getParameter("subjectscheduleid"));
			
			
	
			if(operation.equals("A")){
				//result					= schedule.updateSchedules(
				//		request.getParameter("subjectscheduleid"),
				//		"A"
				//);
				
				bean.setStatus("A");
				result					= schedule.updateSchedules(bean);
				
			}
			else{
				//result					= schedule.updateSchedules(
				//		request.getParameter("subjectscheduleid"),
				//		"X"
				//);
				
				bean.setStatus("X");
				result					= schedule.updateSchedules(bean);
		
			}
		
				
				if(result >0)
					if(operation.equals("A"))
						status	= "Scheduled Subject[s] Successfully Restored.";
					else
						status	= "Scheduled Subject[s] Successfully Deleted.";
				else
					if(operation.equals("A"))
						status	= "Scheduled Subject[s] Resoration Failed.";
					else
						status	= "Scheduled Subject[s] Deletion Failed.";
		}
		catch(Exception e){
			
		}

	%>
	<input type='hidden' name='session' 			value='<%=sessionid%>'>
	<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
	<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid%>'>
	<input type='hidden' name='message' 			value='<%=status%>'>
	<input type='hidden' name='returnurl' 			value='DeActivatedSubjects.jsp'>
	<input type='hidden' name='result' 				value='<%=result%>'>
	<input type='hidden' name='board' 				value='<%=boardid%>'>
	<input type='hidden' name='boardname' 			value='<%=boardname%>'>
	<input type='hidden' name='archival' 			value='<%=archival%>'>
	
	</form>
</body>
</html>