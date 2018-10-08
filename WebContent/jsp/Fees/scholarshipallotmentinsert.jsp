<jsp:useBean id="query_object" scope="page" class="com.iGrandee.MasterEntries.Standard.StandardQuery" />
<jsp:useBean id="allotmentbean" scope="page" class="com.iGrandee.Fees.Allotmentbean" />
<%
String message			= "";
int result = 0;
String return_file		=  "";
try
{
	
	allotmentbean.setStandardscheduleid(request.getParameterValues("standardscheduleid"));
	allotmentbean.setAmount(request.getParameterValues("amount"));
	allotmentbean.setScholarshipid(request.getParameter("scholarship"));
	allotmentbean.setTermfeesid(request.getParameterValues("termfees"));
	allotmentbean.setAmountallocationstatus("A");
	allotmentbean.setCreatedby((String)session.getAttribute("userid"));

	result				= query_object.insertscholarshipallotment(allotmentbean);
	 return_file		= request.getContextPath()+"/jsp/Fees/scholarshipallotment.jsp";
	if(result >0)
		message				= "Scholarship Allotment Successfully Inserted";
	else
		message				= "Scholarship Allotment Failed";
	

}catch(Exception e){e.printStackTrace();}
%>
<html>
<head>

<script type="text/javascript">

function loadResult()
{
	document.submitlessonform.action	= "<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.submitlessonform.submit();
}

</script>
</head>
<body onload="loadResult()">
<form name="submitlessonform" action="" method="post">

	<input type="hidden" name="result" 			value="<%=result%>">
   	<input type="hidden" name="returnurl" 		value="<%=return_file%>">
   	<input type="hidden" name="message" 		value="<%=message%>">
   	
	<input type="hidden" name="academicyear" 	value="<%=request.getParameter("academicyear")%>">
   	<input type="hidden" name="standard_board" 	value="<%=request.getParameter("standard_board")%>">
   	<input type="hidden" name="scholarship" 	value="<%=request.getParameter("scholarship")%>">
   	
</form>
</body>
</html>