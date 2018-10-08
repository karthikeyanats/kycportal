<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child  - <%=bundle.getString("label.parentattendance.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>

	function backSchedule()
	{
		document.wprkallotment.action = "Schedule.jsp";
		document.wprkallotment.submit();
	}
	function previousweek()
	{
		document.wprkallotment.searchdate.value=document.wprkallotment.previousdate.value;
		document.wprkallotment.submit();
	}
	function nextweek()
	{
		document.wprkallotment.searchdate.value=document.wprkallotment.nextdate.value;
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



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.parentattendance.entryheading") %></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,com.iGrandee.Attendance.AttendanceQuery"%>
<%
	HashMap	hashmap				= null;
	String today				= DateTime.showTime("calendar");

	DateTime dateobj=new DateTime();
	String searchdate="";
	if((request.getParameter("searchdate")+"").equals("null"))
	{
		//out.println(request.getParameter("searchdate"));
		 searchdate=dateobj.getMySQLFormat(today)+"";
	}
	else
	{
		searchdate=request.getParameter("searchdate")+"";
	}

	String studentid	= (String)session.getValue("studentid");
	AttendanceQuery attencequery=new AttendanceQuery();
	
	ArrayList prenext =attencequery.getweekprenextdatesforgivendate(searchdate);
	String prevdate="";
	String nextdate="";
	if(prenext.size()>0)
	{
		ArrayList prenext2=(ArrayList)prenext.get(0);
		 prevdate=prenext2.get(0)+"";
		 nextdate=prenext2.get(1)+"";
	}
%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
	<input type=hidden name="previousdate" value="<%=prevdate%>">
	<input type=hidden name="nextdate" value="<%=nextdate%>">
		<input type=hidden name="searchdate" value="">
	
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' width='100%' height='100%'>
								<table  border='0' align="center" width="100%" cellspacing=5 cellpadding=0>

									<tr  height='25'>
										<td valign='top'>
											<table id="rounded-corner" border=0 summary="Department List" width="100%">
											    <thead>
											    	<tr>
											        	
											            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.parentattendance.StudentDetails") %></th>
											            <th scope="col" class="rounded-q4" width="2%"></th>
											        </tr>
											    </thead>
											    <tfoot>
													<tr>
														<td class="rounded-foot-left"><em></em></td>
														<td class="rounded-foot-right">&nbsp;</td>
														</tr>
												</tfoot>
											    <tr>		
											    	<td colspan='2'>											
										
										
															<%
																out.print("<table border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
																out.print("<tr><td width='17%'  class=tablebold >"+bundle.getString("label.parentattendance.StudentName") +"</td><td width='1%'  class=tablebold >:</td><td>"+session.getValue("studentname")+"</td></tr>");
																out.print("<tr><td class=tablebold >"+bundle.getString("label.parentattendance.AcademicYear") +"</td><td class=tablebold >:</td><td>"+session.getValue("sessionname")+"</td></tr>");
																if(session.getValue("groupname") == null)
																	out.print("<tr  ><td class=tablebold>"+bundle.getString("label.parentattendance.StandardName") +"</td><td class=tablebold >:</td><td>"+session.getValue("standardname")+"</td></tr>");
																else
																	out.print("<tr><td class=tablebold >"+bundle.getString("label.parentattendance.StandardName") +"</td><td class=tablebold >:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
																out.print("<tr><td class=tablebold >"+bundle.getString("label.parentattendance.SectionName") +"</td><td class=tablebold >:</td><td>"+session.getValue("sectionname")+"</td></tr>");
																out.print("<tr><td class=tablebold >"+bundle.getString("label.parentattendance.BoardName") +"</td><td class=tablebold >:</td><td>"+session.getValue("boardname")+"</td></tr>");
																out.print("<tr><td class=tablebold >"+bundle.getString("label.parentattendance.MediumName") +"</td><td class=tablebold >:</td><td>"+session.getValue("mediumname")+"</td></tr>");
																out.print("<tr><td class=tablebold >"+bundle.getString("label.parentattendance.RollNo") +"</td><td class=tablebold >:</td><td>"+session.getValue("rollno")+"</td></tr>");
																out.print("</table>");
															%>
													</td>
												</tr>
											</table>	
										
										<br><br>
										<table border=0 width="100%" class=tablebold>
										<tr>
										<td align=left><a href="#Previous" name="Previous" onclick=previousweek()>&lt; <%=bundle.getString("hlink.parentattendance.PreviousWeek") %></a></td><td align=center id="weekstatus" style="visibility:hidden">
										<%=bundle.getString("label.parentattendance.CurrentWeek") %>						
										</td><td align=right><a href="#next" name="next" onclick=nextweek()><%=bundle.getString("hlink.parentattendance.NextWeek") %> </a></td>
										</tr>
										</table>
											<table id="rounded-corner" border=0 summary="Department List" width="100%">
											    <thead>
											    <tr>
											        	<th scope="col" class="rounded-company" width="1%"></th>
											            <th scope="col" class="rounded" width="5%" ><%=bundle.getString("label.parentattendance.SL.No") %></th>
											            <th scope="col" class="rounded" width="25%" ><%=bundle.getString("label.parentattendance.Date") %></th>
											            <th scope="col" class="rounded" width="25%" ><%=bundle.getString("label.parentattendance.Day") %></th>
											            <th scope="col" class="rounded" width="45%" ><%=bundle.getString("label.parentattendance.StudentAttendanceStatus") %></th>
											            <th scope="col" class="rounded-q4" width="1%"></th>
											        </tr>
											   </thead>
											   <tfoot>
													<tr>
														<td colspan=5 class="rounded-foot-left"><em></em></td>
														<td class="rounded-foot-right">&nbsp;</td>
														</tr>
												</tfoot>
							<%
								ArrayList weekdate=attencequery.getweekdatesforgivendate(searchdate);
								//out.println(weekdate);
								if(weekdate.size()>0)
								{
								ArrayList weekdate2=(ArrayList)weekdate.get(0);
								String statusarray[]=new String[7];
								String dayarray[]=new String[7];
								String datearray[]=new String[7];
								int lenth=0;
								int lenth1=0;
								int lenth2=0;
								for(int i=0;i<weekdate2.size();i++)
								{
									ArrayList Studstate=new ArrayList();
									if(i%2==0)
									{
										Studstate=attencequery.getattendanceforstudent(studentid,weekdate2.get(i)+"");
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
										//out.println(lenth+"======="+status);

										statusarray[lenth]=status;
										datearray[lenth1]=weekdate2.get(i)+"";
										lenth++;
										lenth1++;
									}
									else
									{
										//out.println(lenth2+"======="+weekdate2.get(i));
										dayarray[lenth2]=weekdate2.get(i)+"";
										lenth2++;
									}
									//out.println(dayarray[1]);
									//out.println(statusarray[1]);

								}
								for(int y=0,z=1;y<dayarray.length;y++,z++)
								{
									//out.println(datearray[y]+"equals"+(dateobj.getMySQLFormat(today)+"").replaceAll("/","-"));
									String datedd="";
									String datefun[]=(dateobj.getMySQLFormat(today)+"").split("/");
									if(Integer.parseInt(datefun[2])<10)
										datedd=datefun[0]+"-"+datefun[1]+"-0"+datefun[2];
									else
										datedd=datefun[0]+"-"+datefun[1]+"-"+datefun[2];
									//out.println(datearray[y]+"equals"+datedd);
									if(datearray[y].equals(datedd))
									{
									out.println("<tr class=tablebold>");
									out.println("<script>document.getElementById('weekstatus').style.visibility='visible'</script>");
									}
									else
									{
									out.println("<tr>");
									}
									out.println("<td>");
									out.println("</td>");
									out.println("<td>");
									out.println(z);
									out.println("</td>");
									out.println("<td>");
									String datesplit[]=datearray[y].split("-");
									out.println(datesplit[2]+"-"+datesplit[1]+"-"+datesplit[0]);
									out.println("</td>");
									out.println("<td>");
									out.println(dayarray[y]);
									out.println("</td>");
									out.println("<td>");
									out.println(statusarray[y]);
									out.println("</td>");
									out.println("<td>");
									out.println("</td>");
									out.println("</tr>");
								}
								}
								%>		
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