
<%@page import="com.iGrandee.Prinicipal.PrinicipalQuery"%>

<%
String instituteid = null;
String userid = null;
String reqstandardid = null;
String lessonname;
String lessondescription; 
int rows = 0;
String return_file = "";
String op="";
PrinicipalQuery  prinicipalquery = new com.iGrandee.Prinicipal.PrinicipalQuery();
String resultword = null;
String Examallotmentid = null;

try
{
		String examscheduleid [] = request.getParameterValues("examscheduleid");
		//out.println(examscheduleid);
		rows = prinicipalquery.ResultPublishUpdate(examscheduleid); 
		
		
		if(rows>0)
		{
			resultword="Result is successfully Published";
		}	
		else
		{
			resultword="operation Failed";
		}
		return_file = "./Principal/ExamResultPublish.jsp";
	
}catch(Exception e){e.printStackTrace();}
%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.submitpublishform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.submitpublishform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="submitpublishform" action="" method="post">
<input type="hidden" name="result" value="<%=rows %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=resultword%>">
</form>
</body>
</html>
