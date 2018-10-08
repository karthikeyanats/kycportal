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
		  String Staffid = null;

		  String personid = null;
		  String street = null;
		  String street2 = null;

	      String city = null;
	      String state = null;
	      String country = null;
	      String zipcode = null;
	      String permanentstreet = null;
	      String permanentstreet2 = null;

	      String permanentcity = null;
	      String permanentstate = null;
	      String permanentcountry = null;
	      String permanentzipcode = null;
	      String landlinenumber = null;
	      String mobilenumber = null;

	      String emailid = null;
	      
	      personid = request.getParameter("personid");
	       landlinenumber = request.getParameter("landline");
	       emailid = request.getParameter("email");
	       street = request.getParameter("AddressForCommunication");
	       street2 = request.getParameter("street2");

	       city = request.getParameter("communicationcity");
	       state = request.getParameter("hiddencommunicationstate");
	       country = request.getParameter("hiddencommunicationcountry");
	       zipcode = request.getParameter("communicationpin");
	       
	       permanentstreet = request.getParameter("permanent");
	       //System.out.println("=======>>>>state"+state);
	       permanentstreet2 = request.getParameter("permanentstreet2");

	       permanentcity = request.getParameter("permanentcity");
	       permanentstate = request.getParameter("hiddenpermanentstate");

	       permanentcountry = request.getParameter("hiddenpermanentcountry");
	       permanentzipcode = request.getParameter("permanentpin");
	       mobilenumber = request.getParameter("mobileno");
	       Staffid = request.getParameter("Staffid");
	       gen_qu.setMobile(mobilenumber);
	       gen_qu.setPhone(landlinenumber);
	        gen_qu.setEMail(emailid);
	        gen_qu.setStreet1(street);
	        gen_qu.setStreet2(street2);
	        gen_qu.setCity(city);
	       gen_qu.setState(state);
	       gen_qu.setCountry(country);
	       gen_qu.setZipCode(zipcode);
	        gen_qu.setpermanentStreet1(permanentstreet);
	        gen_qu.setpermanentStreet2(permanentstreet2);
	       gen_qu.setpermanentCity(permanentcity);
		    //System.out.println("=======>>>>permanentstatepermanentstate"+ permanentstate);
	        gen_qu.setpermanentState(permanentstate);
		   // System.out.println("=======>>>>permanentstate"+ gen_qu.getpermanentState());

	       gen_qu.setpermanentCountry(permanentcountry);
	       gen_qu.setpermanentZipCode(permanentzipcode);
	       gen_qu.setPersonId(personid);
	       String smsmobile = request.getParameter("smscontactno");
			gen_qu.setSmsmobile(smsmobile);
	       %>
		      <input type="hidden" name="Staffid" value="<%=Staffid%>" />
		      <%
	        int result=gen_query.Staffpersonalcontactupdate(gen_qu); 
			//System.out.println("result===========>>>>"+result);
			String return_file = "./Registration/Staffcontactprofileupdate.jsp";
			String resultword="";
if(result>0)
	{
		resultword="Contact Details Successfully Updated";
	}
else
	{
		resultword="Operation Failed";

	}
		%>
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/> 
			</form>
	</body>
</html>

