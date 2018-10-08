<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameEntry" />
<jsp:useBean id="periodnamebean" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameBean" />


<%@ page language="java" import="java.util.*"%>
<%
String periodname = request.getParameter("periodname");
String periodnameid = request.getParameter("periodnameid");

String createdby = (String)session.getValue("userid");
String Status = "A";



	periodnamebean.setCreatedby(createdby);
	periodnamebean.setPeriodnamestatus(Status);
	periodnamebean.setPeriodnameid(periodnameid);
	periodnamebean.setPeriodname(periodname.replaceAll("&quot;","\"").trim());
	

	int courseList = query_object.UpdateEdittPeriodName(periodnamebean); 
	String message="";
	

	
	if(courseList==1000)
	{
		message = " Period Name Already Exists";
	    courseList=1000;
	}
	else if(courseList==0)
	{
		message = " Period Name Updation failed";

	}
	else if(courseList>=1)
	{
		message = "Successfully Period Name Updated";

	}
		
		String return_file =request.getContextPath()+"/jsp/PeriodNames/PeriodNameList.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
	
%>
