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
String  message=null;
StudentRegistrationQuery registraquery =new StudentRegistrationQuery();
int result=0;
String returnurl=null;
returnurl=""+request.getContextPath()+"/jsp/Registration/RegisteredStudentList.jsp";
	try
	{
		
		
		 
			if(request.getParameter("applicationid")!=null){
	    		result=registraquery.deletecandidate(request.getParameter("applicationid"),request.getParameter("personid")); 
			}
				 
			
		 		if(result >0)
		 			message="Candidate Deleted Successfully";
		 			else
		 				message="Failure while Delete";
		 			
	
		 		}catch(Exception e){}
			String return_file = request.getContextPath()+"/jsp/Registration/RegisteredStudentList.jsp";
				//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?result="+result+"&returnurl="+return_file+"&message="+resultword);
		%>
<input type="hidden" name="message" value="<%=message%>"/>
<input type="hidden" name="result" value="<%=result%>"/>
<input type="hidden" name="returnurl" value="<%=returnurl%>"/>


	</form>
</body>
</html>