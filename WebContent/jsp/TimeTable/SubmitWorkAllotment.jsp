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
	import="com.iGrandee.TimeTable.PeriodTime.WorkAllotment,com.iGrandee.TimeTable.PeriodTime.WorkAllotmentBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status			= null;
	int result				= 0;
	WorkAllotment allot		= new WorkAllotment();
	WorkAllotmentBean bean	= new WorkAllotmentBean();
	String sessionid		= request.getParameter("session");
	String deptid			= request.getParameter("department");
	String roleid			= request.getParameter("role");
	String userid			= (String)session.getValue("userid");
	
	
	bean.setStaffids(request.getParameterValues("staffs"));
	bean.setNoofhours(request.getParameterValues("workhour"));
	bean.setCreatedby(userid);
	bean.setSessionid(sessionid);
	bean.setIpaddress(request.getRemoteHost());
	
	
	 	
	result					= allot.insertUpdateWorkHour(bean);
	
	//result					= allot.insertUpdateWorkHour(
	//		request.getParameterValues("staffs"),
	//		request.getParameterValues("workhour"),
	//		userid,sessionid,
	//		request.getRemoteHost()
	//);
	
	if(result >0)
		status	= "Work Allotted Successfully.";
	else
		status	= "Work Allottment Failed.";

	
	%>
	
	<input type='hidden' name='session' 	value='<%=sessionid%>'>
	<input type='hidden' name='department' 	value='<%=deptid%>'>
	<input type='hidden' name='role' 		value='<%=roleid%>'>
	<input type='hidden' name='message' 	value='<%=status%>'>
	<input type='hidden' name='result' 		value='<%=result%>'>
	<input type='hidden' name='returnurl' 	value='./TimeTable/WorkAllotment.jsp'>
	
	
	
	</form>
</body>
</html>