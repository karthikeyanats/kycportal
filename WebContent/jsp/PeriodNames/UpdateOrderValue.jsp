<jsp:useBean id="query_object" scope="page"  class="com.iGrandee.PeriodName.PeriodNameEntry" />


<%@ page language="java" import="java.util.*"%>
<%
	
	String message 			= "";
	String[] periodnames 	= request.getParameterValues("periodnames");
	String[] ordervalue 	= request.getParameterValues("ordervalue");
	
	int courseList = query_object.updateOrderValue(ordervalue,periodnames); 

	if(courseList==0)
		message = " Order Value updation failed";	
	else if(courseList>=1) 
	      message = "Order value updated Successfully.";

	String return_file =request.getContextPath()+"/jsp/PeriodNames/PeriodNameList.jsp";
 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
 %>
