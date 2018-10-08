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
		 
	      
	      userid = request.getParameter("personid");
	      
	        String previousschoolname =  request.getParameter("schoolname");
			String previousschooladdress = request.getParameter("schooladdress");
			String mediumstudied =  request.getParameter("medium");
			String tc =  request.getParameter("tc");
			String cc = request.getParameter("cc");
			String splcategory =  request.getParameter("splCategory");
			String marksheet =  request.getParameter("ms");
			String medicalcertificate =  request.getParameter("mc");
			String sportscertificate = request.getParameter("sc");
			gen_qu.setSubject(request.getParameterValues("subject"));
	        gen_qu.setMonthyear(request.getParameterValues("month"));
	        gen_qu.setMarkscored(request.getParameterValues("mark"));
	      	gen_qu.setMaxmark(request.getParameterValues("max"));
	        gen_qu.setRegistionno(request.getParameterValues("registrationno"));
	        gen_qu.setUpdateStatus(request.getParameterValues("examinfoedit"));
	        gen_qu.setExaminfoid(request.getParameterValues("examinfoid"));
	        gen_qu.setPreviousSchoolDetails(previousschoolname);
	        gen_qu.setPreviousSchooladdress(previousschooladdress);
	        gen_qu.setPreviousSchoolmedium(mediumstudied);
	        gen_qu.setTccheck(tc);
		    gen_qu.setCccheck(cc);
		    gen_qu.setSccheck(sportscertificate);
		    gen_qu.setMccheck(medicalcertificate);
		    gen_qu.setMscheck(marksheet);
		    gen_qu.setSpccheck(splcategory);
		    gen_qu.setCreatedby(sessionuserid);
	        gen_qu.setPersonid(userid);
	        %>
		      <input type="hidden" name="personid" value="<%=userid%>" />
		    <%
	        int result=gen_query.Studentpreviousschoolupdate(gen_qu); 
		    String resultword="";
		    if(result>0)
		      	{
		      		resultword="Stident Previous Details Successfully Updated";
		      	}
		      else
		      	{
		      		resultword="Operation Failed";
		      	}
		    String return_file = "./Registration/StudentPreviousSchoolProfileUpdate.jsp";

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

