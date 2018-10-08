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
<%@ page import="com.iGrandee.Registration.StaffRegistrationBean" %>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery" %>

<%@ page import="com.iGrandee.Common.DateTime" %><% 
String instituid=(String)session.getValue("instituteid");
String sessionuserid = "";
sessionuserid=(String)session.getValue("userid");
DateTime dateobj=new DateTime();
StaffRegistrationBean gen_qu=new StaffRegistrationBean();
StaffRegistrationQuery gen_query=new StaffRegistrationQuery();
%>

		<%
		try{
		  String Staffid = null;
		  String departmentid = null;

		  
		  String personid = null;
		  String documentid []= null;

	      personid = request.getParameter("personid");
	       documentid = request.getParameterValues("documentid");     
	       Staffid = request.getParameter("Staffid");
	       departmentid = request.getParameter("departmentid");

	       %>
	       <input type="hidden" name="Staffid" value="<%=Staffid%>" />
	       <input type="hidden" name="departmentid" value="<%=departmentid%>"/>
	       
	       <%
	         gen_qu.setDocumentid(documentid);   
	        int result=gen_query.Staffverificationcertificatedelete(gen_qu);   
			String return_file = "./Registration/Staffverificationcertificateupdate.jsp";
			String resultword="";
if(result>0)
	{
		resultword="Document Successfully Deleted";
	}
else
	{
		resultword="Operation Failed";

	} %>
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>

		<%}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		%>
			</form>
	</body>
</html>

