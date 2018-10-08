<%@page import="com.iGrandee.TransportFees.StudentstageAllocationAction"%>
<%@page import="com.iGrandee.TransportFees.StudentstageAllocation"%>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.MasterEntries.Community.CommunityBean,com.iGrandee.MasterEntries.Community.CommunityQuery"%>
<%
	StudentstageAllocationAction  FeesSettings = new StudentstageAllocationAction();
	StudentstageAllocation     FeesSettingsBean= new StudentstageAllocation();
	String rollnumber = null;
	if(request.getParameter("reqrollnumbertext")!=null){
		rollnumber=request.getParameter("reqrollnumbertext");
	}
	String routename = null;
	String stageid= null;
	String studentapprovalid = null;
	String userid = null;
	String op=null;
	String return_file=null;
	String message="";
	int result = 0;
try
{
	
	userid = (String)session.getValue("userid");
	stageid = request.getParameter("stagename");
	//System.out.println("stageid - StageName===>>>"+stageid);
	
	//String oldstageid = request.getParameter("stageidnames");
	String oldstageid = request.getParameter("existingstageid");
	
	
	//System.out.println("oldstageid===>>>"+oldstageid);
	routename = request.getParameter("routename");
	studentapprovalid = request.getParameter("studentapprovalid");	
	String studentstageallocationids = request.getParameter("studentstageallocationid");
	String studentstageallocationlogids = request.getParameter("studentstageallocationlogid");
	
	String studentallocationstatus = FeesSettings.getstudentallocationstatus(studentstageallocationids);
	//System.out.println("studentallocationstatus===>>>"+studentallocationstatus);  
		
	FeesSettingsBean.setStudentapprovalid(studentapprovalid);  
	FeesSettingsBean.setTransportstageid(stageid);
	
	if(studentallocationstatus.equals("C"))
	{
		result = FeesSettings.UpdateinsertStudentstageStatus(FeesSettingsBean,oldstageid,studentstageallocationids,studentstageallocationlogids);
	}else
	{	
	result = FeesSettings.UpdateinsertStudentstage(FeesSettingsBean,oldstageid,studentstageallocationids,studentstageallocationlogids);
	}
 
	
	
	 if(result==1000)
			message = "Student Stage Info already Exists";	 
	
	if(result >0)
		message = "Student Stage Successfully Changed";
	else
		message = "Student Stage Change Process is Failed";

	return_file = request.getContextPath()+"/jsp/TransportFees/StageFeesStudentinfo.jsp";
	
	
	/* if(result==1000)
		op="Student Stage Info already Exists";
	else if(result>0)
		op="Student Stage Successfully Inserted";
	else
		op="Student Stage Insertion Failed";  

	return_file = request.getContextPath()+"/jsp/TransportFees/Stagestusearch.jsp"; */
	
}catch(Exception e){}	
	
	
%>

<html>
<head>
<script type="text/javascript">
function goop(){
	document.operation_form.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.operation_form.submit();
}
</script>
</head>
<body onload="goop()">
<form name="operation_form" method="post" >
<input type="hidden" name="message" value="<%=message%>"/>
<input type="hidden" name="returnurl" value="<%=return_file%>"/>
<input type="hidden" name="rollnumbertext" value="<%=rollnumber%>"/>
<input type="hidden" name="result" value="<%=result %>">
<input type="hidden" name="returnurl" value="<%=return_file%>">



 
</form>
</body>
</html>


