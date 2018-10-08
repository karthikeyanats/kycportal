<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String studentAllocationId 	= "";
String secSchedId 			= "";



com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();
com.iGrandee.Application.AllocationBean allocationBean = new com.iGrandee.Application.AllocationBean();
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	studentAllocationId = request.getParameter("studentallocationid");
	secSchedId=request.getParameter("sectionSchedId");
	String ipaddress = request.getRemoteAddr();
	
	int sectionSchedId = Integer.parseInt(secSchedId);
	//if(feestermoperation.equals("insert"))
	
		allocationBean.setStudentallocationid(studentAllocationId);
		allocationBean.setSectionscheduleid(sectionSchedId); 
		allocationBean.setCreatedby(userid);
		allocationBean.setIpaddress(ipaddress);
		allocationBean.setInstituteid(instituteid);
		rows += applicationQuery.updateAllocation(allocationBean);
		if(rows>0)
			op = "Allocation Updated Successfully";
		else
			op = "Allocation Updation Failed";
		return_file = request.getContextPath()+"/jsp/ApplicationForm/StudentsAllocated.jsp";
	
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?op="+op+"&result="+rows+"&returnurl="+return_file);
//	response.sendRedirect(request.getContextPath()+"/jsp/Opreation_result_withrequest.jsp?op="+op+"&result="+rows+"&returnurl="+return_file);	
	

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
<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
<input type="hidden" name="standardpublishid" value="<%=secSchedId%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus") %>">

<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="message" value="<%=op%>">

</form>
</body>
</html>
