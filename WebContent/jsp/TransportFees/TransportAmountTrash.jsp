<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />


<%@ page language="java" import="java.util.*"%>
<%

String transportfeessettingsid = "";
String[] transportstageid = null;
String sessionid = (String)session.getValue("sessionid");
String[] transportfeesheadid = null;  
String[] setttingheadid= null;
String transportcategoryid="";
String[] transportfeesamount = null;
String transportrouteid = request.getParameter("transportrouteid");
String transportfeestypeid = request.getParameter("transportfeestypeid");
String transportfeestypename = request.getParameter("tn");
String userid = null;
String op=null;
String return_file=null;
int result = 0;

String req_transportcategoryname = null; 
String req_transportroutename =null;
try{
	String curstatus = "T";
	 req_transportcategoryname = request.getParameter("req_transportcategoryname");
	  req_transportroutename = request.getParameter("req_transportroutename");
	String transportstageamountallocationid = request.getParameter("transportstageamountallocationid");
	
	result = query_object.changetranspotAmountTrashStatus(transportstageamountallocationid, "T");
	
	/* if(result==1000)
		op="Amount already Exists";
	else if(result>0)
		op="Amount Successfully Trashed";
	else
		op="Amount Trash Failed"; */

		String message="";
		
		if(result >0)
			op = "Amount Successfully Trashed"; 
		else
			op = "Amount trash Failed";	

		return_file =request.getContextPath()+"/jsp/TransportFees/ViewAmountAllocation.jsp";
	 	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
}
catch(Exception e){
	
	e.printStackTrace();
	
}
	 	
%>

<html>
<head>
<script type="text/javascript">
function go()
{
	document.cat_form.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
    document.cat_form.submit();
}

</script>	
</head>
<body onload="go()">
<form name="cat_form" method="post">

	<input type="hidden" name="message" value="<%=op%>"/>  
	<input type="hidden" name="result" value="<%=result%>"/>
	<input type="hidden" name="returnurl" value="<%=return_file%>"/>
	<input type="hidden" name="message" value="<%=op%>"/>  
	<input type="hidden" name="result" value="<%=result%>"/>
	<input type="hidden" name="returnurl" value="<%=return_file%>"/>
	<input type="hidden" name="transportcategoryid" value="<%=request.getParameter("transportcategoryid")%>"/> 
	<input type="hidden" name="transportrouteid" value="<%=transportrouteid%>"/>
	<input type="hidden" name="sessionid" value="<%=sessionid%>">
	<input type="hidden" name="tn" value="<%=transportfeestypename%>">  
	<input type="hidden" name="transportfeestypeid" value="<%=transportfeestypeid%>" />
	     <input type="hidden" name="req_transportroutename" value="<%=req_transportroutename%>"/>
<input type="hidden" name="req_transportcategoryname" value="<%=req_transportcategoryname%>"/>     
<%

if(request.getParameter("transportcategoryid")!=null){
	out.println("<input type='hidden' name='transportcategoryid' value='"+request.getParameter("transportcategoryid")+"'/>");
	
}	

if(request.getParameter("sessionid")!=null){
	out.println("<input type='hidden' name='sessionid' value='"+request.getParameter("sessionid")+"'/>");
	
}	


if(request.getParameter("transportrouteid")!=null){
	
	out.println("<input type='hidden' name='transportrouteid' value='"+request.getParameter("transportrouteid")+"'/>");
}

if(request.getParameter("transportfeestypename")!=null){
	
	out.println("<input type='hidden' name='transportfeestypename' value='"+request.getParameter("transportfeestypename")+"'/>");
}

if(request.getParameter("transportfeestypeid")!=null){
	
	out.println("<input type='hidden' name='transportfeestypeid' value='"+request.getParameter("transportfeestypeid")+"'/>");
}
	
%>	
</form>
</body>

</html>
