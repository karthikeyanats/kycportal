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
			CurricularEventBean curricular_bean=new CurricularEventBean();
			ExtraCurricularQuery curricular_query=new ExtraCurricularQuery();
		  	String eventparticipantsid = null;
			String sessionid		=request.getParameter("sessionid")+"";

		  	eventparticipantsid = request.getParameter("eventparticipantsid");
		  	
		  	curricular_bean.setEventparticipantsid(eventparticipantsid);
     		String resultword="";
	      	int result=curricular_query.CurricularEventActivityDeallocation(curricular_bean); 
	      	if(result>0)
	      	{
	      		resultword="Curricular Event Successfully Deallocated";
	      	}
	      	else
	      	{
	      		resultword="Curricular Event Deallocation Failed";
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


			