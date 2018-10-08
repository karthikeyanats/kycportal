
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	//String stdscheduleid	=	null;
	String sectionSchedId	=	null;
	String return_file = "";
	String op = "";
	String approvedby 		=	(String)session.getValue("userid");

	//stdscheduleid=request.getParameter("stdscheduleid");
	sectionSchedId=request.getParameter("sectionSchedId");	
	out.println("sectionSchedId-->"+sectionSchedId);

	String[] chkBoxId=null;
	chkBoxId= request.getParameterValues("chk");
	
	String[] rollNo=null;
	rollNo= request.getParameterValues("rollno");	
	
	//approvedby=(String)session.getAttribute("uName");
	//out.print("chkBoxId,stdscheduleid,approvedby,rollno-->"+chkBoxId+"--"+sectionSchedId+"--"+approvedby+"--"+rollNo);
	int j;
	j = registrationQuery.updateRollNumberGen(chkBoxId,sectionSchedId,approvedby,rollNo);	

	if(j>0)
		op = "Roll No. Allocated Successfully";
	else
		op = "Roll No. Allocation Failed";
	
	return_file = request.getContextPath()+"/jsp/RollNumberGeneration/RollNoGenSelect.jsp";
	
//String newStud="";
//String registerStud="";
//int no_of_rows=chkBoxId.length;
//String op="Successfully Inserted";
//response.sendRedirect("./RollNoGenSelect.jsp");
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