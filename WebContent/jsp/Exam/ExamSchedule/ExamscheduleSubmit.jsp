<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>
	
<%
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean ExamAllotmentBean = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean();
	ExamAllotmentQuery	schedule	= new ExamAllotmentQuery();

	String op="";
	int result=0;
	String return_file = null;
	String[] checkstandard=null;
	String[] examdate=null;
	String[] starttime=null;
	String[] endtime=null;
	String[] examtype=null;
try{	
		checkstandard= request.getParameterValues("checkstandard");
		//System.out.println("checkstandard>>>"+checkstandard[0]);
		String sessionid		= request.getParameter("reg_sessionid");
		//System.out.println("res_sessionid>>>"+sessionid);
		String examallotmentid		= request.getParameter("exallotid");
		//System.out.println("res_examallotmentid>>>"+examallotmentid);
		String instituteid		= (String)session.getValue("instituteid");
		ExamAllotmentBean.setInstituteid(instituteid);
		//System.out.println("res_instituteid>>>"+instituteid);
		String userid		= (String)session.getValue("userid");
		//System.out.println("res_userid>>>"+userid);
		 examdate			= request.getParameterValues("examdates");
		//System.out.println("res_examdate>>>"+examdate[0]);
		starttime			= request.getParameterValues("starttime");
		//System.out.println("res_starttime>>>"+starttime[0]);
		 endtime			= request.getParameterValues("endtime");
		 examtype			= request.getParameterValues("examtypename");
		//System.out.println("res_examtype>>>"+examtype[0]);
		String allotedby 		=	(String)session.getValue("userid");
		//System.out.println("allotedby>>>"+allotedby);
		
		result					= schedule.scheduleExams(checkstandard,examallotmentid,allotedby,instituteid,examdate,starttime,endtime,examtype);			
		
		if(result >0)
			op	= "Exam Time Successfully Scheduled";
		else
			op	= "Exam Time Unable to Schedule.";
		
		return_file = request.getContextPath()+"/jsp/Exam/ExamSchedule/ExamScheduleCreate.jsp";
		//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	}catch(Exception e){}
%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.examScheduleForm.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.examScheduleForm.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="examScheduleForm" action="" method="post">
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type=hidden name=req_examnameid value="<%=request.getParameter("req_examnameid")%>">
<input type=hidden name=req_examname  value="<%=request.getParameter("req_examname")%>">
<input type="hidden" name="req_standardscheduleid" value="<%=request.getParameter("req_standardscheduleid")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="message" value="<%=op%>">
</form>
</body>
</html>