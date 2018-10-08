<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Rack.RackEntry" />
<jsp:useBean id="rackbean" scope="page"
	class="com.iGrandee.Library.MasterEntries.Rack.RackBean" />


     
<%@ page language="java" import="java.util.*"%>
<%
	String rackname=request.getParameter("rackname");
	String description=request.getParameter("description");
	String rackid=request.getParameter("rackid");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getLocalAddr();
	String Status="A";
	String LogStatus="Updated";
	
	rackbean.setCreatedby(createdby);
	rackbean.setInstituteid(instituteid);
	rackbean.setIpaddress(ipaddress);
	rackbean.setRackid(rackid);
	rackbean.setRackname(rackname.replaceAll("&quot;","\"").trim());
	rackbean.setDescription(description.trim());
	
	rackbean.setRackstatus(Status);
	rackbean.setRacklogstatus(Status);
	rackbean.setLogstatus(LogStatus); 
	
	int courseList = query_object.UpdateEdittRack(rackbean);
	String message="";
	

	
	if(courseList==1000)
	{
		message = " Rack Name  Already Exists";
	    courseList=1000;
	}
	else if(courseList==0)
	{
		message = " Rack Updation  failed";

	}
	else if(courseList>=1)
	{
		message = "Successfully Rack Updated";

	}
		
		String return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Rack/RackList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
