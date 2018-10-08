<jsp:useBean id="query_object" scope="page"	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
	


 
 <%@ page language="java" import="java.util.ArrayList,java.util.HashMap" %>
<%!


	String seminar_str;
	int no_of_rows=0;
	String return_file = null;

	String op = null;
	boolean lnk_flag = false;
	String content = null;
	String catname =null;
	String faqid  = null;
	String sessionname = null;
	String ipaddress=null;
%>
<%
String sessionid = request.getParameter("req_sessionid");

String contexts=request.getContextPath() ;
sessionname = request.getParameter("req_sessionname");
try
{                        

	String operation = request.getParameter("mode_of_operation");

 if(operation.equals("manipulate"))
	{
	 String calendarid = request.getParameter("calendar_typeid");
		 ipaddress = request.getRemoteAddr();

			instituteBean.setSchoolcalendarid(calendarid);
	instituteBean.setIpaddress(ipaddress);
	instituteBean.setCalendarstatus("T");	
	sessionid = request.getParameter("req_sessionid");


				no_of_rows = query_object.activity(instituteBean);
			
				op = "Trashed";

				 String message="";
					if(no_of_rows >0)
						message = "Successfully Calendar Event "+op;
					else
						message = "Calendar Event"+op+" failed";	

						String return_file =request.getContextPath()+"/jsp/SchoolCalender/SchoolCalendarView.jsp?req_sessionid="+sessionid+"&req_sessionname="+sessionname;
					 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
					 	

	}
 if(operation.equals("manipulateActive"))
	{
	 String calendarid = request.getParameter("calendar_typeid");
		 ipaddress = request.getRemoteAddr();
			instituteBean.setCalendarstatus("A");	

			instituteBean.setSchoolcalendarid(calendarid);
	instituteBean.setIpaddress(ipaddress);
	sessionid = request.getParameter("req_sessionid");



				no_of_rows = query_object.activity(instituteBean);
			
				op = "Restored";
				
				 String message="";
					if(no_of_rows >0)
						message = "Succeesfully Calendar Event "+op;
					else
						message = "Calendar Event "+op+" failed";	

						String return_file =request.getContextPath()+"/jsp/SchoolCalender/SchoolCalendarTrashList.jsp?req_sessionid="+sessionid+"&req_sessionname="+sessionname;;
					 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);


	}

 if(operation.equals("manipulateDelete"))
	{
	 String calendarid = request.getParameter("calendar_typeid");
		 ipaddress = request.getRemoteAddr();
			instituteBean.setCalendarstatus("X");	

			instituteBean.setSchoolcalendarid(calendarid);
	instituteBean.setIpaddress(ipaddress);
	sessionid = request.getParameter("req_sessionid");



				no_of_rows = query_object.activity(instituteBean);
			
				op = "Deleted";
				
				 String message="";
					if(no_of_rows >0)
						message = "Succeesfully Calendar Event "+op;
					else
						message = "Calendar Event "+op+" failed";	

						String return_file =request.getContextPath()+"/jsp/SchoolCalender/SchoolCalendarTrashList.jsp?req_sessionid="+sessionid+"&req_sessionname="+sessionname;;
					 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);


	}

	if(operation.equals("status"))
		{
 	String calendar_typeid = request.getParameter("calendar_typeid");
					String state = request.getParameter("status");

					sessionid = request.getParameter("req_sessionid");

				
					if(state.equals("A"))
					{
						op = "Activated";
					}
					else
					{
						op = "DeActivated";
					}

					
					 String message="";
						if(no_of_rows >0)
							message = "Succeesfully Calender Event "+op;
						else
							message = "Calender Event "+op+" failed";	

							String return_file =request.getContextPath()+"/jsp/SchoolCalender/SchoolCalendarView.jsp?req_sessionid="+sessionid+"&req_sessionname="+sessionname;
						 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);	
					


	}      
	
   if(operation.equals("update"))
	{
		String calendarid = request.getParameter("calendar_typeid");
		String eventdate = request.getParameter("eventdate");
		String eventdescription= request.getParameter("eventdescription");
		sessionid = request.getParameter("req_sessionid");
		sessionname = request.getParameter("req_sessionname");
		String holiday_status= request.getParameter("holiday_status");
		 ipaddress = request.getRemoteAddr();
		instituteBean.setSchoolcalendarid(calendarid);
		instituteBean.setEventdate(eventdate);
		instituteBean.setEventdescription(eventdescription);
		instituteBean.setIpaddress(ipaddress);
		instituteBean.setholiday_status(holiday_status);
		sessionid = request.getParameter("req_sessionid");

		no_of_rows = query_object.modify(instituteBean);

		op = "Updated";

		 String message="";
			if(no_of_rows >0)
				message = "Succeesfully Calender Event "+op;
			else
				message = "Calendar Event "+op+" failed";	

				String return_file =request.getContextPath()+"/jsp/SchoolCalender/SchoolCalendarView.jsp?req_sessionid="+sessionid+"&req_sessionname="+sessionname;;
			 	response.sendRedirect(request.getContextPath()+"/jsp/Operation_Result.jsp?message="+message+"&result="+no_of_rows+"&returnurl="+return_file);
	}
   
 
	
}
catch(NullPointerException e)
{}      
%>    

	



