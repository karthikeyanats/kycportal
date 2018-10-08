<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityEntry" />
<jsp:useBean id="activitybean" scope="page"
	class="com.iGrandee.MasterEntries.Extracurricularactivity.ExtracurricularactivityBean" />

<%@ page language="java" import="java.util.*"%>
	
	
	<%
	int courseList=0;
	String extracurricularactivityid = request.getParameter("extracurricularactivityid");
	String extracurricularname = request.getParameter("extracurricularname");
	String descryption = request.getParameter("descryption");
	String createdby = (String)session.getValue("userid");
	String flage=request.getParameter("flage");
	String Status="";
	String LogStatus="";
	String message="";
	String return_file="";
	activitybean.setExtracurricularactivityid(extracurricularactivityid);
	activitybean.setExtracurricularname(extracurricularname);
	activitybean.setDescription(descryption);
	activitybean.setCreatedby(createdby);

	if(flage.equals("Trash"))
	{	
		LogStatus="Trashed";
		Status="T";
		activitybean.setStatus("A");
		activitybean.setExtracurricularstatus(Status);
		activitybean.setAction(LogStatus); 
		courseList = query_object.ExtracurricularactivityStatusUpdate(activitybean); 
		if(courseList==0)
		message="Trash";
		else
		message="Trashed";
	
		return_file =request.getContextPath()+"/jsp/MasterEntries/Extracurricularactivity/ExtracurricularactivityList.jsp";

	}
	 else if(flage.equals("Delete"))
	{	
		LogStatus="Deleted";
		Status="X";
		activitybean.setStatus("A");
		activitybean.setExtracurricularstatus(Status);
		activitybean.setAction(LogStatus); 
		courseList = query_object.ExtracurricularactivityStatusUpdate(activitybean); 
		if(courseList==0)
		message="Deletion";
		else
		message="Deleted";
		 return_file =request.getContextPath()+"/jsp/MasterEntries/Extracurricularactivity/ExtracurricularactivityTrashListview.jsp";

	} else if(flage.equals("Restore")) 
	{	
		LogStatus="Restored";
		Status="A";
		activitybean.setStatus("A");
		activitybean.setExtracurricularstatus(Status);
		activitybean.setAction(LogStatus); 
		courseList = query_object.ExtracurricularactivityStatusUpdate(activitybean); 
		if(courseList==0)
		message="Restore";
		else
		message="Restored";
		 return_file =request.getContextPath()+"/jsp/MasterEntries/Extracurricularactivity/ExtracurricularactivityTrashListview.jsp";

	}
	
	
	if(courseList==0)
	{
		message = " Extracurricular Activity "+message+" failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Extracurricular Activity Successfully  "+message;

	} 
	
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);


%>