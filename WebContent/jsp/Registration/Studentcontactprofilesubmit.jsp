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
<%@ page import="com.iGrandee.Registration.StudentRegistrationBean" %>
<%@ page import="com.iGrandee.Registration.StudentRegistrationQuery" %>

<%@ page import="com.iGrandee.Common.DateTime" %>

<% 

String instituid=(String)session.getValue("instituteid");
String sessionuserid = "";
sessionuserid=(String)session.getValue("userid");
DateTime dateobj=new DateTime();
StudentRegistrationBean gen_qu=new StudentRegistrationBean();
StudentRegistrationQuery gen_query=new StudentRegistrationQuery();
%>

		<%
		  String userid = null;
		  String street = null;
	      String city = null;
	      String state = null;
	      String country = null;
	      String zipcode = null;
	      String permanentstreet = null;
	      String permanentcity = null;
	      String permanentstate = null;
	      String permanentcountry = null;
	      String permanentzipcode = null;
	      String landlinenumber = null;
	      String emailid = null;
	      
	      userid = request.getParameter("personid");
	      landlinenumber = request.getParameter("telephone");
	      emailid = request.getParameter("email");
	      street = request.getParameter("AddressForCommunication");
	     String street2 = request.getParameter("Communicationstreet2");

	       city = request.getParameter("communicationcity");
	       state = request.getParameter("hiddencommunicationstate");
	       country = request.getParameter("hiddencommunicationcountry");
	       zipcode = request.getParameter("communicationpin");
	       permanentstreet = request.getParameter("permanent");
	     String  permanentstreet2 = request.getParameter("permanentstreet2");

	       permanentcity = request.getParameter("permanentcity");
	       permanentstate = request.getParameter("hiddenpermanentstate");
	       permanentcountry = request.getParameter("hiddenpermanentcountry");
	       permanentzipcode = request.getParameter("permanentpin");
		     String  mobilenumber = request.getParameter("mobileno");
		     String  smscontactno = request.getParameter("smscontactno");

	       gen_qu.setLandlinenumber(landlinenumber);
	       gen_qu.setMobileno(mobilenumber);

	        gen_qu.setEmailid(emailid);
	        gen_qu.setStreet1(street);
	        gen_qu.setStreet2(street2);

	        gen_qu.setCity(city);
	       gen_qu.setState(state);
	       gen_qu.setCountry(country);
	        gen_qu.setZipcode(zipcode);
	        gen_qu.setPermanentstreet1(permanentstreet);
	        gen_qu.setPermanentstreet2(permanentstreet2);

	       gen_qu.setPermanentcity(permanentcity);
	        gen_qu.setPermanentstate(permanentstate);
	       gen_qu.setPermanentcountry(permanentcountry);
	       gen_qu.setPermanentzipcode(permanentzipcode);
	       gen_qu.setSmsContactNo(smscontactno);

	       gen_qu.setUserid(userid);
	       %>
		      <input type="hidden" name="personid" value="<%=userid%>" />
		      <%
	        int result=gen_query.Studentpersonalcontactupdate(gen_qu); 
		      String resultword="";
		      if(result>0)
		      	{
		      		resultword="Contact Details Successfully Updated";

		      	}
		      else
		      	{
		      		resultword="Operation Failed";

		      	}		String return_file = "./Registration/Studentcontactprofileupdate.jsp";

		%>
<input type="hidden" name="studentprofileedit" value="<%=request.getParameter("studentprofileedit")%>">
<input type=hidden   name=session value="<%=request.getParameter("session")%>">
<input type=hidden   name=board value="<%=request.getParameter("board")%>">
<input type=hidden   name=standardscheduleid value="<%=request.getParameter("standardscheduleid")%>">
<input type=hidden   name=sectionscheduleid value="<%=request.getParameter("sectionscheduleid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="req_standardnamegp" value="<%=request.getParameter("req_standardnamegp")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="req_studentname" value="<%=request.getParameter("req_studentname")%>">

<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">	
<input type="hidden" name="message" value="<%=resultword%>">
	
			</form>
	</body>
</html>

