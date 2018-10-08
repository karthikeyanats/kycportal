<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String studentapprovalId 	= "";
String statusChange 	= "";


com.iGrandee.Application.RegistrationProcess  approvalQuery = new com.iGrandee.Application.RegistrationProcess();
com.iGrandee.Application.ApprovalBean approvalBean = new com.iGrandee.Application.ApprovalBean();try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");

	studentapprovalId = request.getParameter("studentapprovalid_hidden");
	statusChange = request.getParameter("statuschange");
	
	
	String ipaddress = request.getRemoteAddr();
	
	//if(feestermoperation.equals("insert"))
	
		approvalBean.setStudentapprovalid(studentapprovalId);
		approvalBean.setStatus(statusChange);
		approvalBean.setCreatedby(userid);
		approvalBean.setIpaddress(ipaddress);
		approvalBean.setInstituteid(instituteid);
		rows += approvalQuery.updateStatusApproval(approvalBean);
		
		if(rows>0)
		{
			if(statusChange.equals("D"))
			{
				op = "Approval Deactivated Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApproveDeactivatedView.jsp";
			}
			else if(statusChange.equals("T"))
			{
				op = "Approval Trashed Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApproveTrashView.jsp";
			}
			else if(statusChange.equals("A"))
			{
				if(request.getParameter("statuschangeval").equals("Restore"))
					op = "Approval Restored Successfully";
				else if(request.getParameter("statuschangeval").equals("Activate"))
					op = "Approval Activated Successfully";

				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApproveView.jsp";
			}
			else if(statusChange.equals("X"))
			{
				op = "Approval Deleted Successfully";
				return_file = request.getContextPath()+"/jsp/ApplicationForm/ApproveTrashView.jsp";
			}
		}
		else
		{
				if(statusChange.equals("D"))
				{
					op = "Approval Deactivation Failed";
					return_file = request.getContextPath()+"/jsp/ApplicationForm/ApproveDeactivatedView.jsp";
				}
				else if(statusChange.equals("T"))
				{
					op = "Trashing Approval Failed";
					return_file = request.getContextPath()+"/jsp/ApplicationForm/ApproveTrashView.jsp";
				}
				else if(statusChange.equals("A"))
				{
					op = "Approval Activation Failed";
					return_file = request.getContextPath()+"/jsp/ApplicationForm/ApproveView.jsp";
				}
				else if(statusChange.equals("X"))
				{
					op = "Approval Deletion Failed";
					return_file = request.getContextPath()+"/jsp/ApplicationForm/ApproveTrashView.jsp";
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
