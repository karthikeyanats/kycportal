<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.parenthome.entrytitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>

	function assignmentclick(obj)
	{
	var assignmentid=obj.getAttribute("assignmentid");
	document.wprkallotment.assignmentid.value=assignmentid;
	document.wprkallotment.action = "../Student/AssignmentViewStudentHomePage.jsp";
		document.wprkallotment.submit();
	}

	function examyclick(obj)
	{
	var examnameid=obj.getAttribute("examnameid");
	document.wprkallotment.examnameid.value=examnameid;
	document.wprkallotment.action = "../Exam/ExamSchedule/ExamScheduleListStudentHomepage.jsp";
		document.wprkallotment.submit();
	}
	function  circularFun(obj)
	{
	var circularid= obj.getAttribute("circularidss");
	
	document.wprkallotment.circularid.value=circularid;
	document.wprkallotment.action = "./circularViewParentHomePage.jsp";
		document.wprkallotment.submit();
		
	}
</script>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.studentportal.rootpath")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule,com.iGrandee.Parent.ParentHome"%>

<%
	
	Schedule wallot = new Schedule();
	HashMap hashmap = null;
	String userid = request.getParameter("userid");
	ParentHome home = new ParentHome();

	ArrayList details = home.getStudentDetails(userid);
	if (details != null && details.size() > 0) {
		hashmap = (HashMap) details.get(0);

		session.putValue("instituteid", (String) hashmap
				.get("instituteid"));
		session.putValue("institutelogo", (String) hashmap
				.get("institutelogo"));
		session.putValue("institutename", (String) hashmap
				.get("institutename"));
		session.putValue("sectionscheduleid", (String) hashmap
				.get("sectionscheduleid"));
		session.putValue("standardscheduleid", (String) hashmap
				.get("standardscheduleid"));
		session.putValue("sectionname", (String) hashmap
				.get("sectionname"));
		session.putValue("standardname", (String) hashmap
				.get("standardname"));
		session
				.putValue("boardname", (String) hashmap
						.get("boardname"));
		session.putValue("sessionname", (String) hashmap
				.get("sessionname"));
		session.putValue("studentname", (String) hashmap
				.get("studentname"));
		session.putValue("mediumname", (String) hashmap
				.get("mediumname"));
		session
				.putValue("groupname", (String) hashmap
						.get("groupname"));
		session.putValue("prefix", (String) hashmap.get("prefix"));
		session.putValue("studentid", (String) hashmap
				.get("studentallocationid"));
		session.putValue("rollno", (String) hashmap
				.get("rollno"));
		session.putValue("studentapprovalid", (String) hashmap
				.get("studentapprovalid"));		
		

	}
	String studentid = (String) session.getValue("studentid");

	String instituteid = (String) session.getValue("instituteid");
	String sectionscheduleid = (String) session
			.getValue("sectionscheduleid");
	ArrayList periodList = wallot.loadPeriods(instituteid);
	ArrayList scheduleList = wallot.loadStudentSchedule(
			sectionscheduleid, instituteid);
	String standardscheduleid = (String) session
			.getValue("standardscheduleid");
%>

 <jsp:useBean id="common_data_object" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
<form name='wprkallotment' method='post'><input type="hidden"
	name="assignmentid" value=""><input type="hidden"
	name="studentdiaryid" value=""><input type="hidden"
	name="examnameid" value="">
	
	<input type="hidden"
	name="circularid" value=""><input type="hidden"
	name="table_temp" value="">	

	
	<input type="hidden" name="assignmentid_flage" value="singleassignment"/>


						<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									
									<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.studentportal.StudentDetails")%>
									</th>
									<th scope="col" class="rounded-q4" width="1%"></th>
								</tr>
							</thead>
							<tr >
								<td colspan='3'>
								<%
									out
											.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out
											.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.parenthome.StudentName")+"</td><td width='1%'>:</td><td class='tablelight'>"
													+ session.getValue("studentname") + "</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.AcademicYear")+"</td><td>:</td><td class='tablelight'>"
											+ session.getValue("sessionname") + "</td></tr>");
									if (session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.StandardName")+"</td><td>:</td><td class='tablelight'>"
												+ session.getValue("standardname") + "</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.StandardName")+"</td><td>:</td><td class='tablelight'>"
												+ session.getValue("standardname")
												+ "&nbsp;&nbsp;[&nbsp;" + session.getValue("groupname")
												+ "&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.SectionName")+"</td><td>:</td><td class='tablelight'>"
											+ session.getValue("sectionname") + "</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.BoardName")+"</td><td>:</td><td class='tablelight'>"
											+ session.getValue("boardname") + "</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.MediumName")+"</td><td>:</td><td class='tablelight'>"
											+ session.getValue("mediumname") + "</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.parenthome.RollNo.")+"</td><td>:</td><td class='tablelight'>"
											+ session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
								%>
								</td>
							</tr>
						</table>
						<br>


