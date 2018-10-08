<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	
	function callRplace(obj){
	
		document.wprkallotment.dayid.value 			= obj.getAttribute("dayid");
		document.wprkallotment.periodid.value 		= obj.getAttribute("periodid");
		document.wprkallotment.timetableid.value 	= obj.getAttribute("timetableid");
		document.wprkallotment.staffid.value 		= obj.getAttribute("staffid");
		document.wprkallotment.action = "ReplaceView.jsp";
		document.wprkallotment.submit();
	
	
	}
	
	function editSchedule(){
	
		document.wprkallotment.action = "EditSchedule.jsp";
		document.wprkallotment.submit();
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
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.replacetimetableallocation")%></h2>
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
	
	String dayid			= request.getParameter("dayid");
	String periodid			= request.getParameter("periodid");
		
	ArrayList staffList		= wallot.loadStaffForSection(sectionid);
	String instituteid		= (String)session.getValue("instituteid");
	String userid			= (String)session.getValue("userid");
	ArrayList periodList	= wallot.loadPeriods(instituteid,userid); 
	ArrayList scheduleList	= wallot.loadSchedules(instituteid,sectionid,userid); 

%>
	<form name='wprkallotment' method='post'>

								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='3'>										
							
											<table  border=0 bordercolor='blue' align="center" width="100%" cellspacing=0 cellpadding=5>
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
						
			<% 
			if(periodList != null && periodList.size()>7){
			%>				
			<div class="myScrollingDiv">
			<%} %>											
	
										
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
																				buffer.append("<td align='center' class='tablelight'>-</td>");
																			else
																				buffer.append("<td align='center' class='tablelight'><span id='staff"+idcount+"' title='"+hashmap.get("staffname")+"'>"+hashmap.get("shortstaff")+"</span><br><input type='checkbox' id='check"+idcount+"' idcount='"+idcount+"' name='schedules' dayid='"+hashmap.get("dayid")+"' periodid='"+hashmap.get("periodid")+"' subjectallotmentid=''  disabled checked><br><span id='subject"+idcount+"' title='"+hashmap.get("subjectname")+"'>"+hashmap.get("shortsubject")+"</span><br><a href='#' onclick='callRplace(this)' dayid='"+hashmap.get("dayid")+"' periodid='"+hashmap.get("periodid")+"' staffid='"+hashmap.get("staffid")+"' timetableid='"+hashmap.get("timetableid")+"'>Replace Staff</a></td>");
																			
				
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
			
			<% 
			if(periodList != null && periodList.size()>7){
			%>				
			</div>
			<%} %>											
				
			<a href="#" class="bt_blue" name='back' 	id='back' onclick='backSchedule()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
				
		<input type='hidden' name='standardname' 	value='<%=standardname%>'>
		<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
		<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
		<input type='hidden' name='boardname' 		value='<%=boardname%>'>
		<input type='hidden' name='section' 		value='<%=sectionid%>'>
		<input type='hidden' name='session' 		value='<%=sessionid%>'>
		<input type='hidden' name='standard'		value='<%=standardid%>'>
		<input type='hidden' name='staffschedule'	value=''>
		<input type='hidden' name='total'			value='<%=idcount%>'>
		<input type='hidden' name='dayid'			value=''>
		<input type='hidden' name='periodid'		value=''>
		<input type='hidden' name='timetableid'		value=''>
		<input type='hidden' name='staffid'			value=''>
		
		
		
		

	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>