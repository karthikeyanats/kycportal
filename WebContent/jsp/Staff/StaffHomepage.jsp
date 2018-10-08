<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.staffportal.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" 	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript" 	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" 	src="<%=request.getContextPath()%>/jsp/kycpanel/csspopup.js"></script>

<script language='javascript'>

	function backSchedule(){
	
		document.wprkallotment.action = "Schedule.jsp";
		document.wprkallotment.submit();
	}

	function assignmentclick(obj)
	{
		var assignmentid=obj.getAttribute("assignmentid");
		document.wprkallotment.assignmentid.value=assignmentid;
		document.wprkallotment.action = "./AssignmentViewStudentHomePage.jsp";
		document.wprkallotment.submit();
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
	
	function  circularFun(obj)
	{
		var circularid= obj.getAttribute("circularidss");
		document.wprkallotment.circularid.value=circularid;
		document.wprkallotment.action = "../Parent/circularViewParentHomePage.jsp";
		document.wprkallotment.submit();
	}
	
	function profileview(obj)
	{
		document.wprkallotment.action = "<%=request.getContextPath()%>/jsp/Registration/StaffProfileView.jsp";
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
	
	Schedule wallot = new Schedule();
	HashMap hashmap = null;
	HashMap hashmap1 = null;
	String standardscheduleid = (String) session
			.getValue("standardscheduleid");
	String studentid = (String) session.getValue("studentid");

	String sectionid = request.getParameter("section");
	String instituteid = (String) session.getValue("instituteid");
	String sectionscheduleid = (String) session
			.getValue("sectionscheduleid");
	String userid = (String) session.getValue("userid");
	ArrayList periodList = wallot.loadPeriods(instituteid);
	ArrayList scheduleList = null;
	String[] staffida = session.getValueNames();
	for (int i = 0; i < staffida.length; i++) {
		//	out.println(staffida[i]);

	}
	String staffid = (String) session.getValue("staffid");
	String roleid = (String) session.getValue("roleid");
	String sessionname = (String) session.getValue("sessionname");
	String sessionid = (String) session.getValue("sessionid");
	String departmentid = (String) session.getValue("departmentid");

	ArrayList totalPeriods = null;
%>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
<div id="blanket" style="display: none;"></div>
<div id="popUpDiv" style="display: none;"><a href="#"
	onclick="popup('popUpDiv')">Click Me To Close</a>
<table id="newTable" width='100%' height="100%" align="center">
</table>
</div>
<form name='wprkallotment' method='post'><input type="hidden"
	name="backward" value="facultyhome" /> <input type="hidden"
	name="Staffid" value="<%=staffid%>"><input type="hidden"
	name="assignmentid" value=""><input type="hidden"
	name="studentdiaryid" value=""><input type="hidden"
	name="examnameid" value=""><input type="hidden"
	name="circularid" value=""><input type="hidden"
	name="table_temp" value="">
<%
	
%>
<table border='0' align="center" width="100%" height="250px"
	cellspacing=0 cellpadding=0>
	<tr>
		<td colspan='5' align="center" >
		<table border='0' align="center" width="100%" cellspacing=0
			cellpadding=20>
			<tr>
				<td width='50%'><a class='tablebold'>
				<%=bundle.getString("label.adminportal.CurrentAcademicYear") %>
				:</a>&nbsp;&nbsp;<a class="tablelight"><%=sessionname%></a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr height="250px" valign="top">
		<td width='33%' align='center' valign="top">

		<table border=0 cellpadding=0 cellspacing=0 width="100%"
			height="250px" id="rounded-corner_home">
			<thead>
				<tr height=20>
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.adminportal.Announcement") %></th>
					<th scope="col" class="rounded-q4" width="10"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td  class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<%
				if (sessionid != null && !sessionid.equals("")
						&& !sessionid.equalsIgnoreCase("null")) {
					periodList = wallot.loadPeriods(instituteid);
					totalPeriods = wallot.loadTotalPeriods(instituteid);
					scheduleList = wallot.loadStaffSchedule(userid, instituteid,sessionid);
				}
			%>
			<tbody>
				<tr valign="top" height="250px">
					<td colspan=2 valign="top">
					<table border='0' align="center" width="100%" cellspacing=0
						cellpadding=5>
						<tr>
							<td><%@ page
								import="com.iGrandee.Announcement.AnnouncementEntry"%>
							<%
								AnnouncementEntry studentquery = new AnnouncementEntry();
								ArrayList announce_list = null;
								announce_list = studentquery
										.getAnnouncementForHomeScreen(instituteid);
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
		<table border=0 cellpadding=0 cellspacing=0 width="100%"
			height="250px" id="rounded-corner_home">
			<thead>
				<tr height=20>
				
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.adminportal.Circular") %></th>
					<th scope="col" class="rounded-q4" width="10"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr valign=top height="250px">
					<td colspan=3>
					<table border='0' align="center" width="100%" cellspacing=0
						cellpadding=5>

						<%@ page import="com.iGrandee.Parent.ParentHome"%>
						<%
						ParentHome staffquery = new ParentHome();

						ArrayList circulararray =null;
						ArrayList circulararrayByrole = new ArrayList();
						HashMap circularmap = null;
						HashMap circularmapByrole=null;
						circulararray = staffquery.CircularViewForStaffHomePage(staffid);
						circulararrayByrole = staffquery.CircularViewForStaffHomePageByRole(roleid+"&"+departmentid);

						if ((circulararray != null && circulararray.size() > 0) || (circulararrayByrole != null && circulararrayByrole.size() > 0)) 
						{
							for (int i = 0; i < circulararray.size(); i++) {
								circularmap = (HashMap) circulararray.get(i);
								out.print("<tr>");
								out.print("<td valign='top'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img>&nbsp;&nbsp;&nbsp;<a href='#'  maxlength='150' circularidss='"+ circularmap.get("circularid")+ "'   onclick=circularFun(this) >"+ (String)circularmap.get("subject")+ "</a><br>"+(String)circularmap.get("cdate")+"</td>");

								circularmap = null;  
								out.print("</tr>");
								
								
							}   
							for(int j = 0; j < circulararrayByrole.size(); j++)
							{   
								circularmapByrole = (HashMap) circulararrayByrole.get(j);
								out.print("<tr>");
								out.print("<td valign='top'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img>&nbsp;&nbsp;&nbsp;<a href='#'  maxlength='150' circularidss='"+ circularmapByrole.get("circularid")+ "'   onclick=circularFun(this) >"+ (String)circularmapByrole.get("subject")+ "</a><br>"+(String)circularmapByrole.get("cdate")+"</td>");
								circularmap = null;  
								out.print("</tr>");
							}
						} else
						{
							out.print("No Items to View</font>");
						}
						%>
					</table>
					</td>
			</tbody>
		</table>
		</td>
		<td>&nbsp;&nbsp;</td>
		<td width='33%' align='center' valign="top">
		<table border=0 cellpadding=0 cellspacing=0 width="100%"
			height="250px" id="rounded-corner_home">
			<thead>
				<tr height=20 valign="top">
				
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
					<td valign="top" colspan=2>
					<table border='0' align="center" valign="top" width="100%"
						cellspacing=0 cellpadding=5>
						<%@page import="com.iGrandee.Prinicipal.PrinicipalQuery"%>

						<%
						PrinicipalQuery details = new PrinicipalQuery();
						ArrayList profiledetails = new ArrayList();
						profiledetails = details.loadprofiledetails(userid);
						for (int i = 0; i < profiledetails.size(); i++) {
							HashMap innermap = (HashMap) profiledetails.get(i);
							String username = innermap.get("uname") + "";
							String mobilenumber = innermap.get("mobilenumber") + "";
							String emailid = innermap.get("emailid") + "";
							String qualification = innermap.get("qualification") + "";

							String image = innermap.get("imagepath") + "";

							out.println("<tr>");
							out
									.println("<td rowspan=4 valign=top><img src='"
											+ request.getContextPath()
											+ "/OpenDocument?r1=path&r2="
											+ image
											+ "' alt='' title='' border='0'  width='100' height='100'/> </td>");
							out
									.println("<td><a href='#' onclick='profileview(this)' Staffid='"+staffid+"'>"
											+ username +"</a>&nbsp;,"+qualification+"</td>");
							out.println("</tr>");

							out.println("<tr>");

							out
									.println("<td>" + session.getValue("userrolename")
											+ "</td>");

							out.println("</tr>");
							out.println("<tr>");

							out.println("<td>" + mobilenumber + "</td>");

							out.println("</tr>");
							out.println("<tr>");

							out.println("<td><a href=mailto:"+emailid+">" + emailid + "</a></td>");

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
<table border='0' align="center" width="80%" height='100%' cellspacing=0
	cellpadding=0>
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


						<table border='0' align="center" width="100%" height="100%"
							cellspacing=0 cellpadding=0>
							<tr>
								<td width="100%">
								<table id="rounded-corner" border=0 summary="Department List"
									width="100%" height="50%">
									<thead>
										<tr>
											<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.adminportal.TimeTable") %></th>
											<th scope="col" class="rounded-q4" width="1%">
											</th>
										</tr>
									</thead>
									<tr>
									
										<td>
										<table border='0' align="center" width="90%" cellspacing=0
											cellpadding=0>
											<tr>
												
												<%
													boolean timetableflag = false;
													if (periodList != null && periodList.size() > 0) {
														 timetableflag = true;
														out.print("<td>"+bundle.getString("label.staffportal.Periods")+"</td>");
														for (int y = 0; y < periodList.size(); y++) {
															hashmap = (HashMap) periodList.get(y);
															out.print("<td class='tablebold' rowspan='2' nowrap>"
																	+ hashmap.get("periodname") + " <br>"
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
											
											String dayid = "";
											String dayid1 = "";
											String periodid = "";
											String periodid1 = "";

											StringBuffer buffer = new StringBuffer();

											if (totalPeriods != null && totalPeriods.size() > 0) {
												timetableflag = true;
												out.print("<tr><td>"+bundle.getString("label.staffportal.Day")+"</td></tr>");
												for (int y = 0; y < totalPeriods.size();) {

													for (innerloop = 0; innerloop < periodList.size()
															&& (y + innerloop) < totalPeriods.size(); innerloop++) {
														hashmap = (HashMap) totalPeriods
																.get((y + innerloop));

														dayid = (String) hashmap.get("dayid");
														periodid = (String) hashmap.get("periodid");

														if (innerloop == 0)
															buffer.append("<tr><td class='tablebold'>"
																	+ hashmap.get("dayname") + "</td>");

														if (scheduleList != null && scheduleList.size() > 0) {

															hashmap1 = (HashMap) scheduleList.get(0);
															dayid1 = (String) hashmap1.get("dayid");
															periodid1 = (String) hashmap1.get("periodid");

															if (dayid1.equals(dayid)
																	&& periodid1.equals(periodid)) {
																buffer
																		.append("<td align='center' class='tablelight'><span title='Standard Name : "
																				+ hashmap1
																						.get("standardname")
																				+ "'>"
																				+ hashmap1
																						.get("shortstandard")
																				+ "</span><br><span title='Section Name : "
																				+ hashmap1
																						.get("sectionname")
																				+ "'>"
																				+ hashmap1
																						.get("shortsection")
																				+ "</span><br><span title='Subject Name : "
																				+ hashmap1
																						.get("subjectname")
																				+ "'>"
																				+ hashmap1
																						.get("shortsubject")
																				+ "</span></td>");

																scheduleList.remove(0);

															} else {
																buffer
																		.append("<td align='center' class='tablelight'>-</td>");
															}

														} else {
															buffer
																	.append("<td align='center' class='tablelight'>-</td>");
														}

														//	if(hashmap.get("timetableid") == null)
														//	buffer.append("<td align='center' class='tablelight'>-</td>");
														//else
														//	buffer.append("<td align='center' class='tablelight'><span title='Standard Name : "+hashmap.get("standardname")+"'>"+hashmap.get("shortstandard")+"</span><br><span title='Section Name : "+hashmap.get("sectionname")+"'>"+hashmap.get("shortsection")+"</span><br><span title='Subject Name : "+hashmap.get("subjectname")+"'>"+hashmap.get("shortsubject")+"</span></td>");

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
										<td></td>

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
</table>
</div>








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