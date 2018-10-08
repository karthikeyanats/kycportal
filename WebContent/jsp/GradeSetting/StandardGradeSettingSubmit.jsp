<%@ page import="java.util.ArrayList,java.util.HashMap"%>
<%
	int result = 0;
	String resultword = null;

	String[] scaleid = null;

	
	String[] standardscheduleid = null;

	String return_file = null;
	try {
		com.iGrandee.GradeSetting.GradeScaleQuery gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
		com.iGrandee.GradeSetting.GradeScaleBean gradescalebean = new com.iGrandee.GradeSetting.GradeScaleBean();
		standardscheduleid = request.getParameterValues("standardscheduleid");
		scaleid = request.getParameterValues("scalenameid");

		gradescalebean.setScaleId(scaleid);
		gradescalebean.setStandardscheduleid(standardscheduleid);
				
		result = gradescaleQuery.UpdateStandardScaleType(gradescalebean);
			
		if (result > 0) {
			resultword = "Grade Scale Setting  successfully Allocated ";
		} else {
			resultword = "Operation Failed";
		}
		return_file = "./GradeSetting/StandardGradeSettings.jsp";
	} catch (Exception e) { e.printStackTrace();
	}
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
<input type="hidden" name="result" value="<%=result%>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=resultword%>">
</form>
</body>
</html>

