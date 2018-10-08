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
	String[] exmallotid=null;
	String publishStatus = request.getParameter("status");
	String scheduleStatus = null;
	
	if(publishStatus.equals("A")){
		scheduleStatus	= "A";
	}
	if(publishStatus.equals("T")){
		scheduleStatus	= "P";
	}
	if(publishStatus.equals("X")){
		scheduleStatus	= "P";
	}
		
try{	
		checkstandard= request.getParameterValues("checkstandard");
		exmallotid=request.getParameterValues("exallotid");
		//System.out.println("checkstandard>>>"+checkstandard[0]);
		String allotedby 		=	(String)session.getValue("userid");
		//System.out.println(checkstandard+"--"+exmallotid+"--"+status);
		//result					= schedule.updatePublishExam(checkstandard,exmallotid);
		result					= schedule.updateStatusForExamPublish(checkstandard,exmallotid,publishStatus,scheduleStatus);
		
		if(result >0){
			if(publishStatus.equals("A")){
				op	= "Published Subject(s) Successfully Restored.";
				return_file = request.getContextPath()+"/jsp/Principal/ExamSchedulePublishView.jsp";
			}
			if(publishStatus.equals("T")){
				op	= "Published Subject(s) Successfully Trashed.";
				return_file = request.getContextPath()+"/jsp/Principal/ExamPublishTrash.jsp";
			}
			if(publishStatus.equals("X")){
				op	= "Published Subject(s) Successfully Deleted.";
				return_file = request.getContextPath()+"/jsp/Principal/ExamPublishTrashView.jsp";
			}
			
		}
		else{
			if(publishStatus.equals("A")){
				op	= "Published Subject(s) Unable to Restore.";
				return_file = request.getContextPath()+"/jsp/Principal/ExamSchedulePublishView.jsp";
			}
			if(publishStatus.equals("T")){
				op	= "Published Subject(s) Unable to Trash.";
				return_file = request.getContextPath()+"/jsp/Principal/ExamPublishTrash.jsp";
			}
			if(publishStatus.equals("X")){
				op	= "Published Subject(s) Unable to Delete.";
				return_file = request.getContextPath()+"/jsp/Principal/ExamPublishTrashView.jsp";
			}
		}
		
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