<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameEntry" />
<jsp:useBean id="periodnamebean" scope="page"
	class="com.iGrandee.PeriodName.PeriodNameBean" /> 

<%@ page language="java" import="java.util.*"%>
<%
String message = "";
	String periodname = request.getParameter("periodname");
	String createdby = (String)session.getValue("userid");
	String instituteid = (String)session.getValue("instituteid");
	String ipaddress = request.getRemoteAddr();
	String Status = "A";
	


	periodnamebean.setPeriodname(periodname.trim());
	periodnamebean.setCreatedby(createdby);
	periodnamebean.setPeriodnamestatus(Status); 
	periodnamebean.setInstituteid(instituteid);
	int courseList = query_object.insertPeriodname(periodnamebean); 
	

	if(courseList==1000)
	{
		message = " Period Name Already Exists";
	      courseList=1000;  

	}else if(courseList==0)
	{
		message = " Period Name Insert failed";	

	}
	else if(courseList>=1) 
	{ 
	      message = "Successfully Period Name Inserted";

	} 
	
		String return_file =request.getContextPath()+"/jsp/PeriodNames/periodnamesEntry.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	
	 	
 	%>
