<%@ page import="java.util.ArrayList,java.util.HashMap"%>
<%
	int result = 0;
	String resultword = null;
	String Sessionid = null;
	String boardid = null;
	String scaleid = null;
	
	String[] gradescaleid = null;

	String[] gradeid = null;
	String[] rangefrom = null;
	String[] rangeto = null;

	String return_file = null;
	try {
		com.iGrandee.GradeSetting.GradeScaleQuery gradescaleQuery = new com.iGrandee.GradeSetting.GradeScaleQuery();
		com.iGrandee.GradeSetting.GradeScaleBean gradescalebean = new com.iGrandee.GradeSetting.GradeScaleBean();

		//String stdscheduleid	=	null;

		String createdby = (String) session.getValue("userid");
		gradeid = request.getParameterValues("gradeid");
		rangefrom = request.getParameterValues("rangefrom");
		rangeto = request.getParameterValues("rangeto");
		gradescaleid = request.getParameterValues("gradescaleid");

		Sessionid = request.getParameter("sessionid");
		boardid = request.getParameter("boardid");
		scaleid = request.getParameter("scalenameid");

		gradescalebean.setGradescaleId(gradescaleid);
		gradescalebean.setBoardid(boardid);
		gradescalebean.setSessionid(Sessionid);
		gradescalebean.setScaleid(scaleid);
		gradescalebean.setGradeId(gradeid);
		gradescalebean.setRangeFrom(rangefrom);
		gradescalebean.setRangeTo(rangeto);
		gradescalebean.setCreatedby(createdby);
		
		result = gradescaleQuery.insertGradeSystem(gradescalebean);
			
		if (result > 0) {
			resultword = "GradeScale successfully Inserted";
		} else {
			resultword = "Operation Failed";
		}
		return_file = "./GradeSetting/GradeScaleSettings.jsp";
	} catch (Exception e) {
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

