<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Period Settings</title>
<script type="text/javascript">
function loadStatus(){

	document.frm.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
	document.frm.submit();
}
</script>
</head>
<body onload='loadStatus()'>
<form name=frm method='post'>
<%@ page language="java" %>
<%@ page import="com.iGrandee.TimeTable.PeriodTime.BroadCastSession,com.iGrandee.TimeTable.PeriodTime.PeriodBean" %>

<%
	BroadCastSession broadCastSession 	= new BroadCastSession();
	PeriodBean bean						= new PeriodBean();
	int no_of_rows	 	= 0;
	String status		= "";

	try
	{
		String mode	 		= request.getParameter("user_mode");
		String instituteid	= (String)session.getValue("instituteid");

		if(mode.equals("insert"))
		{
			String periodname 	= request.getParameter("period_name");
			String st_hr 		= request.getParameter("period_start_time_hr");
			String st_min		= request.getParameter("period_start_time_min");
			String ed_hr 		= request.getParameter("period_end_time_hr");
			String ed_min		= request.getParameter("period_end_time_min");
			String period_time 	= st_hr+":"+st_min+"-"+ed_hr+":"+ed_min;
			
			
			bean.setPeriodtime(period_time);
			bean.setPeriodnameid(periodname);
			bean.setInstituteid(instituteid);
			
			no_of_rows 			= broadCastSession.insertPeriods(bean);
			//no_of_rows 			= broadCastSession.insertPeriods(period_time, periodname, instituteid);
			
		}
		else if(mode.equals("update"))
		{
			String periodsId[] 	= request.getParameterValues("check");
			String periodname[] = request.getParameterValues("up_periodtime");
			
			bean.setPeriodids(periodsId);
			bean.setPeriodtimes(periodname);
			
			no_of_rows 			= broadCastSession.updatePeriods(bean);
			//no_of_rows 			= broadCastSession.updatePeriods(periodsId, periodname);
		}
		else if(mode.equals("delete"))
		{
			String pid[] = request.getParameterValues("check");
			bean.setPeriodids(pid);
			
			no_of_rows += broadCastSession.deletePeriods(bean);
			//no_of_rows += broadCastSession.deletePeriods(pid);
		}
				
		if(no_of_rows >= 1)	{
			
			if(mode.equals("insert"))
				status = "Period Time Successfully Inserted";
			else if(mode.equals("update"))
				status = "Period Time Successfully Updated";
			else if(mode.equals("delete"))
				status = "Period Time Successfully Deleted";
			
		}
		else {
			
			if(mode.equals("insert"))
				status = "Period Time Insertion Failure ";
			else if(mode.equals("update"))
				status = "Period Time Updation Failure ";
			else if(mode.equals("delete"))
				status = "Period Time Deletion Failure ";

		}
	}
    catch(NullPointerException ee){
    	ee.printStackTrace();
    }
 %>
<input type='hidden' name='message' 	value='<%=status%>'>
<input type='hidden' name='result' 		value='<%=no_of_rows%>'>
<input type='hidden' name='returnurl' 	value='./TimeTable/PeriodTime.jsp'>
</form>
</body>
</html>
