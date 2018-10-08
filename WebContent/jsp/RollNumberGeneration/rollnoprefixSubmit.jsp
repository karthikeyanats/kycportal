
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	//String stdscheduleid	=	null;
	String sectionSchedId	=	null;
	String op = "";
	String return_file = "";
	String approvedby 		=	(String)session.getValue("userid");

	//stdscheduleid=request.getParameter("stdscheduleid");
	sectionSchedId=request.getParameter("sectionSchedId");	
	//out.println("sectionSchedId-->"+sectionSchedId);

	//String[] chkBoxId=null;
	//chkBoxId= request.getParameterValues("chk");
	
	String rollNoPrefix=null;
	rollNoPrefix= request.getParameter("rollnoprefix");	
	
	//approvedby=(String)session.getAttribute("uName");
//out.print("chkBoxId,stdscheduleid,approvedby,rollno-->"+chkBoxId+"--"+sectionSchedId+"--"+approvedby+"--"+rollNo);
	int j;
	//j = registrationQuery.updateRollNumberGen(chkBoxId,sectionSchedId,approvedby,rollNo);
	j = registrationQuery.setRollNumberPrefix(sectionSchedId,approvedby,rollNoPrefix);
	
	if(j>0)
		op = "Roll No. Prefix was "+request.getParameter("confirmresult")+" Successfully";
	else
		op = "Roll No. Prefix set Failed";
	
	return_file = request.getContextPath()+"/jsp/RollNumberGeneration/RollNoGenSelect.jsp";

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
<input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
<input type="hidden" name="standardpublishid" value="<%=request.getParameter("standardpublishid")%>">
<input type="hidden" name="reg_coursepubid_hidden" value="<%=request.getParameter("reg_coursepubid_hidden")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type="hidden" name="req_sectionpubid" value="<%=sectionSchedId%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">



</form>
</body>
</html>