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
			String eventname=request.getParameter("eventhidden")+"";
			String venue=request.getParameter("venuehidden")+"";
			String eventdate=request.getParameter("eventdatehidden")+"";
			String sessionuserid = "";
			sessionuserid=(String)session.getValue("userid");
			String update=request.getParameter("update")+"";
			String sessionid		=request.getParameter("session")+"";

			
			CurricularEventBean curricular_bean=new CurricularEventBean();
			ExtraCurricularQuery curricular_query=new ExtraCurricularQuery();
		  	String eventid = null;
	      	String studentallocationid [] = null;
	      	String awarddetails [] = null;
	      	eventid = request.getParameter("eventid");
	      	studentallocationid = request.getParameterValues("studentallocationid");
	      	awarddetails = request.getParameterValues("awarddetails");
	      	curricular_bean.setCurriculareventid(eventid);
	      	curricular_bean.setStudentallocationid(studentallocationid);
	      	curricular_bean.setAwarddetails(awarddetails);

     		String resultword="";
	      	int result=curricular_query.insertCurricularEventAward(curricular_bean); 
	      	if(result>0)
	      	{
	      		if(update.equals("update"))
		      		resultword="Award Successfully Updated";
	      		else
	      			resultword="Award Successfully Entered";
	      	}
	      	else
	      	{
	      		if(update.equals("update"))
		      		resultword="Award Updation Failed";
	      		else
	      			resultword="Award Insertion Failed";
	      		
	      		
	      	}
			//System.out.println("result===========>>>>"+result);
			String return_file = "./MasterEntries/ExtraCurricular/CurricularEventAwardEntry.jsp";
		%>
		<input type="hidden" name="session"  id="session" value="<%=sessionid%>">
		
<input type="hidden" name="eventidhidden" value="<%=eventid%>">
<input type="hidden" name="eventhidden" value="<%=eventname%>">
<input type="hidden" name="venuehidden" value="<%=venue%>">
<input type="hidden" name="eventdatehidden" value="<%=eventdate%>">
<input type="hidden" name="message" value="<%=resultword%>">
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">		
			</form>
	</body>
</html>

