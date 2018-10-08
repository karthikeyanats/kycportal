<%@ page import="java.util.ArrayList,java.util.HashMap"%>
<%
int result=0;
String resultword=null;
String Sessionid =null;

String [] gradename=null;
String [] from=null;
String [] to=null;

String return_file=null;
String examschid	=	null;
try{
	com.iGrandee.Exam.ExamnameEntry  gradeQuery = new com.iGrandee.Exam.ExamnameEntry();
	com.iGrandee.Exam.ExamnameBean  gradebean = new com.iGrandee.Exam.ExamnameBean();

	//String stdscheduleid	=	null;
	
	String createdby 		=	(String)session.getValue("userid");
	gradename=request.getParameterValues("GradeName");
	from=request.getParameterValues("Rangefrom");
	to=request.getParameterValues("Rangeto");
	Sessionid=request.getParameter("sessionname");

	if(gradename.length>0 && from.length>0 && to.length>0 && gradename!=null && from!=null && to!=null)
	{
		for(int i=0;i<gradename.length;i++)
		{
			gradebean.setSessionid(Sessionid);
			gradebean.setGradename(gradename[i]);	
			gradebean.setRangefrom(from[i]);	
			gradebean.setRangeto(to[i]);
			gradebean.setExamnamestatus("A");	
			gradebean.setCreatedby(createdby);	
			result += gradeQuery.insertGradeSystem(gradebean);	
		}
	}
	if(result>0)
	{
		resultword="Grade is successfully Inserted";
	}
	else
	{
		resultword="Operation Failed";
	}
	return_file ="./Exam/ExamMark/GradeEntry.jsp";
}catch(Exception e){}
%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.submitgradeform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.submitgradeform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="submitgradeform" action="" method="post">
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=resultword%>">
</form>
</body>
</html>

