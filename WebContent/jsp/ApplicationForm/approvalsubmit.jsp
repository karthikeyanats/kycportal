
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	com.iGrandee.Application.ApprovalBean  approvalBean = new com.iGrandee.Application.ApprovalBean();
	String stdscheduleid	=	null;
	String approvedby 		=	(String)session.getValue("userid");

	stdscheduleid=request.getParameter("stdscheduleid");
	String op = "";
	String return_file = "";
	//out.println("stdscheduleid[i]"+stdscheduleid);

	String[] chkBoxId=null;
	chkBoxId= request.getParameterValues("chk");
	
	int stdscheduleId = Integer.parseInt(stdscheduleid);
	
	approvalBean.setRegistrationid(chkBoxId);
	approvalBean.setStandardscheduleid(stdscheduleId);
	approvalBean.setCreatedby(approvedby);
	//approvalBean.setIpaddress(ipaddress);
	//approvalBean.setInstituteid(instituteid);
	
	//approvedby=(String)session.getAttribute("uName");
	//out.print("chkBoxId,stdscheduleid,approvedby"+chkBoxId+"--"+stdscheduleid+"--"+approvedby);
	int j;
	j = registrationQuery.insertApprovalStudent(approvalBean);
	//j = registrationQuery.insertApprovalStudent(chkBoxId,stdscheduleid,approvedby);	
	
	if(j>0)
		op = "Student(s) Approved Successfully";
	else
		op = "Student(s) Approval Failed";
	
	return_file = request.getContextPath()+"/jsp/ApplicationForm/StudentApproval.jsp";

	//op="Successfully Inserted";
//response.sendRedirect("./StudentApproval.jsp");

	//out.println("<h2><center><b>Successfully Inserted");

%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.applicationForm.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.applicationForm.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="applicationForm" action="" method="post">
<input type="hidden" name="result" value="<%=j %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=op%>">

</form>
</body>
</html>