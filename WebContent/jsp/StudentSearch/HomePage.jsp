<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.viewtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>

<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>


	
function studentprofile()
{
document.wprkallotment.action= "StudentProfileView.jsp";
			document.wprkallotment.submit();
}	
function studentdiary()
{
document.wprkallotment.action= "StudentDiary.jsp";
			document.wprkallotment.submit();
}

function studentprogressreport()
{
document.wprkallotment.action= "studentprogressReport.jsp";
			document.wprkallotment.submit();
}
function studentfees()
{
document.wprkallotment.action= "studentFees.jsp";
			document.wprkallotment.submit();
}
function studentevent()
{
document.wprkallotment.action= "StudentEvent.jsp";
			document.wprkallotment.submit();
}
function studentAttendance()
{
document.wprkallotment.action= "StudentAttendance.jsp";
			document.wprkallotment.submit();
}
function studentassignment()
{
document.wprkallotment.action= "Studentassignment.jsp";
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

<h2><%=bundle.getString("label.studentsearch.homerootpath") %></h2>
<%@ page import="java.util.*"%> <%@ page
	import="com.iGrandee.StudentSearch.StudentSearchEntry"%>
<%
	StudentSearchEntry studentquery = new StudentSearchEntry();
	HashMap map = null;
	

	ArrayList Studentpersonminidetails=null;

		
	String rollnumber = "";
	rollnumber = request.getParameter("rollnumber");
	String personid = "";
	String name = "";
	String sessionname="";
	String sectionid="";
	String standardid="";
	String sectionname="";
	String standardname="";
	String standardscheduleid="";
	String studentallocationid = "";
	String groupname =null;
	
	 //Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
	 Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)session.getValue("sessionid"));
	 
	 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0)
	 {
			
			map = (HashMap) Studentpersonminidetails.get(0);
			name = (String) map.get("uname");
			standardid = (String) map.get("standardid");
			standardid = (String) map.get("standardid");
			studentallocationid = (String) map.get("studentallocationid");
			
			standardname = (String) map.get("standardname");
			sectionname = (String) map.get("sectionname");
			standardscheduleid = (String) map.get("standardscheduleid");
			sessionname = (String) map.get("sessionname");
			groupname = (String) map.get("groupname");
			if(groupname==null)
				groupname="";
			else
				groupname=" - "+groupname;



	 }

	


%>

<form name='wprkallotment' method='post'>
<table class="bodyinnercolor" border=0 bordercolor='red' align="center"
	width="100%" height='100%' cellspacing=0 cellpadding=0>
	<tr>
		<td valign='left'>
						<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.studentsearch.hometableheading") %></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded" width="23%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded-q4" width="25%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.rollno") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=rollnumber%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.studentname") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=name%></td>
				</tr>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.academicyear") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=sessionname%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.standard") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=standardname%><%=groupname %></td>
				</tr>
				<tr>
					
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.section") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" colspan=4 width="20%"><%=sectionname%></td>
				</tr>

		</table>
		</td>
	</tr>
	</table>

	
	<br>
	<tr>
		<td  align=center>
		<table bgcolor="#ECF8FD" border=0 cellpadding=5 cellspacing=0		width="100%">
	
				<tr align=center>
					<td>
						<a href="#" onclick="studentprofile()"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Profile.png" title="STUDENT PROFILE" border=0></img></a>
					</td>
					<td>
					<a href="#" onclick="studentfees()"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Fees.png" title="STUDENT FEES DETAILS" border=0></img></a>
					</td>
					<td>
					<a href="#" onclick="studentAttendance()"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Attendance.png" title="STUDENT ATTENDANCE" border=0></img></a>
					</td>
				</tr>
				<tr align=center>
				<td>Profile</td><td>Fees</td><td>Attendance</td>
				</tr>
				
				<tr align=center>
					<td>
						<a href="#" onclick="studentdiary()"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Diary.png" title="STUDENT DIARY" border=0></img></a>
					</td>
					<td>
					<a href="#" onclick="studentassignment()"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Assignment.png" title="STUDENT ASSIGNMENT" border=0></img></a>
					</td>
					<td>
					<a href="#" onclick="studentprogressreport()"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Progress-Report.png" title="PROGRESS REPORT" border=0></img></a>
					</td>
				</tr>
				<tr align=center>
				<td>Diary</td><td>Assignment</td><td>Progress Report</td>
				</tr>
				<tr align=center>
					<td>
						<a href="#" onclick="studentevent()"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/Extra-Curricular-Event.png" title="EXTRA CURRICULAR EVENT" border=0></img></a>
					</td>
				</tr>
				<tr align=center>
				<td>Event</td>
				</tr>
						
		
		</table>
			<tbody>

<input type="hidden" name="studentallocationid" value="<%=studentallocationid %>">
<input type="hidden" name="rollnumber" value="<%=rollnumber %>">

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