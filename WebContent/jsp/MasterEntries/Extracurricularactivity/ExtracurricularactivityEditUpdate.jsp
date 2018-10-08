<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry" />
<jsp:useBean id="activitybean" scope="page"
	class="com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityBean" />


     
<%@ page language="java" import="java.util.*"%>
<%
	String extracurricularname=request.getParameter("extracurricularname");
	String description=request.getParameter("description");
	String extracurricularactivityid=request.getParameter("extracurricularactivityid");
	String createdby = (String)session.getValue("userid");
	String Status="A";
	String LogStatus="Updated";
	
	activitybean.setCreatedby(createdby);
	activitybean.setExtracurricularactivityid(extracurricularactivityid);
	activitybean.setExtracurricularname(extracurricularname.replaceAll("&quot;","\"").trim());
	activitybean.setDescription(description.trim());
	
	activitybean.setExtracurricularstatus(Status);
	activitybean.setStatus(Status);
	activitybean.setAction(LogStatus); 
	
	int courseList = query_object.UpdateEdittExtracurricularactivity(activitybean); 
	String message="";
	

	
	if(courseList==1000)
	{
		message = " Extracurricular Activity Name  Already Exists";
	    courseList=1000;
	}
	else if(courseList==0)
	{
		message = " Extracurricular Activity Updation  Failed";

	}
	else if(courseList>=1)
	{
		message = "Extracurricular Activity Successfully  Updated";

	}
		
		String return_file =request.getContextPath()+"/jsp/MasterEntries/Extracurricularactivity/ExtracurricularactivityList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
