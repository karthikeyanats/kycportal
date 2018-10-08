<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Exam.ExamAllotment.ExamAllotmentQuery"%>
	
<%
	com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean examAllotmentBean = new com.iGrandee.Exam.ExamAllotment.ExamAllotmentBean();
	ExamAllotmentQuery	examAllotmentQuery	= new ExamAllotmentQuery();

	String op="";
	int result=0;
	String return_file = null;
	//String[] checkstandard=null;
	//String[] examdate=null;
	//String[] starttime=null;
	//String[] endtime=null;
try{
	
		String instituteid		= (String)session.getValue("instituteid");	
		String userid = (String)session.getValue("userid");
	
		String examscheduleId = request.getParameter("examscheduleid_hidden");
		String publishStatus = request.getParameter("statuschange");	
		String ipaddress = request.getRemoteAddr();	
	//if(feestermoperation.equals("insert"))	
		examAllotmentBean.setExamscheduleid(examscheduleId);
		examAllotmentBean.setPublishstatus(publishStatus);
		if(publishStatus.equals("A"))
			examAllotmentBean.setSchedulestatus("A");
		if(publishStatus.equals("X")){
			publishStatus = "A";
			examAllotmentBean.setPublishstatus(publishStatus);
			examAllotmentBean.setSchedulestatus("P");
		}
		//examAllotmentBean.setStatus(statusChange);
		examAllotmentBean.setAllotedby(userid);
		//examAllotmentBean.setIpaddress(ipaddress);
		examAllotmentBean.setInstituteid(instituteid);
		result += examAllotmentQuery.updateStatusPublishExams(examAllotmentBean);
		    
		if(result >0){
			if(request.getParameter("statuschange").equals("A")){
				return_file = request.getContextPath()+"/jsp/Principal/ExamSchedulePublishView.jsp";
				op	= "Published Subject Restored Successfully";
			}
			if(request.getParameter("statuschange").equals("X")){
				return_file = request.getContextPath()+"/jsp/Principal/ExamPublishTrashView.jsp";
				op	= "Published Subject Deleted Successfully";				
			}
		}
		else{
			if(request.getParameter("statuschange").equals("A")){
				op	= "Deleting Published Subject Failed";
				return_file = request.getContextPath()+"/jsp/Principal/ExamSchedulePublishView.jsp";
			}
			if(request.getParameter("statuschange").equals("X")){
				op	= "Restoring Published Subject Failed";
				return_file = request.getContextPath()+"/jsp/Principal/ExamPublishTrashView.jsp";
			}
		}
		
		//return_file = request.getContextPath()+"/jsp/Exam/ExamSchedule/Examschedulecreation.jsp";
		//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+op+"&result="+result+"&returnurl="+return_file);
	}catch(Exception e){}
%>

<html>
<head>
<script language="javascript">
function loadResult()
{
	document.scheduleForm.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.scheduleForm.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="scheduleForm" action="" method="post">
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
<input type="hidden" name="req_standardscheduleid" value="<%=request.getParameter("req_standardscheduleid")%>">
<input type="hidden" name="req_examnameid" value="<%=request.getParameter("req_examnameid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type="hidden" name="req_examname" value="<%=request.getParameter("req_examname")%>">
<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="message" value="<%=op%>">
</form>
</body>
</html>	