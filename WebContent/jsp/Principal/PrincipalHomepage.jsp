<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Principal Home Page  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/csspopup.js"></script>
<script language='javascript'>


	
	var checkedcount		= 0;
	var idcount				= "";
	var checkobj;
	var staffobj;
	var subjectobj;	
	var tempobj;
	var flag				= false;
	
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
//document.wprkallotment.action = "./circularViewHMHomePage.jsp";
		document.wprkallotment.action = "../Parent/circularViewParentHomePage.jsp";
	
		document.wprkallotment.submit();
		
	}
	function studenttimetable()
	{
	document.wprkallotment.action = "./TimeTableForStaff.jsp";
			document.wprkallotment.submit();
	
	}
	function studentabbsentess()
	{
	document.wprkallotment.action = "";
	document.wprkallotment.submit();
	}
		function studentfess()
	{
	
	document.wprkallotment.action = "../Fees/FeesCollection_pre.jsp";
	document.wprkallotment.submit();
	}
	function profileview()
	{
	document.wprkallotment.action = "<%=request.getContextPath()%>/jsp/Registration/StaffProfileView.jsp";
	document.wprkallotment.submit();
	}
</script>
<style type="text/css">
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
	String standardscheduleid = (String) session
			.getValue("standardscheduleid");
	String studentid = (String) session.getValue("studentid");

	String sectionid = request.getParameter("section");
	String instituteid = (String) session.getValue("instituteid");
	String sectionscheduleid = (String) session
			.getValue("sectionscheduleid");
	String userid = (String) session.getValue("userid");
	ArrayList periodList = wallot.loadPeriods(instituteid);
	ArrayList scheduleList = wallot.loadStudentSchedule(
			sectionscheduleid, instituteid);
	String[] staffida = session.getValueNames();
	for (int i = 0; i < staffida.length; i++) {
		// out.println(staffida[i]);

	}
	String staffid = (String) session.getValue("staffid");
	String roleid = (String) session.getValue("roleid");
	String sessionname = (String) session.getValue("sessionname");
	String sessionid = (String) session.getValue("sessionid");
	String departmentid=(String)session.getValue("departmentid");
	ArrayList totalPeriods = null;
	
	
%> <jsp:useBean id="common_data_object" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
<div id="blanket" style="display: none;"></div>
<div id="popUpDiv" style="display: none;"><a href="#"
	onclick="popup('popUpDiv')">Click Me To Close</a>
<table id="newTable" width='100%' height="100%" align="center">
</table>
</div>
<form name='wprkallotment' method='post'><input type="hidden"
	name="assignmentid" value=""><input type="hidden"
	name="studentdiaryid" value=""><input type="hidden"
	name="examnameid" value=""><input type="hidden"
	name="circularid" value=""><input type="hidden"
	name="table_temp" value="">
	<input type="hidden" name="Staffid" value="<%=staffid%>">
	<input type="hidden" name="backward" value="principalhome"/>
	
		<table border='0' align="center" cellspacing=0	cellpadding=5 align=left >
									<tr>
										<td class='tablebold'><%=bundle.getString("label.adminportal.CurrentAcademicYear") %></td>
										<td>:</td></td><td ><%=sessionname%></td>
									</tr>
								</table><br>
 
		<table border=0 cellpadding=10 cellspacing=0 width="100%">
<tr valign=top>
<td width="60%">
<table border=0 cellpadding=0 cellspacing=0 width="100%" id="rounded-corner_home" >
<thead>
<tr>
<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Quickview") %></th>
<th scope="col" class="rounded-q4" width="10%" ></th>

</tr>
</thead>
<tfoot>
<tr>
<td   class="rounded-foot-left"><em></em></td>
<td class="rounded-foot-right">&nbsp;</td>
</tr>
</tfoot>
<tr>
<td colspan=2>
<table border=0 cellpadding=0 cellspacing=0 width="100%">

<tr align=center>
	<td><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Teachers Time Table.png" title="Staff Time Table" border=0></img></td>
	<td><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Student Absent.png" title="Today Student Absentees" border=0></img></td>
</tr>
<tr align=center class=tablebold>
	<td><a href="<%=request.getContextPath()%>/jsp/Principal/TimeTableForStaff.jsp">Staff TimeTable</a></td>
	<td><a href="<%=request.getContextPath()%>/jsp/Attendance/YearofsessionAttendanceView.jsp" title="Today Student Absentees">Today Student Absentees</a></td>
</tr>

