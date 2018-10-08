<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String applicationId 	= "";
String applicationNo 	= "";
String applicantName 	= "";
String applicationCost 	= "";
String contactNo 		= "";
String emailId	 		= "";
String stdSchedId 		= "";


com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();
com.iGrandee.Application.ApplicationBean applicationBean = new com.iGrandee.Application.ApplicationBean();
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	applicantName=request.getParameter("applicantName");
	applicationNo=request.getParameter("applicationNo");
	applicationCost=request.getParameter("applicationCost");
	contactNo=request.getParameter("contactno");
	emailId=request.getParameter("emailid");	
	applicationId = request.getParameter("applicationid");
	stdSchedId=request.getParameter("standardpublishid");
	String ipaddress = request.getRemoteAddr();
	
	int standardSchedId = Integer.parseInt(stdSchedId);
	//if(feestermoperation.equals("insert"))
	
		applicationBean.setApplicationid(applicationId);
		applicationBean.setApplicantname(applicantName);
		applicationBean.setApplicationno(applicationNo);
		applicationBean.setApplicationcost(applicationCost);
		applicationBean.setContactno(contactNo);
		applicationBean.setEmailid(emailId);		
		applicationBean.setStandardscheduleid(standardSchedId); 
		applicationBean.setCreatedby(userid);
		applicationBean.setIpaddress(ipaddress);
		applicationBean.setInstituteid(instituteid);
		rows += applicationQuery.updateApplication(applicationBean);
		
		if(rows>0)
			op = "Application Successfully Updated";
		else
			op = "Application Updation Failed";
		
		return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationIssueView.jsp";
	
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
<input type="hidden" name="standardpublishid" value="<%=stdSchedId%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus") %>">
<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="message" value="<%=op%>">

</form>
</body>
</html>
