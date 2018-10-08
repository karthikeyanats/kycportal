<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentportal.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language='javascript'>

	function backSchedule(){
	
		document.wprkallotment.action = "Schedule.jsp";
		document.wprkallotment.submit();
		
	}

	function assignmentclick(obj,flage)
	{
		var assignmentid=obj.getAttribute("assignmentid");
		document.wprkallotment.assignmentid.value=assignmentid;
		if(flage=="parent")
		{
		document.wprkallotment.action = "./AssignmentViewStudentHomePage.jsp";
		document.wprkallotment.submit();
		}
		else if(flage=="student")
		{
		document.wprkallotment.status.value="A";
		document.wprkallotment.action = "./AssignmentProcess.jsp";
		document.wprkallotment.submit();
		}
	}
	
	function diaryclick(obj)
	{
		var studentdiaryid=obj.getAttribute("studentdiaryid");
		document.wprkallotment.studentdiaryid.value=studentdiaryid;
		document.wprkallotment.action = "./Dairyview.jsp";
			document.wprkallotment.submit();
		}
		function examyclick(obj)
		{
		var examnameid=obj.getAttribute("examnameid");
		document.wprkallotment.examnameid.value=examnameid;
		document.wprkallotment.action = "../Exam/ExamSchedule/ExamScheduleListStudentHomepage.jsp";
		document.wprkallotment.submit();
	}
	
	function profileview(obj)
	{
		document.wprkallotment.action = "<%=request.getContextPath()%>/jsp/Student/StudentProfileView.jsp";
		document.wprkallotment.submit();
	}
	
	function windopen(attachments)
	{
		window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+attachments);
	}
	
	function  circularFun(obj)
	{
		var circularid= obj.getAttribute("circularidss");
		document.wprkallotment.circularid.value=circularid;
		document.wprkallotment.action = "../Parent/circularViewParentHomePage.jsp";
		document.wprkallotment.submit();
	}
	
</script>
<style type="text/css">
<!--
-->
</style>
</head>
<body>
<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.adminportal.dashboard") %></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule"%>
<%
	/* String[] staffida = session.getValueNames();
	 for (int i = 0; i < staffida.length; i++) {
	 out.println(staffida[i]);

	 }*/
		String usercategory1=(String)session.getValue("usercategory");  
String sectionname = null;
	Schedule wallot = new Schedule();
	HashMap hashmap = null;
	HashMap hashmap1 = null;
	String standardscheduleid = (String) session
			.getValue("standardscheduleid");
	String studentid = (String) session.getValue("studentid");
	sectionname = (String)session.getValue("sectionname");
	String sectionid = request.getParameter("section");
	String instituteid = (String) session.getValue("instituteid");
	String sectionscheduleid = (String) session
			.getValue("sectionscheduleid");
	String userid = (String) session.getValue("userid");
	ArrayList periodList = wallot.loadPeriods(instituteid);
	ArrayList scheduleList = wallot.loadStudentSchedule(
			sectionscheduleid, instituteid);
	
	ArrayList topper = null;
	ArrayList weaker = null;
	String studentid1 = "";
%>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
<div id="blanket" style="display: none;"></div>
<div id="popUpDiv" style="display: none;"><a href="#"
	onclick="popup('popUpDiv')">Click Me To Close</a>
<table id="newTable" width='100%' height="100%" align="center">
</table>
</div>
<form name='wprkallotment' method='post'>
<input type="hidden"	name="assignmentid" value=""/>
<input type="hidden"	name="studentdiaryid" value=""/>
<input type="hidden"	name="examnameid" value=""/>
<input type="hidden"	name="circularid" value=""/>
<input type="hidden"	name="table_temp" value=""/>
<input type="hidden"	name="status"/>
<input type="hidden"	name="pagefrom" value="homepage"/>

	
	<input type="hidden" name="assignmentid_flage" value="singleassignment"/>
		<table border='0' align="center" cellspacing=0	cellpadding=5 align=left >
									<tr>
										<td class='tablebold'><%=bundle.getString("label.adminportal.CurrentAcademicYear") %></td>
										<td>:</td></td><td ><%=session.getValue("sessionname")%></td>
									</tr>
								</table><br>
