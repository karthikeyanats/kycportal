<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />



<%@ page language="java" import="java.util.*"%>
<%
	String transportrouteid=request.getParameter("transportrouteid");

	int courseList = query_object.changetranspotroute(transportrouteid,"A");
	
	String message="";
	if(courseList >0)
		message = "Transport Route Successfully Restored";
	else
		message = "Transport Route Restore Failed";	

		String return_file =request.getContextPath()+"/jsp/TransportFees/transportTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
%>
