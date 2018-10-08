<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
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
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.edittimetableallocation")%></h2>
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
	String boardname		= request.getParameter("boardname");
	
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	ArrayList staffList		= wallot.loadStaffForSection(sectionid);
	String instituteid		= (String)session.getValue("instituteid");
	String userid			= (String)session.getValue("userid");
	ArrayList periodList	= wallot.loadPeriods(instituteid,userid); 
	ArrayList scheduleList	= wallot.loadSchedules(instituteid,sectionid,userid);

%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>

							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='2'>										
							
											<table  border=0  align="center" width="100%" cellspacing=0 cellpadding=5>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
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
											</table>
										</td>
									</tr>
								</table>

						<br>
						<div class="myScrollingDiv">											
						
						<table class="bodyinnercolor" border='0' bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' width='100%' height='100%'>
								<table  border='0' align="center" width="100%" cellspacing=0 cellpadding=5>

									<tr class='tablebold' height='25'>
										<td valign='top'>
										
											<table id="rounded-corner" border=0 summary="Department List" width="100%">
											    <thead>
											    	<tr>
											            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.scheduledetails")%></th>
											            <th scope="col" class="rounded-q4" width="2%"></th>
											        </tr>
											    </thead>
											    <tr>		
											    	<td colspan='2'>										
										
														<table  border='1' align="center" width="100%" cellspacing=0 cellpadding=5>
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
																			buffer.append("<td align='center' class='tablelight'><span id='staff"+idcount+"'></span><br><input type='checkbox' id='check"+idcount+"' idcount='"+idcount+"' name='schedules' dayid='"+hashmap.get("dayid")+"' periodid='"+hashmap.get("periodid")+"' subjectallotmentid=''  disabled><br><span id='subject"+idcount+"'></span></td>");
																		else
																			buffer.append("<td align='center' class='tablelight'><span id='staff"+idcount+"' title='"+hashmap.get("staffname")+"'>"+hashmap.get("shortstaff")+"</span><br><input type='checkbox' id='check"+idcount+"' idcount='"+idcount+"' name='schedules' dayid='"+hashmap.get("dayid")+"' periodid='"+hashmap.get("periodid")+"' subjectallotmentid='"+hashmap.get("subjectallotmentid")+"' timetableid='"+hashmap.get("timetableid")+"'  checked shortsubject='"+hashmap.get("shortsubject")+"' shortstaff='"+hashmap.get("shortstaff")+"' subjectname='"+hashmap.get("subjectname")+"' staffname='"+hashmap.get("staffname")+"' onclick='checkSchedule(this)'><br><span id='subject"+idcount+"' title='"+hashmap.get("subjectname")+"'>"+hashmap.get("shortsubject")+"</span></td>");
																		
			
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
											</table>
										</td>
									</tr>
								
								</table>
							</td>
						</tr>					
					</table>
				</div>
				

					
				<a href="#" class="bt_blue" 	name='back' 	id='back' onclick='backSchedule()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
				<a href="#" class="bt_green" 	name='edit' 	id='edit' onclick='editSchedule()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.update")%></strong><span class="bt_green_r"></span></a>
					
						
		
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