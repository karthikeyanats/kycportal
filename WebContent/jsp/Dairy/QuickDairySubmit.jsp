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
	
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page language="java" import="com.iGrandee.Dairy.Dairy,com.iGrandee.Dairy.DairyReplyBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
		
		String status			= null;
		int result				= 0;
		Dairy allot				= new Dairy();
		DairyReplyBean bean		= new DairyReplyBean();
		String dairyid			= request.getParameter("dairyid");
		String dairyname		= request.getParameter("dairyname");
		String sessionid		= request.getParameter("session");
		String standardid		= request.getParameter("standard");
		String sectionid		= request.getParameter("section");
		String subjectid		= request.getParameter("subject");
		String sectionname		= request.getParameter("sectionname");
		String subjectname		= request.getParameter("subjectname");
		String standardname		= request.getParameter("standardname");
		String sessionname		= request.getParameter("sessionname");	
		
		bean.setStudentdiaryreplyids(request.getParameterValues("replyid"));
		bean.setStaffdiaryremarkss(request.getParameterValues("staffremark"));
		
		result						= allot.insertDairyFacultyRemarks(bean);
		
		//result						= allot.insertDairyFacultyRemarks(
		//		request.getParameterValues("replyid"),
		//		request.getParameterValues("studentid"),
		//		request.getParameterValues("staffremark")
		//);

	
		if(result >0)
			status	= " Diary  Evaluated Successfully.";
		else
			status	= "Diary Evaluation Failed.";
		
	%>

		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
		<input type='hidden' name='section' 			value='<%=sectionid%>'>
		<input type='hidden' name='subject' 			value='<%=subjectid%>'>
		<input type='hidden' name='standard' 			value='<%=standardid%>'>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>
		<input type='hidden' name='sectionname' 		value='<%=sectionname%>'>
		<input type='hidden' name='dairyid' 			value='<%=dairyid %>'>
		<input type='hidden' name='dairyname' 			value='<%=dairyname %>'>
		<input type='hidden' name='message' 			value='<%=status%>'>
		<input type='hidden' name='result' 				value='<%=result%>'>
		<input type='hidden' name='returnurl' 			value='./Dairy/TrackDairyQuick.jsp'>
		
	
	</form>
</body>
</html>