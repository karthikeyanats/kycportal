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
	import="com.iGrandee.TimeTable.PeriodTime.WorkAllotment,com.iGrandee.TimeTable.PeriodTime.SubjectAllotmentBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status				= null;
	String status1				= request.getParameter("status");
	int result					= 0;
	WorkAllotment allot			= new WorkAllotment();
	SubjectAllotmentBean bean	= new SubjectAllotmentBean();
	String sessionid			= request.getParameter("session");
	String sessionname			= request.getParameter("sessionname");
	String standardid			= request.getParameter("standard");
	String sectionid			= request.getParameter("section");
	String staffid				= request.getParameter("staffid");
	String staffname			= request.getParameter("staffname");
	String deptid				= request.getParameter("department");
	String roleid				= request.getParameter("role");
	
	
	bean.setAllottedhourss(request.getParameterValues("hours"));
	bean.setSubjectallotmentids(request.getParameterValues("schedule"));
	
	if(status1 != null && status1.equals("update")){
		
		result					= allot.updateAssign(bean);
		
		//result					= allot.updateAssign(
		//		request.getParameterValues("hours"),
		//		request.getParameterValues("schedule")
		//);
		
		if(result >0)
			status	= "Subject Allotment Successfully Updated.";
		else
			status	= "Subject Allotment Updation Failed.";
		
	}
	else if(status1 != null && status1.equals("delete")){
		
		result					= allot.removeAssign(bean);

		
		//result					= allot.removeAssign(
		//		request.getParameterValues("schedule")
		//);
		
		if(result >0)
			status	= "Subject Allotment Successfully Removed.";
		else
			status	= "Subject Allotment Remove Failed. This may happened due to this subject is already scheduled.";
	}

	%>
	
	<input type='hidden' name='session' 	value='<%=sessionid%>'>
	<input type='hidden' name='sessionname' value='<%=sessionname%>'>
	<input type='hidden' name='standard' 	value='<%=standardid%>'>
	<input type='hidden' name='section' 	value='<%=sectionid%>'>
	<input type='hidden' name='staffid' 	value='<%=staffid%>'>
	<input type='hidden' name='staffname' 	value='<%=staffname%>'>
	<input type='hidden' name='department' 	value='<%=deptid%>'>
	<input type='hidden' name='role' 		value='<%=roleid%>'>
	
	<input type='hidden' name='message' 	value='<%=status%>'>
	<input type='hidden' name='result' 		value='<%=result%>'>
	<input type='hidden' name='returnurl' 	value='./TimeTable/SubjectAllotment.jsp'>
	
	</form>
</body>
</html>