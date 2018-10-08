<%@page import="com.sun.mail.handlers.message_rfc822"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Discount.DiscountAction" />

<jsp:useBean id="querybean" scope="page"
	class="com.iGrandee.Discount.Discountallocationbean" />

<%@ page import="java.io.*,java.util.*"%>

<%
String  operation =null;String discountcategoryid=null;String createdby=null;
String studentapprovalid=null;String rollnumber=null;String message="";String return_file=null;
int result=0;String discountusersid=null;
if(request.getParameter("operation")!=null){
	  operation = request.getParameter("operation")+"";
}
if(request.getParameter("discountcategoryid")!=null){
	 discountcategoryid = request.getParameter("discountcategoryid");
}	 
if(session.getValue("userid")!=null){
 	createdby = (String)session.getValue("userid");
}

if(request.getParameter("studentapprovalid")!=null)
{
	studentapprovalid=(String)request.getParameter("studentapprovalid");
}

if(request.getParameter("rollno")!=null){
	rollnumber=request.getParameter("rollno");
}

if(request.getParameter("discountusersid")!=null){
	discountusersid=request.getParameter("discountusersid");
}

querybean.setCreatedby(createdby);
querybean.setDiscountcategoryid(discountcategoryid);
querybean.setDiscountuserstatus("A");
querybean.setStudentapprovalid(studentapprovalid);

if(request.getParameter("operation")!=null){

if(operation.equals("allocate")){	



 result=0;
	
	 result= query_object.insertdiscountallocation(querybean);
	
	
	if(result >0)
		message = "Discount Category Successfully  Allocated";
	else
		message = "Discount Category Allocation Failed";	 

		 return_file =request.getContextPath()+"/jsp/Discount/Discountallocation.jsp"; 
	 	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+result+"&returnurl="+return_file+"&rollnumber="+rollnumber);
	 	
 }
if(operation.equals("cancel")){
	
	


	 result=0;
		
		 result= query_object.updatediscountallocation(querybean);
		
		
		if(result >0)
			message = "Discount Category  Allocation  Canceled Successfully";
		else
			message = "Discount Category ReAllocation Failed";	 

			 return_file =request.getContextPath()+"/jsp/Discount/Discountallocation.jsp"; 
		 	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+result+"&returnurl="+return_file);
	
}

if(operation.equals("remove")){
	
	 result=0;
		 result= query_object.removediscountallocation(querybean,discountusersid);
		
		 if(result==1000)
				message = "Discount Category had been Allocated to the Student";	 
		
		if(result >0)
			message = "Discount Category  Allocation  Removed Successfully";
		else
			message = "Failure while Removing Discount";

			 return_file =request.getContextPath()+"/jsp/Discount/Discountallocation.jsp"; 
		 	//response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+result+"&returnurl="+return_file);
	
}


}

	 	
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