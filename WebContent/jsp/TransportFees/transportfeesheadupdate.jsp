<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.TrasportFeesHeadAction" />
<jsp:useBean id="transportRouteBean" scope="page"
	class="com.iGrandee.TransportFees.TrasportFeesHead" />

	
<%@ page language="java" import="java.util.*"%>
<%
try{
	String transportfeesheadname=request.getParameter("routename");
	transportfeesheadname=transportfeesheadname.replaceAll("&quot;","\"");
	String transportfeesheadid=request.getParameter("transportfeesheadid");
	//System.out.println("transportfeesheadid==>>"+transportfeesheadid);
	//System.out.println("transportfeesheadname==>>"+transportfeesheadname);
	String instituteid = (String)session.getValue("instituteid"); 
	transportRouteBean.setInstituteid(instituteid);
	 
	
	int courseList = query_object.updatetranspotfeeshead(transportfeesheadid,transportfeesheadname,instituteid);
	 
	String message="";
	if(courseList ==1)
	{
		message = "Transport Fees Head Name Successfully Updated"; 
	}
	else if(courseList ==0)
	{
		message = " Transport Fees Head Name Updation  Failed";	
	}
	else if(courseList ==1000)
	{
		message = " Fees Head Name Already Exist";	
		courseList=1000;
	}

		String return_file =request.getContextPath()+"/jsp/TransportFees/transportFeeslist.jsp";
	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+courseList+"&returnurl="+return_file);
	 	
}
catch(Exception e)
{
	e.printStackTrace();	
}
%>
