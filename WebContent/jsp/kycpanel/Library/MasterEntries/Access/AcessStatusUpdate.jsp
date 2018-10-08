<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Access.AccessEntry" />
<jsp:useBean id="accessbean" scope="page"
	class="com.iGrandee.Library.MasterEntries.Access.AccessBean" />

<%@ page language="java" import="java.util.*"%>  
<% 
	String flage=request.getParameter("flage");
	String message = "";
	String accessstatus="";
	String logstatus="";
	String return_file ="";
	String accessid = request.getParameter("accessid");
	
	if(flage.equals("Trash"))
	{
	 	      accessstatus="T";
	 	      logstatus="Trashed";
		       return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Access/AccessList.jsp";

	}
	else if(flage.equals("Delete"))
	{
			 accessstatus="X";
		 	 logstatus="Deleted";
			 return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Access/AccessTrashList.jsp";

	}
	else if(flage.equals("Restore"))
	{
			 accessstatus="A";
		     logstatus="Restored";
			 return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Access/AccessTrashList.jsp";

	}
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	
	accessbean.setAccessid(accessid);
	
	accessbean.setAccessstatus(accessstatus);
	accessbean.setInstituteid(instituteid);
	accessbean.setCreatedby(createdby);
	
	accessbean.setAccesslogstatus("A");
	accessbean.setLogstatus(logstatus);
	 
	
	
	int courseList = query_object.StatusUpdateAccess(accessbean);   
   
	

	if(courseList==0)
	{
		message = "Role wise Access "+logstatus+"  Failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Role wise Access "+logstatus;

	} 
	
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
	 	
 	%>
