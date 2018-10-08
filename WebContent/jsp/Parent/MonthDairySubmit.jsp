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
<title>Submit Schedule</title>
</head>
<body onload='LoadStatus()'>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Assignment.AssignmentStudent,com.iGrandee.Dairy.Dairy,com.iGrandee.Dairy.DairyReplyBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
		
		String status		= null;
		int result			= 0;
		Dairy allot			= new Dairy();
		DairyReplyBean bean	= new DairyReplyBean();
		String studentid	= (String)session.getValue("studentid");
		String dairyid		= request.getParameter("dairyid");
		String dayname		= request.getParameter("dayname");
		String date			= request.getParameter("dairydate");
		String cdate		= request.getParameter("cdairydate");
		String index		= request.getParameter("index");
		
		
		bean.setStudentdiaryid(dairyid);
		bean.setStudentid(studentid);
		bean.setParentremarks(request.getParameter("studremarks"));
		
		result						= allot.insertDairyParent(bean);
		
		//result						= allot.insertDairyParent(
		//		dairyid,
		//		studentid,
		//		request.getParameter("studremarks")
		//);

	
		if(result >0)
			status	= "Diary Successfully Submitted.";
		else
			status	= "Diary Submission Failed.";
		
	%>
	
	<input type='hidden' name='dairydate' 	value='<%=date%>'>
	<input type='hidden' name='cdairydate' 	value='<%=cdate%>'>
	<input type='hidden' name='dayname' 	value='<%=dayname%>'>
	<input type='hidden' name='index' 		value='<%=index%>'>
	<input type='hidden' name='message' 	value='<%=status%>'>
	<input type='hidden' name='result' 		value='<%=result%>'>
	<input type='hidden' name='returnurl' 	value='./Parent/MonthDairyView.jsp'>
	
	</form>
</body>
</html>