<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String registrationId 	= "";
String statusChange 	= "";


com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
com.iGrandee.Application.RegistrationBean registrationBean = new com.iGrandee.Application.RegistrationBean();try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");

	registrationId = request.getParameter("registrationid_hidden");
	statusChange = request.getParameter("statuschange");
	
	
	String ipaddress = request.getRemoteAddr();
	
	//if(feestermoperation.equals("insert"))
	
		registrationBean.setRegistrationid(registrationId);
		registrationBean.setStatus(statusChange);
		registrationBean.setCreatedby(userid);
		registrationBean.setIpaddress(ipaddress);
		registrationBean.setInstituteid(instituteid);
		rows += registrationQuery.updateStatusRegistration(registrationBean);
		
		if(rows>0)
		{
			if(statusChange.equals("D"))
			{
				op = "Admission Deactivated Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/RegistrationDeactivatedView.jsp";
			}
			else if(statusChange.equals("T"))
			{
				op = "Admission Trashed Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/RegistrationTrashView.jsp";
			}
			else if(statusChange.equals("A"))
			{
				if(request.getParameter("statuschangeval").equals("Restore"))
					op = "Admission Restored Successfully";
				else if(request.getParameter("statuschangeval").equals("Activate"))
					op = "Admission Activated Successfully";

				return_file = request.getContextPath()+"/jsp/ApplicationForm/RegistrationView.jsp";
			}
			else if(statusChange.equals("X"))
			{
				op = "Admission Deleted Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/RegistrationTrashView.jsp";
			}
		}
		else
		{
			if(statusChange.equals("D"))
			{
				op = "Admission Deactivation Failed";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/RegistrationDeactivatedView.jsp";
			}
			else if(statusChange.equals("T"))
			{
				op = "Trashing Admission Failed";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/RegistrationTrashView.jsp";
			}
			else if(statusChange.equals("A"))
			{
				op = "Admission Activation Failed";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/RegistrationView.jsp";
			}
			else if(statusChange.equals("X"))
			{
				op = "Admission Deletion Failed";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/RegistrationTrashView.jsp";
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
