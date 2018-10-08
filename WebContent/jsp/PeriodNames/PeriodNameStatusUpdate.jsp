<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameEntry" />
<jsp:useBean id="periodnamebean" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameBean" />

<%@ page language="java" import="java.util.*"%>
	
	
	<%
	int courseList=0;
	String periodnameid = request.getParameter("periodnameid");
	String periodname = request.getParameter("periodname");
	String createdby = (String)session.getValue("userid");
	String flage=request.getParameter("flage");
	String Status="";

	String message="";
	String return_file="";
	periodnamebean.setPeriodnameid(periodnameid);
	periodnamebean.setPeriodname(periodname);
	periodnamebean.setCreatedby(createdby);
	
	if(flage.equals("Trash"))
	{	
		Status="T";
		periodnamebean.setPeriodnamestatus(Status);
		courseList = query_object.StatusUpdate(periodnamebean); 
		message="Trashed"; 
		return_file =request.getContextPath()+"/jsp/PeriodNames/PeriodNameList.jsp";

	}
	 else if(flage.equals("Delete"))
	{	
		Status="X";
		periodnamebean.setPeriodnamestatus(Status);
		courseList = query_object.StatusUpdate(periodnamebean); 
		message="Deleted"; 
		 return_file =request.getContextPath()+"/jsp/PeriodNames/PeriodNameTrashListview.jsp";

	} else if(flage.equals("Restore"))
	{	
		Status="A";
		periodnamebean.setPeriodnamestatus(Status);
		courseList = query_object.StatusUpdate(periodnamebean); 
		message="Restored"; 
		 return_file =request.getContextPath()+"/jsp/PeriodNames/PeriodNameTrashListview.jsp";

	}
	
	
	if(courseList==0)
	{
		message = " Period Name "+message+" failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Period Name "+message;

	} 
	
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);


%>