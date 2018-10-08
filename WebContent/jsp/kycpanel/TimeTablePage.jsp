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

    <h2>Home Page / My Time Table</h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule,com.iGrandee.Assignment.Assignment"%>
	
<%
		//ResourceBundle bundle = ResourceBundle.getBundle("ResourceBundle.English_en");
		Schedule wallot = new Schedule();
		HashMap hashmap = null;
		HashMap hashmap1 = null;
		String sectionid = request.getParameter("section");
		String instituteid = (String) session.getValue("instituteid");
		String userid = (String) session.getValue("userid");
		String sessionid = (String) session.getValue("sessionid");
		String sessionname = (String) session.getValue("sessionname");
		ArrayList periodList = null;
		ArrayList scheduleList = null;
		ArrayList totalPeriods = null;
	%>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				<table border='0' align="center" width="100%" cellspacing=5
					cellpadding=0>
					<tr>
						<td valign='top'>
						<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="1%"></th>
									<th scope="col" class="rounded" width="98%">Session
									Details</th>
									<th scope="col" class="rounded-q4" width="1%"></th>
								</tr>
							</thead>
							<tr>
								<td colspan='3'>
								<table border='0' align="center" width="100%" cellspacing=0
									cellpadding=5>
									<tr>
										<td width='20%' class='tablebold'>Academic Year</td>
										<td width='1%' class='tablebold'>:</td>
										<td width='80%'><%=sessionname%></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						</td>
					</tr>
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
									<th scope="col" class="rounded-company" width="1%"></th>
									<th scope="col" class="rounded" width="98%">Time Table
									View</th>
									<th scope="col" class="rounded-q4" width="1%"></th>
								</tr>
							</thead>
							<tr>
								<td colspan='3'>

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
																		.append("<td align='center' class='tablelight'><span title='Standard Name : "
																				+ hashmap1
																						.get("standardname")
																				+ "'>"
																				+ hashmap1
																						.get("shortstandard")
																				+ "</span><br><span title='Section Name : "
																				+ hashmap1
																						.get("sectionname")
																				+ "'>"
																				+ hashmap1
																						.get("shortsection")
																				+ "</span><br><span title='Subject Name : "
																				+ hashmap1
																						.get("subjectname")
																				+ "'>"
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

					
					
				</table>
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