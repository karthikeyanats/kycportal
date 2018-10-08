<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.Library.MasterEntries.Frequency.FrequencyEntry" />
<jsp:useBean id="frequencybean" scope="page"
	class="com.iGrandee.Library.MasterEntries.Frequency.FrequencyBean" />

<%@ page language="java" import="java.util.*"%>
	
	
	<%
	int courseList=0;
	String frequencyid = request.getParameter("frequencyid");
	String frequencyname = request.getParameter("frequencyname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getLocalAddr();
	String flage=request.getParameter("flage");
	String Status="";
	String LogStatus="";
	String message="";
	String return_file="";
	frequencybean.setFrequencyid(frequencyid);
	frequencybean.setFrequencyname(frequencyname);
	frequencybean.setDescription(descryption);
	frequencybean.setCreatedby(createdby);
	frequencybean.setInstituteid(instituteid);
	frequencybean.setIpaddress(ipaddress);
	frequencybean.setFrequencylogstatus("A");
	
	if(flage.equals("Trash"))
	{	
		LogStatus="Trashed";
		Status="T";
		frequencybean.setLogstatus(LogStatus); 
		frequencybean.setFrequencystatus(Status);
		courseList = query_object.FrequencyStatusUpdate(frequencybean); 
		message="Trashed";
		return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Frequency/FrequencyList.jsp";

	}
	 else if(flage.equals("Delete"))
	{	
		LogStatus="Deleted";
		Status="X";
		frequencybean.setLogstatus(LogStatus); 
		frequencybean.setFrequencystatus(Status);
		courseList = query_object.FrequencyStatusUpdate(frequencybean); 
		message="Deleted";
		 return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Frequency/FrequencyTrashListview.jsp";

	} else if(flage.equals("Restore"))
	{	
		LogStatus="Restored";
		Status="A";
		frequencybean.setLogstatus(LogStatus); 
		frequencybean.setFrequencystatus(Status);
		courseList = query_object.FrequencyStatusUpdate(frequencybean);  
		message="Restored";
		 return_file =request.getContextPath()+"/jsp/Library/MasterEntries/Frequency/FrequencyTrashListview.jsp";

	}
	
	
	if(courseList==0)
	{
		message = " Frequency "+message+" failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Frequency "+message;

	} 
	
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);


%>