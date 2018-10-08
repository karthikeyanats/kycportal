<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String tcIssuedId		 	= "";
String statusChange 	= "";

com.iGrandee.TCGeneration.TCGenerationQuery  tcGenerationQuery = new com.iGrandee.TCGeneration.TCGenerationQuery();
com.iGrandee.TCGeneration.TCGenerationBean tcGenerationBean = new com.iGrandee.TCGeneration.TCGenerationBean();
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	String ipaddress = request.getRemoteHost();
	
	tcIssuedId				= 	request.getParameter("tcissueid_hidden");
	statusChange 			= 	request.getParameter("statuschange");
	//String ipaddress = request.getLocalAddr();
	int tcIssueId = Integer.parseInt(tcIssuedId);
	int createdby			= Integer.parseInt(userid);
		
		tcGenerationBean.setTcissueid(tcIssueId);
		tcGenerationBean.setTcissuestatus(statusChange);		
		tcGenerationBean.setCreatedby(createdby);
		tcGenerationBean.setIpaddress(ipaddress);

		rows += tcGenerationQuery.updateStatusTCGeneration(tcGenerationBean);
		
		if(rows>0)
		{
			if(statusChange.equals("D"))
			{
				op = "TC Details Deactivated Successfully";
				return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateDeactivatedList.jsp";
			}
			else if(statusChange.equals("T"))
			{
				op = "TC Details Successfully Trashed";
				return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateTrashList.jsp";
			}
			else if(statusChange.equals("A"))
			{
				op = "TC Details Successfully Activated";
				return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateList.jsp";
			}
			else if(statusChange.equals("X"))
			{
				op = "TC Details Successfully Deleted";
				return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateTrashList.jsp";
			}
		}
		else
		{
			if(statusChange.equals("D"))
			{
				op = "TC Details Deactivation Failed";
				return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateDeactivatedList.jsp";
			}
			else if(statusChange.equals("T"))
			{
				op = "Trashing TC Details Failed";
				return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateTrashList.jsp";
			}
			else if(statusChange.equals("A"))
			{
				op = "TC Details Activation Failed";
				return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateList.jsp";
			}
			else if(statusChange.equals("X"))
			{
				op = "TC Details Deletion Failed";
				return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateTrashList.jsp";
			}
		}
		
		//return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateList.jsp";
	
	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?op="+op+"&result="+rows+"&returnurl="+return_file);
//	response.sendRedirect(request.getContextPath()+"/jsp/Opreation_result_withrequest.jsp?op="+op+"&result="+rows+"&returnurl="+return_file);	
	

}catch(Exception e){e.printStackTrace();}

%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	//document.applicationForm.action="<%=request.getContextPath()%>/jsp/Operation_Result.jsp";
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
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="standardnamegp" value="<%=request.getParameter("standardnamegp")%>">
<input type="hidden" name="req_sectionpubid" value="<%=request.getParameter("req_sectionpubid")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="op" value="<%=op%>">
<input type="hidden" name="message" value="<%=op%>">

</form>
</body>
</html>