<%
	topper = wallot.checkStandardTopperWeeker(standardscheduleid,
			"desc", "3");
	weaker = wallot.checkStandardTopperWeeker(standardscheduleid,
			"asc", "10");

	if (topper != null && topper.size() > 0) {
		for (int x = 0; x < topper.size(); x++) {

			hashmap1 = (HashMap) topper.get(x);
			studentid1 = (String) hashmap1.get("studentallocationid");
			if (studentid1 != null && studentid != null
					&& studentid1.equals(studentid)) {
				out
						.print("<table width='100%' style='display:none'><tr><td colspan='4' class='tablebold'><div class='valid_box'><center>You are in Top 3 List of this Standard. Mark Scored is "
								+ hashmap1.get("totalmark")
								+ ". Position is "
								+ (x + 1)
								+ "</center></div></td></tr></table><br>");
				break;
			}
		}
	}

	if (weaker != null && weaker.size() > 0) {
		for (int x = 0; x < weaker.size(); x++) {

			hashmap1 = (HashMap) weaker.get(x);
			studentid1 = (String) hashmap1.get("studentallocationid");
			if (studentid1 != null && studentid != null
					&& studentid1.equals(studentid)) {
				out
						.print("<table width='100%' style='display:none'><tr><td colspan='4' class='tablebold'><div class='error_box'><center>You are in Weak 10 List of this Standard. Mark Scored is "
								+ hashmap1.get("totalmark")
								+ ". Position is "
								+ (x + 1)
								+ "</center></div></td></tr></table><br>");
				break;
			}
		}
	}
