<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page language="java"
	import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child -  <%=bundle.getString("label.attendance.attendancevieew") %>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/StyleCalender.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/CalendarControl.js"></script>
<script type="text/javascript">

	function changeSession(){
		
		if(check_ForParticularElements(document.Attendance_Form.session,"select")){
			document.Attendance_Form.submit();
		}
	}
	
	function changeStandard(){
		
		if(check_ForParticularElements(document.Attendance_Form.standard,"select")){
			document.Attendance_Form.submit();
		}
	}	
	function checkattendanceradio()
	{
	for(var i=0;i<document.Attendance_Form.attendanceradio.length;i++)
	{
	if(document.Attendance_Form.attendanceradio[i].checked)
	{
	if(document.Attendance_Form.attendanceradio[i].value=="today")
	{
	document.Attendance_Form.monthdate.disabled=true;
	document.Attendance_Form.attendancedate.disabled=true;
	document.Attendance_Form.todaydate.disabled=false;
	
	}
	else if(document.Attendance_Form.attendanceradio[i].value=="date")
	{
	document.Attendance_Form.monthdate.disabled=true;
	document.Attendance_Form.todaydate.disabled=true;
	document.Attendance_Form.attendancedate.disabled=false;
	
	}
	else if(document.Attendance_Form.attendanceradio[i].value=="month")
	{
	document.Attendance_Form.monthdate.disabled=false;
	document.Attendance_Form.todaydate.disabled=true;
	document.Attendance_Form.attendancedate.disabled=true;
	}
	}
	}
	}
	function loadstudent()
	{
	if(check_ForParticularElements(document.Attendance_Form.standard,"select",document.Attendance_Form.section,"select")){
	for(var i=0;i<document.Attendance_Form.attendanceradio.length;i++)
	{
	if(document.Attendance_Form.attendanceradio[i].checked)
	{
	if(document.Attendance_Form.attendanceradio[i].value=="today")
	{
	
	document.Attendance_Form.monthdate.disabled=true;
	document.Attendance_Form.attendancedate.disabled=true;
	document.Attendance_Form.hiddenfromdate.value=document.Attendance_Form.todaydate.value;
	}
	else if(document.Attendance_Form.attendanceradio[i].value=="date")
	{
	if(check_ForParticularElements(document.Attendance_Form.attendancedate,"text"))
	{
	document.Attendance_Form.monthdate.disabled=true;
	document.Attendance_Form.todaydate.disabled=true;
	document.Attendance_Form.hiddenfromdate.value=document.Attendance_Form.attendancedate.value;
	}
	else
	{
	return false;
	}
	}
	else if(document.Attendance_Form.attendanceradio[i].value=="month")
	{
	if(check_ForParticularElements(document.Attendance_Form.monthdate,"text"))
	{
	document.Attendance_Form.todaydate.disabled=true;
	document.Attendance_Form.attendancedate.disabled=true;
	document.Attendance_Form.hiddenfromdate.value=document.Attendance_Form.monthdate.value;
	}
	else
	{
	return false;
	}
	}
	}
	}
	document.Attendance_Form.standardname.value=document.Attendance_Form.standard.options[document.Attendance_Form.standard.options.selectedIndex].text;
	document.Attendance_Form.sectionname.value=document.Attendance_Form.section.options[document.Attendance_Form.section.options.selectedIndex].text;
	document.Attendance_Form.action="./StudentAttendanceStaffView.jsp"
	document.Attendance_Form.submit();
	}
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

    <h2><%=bundle.getString("label.attendance.attendancerootpath") %></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime"%>
<%@ page language="java"
	import="com.iGrandee.Assignment.Assignment"%>
	
<%
	Assignment wallot 		= new Assignment();
	String instituteid 		= (String)session.getValue("instituteid");
	String userid 			= (String)session.getValue("userid");
	
	ArrayList academicList	= wallot.loadSessionForStaff(userid);
	HashMap	hashmap			= null;
	String sessionid		= session.getValue("sessionid")+"";
	String standardid		= request.getParameter("standard")+"";
	ArrayList standardList	= null;
	ArrayList sectionList	= null;
	String today				= DateTime.showTime("calendar");
	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null")){
		standardList	= wallot.loadStandardForStaff(userid,sessionid); 
	}
	if(standardid != null && !standardid.equals("") && !standardid.equalsIgnoreCase("null")){
		sectionList		= wallot.loadSectionForStaffUsingStandardscheduleid(userid,standardid);
	}
