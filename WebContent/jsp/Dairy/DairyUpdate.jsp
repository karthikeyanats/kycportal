<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<script language='javascript'>

	function LoadStatus()
	{
		//document.wkrkallotmentsubmit.action = "./../Operation_Result.jsp";
				document.wkrkallotmentsubmit.action="<%=request.getContextPath()%>/jsp/Opreation_result_withrequest.jsp";
					
		document.wkrkallotmentsubmit.submit();
	}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Schedule</title>
</head>
<body onload='LoadStatus()'>
<%@ page language="java"
	import="java.util.ResourceBundle,com.iGrandee.Dairy.DairyBean"%>
<%@ page language="java"
	import="com.iGrandee.Dairy.Dairy"%>
	
	<form name='wkrkallotmentsubmit' method='post'>
	<%
	String status			= null;
	int result				= 0;
	Dairy 	allot			= new Dairy();
	DairyBean bean			= new DairyBean();
	String userid			= (String)session.getValue("userid");
	String sessionid		= request.getParameter("session");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	String subjectid		= request.getParameter("subject");
	String subjectname		= request.getParameter("subjectname");
	String dairyid			= request.getParameter("dairyid");
	String status1			= request.getParameter("status");
	
	try{
		
		bean.setStudentdiaryid(dairyid);
		bean.setSubject(request.getParameter("topic"));
		bean.setWorkdetails(request.getParameter("description"));
		bean.setDairydate(request.getParameter("dairydate"));
		bean.setDairysubmissiondate(request.getParameter("enddate")	);
		
		if(status1 != null && status1.equals("A")){
		
			result					= allot.dairyUpdate(bean);
			
			//result					= allot.dairyUpdate(
			//		request.getParameter("topic"),
			//		request.getParameter("description"),
			//		dairyid,
			//		request.getParameter("dairydate"),
			//		request.getParameter("enddate")	

			//);
			
			if(result >0)
				status	= " Diary Successfully Updated.";
			else
				status	= "Diary Updation Failed.";
			
			
		}else if(status1 != null && status1.equals("D")){
		
			result					= allot.dairyDelete(bean);
			//result					= allot.dairyDelete(
			//		dairyid
			//);
			
			if(result == 1000)
				status	= "Some of the Student(s) replied for this diary. So you can not delete.";
			else if(result >0)
				status	= "Diary Successfully Deleted.";
			else
				status	= "Diary Deletion Failed.";
			
		}
	}
	catch(Exception e){
		
	}

	
	%>
	
	<input type='hidden' name='standardname' 	value='<%=standardname%>'>
	<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
	<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
	<input type='hidden' name='section' 		value='<%=sectionid%>'>
	<input type='hidden' name='session' 		value='<%=sessionid%>'>
	<input type='hidden' name='subject' 		value='<%=subjectid%>'>
	<input type='hidden' name='subjectname'		value='<%=subjectname%>'>
	<input type='hidden' name='standard'		value='<%=standardid%>'>
	
	<input type='hidden' name='message' 		value='<%=status%>'>
	<input type='hidden' name='result' 			value='<%=result%>'>
	<input type='hidden' name='returnurl' 		value='./Dairy/DairyView.jsp'>
	</form>
</body>
</html>