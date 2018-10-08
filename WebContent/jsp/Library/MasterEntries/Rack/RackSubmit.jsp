<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Rack.RackEntry" />
<jsp:useBean id="rackbean" scope="page"
	class="com.iGrandee.Library.MasterEntries.Rack.RackBean" />

<%@ page language="java" import="java.util.*"%>
<%
String message = "";
	String rackname = request.getParameter("rackname");
	String descryption = request.getParameter("descryption");
	String createdby = session.getValue("userid")+"";
	String instituteid = session.getValue("instituteid")+"";
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	
	String LogStatus = "Created";
	
if(descryption.equals(""))
{
	descryption="-";
}

	rackbean.setRackname(rackname.trim());
	rackbean.setDescription(descryption.trim());
	rackbean.setCreatedby(createdby);
	rackbean.setInstituteid(instituteid);
	rackbean.setIpaddress(ipaddress);
	rackbean.setRackstatus(Status);
	rackbean.setRacklogstatus(Status);
	rackbean.setLogstatus(LogStatus); 
	int courseList = query_object.insertRack(rackbean); 
	
	if(courseList==1000)
	{
		message = " Rack Name Already Exists";
	      courseList=1000;  

	}else if(courseList==0)
	{
		message = " Rack insert  failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Rack Inserted";

	} 
	
		String return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Rack/RackEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
	 	
 	%>
