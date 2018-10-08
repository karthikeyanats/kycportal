<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Rack.RackEntry" />
<jsp:useBean id="rackbean" scope="page"
	class="com.iGrandee.Library.MasterEntries.Rack.RackBean" />

<%@ page language="java" import="java.util.*"%>
	
	
	<%
	int courseList=0;
	String rackid = request.getParameter("rackid");
	String rackname = request.getParameter("rackname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getLocalAddr();
	String flage=request.getParameter("flage");
	String Status="";
	String LogStatus="";
	String message="";
	String return_file="";
	rackbean.setRackid(rackid);
	rackbean.setRackname(rackname);
	rackbean.setDescription(descryption);
	rackbean.setCreatedby(createdby);
	rackbean.setInstituteid(instituteid);
	rackbean.setIpaddress(ipaddress);
	rackbean.setRacklogstatus("A");
	
	if(flage.equals("Trash"))
	{	
		LogStatus="Trashed";
		Status="T";
		rackbean.setLogstatus(LogStatus); 
		rackbean.setRackstatus(Status);
		courseList = query_object.RackStatusUpdate(rackbean); 
		message="Trashed";
		return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Rack/RackList.jsp";

	}
	 else if(flage.equals("Delete"))
	{	
		LogStatus="Deleted";
		Status="X";
		rackbean.setLogstatus(LogStatus); 
		rackbean.setRackstatus(Status);
		courseList = query_object.RackStatusUpdate(rackbean); 
		message="Deleted";
		 return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Rack/RackTrashListview.jsp";

	} else if(flage.equals("Restore"))
	{	
		LogStatus="Restored";
		Status="A";
		rackbean.setLogstatus(LogStatus); 
		rackbean.setRackstatus(Status);
		courseList = query_object.RackStatusUpdate(rackbean); 
		message="Restored";
		 return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Rack/RackTrashListview.jsp";

	}
	
	
	if(courseList==0)
	{
		message = " Rack "+message+" failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Rack "+message;

	} 
	
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);


%>