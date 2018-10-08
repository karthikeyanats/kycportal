<%@ page import="java.util.ArrayList,java.util.HashMap"%>
<%
int result=0;
String resultword=null;
String Sessionid =null;

String  gradename=null;
String  from=null;
String  to=null;
String  EditStatus=null;
String  Gradeid=null;
String return_file=null;
String examschid	=	null;
try{
	com.iGrandee.Exam.ExamnameEntry  gradeQuery = new com.iGrandee.Exam.ExamnameEntry();
	com.iGrandee.Exam.ExamnameBean  gradebean = new com.iGrandee.Exam.ExamnameBean();

	//String stdscheduleid	=	null;
	
	String createdby 		=	(String)session.getValue("userid");
	Gradeid=request.getParameter("Gradeid");
	gradename=request.getParameter("GradeName");
	from=request.getParameter("Rangefrom");
	to=request.getParameter("Rangeto");
	Sessionid=request.getParameter("sessionname");
	EditStatus=request.getParameter("editstatus");
			gradebean.setSessionid(Sessionid);
			gradebean.setGradename(gradename);	
			gradebean.setGradeid(Gradeid);	
			gradebean.setRangefrom(from);	
			gradebean.setRangeto(to);
			gradebean.setCreatedby(createdby);	
			if(EditStatus.equals("E"))
			{	 
				gradebean.setGradestatus("A");	
				result += gradeQuery.updateGradeSystem(gradebean);
			}
			else if(EditStatus.equals("A") || EditStatus.equals("X")|| EditStatus.equals("T"))
			{
				gradebean.setGradestatus(EditStatus);	
				result += gradeQuery.updateGradeSystemStatus(gradebean);
			}
	if(result>0)
	{
		 if(EditStatus.equals("E"))
		{
			resultword="Grade is successfully Updated";
		}
		 else if(EditStatus.equals("A"))
		{
			resultword="Grade is successfully Restored";
		}
		else if(EditStatus.equals("X"))
		{
			resultword="Grade is successfully Deleted";
		}
		else if(EditStatus.equals("T"))
		{
			resultword="Grade is successfully Trashed";
		}
	}
	else
	{
		resultword="Operation Failed";
	}
	return_file ="./Exam/ExamMark/GradeView.jsp";  
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

