<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<%@ page import="com.iGrandee.Registration.StudentRegistrationBean" %>
<%@ page import="com.iGrandee.Registration.StudentRegistrationQuery" %>

<head>
<script language="javascript">
function loadResult()
{
	document.f1.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.f1.submit();
}
</script>
</head>
<body onload=loadResult()>
<form name="f1" method="post">
<%

	String sessionuserid = "";
	int result=0;
	String guardianname = null;
	String guardianmailid = null;

	String guardrelation = null;
	String guardemployment = null;
	String nameoforg = null;
	String annualincome = null;
	String guardposition = null;
	String physicallyChallenge = null;
	String ExServiceman = null;
	String ipaddress  = null;
	String studentguardianid = null;
	String personid = null;
	String candidateregisterid = null;
	String physicalmarks = null;
	String message="";
	String userid = null;
	StudentRegistrationBean gen_qu=new StudentRegistrationBean();
	StudentRegistrationQuery gen_query=new StudentRegistrationQuery();
	try
	{
		   sessionuserid=(String)session.getValue("userid");
		   studentguardianid = request.getParameter("studentguardianid");
			userid = request.getParameter("personid");
	       personid = request.getParameter("personid");
	       guardianname = request.getParameter("guardianname");
	       guardianmailid = request.getParameter("guardianmailid");
	       
	       guardrelation = request.getParameter("relation");
	       guardemployment = request.getParameter("selfemployed");
	       nameoforg = request.getParameter("organization");
	       annualincome = request.getParameter("annualincome");
	       guardposition = request.getParameter("position");
	       physicallyChallenge = request.getParameter("physicallyfit");
	       physicalmarks = request.getParameter("physicalmarks");
	       ExServiceman = request.getParameter("exserviceman");
	       candidateregisterid = request.getParameter("candidateregisterid");
	       
	    /*  out.println(studentguardianid+"<br>");
	       out.println(guardianname+"<br>");
	       out.println(guardrelation+"<br>");
	       out.println(guardemployment+"<br>");
	       out.println(nameoforg+"<br>");
	       out.println(annualincome+"<br>");
	       out.println(guardposition+"<br>");
	       out.println(physicallyChallenge+"<br>");
	       out.println(physicalmarks+"<br>");
	       out.println(ExServiceman+"<br>");
	       out.println(candidateregisterid+"<br>");
	       
	       */
	       
	       
	       
	       
       
			gen_qu.setGuardianname(guardianname);
	       gen_qu.setGuardianmailid(guardianmailid);
	       
			
			gen_qu.setGuardrelation(guardrelation);
			gen_qu.setGuardemployment(guardemployment);
			gen_qu.setNameoforg(nameoforg);
			gen_qu.setAnnualincome(annualincome);
			gen_qu.setGuardposition(guardposition);
			gen_qu.setExServiceman(ExServiceman);
			gen_qu.setPersonid(personid);
			gen_qu.setStudentguardianid(studentguardianid);
	    
			gen_qu.setCanidateregisterid(candidateregisterid); 
			gen_qu.setPhysicalmarks(physicalmarks);
			gen_qu.setPhysicallyChallenge(physicallyChallenge);
			gen_qu.setExServiceman(ExServiceman);
			
	    	result=gen_query.UpdateParentGuardianInfo(gen_qu); 
		 
				 
			
		 		if(result >0)
		 			message="Updated Successfully";
		 			else
		 				message="Failure updation";
		 			
	
		 		}catch(Exception e){}
			String return_file = "./Registration/Studentprofileview.jsp";
				//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?result="+result+"&returnurl="+return_file+"&message="+resultword);
		%>
		<input type="hidden" name="personid" value="<%=userid%>">
<input type="hidden" name="studentprofileedit" value="<%=request.getParameter("studentprofileedit")%>">
<input type=hidden   name=session value="<%=request.getParameter("session")%>">
<input type=hidden   name=board value="<%=request.getParameter("board")%>">
<input type=hidden   name=standardscheduleid value="<%=request.getParameter("standardscheduleid")%>">
<input type=hidden   name=sectionscheduleid value="<%=request.getParameter("sectionscheduleid")%>">
<input type="hidden" name="req_sessionname" value="<%=request.getParameter("req_sessionname")%>">
<input type="hidden" name="req_sessionstatus" value="<%=request.getParameter("req_sessionstatus")%>">
<input type="hidden" name="hiddensession" value="<%=request.getParameter("session")%>">

<input type="hidden" name="req_boardname" value="<%=request.getParameter("req_boardname")%>">
<input type="hidden" name="req_standardnamegp" value="<%=request.getParameter("req_standardnamegp")%>">
<input type="hidden" name="req_sectionname" value="<%=request.getParameter("req_sectionname")%>">
<input type="hidden" name="req_studentname" value="<%=request.getParameter("req_studentname")%>">
	<input type="hidden" name="personid" value="<%=userid%>">
	<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">
<input type="hidden" name="message" value="<%=message%>">
	</form>
</body>
</html>