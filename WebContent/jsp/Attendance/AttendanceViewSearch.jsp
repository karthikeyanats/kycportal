<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Attendance View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/StyleCalender.css">

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/CalendarControl.js"></script>


<script type="text/javascript">
	function checkattendanceradio()
	{
	document.Attendance_Form.checkstatus.value="selected";
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
	if(document.Attendance_Form.checkstatus.value=="selected")
	{
	if(check_ForParticularElements(document.Attendance_Form.session,"select",document.Attendance_Form.board,"select",document.Attendance_Form.standard,"select",document.Attendance_Form.section,"select")){
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
	document.Attendance_Form.sessionname.value=document.Attendance_Form.session.options[document.Attendance_Form.session.options.selectedIndex].text;
	document.Attendance_Form.boardname.value=document.Attendance_Form.board.options[document.Attendance_Form.board.options.selectedIndex].text;
	document.Attendance_Form.standardname.value=document.Attendance_Form.standard.options[document.Attendance_Form.standard.options.selectedIndex].text;
	document.Attendance_Form.sectionname.value=document.Attendance_Form.section.options[document.Attendance_Form.section.options.selectedIndex].text;
	document.Attendance_Form.action="./StudentAttendanceView.jsp"
	document.Attendance_Form.submit();
	}
	}
	else
	{
		alert("Select Any One Search Option ");
	}
	}
