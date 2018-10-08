<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - TimeTable | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	function backfun(){
	
		document.wprkallotment.action = "./TimeTableForStaff.jsp";
		document.wprkallotment.submit();
	}

</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.stafftimetablestaffview")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule"%>
	
<%
	Schedule wallot 		= new Schedule();
	HashMap	hashmap			= null;

	HashMap	hashmap1			= null;
	String 	sessionid		= session.getValue("sessionid")+"";
	String	standardid		= request.getParameter("standard")+"";
	String sectionid		= request.getParameter("section");
	String instituteid		= (String)session.getValue("instituteid");
	//String userid			= (String)session.getValue("userid");
	String userid			= request.getParameter("userid");
	//out.println("========>>>>>>>>"+userid);

	ArrayList periodList	= wallot.loadPeriods(instituteid); 
	ArrayList scheduleList	= wallot.loadStaffSchedule(userid,instituteid,sessionid);
	ArrayList totalPeriods = null;

%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
	<input type="hidden" name="session" value="<%=sessionid %>">
	<input type="hidden" name="standardid1" value="<%=standardid %>">
	
	<input type="hidden" name="standard" value="<%=request.getParameter("req_stdschedid") %>">
	<input type="hidden" name="board" value="<%=request.getParameter("req_boardid") %>">
		
			<table width='100%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%">Selected Information</th>
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
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' >
					<%=session.getValue("sessionname") %>
				</td>
				<td width='15%' class='tablebold'>Board</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' >
				<%=request.getParameter("req_boardname") %>					
				</td>
			</tr>
			<tr>
		
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.standardname")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' >
					<%=request.getParameter("req_standardnamegp")%>
				</td>
			<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.staffname")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' >
			<%=request.getParameter("username")%>
			</td>
			</tr>
			</table></td></tr>
		</tbody>
		</table>
		
	
		<%if(periodList.size()>7) 
		{
		%>
		<div class="myScrollingDiv">
		<%}%>	
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' width='100%' height='100%'>
								<table  border='0' align="center" width="100%" cellspacing=5 cellpadding=0>

									<tr class='tablebold' height='25'>
										<td valign='top'>
										<%
						if (sessionid != null && !sessionid.equals("")
								&& !sessionid.equalsIgnoreCase("null")) {
							periodList = wallot.loadPeriods(instituteid);
							totalPeriods = wallot.loadTotalPeriods(instituteid);
							scheduleList = wallot.loadStaffSchedule(userid, instituteid,
									sessionid);
					%>
					<tr class='tablebold' height='25'>
						<td valign='top'>

						<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.schedule.timetableview")%></th>
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
																		.append("<td align='center' class='tablelight' title='Standard : "
																				+ hashmap1.get("standardname")
																				+ "&#13;Section : "
																				+ hashmap1.get("sectionname")
																				+ "&#13;Subject : "
																				+ hashmap1.get("subjectname")
																				+ "'><span >"
																				+ hashmap1.get("shortstandard")
																				+ "</span><br><span>"
																				+ hashmap1.get("shortsection")
																				+ "</span><br><span >"
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
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<%
						}
					%>
</td>
									</tr>
								</table>
							</td>
						</tr>					
					</table>
				</td>
			</tr>
		</table>
		<%if(periodList.size()>7) 
		{
		%>
		</div>
		<%}%>							 <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		
	</form>
    </div><!-- end of right content-->
  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>