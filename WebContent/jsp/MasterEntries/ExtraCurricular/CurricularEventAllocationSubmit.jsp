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
<%@ page import="com.iGrandee.MasterEntries.ExtraCurricular.ExtraCurricularQuery" %>
<%@ page import="com.iGrandee.MasterEntries.ExtraCurricular.CurricularEventBean" %>


<% 
			String sessionuserid = "";
			String sessionid		=request.getParameter("sessionid")+"";
			sessionuserid=(String)session.getValue("userid");
			CurricularEventBean curricular_bean=new CurricularEventBean();
			ExtraCurricularQuery curricular_query=new ExtraCurricularQuery();
		  	String eventid = null;
	      	String studentallocationid [] = null;
	      	String ipaddress = null;
	      	eventid = request.getParameter("eventid");
			//System.out.println("eventid===========>>>>"+eventid);

	      	studentallocationid = request.getParameterValues("allocatecheck");
	      	ipaddress = request.getRemoteAddr();
	             
	      	curricular_bean.setCurriculareventid(eventid);
	      	curricular_bean.setCreatedby(sessionuserid);
	      	curricular_bean.setStudentallocationid(studentallocationid);
	      	curricular_bean.setIpaddress(ipaddress);
     		String resultword="";
	      	int result=curricular_query.insertCurricularEventAllocation(curricular_bean); 
	      	if(result>0)
	      	{
	      		resultword="Curricular Event Successfully Allocated";
	      	}
	      	else
	      	{
	      		resultword="Curricular Event Allocation Failed";
	      	}
			//System.out.println("result===========>>>>"+result);
			String return_file = "./MasterEntries/ExtraCurricular/CurricularEventAllocation.jsp";
		%>
<input type="hidden" name="session"  id="session" value="<%=sessionid%>">
<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">		
			</form>
	</body>  
</html>

