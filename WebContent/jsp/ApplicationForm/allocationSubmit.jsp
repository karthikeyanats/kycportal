
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	com.iGrandee.Application.AllocationBean  allocationBean = new com.iGrandee.Application.AllocationBean();
	//String stdscheduleid	=	null;
	String sectionSchedId	=	null;
	String op = "";
	String return_file = "";

	String approvedby 		=	(String)session.getValue("userid");
	//stdscheduleid=request.getParameter("stdscheduleid");
	sectionSchedId=request.getParameter("sectionSchedId");	
	//out.println("sectionSchedId-->"+sectionSchedId);
	String[] chkBoxId=null;
	chkBoxId= request.getParameterValues("chk");
	//approvedby=(String)session.getAttribute("uName");
	//out.print("chkBoxId,stdscheduleid,approvedby"+chkBoxId+"--"+sectionSchedId+"--"+approvedby);
	
	int secScheduleId = Integer.parseInt(sectionSchedId);
	
	allocationBean.setCandidateregisterid(chkBoxId);
	allocationBean.setSectionscheduleid(secScheduleId);
	allocationBean.setCreatedby(approvedby);
	
	int j;
	j = registrationQuery.insertAllocationStudent(allocationBean);
	//j = registrationQuery.insertAllocationStudent(chkBoxId,sectionSchedId,approvedby);	
	
	if(j>0)
		op = "Student(s) Allocated Successfully";
	else
		op = "Student(s) Allocation Failed";
	
	return_file = request.getContextPath()+"/jsp/ApplicationForm/StudentAllocation.jsp";
//String newStud="";
//String registerStud="";
//int no_of_rows=chkBoxId.length;
//String op="Successfully Inserted";
//response.sendRedirect("./StudentAllocation.jsp");
//String return_file = "./applicationlist.jsp";
//response.sendRedirect("./Operation_Result.jsp?op="+op+"&rows="+no_of_rows+"&registerStud="+registerStud+"&newStud="+newStud+"&forwardfile="+return_file);


	//response.sendRedirect("./StudentAllocation.jsp?insert="+insert);
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