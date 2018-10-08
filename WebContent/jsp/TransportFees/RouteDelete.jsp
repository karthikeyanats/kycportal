<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TransportRouteAction" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.Role.RoleBean" />

<%@ page import="java.io.*,java.util.*"%>

<%

	String transportrouteid = request.getParameter("transportrouteid");

	
	
	
	//int trashlist = query_object.changetranspotroute(transportrouteid, "X");
	int trashlist = query_object.deletetranspotroute(transportrouteid);
	
	String message="";
	if(trashlist >0)
		message = "Transport Route Successfully  Deleted";
	else
		message = " Transport Route Deletion  Failed";	 

		String return_file =request.getContextPath()+"/jsp/TransportFees/transportTrashListview.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+trashlist+"&returnurl="+return_file);
	 	
%>