<tr align=center>
	<td><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/student-search.png" title="Student Search" border=0></img></td>
		<td><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/result-analysis.png" title="Result Analysis" border=0></img></td>
	
</tr>

<tr align=center class=tablebold>
<td><a href="<%=request.getContextPath()%>/jsp/StudentSearch/StudentSearch.jsp" title="Student Search">Student Search</a></td>
	<td><a href="<%=request.getContextPath()%>/jsp/Reports/Reportanalysis.jsp" title="Result Analysis">Result Analysis</a></td>
</tr>

</table>

</td>
</tr>
</table>
</td>
<td width="40%" valign=top>
<table border="0" width="100%">
<tr><td>
<table border=0  cellpadding=0 cellspacing=0 width="100%" height='100%'
			id="rounded-corner_home">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Profile") %></th>
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
				<tr>
					<td colspan=2 valign=top >
											<table border='0' align="center" width="100%" valign=top cellspacing=0
												cellpadding=5>

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
										.println("<td><a href='#' onclick='profileview(this)' Staffid='"+staffid+"' >"
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

								out.println("<td>" + emailid + "</td>");

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
								</table>

</td></tr>
<tr><td>
<table border=0 cellpadding=0 cellspacing=0 width="100%" id="rounded-corner_home" >
<thead>
<tr>
<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Circular") %></th>
<th scope="col" class="rounded-q4" width="10%" ></th>

</tr>
</thead>
<tfoot>
<tr>
<td class="rounded-foot-left"><em></em></td>
<td class="rounded-foot-right">&nbsp;</td>
</tr>
</tfoot>
<tr>
<td colspan=2>
<table border='0' align="center" width="100%" cellspacing=0 cellpadding=5>
												<%@ page import="com.iGrandee.Parent.ParentHome"%>
												<%
												ParentHome staffquery = new ParentHome();

												ArrayList circulararray = null;
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
														out.print("<td valign='top'>=></td><td valign='top'  maxlength='150'><a href='#'  maxlength='150' circularidss='"+ circularmap.get("circularid")+ "'   onclick=circularFun(this) >"+ (String)circularmap.get("subject")+ "</a><br>"+(String) circularmap.get("cdate")+"</td>");

														circularmap = null;  
														out.print("</tr>");
														
														
													}
													for(int j = 0; j < circulararrayByrole.size(); j++)
													{
														circularmapByrole = (HashMap) circulararrayByrole.get(j);
														out.print("<tr>");
														out.print("<td valign='top'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img></td><td valign='top'  maxlength='150'><a href='#'  maxlength='150' circularidss='"+ circularmapByrole.get("circularid")+ "'   onclick=circularFun(this) >"+ (String)circularmapByrole.get("subject")+"</a><br>"+(String) circularmapByrole.get("cdate")+"</td>");

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
</tr>
</table>
</td></tr>

<tr><td>
<table border=0 cellpadding=0 cellspacing=0 width="100%" id="rounded-corner_home" >
<thead>
<tr>
<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.adminportal.Announcement") %></th>
<th scope="col" class="rounded-q4" width="10" ></th>

</tr>
</thead>
<tfoot>
<tr>
<td class="rounded-foot-left"><em></em></td>
<td class="rounded-foot-right">&nbsp;</td>
</tr>
</tfoot>
<tr>
<td colspan=2>
<%@ page import="com.iGrandee.Announcement.AnnouncementEntry"%>
<table border='0' align="center" width="100%" cellspacing=0 cellpadding=4>
											<tr>
												<td>
												<%
													AnnouncementEntry studentquery = new AnnouncementEntry();
													ArrayList announce_list = null;
													announce_list = studentquery.getAnnouncementForHomeScreen(instituteid);
													out
															.print("<marquee  onmouseover=this.stop() onmouseout=this.start() class=tablelight direction='up' height=170 scrollamount=1 scrolldelay='2'><br>");
													if (announce_list != null && announce_list.size() > 0) {
														for (int i = 0; i < announce_list.size(); i++) {
															HashMap announce_map = (HashMap) announce_list.get(i);
															String announcement = announce_map
																	.get("annoucementdetails").toString();
															out.print("<br><p align='justify'>" + (announcement)
																	+ "</p><br>");
															announce_map = null;

														}
														announce_list = null;
														out.print("</marquee");
													} else {
														out.print("<td colspan=4>No Items to View</td>");
													}
												%>
												</td>
											</tr>

										</table>

</td>
</tr>
</table>

</td></tr>

</table>	
</td>
</tr>
</table>	



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