<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String applicationId 	= "";
String statusChange 	= "";


com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();
com.iGrandee.Application.ApplicationBean applicationBean = new com.iGrandee.Application.ApplicationBean();
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");

	applicationId = request.getParameter("applicationid_hidden");
	statusChange = request.getParameter("statuschange");
	
	
	String ipaddress = request.getRemoteAddr();
	
	//if(feestermoperation.equals("insert"))
	
		applicationBean.setApplicationid(applicationId);
		applicationBean.setStatus(statusChange);
		applicationBean.setCreatedby(userid);
		applicationBean.setIpaddress(ipaddress);
		applicationBean.setInstituteid(instituteid);
		rows += applicationQuery.updateStatusApplication(applicationBean);
		if(rows>0)
		{
			if(statusChange.equals("D"))
			{
				op = "Application Deactivated Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationDeactivatedView.jsp";
			}
			else if(statusChange.equals("T"))
			{
				op = "Application Trashed Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationTrashView.jsp";
			}
			else if(statusChange.equals("A"))
			{
				if(request.getParameter("statuschangeval").equals("Restore"))
					op = "Application Restored Successfully";
				else if(request.getParameter("statuschangeval").equals("Activate"))
					op = "Application Activated Successfully";
				
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationIssueView.jsp";
			}
			else if(statusChange.equals("X"))
			{
				op = "Application Deleted Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationTrashView.jsp";
			}
		}
		else
		{
			if(statusChange.equals("D"))
			{
				op = "Application Deactivation Failed";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationDeactivatedView.jsp";
			}
			else if(statusChange.equals("T"))
			{
				op = "Trashing Application Failed";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationTrashView.jsp";
			}
			else if(statusChange.equals("A"))
			{
				op = "Application Activation Failed";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationIssueView.jsp";
			}
			else if(statusChange.equals("X"))
			{
				op = "Application Deletion Failed";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApplicationTrashView.jsp";
			}
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
<input type="hidden" name="req_boardid" value="<%=request.getParameter("req_boardid")%>">
<input type="hidden" name="standardpublishid" value="<%=request.getParameter("standardpublishid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus") %>">
<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="message" value="<%=op%>">
</form>
</body>
</html>
