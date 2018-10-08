		<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery" %>
		<%
		String departid=request.getParameter("departmentid");
		//System.out.println("departid===========>>>>"+departid);

		String ipaddress  = request.getRemoteHost();
		String Staffid=request.getParameter("Staffid");
		String roleid=request.getParameter("user_role");
		String categoryid=request.getParameter("user_post");

		String departmentid=request.getParameter("user_department");

		String Status=request.getParameter("Promotion");
		String userid=(String)session.getValue("userid");
		String Staffuserid=request.getParameter("Staffuserid");

		
		//System.out.println("ipaddress===========>>>>"+ipaddress);
		//System.out.println("Staffid===========>>>>"+Staffid);
		//System.out.println("roleid===========>>>>"+roleid);
		//System.out.println("Status===========>>>>"+Status);
		//System.out.println("userid===========>>>>"+userid);
		//System.out.println("departmentid===========>>>>"+departmentid);

		StaffRegistrationQuery gen_query=new StaffRegistrationQuery();
		String resultword="";
		int result=gen_query.Staffprmotionupdate(Staffid,departmentid,ipaddress,userid,roleid,Status,categoryid,Staffuserid);
		//System.out.println("result===========>>>>"+result); 
		if(result>0)
		{
			resultword="Staff Successfully Promoted";
		}
		else
		{
			resultword="Operation Failed";
		}
		String return_file ="./Registration/StaffpromotionPreviewView.jsp";

			%>
<html>
<head>
<script language="javascript">
function loadResult()
{
	document.submitgradeform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.submitgradeform.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="submitgradeform" action="" method="post">

<input type="hidden" name="Staffid" value="<%=Staffid%>"/>
<input type="hidden" name="roleid" value="<%=roleid%>"/>

<input type="hidden" name="departmentid" value="<%=departid%>"/>
<input type="hidden" name="Status" value="<%=Status%>"/>
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=resultword%>">
</form>
</body>
</html>