function loadcombo(id,id1,flag)
{
val=id.value;
val1=id1.value;
val2=document.Attendance_Form.sessioninstituteid.value;
var url = "";
	   if(flag=="standard")
	   {
	  	  url = "./attendanceinfo.jsp?action=standard&sessionid="+val+"&boardid="+val1+"&instituteid="+val2;
	   }
	 else if(flag=="section")
	   {
		   url = "./attendanceinfo.jsp?action=section&standardscheduleid="+val1+"&instituteid="+val2;
	   }
	     else
	   {
		   alert("The Key does not match with any value,URL is Empty, Please contact Administrator/Programmer");
	   }
	   var req =initRequest();
	   req.onreadystatechange = function()
	   {
		   if (req.readyState == 4)
		   {
			   if (req.status == 200)
			   {
				  if(flag=="standard")
				  {
					parseMessages(req.responseXML,flag);
				  }
				 else if(flag=="section")
				  {
					 parseMessages(req.responseXML,flag);
				  }
				   			  
			   }
			}
	   };
	   req.open("GET", url, true);
	   req.send(null);
	}
	function parseMessages(parseXML,flag)
	{
		if(flag=="standard")
		{
			optionDelete(document.Attendance_Form.standard,'1');
			var rootObj=parseXML.getElementsByTagName("standard");
			var cNode_1=rootObj[0].childNodes.length;
			if(cNode_1>0)
			{
				for(var i=0,j=1;i<parseInt(cNode_1);i++,j++)
					{
						var standardid=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
						var standardname=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
						document.getElementById("standard").options[j] = new Option(standardname,standardid);
					}
			}
		}
		if(flag=="section")
		{
			optionDelete(document.Attendance_Form.section,'1');
			var rootObj=parseXML.getElementsByTagName("section");
			var cNode_1=rootObj[0].childNodes.length;
			if(cNode_1>0)
			{
				for(var i=0,j=1;i<parseInt(cNode_1);i++,j++)
					{
						var sectionid=rootObj[0].childNodes.item(i).childNodes.item(0).firstChild.nodeValue;
						var sectionname=rootObj[0].childNodes.item(i).childNodes.item(1).firstChild.nodeValue;
						document.getElementById("section").options[j] = new Option(sectionname,sectionid);
					}
			}
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.attendanceview")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Attendance.AttendanceQuery,com.iGrandee.Common.DateTime"%>
<%

		AttendanceQuery attencequery			= new AttendanceQuery();
		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList sessionList		= attencequery.loadyearofsession(instituteid);
		ArrayList BoardList			= attencequery.loadboard(instituteid);
		String today				= DateTime.showTime("calendar");
%>

<form name="Attendance_Form" action="" method="post">
						<input type="hidden" name="checkstatus" value="">
						<input type="hidden" name="hiddenfromdate" value="">
						<input type="hidden" name="hiddentodate" value="">
						<input type="hidden" name="todaydate" value="<%=today %>">
						<input type="hidden" name="sessionname" value="">
						<input type="hidden" name="boardname" value="">
						<input type="hidden" name="standardname" value="">
						<input type="hidden" name="sectionname" value="">
					    <input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%" colspan=5><%=bundle.getString("label.schedule.studentattendanceview")%></th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=5 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody ><tr>
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='34%'>
					<select name='session'  id='session'   validate='Academic Year' >
						<option value='0'>-Select Academic Year-</option>
						<%
							if(sessionList != null && sessionList.size()>0)
								for(int y=0;y<sessionList.size();y++){
									hashmap		= (HashMap)sessionList.get(y);
									out.print("<option value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
								}
							
						%>
					</select>
				</td>
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='34%'>
					<select name='board' id='board' validate='Board Name' onchange="loadcombo(document.getElementById('session'),this,'standard')">
						<option value='0'>-Select Board-</option>
						<%
							if(BoardList != null && BoardList.size()>0)
								for(int y=0;y<BoardList.size();y++){
									hashmap		= (HashMap)BoardList.get(y);
									String boardname=hashmap.get("boardname")+"";
									String mediumname=hashmap.get("mediumname")+"";
									if(!mediumname.equals("null"))
										boardname=boardname+" -"+mediumname;
										out.print("<option value='"+hashmap.get("boardid")+"'>"+boardname+"</option>");
								}
							
						%>
					</select>
				</td>
			</tr>
			<tr>
				<td class='tablebold' ><%=bundle.getString("label.schedule.standardname")%></td>
				<td class='tablebold'>:</td>
				<td class='tablelight'>
					<select name='standard' id='standard' validate='Standard Name' onchange="loadcombo(document.getElementById('board'),this,'section')">
						<option value='0'>-Select Standard-</option>
					</select>
				</td>
				<td class='tablebold'><%=bundle.getString("label.schedule.section")%></td>
				<td class='tablebold'>:</td>
				<td class='tablelight'>
					<select name='section' id='section' validate='Section Name' >
						<option value='0'>-Select Section-</option>
					</select>
				</td>
			</tr>
			</tbody>
			</table>
			<br>
			<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%" colspan=4><%=bundle.getString("label.schedule.attendancesearchoption")%></th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=4 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody >
			<tr>
			<td></td>
			<td class='tablebold'>
			<input type="radio" name="attendanceradio" value="today"  onclick="checkattendanceradio()">
				<%=bundle.getString("label.schedule.todaydate")%>			
			</td>
			<td class='tablebold'>
			:
			</td>
				<td>
					 <%=today %>
				</td>
							<td></td>
				
			</tr>
			<tr>
			<td></td>
			<td class='tablebold'><input type="radio" name="attendanceradio" value="date" onclick="checkattendanceradio()">
			 <%=bundle.getString("label.schedule.date")%>
			</td>
			<td class='tablebold'>
			:
			</td>
				<td  >
					 <input type='text' name='attendancedate' validate='Attendance Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Attendance_Form.attendancedate','0',event,'Not_Greater_Than_CurrentDate',Attendance_Form.todaydate)>
				</td>
							<td></td>
				
			</tr>
			<tr>
							<td></td>
			
			<td class='tablebold'><input type="radio" name="attendanceradio" value="month" onclick="checkattendanceradio()">
			 <%=bundle.getString("label.schedule.monthwise")%>
			</td>
			<td class='tablebold'>
			:
			</td>
				<td  >
						<input type='text' name='monthdate'  id='monthdate'  validate='Attendance Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' onclick="showCalendarControl('monthdate')">
				</td>
			<td></td>
				
			</tr>
		</tbody>
		</table>
		<a href="#" class="bt_blue" onclick='loadstudent()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.loadstudent")%></strong><span class="bt_blue_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>