<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="../../js/xmlhttpobject.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/clearselects.js"></SCRIPT>

<script language='javascript'>

	var shortname 	= "";
	var fullname 	= ""; 
	var shortsub 	= "";
	var fullsub 	= "";
	var allotted	= 0;
	var scheduled	= 0;
	var remaining	= 0;

	
	function selectSubject(){
	
		if(check_ForParticularElements(document.wprkallotment.staff,"select",document.wprkallotment.subject,"select")){
			fullname	= document.wprkallotment.staff.options[document.wprkallotment.staff.options.selectedIndex].text;
			
			if(fullname.length>8)
				shortname	= fullname.substring(0,8);
			else
				shortname	= fullname;
			
			fullsub	= document.wprkallotment.subject.options[document.wprkallotment.subject.options.selectedIndex].text;
			if(fullsub.length>8)
				shortsub	= fullsub.substring(0,8);
			else
				shortsub	= fullsub;
				
				
			loadSubjects("remaining");
		
		}else{
				
			document.getElementById("remaining").innerHTML	= "-";
			document.getElementById("scheduled").innerHTML	= "-";
		}
	}
	
	
	function loadSubjects(status)
	{
		if(status == "subject") {
		
			clearObjects("subject")
			if(check_ForParticularElements(document.wprkallotment.staff,"select")){
				url="ScheduleAjax.jsp?action=loadsujects&staffid="+document.getElementById("staff").value+"&sectionid="+document.wprkallotment.section.value;
			}
			else{
				document.getElementById("remaining").innerHTML	= "-";
				document.getElementById("scheduled").innerHTML	= "-";
				return false;
			}
		}
		else if(status == "checkschedule"){
		
			if(check_ForParticularElements(document.wprkallotment.staff,"select",document.wprkallotment.subject,"select")){
				url="ScheduleAjax.jsp?action=checkschedule&dayid="+tempobj.getAttribute("dayid")+"&sessionid="+document.wprkallotment.session.value+"&periodid="+tempobj.getAttribute("periodid")+"&staffid="+document.getElementById("staff").value;
			}
			else{
				tempobj.checked = false;
				flag			= true;
				return false;
			}
		}
		else if(status == "schedule"){
		
			if(check_ForParticularElements(document.wprkallotment.staff,"select",document.wprkallotment.subject,"select")){
				url="ScheduleAjax.jsp?action=schedule&dayid="+tempobj.getAttribute("dayid")+"&sessionid="+document.wprkallotment.session.value+"&periodid="+tempobj.getAttribute("periodid")+"&staffid="+document.getElementById("staff").value+"&subjectallotment="+document.getElementById("subject").value+"&sectionid="+document.wprkallotment.section.value;
			}
			else{
				tempobj.checked = false;
				return false;
			}
		}
		else if(status == "remaining"){
		
			if(check_ForParticularElements(document.wprkallotment.staff,"select",document.wprkallotment.subject,"select")){
				url="ScheduleAjax.jsp?action=remaining&staffid="+document.getElementById("staff").value+"&subjectallotment="+document.getElementById("subject").value;
			}
			else{
				tempobj.checked = false;
				return false;
			}
		}		
		else if(status == "remainingforstaff"){

			url="ScheduleAjax.jsp?action=remainingforstaff&staffid="+document.getElementById("staff").value+"&sessionid="+document.wprkallotment.session.value;
		
		}		
		
		
		
		var req = initRequest();
		req.onreadystatechange = function()
		{
			if(req.readyState == 4)
			{
				if(req.status == 200)
				{
					parseResponse(req.responseXML,status);
				}
			}
		};
		req.open("GET", url, true);
		req.send(null);

	}	
	
	function parseResponse(responseXML,status){
	
			root_obj = responseXML.getElementsByTagName("MainEntity");
			node_len = root_obj[0].childNodes.length;
			
			if(status == "subject"){
				
				selectobj	= document.getElementById("subject");
				
				for(var i=0;i<node_len;i++){
					selectobj.options[selectobj.length] = new Option(root_obj[0].childNodes[i].childNodes[1].childNodes[0].nodeValue,root_obj[0].childNodes[i].childNodes[0].childNodes[0].nodeValue);
				}
				
				loadSubjects("remainingforstaff");
			}
			else if(status == "checkschedule"){
				
				if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "Yes")
				{
					alert("The Staff "+fullname+" already Scheduled for the Following:\n 1.Academic Year : "+document.wprkallotment.sessionname.value+"\n 2. Standard : "+root_obj[0].childNodes.item(0).childNodes.item(4).firstChild.nodeValue+"\n 3. Subject : "+root_obj[0].childNodes.item(0).childNodes.item(3).firstChild.nodeValue+"\n 4. Section : "+root_obj[0].childNodes.item(0).childNodes.item(5).firstChild.nodeValue+"\n 5. Period : "+root_obj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue+"\n 6. Day : "+root_obj[0].childNodes.item(0).childNodes.item(2).firstChild.nodeValue);
					flag	= true;
				}
				else
				{
					flag	= false;
				}
			}
			else if(status == "remaining"){
				
				if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "Not Yet Allotted")
				{
					allotted	= 0;
					scheduled	= 0;
					remaining	= 0;
					//alert("Please set number of hours for this subject.");
				}
				else
				{
					allotted	= parseInt(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue,10);
					scheduled	= parseInt(root_obj[0].childNodes[0].childNodes[1].childNodes[0].nodeValue,10);
					remaining	= allotted-scheduled;
					//alert("Total hours Allotted "+allotted+"\n"+"Total hours Scheduled "+scheduled+"\n"+"Total hours Remaining "+remaining)
					//document.getElementById("remaining").innerHTML	= allotted +"&nbsp;&&nbsp;"+scheduled+"&nbsp;&&nbsp;"+remaining;
					document.getElementById("remaining").innerHTML	= allotted;
					document.getElementById("scheduled").innerHTML	= scheduled;
					
				}
			}
			else if(status == "remainingforstaff"){
				
				allotted	= parseInt(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue,10);
				scheduled	= parseInt(root_obj[0].childNodes[0].childNodes[1].childNodes[0].nodeValue,10);
				remaining	= allotted-scheduled;
				document.getElementById("remaining").innerHTML	= allotted;
				document.getElementById("scheduled").innerHTML	= scheduled;
					
			}			
			else if(status == "schedule"){
			
				if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "0")
				{
					alert("Failuire schedule.Please contact administrator");
					tempobj.checked	= false;
					
				}
				else if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "2")
				{
					alert("The Staff "+fullname+" already Scheduled for the Following:\n 1.Academic Year : "+document.wprkallotment.sessionname.value+"\n 2. Standard : "+root_obj[0].childNodes.item(0).childNodes.item(4).firstChild.nodeValue+"\n 3. Subject : "+root_obj[0].childNodes.item(0).childNodes.item(3).firstChild.nodeValue+"\n 4. Section : "+root_obj[0].childNodes.item(0).childNodes.item(5).firstChild.nodeValue+"\n 5. Period : "+root_obj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue+"\n 6. Day : "+root_obj[0].childNodes.item(0).childNodes.item(2).firstChild.nodeValue);
					tempobj.checked	= false;
					
				}
				else if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "3")
				{
					alert("The Staff "+fullname+" already Scheduled for all the allotted hours");
					//document.getElementById("remaining").innerHTML	= allotted +"&nbsp;&&nbsp;"+scheduled+"&nbsp;&&nbsp;"+remaining;
					document.getElementById("remaining").innerHTML	= allotted;
					document.getElementById("scheduled").innerHTML	= scheduled;
					tempobj.checked	= false;
					
				}else if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "4")
				{
					alert("The Subject "+fullsub+" already Scheduled for all the credit hours.");
					tempobj.checked	= false;
					
				}else{
				
					idcount					= tempobj.getAttribute("idcount");
					staffobj				= document.getElementById("staff"+idcount);
					subjectobj				= document.getElementById("subject"+idcount);
					staffobj.innerHTML 		= shortsub;
					staffobj.title			= fullsub;
					subjectobj.innerHTML 	= shortname;
					subjectobj.title		= fullname;
					tempobj.setAttribute('subjectallotmentid',document.getElementById("subject").value);
					tempobj.disabled 		= true;
					scheduled++;
					remaining	= allotted-scheduled;
					//document.getElementById("remaining").innerHTML	= allotted +"&nbsp;&&nbsp;"+scheduled+"&nbsp;&&nbsp;"+remaining;
					document.getElementById("scheduled").innerHTML	= scheduled;
					
					
				}
			}
	}
	
	var checkedcount		= 0;
	var idcount				= "";
	var checkobj;
	var staffobj;
	var subjectobj;	
	var tempobj;
	var flag				= false;
	
	function checkScheduleAjax(obj){
	
		if(obj.checked){
		
			tempobj = obj;
			
			if(check_ForParticularElements(document.wprkallotment.staff,"select",document.wprkallotment.subject,"select")){
				if(confirm("Are you sure wants to schedule?")){
					loadSubjects("schedule");
				}
				else
					obj.checked	= false;
			}
			else
				obj.checked	= false;
			
		
		}
		else{
		
				idcount					= obj.getAttribute("idcount");
				staffobj				= document.getElementById("staff"+idcount);
				subjectobj				= document.getElementById("subject"+idcount);
				staffobj.innerHTML 		= "";
				staffobj.title			= "";
				subjectobj.innerHTML 	= "";
				subjectobj.title		= "";
				
				obj.setAttribute('subjectallotmentid','');
			
			
			checkedcount--;
		}	
	}
	
	function editSchedule(){
	
		document.wprkallotment.action = "EditSchedule.jsp";
		document.wprkallotment.submit();
	}
		
	function backSchedule(){
	
		document.wprkallotment.action = "ScheduleSelect.jsp";
		document.wprkallotment.submit();
	}
	
	function replaceSchedule(){

		document.wprkallotment.action = "ReplacePeriod.jsp";
		document.wprkallotment.submit();
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

    <h2><%=bundle.getString("label.schedule.timetableallocation")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule"%>
	
<%
	Schedule wallot 		= new Schedule();
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	String boardname		= request.getParameter("boardname");
	ArrayList staffList		= wallot.loadStaffForSection(sectionid);
	String instituteid		= (String)session.getValue("instituteid");
	String userid			= (String)session.getValue("userid");
	ArrayList periodList	= wallot.loadPeriods(instituteid,userid); 
	ArrayList scheduleList	= wallot.loadSchedules(instituteid,sectionid,userid); 
	
	//out.println(scheduleList);

%>
	<form name='wprkallotment' method='post'>

					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' >
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>
								    	<td colspan='2'>							
											<table  border=0 bordercolor='blue' align="center" width="100%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight'>
													<%=sessionname %>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.board")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=boardname %>
													</td>
												</tr>
												
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=standardname %>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.section")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=sectionname %>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='100%' colspan='3'><%=bundle.getString("label.schedule.allottedhours")%> &nbsp;:&nbsp;<span id='remaining'>-</span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
														<%=bundle.getString("label.schedule.scheduledhours")%>  &nbsp;:&nbsp;<span id='scheduled'>-</span>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					 </table>
					 <br>
					
					<% 
					if(periodList != null && periodList.size()>6){
					%>
					<div class="myScrollingDiv">											
					<%}%>
					
					<table class="bodyinnercolor" border='0' bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' width='80%' height='100%'>
								
								<table id="rounded-corner" border=0 summary="Department List" width="80%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.scheduledetails")%></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr> 
								    	<td colspan='2'>							
												<table  border='1' align="center" width="100%" cellspacing=0 cellpadding=0>
													<tr class='tablebold' height='25'>
														<td class='tablebold' width='25%'><%=bundle.getString("label.schedule.staffname")%></td>
														<td rowspan='4' valign='top'>
															
																<table  border='0' align="center" width="80%" cellspacing=0 cellpadding=5>
																<tr>
																	<td><%=bundle.getString("label.schedule.periods")%></td>
																<%
																	if(periodList != null && periodList.size()>0){
																		for(int y=0;y<periodList.size();y++){
																			hashmap		= (HashMap)periodList.get(y);
																			out.print("<td class='tablebold' rowspan='2' nowrap>"+hashmap.get("periodname")+"<br>"+hashmap.get("periodtime")+"</td>");
																		}
																	}
																%>
																</tr>
																<tr>
																	<td><%=bundle.getString("label.schedule.day")%></td>	
																</tr>
																<%
																	int innerloop			= 0;
																	int getcount			= 0;
																	int idcount				= 1;
																	
																	StringBuffer buffer		= new StringBuffer();
																	
																	if(scheduleList != null && scheduleList.size()>0){
																		for(int y=0;y<scheduleList.size();){
											
																			for(innerloop=0;innerloop<periodList.size() && (y+innerloop)<scheduleList.size();innerloop++){
																				hashmap		= (HashMap)scheduleList.get((y+innerloop));
																				
																				if(innerloop == 0)
																					buffer.append("<tr><td class='tablebold'>"+hashmap.get("dayname")+"</td>");
																				
																				if(hashmap.get("sectionpublishid") == null)
																					buffer.append("<td align='center' class='tablelight'><span id='staff"+idcount+"'></span><br><input type='checkbox' id='check"+idcount+"' idcount='"+idcount+"' name='schedules' dayid='"+hashmap.get("dayid")+"' periodid='"+hashmap.get("periodid")+"' subjectallotmentid='' onclick='checkScheduleAjax(this)'><br><span id='subject"+idcount+"'></span></td>");
																				else
																					buffer.append("<td align='center' class='tablelight'><span id='staff"+idcount+"' title='"+hashmap.get("staffname")+"'>"+hashmap.get("shortstaff")+"</span><br><input type='checkbox' id='check"+idcount+"' idcount='"+idcount+"' name='schedules' dayid='"+hashmap.get("dayid")+"' periodid='"+hashmap.get("periodid")+"' subjectallotmentid=''  disabled checked><br><span id='subject"+idcount+"' title='"+hashmap.get("subjectname")+"'>"+hashmap.get("shortsubject")+"</span></td>");
																				
					
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
															
														</td>
													</tr>
													<tr >
														<td  class='tablebold'  valign='top'>
															<select class='tablelight' name='staff' id='staff' validate='Staff Name' size='5' width='100' onclick='loadSubjects("subject")'>
															<option value='0'>-Select Staff Name-</option>
															<%
																if(staffList != null && staffList.size()>0){
																	for(int y=0;y<staffList.size();y++){
																		hashmap		= (HashMap)staffList.get(y);
																			out.print("<option value='"+hashmap.get("staffid")+"'>"+hashmap.get("name")+"</option>");
																	}
																}
															%>
															</select>
														</td>
													</tr>
													<tr class='tablebold' height='25'>
														<td  class='tablebold' ><%=bundle.getString("label.schedule.subjectname")%></td>
													</tr>
													<tr >
														<td class='tablebold' valign='top'>
															<select class='tablelight' name='subject' validate='Subjects Name' id='subject' size='5' onclick='selectSubject()'>
															<option value='0'>-Select Subject Name-</option>
															
															</select>
														</td>
													</tr>
												</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>					
					</table>
					
			<%if(periodList != null && periodList.size()>6){%>
			</div>
			<%}%>
		

		
		<a href="#" class="bt_blue"  name='back' 	id='back' onclick='backSchedule()'>		<span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" name='repl' 	id='repl' onclick='replaceSchedule()'>	<span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.replacestaff")%></strong><span class="bt_green_r"></span></a>
		<a href="#" class="bt_green" name='edit' 	id='edit' onclick='editSchedule()'>		<span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.edit")%></strong><span class="bt_green_r"></span></a>
		

		<input type='hidden' name='standardname' 	value='<%=standardname%>'>
		<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
		<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
		<input type='hidden' name='boardname' 		value='<%=boardname%>'>
		<input type='hidden' name='section' 		value='<%=sectionid%>'>
		<input type='hidden' name='session' 		value='<%=sessionid%>'>
		<input type='hidden' name='standard'		value='<%=standardid%>'>
		<input type='hidden' name='staffschedule'	value=''>
		<input type='hidden' name='total'			value='<%=idcount%>'>

	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>