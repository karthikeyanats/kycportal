<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Time Table View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/xmlhttpobject.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/clearselects.js"></SCRIPT>

<script language='javascript'>

	var shortname 	= "";
	var fullname 	= "";
	var shortsub 	= "";
	var fullsub 	= "";

	
	
	function loadSubjects(status)
	{
		if(status == "subject") {
		
			clearObjects("subject")
			if(check_ForParticularElements(document.wprkallotment.staff,"select")){
				url="ScheduleAjax.jsp?action=loadsujects&staffid="+document.getElementById("staff").value+"&sectionid="+document.wprkallotment.section.value;
			}
			else{
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
			}
			else if(status == "checkschedule"){
				
				if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "Yes")
				{
					alert("The Staff "+fullname+" already Sheduled for the Following\n.1.Academic Year : "+document.wprkallotment.sessionname.value+"\n.2. Standard : "+root_obj[0].childNodes.item(0).childNodes.item(4).firstChild.nodeValue+"\n.3. Subject : "+root_obj[0].childNodes.item(0).childNodes.item(3).firstChild.nodeValue+"\n.4. Section : "+root_obj[0].childNodes.item(0).childNodes.item(5).firstChild.nodeValue+"\n.5. Period : "+root_obj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue+"\n.6. Day : "+root_obj[0].childNodes.item(0).childNodes.item(2).firstChild.nodeValue);
					flag	= true;
				}
				else
				{
					flag	= false;
				}
			}
			else if(status == "schedule"){
				
				if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "0")
				{
					alert("Failure schedule.Please contact administrator");
					tempobj.checked	= false;
					
				}
				else if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "2")
				{
					alert("The Staff "+fullname+" already Sheduled for the Following\n.1.Academic Year : "+document.wprkallotment.sessionname.value+"\n.2. Standard : "+root_obj[0].childNodes.item(0).childNodes.item(4).firstChild.nodeValue+"\n.3. Subject : "+root_obj[0].childNodes.item(0).childNodes.item(3).firstChild.nodeValue+"\n.4. Section : "+root_obj[0].childNodes.item(0).childNodes.item(5).firstChild.nodeValue+"\n.5. Period : "+root_obj[0].childNodes.item(0).childNodes.item(1).firstChild.nodeValue+"\n.6. Day : "+root_obj[0].childNodes.item(0).childNodes.item(2).firstChild.nodeValue);
					tempobj.checked	= false;
					
				}
				else if(root_obj[0].childNodes[0].childNodes[0].childNodes[0].nodeValue == "3")
				{
					alert("The Staff "+fullname+" already Sheduled for all the allotted hours");
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

				loadSubjects("schedule");
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
	
		
	function backSchedule(){
	
		document.wprkallotment.action = "ScheduleSelect.jsp";
		document.wprkallotment.submit();
	}

	function printfun()
	{
	window.open("PrintPreviewSchedule.jsp?&req_sessionname="+document.wprkallotment.req_sessionname.value+"&session="+document.wprkallotment.req_sessionid.value+"&standard="+document.wprkallotment.standard.value+"&standardname="+document.wprkallotment.standardname.value+"&section="+document.wprkallotment.section.value+"&sectionname="+document.wprkallotment.sectionname.value+"&req_sessionstatus="+document.wprkallotment.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=700,scrollbars=1;")
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

    <h2><%=bundle.getString("label.reports.reportstimetableview")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule"%>
	
<%
	Schedule wallot 		= new Schedule();
	HashMap	hashmap			= null;
	int getcount			= 0;
	String sessionid		= request.getParameter("session");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	String boardname		= request.getParameter("boardname");
	String instituteid		= (String)session.getValue("instituteid");
	ArrayList periodList	= wallot.loadPeriods(instituteid); 
	ArrayList scheduleList	= wallot.loadScheduless(instituteid,sectionid); 

%>
	<form name='wprkallotment' method='post'>
		<table class="bodyinnercolor" border='0' align="center" width="80%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' >
								<table  border=0 bordercolor='blue' id=rounded-corner align="center" width="80%" cellspacing=0 cellpadding=0>
									<thead>
											    	<tr bordercolor='blue'>
											        	
											            <th scope="col" class="rounded-company" width="99%" colspan=4 ><%=bundle.getString("label.schedule.selectedinfo")%></th>
											            <th scope="col" class="rounded-q4" width="1%"></th>
											        </tr>
											    </thead>
											    <tfoot>
													<tr>
													<td colspan=4 class="rounded-foot-left"><em></em></td>
													<td class="rounded-foot-right">&nbsp;</td>
											</tr>
											</tfoot>
									<tbody>
									<tr height='23'>
									<td></td>
										<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
										<td  class='tablebold' width='1'>:</td>
										<td  class='tablelight' width='79%'>
										<%=sessionname %>
										</td>
										<td></td>
									</tr>
									<tr height='23'>
									<td></td>
										<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.board")%></td>
										<td  class='tablebold' width='1'>:</td>
										<td  class='tablelight' width='79%'>
										<%=boardname%>
										</td>
										<td></td>
									</tr>									

									<tr height='23'>
										<td></td>
									
										<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%></td>
										<td  class='tablebold' width='1'>:</td>
										<td  class='tablelight' width='79%'>
										<%=standardname %>
										</td>
																			<td></td>
										
									</tr>
									<tr height='23'>
																		<td></td>
									
										<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.section")%></td>
										<td  class='tablebold' width='1'>:</td>
										<td  class='tablelight' width='79%'>
										<%=sectionname %>
										</td>
																			<td></td>
										
									</tr>
									</tbody>
								</table>
															<br>
								
						</td>
					</tr>
				</table>
								
						</td>
					</tr>
				</table>
				
				<%
				//out.println("<tr><td align=center><iframe id='iframeid' src='./TimeTableIfrm.jsp' width=826px height=400px frameborder=0></iframe></td></tr>"); 
				if(periodList.size()>7)
				{
				%>				
					<div class="myScrollingDiv">
				<%
				} 
				%>
						<table border=0 bordercolor=red>
						<tr>
						<td>
						<tr>
							<td  align='left' height='100%'>							
								<table  border='0' id=rounded-corner align="center" width="90%"  cellpadding=0>
								<thead>
											    	<tr bordercolor='blue'>
											            <th scope="col" colspan='2'  class="rounded-company" width="99%" ><%=bundle.getString("label.schedule.timetableview")%></th>
											            <th scope="col" class="rounded-q4" width="1%"></th>
											        </tr>
											    </thead>
											    <tfoot>
													<tr>
													<td  colspan='2' class="rounded-foot-left"><em></em></td>
													<td class="rounded-foot-right">&nbsp;</td>
											</tr>
											</tfoot>
											<tbody>
									<%
									if(periodList.size()>0)
									{
									%>				
									<tr class='tablebold' height='25'>
									<td></td>
										<td>
											<table  border='1' align="center"  cellspacing=0 cellpadding=0>
											<tr>
												<td><%=bundle.getString("label.schedule.periods")%></td>
											<%
												if(periodList != null && periodList.size()>0){
													for(int y=0;y<periodList.size();y++){
														hashmap		= (HashMap)periodList.get(y);
														out.print("<td class='tablebold' rowspan='2' nowrap>"+hashmap.get("periodname")+" <br>"+hashmap.get("periodtime")+"</td>");
													}
												}
											%>
											</tr>
											<tr>
												<td><%=bundle.getString("label.schedule.day")%></td>	
											</tr>
											<%
												int innerloop			= 0;
												//int getcount			= 0;
												int idcount				= 1;
												
												StringBuffer buffer		= new StringBuffer();
												if(scheduleList != null && scheduleList.size()>0){
													for(int y=0;y<scheduleList.size();){
						
														for(innerloop=0;innerloop<periodList.size() && (y+innerloop)<scheduleList.size();innerloop++){
															hashmap		= (HashMap)scheduleList.get((y+innerloop));
															
															if(innerloop == 0)
																buffer.append("<tr><td class='tablebold'>"+hashmap.get("dayname")+"</td>");
															if(hashmap.get("sectionpublishid") == null)
																buffer.append("<td align='center' class='tablelight'>-</td>");
															else
																buffer.append("<td align='center' class='tablelight'>"+hashmap.get("staffname")+"<br>("+hashmap.get("subjectname")+" )</td>");
															getcount++;

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
										</td><td></td>
										</tr>
										<%
										}
										else
										{
											out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");	
										//out.print("<tr><td align=center colspan=3>"+bundle.getString("label.schedule.datanotfound")+"</td</tr>");	
										}
										%>
											
										
										</table>								
							</td>
						</tr>					
					</table>
				<%
				if(periodList.size()>7)
				{
				%>				
				</div>	
				<%
				} 
				%>	
		<a href="#" class="bt_blue"  name='back' 	id='back' onclick='backSchedule()'>		<span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		
		<%
		if(getcount>0){
		%>
		<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
		<%
		}
		%>
		<input type='hidden' name='standardname' 	value='<%=standardname%>'>
		<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
		<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
		<input type='hidden' name='section' 		value='<%=sectionid%>'>
		<input type='hidden' name='session' 		value='<%=sessionid%>'>
		<input type='hidden' name='standard'		value='<%=standardid%>'>
		<input type='hidden' name='staffschedule'	value=''>

<input type=hidden name=req_sessionid value="<%=request.getParameter("req_sessionid")%>">
<input type=hidden name=req_sessionname value="<%=request.getParameter("req_sessionname") %>">
<input type=hidden name=req_sessionstatus value="<%=request.getParameter("req_sessionstatus") %>">			

	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>