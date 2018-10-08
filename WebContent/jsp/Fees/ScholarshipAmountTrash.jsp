<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />


<%@ page language="java" import="java.util.*"%>
<%

String message			= "";
int result = 0;
String return_file		=  "";
String standardscheduleid = request.getParameter("standard");
String resultword = "";
String scholarshipid = request.getParameter("scholarship");
String userid = (String)session.getAttribute("userid");
String academicyear = request.getParameter("academicyear");



try{
	
	String curstatus = "T";

	//String feestermid = request.getParameter("feestermid1");
	//System.out.println("feestermid===>>>"+feestermid);
	String scholarshipamountallocationid = request.getParameter("scholarshipamountallocationid");
	//System.out.println("scholarshipamountallocationid===>>>"+scholarshipamountallocationid);
	result = query_object.changeFeesscollectionstatus(scholarshipamountallocationid);
	
	if(result >0)
		
		resultword = "Scholarship Amount Successfully DeAllocated";
	else 
		resultword = " Scholarship Amount Deallocation process Failed";	

		return_file =request.getContextPath()+"/jsp/Fees/newallottment1.jsp";
		
	 	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
}
catch(Exception e){
	
	e.printStackTrace();
	
}
	 	

%>
<html>
<head>
<script type="text/javascript">
function go()
{
	document.cat_form.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
    document.cat_form.submit();
}

</script>	
</head>
<body onload="go()">
<form name="cat_form" method="post">

<input type="hidden" name="academicyear" 	value="<%=request.getParameter("academicyear")%>">
   			<input type="hidden" name="standard_board" 	value="<%=request.getParameter("standard_board")%>">
   			<input type="hidden" name="scholarship" 	value="<%=request.getParameter("scholarship")%>">
   			<input type="hidden" name="standard" 	value="<%=standardscheduleid%>">
   			
			<input type="hidden" name="result" value="<%=result %>">
			<input type="hidden" name="message" value="<%=resultword%>">
	<input type="hidden" name="returnurl" value="<%=return_file%>">



</form>
</body>

</html>