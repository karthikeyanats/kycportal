<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Attendance Entry  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	
	function loadstudent()
	{
		if(check_ForParticularElements(document.Attendance_Form.session,"select",document.Attendance_Form.board,"select",document.Attendance_Form.standard,"select",document.Attendance_Form.section,"select",document.Attendance_Form.attendancedate,"text")){
			document.Attendance_Form.sessionname.value=document.Attendance_Form.session.options[document.Attendance_Form.session.options.selectedIndex].text;
			document.Attendance_Form.boardname.value=document.Attendance_Form.board.options[document.Attendance_Form.board.options.selectedIndex].text;
			document.Attendance_Form.standardname.value=document.Attendance_Form.standard.options[document.Attendance_Form.standard.options.selectedIndex].text;
			document.Attendance_Form.sectionname.value=document.Attendance_Form.section.options[document.Attendance_Form.section.options.selectedIndex].text;
			//document.Attendance_Form.action="./StudentAttendanceEntry.jsp"
			document.Attendance_Form.action="./StudentAttendanceEntryForStaff.jsp"
			document.Attendance_Form.submit();
		}
	}
	
	function checkStandard(event){
	
		if(check_ForParticularElements(document.Attendance_Form.session,"select",document.Attendance_Form.board,"select",document.Attendance_Form.standard,"select")){
		Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Attendance_Form.attendancedate','0',event,'AttendanceDate',document.Attendance_Form.todaydate)
		//Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Attendance_Form.attendancedate','0',event,'Not_Greater_Than_CurrentDate','AttendanceDate',document.Attendance_Form.todaydate)
		}
	}
	
	
function loadcombo(id,id1,flag)
{
val=id.value;
val1=id1.value;
val2=document.Attendance_Form.sessioninstituteid.value;
var dat=new Date(); 
var url = "";
	   if(flag=="standard")
	   {
		   var val22=val.split("@");
		   val=val22[0];
	  	  url = "./attendanceinfo.jsp?action=standard&sessionid="+val+"&boardid="+val1+"&instituteid="+val2+"&dat="+dat;
	  	  document.Attendance_Form.sessionstatus.value=val22[1];
	   }
	 else if(flag=="section")
	 {
	 		//document.Attendance_Form.todaydate.value	= document.Attendance_Form.standard.options[document.Attendance_Form.standard.options.selectedIndex].getAttribute("startdate")+","+document.Attendance_Form.standard.options[document.Attendance_Form.standard.options.selectedIndex].getAttribute("enddate");
	 		document.Attendance_Form.todaydate.value	= document.Attendance_Form.standard.options[document.Attendance_Form.standard.options.selectedIndex].getAttribute("startdate")+","+document.Attendance_Form.standard.options[document.Attendance_Form.standard.options.selectedIndex].getAttribute("enddate")+","+document.Attendance_Form.todaydate.value;

		   	url = "./attendanceinfo.jsp?action=section&standardscheduleid="+val1+"&instituteid="+val2+"&dat="+dat;
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
					document.getElementById("standard").options[j].setAttribute("enddate",rootObj[0].childNodes.item(i).childNodes.item(2).firstChild.nodeValue);
					document.getElementById("standard").options[j].setAttribute("startdate",rootObj[0].childNodes.item(i).childNodes.item(3).firstChild.nodeValue);
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

    <h2><%=bundle.getString("label.schedule.attendanceentry")%></h2>
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
						<input type="hidden" name="sessionstatus" value="">
						<input type="hidden" name="todaydate" value="<%=today %>">
						<input type="hidden" name="sessionname" value="">
						<input type="hidden" name="boardname" value="">
						<input type="hidden" name="standardname" value="">
						<input type="hidden" name="sectionname" value="">
					    <input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						
		<table width='90%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%" colspan=5><%=bundle.getString("label.schedule.studentattendanceentry")%></th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=5 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody >
		<tr>
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='34%'>
					<select name='session'  id='session'   validate='Academic Year' >
						<option value='0'>-Select Academic Year-</option>
						<%
						if(sessionList != null && sessionList.size()>0)
							for(int y=0;y<sessionList.size();y++){
								hashmap		= (HashMap)sessionList.get(y);
								out.print("<option value='"+hashmap.get("sessionid")+"@"+hashmap.get("sessionstatus")+"'>"+hashmap.get("sessionname")+"</option>");
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
				<td  class='tablebold'><%=bundle.getString("label.schedule.section")%></td>
				<td class='tablebold'>:</td>
				<td class='tablelight'>
					<select name='section' id='section' validate='Section Name' >
						<option value='0'>-Select Section-</option>
					</select>
				</td>
			</tr>
			<tr>
			<td class='tablebold'>
			<%=bundle.getString("label.schedule.date")%>
			</td>
			<td class='tablebold'>
			:
			</td>
				<td width='100%' colspan=4>
					<!--<input type='text' name='attendancedate' validate='Attendance Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Attendance_Form.attendancedate','0',event,'Not_Greater_Than_CurrentDate',Attendance_Form.todaydate)>  -->
					<input type='text' name='attendancedate' validate='Attendance Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' onclick="checkStandard(event)"> 
				</td>
				
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