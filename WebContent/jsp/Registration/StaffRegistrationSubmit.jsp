<%@ page language="java" %>
<%@ page import="com.iGrandee.Registration.StaffRegistrationUpload" %>
<%@ page import="com.iGrandee.Registration.StaffRegistrationBean" %>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery" %>
<%@ page import="com.iGrandee.Common.DateTime" %>
<% 
String firstname = "";
String midname = "";
String lastname = "";
String photo="";
String gender = "";
String mstatus = "";
String dob = "";

String street1 = "";
String street2 = "";
String city = "";
String state = "";
String country = "";
String zipcode = "";

String permanentstreet1 = "";
String permanentstreet2 = "";
String permanentcity = "";
String permanentstate = "";
String permanentcountry = "";
String permanentzipcode = "";

String major[] = null;
String user_qualification[] = null;
String Yearofgrad[] = null;
String marks[] = null;
String institutename[] = null;
String instituid = "";
instituid=(String)session.getValue("instituteid");
String sessionuserid = "";
sessionuserid=(String)session.getValue("userid");
DateTime dateobj=new DateTime();
StaffRegistrationQuery gen_query=new StaffRegistrationQuery();
%>
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
		<%
		StaffRegistrationBean	gen_qu=new StaffRegistrationBean();
		gen_qu=(StaffRegistrationBean)session.getAttribute("detailobj");
		//out.println("===="+gen_qu.getDOB());  
		int result=gen_query.StaffRegistration(gen_qu);  
		session.removeAttribute("detailobj");
		 String return_file = "./Registration/Staff_registration.jsp";
		 String resultword="";
		 if(result ==1000){
				resultword="The Following Username Already Exists :"+gen_qu.getUserName();
				result=0;
			}
		 else if(result >0){
				resultword="Staff Successfully Registered";
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

