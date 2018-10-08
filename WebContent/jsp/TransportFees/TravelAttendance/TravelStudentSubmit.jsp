<%@page import="com.iGrandee.TransportFees.TravelAttendance.TransportAttendanceAction"%>
<%@page import="com.iGrandee.TransportFees.TravelAttendance.TransportAttendance"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean,com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>

<%
/* com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery  ExamAllotmentQuery = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery();
com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean ExamAllotmentBean = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean(); */

com.iGrandee.TransportFees.TravelAttendance.TransportAttendance TransportAttendance = new com.iGrandee.TransportFees.TravelAttendance.TransportAttendance();
com.iGrandee.TransportFees.TravelAttendance.TransportAttendanceAction TransportAttendanceAction = new com.iGrandee.TransportFees.TravelAttendance.TransportAttendanceAction();

String instituteid = null;
String studentstageallocationid = "";
String studentapprovalidid = "";
String transportcategoryid = "";
String createdby = "";
int no_of_rows= 0 ;
String op = "";
String return_file = null;
int result = 0;
try
{
	instituteid = (String)session.getValue("instituteid");
	//System.out.println("instituteid>>>"+instituteid);
	createdby = (String)session.getValue("userid");
	//System.out.println("allotedby>>>"+allotedby);
	transportcategoryid = request.getParameter("transportcategoryid");
	System.out.println("transportcategoryid>>>"+transportcategoryid);
	//String statusflag 			= request.getParameter("statusflag");
	
	String[] chkBoxId=null;
	chkBoxId= request.getParameterValues("chkid");
	System.out.println("chkBoxId>>>"+chkBoxId);
	//result = ExamAllotmentQuery.insertExamAllotment(examnameid,chkBoxId,allotedby,instituteid);
	result = TransportAttendanceAction.inserttransportattendance(transportcategoryid,chkBoxId,createdby);
	//System.out.println("result>>>"+result);
	
	if(result>0)
		op="Student Travel Attendance Inserted Successfully";
	else
		op="Student Travel Attendance Failed";

	return_file = request.getContextPath()+"/jsp/TransportFees/TravelAttendance/TravelStudentView.jsp";
	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	


		
}catch(Exception e){}	
	
	
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

	<input type="hidden" name="message" value="<%=op%>"/>  
	<input type="hidden" name="result" value="<%=result%>"/>
	<input type="hidden" name="returnurl" value="<%=return_file%>"/>
	<input type="hidden" name="transportcategoryid" value="<%=request.getParameter("transportcategoryid")%>"/> 
	
	
	          
<%

if(request.getParameter("transportcategoryid")!=null){
	out.println("<input type='hidden' name='transportcategoryid' value='"+request.getParameter("transportcategoryid")+"'/>");
	
}	

if(request.getParameter("sessionid")!=null){
	out.println("<input type='hidden' name='sessionid' value='"+request.getParameter("sessionid")+"'/>");
	
}	


if(request.getParameter("transportrouteid")!=null){
	
	out.println("<input type='hidden' name='transportrouteid' value='"+request.getParameter("transportrouteid")+"'/>");
}

if(request.getParameter("transportfeestypename")!=null){
	
	out.println("<input type='hidden' name='transportfeestypename' value='"+request.getParameter("transportfeestypename")+"'/>");
}

if(request.getParameter("transportfeestypeid")!=null){
	
	out.println("<input type='hidden' name='transportfeestypeid' value='"+request.getParameter("transportfeestypeid")+"'/>");
}
	
%>	 
</form>
</body>

</html>
