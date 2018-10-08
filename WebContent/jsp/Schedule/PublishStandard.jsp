<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		//alert(document.wkrkallotmentsubmit.status.value);
		document.wkrkallotmentsubmit.action = "OperationResult.jsp";			
		document.wkrkallotmentsubmit.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Work Allotment</title>
</head>
<body onload='LoadStatus()'>
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page language="java" import="com.iGrandee.Schedule.Schedule,com.iGrandee.Schedule.ScheduleBean"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	
		Schedule	schedule	= new Schedule();
		ScheduleBean bean		= new ScheduleBean();
		
		String status			= null;
		int result				= 0;
		String sessionid		= request.getParameter("session");
		String boardid			= request.getParameter("board");
		String instituteid		= (String)session.getValue("instituteid");
		String userid			= (String)session.getValue("userid");
		String archival			= request.getParameter("archival");
		
		
		try{
			bean.setStandardids(request.getParameterValues("checkstandard"));
			bean.setGroupids(request.getParameterValues("groups"));
			bean.setStartdates(request.getParameterValues("starts"));
			bean.setEnddates(request.getParameterValues("ends"));
			bean.setNoofseatss(request.getParameterValues("totalseat"));
			bean.setLastdate(request.getParameter("lastdate"));
			bean.setSessionid(request.getParameter("session"));
			bean.setInstituteid(instituteid);
			bean.setUserid(userid);
			bean.setIpaddress(request.getRemoteAddr());
			result				= schedule.publishStandards(bean);
			
			//result					= schedule.publishStandards(
			//
			//		request.getParameterValues("checkstandard"),
			//		request.getParameterValues("groups"),
			//		request.getParameterValues("starts"),
			//		request.getParameterValues("ends"),
			//		request.getParameter("lastdate"),
			//		request.getParameter("session"),
			//		instituteid,
			//		userid,
			//		request.getRemoteAddr()
			//);
			
		}
		catch(Exception e){
			
		}
		
		
		
		
		
		if(result >0)
			status	= "Standard Published Successfully.";
		else
			status	= "Standard Publishing Failed.";


	%>
	
	<input type='hidden' name='session' 	value='<%=sessionid%>'>
	<input type='hidden' name='board' 		value='<%=boardid%>'>
	<input type='hidden' name='message' 	value='<%=status%>'>
	<input type='hidden' name='archival' 	value='<%=archival%>'>
	<input type='hidden' name='returnurl' 	value='StandardSchedule.jsp'>
	<input type='hidden' name='result' 		value='<%=result%>'>
	<input type='hidden' name='archival' 	value='<%=archival%>'>
	</form>
</body>
</html>