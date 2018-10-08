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
<%@ page language="java" %>
<%@ page import="com.iGrandee.Login.LoginAction,com.iGrandee.Password.PasswordQuery" %>
<%
LoginAction loginobj=new LoginAction();
PasswordQuery passwdquery=new PasswordQuery();

String oldpassword = "";
String newpassword = "";
String confirmpassword = "";
String username = "";
int cnt = 0;
int	passflag =0;
try
{
	oldpassword  = request.getParameter("oldpassword");
	newpassword  = request.getParameter("newpassword");
	confirmpassword  = request.getParameter("confirmpassword");
	username = session.getValue("username").toString();

	passflag =  loginobj.checkPassword(username,oldpassword);
	if(passflag>1)
	{
		cnt = passwdquery.updateChangePassword(username,confirmpassword);
	}
}catch(Exception e){
	//System.out.println("Exception in Submit Password"+e.getMessage());
}



%>
		<%
		int result=1;
		String return_file = "";
		String resultword = "";

		if(passflag >1)
		{
			if(cnt>0)
			{
			resultword="User Password Successfully Changed";
			}
			else
			{
			resultword="Operation Failed";
			}
			 return_file = "./Staff/changepasswd.jsp";

		}
		else
		{
			resultword="Entered Wrong Old Password";
			 return_file = "./Staff/oldpassword.jsp";

		}
		%>
<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="result" value="<%=cnt %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">			
			</form>
	</body>
</html>

