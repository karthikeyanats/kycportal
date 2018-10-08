<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />

<%@ page import="java.io.*,java.util.*"%>

<%

	String transportfeesheadid = request.getParameter("transportfeesheadid");

	
	
	
	//int trashlist = query_object.changetranspotFeesHeadName(transportfeesheadid, "X");
	int trashlist = query_object.deletetranspotFeesHeadName(transportfeesheadid);
	
	String message=""; 
	if(trashlist >0)
		message = "Transport Fees Head Name Successfully  Deleted";
	else
		message = " Transport Fees Head Name Deletion  Failed";	 

		String return_file =request.getContextPath()+"/jsp/TransportFees/TrashTransportFeesHeadList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
