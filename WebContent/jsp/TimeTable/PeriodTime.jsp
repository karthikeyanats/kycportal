<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<!-- <script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>-->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">

	function cancelQuestion(){
	
		document.Period_Form.reset();
	
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
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <h2><%=bundle.getString("label.schedule.periodsettings")%></h2>
	
	<%@ page language="java" import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page language="java" import="com.iGrandee.TimeTable.PeriodTime.BroadCastSession"%>
	
		<form name="Period_Form" action="" method="post">
		<%
			String req_instituteid 				= (String)session.getValue("instituteid");
			String userid 						= (String)session.getValue("userid");
			BroadCastSession broadcastsession 	= new BroadCastSession();
			ArrayList periodList 				= broadcastsession.getPeriodName(req_instituteid,userid);
			HashMap hashmap						= null;
			ArrayList stdwise_pro 				= broadcastsession.getDateSchedulePeriods(req_instituteid,userid);
			String institute_mode 	= "";
			String admin_status 	= "";
			String broadsession 	= "Period";
			int i 					= 0;
			String req_institutename = "";


		%> 
			<input type="hidden" name="user_mode" 			value="none"> 
			<input type="hidden" name="req_instituteid" 	value="<%=req_instituteid%>">
			<input type="hidden" name="req_institutename" 	value="<%= req_institutename%>"> 
			<input type="hidden" name="back" 				value="institute">

			<table id="rounded-corner" border=0 summary="Department List" width="100%">
			    <thead>
			    	<tr>
			            <th scope="col" class="rounded-company" width="98%">Period Details</th>
			            <th scope="col" class="rounded-q4" width="1%"></th>
			        </tr>
			    </thead>
			    <tr>
			    	<td colspan='2'>
						
						<table align=center >
							<tr>
								<td class="tablebold" valign="top"><a href="../PeriodNames/periodnamesEntry.jsp"><%=bundle.getString("label.schedule.broadcastsession")%></a>&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;</td>
								<td >
									<select name="period_name" class="tablelight" size="5">
									<%
										if(periodList != null && periodList.size()>0){
											for(int u=0;u<periodList.size();u++){
												hashmap		= (HashMap)periodList.get(u);
												out.print("<option value='"+hashmap.get("periodnameid")+"'>"+hashmap.get("periodname")+"</option>");
											}
										}
									%>
									</select>
								</td>
							</tr>
							<tr>
								<td class="tablebold"><%=bundle.getString("label.schedule.timing")%>
								&nbsp;&nbsp;&nbsp;</td>
								<td>&nbsp;</td>
								<td >
								<table cellspacing="0" cellpadding="0">
									<tr>
										<td><font color=red><a class="tabletd"><%=bundle.getString("label.schedule.from")%></a></font><font color=red>*</font>
										<td><input type="text" name="period_start_time_hr" class="tablelight" size="1" value="00" maxlength="2" cname='period_start_time_hr'>
										<td class="tablebold">:</td>
										<td><input type="text" name="period_start_time_min" class="tablelight" size="1" value="00" maxlength="2" cname='period_start_time_min'>
									</tr>
									<tr>
										<td><font color=red><a class="tabletd"><%=bundle.getString("label.schedule.to")%></a></font><font color=red>*</font>
										<td><input type="text" name="period_end_time_hr" class="tablelight" size="1" value="00" maxlength="2" cname='period_end_time_hr'>
										<td class="tablebold">:</td> 
										<td><input type="text" name="period_end_time_min" class="tablelight" size="1" value="00" maxlength="2" cname='period_end_time_min'>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
				     	
     	<a href="#" class="bt_red" onclick='cancelQuestion()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.cancel")%></strong><span class="bt_red_r"></span></a>
  		<a href="#" id="period_submit"  class="bt_green" onclick='submitPeriod()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.submit")%></strong><span class="bt_green_r"></span></a>
		
		<br>
		
						<table id="entire_maintab" align="center" cellpadding=0 cellspacing=0 width="70%">
							<tr>
								<td>
								<table id="entire_subtab" border=0 bordercolor=black
									cellpadding=3 cellspacing=0 width="100%">
								</table>
								<table id="rounded-corner" border=0 summary="Department List" width="80%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="20%"><%=bundle.getString("label.schedule.select")%></th>
								            <th scope="col" class="rounded" width="50%"><%=bundle.getString("label.schedule.broadcastsession")%></th>
								            <th scope="col" class="rounded-q4" width="30%"><%=bundle.getString("label.schedule.duration")%></th>
								        </tr>
								    </thead>
								
									<%
											
											if (stdwise_pro != null && stdwise_pro.size() > 0) {
												for (i = 0; i < stdwise_pro.size(); i++) {
													
													hashmap = (HashMap) stdwise_pro.get(i);
													out.print("<tr class=tabletd height=22>");
													out.print("<td class='tabletd' align=left><input type=checkbox name=check value='"+hashmap.get("periodid")+"' periodid='"+ hashmap.get("periodid") + "' periodname='"+ hashmap.get("periodname") + "' periodtime='"+ hashmap.get("periodtime") + "' totalschedule='0' idx='" + i + "' onclick='loadValues(this);'></td>");
													out.print("<td class='tabletd' align=left><input type='hidden' class='tablelight' size='15' name='periodname' value='"+ hashmap.get("periodname") + "'><span class='tablelight' id='periodname_span'>" + hashmap.get("periodname") + "</span></td>"); 
													out.print("<td class='tabletd' align=left><input type='text' style='display:none;' class='tablelight' size='15' name='periodtime' idx='" + i + "' oldvalue='"+ hashmap.get("periodtime")+ "'  value='"+ hashmap.get("periodtime")+ "' maxlength='11' onblur='checkUpdateFormat(this);'><span class='tablelight' id='periodtime_span"+ i + "'>"+ hashmap.get("periodtime")+ "</span></td>");
													out.print("</tr>");
												}
											} else {
												out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
												//out.print("<tr class=tabletd height=22>");
												//out.print("<td class=tablebold colspan=3 align=center>"+bundle.getString("label.schedule.datanotfound")+"</td>");
												//out.print("</tr>");
											}
									%>
								</table>
								</td>
							</tr>
							<tr class=tabletd>
								<td class=tabletd>
								<br>
								<table align="center" border="0" width="100%" cellspacing="0"
									cellpadding="0">
									<tr>
									
										<td width="100%" align="center" valign="middle" height="18">

     	<!--  <a href="#" name="delete_but" id='delete_but' disabled class="bt_red" onclick='deleteProjects()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.delete")%></strong><span class="bt_red_r"></span></a>
  		<a href="#" name="update_but" id='update_but' disabled class="bt_green" onclick='updatePeriods()'><span class="bt_green_lft"></span><strong> <%=bundle.getString("label.schedule.update")%></strong><span class="bt_green_r"></span></a>-->
										
											<input type=button class=tablehead name="update_but" id='update_but' disabled value=" <%=bundle.getString("label.schedule.update")%> " onclick='updatePeriods()'>&nbsp; 
											<input type=button class=tablehead name="delete_but" id='delete_but' disabled value=" <%=bundle.getString("label.schedule.delete")%> " onclick='deleteProjects()'>&nbsp;
				
										</td>
									</tr>
								</table>
								</td>
							<tr>
						</table>
						<br>
						</td>
					</tr>	
				</table>
				<table id="insert_period" style='display:none'>
				</table>
						

</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
<head>
<script language='javascript'>

var count = 0;
function loadValues(obj)
{
	var pos = obj.getAttribute("idx");
	if(document.Period_Form.check.length > 1)
	{
		if(document.Period_Form.check[pos].checked) {
				document.Period_Form.periodtime[pos].style.display = "block";
				document.getElementById("periodtime_span"+pos).style.display = "none";
				count++;
		}
		else {
			document.Period_Form.periodtime[pos].style.display = "none";
			document.getElementById("periodtime_span"+pos).style.display = "block";
			count--;
		}
	}
	else {
		if(document.Period_Form.check.checked) {
			document.Period_Form.periodtime.style.display = "block";
			document.getElementById("periodtime_span"+pos).style.display = "none";
			count++;
		}
		else {
			document.Period_Form.periodtime.style.display = "none";
			document.getElementById("periodtime_span"+pos).style.display = "block";
			count--;
		}
	}
	
		
	if(count > 0) {
		document.getElementById("update_but").disabled = false;
		document.getElementById("delete_but").disabled = false;
	}
	else {
		document.getElementById("update_but").disabled = true;
		document.getElementById("delete_but").disabled = true;
	}
}

function updatePeriods()
{
	document.getElementById("update_but").disabled =true;
	if(count>0)
	{
		var insert_period 	= document.getElementById("insert_period");
		var tbodytab 		= document.createElement("tbody");
		
		if(document.Period_Form.check.length > 1) {
		
			for(var i=0;i<document.Period_Form.check.length;i++) {
				
				if(document.Period_Form.check[i].checked){
				
					var tr = document.createElement("tr");
					var td = document.createElement("td");
					periodtime = document.Period_Form.periodtime[i].value;
					td.innerHTML = "<input type='hidden' name='up_periodtime' value='"+periodtime+"'>";
					tr.appendChild(td);
					tbodytab.appendChild(tr);
				}
			}
		}
		else {
			if(document.Period_Form.check.checked) {
				var tr = document.createElement("tr");
				var td = document.createElement("td");
				periodtime = document.Period_Form.periodtime.value;
				td.innerHTML = "<input type='hidden' name='up_periodtime' value='"+periodtime+"'>";
				tr.appendChild(td);
				tbodytab.appendChild(tr);
			}
		}
		insert_period.appendChild(tbodytab);
		document.Period_Form.user_mode.value = "update";
		document.Period_Form.action = "./period_settings_submit.jsp";
		document.Period_Form.submit();
	}
	else
	{
	 	alert("Please select a time to edit.");
	 	document.getElementById("update_but").disabled = false;
	}
}
function deleteProjects()
{
	document.getElementById("delete_but").disabled =true;
	if(count>0)
	{
		var scheduledperiods = "";	
		var flag = false;
		if(document.Period_Form.check.length > 1)
		{
			for(var pos =0;pos<document.Period_Form.check.length;pos++){
				if(document.Period_Form.check[pos].checked) {
					if(parseInt(document.Period_Form.check[pos].getAttribute("totalschedule"),10)>0){
						scheduledperiods += document.Period_Form.check[pos].getAttribute("periodname")+" Session,";
						flag = true;
					}
				}
			}
		}
		else {
			if(document.Period_Form.check.checked) {
				if(parseInt(document.Period_Form.check.getAttribute("totalschedule"),10)>0){
					scheduledperiods += document.Period_Form.check[pos].getAttribute("periodname")+" Session,";
					flag = true;
				}
			}
		}
		if(!flag) {
			if(confirm("Do you want to delete the Period...?")){
				document.Period_Form.user_mode.value = "delete";
				document.Period_Form.action = "./period_settings_submit.jsp";
				document.Period_Form.submit();
			}
		}
		else
		{
		 alert("The following periods already scheduled \n"+scheduledperiods+".\nPlease try to delete unscheduled periods.")
		}
	}
	else
	{
		document.getElementById("delete_but").disabled = false;
		alert("Please select a time to edit.");
	}
}


	function checkHourFormat(obj){
	
	    var isValid = /[0-1](?=[0-9])|2(?=[0-3])/.test(obj.value);
		
		if(!isValid){
		
			alert("Please enter a valid Hour.Use HH format.")
			eval("document.Period_Form."+obj.getAttribute("cname")+".focus()");
			eval("document.Period_Form."+obj.getAttribute("cname")+".value='00'");
		}
		return isValid;
	}	
	
	function checkMinFormat(obj){
		
		var isValid = /[0-5](?=[0-9])/.test(obj.value)
		if(!isValid){
			
			alert("Please enter a valid Min. Use MM format.")
			eval("document.Period_Form."+obj.getAttribute("cname")+".focus()");
			eval("document.Period_Form."+obj.getAttribute("cname")+".value='00'");
		}
		return isValid;
	}	
	
	function checkUpdateFormat(obj){
	
		var idx		= obj.getAttribute("idx"); 
		var oldvalue= obj.getAttribute("oldvalue"); 
		
		var isValid = /^([0-1]?[0-9]|2[0-3]):([0-5][0-9])(-([0-1]?[0-9]|2[0-3]):([0-5][0-9]))?$/.test(obj.value);
		if(!isValid){

			alert("Please enter a valid Time Format. Use HH:MM-HH:MM format.")
			if(document.Period_Form.check.length > 1){
			
				eval("document.Period_Form.periodtime["+idx+"].focus()");
				eval("document.Period_Form.periodtime["+idx+"].value='"+oldvalue+"'");
			}
			else{
				eval("document.Period_Form.periodtime.focus()");
				eval("document.Period_Form.periodtime.value='"+oldvalue+"'");			
			}
		}
		else
			validateSessions(obj, "Period_Form.periodtime");
	}		
	


	function submitPeriod(){
	
		var buttonobj 		= document.getElementById("period_submit");
		buttonobj.disabled 	= true;
		
		if(document.Period_Form.period_name.selectedIndex == -1){
		
			alert("Period is not selected.Please select a period to set time.");
			buttonobj.disabled 	= false;
			return false;
		}		
		
		if(document.Period_Form.period_name.selectedIndex != 0){
		
			alert("Invalid scheduling, may be your previous period not scheduled.");
			buttonobj.disabled 	= false;
			return false;
		}
		
		if(!checkHourFormat(document.Period_Form.period_start_time_hr)){
			buttonobj.disabled 	= false;
			return false;
		}
		
		if(!checkMinFormat(document.Period_Form.period_start_time_min)){
			buttonobj.disabled 	= false;
			return false;
		}
		if(!checkHourFormat(document.Period_Form.period_end_time_hr)){
			buttonobj.disabled 	= false;
			return false;
		}
		if(!checkMinFormat(document.Period_Form.period_end_time_min)){
			buttonobj.disabled 	= false;
			return false;
		}		
		
		 var e_suffix_hr = document.Period_Form.period_end_time_hr.value;
		 var e_suffix_mn = document.Period_Form.period_end_time_min.value;
		 var s_suffix_hr = document.Period_Form.period_start_time_hr.value;
		 var s_suffix_mn = document.Period_Form.period_start_time_min.value;
	
	     if(e_suffix_hr.charAt(0) == "0")
	         e_suffix_hr = e_suffix_hr.charAt(1);
	
	     if(e_suffix_mn.charAt(0) == "0")
	         e_suffix_mn = e_suffix_mn.charAt(1);
	
	     if(s_suffix_hr.charAt(0) == "0")
	         s_suffix_hr = s_suffix_hr.charAt(1);
	
	     if(s_suffix_mn.charAt(0) == "0")
	         s_suffix_mn = s_suffix_mn.charAt(1);
	
		 hrsdiff  = new Number(e_suffix_hr) - new Number(s_suffix_hr);
		 mindiff  = new Number(e_suffix_mn) - new Number(s_suffix_mn);
	
		 mindiff1 = hrsdiff*60;
		 total_dur_mins = mindiff1+mindiff;	
		 
		 if(total_dur_mins <=0){
		 	alert("End Time must be greater than Start Time");
		 	document.Period_Form.period_start_time_hr.focus();
		 	buttonobj.disabled 	= false;
		 	return false;
		 }	
		 
		if(!checkTimings())
		{
			buttonobj.disabled 	= false;
			return false;
		}		

		document.Period_Form.user_mode.value = "insert";
		document.Period_Form.action = "./period_settings_submit.jsp";
		document.Period_Form.submit();
		 
	}


<%
	out.print("var periods = new Array();");
	out.print("function Period(v_periodname, v_periodslot){");
		out.print("this.v_periodname=v_periodname;");
		out.print("this.v_periodslot=v_periodslot;");
	out.print("}");

	if(stdwise_pro != null && stdwise_pro.size() != 0)
	{
		for(int k=0;k<stdwise_pro.size();k++)
		{
			HashMap pro_map = new HashMap();
			pro_map = (HashMap)stdwise_pro.get(k);

			String periodname= pro_map.get("periodname").toString();
			String periodtime= pro_map.get("periodtime").toString();
			out.print("periods["+k+"] = new Period('"+periodname+"','"+periodtime+"');");
		}
	}
%>

function getStartTimeInMinutes(periodValue) {
	var split_periodValue 	= periodValue.split("-");
	var split_inner			= split_periodValue[0].split(":");
	return ((new Number(split_inner[0]) * 60) + new Number(split_inner[1]))
}

function getEndTimeInMinutes(periodValue){
	var split_periodValue 	= periodValue.split("-");
	var split_inner			= split_periodValue[1].split(":");

	return ((new Number(split_inner[0]) * 60) + new Number(split_inner[1]))
}

function checkTimings(){
	
	if(periods != null){
		for(var a=0;a<periods.length;a++){
			var started = getStartTimeInMinutes(periods[a].v_periodslot)
			var ended 	= getEndTimeInMinutes(periods[a].v_periodslot)
			
			var startGiven	= (new Number(document.Period_Form.period_start_time_hr.value) * 60) + new Number(document.Period_Form.period_start_time_min.value);
			var endGiven	= (new Number(document.Period_Form.period_end_time_hr.value) * 60) + new Number(document.Period_Form.period_end_time_min.value);

			if((startGiven >= started) & (startGiven <= ended) || (endGiven >= started) & (endGiven <= ended)){
				alert("Invalid time slot, this may be already in use.");
				return false;
			}
		}
	}
	return true;
}

</script>

</head>
</html>