<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
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
	
	
	function checkSchedule(obj){
		
		if(obj.checked){
			
			idcount					= obj.getAttribute("idcount");
			staffobj				= document.getElementById("staff"+idcount);
			subjectobj				= document.getElementById("subject"+idcount);
			staffobj.innerHTML 		= obj.getAttribute("shortstaff");
			staffobj.title			= obj.getAttribute("staffname");
			subjectobj.innerHTML 	= obj.getAttribute("shortsubject");
			subjectobj.title		= obj.getAttribute("subjectname");
			obj.setAttribute('subjectallotmentid',obj.getAttribute("subjectallotmentid"));
			checkedcount--;
		
		}
		else{
		
				idcount					= obj.getAttribute("idcount");
				staffobj				= document.getElementById("staff"+idcount);
				subjectobj				= document.getElementById("subject"+idcount);
				staffobj.innerHTML 		= "";
				staffobj.title			= "";
				subjectobj.innerHTML 	= "";
				subjectobj.title		= "";

				//obj.setAttribute('subjectallotmentid','');
				checkedcount++;
		}
	}
	
	function editSchedule(){
	
		var count		= 0;
		var schedule	= "";
	
		if(checkedcount >0){
			
			count		= parseInt(document.wprkallotment.total.value,10);
			
			schedule 	= "";
			for(var x=1;x<=count;x++){
				
				checkobj	= document.getElementById("check"+x);

				if(!checkobj.checked && !checkobj.disabled){
				
					schedule	+= checkobj.getAttribute("timetableid")+","+checkobj.getAttribute("subjectallotmentid")+",";
				}
			
			}
			
			if(schedule.length>2)
				schedule	= schedule.substring(0,schedule.length-1);
			
			document.wprkallotment.staffschedule.value	= schedule;
			
			document.wprkallotment.action = "updateschedule.jsp";
			document.wprkallotment.submit();
		
		}
		else{
			alert("Please uncheck any one period to update!.")
		}
	}
	
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
	document.wprkallotment.action = "./circularViewStaffHomePage.jsp";
		document.wprkallotment.submit();
		
	}
	function profileview(obj)
	{
	document.wprkallotment.action = "<%=request.getContextPath()%>/jsp/Registration/StaffProfileView.jsp";
	document.wprkallotment.submit();
	}
	function backfun()
	{
	document.wprkallotment.action = "./SubjectAllotment.jsp";
	document.wprkallotment.submit();
	}

	function printfun()
	{
	window.open("PrintPreviewStaffTimetable.jsp?&req_sessionname="+document.wprkallotment.req_sessionname.value+"&session="+document.wprkallotment.req_sessionid.value+"&userid="+document.wprkallotment.req_userid.value+"&rolename="+document.wprkallotment.rolename.value+"&username="+document.wprkallotment.username.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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
<h2>Reports / Session wise Report / Staff Allotment List / Subject Allotment Details</h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule,com.iGrandee.Prinicipal.PrinicipalQuery"%>
 <%
 	//ResourceBundle bundle = ResourceBundle.getBundle("ResourceBundle.English_en");
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
 	//String userid = (String) session.getValue("userid");
 	String userid = request.getParameter("userid");
 	
 	ArrayList periodList = wallot.loadPeriods(instituteid);
 	ArrayList scheduleList = wallot.loadStudentSchedule(
 			sectionscheduleid, instituteid);
 	String[] staffida=session.getValueNames();
 	for(int i=0;i<staffida.length;i++)
 	{
 	 //	out.println(staffida[i]);

 	}
 	String staffid =(String)session.getValue("staffid");
 	String roleid =(String)session.getValue("roleid");
	String sessionname			= (String)session.getValue("sessionname");
	String sessionid = (String) session.getValue("sessionid");
String departmentid=(String)session.getValue("departmentid");
	
	ArrayList totalPeriods = null;
 %>
<jsp:useBean id="common_data_object" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
<div id="blanket" style="display: none;"></div>
<div id="popUpDiv" style="display: none;"><a href="#"
	onclick="popup('popUpDiv')">Click Me To Close</a>
<table id="newTable" width='100%' height="100%" align="center">
</table>
</div>
<form name='wprkallotment' method='post'>
<input type="hidden" name="backward" value="facultyhome"/>

<input type="hidden"
	name="Staffid" value="<%=staffid%>">
<input type="hidden"
	name="assignmentid" value=""><input type="hidden"
	name="studentdiaryid" value=""><input type="hidden"
	name="examnameid" value=""><input type="hidden"
	name="circularid" value=""><input type="hidden"
	name="table_temp" value="">
<input type=hidden name=req_userid value="<%=userid%>">
<input type=hidden name=rolename value="<%=request.getParameter("rolename")%>">
<input type=hidden name=username value="<%=request.getParameter("staffname")%>">

	
<input type=hidden name=req_sessionid value="<%=request.getParameter("req_sessionid")%>">
<input type=hidden name=req_sessionname value="<%=request.getParameter("req_sessionname") %>">
<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">	

	<%
						if (sessionid != null && !sessionid.equals("")
								&& !sessionid.equalsIgnoreCase("null")) {
							periodList = wallot.loadPeriods(instituteid);
							totalPeriods = wallot.loadTotalPeriods(instituteid);
							scheduleList = wallot.loadStaffSchedule(userid, instituteid,
									sessionid);
					%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        
								            <th scope="col" class="rounded-company" width="98%">Subject Allotment Details</th>
								            <th scope="col" class="rounded-q4" width="1%"></th>
								        </tr>
								    </thead>
								    <tr>
								    	<td colspan='2'>							
							
											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'>Academic Year</td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=request.getParameter("req_sessionname") %>
													</td>
													
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'>Department</td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=request.getParameter("deptname") %>
													</td>													
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'>Role</td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<%=request.getParameter("rolename") %>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'>Staff Name</td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<%=request.getParameter("staffname") %>
													</td>
												</tr>												
											<%
											if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
											{
											%>
											
											<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%' valign=top >Archival Details</td>
													<td  class='tablebold' width='1' valign=top >:</td>
													<td valign=top class='tablelight' align=left><h2>This is an Archived Year</h2></td>
											</tr>
											<%
											} 
											%>												
											</table>
										</td>
									</tr>
								</table>
								<%} %>
								<br></br>
								
									<% 
					if(periodList != null && periodList.size()>6){
					%>
					<div class="myScrollingDiv">											
					<%}%>
					
								<table id="rounded-corner" border=0 
							width="100%">
							<thead>
								<tr>
								
									<th scope="col" class="rounded-company" width="98%">Time Table
									View</th>
									<th scope="col" class="rounded-q4" width="1%"></th>
								</tr>
							</thead>
							<tr>
								<td colspan='2'>

								<table border='1' align="center" width="100%" cellspacing=0
									cellpadding=5>
									<tr>
										<td>Periods</td>
										<%
											if (periodList != null && periodList.size() > 0) {
													for (int y = 0; y < periodList.size(); y++) {
														hashmap = (HashMap) periodList.get(y);
														out.print("<td class='tablebold' rowspan='2' nowrap>"
																+ hashmap.get("periodname") + " <br>"
																+ hashmap.get("periodtime") + "</td>");
													}
												}
										%>
									</tr>
									<tr>
										<td>Day</td>
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

											out.print(buffer.toString());
											idcount--;
									%>
								</table>
								</td></tr></table>
								<%if(periodList != null && periodList.size()>6){%>
			</div>
			<%}%>
				<a href="#" class="bt_blue" onClick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
				<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>				
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