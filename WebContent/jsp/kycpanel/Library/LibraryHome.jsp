<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Dash Board  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/csspopup.js"></script>

<script language='javascript'>


function  circularFun(obj)
	{
	var circularid= obj.getAttribute("circularidss");
	
	document.wprkallotment.circularid.value=circularid;
	document.wprkallotment.action = "../Parent/circularViewParentHomePage.jsp";
		document.wprkallotment.submit();
		
	} 
	function studenttimetable()
	{
	document.wprkallotment.action = "../Principal/TimeTableForStaff.jsp";
			document.wprkallotment.submit();
	
	}
	function studentabbsentess()
	{
	document.wprkallotment.action = "../Attendance/YearofsessionAttendanceView.jsp";
	document.wprkallotment.submit();
	}
	function studentfess()
	{
	
	document.wprkallotment.action = "../Fees/FeesCollection_pre.jsp";
	document.wprkallotment.submit();
	}
	function profileview(obj)
	{
	document.wprkallotment.Staffid.value=obj.getAttribute("Staffid");
	document.wprkallotment.action = "/kycportal/jsp/Registration/StaffProfileView.jsp";
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
	import="java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"%>
<%

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
	
	/*String[] staffida = session.getValueNames();
	for (int i = 0; i < staffida.length; i++) {
		 out.println(staffida[i]);

	}*/
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
	<table border='0' align="center" width="100%" cellspacing=0	cellpadding=5>
									<tr>
										<td width='50%' class='tablebold'><%=bundle.getString("label.adminportal.CurrentAcademicYear") %></td>
										<td width='50%'><%=sessionname%></td>
									</tr>
								</table><br />
	
<table border=0 cellpadding=0 cellspacing=0 width="100%">
	<tr>
		<td width="60%" valign="top" >
			<table border=0 cellpadding=0 cellspacing=0 width="100%" id="rounded-corner_home" >
				 <thead>
				<tr valign="top">
		        	<th scope="col" class="rounded-company" width="10"></th>
		        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.adminportal.Services") %></th>
		        	<th scope="col" class="rounded-q4" width="10" ></th>
		        </tr>
		        </thead>
		        <tfoot>
    			<tr>
        			<td colspan=2  class="rounded-foot-left"><em></em></td>
        			<td class="rounded-foot-right">&nbsp;</td>
       			</tr>
    			</tfoot>
		        <tr>
		     	<td colspan=3>
			     	<table border=0 cellpadding=0 cellspacing=0 width="100%">
			     		<tr align=center><td><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Teachers Time Table.png" title="Staff Time Table" border=0></img></td><td><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/applicationissue.png" title="New Arrival" border=0></img></td></tr>
			     		<tr align=center class=tablebold><td><a href="<%=request.getContextPath()%>/jsp/TimeTable/ScheduleSelect.jsp">New Arrival</a></td><td><a href="<%=request.getContextPath()%>/jsp/ApplicationForm/ApplicationIssue_Pre1.jsp">Search</a></td></tr>
			     		
						<tr align=center><td><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Student Absent.png" title="Today Student Absentees" border=0></img></td><td><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Fees.png" title="Fees Collection" border=0></img></td></tr>
						<tr align=center class=tablebold><td><a href="<%=request.getContextPath()%>/jsp/Attendance/AdminAttendanceView.jsp" title="Today Student Absentees">Report</a></td><td><a href="<%=request.getContextPath()%>/jsp/Fees/FeesCollection_pre.jsp">Fees Collection</a></td></tr>

					</table>
		     	</td>
		      </tr>
			</table>
		</td>
		<td width="40%" valign="top">
			<table border="0" width="100%">
				<tr><td valign="top">
				<table border=0 cellpadding=0 cellspacing=0 width="100%" id="rounded-corner_home" >
	 <thead>
	<tr valign="top">
	<th scope="col" class="rounded-company" width="10"></th>
	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.adminportal.Profile") %></th>
	<th scope="col" class="rounded-q4" width="10" ></th>

</tr>
</thead>
<tfoot>
<tr>
	<td colspan=2  class="rounded-foot-left"><em></em></td>
	<td class="rounded-foot-right">&nbsp;</td>
</tr>
</tfoot>
<tr>
<td colspan=3>
<table border='0' align="center" width="100%" cellspacing=0
												cellpadding=5>
												<%@page import="com.iGrandee.Prinicipal.PrinicipalQuery"%>
												
												<%
												PrinicipalQuery details = new PrinicipalQuery();
												ArrayList profiledetails = null;
												profiledetails=details.loadprofiledetails(userid);
												for (int i = 0; i < profiledetails.size(); i++)
												{
													HashMap innermap=(HashMap)profiledetails.get(i);
													String username=innermap.get("uname")+"";
													String qualification=innermap.get("qualification")+"";
													String mobilenumber=innermap.get("mobilenumber")+"";
													String emailid=innermap.get("emailid")+"";
													String image=innermap.get("imagepath")+"";

													
													out.println("<tr>");
													out.println("<td rowspan=4 valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=path&r2="+image+"' alt='' title='' border='0'  width='100' height='100'/> </td>");
													out.println("<td><a href='#' onclick='profileview(this)' Staffid='"+staffid+"'>"+username+"</a>&nbsp;,"+qualification+"</td>");
													out.println("</tr>");

													out.println("<tr>");

													out.println("<td>"+session.getValue("userrolename")+"</td>");

													out.println("</tr>");
													out.println("<tr>");

													out.println("<td>"+mobilenumber+"</td>");

													out.println("</tr>");
													out.println("<tr>");

													out.println("<td><a href=mailto:"+emailid+">"+emailid+"</a> </td>");

													out.println("</tr>");
													out.println("<tr>");
													String rolename=session.getValue("userrolename")+"";
													/*if(rolename.equals("Student"))
														out.println("<td align =right colspan=2><a href='#' onclick='profileview(this)' Staffid='"+staffid+"'>My Profile...</a></td>");
													else
													out.println("<td align =right colspan=2><a href='#' onclick='profileview(this)' Staffid='"+staffid+"'>My Profile...</td>");*/
													out.println("</tr>");

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
	<th scope="col" class="rounded-company" width="10"></th>
	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.adminportal.Circular") %></th>
	<th scope="col" class="rounded-q4" width="10" ></th>

</tr>
</thead>
<tfoot>
<tr>
	<td colspan=2  class="rounded-foot-left"><em></em></td>
	<td class="rounded-foot-right">&nbsp;</td>
</tr>
</tfoot>
<tr>
<td colspan=3>
<table border='0' align="center" width="100%" cellspacing=0
												cellpadding=5>

												<%@ page import="com.iGrandee.Parent.ParentHome"%>
												<%
													ParentHome adminquery = new ParentHome();

													ArrayList circulararray = new ArrayList();
													ArrayList circulararrayByrole = new ArrayList();
													HashMap circularmap = null;
													HashMap circularmapByrole = null;
													circulararray = adminquery.CircularViewForAdminHomePage(staffid);  
													circulararrayByrole = adminquery.CircularViewForAdminPageByRole(roleid+"&"+departmentid);
													if ((circulararray != null && circulararray.size() > 0)
															|| (circulararrayByrole != null && circulararrayByrole
																	.size() > 0)) {
														for (int i = 0; i < circulararray.size(); i++) {
															circularmap = (HashMap) circulararray.get(i);
															out.print("<tr>");
															out.print("<td width='5%' valign=top><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img></td><td maxlength='150' valign=top><a href='#'  maxlength='150' circularidss='"
																			+ circularmap.get("circularid")
																			+ "'   onclick=circularFun(this) >"
																			+ (String) circularmap.get("subject")
																			
																			
																			+ "</a><br>"+(String) circularmap.get("cdate")+"</td>");

															circularmap = null;
															out.print("</tr>");

														}
														
														for (int j = 0; j < circulararrayByrole.size(); j++) {
															circularmapByrole = (HashMap) circulararrayByrole.get(j);
															out.print("<tr valign=top>");  
															out.print("<td width='5%'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/bullet_arrow.png' border=0></img></td><td maxlength='150'><a href='#'  maxlength='150' circularidss='"+ circularmapByrole.get("circularid")+ "'   onclick=circularFun(this) >"+ (String) circularmapByrole.get("subject")+ "</a><br>"+(String) circularmapByrole.get("cdate")+"</td>");

															circularmap = null;
															out.print("</tr>");
														}
													} else {
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
	<th scope="col" class="rounded-company" width="10"></th>
	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.adminportal.Announcement") %></th>
	<th scope="col" class="rounded-q4" width="10" ></th>

</tr>
</thead>
<tfoot>
<tr>
	<td colspan=2  class="rounded-foot-left"><em></em></td>
	<td class="rounded-foot-right">&nbsp;</td>
</tr>
</tfoot>
<tr>
<td colspan=3>

<table border='0' align="center" width="100%" cellspacing=0 cellpadding=4>
											<tr>
												<td><%@ page
													import="com.iGrandee.Announcement.AnnouncementEntry"%>
												<%

													AnnouncementEntry studentquery = new AnnouncementEntry();
													ArrayList announce_list = null;
													announce_list = studentquery.getAnnouncementForHomeScreen(instituteid); 
													out
															.print("<marquee  onmouseover=this.stop() onmouseout=this.start() class=tablelight direction='up' height=170 scrollamount=1 scrolldelay='2'><br>");
													if (announce_list != null && announce_list.size() > 0) {
														for (int i = 0; i < announce_list.size(); i++) {
															HashMap announce_map = (HashMap) announce_list.get(i);
															String announcement = (String)announce_map
																	.get("annoucementdetails");
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

<table style="hidden" class="bodyinnercolor" border='0' align="center" width="100%"
	height='100%' cellspacing=0 cellpadding=0>
	<tr>
		<td width='100%' align='center'>
		<table border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				
				</td>
			</tr>
		</table>
		<br>
		</td>
	</tr>
</table>
<input type="hidden" name="Staffid" value=""/>
<input type="hidden" name="backward" value="adminhome"/>


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