%>
<table border='0' align="center" width="100%" height="250px" 
	cellspacing=0 cellpadding=0>
	<!-- <tr  valign="top" height="30px">
		<td width='33%' align=right valign="middle" colspan=6>
				<a href="<%=request.getContextPath()%>/jsp/ContentManagement/ContentList.jsp"  class=tablebold>Content View</a> 
				<br>  
		</td>
		</tr> -->
	<tr  height="250px" valign="top">
		<td width='33%' align='center' valign="top">	
		<table border=0 cellpadding=0 cellspacing=0 width="100%"  height="250px"
			id="rounded-corner_home">
			<thead>
				<tr height=30>
				
					<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Announcement") %></th>
					<th scope="col" class="rounded-q4" width="10%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td  class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr valign="top" height="250px">
					<td colspan=2 valign="top">
					<table border='0' align="center" width="100%"   
						cellspacing=0 cellpadding=5>
						<tr  >
							<td><%@ page
								import="com.iGrandee.Announcement.AnnouncementEntry"%>
							<%
								AnnouncementEntry studentquery = new AnnouncementEntry();
								ArrayList announce_list =null;
								announce_list = studentquery.getAnnouncementForHomeScreen(instituteid);
								out
										.print("<marquee  onmouseover=this.stop() onmouseout=this.start() class=tablelight direction='up' height=150 scrollamount=1 scrolldelay='2'><br>");
								if (announce_list != null && announce_list.size() > 0) {
									for (int i = 0; i < announce_list.size(); i++) {
										HashMap announce_map = (HashMap) announce_list.get(i);
										String announcement = (String) announce_map
												.get("annoucementdetails");
										out.print("<br><p align='justify'>" + (announcement)
												+ "</p><br>");
										announce_map = null;

									}
									announce_list = null;
									out.print("</marquee");
								} else {
									out.print("<td colspan=4 valign=top>No Items to View</td>");
								}
							%>
							</td>
						</tr>

					</table>
					</td>
			</tbody>
		</table>
		</td>
		<td>&nbsp;&nbsp;</td>
		<td width='33%' align='center' valign=top>
		<table border=0 cellpadding=0 cellspacing=0 width="100%"   height="250px"
			id="rounded-corner_home">
			<thead>
				<tr height=30>
					<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Circular") %></th>
					<th scope="col" class="rounded-q4" width="10%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr valign=top  height="250px"  >
					<td colspan=2>
					<table border='0' align="center" width="100%" cellspacing=0
						cellpadding=5>
						
						<%@ page import="com.iGrandee.Parent.ParentHome"%>
						<%
							
							String standardid = "";
							ParentHome parentquery = new ParentHome();

							ArrayList circulararray =null;
							ArrayList circularforstd =null;
							HashMap circularmap = null;
							HashMap circularmapstd = null;

							circulararray = parentquery.CircularViewForStudentPage(standardscheduleid);
							circularforstd = parentquery
									.CircularViewForStudentIndividual(studentid);
							if ((circulararray != null && circulararray.size() > 0)
									|| (circularforstd != null && circularforstd.size() > 0)) {
								for (int i = 0; i < circulararray.size(); i++) {
									circularmap = (HashMap) circulararray.get(i);
									
									out.print("<tr valign=top ><td><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img></td><td><a href='#'  maxlength='150' circularidss='" + circularmap.get("circularid")
											+ "' onclick=circularFun(this) >"+(String) circularmap.get("subject")+"</a><br>"+(String) circularmap.get("cdate")+"</td></tr>");
									circularmap = null;
								}
								for (int j = 0; j < circularforstd.size(); j++) {
									circularmapstd = (HashMap) circularforstd.get(j);
									out.print("<tr valign=top><td><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img></td><td><a href='#'  maxlength='150' circularidss='" + circularmapstd.get("circularid")
											+ "' onclick=circularFun(this) >"+(String) circularmapstd.get("subject")+"</a><br>"+(String) circularmapstd.get("cdate")+"</td></tr>");

									circularmapstd = null;
								}
								circularforstd = null;

							} else {
								out.print("<tr valign=top><td>No Items to View</font></td></tr>");
							}
						%>
					</table>
					</td>
			</tbody>
		</table>
		</td>
		<td>&nbsp;&nbsp;</td>
		<td width='33%' align='center' valign="top">
		<table border=0 cellpadding=0 cellspacing=0 width="100%"  height="250px"
			id="rounded-corner_home">
			<thead>
				<tr height=30 >
	
					<th scope="col" class="rounded-company" width="100%" align=left><%=bundle.getString("label.adminportal.Profile") %></th>
					<th scope="col" class="rounded-q4" width="1px"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr height="250px">
				
					<td  valign="top" colspan=2>
					<table border='0' align="center" valign="top" width="100%"  
						cellspacing=0 cellpadding=5>
						<%@page import="com.iGrandee.Prinicipal.PrinicipalQuery"%>

						<%
							PrinicipalQuery details = new PrinicipalQuery();
							ArrayList profiledetails = null;
							profiledetails = details.loadprofiledetails(userid);
							for (int i = 0; i < profiledetails.size(); i++) {
								HashMap innermap = (HashMap) profiledetails.get(i);
								String username = innermap.get("uname") + "";
								String mobilenumber = innermap.get("mobilenumber") + "";
								String emailid = innermap.get("emailid") + "";
								String image = innermap.get("imagepath") + "";

								out.println("<tr>");
								out
										.println("<td rowspan=5 valign=top><img src='"
												+ request.getContextPath()
												+ "/OpenDocument?r1=path&r2="
												+ image
												+ "' alt='' title='' border='0'  width='100' height='100'/> </td>");
								out
										.println("<td><a href='#' onclick='profileview(this)' Staffid=''>"
												+ username + "</a></td>");
								out.println("</tr>");

								out.println("<tr>");

								out
										.println("<td>" + session.getValue("userrolename")
												+ "</td>");

								out.println("</tr>");
								out.println("<tr>");
								String rollnumber="";
								if(session.getValue("studentrollno")==null)
					 				rollnumber = "Not yet Generated";
								else
									rollnumber = (String)session.getValue("studentrollno");
								out.println("<td>" + rollnumber + "</td>");

								out.println("</tr>");
								
								//out.println("<tr>");
								//out.println("<td>" + mobilenumber + "</td>");
								//out.println("</tr>");
								out.println("<tr>");
								out.println("<td>" + session.getValue("standardname") + "</td>");
								out.println("</tr>");
								
								out.println("<tr>");
								out.println("<td>" + sectionname + "</td>");
								out.println("</tr>");
								
								
								
								out.println("<tr>");

								out.println("<td>&nbsp;</td><td><a href=mailto:"+emailid+">" + emailid + "</a></td>");

								out.println("</tr>");
								out.println("<tr>");
								String rolename = session.getValue("userrolename") + "";
								/*if(rolename.equals("Student"))
									out.println("<td align =right colspan=2><a href='#' onclick='profileview(this)' Staffid='"+staffid+"'>My Profile...</a></td>");
								else
								out.println("<td align =right colspan=2><a href='#' onclick='profileview(this)' Staffid='"+staffid+"'>My Profile...</td>");*/
								out.println("</tr>");

							}
						%>

					</table>
					</td>
					
			</tbody>
		</table>
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
										<table border='0' align="center" width="100%" cellspacing=0
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
													timetableflag = true;
													out.print("<tr><td>"+bundle.getString("label.schedule.day")+"</td></tr>");
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
						
									<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Exam/Date") %></th>
									<th scope="col" class="rounded-q4" width="10%"></th>

								</tr>
							</thead> 
							<tfoot>
								<tr height='10px'>
									<td class="rounded-foot-left"><em></em></td>
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
								<tr height='20px'>
									<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.adminportal.Assignment") %></th>
									<th scope="col" class="rounded-q4" width="10"></th>

								</tr>
							</thead>
							<tfoot>
								<tr height='10px'>
									<td class="rounded-foot-left"><em></em></td>
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
										    String datestatus				= "";

											ArrayList Assignmentarray =null;
											HashMap Assignmentmap = null;
											Assignmentarray = Assignmentquery.loadQuestionsForHomeScreen(
													standardscheduleid, studentid);
											if (Assignmentarray != null && Assignmentarray.size() > 0) {
												for (int i = 0; i < Assignmentarray.size(); i++) {

													Assignmentmap = (HashMap) Assignmentarray.get(i);
													datestatus			= (String)Assignmentmap.get("datestatus");
													out.print("<tr>");
													if(usercategory1.equals("P"))
													{
															if(datestatus != null && datestatus.equals("Available"))
															{
															out.print("<td><p align='justify'><a href='#' assignmentid='"+ Assignmentmap.get("assignmentid")+ "' onclick=assignmentclick(this,'parent')>"+ (String) Assignmentmap.get("questionname")+ "</a></p></td>");
															}
															else
															{
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
</html>