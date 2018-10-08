<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Attendance | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>

	function backSchedule()
	{
		document.wprkallotment.action = "Schedule.jsp";
		document.wprkallotment.submit();
	}
	function previousmonth1()
	{
		var date=document.wprkallotment.searchmonth.value.split("-");
		var monthdate="";
		var aa="";
		if((date[0].charAt(0)) == 0)
			aa = parseInt((date[0]).charAt(1));			
		else 
			aa = parseInt(date[0]);
		if((aa-1)==0)
		{
			monthdate="12-"+(parseInt(date[1])-1);
			document.wprkallotment.displaymonth.value="12-"+(parseInt(date[1])-1);
		}
		else
		{
			if((aa-1)<10)
				{
					document.wprkallotment.displaymonth.value="0"+(aa-1)+"-"+date[1];
				}
			else
				{
					document.wprkallotment.displaymonth.value=(aa-1)+"-"+date[1];
				}
			monthdate=(aa-1)+"-"+date[1]
		}
		
		document.wprkallotment.searchmonth.value=monthdate;
		document.wprkallotment.submit();
	}
	function nextmonth1()
	{
		var date=document.wprkallotment.searchmonth.value.split("-");
		var monthdate="";
		
		var aa="";
		if((date[0].charAt(0)) == 0)
			aa = parseInt((date[0]).charAt(1));	  		
		else 
			aa = parseInt(date[0]);  
			
		if((aa+1)==13)
		{
		monthdate="1-"+(parseInt(date[1])+1)
		document.wprkallotment.displaymonth.value="01-"+(parseInt(date[1])+1);
		}
		else
		{
		if((aa+1)<10)
		{
		document.wprkallotment.displaymonth.value="0"+(aa+1)+"-"+date[1];
		}
		else
		{
		document.wprkallotment.displaymonth.value=(aa+1)+"-"+date[1];
		}
		monthdate=(aa+1)+"-"+date[1]
		}
		document.wprkallotment.searchmonth.value=monthdate;
		document.wprkallotment.submit();
	}
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.attendancemonthlyview")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ArrayList,java.util.ResourceBundle,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.Attendance.AttendanceQuery"%>
<%
	HashMap	hashmap				= null;
	String today				= DateTime.showTime("calendar");

	DateTime dateobj=new DateTime();
	String searchmonth="";
	if((request.getParameter("searchmonth")+"").equals("null"))
	{
		String datevar[]=(dateobj.getMySQLFormat(today)+"").split("/");
		 searchmonth=datevar[1]+"-"+datevar[0];
	}
	else
	{
		searchmonth=request.getParameter("searchmonth")+"";
	}
	AttendanceQuery attencequery=new AttendanceQuery();
	String studentid				= (String)session.getValue("studentid");
	String prevmonth="";
	String nextmonth="";
	String attendancedate ="";
	String forMonth="";
	String convMonthPick ="";
	if((request.getParameter("displaymonth")+"").equals("null"))
	{
		 String datevar[]=(dateobj.getMySQLFormat(today)+"").split("/");
		 convMonthPick=datevar[1]+"-"+datevar[0];
		 //out.print("searchmonth=========>>>>>"+convMonthPick); 
	}
	else
	{
		convMonthPick=request.getParameter("displaymonth")+"";
	}

		int totalmonth=0;
	if(!convMonthPick.equals("null"))
	{
		if(convMonthPick.substring(0,2).equals("01"))
		{
			prevmonth = "December "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "January "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "February "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}
		if(convMonthPick.substring(0,2).equals("02"))
		{
		forMonth = "February "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
		prevmonth = "January "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		nextmonth = "March "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}
		if(convMonthPick.substring(0,2).equals("03"))
		{
			prevmonth = "February "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "March "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "April "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}
		if(convMonthPick.substring(0,2).equals("04"))
		{
			prevmonth = "March "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "April "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "May "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}		
		if(convMonthPick.substring(0,2).equals("05"))
		{
			prevmonth = "April "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "May "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "June "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}			
		if(convMonthPick.substring(0,2).equals("06"))
		{
			prevmonth = "May "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "June "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "July "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}	
		if(convMonthPick.substring(0,2).equals("07"))
		{
			prevmonth = "June "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "July "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "August "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}	
		if(convMonthPick.substring(0,2).equals("08"))
		{
			prevmonth = "July "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "August "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "September "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}			
		if(convMonthPick.substring(0,2).equals("09"))
		{
			prevmonth = "August "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "September "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "October "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}				
		if(convMonthPick.substring(0,2).equals("10"))
		{
			prevmonth = "September "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "October "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "November "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}	
		if(convMonthPick.substring(0,2).equals("11"))
		{
			prevmonth = "October "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "November "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "December "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}			
		if(convMonthPick.substring(0,2).equals("12"))
		{
			prevmonth = "November "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
			forMonth = "December "+convMonthPick.substring(convMonthPick.lastIndexOf("-")+1);
			nextmonth = "February "+searchmonth.substring(searchmonth.lastIndexOf("-")+1);
		}
		System.out.println("searchmonth=======>>>>>"+searchmonth);
		totalmonth=Integer.parseInt(attencequery.toGetAllDates(searchmonth));
	}
		
	%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
	<input type=hidden name="previousmonth" value="<%=prevmonth%>">
	<input type=hidden name="nextmonth" value="<%=nextmonth%>">
		<input type=hidden name="searchmonth" value="<%=searchmonth%>">
		<input type=hidden name="displaymonth" value="">
		
	
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' width='100%' height='100%'>
								<table  border='0' align="center" width="100%" cellspacing=5 cellpadding=0>

									<tr  height='25'>
										<td valign='top'>
										<table border=0 width="100%" class=tablebold>
										<tr>
										<td align=left><a href="#Previous" name="Previous" onclick="previousmonth1()"> < <%=prevmonth%></a></td><td align=center >
										<%=forMonth%>						
										</td><td align=right><a href="#next" name="next" onclick="nextmonth1()"><%=nextmonth%> > </a></td>
										</tr>
										</table>
						<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="1%" ></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.schedule.slno")%></th>
					            <th scope="col" class="rounded" 		width="25%"><%=bundle.getString("label.schedule.date")%></th>
					            <th scope="col" class="rounded" 		width="25%"><%=bundle.getString("label.schedule.day")%></th>
					            <th scope="col" class="rounded" 		width="35%"><%=bundle.getString("label.schedule.studentattendancestatus")%></th>
					        	<th scope="col" class="rounded-q4" 		width="1%"></th>
					         </tr>
					          </thead>
					    <tbody>
					<%
							out.print("<tr>");
							for(int i=1;i<=totalmonth;i++)
							{
							String monthPickarray []= convMonthPick.split("-");
							attendancedate=monthPickarray[1]+"-"+monthPickarray[0]+"-"+i;
							ArrayList Studstate=attencequery.getattendanceforview(studentid,attendancedate);
							String status="-";
							if(Studstate.size()>0)
							{
							HashMap studmap=(HashMap)Studstate.get(0);
							status=studmap.get("studentstate")+"";
							if(status.equals("P"))
								status="Present";
								else if(status.equals("A"))
								status="Absent";
								else if(status.equals("null"))
								status="-";
								else if(status.equals("OD"))
									status="On Duty";
								else
								status=status;
							}
							if(attendancedate.equals((dateobj.getMySQLFormat(today)+"").replaceAll("/","-")))
							{
							out.println("<tr class=tablebold>");
							}
							else
							{
							out.println("<tr>");
							}							
							out.print("<td></td>");
							
								out.print("<td>"+i+"</td>");
							if(i<10)
							{
								out.print("<td>0"+i+"-"+monthPickarray[0]+"-"+monthPickarray[1]+"</td>");
							}
							else
							{
								out.print("<td>"+i+"-"+monthPickarray[0]+"-"+monthPickarray[1]+"</td>");

							}
							out.print("<td>"+attencequery.toGetDayfordate(attendancedate)+"</td>");
							out.print("<td>"+status+"</td>");
							out.print("<td></td>");

							out.print("</tr>");

							}
							%>
					
						</tbody>
						</table>
									
								</table>
							</td>
						</tr>					
					</table>
				</td>
			</tr>
		</table>
	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>