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
<form name="submitlessonform" action="" method="post"><%@ page
	language="java"%> <%@ page
	import="com.iGrandee.Registration.StaffRegistrationBean"%>
<%@ page import="com.iGrandee.Registration.StaffRegistrationQuery"%>

<%@ page import="com.iGrandee.Common.DateTime"%>
<%
	String instituid = (String) session.getValue("instituteid");
	String sessionuserid = "";
	sessionuserid = (String) session.getValue("userid");
	DateTime dateobj = new DateTime();
	StaffRegistrationBean gen_qu = new StaffRegistrationBean();
	StaffRegistrationQuery gen_query = new StaffRegistrationQuery();
%> <%
 	String Staffid = null;

 	String personid = null;

 	String major[] = null;
 	String user_qualification[] = null;
 	String Yearofgrad[] = null;
 	String marks[] = null;
 	String institutename[] = null;
 	String deptid = "";
 	String roleid = "";
 	String joiningdate = "";
 	String post = "";
	String departid=request.getParameter("departmentid");

 	personid = request.getParameter("personid");
 	major = request.getParameterValues("major");
 	user_qualification = request.getParameterValues("user_qualification");
 	Yearofgrad = request.getParameterValues("Yearofgrad");
 	marks = request.getParameterValues("marks");
 	institutename = request.getParameterValues("institutename");
 	post = request.getParameter("user_post");
 	deptid = request.getParameter("user_department");
 	roleid = request.getParameter("user_role");
 	joiningdate = request.getParameter("user_joining_date");
 	joiningdate = dateobj.getMySQLFormat(joiningdate) + "";
	String instRole[]	= request.getParameterValues("instituteRole");
	String instPeriod[]	= request.getParameterValues("institutePeriod");
	String areaInterest=request.getParameter("areaOfInterest");
	String publiCations=request.getParameter("publiCations");
    Staffid = request.getParameter("Staffid");
    //System.out.println("Staffid=======>>>>>"+Staffid);
	String ipaddress  = request.getRemoteHost();
	String hiddenqualification[]	= request.getParameterValues("hiddenqualification");
	String staffqualificationid[]	= request.getParameterValues("staffqualificationid");
	String hiddenexperience[]	= request.getParameterValues("hiddenexperience");
	String staffexperienceid[]	= request.getParameterValues("staffexperienceid");
	
	gen_qu.setmajor(major);
	gen_qu.setuser_qualification(user_qualification);
	gen_qu.setYearofgrad(Yearofgrad);
	gen_qu.setmarks(marks);
	gen_qu.setinstitutename(institutename);
	gen_qu.setStaffqualificationid(staffqualificationid);
	gen_qu.setUpdatestatus(hiddenqualification);
	gen_qu.setStaffexperienceid(staffexperienceid);
	gen_qu.setUpdatestatus1(hiddenexperience);
	gen_qu.setPost(post);
	gen_qu.setDepartment(deptid);
	gen_qu.setRole(roleid);
	gen_qu.setJoiningDate(joiningdate);
	gen_qu.setUserId(sessionuserid);
	gen_qu.setinstRole(instRole);
	gen_qu.setinstPeriod(instPeriod);
	
	gen_qu.setAreaOfInterest(areaInterest);
	gen_qu.setPubliCations(publiCations);
	
 	gen_qu.setStaffid(Staffid);

 	gen_qu.setPersonId(personid);
 	gen_qu.setipaddress(ipaddress);

 %> <input type="hidden" name="Staffid" value="<%=Staffid%>" />
 	<input type="hidden" name="departmentid" value="<%=departid%>"/>
 	<input type="hidden" name="deptname" value="<%=request.getParameter("deptname")%>"/>
 
<%
	int result = gen_query.Staffpersonalexperienceupdate(gen_qu);
	//System.out.println("request.getParameter===========>>>>" + request.getParameter("deptname"));
	String return_file = "./Registration/StaffExperienceprofileupdate.jsp";
	String resultword = "";
	if (result > 0) {
		resultword = "Experience Details Successfully Updated";

	} else {
		resultword = "Operation Failed";

	}
%> <input type="hidden" name="result" value="<%=result %>"> <input
	type="hidden" name="returnurl" value="<%=return_file%>"> <input
	type="hidden" name="message" value="<%=resultword%>"></form>
	
</body>
</html>