<div class="myScrollingDiv">

<table  border='0' align="center" width="80%" height='100%' cellspacing=0 cellpadding=0>
	<tr>
		<td width='100%'>
		<table border=0 bordercolor='blue' align="center" width="80%"
			cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				<table border='0' align="center" width="100%" cellspacing=0
					cellpadding=0>



					<tr height='25'>
						<td valign='top' width="100%">

					<table border='0' align="center" width="100%" height="100%" cellspacing=0 cellpadding=0>
							<tr>
								<td width="100%">
								<table id="rounded-corner" border=0 summary="Department List"
									width="100%" height="50%">
									<thead>
										<tr>
											<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.adminportal.TimeTable") %>
											</th>
											<th scope="col" class="rounded-q4" width="1%"></th>
										</tr>
									</thead>

									<tr>
										<td >
										<table border='0' align="center" width="98%" cellspacing=0
											cellpadding=0>
											<tr>
												
												<%
													boolean timetableflag = false;
													if (periodList != null && periodList.size() > 0) {
														timetableflag = true;
														out.print("<td>"+bundle.getString("label.schedule.periods")+"</td>");
														for (int y = 0; y < periodList.size(); y++) {
															hashmap = (HashMap) periodList.get(y);
															out.print("<td class='tablebold' rowspan='2' nowrap>"
																	+ hashmap.get("periodname") + "<br>"
																	+ hashmap.get("periodtime") + "</td>");
														}
													}
													else
														timetableflag = false;
												%>
											</tr>
											
											<%
												int innerloop = 0;
												int getcount = 0;
												int idcount = 1;

												StringBuffer buffer = new StringBuffer();

												if (scheduleList != null && scheduleList.size() > 0) {
													out.print("<tr><td>"+bundle.getString("label.schedule.day")+"</td></tr>");
													timetableflag = true;
													for (int y = 0; y < scheduleList.size();) {

														for (innerloop = 0; innerloop < periodList.size()
																&& (y + innerloop) < scheduleList.size(); innerloop++) {
															hashmap = (HashMap) scheduleList.get((y + innerloop));

															if (innerloop == 0)
																buffer.append("<tr><td class='tablebold'>"
																		+ hashmap.get("dayname") + "</td>");

															if (hashmap.get("subjectname") == null)
																buffer
																		.append("<td align='center' class='tablelight'>-</td>");
															else
																buffer
																		.append("<td align='center' class='tablelight'><span title='Staff Name : "
																				+ hashmap.get("staffname")
																				+ "'>"
																				+ hashmap.get("shortstaff")
																				+ "</span><br><span title='Subject Name : "
																				+ hashmap.get("subjectname")
																				+ "'>"
																				+ hashmap.get("shortsubject")
																				+ "</span></td>");

															idcount++;

														}
														y += innerloop;
														innerloop = 0;
														buffer.append("</tr>");
													}
												}
												else
													timetableflag = false;

												out.print(buffer.toString());
												idcount--;
												
												if(!timetableflag)
													out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
												
											%>
										</table>
										</td>
										<td ></td>
										
									</tr>
								</table>

								</td>
							</tr>
						</table>
						
						</td>
					</tr>

				</table>

								<br>
				</td>

			</tr>
			</table>
				</td>

			</tr>
			</table>
			</div>

			<br>
			<table border=0 width=100%>
			<tr>
				<td >
				<table border=0 cellpadding=0 cellspacing=0 width="100%" height='100%'
					rules=groups>
					<tr>
						<td width="50%" valign="top">
						<table border=0 cellpadding=0 cellspacing=0 width="100%" 
							 id="rounded-corner_home"> 
							<thead>
								<tr height='20px'>
									<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Announcement") %></th>
									<th scope="col" class="rounded-q4" width="10"></th>

								</tr>
							</thead> 
							<tfoot>
								<tr height='10px'>
									<td colspan=0 class="rounded-foot-left"><em></em></td>
									<td class="rounded-foot-right">&nbsp;</td>
								</tr>
							</tfoot>
							<tbody>
								<tr height='220px'>
									<td colspan=2 valign=top>
									<table border='0' align="center" width="100%" cellspacing=0
										cellpadding=0>

										<%@ page import="com.iGrandee.Announcement.AnnouncementEntry"%>

										<%
										AnnouncementEntry studentquery = new AnnouncementEntry();
										ArrayList announce_list = new ArrayList(); 
										announce_list = studentquery.getAnnouncementForHomeScreen(instituteid);
										if (announce_list != null && announce_list.size() > 0) {
										out.print("<marquee  onmouseover=this.stop() onmouseout=this.start() class=tablelight direction='up' height=170 scrollamount=1 scrolldelay='2'><br>");
										
											for (int i = 0; i < announce_list.size(); i++) {
												HashMap announce_map = (HashMap) announce_list.get(i);
												
												String announcement = (String)announce_map.get("annoucementdetails");
												out.print("<br><p align='justify'>"+(announcement)+"</p><br>");
												announce_map = null;
												
											}
											announce_list = null;
											out.print("</marquee>");
										} else {
											out.print("<td colspan=4 valign=top>No Items to View</td>");
										}										
												
										%>




									</table>
									</td>
									</tr>
						</table>
 
						</td>
						<td>&nbsp;&nbsp;</td>

						<td width="50%" valign="top">
						<table border=0 cellpadding=0 cellspacing=0 width="100%"
							 id="rounded-corner_home">
							<thead>
								<tr  height='20px'>
									<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Circular") %></th>
									<th scope="col" class="rounded-q4" width="10"></th>

								</tr>
							</thead>
							<tfoot>
								<tr height='10px'>
									<td colspan=1 class="rounded-foot-left"><em></em></td>
									<td class="rounded-foot-right">&nbsp;</td>
								</tr>
							</tfoot>
							<tbody>
								<tr height='220px'>
									<td colspan=2 valign=top>

									<table border='0' align="center" width="100%" cellspacing=0
										cellpadding=0 height="100%" >


										<%@ page import="com.iGrandee.Parent.ParentHome"%>

										<%
										String standardid="";
										ParentHome parentquery = new ParentHome();

										ArrayList circulararray = null;
										ArrayList circularforstd = null;
										HashMap circularmap = null;
										HashMap circularmapstd = null;
										circulararray = parentquery.CircularViewForStudentPage(standardscheduleid);
										circularforstd=parentquery.CircularViewForStudentIndividual(studentid);
										if( (circulararray != null && circulararray.size() > 0) || (circularforstd != null && circularforstd.size() > 0))
										{
											for (int i = 0; i < circulararray.size(); i++) {
												circularmap = (HashMap) circulararray.get(i);
												out.print("<tr valign=top height='25px'><td><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img></td><td valign='top'  maxlength='150'><a href='#'  maxlength='150' circularidss='"+ circularmap.get("circularid")+ "'   onclick=circularFun(this) >"+ (String)circularmap.get("subject")+  "</a><br>"+circularmap.get("cdate")+"</td></tr>");
												circularmap = null;  
											} 
											for (int j = 0; j < circularforstd.size(); j++) {
												circularmapstd = (HashMap) circularforstd.get(j);
												out.print("<tr height='25px'>");
												out.print("<td valign=top height='25px'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img></td><td valign='top'  maxlength='150'><a href='#'  maxlength='150' circularidss='"+ circularmapstd.get("circularid")+ "'   onclick=circularFun(this) >"+ (String)circularmapstd.get("subject")+ "</a><br>"+circularmapstd.get("cdate")+"</td></tr>");
												circularmapstd = null;  
											}
											circularforstd = null;
											
										} else
										{
											out.print("No Items to View</font>");
										}										
										%>
									</table>
									</td>
								</tr>
						</table>

						</td>
					</tr>
				</table>





				</td>
			</tr>
		</table>


				</td>
			</tr>
		</table>

			<br>
			<table border=0 width=100%>
			<tr>
				<td >
				<table border=0 cellpadding=0 cellspacing=0 width="100%" height='100%'
					rules=groups>
					<tr>
						<td width="50%" valign="top">
						<table border=0 cellpadding=0 cellspacing=0 width="100%" 
							 id="rounded-corner_home"> 
							<thead>
								<tr  height='20px'>
									<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Exam/Date") %></th>
									<th scope="col" class="rounded-q4" width="10%"></th>

								</tr>
							</thead> 
							<tfoot>
								<tr  height='10px'>
									<td colspan=1 class="rounded-foot-left"><em></em></td>
									<td class="rounded-foot-right">&nbsp;</td>
								</tr>
							</tfoot>
							<tbody>
								<tr height='220px'>
									<td colspan=2 valign=top>
									<table border='0' align="center" width="100%" height='100%' cellspacing=0
										cellpadding=0>

										<%@ page import="com.iGrandee.Exam.ExamnameEntry"%>

										<%
										ExamnameEntry examQuery = new ExamnameEntry();
										ArrayList examarray = null;
											examarray = examQuery 
													.LoadScheduledExamForHomepage(standardscheduleid,instituteid);
											if (examarray != null && examarray.size() > 0) {
												for (int i = 0; i < examarray.size(); i++) {
													out.print("<tr valign=top>");
													HashMap examarray_map = (HashMap) examarray.get(i);
													String subject = (String) examarray_map.get("examname");
													out.print("<td><p align='justify'><a href='#' examnameid='"
															+ examarray_map.get("examnameid")
															+ "' onclick='examyclick(this)'>" + subject
															+ "&nbsp;&nbsp;"
															+ (String) examarray_map.get("examdate")
															+ "</a></p></td>");

													examarray_map = null;
													out.print("</tr>");
												}
												examarray = null;
											} else {
												out.print("No Items to View</font>");
											}
										%>




									</table>
									</td>
						</table>
 
						</td>
						<td>&nbsp;&nbsp;</td>

						<td width="50%" valign="top">
						<table border=0 cellpadding=0 cellspacing=0 width="100%"
							 id="rounded-corner_home">
							<thead>
								<tr  height='20px'>
									
									<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Assignment") %></th>
									<th scope="col" class="rounded-q4" width="10%"></th>

								</tr>
							</thead>
							<tfoot>
								<tr  height='10px'>
									<td colspan=1 class="rounded-foot-left"><em></em></td>
									<td class="rounded-foot-right">&nbsp;</td>
								</tr>
							</tfoot>
							<tbody>
								<tr height='220px'>
									<td colspan=2 valign=top>

									<table border='0' align="center" width="100%" cellspacing=0
										cellpadding=0 height="100%" >


										<%@ page import="com.iGrandee.Assignment.Assignment"%>

										<%
										Assignment Assignmentquery = new Assignment();
										String     datestatus				= "";

										ArrayList Assignmentarray =null;
										HashMap Assignmentmap = null;
											Assignmentarray = Assignmentquery.loadQuestionsForHomeScreen(
													standardscheduleid, studentid);
											
											if (Assignmentarray != null && Assignmentarray.size() > 0) {
												for (int i = 0; i < Assignmentarray.size(); i++) {

													Assignmentmap = (HashMap) Assignmentarray.get(i);
													datestatus			= (String)Assignmentmap.get("datestatus");
													out.print("<tr>");
													if(session.getValue("usercategory").equals("P"))
													{
															if(datestatus != null && datestatus.equals("Available"))
															{
															out.print("<td><p align='justify'><a href='#' assignmentid='"+ Assignmentmap.get("assignmentid")+ "' onclick=assignmentclick(this,'parent')>"+ (String) Assignmentmap.get("questionname")+ "</a></p></td>");
															}
															else
															{
																if(i==0)
																out.print("<tr><td valign=top>No Items to View</td></tr>"); 
															//out.print("<td><p align='justify'>"+ (String) Assignmentmap.get("questionname")+ "<font color='red'>&nbsp;[&nbsp;"+bundle.getString("label.assignment.DateExpired")+"&nbsp;]</font></td>");
															}
													}
													else  
													{
														if(datestatus != null && datestatus.equals("Available"))
														{
														out.print("<td valign=top><p align='justify'><a href='#' assignmentid='"+ Assignmentmap.get("assignmentid")+ "' onclick=assignmentclick(this,'student')>"+ (String) Assignmentmap.get("questionname")+ "</a></p></td>");
	
														} 
														else
														{
															if(i==0)
															out.print("<tr><td valign=top>No Items to View</td></tr>");
															//out.print("<td><p align='justify'>"+ (String) Assignmentmap.get("questionname")+ " <font color='red'>&nbsp;[&nbsp;"+bundle.getString("label.assignment.DateExpired")+"&nbsp;]</font></td>");
														}
													}
													Assignmentmap = null;
													out.print("</tr>");
												}
												Assignmentarray = null;
											} else {
												out.print("<tr><td valign=top>No Items to View</td></tr>");
											}
										%>
									</table>
									</td>
								</tr>
						</table>

						</td>
					</tr>
				</table>


				</td>
			</tr>
		</table>


				</td>
			</tr>
		</table>

<br>


</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
<!------------------------------------------------------------------------------------------------------------>







</html>

