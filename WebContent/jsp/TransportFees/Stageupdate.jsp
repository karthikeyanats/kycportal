<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportStageAction" />
<jsp:useBean id="transportRouteBean" scope="page"
	class="com.iGrandee.TransportFees.TransportRoute" />

	
<%@ page language="java" import="java.util.*"%>
<%
try{
	
	String transportstagename=request.getParameter("transportstagename");
	transportstagename=transportstagename.replaceAll("&quot;","\"");
	String descryption=request.getParameter("transportstagedescription");
	String transportstageid=request.getParameter("transportstageid");
	String transportrouteid=null;
	if(request.getParameter("transportrouteid")!=null)
		transportrouteid=request.getParameter("transportrouteid");
	
	int courseList = query_object.updatetransportstage(transportstageid, transportstagename, descryption,transportrouteid);
	
	String message="";
	if(courseList ==1)
	{ 
		message = "Stage Successfully Updated"; 
	}
	else if(courseList ==0)
	{
		message = " Stage Updation  Failed";	
	}
	else if(courseList ==1000)
	{
		message = " Stage Name Already Exist";	
		courseList=1000;
	}

		String return_file =request.getContextPath()+"/jsp/TransportFees/StageListroutewise.jsp";
		out.println("transportrouteid>>>"+transportrouteid);
	 	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file+"&transportrouteid="+transportrouteid);
	 	

%>
<html>



<head>
<script language="javascript">
function loadResult()
{
	document.stageform.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.stageform.submit();
}
</script>
</head>
<body onload="loadResult()">
<form name="stageform" method="post">
<input type="hidden" name="transportrouteid" value="<%=transportrouteid%>"/>
<input type="hidden" name="returnurl" value="<%=return_file%>"/>
<input type="hidden" name="result" value="<%=courseList%>"/>
<input type="hidden" name="message" value="<%=message%>"/>
<input type="hidden" name=transportstageid value="<%=transportstageid%>"/>


  <%
String routename=null;
if(request.getParameter("routename")!=null){
	
	out.println("<input type='hidden' name='routename' value='"+request.getParameter("routename")+"'>");
	  
	
} 
         
         %>
</form>
</body>

</body>
<%
}
catch(Exception e)
{
	e.printStackTrace();	
}
%>
</html>