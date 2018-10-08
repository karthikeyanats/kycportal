<html>
<head>
<script language="javascript">
function loadResult()
{
	document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.submitlessonform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="submitlessonform" action="" method="post">
		<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery" %>
		<%
		String departid=request.getParameter("departmentid");
		//System.out.println("departid===========>>>>"+departid);

		String ipaddress  = request.getRemoteHost();
		String Staffid=request.getParameter("Staffid");
		String roleid=request.getParameter("roleid");
		String Status=request.getParameter("status");
		String userid=(String)session.getValue("userid");
		//System.out.println("ipaddress===========>>>>"+ipaddress);
		//System.out.println("Staffid===========>>>>"+Staffid);
		//System.out.println("roleid===========>>>>"+roleid);
		//System.out.println("Status===========>>>>"+Status);
		//System.out.println("userid===========>>>>"+userid);

		StaffRegistrationQuery gen_query=new StaffRegistrationQuery();
		%>
		<input type="hidden" name="departmentid" value="<%=departid%>"/>
		<input type="hidden" name="Status" value="<%=Status%>"/>
		<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>
		
		<%
		int result=gen_query.StaffStatusupdate(Staffid,Status,ipaddress,userid,roleid);
	//	System.out.println("result===========>>>>"+result);
		String return_file = "./Registration/Staff_List_View.jsp";
		String resultword = "";
		if(result >0){
			if(Status.equals("T"))
			resultword="Staff Successfully Trashed";
			else if(Status.equals("A"))
				resultword="Staff  Successfully Activated";
			else if(Status.equals("T"))
				resultword="Staff Successfully Trashed";
			else if(Status.equals("D"))
				resultword="Staff Successfully Deactivated";
			else if(Status.equals("X"))
				resultword="Staff Successfully Deleted";
		}
		else
		{
			resultword="operation Failed";
		}
			
		%>

<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">			
			</form>
	</body>
</html>
