<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />


<%@ page language="java" import="java.util.*"%>
<%
try{
	
	String curstatus = "T";

	String transportfeesheadid = request.getParameter("transportfeesheadid");
	
	int trashlist = query_object.changetranspotFeesHead(transportfeesheadid, "T");
	
	String message=""; 
	if(trashlist >0)
		message = "Transport Fees Head Name Successfully Trashed";
	else
		message = " Transport Fees Head Name Trash Failed";	

		String return_file =request.getContextPath()+"/jsp/TransportFees/transportFeeslist.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
}
catch(Exception e){
	
	e.printStackTrace();
	
}
	 	
%>
