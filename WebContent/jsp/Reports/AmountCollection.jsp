<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Financial Report | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/StyleCalender.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/CalendarControl.js"></script>


<script type="text/javascript">
	function checkamountradio()
	{
	document.Amount_Form.checkstatus.value="selected";
	for(var i=0;i<document.Amount_Form.amountradio.length;i++)
	{
	if(document.Amount_Form.amountradio[i].checked)
	{
	//alert(document.Amount_Form.amountradio[i].value)
	if(document.Amount_Form.amountradio[i].value=="today")
	{
	document.Amount_Form.monthdate.disabled=true;
	document.Amount_Form.appFromdate.disabled=true;
	document.Amount_Form.appTodate.disabled=true;
	document.Amount_Form.todaydate.disabled=false;
	document.Amount_Form.monthcalendar.disabled=true;
	document.Amount_Form.fromdate.disabled=true;
	document.Amount_Form.todate.disabled=true;
	
	
	}
	else if(document.Amount_Form.amountradio[i].value=="fromtodate")
	{
	document.Amount_Form.monthdate.disabled=true;
	document.Amount_Form.todaydate.disabled=true;
	document.Amount_Form.appFromdate.disabled=false;
	document.Amount_Form.appTodate.disabled=false;
	document.Amount_Form.monthcalendar.disabled=true;
	document.Amount_Form.fromdate.disabled=false;
	document.Amount_Form.todate.disabled=false;	
	}
	else if(document.Amount_Form.amountradio[i].value=="month")
	{
	document.Amount_Form.monthdate.disabled=false;
	document.Amount_Form.todaydate.disabled=true;
	document.Amount_Form.appFromdate.disabled=true;
	document.Amount_Form.appTodate.disabled=true;
	document.Amount_Form.monthcalendar.disabled=false;
	document.Amount_Form.fromdate.disabled=true;
	document.Amount_Form.todate.disabled=true;
	}
	}
	}
	}

	function viewAmount()
	{
	var check = false;
	if(check_ForParticularElements(document.Amount_Form.session,"select")){
	if(document.Amount_Form.checkstatus.value=="selected")
	{
	for(var i=0;i<document.Amount_Form.amountradio.length;i++)
	{
	if(document.Amount_Form.amountradio[i].checked)
	{
	if(document.Amount_Form.amountradio[i].value=="today")
	{
	
	document.Amount_Form.monthdate.disabled=true;
	document.Amount_Form.appFromdate.disabled=true;
	document.Amount_Form.appTodate.disabled=true;
	document.Amount_Form.hiddenfromdate.value=document.Amount_Form.todaydate.value;
	document.Amount_Form.hiddentodate.value=document.Amount_Form.todaydate.value;
	}
	else if(document.Amount_Form.amountradio[i].value=="fromtodate")
	{
	if(check_ForParticularElements(document.Amount_Form.appFromdate,"text",document.Amount_Form.appTodate,"text"))
	{
	document.Amount_Form.monthdate.disabled=true;
	document.Amount_Form.todaydate.disabled=true;
	document.Amount_Form.hiddenfromdate.value=document.Amount_Form.appFromdate.value;
	document.Amount_Form.hiddentodate.value=document.Amount_Form.appTodate.value;
	}
	else
	{
	return false;
	}
	}
	else if(document.Amount_Form.amountradio[i].value=="month")
	{
	if(check_ForParticularElements(document.Amount_Form.monthdate,"text"))
	{
	   var months = new Array(2);
	   //months = {'January','February'};
   		months[1]  = "January";
   		months[2]  = "February";
   		months[3]  = "March";
   		months[4]  = "April";
   		months[5]  = "May";
   		months[6]  = "June";
   		months[7]  = "July";
   		months[8]  = "August";
   		months[9]  = "September";
   		months[10]  = "October";
   		months[11] = "November";
   		months[12] = "December";
   		
   		var monthpick = document.Amount_Form.monthdate.value;
   		var monthYear = monthpick.split("-");
   		//alert(monthYear[0])
   		var monthnum = monthYear[0];
   		//alert(parseInt(num,10))
   		//parseInt("He was 40")
   		var monthFullname = months[parseInt(monthnum,10)];
   		var monthShortname = monthFullname.substring(0,3);
   		
   		//alert("Full->"+monthFullname);
   		//alert("Shrt->"+monthShortname);
	document.Amount_Form.todaydate.disabled=true;
	document.Amount_Form.appFromdate.disabled=true;
	document.Amount_Form.appTodate.disabled=true;
	document.Amount_Form.hiddenfromdate.value="1-"+monthShortname+"-"+monthYear[1];
	document.Amount_Form.hiddentodate.value="31-"+monthShortname+"-"+monthYear[1];
	document.Amount_Form.hiddenmonth.value=monthFullname+"-"+monthYear[1];
	}
	else
	{
	return false;
	}
	}
	}
	}
	
	for(var i=0;i<document.Amount_Form.amountcheck.length;i++)
	{
	if(document.Amount_Form.amountcheck[i].checked==true)
	{
	check=true;
	}
	}
	
	if(check){
	document.Amount_Form.req_sessionname.value=document.Amount_Form.session.options[document.Amount_Form.session.options.selectedIndex].text;
	document.Amount_Form.req_sessionid.value=document.Amount_Form.session.options[document.Amount_Form.session.options.selectedIndex].value;
	document.Amount_Form.req_sessionstatus.value=document.Amount_Form.session.options[document.Amount_Form.session.options.selectedIndex].getAttribute("sessionstatus");

	document.Amount_Form.action="./AmountCollectionView.jsp"
	document.Amount_Form.submit();
	}
	else{
		alert("Select atleast one Check Box");
	}
	}
	else
	{
		alert("Select any one Radio Button ");
	}
	}

	}
	
	function viewStdwiseAmount()
	{
		document.Amount_Form.action="./AmountCollection_Pre.jsp"
		document.Amount_Form.submit();	
	}
	
	function loadstudent()
	{
	if(document.Amount_Form.checkstatus.value=="selected")
	{
	if(check_ForParticularElements(document.Amount_Form.session,"select",document.Amount_Form.board,"select",document.Amount_Form.standard,"select",document.Amount_Form.section,"select")){
	for(var i=0;i<document.Amount_Form.amountradio.length;i++)
	{
	if(document.Amount_Form.amountradio[i].checked)
	{
	if(document.Amount_Form.amountradio[i].value=="today")
	{
	
	document.Amount_Form.monthdate.disabled=true;
	document.Amount_Form.attendancedate.disabled=true;
	document.Amount_Form.hiddenfromdate.value=document.Amount_Form.todaydate.value;
	}
	else if(document.Amount_Form.amountradio[i].value=="fromtodate")
	{
	if(check_ForParticularElements(document.Amount_Form.attendancedate,"text"))
	{
	document.Amount_Form.monthdate.disabled=true;
	document.Amount_Form.todaydate.disabled=true;
	document.Amount_Form.hiddenfromdate.value=document.Amount_Form.attendancedate.value;
	}
	else
	{
	return false;
	}
	}
	else if(document.Amount_Form.amountradio[i].value=="month")
	{
	if(check_ForParticularElements(document.Amount_Form.monthdate,"text"))
	{
	document.Amount_Form.todaydate.disabled=true;
	document.Amount_Form.attendancedate.disabled=true;
	document.Amount_Form.hiddenfromdate.value=document.Amount_Form.monthdate.value;
	}
	else
	{
	return false;
	}
	}
	}
	}
	document.Amount_Form.sessionname.value=document.Amount_Form.session.options[document.Amount_Form.session.options.selectedIndex].text;
	document.Amount_Form.boardname.value=document.Amount_Form.board.options[document.Amount_Form.board.options.selectedIndex].text;
	document.Amount_Form.standardname.value=document.Amount_Form.standard.options[document.Amount_Form.standard.options.selectedIndex].text;
	document.Amount_Form.sectionname.value=document.Amount_Form.section.options[document.Amount_Form.section.options.selectedIndex].text;
	document.Amount_Form.action="./StudentAttendanceView.jsp"
	document.Amount_Form.submit();
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
val2=document.Amount_Form.sessioninstituteid.value;
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
			optionDelete(document.Amount_Form.standard,'1');
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
			optionDelete(document.Amount_Form.section,'1');
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="center_content">

    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.reportsfinanicialreports")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Attendance.AttendanceQuery,com.iGrandee.Common.DateTime"%>
<%

		AttendanceQuery attencequery			= new AttendanceQuery();
		HashMap	hashmap				= null;
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList sessionList		= attencequery.loadyearofsession(instituteid);
		//ArrayList BoardList			= attencequery.loadboard(instituteid);
		String today				= DateTime.showTime("calendar");
%>

<form name="Amount_Form" action="" method="post">
						<input type="hidden" name="checkstatus" value="">
						<input type="hidden" name="hiddenfromdate" value="">
						<input type="hidden" name="hiddentodate" value="">
						<input type="hidden" name="hiddenmonth" value="">						
						<input type="hidden" name="todaydate" value="<%=today %>">
						<input type="hidden" name="req_sessionname" value="">
						<input type="hidden" name="req_sessionid" value="">
						<input type="hidden" name="req_sessionstatus" value="">
						
					    <input type="hidden" name="sessioninstituteid" value="<%=instituteid %>">
						
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="95%"><%=bundle.getString("label.reports.finanicialreports")%></th>
				
				<th scope="col" class="rounded-q4" width="5%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody ><tr>
		<td colspan=2>
		<table width="90%" border=0 align=center><tr>
				<td width='25%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%> :</td>
				
				<td  class='tablelight' >
					<select name='session'  id='session'   validate='Academic Year' >
						<option value='0'>-Select Session-</option>
						<%
							if(sessionList != null && sessionList.size()>0)
								for(int y=0;y<sessionList.size();y++){
									hashmap		= (HashMap)sessionList.get(y);
									out.print("<option value='"+hashmap.get("sessionid")+"' sessionstatus='"+hashmap.get("sessionstatus")+"'>"+hashmap.get("sessionname")+"</option>");
								}
							
						%>
					</select>
				</td>
			</tr>
			</tbody>
		<tfoot>
			<tr>
				<td colspan=4 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>
		<tbody >
			<tr>
			
			<td class='tablebold'>
			<input type="radio" name="amountradio" value="today"  onclick="checkamountradio()">
			<%=bundle.getString("label.schedule.todaydate")%>
			</td>

				<td colspan=3 align=left>
					 <%=today %>
				</td>
			</tr>
			<tr>
			
			<td class='tablebold' width=20%><input type="radio" name="amountradio" value="fromtodate" onclick="checkamountradio()">
			 <%=bundle.getString("label.schedule.fromdate")%>
			</td>
				<td  width=30%>
					 <input type='text' name='appFromdate' validate='From Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' name='fromdate' onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Amount_Form.appFromdate','0',event,'Not_Greater_Than_CurrentDate',Amount_Form.appTodate)>
				</td>
				
				<td align=left class=tablebold  width=10%>
				<%=bundle.getString("label.schedule.todate")%>
				</td>
				<td  width=40%> 
				<input type='text' name='appTodate' validate='To Date ' size='15' value='' onfocus='this.blur()'><input type='button' value='^' name='todate'  onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Amount_Form.appTodate','0',event,'Not_Less_Than_StartDate',Amount_Form.appFromdate)>
				</td>
			</tr>
			<tr>
					
			
			<td class='tablebold'><input type="radio" name="amountradio" value="month" onclick="checkamountradio()">
			 <%=bundle.getString("label.schedule.monthwise")%>
			</td>

				<td>
						<input type='text' name='monthdate'  id='monthdate'  validate='Month' size='15' value='' onfocus='this.blur()'><input type='button' value='^' name='monthcalendar' onclick="showCalendarControl('monthdate')">
				</td>
			
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan=4 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>		


			<tr>
			
			<td class='tablebold' colspan=3>
			<input type="checkbox" name="amountcheck" value="AI"  >
			<%=bundle.getString("label.schedule.applicationissue")%>
			</td>

			</tr>
			<tr>
			
			<td class='tablebold' width=20%><input type="checkbox" name="amountcheck" value="AD">
			 <%=bundle.getString("label.schedule.admission")%>
			</td>
				
			</tr>
			<tr>
							
			
			<td class='tablebold'><input type="checkbox" name="amountcheck" value="FC">
			 <%=bundle.getString("label.schedule.feescollection")%>
			</td>

				
		</tr></table>
		</td>	
			</tr>
		</tbody>		
		</table>

		<a href="#" class="bt_blue" onclick='viewStdwiseAmount()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.standardwisereport")%></strong><span class="bt_blue_r"></span></a>		
		<a href="#" class="bt_green" onclick='viewAmount()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.view")%></strong><span class="bt_green_r"></span></a>
		</form>		

    </div><!-- end of right content--> 


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>