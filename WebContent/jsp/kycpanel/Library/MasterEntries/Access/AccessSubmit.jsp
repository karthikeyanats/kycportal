<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Access.AccessEntry" />
<jsp:useBean id="accessbean" scope="page"
	class="com.iGrandee.Library.MasterEntries.Access.AccessBean" />

<%@ page language="java" import="java.util.*"%>  
<% 
	
	String message = "";
	String userstatus = request.getParameter("userstatus");
	String renewdays = request.getParameter("renewdays");
	String returndays = request.getParameter("returndays");
	String renewcount = request.getParameter("renewcount");
	String fineperday = request.getParameter("fineperday");
	String noofbooks = request.getParameter("noofbooks");
	String accessstatus="A";
	String logstatus="Created";
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	
	accessbean.setRoleid(userstatus);
	accessbean.setRenewdays(renewdays);
	accessbean.setReturndays(returndays);
	accessbean.setRenewcount(renewcount);
	accessbean.setFineperday(fineperday);
	accessbean.setNoofbooks(noofbooks);
	accessbean.setAccessstatus(accessstatus);
	accessbean.setInstituteid(instituteid);
	accessbean.setCreatedby(createdby);
	
	accessbean.setAccesslogstatus("A");
	accessbean.setLogstatus(logstatus);
	
	int courseList = query_object.insertAccess(accessbean); 

	

	 if(courseList==0)
	{
		message = " Role wise Access insert  Failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Role wise Access Inserted";

	} 
	
		String return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Access/AccessEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
	 	
 	%>
