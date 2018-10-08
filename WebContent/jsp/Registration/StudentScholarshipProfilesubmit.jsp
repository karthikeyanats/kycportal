<html>
<head>
<script type="text/javascript">

	function loadResult()
	{
		 document.submitlessonform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
		document.submitlessonform.submit();
	}

</script>
</head>
<body onload=loadResult()>
	<form name="submitlessonform" action="" method="post">
		<%@ page language="java"%>
		<%@ page import="com.iGrandee.Registration.StudentRegistrationBean"%>
		<%@ page import="com.iGrandee.Registration.StudentRegistrationQuery"%>

		<%@ page import="com.iGrandee.Common.DateTime"%>

		<%
		try{
			String approvalid = null;
			int result = 0;
			String instituid = (String) session.getAttribute("instituteid");
			String sessionuserid = (String) session.getAttribute("userid");
			DateTime dateobj = new DateTime();
			StudentRegistrationBean gen_qu = new StudentRegistrationBean();
			StudentRegistrationQuery gen_query = new StudentRegistrationQuery();

			String userid = request.getParameter("personid");
			approvalid = request.getParameter("studentapprovalid");

			gen_qu.setStudentapprovalid(approvalid);
			gen_qu.setPersonid(userid);

			gen_qu.setStandardscheduleid(request.getParameter("standardscheduleid"));
			gen_qu.setCreatedby(sessionuserid);
			

			if (request.getParameter("actionstate") != null && request.getParameter("actionstate").equals("allocate")) {
				//gen_qu.setScholarshipallocation(request.getParameterValues("scholarshipallocation"));
				gen_qu.setScholarshipallocation(request.getParameterValues("scholarshipamountallocationid"));
				gen_qu.setTermfeesid(request.getParameterValues("termfeesid"));
				gen_qu.setAmount(request.getParameterValues("amount"));
				gen_qu.setStudentapprovalid(approvalid);
			//	out.println(gen_qu.getTermfeesid().length);
				
				result = gen_query.studentScholarshipUpdate(gen_qu);
			 }
			else if (request.getParameter("actionstate") != null && request.getParameter("actionstate").equals("deallocate")) {
				//gen_qu.setScholarshipallocation(request.getParameterValues("descholarshipallocation"));
				gen_qu.setScholarshipallocation(request.getParameterValues("descholarshipamountallocationid"));
				gen_qu.setSchemeforstudentid(request.getParameterValues("schemeforstudentid"));
				gen_qu.setFeescollectionid(request.getParameterValues("feescollectionid")); 
				result = gen_query.studentScholarshipUpdateProcess(gen_qu);
			}
			
			String resultword = "";

			if (result > 0) {
				resultword = "Student Scholarship Details Successfully Updated";
			} else {
				resultword = "Operation Failed";
			}

			String return_file = "./Registration/StudentScholarshipProfileUpdate.jsp";
		%>

		<input type="hidden" name="personid" value="<%=userid%>" /> <input
			type="hidden" name="studentprofileedit"
			value="<%=request.getParameter("studentprofileedit")%>"> <input
			type="hidden" name="session"
			value="<%=request.getParameter("session")%>"> <input
			type="hidden" name="board" value="<%=request.getParameter("board")%>">
		<input type="hidden" name="standardscheduleid"
			value="<%=request.getParameter("standardscheduleid")%>"> <input
			type="hidden" name="sectionscheduleid"
			value="<%=request.getParameter("sectionscheduleid")%>"> <input
			type="hidden" name="req_sessionname"
			value="<%=request.getParameter("req_sessionname")%>"> <input
			type="hidden" name="req_sessionstatus"
			value="<%=request.getParameter("req_sessionstatus")%>"> <input
			type="hidden" name="req_boardname"
			value="<%=request.getParameter("req_boardname")%>"> <input
			type="hidden" name="req_standardnamegp"
			value="<%=request.getParameter("req_standardnamegp")%>"> <input
			type="hidden" name="req_sectionname"
			value="<%=request.getParameter("req_sectionname")%>"> <input
			type="hidden" name="result" value="<%=result%>"> <input
			type="hidden" name="returnurl" value="<%=return_file%>"> <input
			type="hidden" name="message" value="<%=resultword%>"> <input
			type="hidden" name="stundentapproveid" value="<%=approvalid%>">
			<input
			type="hidden" name="req_studentname"
			value="<%=request.getParameter("req_studentname")%>">
			<%}catch(Exception e){e.printStackTrace();} %>
	</form>
</body>
</html>