%>
	<form name='Attendance_Form' method='post'>
		<input type="hidden" name="hiddenfromdate" value="">
		<input type="hidden" name="hiddentodate" value="">
		<input type="hidden" name="todaydate" value="<%=today %>">
		<input type="hidden" name="sessionname" value="">
		<input type="hidden" name="boardname" value="">
		<input type="hidden" name="standardname" value="">
		<input type="hidden" name="sectionname" value="">
	    <input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center"  valign="top" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' >
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.attendance.AttendanceDetails") %></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='2'>							
							
							
											<table  border=0 bordercolor='blue' align="center" width="90%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.attendance.AcademicYear") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<%=session.getValue("sessionname") %>
													</td>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.attendance.Standard") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='standard' validate='Standard' onchange='changeStandard()' style="width:150px">
														<option value='0'>-Select Standard-</option>
														<%
														if(standardList != null && standardList.size()>0){
															for(int y=0;y<standardList.size();y++){
																hashmap		= (HashMap)standardList.get(y);
																
																String groupname = (String) hashmap.get("groupname");
												 				if(groupname==null)
												 					groupname = "";
												 				else
												 					groupname = " - "+groupname;
																if(standardid != null && standardid.equals(""+hashmap.get("standardscheduleid")))
																	out.print("<option selected value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+""+groupname+"</option>");
																else
																	out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+""+groupname+"</option>");
															}
														}
														%>											
														</select>
													</td>
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.attendance.Section") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' colspan='4'>
														<select name='section' validate='Section' style="width:150px">
															<option value='0'>-Select Section-</option>
															<%
																if(sectionList != null && sectionList.size()>0){
																for(int y=0;y<sectionList.size();y++){
																	hashmap		= (HashMap)sectionList.get(y);
																	out.print("<option value='"+hashmap.get("sectionscheduleid")+"'>"+hashmap.get("sectionname")+"</option>");
																}
															}
															%>												
														</select>
													</td>
												</tr>
												
											</table>
						
			     						</td>
			     					</tr>
			     				</table>
			     				<br>
			<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.attendance.StudentAttendanceSearchOption") %></th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody >
			<tr>
			<td colspan=2>
			<table width="100%" border=0>
				<tr>
					<td class='tablebold'>
					<input type="radio" name="attendanceradio" value="today" checked onclick="checkattendanceradio()">
					<%=bundle.getString("label.attendance.TodayDate") %>
					</td>
					<td class='tablebold'>
					:
					</td>
					<td>
						 <%=today %>
					</td>
				</tr>
				<tr>
					<td class='tablebold'><input type="radio" name="attendanceradio" value="date" onclick="checkattendanceradio()">
					 <%=bundle.getString("label.attendance.Date") %>
					</td>
					<td class='tablebold'>
					:
					</td>
						<td>
							 <input type='text' name='attendancedate' validate='Attendance Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Attendance_Form.attendancedate','0',event,'Not_Greater_Than_CurrentDate',Attendance_Form.todaydate)>
					</td>
			</tr>
			<tr>
				
			<td class='tablebold'><input type="radio" name="attendanceradio" value="month" onclick="checkattendanceradio()">
			<%=bundle.getString("label.attendance.MonthWise") %> 
			</td>
			<td class='tablebold'>
			:
			</td>
				<td  >
						<input type='text' name='monthdate'  id='monthdate'  validate='Attendance Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' onclick="showCalendarControl('monthdate')">
				</td>
			</tr>
			</table></td></tr>
		</tbody>
		</table>
		<a href="#" class="bt_blue" onclick='loadstudent()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.attendance.LoadStudent") %></strong><span class="bt_blue_r"></span></a>
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