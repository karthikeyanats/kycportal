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
<title>Submit Work Allotment</title>
</head>
<body onload='LoadStatus()'>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.WorkAllotment,com.iGrandee.TimeTable.PeriodTime.ClassTeacherBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
		
		String status			= null;
		int result				= 0;
		WorkAllotment allot		= new WorkAllotment();
		ClassTeacherBean bean	= new ClassTeacherBean();
		
		
		bean.setStaffid(request.getParameter("staffid"));
		bean.setSectionscheduleid(request.getParameter("section"));
		bean.setCreatedby((String)session.getValue("userid"));
		
		if(request.getParameter("status") == null || !request.getParameter("status").equals("update")){
	
			result					= allot.setClassTeacher(bean);
			//result					= allot.setClassTeacher(
			//		request.getParameter("staffid"),
			//		request.getParameter("section"),
			//		(String)session.getValue("userid")
			//);
			
			if(result >0)
				status	= "Class Teacher Successfully Assigned.";
			else
				status	= "Class Teacher Assignment Failed.";
		
		}
		else{
			
			result					= allot.removeClassTeacher(bean);

			//result					= allot.removeClassTeacher(
			//		request.getParameter("staffid"),
			//		request.getParameter("section")
			//);
			
			if(result >0)
				status	= "Class Teacher Successfully Removed.";
			else
				status	= "Class Teacher Removing Failed.";
			
		}
		

	
	%>
	
	<input type='hidden' name='message' 	value='<%=status%>'>
	<input type='hidden' name='result' 		value='<%=result%>'>
	<input type='hidden' name='returnurl' 	value='./TimeTable/ClassTeacher.jsp'>
	
	</form>
</body>
</html>