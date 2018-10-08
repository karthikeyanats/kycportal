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
	String message ="";
	int result = 0;
try
{
	//instituteid = (String)session.getValue("instituteid");
	userid = (String)session.getValue("userid");
	stageid = request.getParameter("stagename");
	System.out.println("Insert stageid===>>"+stageid);
	routename = request.getParameter("routename");
	studentapprovalid = request.getParameter("studentapprovalid");
	/* System.out.println("routename>>>>"+routename);
	System.out.println("stagename>>>>"+stagename); 
	System.out.println("studentapprovalid>>>>"+studentapprovalid); */
		
	
	FeesSettingsBean.setStudentapprovalid(studentapprovalid);
	FeesSettingsBean.setTransportstageid(stageid);
	FeesSettingsBean.setStudentstageallocationstatus("A");
	FeesSettingsBean.setStudentstageallocationaction("Created");
	FeesSettingsBean.setStudentstageallocationlogstatus("A");
	result = FeesSettings.insertStudentstage(FeesSettingsBean); 
 
	 if(result==1000)
			message = "Student Stage Info already Exists";	 
	
	if(result >0)
		message = "Student Stage Sucessfully Allocated";
	else
		message = "Student Stage Allocation Failed";

	return_file = request.getContextPath()+"/jsp/TransportFees/StageFeesStudentinfo.jsp";
	
	
	/* if(result==1000)
		op="Student Stage Info already Exists";
	else if(result>0)
		op="Student Stage Sucessfully Inserted";
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