<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />



<%@ page language="java" import="java.util.*"%>
<%
	String transportfeesheadid=request.getParameter("transportfeesheadid");
	//System.out.println("transportfeesheadid===>>>"+transportfeesheadid+"Sindhu");
	int courseList = query_object.restorefeesheadname(transportfeesheadid,"A");
	
	String message="";
	if(courseList >0)
		message = "Transport Fees Head Name Successfully Restored";
	else
		message = "Transport Fees Head Name Restore Failed";	

		String return_file =request.getContextPath()+"/jsp/TransportFees/TrashTransportFeesHeadList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
