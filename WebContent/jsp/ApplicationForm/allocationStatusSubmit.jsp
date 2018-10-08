<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String studentAllocationId 	= "";
String statusChange 		= "";


com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();
com.iGrandee.Application.AllocationBean allocationBean = new com.iGrandee.Application.AllocationBean();
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");

	studentAllocationId = request.getParameter("studentallocationid_hidden");
	statusChange = request.getParameter("statuschange");
	
	
	String ipaddress = request.getRemoteAddr();
	
	//if(feestermoperation.equals("insert"))
	
		allocationBean.setStudentallocationid(studentAllocationId);
		allocationBean.setStudentallocationstatus(statusChange);
		allocationBean.setCreatedby(userid);
		allocationBean.setIpaddress(ipaddress);
		allocationBean.setInstituteid(instituteid); 
		rows += applicationQuery.updateStatusAllocation(allocationBean);
		
		if(statusChange.equals("D"))
		{
			op = "Deactivated";
			return_file = request.getContextPath()+"/jsp/ApplicationForm/StudentsAllocatedDeactivatedView.jsp";
		}
		else if(statusChange.equals("T"))
		{
			op = "Trashed";
			return_file = request.getContextPath()+"/jsp/ApplicationForm/StudentsAllocatedTrashView.jsp";
		}
		else if(statusChange.equals("A"))
		{
			op = "Restored";
			return_file = request.getContextPath()+"/jsp/ApplicationForm/StudentsAllocatedView.jsp";
		}
		else if(statusChange.equals("X"))
		{
			op = "Deleted";
			return_file = request.getContextPath()+"/jsp/ApplicationForm/StudentsAllocatedTrashView.jsp";
		}
		
		//return_file = "/jsp/ApplicationForm/ApplicationIssue_Pre1.jsp";
	
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?op="+op+"&result="+rows+"&returnurl="+return_file);

}catch(Exception e){e.printStackTrace();}

%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.applicationForm.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.applicationForm.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="applicationForm" action="" method="post">
<input type="hidden" name="result" value="<%=rows %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="standardpublishid" value="<%=request.getParameter("standardpublishid")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type="hidden" name="req_sectionpubid" value="<%=request.getParameter("req_sectionpubid")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus") %>">

<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="message" value="Allocation Successfully <%=op%>">
</form>
</body>
</html>
