<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Frequency.FrequencyEntry" />
<jsp:useBean id="frequencybean" scope="page"
	class="com.iGrandee.Library.MasterEntries.Frequency.FrequencyBean" />

<%@ page language="java" import="java.util.*"%>
<%
	String message = "";
	String frequencyname = request.getParameter("frequencyname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getLocalAddr();
	String Status = "A";
	
	String LogStatus = "Created";
	
if(descryption.equals(""))
{
	descryption="-";
}

	frequencybean.setFrequencyname(frequencyname.trim());
	frequencybean.setDescription(descryption.trim());
	frequencybean.setCreatedby(createdby);
	frequencybean.setInstituteid(instituteid);
	frequencybean.setIpaddress(ipaddress);
	frequencybean.setFrequencystatus(Status);
	frequencybean.setFrequencylogstatus(Status);
	frequencybean.setLogstatus(LogStatus); 
	int courseList = query_object.insertFrequency(frequencybean); 
	

	if(courseList==1000)
	{
		message = " Frequency Name Already Exists";
	      courseList=1000;  

	}else if(courseList==0)
	{
		message = " Frequency insert  failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Frequency Inserted";

	} 
	
		String return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Frequency/FrequencyEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
	 	
 	%>
