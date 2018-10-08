<html>
<head>
<script>

</script>
</head>
<body>
<form name="University" method="post" action="">
<%@page import="com.iGrandee.Registration.InstitutionQurey"%>
<%@page import="com.iGrandee.Registration.InstitutionBean"%>
<%@ page import="com.iGrandee.Registration.InstitutionUpload" %>
<%
InstitutionUpload institutedetails = new InstitutionUpload(request);
InstitutionBean beanobj = new InstitutionBean();
InstitutionQurey registration =new InstitutionQurey();
String photo=institutedetails.startProcessbystring();


String instituteid= institutedetails.getParameter("instituteid");
   String   hiddenphoto = institutedetails.getParameter("studuserphoto");
String txt_school_name 				= institutedetails.getParameter("txt_school_name");

String txt_street1    				= institutedetails.getParameter("txt_street1");
String txt_city 					= institutedetails.getParameter("txt_city");
String slt_country   				= institutedetails.getParameter("slt_country");
String txt_zip  					= institutedetails.getParameter("txt_zip");

String slt_state     				= institutedetails.getParameter("slt_state");
String txt_contact   				= institutedetails.getParameter("txt_contact");
String txt_mail     				= institutedetails.getParameter("txt_mail");
String txt_web       				= institutedetails.getParameter("txt_web");

String txt_street_admin    			= institutedetails.getParameter("txt_street_admin");
String txt_city_admin      			= institutedetails.getParameter("txt_city_admin");
String mobileno      			= institutedetails.getParameter("txt_mobile");

String hid_photo      				= institutedetails.getParameter("hid_photo");
String ipaddress      				= request.getRemoteHost();
String txt_fax      				= institutedetails.getParameter("txt_fax");



beanobj.setinstitutionid(instituteid);
beanobj.setSchool_name(txt_school_name);
beanobj.settxt_street1(txt_street1);
beanobj.settxt_city(txt_city);
beanobj.settxt_zip(txt_zip);
beanobj.setslt_country(slt_country);
beanobj.setslt_state(slt_state);
beanobj.settxt_contact(txt_contact);
beanobj.settxt_mail(txt_mail);
beanobj.settxt_web(txt_web);
beanobj.settxt_mobile(mobileno);
beanobj.settxt_street_admin(txt_street_admin);
beanobj.settxt_city_admin(txt_city_admin);

beanobj.sethid_photo(hid_photo);
beanobj.setipadress(ipaddress);
beanobj.settxt_fax(txt_fax);
if(photo!=null)
{
	beanobj.setPhoto(photo);
}
else
{
	beanobj.setPhoto(hiddenphoto);
}

int result=registration.SchoolInformationUpdate(beanobj);
String message="";
if(result >0)
	message = "Successfully School Information Updated";
else
	message = "School Information Updation  failed";	

	String return_file =request.getContextPath()+"/jsp/Registration/ProfileInfo.jsp";
 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+result+"&returnurl="+return_file);

%>
</form>
</body>
</html>