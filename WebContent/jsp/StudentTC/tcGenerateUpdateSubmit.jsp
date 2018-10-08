<%@ page import="java.util.ArrayList,java.util.HashMap"%>

<%
String instituteid = null;
String userid = null;
int rows = 0;
String return_file = "";
String op = "";

String allocationId		 	= "";
String tcIssuedId		 	= "";
String reason 				= 	"";
String tcIssueDate			=	"";


com.iGrandee.TCGeneration.TCGenerationQuery  tcGenerationQuery = new com.iGrandee.TCGeneration.TCGenerationQuery();
com.iGrandee.TCGeneration.TCGenerationBean tcGenerationBean = new com.iGrandee.TCGeneration.TCGenerationBean();
try
{
	instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	String ipaddress = request.getRemoteHost();
	
	allocationId 			= 	request.getParameter("studentallocationid_hidden");
	tcIssuedId				= 	request.getParameter("tcissueid_hidden");
	reason					=  	request.getParameter("Reason");
	tcIssueDate				=  	request.getParameter("tcIssueDate");
	//String ipaddress = request.getLocalAddr();
	//System.out.println("tcIssueDate-->"+tcIssueDate);
	int studentallocationId = Integer.parseInt(allocationId);
	int tcIssueId = Integer.parseInt(tcIssuedId);
	//System.out.println("tcIssueDate-->"+tcIssueDate+"reason-->"+reason);
	int createdby			= Integer.parseInt(userid);
	//System.out.println("tcIssueId-->"+tcIssueId+"createdby-->"+createdby);
		tcGenerationBean.setTcissueid(tcIssueId);
		tcGenerationBean.setReason(reason);
		tcGenerationBean.setTcissuedate(tcIssueDate);
		tcGenerationBean.setCreatedby(createdby);
		tcGenerationBean.setIpaddress(ipaddress);

		rows += tcGenerationQuery.updateTCGeneration(tcGenerationBean);
		
		if(rows>0)
			op 	= 	"TC Details Updated Successfully";
		else
			op	=	"TC Updation Failed";
		
		return_file = request.getContextPath()+"/jsp/StudentTC/TCGenerateList.jsp";
	
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
