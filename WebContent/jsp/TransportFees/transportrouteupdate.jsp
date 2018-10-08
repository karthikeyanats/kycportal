<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<jsp:useBean id="transportRouteBean" scope="page"
	class="com.iGrandee.TransportFees.TransportRoute" />

	
<%@ page language="java" import="java.util.*"%>
<%
try{
	String routename=request.getParameter("routename");
	routename=routename.replaceAll("&quot;","\"");
	String descryption=request.getParameter("routedescription");
	String routeid=request.getParameter("transportrouteid");
	String instituteid = (String)session.getValue("instituteid"); 
	transportRouteBean.setInstituteid(instituteid);
	 
	
	int courseList = query_object.updatetranspotroute(routeid,routename,descryption,instituteid);
	
	String message="";
	if(courseList ==1)
	{
		message = "TransportRoute Successfully Updated"; 
	}
	else if(courseList ==0)
	{
		message = " Transport Route Updation  Failed";	
	}
	else if(courseList ==1000)
	{
		message = "Transport Route Name Already Exist";	
		courseList=1000;
	}

		String return_file =request.getContextPath()+"/jsp/TransportFees/transportroutelist.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
}
catch(Exception e)
{
	e.printStackTrace();	
}
%>
