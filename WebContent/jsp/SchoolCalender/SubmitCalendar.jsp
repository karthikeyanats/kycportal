
<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />

 <%@ page language="java" import="java.util.ArrayList,java.util.HashMap" %>
 <%
 try
 {
 int count=0;
 	String req_sessionid = request.getParameter("req_sessionid");
 	String req_sessionname = request.getParameter("req_sessionname");
 	//System.out.println("req_sessionid======="+req_sessionid);
	String userid =(String)session.getValue("userid");
	int cnt = 0;
 	String[] eventdate = request.getParameterValues("eventdate");
 	String[] eventdescription = request.getParameterValues("eventdescription");
 	String[] radiobut = request.getParameterValues("radiobut_hidden");
 	//System.out.println("radiobut-->"+radiobut);
String ipaddress = request.getRemoteAddr();
	String check = "notentered";
	//System.out.println("radiobut"+radiobut.length);
 	for(int i=0;i<eventdate.length;i++)
 	{
		if(!eventdate[i].equals("") || !eventdescription[i].equals("") )
		{
		 	instituteBean.setSessionid(req_sessionid);
		 	instituteBean.setIpaddress(ipaddress);
		 	instituteBean.setCreatedby(userid);
			instituteBean.setEventdate(eventdate[i]);
			instituteBean.setEventdescription(eventdescription[i]);
			instituteBean.setEventholidaystatus(radiobut[i]);
			cnt = query_object.insertSchoolCalendar(instituteBean);
			check = "entered";
		}
	}
 	String op="Inserted";
 	out.println("ssssssssss");
 	 String message="";
 	if(cnt >0)
 		message = "Successfully Calender Event "+op;
 	else
 		message = "Calender Event "+op+" failed";	
out.println(cnt);
 		String return_file =request.getContextPath()+"/jsp/SchoolCalender/SchoolCalendarView.jsp?req_sessionname="+req_sessionname+"&req_sessionid="+req_sessionid;
 	 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+cnt+"&returnurl="+return_file);
 	 	

 }
 catch(Exception e)
 {
	 System.out.println("JSP"+e);
 }
 %>

