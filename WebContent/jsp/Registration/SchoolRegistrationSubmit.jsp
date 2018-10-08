<html>
<head>
<script>
function sub(status)
{
/*if(status==1)
{
alert("Successfully Inserted");
}
else if(status==0)
{
alert("Insertion Failed");
}
document.University.action="./SchoolRegistration.jsp";
document.University.submit();*/
}
</script>
</head>
<body>
<form name="University" method="post" action="">
<%@page import="com.iGrandee.Common.DateTime"%>
<%@page import="com.iGrandee.Registration.InstitutionQurey"%>
<%@page import="com.iGrandee.Registration.InstitutionBean"%>
<%@ page import="com.iGrandee.Registration.InstitutionUpload,java.util.HashMap" %>
<%
InstitutionUpload institutedetails = new InstitutionUpload(request);
HashMap photopath=institutedetails.startProcess();

String returnurl="";
String institutionmode      		= institutedetails.getParameter("institutionmode");
if(institutionmode.equals("MA"))
	returnurl=request.getContextPath()+"/jsp/Registration/MasterAdminRegistration.jsp";
else
	returnurl=request.getContextPath()+"/jsp/Registration/SchoolRegistration.jsp";
try{
InstitutionBean beanobj = new InstitutionBean();
InstitutionQurey registration =new InstitutionQurey();
DateTime dateobj=new DateTime();
String txt_school_name 				= institutedetails.getParameter("txt_school_name");
String txt_street1    				= institutedetails.getParameter("txt_street1");
String txt_street2  				= institutedetails.getParameter("txt_street2");
String txt_city 					= institutedetails.getParameter("txt_city");
String slt_country   				= institutedetails.getParameter("slt_country");
String slt_state     				= institutedetails.getParameter("slt_state");
String txt_zip       				= institutedetails.getParameter("txt_zip");
String txt_contact   				= institutedetails.getParameter("txt_contact");
String txt_mail     				= institutedetails.getParameter("txt_mail");
String txt_web       				= institutedetails.getParameter("txt_web");
String txt_fname      				= institutedetails.getParameter("txt_fname");
String txt_mname      				= institutedetails.getParameter("txt_mname");
String txt_lname      				= institutedetails.getParameter("txt_lname");
String slt_prefix      				= institutedetails.getParameter("slt_prefix");
String txt_street_admin    			= institutedetails.getParameter("txt_street_admin");
String txt_city_admin      			= institutedetails.getParameter("txt_city_admin");
String slt_country_admin   			= institutedetails.getParameter("slt_country_admin");
String slt_state_admin     			= institutedetails.getParameter("slt_state_admin");
String txt_zip_admin       			= institutedetails.getParameter("txt_zip_admin");
String txt_contact_admin   			= institutedetails.getParameter("txt_contact_admin");
String txt_mail_admin     			= institutedetails.getParameter("txt_mail_admin");
String txt_dob         				= institutedetails.getParameter("txt_dob");
String slt_sex         				= institutedetails.getParameter("slt_sex");
String txt_qualification       	 	= institutedetails.getParameter("txt_qualification");
String txt_username       			= institutedetails.getParameter("txt_username");
String txt_passward    				= institutedetails.getParameter("txt_passward");
String slt_hint        				= institutedetails.getParameter("slt_hint");
String txt_answer      				= institutedetails.getParameter("txt_answer");
String hid_photo1      				= institutedetails.getParameter("hid_photo1");
String hid_photo2      				= institutedetails.getParameter("hid_photo2");

String txt_mobile_admin      		= institutedetails.getParameter("txt_mobile_admin");
String ipaddress      				= request.getRemoteHost();
String txt_mobile      				= institutedetails.getParameter("txt_mobile");
String txt_fax      				= institutedetails.getParameter("txt_fax");
String age      				= institutedetails.getParameter("age");
String currencytype				= "-";//institutedetails.getParameter("currencytype");

String dob=dateobj.getMySQLFormat(txt_dob)+"";
//System.out.println(dob);
beanobj.setAge(age);
beanobj.setCurrencytype(currencytype);
beanobj.setSchool_name(txt_school_name);
beanobj.settxt_street1(txt_street1);
beanobj.settxt_street2(txt_street2);
beanobj.settxt_city(txt_city);
beanobj.setslt_country(slt_country);
beanobj.setslt_state(slt_state);
beanobj.settxt_zip(txt_zip);
beanobj.settxt_contact(txt_contact);
beanobj.settxt_mail(txt_mail);
beanobj.settxt_web(txt_web);
beanobj.settxt_fname(txt_fname);
beanobj.settxt_mname(txt_mname);
beanobj.settxt_lname(txt_lname);
beanobj.setslt_prefix(slt_prefix);
beanobj.settxt_street_admin(txt_street_admin);
beanobj.settxt_city_admin(txt_city_admin);
beanobj.setslt_country_admin(slt_country_admin);
beanobj.setslt_state_admin(slt_state_admin);
beanobj.settxt_mail_admin(txt_mail_admin);
beanobj.settxt_mobile_admin(txt_mobile_admin);
beanobj.settxt_zip_admin(txt_zip_admin);
beanobj.settxt_contact_admin(txt_contact_admin);
beanobj.settxt_dob(dob);
beanobj.setslt_sex(slt_sex);
beanobj.settxt_qualification(txt_qualification);
beanobj.settxt_username(txt_username);
beanobj.settxt_answer(txt_answer);
beanobj.setslt_hint(slt_hint);
beanobj.settxt_passward(txt_passward);
beanobj.sethid_photo(hid_photo1);
beanobj.setHid_photo2(hid_photo2);

beanobj.setipadress(ipaddress);
beanobj.settxt_mobile(txt_mobile);
beanobj.settxt_fax(txt_fax);
beanobj.setinstitutionmode(institutionmode);
int result=0;
result=registration.SchoolRegistration(beanobj);
String resultword="";
if(result ==1000)
{
	
}
else if(result >0)
{
	if(institutionmode.equals("MA"))
	resultword="Master Admin Successfully Registered";
	else
		resultword="School Successfully Registered";
}
else
{
	resultword="Operation Failed";
}

	response.sendRedirect(request.getContextPath()+"/jsp/Registration/Operation_Result.jsp?message="+resultword+"&result="+result+"&returnurl="+returnurl);


	//response.sendRedirect("./Operation_Result.jsp?message="+resultword+"&result="+result+"&returnurl="+returnurl);
}
catch(Exception e)
{
	e.printStackTrace();
	response.sendRedirect(request.getContextPath()+"/jsp/Registration/Operation_Result.jsp?message=Opertion Failed&result=0&returnurl="+returnurl);
}
%>
</form>
</body>
</html>