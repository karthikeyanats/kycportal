<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Attendance View  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	function backfun()
	{
	document.wprkallotment.action =document.wprkallotment.Backstatus.value;
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

    <div class="right_content">

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Attendance.AttendanceQuery"%>
	
<%
	//ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_en");
	AttendanceQuery attenquery		= new AttendanceQuery();
	HashMap hashmap=null;
	String instituteid			= (String)session.getValue("instituteid");
	String standardid			= request.getParameter("standardscheduleid")+"";
	String boardid				= request.getParameter("board")+"";
	String boardname			= request.getParameter("boardname")+"";
	String standardname			= request.getParameter("standardname")+"";
	String sectionscheduleid	= request.getParameter("sectionscheduleid")+"";
	String sectionname			= request.getParameter("sectionname")+"";
	String searchdate			= request.getParameter("searchdate")+"";
	String Sessionid			= (String)session.getValue("sessionid");
	String Sessionname			= (String)session.getValue("sessionname");
	String backstatus			= request.getParameter("backstatus")+"";
	String attendancestate		= request.getParameter("attendancestate")+"";
	String Backstatus			= "";
	ArrayList SectionList	= null;
	if(!standardid.equals("null") && !sectionscheduleid.equals("null"))
	{
		SectionList	= attenquery.loadAbsentStudentSectionWise(Sessionid,standardid,sectionscheduleid,searchdate,attendancestate); 
		Backstatus="./StandardWiseAttendanceView.jsp";
	}
	else if(!standardid.equals("null"))
	{
			SectionList	= attenquery.loadAbsentStudent(Sessionid,standardid,searchdate,attendancestate);  
			Backstatus="./YearofsessionAttendanceView.jsp";
	}
	else
	{
		Backstatus="./YearofsessionAttendanceView.jsp";

	}
	 if(!backstatus.equals("null") && backstatus.equals("Admin"))
		{
			Backstatus="./AdminAttendanceView.jsp";
		}
	 
%>
<% if(attendancestate.equals("P")){%>
 <h2>Attendance Details / Present List</h2>
 <%}else {%>
 <h2>Attendance Details / Absent List</h2>
<%} %>
<jsp:useBean id="common_data_object"  scope="page" class="com.iGrandee.Common.CommonDataAccess"/>

<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
	<input type="hidden" name="standardscheduleid" value="<%=standardid %>">
	<input type="hidden" name="board" value="<%=boardid %>">
	<input type="hidden" name="Backstatus" value="<%=Backstatus %>">
	<input type="hidden" name="standardname" value="<%=standardname %>">
<input type="hidden" name="boardname" value="<%=boardname %>">
	<input type="hidden" name="searchdate" value="<%=searchdate %>">
	
		<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
			<tr>
				<td align='left' width='100%' height='100%'>
				
						<table id="rounded-corner" border=0 summary="Department List"
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="15%">Selected Details	</th>
									<th scope="col" class="rounded" width="80%" colspan=4></th>
									<th scope="col" class="rounded-q4" width="5%"></th>
								</tr>
							</thead>
							<tbody>
							<tr>
							<td></td>
							<td  width='25%' class='tablebold'>Current Academic Year :</td>
							<td  width='25%'><%= Sessionname%></td>
							<td class='tablebold'>
									Board :
								</td>
								<td>
									<%=boardname%>
								</td >
								
								<td></td>
							</tr>
							
							<tr>
							<td></td>
							<td class='tablebold'>
									Standard :
								</td>
								
							<% if(!standardid.equals("null") && !sectionscheduleid.equals("null"))
							{%>
							<td>
									<%=standardname%>
								</td>
							<td class='tablebold'>
									Section :
								</td>
								<td>
									<%=sectionname%>
								</td>
							<% }
							else
							{%>
								<td colspan=3>
								<%=standardname%>
							</td>
							<%}%>
							<td></td>
							</tr>
							</tbody>
								<tfoot>
									<tr>
										<td colspan=5 class="rounded-foot-left"><em></em></td>
										<td class="rounded-foot-right">&nbsp;</td>
									</tr>
								</tfoot>
						</table>
						<br></br>
																		</td>

											</tr>
<tr>
				<td align='left' width='100%' height='100%'>
				
						
								<table border='0' id="rounded-corner"  align="center" width="100%" cellspacing=3 cellpadding=5>
											<thead>
											<tr >
											<th width='5%' class="rounded-company">Sl.No</th>
											<th width='20%' class="rounded">Student Name</th>
											<th width='45%' class="rounded">Mobile Number</th>
											<th width='45%' class="rounded-q4">Email</th>
											</tr>
											</thead>
											<%
												if(SectionList != null && SectionList.size()>0){
													for(int y=0;y<SectionList.size();y++){
														hashmap		= (HashMap)SectionList.get(y);
														out.println("<tr>");
														String sectid=hashmap.get("personidid")+"";
														String uname=hashmap.get("uname")+"";
														String mobileno=hashmap.get("mobilenumber")+"";
														if(mobileno.equals("null"))
															mobileno="-";
														String emailid=hashmap.get("emailid")+"";
														out.print("<td align=center>"+(y+1)+"</td><td>"+uname+"</td>");
														out.print("<td>"+mobileno+"</td>");
														out.print("<td>"+emailid+"</td>");
														out.println("</tr>");
													}
												}
												else
												{				
													out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
													//out.println("<tr><td align=center colspan=3>Data Not Found<td></tr>");

													
												}
											%>
											</table>
											</td>
											</tr>

										</table>
										<br>
										<a href="#"  onclick="backfun()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong>Back</strong><span
		class="bt_blue_r"></span></a>
										</td>
										<td></td>
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