
<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
	com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	com.iGrandee.Application.Duplicatebean  duplicatebean = new com.iGrandee.Application.Duplicatebean();
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
	
	String[] rollNo=null;
	rollNo= request.getParameterValues("rollno");	
	
	//approvedby=(String)session.getAttribute("uName");
//out.print("chkBoxId,stdscheduleid,approvedby,rollno-->"+chkBoxId+"--"+sectionSchedId+"--"+approvedby+"--"+rollNo);
//out.println("chkBoxId.length>>>"+chkBoxId.length);
for(int k=0;k<chkBoxId.length;k++)
{
	
	//out.println("chkBoxId>>>>>>>>"+chkBoxId[k]);	
}
//out.println("sectionSchedId>>>>>>>"+sectionSchedId);
//out.println("approvedby>>>>"+approvedby);
//out.println("rollNo.length>>>>"+rollNo.length);
for(int x=0;x<rollNo.length;x++){
	//out.println("rollNo>>>>"+rollNo[x]);	
}

//out.println("instituteid>>>>"+session.getValue("instituteid"));



	int j;
	j = registrationQuery.updateRollNumberGen(chkBoxId,sectionSchedId,approvedby,rollNo, (String)session.getValue("instituteid"),duplicatebean);	
	//out.println("j result>>>>"+j);

	if(j>0) 
		op = "Roll Number Generated Successfully"; 
	else if(j==-1)
		op = "Duplicate Roll Number "+duplicatebean.getDuplicaterr();	
	else if(j!=-1 && j<0 )
		op = "Roll Number Generation Failed";
	
	return_file = request.getContextPath()+"/jsp/RollNumberGeneration/RollNoGenerate.jsp";
	//out.println("getDuplicaterr>>>"+duplicatebean.getDuplicaterr());
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
<body onload="loadResult()">
<form name="applicationForm" action="" method="post">
<input type="hidden" name="result" value="<%=j %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=op%>">
<input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
<input type="hidden" name="standardpublishid" value="<%=request.getParameter("standardpublishid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type="hidden" name="req_sectionpubid" value="<%=sectionSchedId%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="rollnoprefix" value="<%=request.getParameter("rollnoprefix")%>">


</form>
</body>
</html>