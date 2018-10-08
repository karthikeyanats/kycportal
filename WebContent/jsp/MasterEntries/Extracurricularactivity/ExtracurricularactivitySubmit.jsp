<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry" />
<jsp:useBean id="activitybean" scope="page"
	class="com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityBean" />

<%@ page language="java" import="java.util.*"%>
<%
String message = "";
	String extracurricularname = request.getParameter("extracurricularname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String instituteid=session.getValue("instituteid")+"";
	String Status = "A";
	
	String LogStatus = "Created";
	
if(descryption.equals(""))
{
	descryption="-";
}

	activitybean.setExtracurricularname(extracurricularname.trim());
	activitybean.setDescription(descryption.trim());
	activitybean.setCreatedby(createdby);
	activitybean.setExtracurricularstatus(Status);
	activitybean.setStatus(Status);
	activitybean.setAction(LogStatus);
	activitybean.setInstituteid(instituteid);
	int courseList = query_object.insertExtracurricularactivity(activitybean); 
	

	if(courseList==1000)
	{
		message = " Extracurricular Activity Name Already Exists";
	      courseList=1000;  

	}else if(courseList==0)
	{
		message = " Extracurricular Activity  Insertion  Failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Extracurricular Activity Successfully Inserted";

	} 
	
		String return_file =request.getContextPath()+"/jsp/MasterEntries/Extracurricularactivity/ExtracurricularactivityEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
	 	
 	%>
