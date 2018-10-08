<%@ page import="java.util.ArrayList,java.util.HashMap"%>
<%
int rows = 0;
String return_file = "";
String op = "";
try{
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  examAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
	//String stdscheduleid	=	null;
	//int result=0;
	//String op=null;
	//String return_file=null;
	String examschid	=	null;
	String[] chkBoxId=null;
	String[] markTaken=null;
	String[] staffRemarks=null;
	String[] comboRemarks=null;

	String createdby 		=	(String)session.getValue("userid");
	//stdscheduleid=request.getParameter("stdscheduleid");
	examschid=request.getParameter("req_examscheduleid");
	
	//System.out.println("mark_examschid"+examschid);	
	//out.println("examschid-->"+examschid);
	
	chkBoxId= request.getParameterValues("chk");
	//System.out.println("chkBoxId>>>"+chkBoxId);
	markTaken= request.getParameterValues("marktaken");
	staffRemarks= request.getParameterValues("staffremarks");
	comboRemarks= request.getParameterValues("comboremarks");
	//System.out.println("markTaken>>>"+markTaken);
	String ipaddress = request.getRemoteAddr();
	//System.out.println("mark_ipaddress>>>"+ipaddress);
	//System.out.println("chkBoxId,stdscheduleid,approvedby,rollno-->"+chkBoxId+"--"+examschid+"--"+createdby+"--"+markTaken);
	rows = examAllotmentQuery.insertMarkStaff(examschid,chkBoxId,markTaken,staffRemarks,comboRemarks,createdby,ipaddress); 
	if (rows>0){
		op="Examination Mark successfully Inserted";
		return_file =request.getContextPath()+"/jsp/Exam/ExamMark/MarkEntryStaffView.jsp";
	}
	else{
		op="Examination Mark insertion Failed";
		return_file =request.getContextPath()+"/jsp/Exam/ExamMark/MarkEntryStaffSelect.jsp";
	}
	
	
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
}catch(Exception e){
	
	e.printStackTrace();
}
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
<body onLoad=loadResult()>
<form name="applicationForm" action="" method="post">
    <input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
	<input type="hidden" name="req_sessionname" value='<%=request.getParameter("req_sessionname")%>'>
	<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
	<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
	<input type="hidden" name="standardpublishid" value="<%=request.getParameter("standardpublishid")%>">
	<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
	<input type="hidden" name="req_sectionpubid" value="<%=request.getParameter("req_sectionpubid")%>">
	<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
	<input type="hidden" name="req_subjectpubid" value="<%=request.getParameter("req_subjectpubid")%>">
	<input type="hidden" name="req_subjectname" value="<%=request.getParameter("req_subjectname")%>">
	<input type=hidden name=req_examscheduleid value="<%=request.getParameter("req_examscheduleid") %>">
	<input type="hidden" name="req_examallotmentname" value="<%=request.getParameter("req_examallotmentname")%>">
	<input type=hidden name=req_theoryexternalmax value="<%=request.getParameter("req_theoryexternalmax")%>">
	<input type=hidden name=req_theoryexternalmin value="<%=request.getParameter("req_theoryexternalmin")%>">
	<input type=hidden name=req_examschedulestatus value="<%=request.getParameter("req_examschedulestatus")%>">
	<input type=hidden name=req_markpublishstatus value="<%=request.getParameter("req_markpublishstatus")%>">
	
<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="message" value="<%=op%>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="result" value="<%=rows%>">

</form>
</body>
</html>