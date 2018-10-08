<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		//document.wkrkallotmentsubmit.action = "./../Operation_Result.jsp?assignmentid"+document.wkrkallotmentsubmit.assignmentid.value;
		document.wkrkallotmentsubmit.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp
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
	import="com.iGrandee.Assignment.AssignmentStudent,com.iGrandee.Assignment.AssignmentReplyBean,com.iGrandee.Assignment.AssignmentUpload"%>

	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status				= null;
	int result					= 0;
	AssignmentStudent allot		= new AssignmentStudent();
	AssignmentUpload upload		= new AssignmentUpload(request);
	AssignmentReplyBean bean	= new AssignmentReplyBean();
	upload.startProcess();
	String studentid			= (String)session.getValue("studentid");
	String assignmentid			= upload.getParameter("assignmentid");
	String oldfile				= upload.getParameter("oldfile");

	String[] files				= upload.getFileNames();
	if(files != null && files[0].equals("-"))
		files[0] = oldfile;


	bean.setAssignmentid(upload.getParameter("assignmentid"));
	bean.setAgentid(upload.getParameter("agentid"));
	bean.setStudentremarks(upload.getParameter("studremarks"));
	bean.setStudentid(studentid);
	bean.setFile(files[0]);
	bean.setIpaddress(request.getRemoteAddr());
	
	result					= allot.insertAssignment_Tracking(bean);

	//result					= allot.insertAssignment_Tracking(
	//		upload.getParameter("assignmentid"),
	//		upload.getParameter("agentid"),
	//		upload.getParameter("studremarks"),
	//		studentid,
	//		files[0],
	//		request.getRemoteAddr()
	//);



	if(result >0)
		status	= "Assignment Successfully Submitted.";
	else
		status	= "Assignment Submission Failed.";
	%>

	<input type='hidden' name='message' 			value='<%=status%>'>
	<input type='hidden' name='result' 				value='<%=result%>'>
	<input type='hidden' name='assignmentid' 		value='<%=assignmentid%>'>
	<input type='hidden' name='returnurl' 			value='./Student/AssignmentView.jsp'>



	</form>
</body>
</html>