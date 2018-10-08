
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportStageAction" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />

<%@ page import="java.io.*,java.util.*"%>

<%

	String transportstageid = request.getParameter("transportstageid");

	
	
	
//	int trashlist = query_object.changetransportstage(transportstageid, "X"); 
	int trashlist = query_object.changetransportstage(transportstageid, "T");
	String message=""; 
	if(trashlist >0)
		message = "Stage Successfully Trashed";
	else
		message = " Stage Trash Failed";	
		String return_file =request.getContextPath()+"/jsp/TransportFees/StageListroutewise.jsp";
	 	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
	 	
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
<%
if(request.getParameter("transportrouteid")!=null){
%>
<input type="text" name="transportrouteid" value="<%=request.getParameter("transportrouteid")%>"/>	
<%	
}
%>
<input type="text" name="returnurl" value="<%=return_file%>"/>
<input type="text" name="result" value="<%=trashlist%>"/>
<input type="text" name="message" value="<%=message%>"/>
  <%
String routename=null;
if(request.getParameter("routename")!=null){
	routename=request.getParameter("routename");
	out.println("<input type='hidden' name='routename' value='"+routename+"'>");
	
} 
         
         %>
</form>
</body>

</body>

</html>