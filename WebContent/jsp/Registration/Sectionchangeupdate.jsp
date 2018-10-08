<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Prinicipal.PrinicipalQuery" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />

	
<%@ page language="java" import="java.util.*"%>
<%
int result=0;
	String []studentallocationid=null;String sectionscheduleid=null;
	String []hiddencreatedby=null;
	if(request.getParameterValues("hiddencreatedby")!=null){
		hiddencreatedby=request.getParameterValues("hiddencreatedby");
	}
	
if(request.getParameter("sectionscheduleid")!=null){
		
		sectionscheduleid=request.getParameter("sectionscheduleid");
		
	}


	if(request.getParameterValues("hiddstudentallocationid")!=null){
		studentallocationid=request.getParameterValues("hiddstudentallocationid");
		for(int k=0;k<studentallocationid.length;k++){
			result=query_object.changesection(studentallocationid[k],sectionscheduleid,hiddencreatedby[k]);
			
			out.println("studentallocationid>>>>"+studentallocationid[k]+"sectionscheduleid>>>"+sectionscheduleid+"hiddencreatedby>>>>"+hiddencreatedby[k]);
		}
		
		
	}   
	
	
	
out.println("result>>>.."+result);
	
	String message="";
	 if(result>0)
	{
		message = "Section Successfully Changed";
		out.println("if>>>>..");

	}
	 else{
		 out.println("else>>>>..");
		 message = "Failed while Section Change";
	 }
		String return_file =request.getContextPath()+"/jsp/Registration/StudentSection.jsp"; 
		response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+result+"&returnurl="+return_file);
%>

<html>
<head>

<script type="text/javascript">

function loadResult()
{
	document.submitlessonform.action	= "<%=request.getContextPath()%>/jsp/Operation_Result.jsp";
	//document.submitlessonform.submit();
}

</script>
</head>
<body onload="loadResult()">
<form name="submitlessonform" action="" method="post">

	<input type="hidden" name="result" 			value="<%=result%>">
   	<input type="hidden" name="returnurl" 		value="<%=return_file%>">
   	<input type="hidden" name="message" 		value="<%=message%>">
   	
	
   	
</form>
</body>
</html>