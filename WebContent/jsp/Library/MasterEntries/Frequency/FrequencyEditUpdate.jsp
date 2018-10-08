<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Frequency.FrequencyEntry" />
<jsp:useBean id="frequencybean" scope="page"
	class="com.iGrandee.Library.MasterEntries.Frequency.FrequencyBean" />


     
<%@ page language="java" import="java.util.*"%>
<%
	String frequencyname=request.getParameter("frequencyname");
	String description=request.getParameter("description");
	String frequencyid=request.getParameter("frequencyid");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status="A";
	String LogStatus="Updated";
	
	frequencybean.setCreatedby(createdby);
	frequencybean.setInstituteid(instituteid);
	frequencybean.setIpaddress(ipaddress);
	frequencybean.setFrequencyid(frequencyid);
	frequencybean.setFrequencyname(frequencyname.replaceAll("&quot;","\"").trim());
	frequencybean.setDescription(description.trim());
	
	frequencybean.setFrequencystatus(Status);
	frequencybean.setFrequencylogstatus(Status);
	frequencybean.setLogstatus(LogStatus); 
	
	int courseList = query_object.UpdateEdittFrequency(frequencybean);
	String message="";
	

	
	if(courseList==1000)
	{
		message = " Frequency Name  Already Exists";
	    courseList=1000;
	}
	else if(courseList==0)
	{
		message = " Frequency Updation  failed";

	}
	else if(courseList>=1)
	{
		message = "Successfully Frequency Updated";

	}
		
		String return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Frequency/FrequencyList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
