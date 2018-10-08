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
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	function backfun()
	{
	document.wprkallotment.action =document.wprkallotment.Backstatus.value;
	document.wprkallotment.submit();
	}
	function changedescription()
	{
	document.wprkallotment.message.value =document.wprkallotment.smstemplate.value;
	}
	
	function sendfun()
	{
	document.wprkallotment.action ="../SMS/SMSBridge.jsp";
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

    <h2>Attendance Details / Absentees List</h2>
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
	String Backstatus			= "";
	ArrayList StudentList	= null;
	ArrayList SmsList		= null;

	if(!standardid.equals("null") && !sectionscheduleid.equals("null"))
	{
		StudentList	= attenquery.loadAbsentStudentSectionWise(Sessionid,standardid,sectionscheduleid,searchdate,"A");
		SmsList		= attenquery.loadsms(); 
		Backstatus="./StandardWiseAttendanceView.jsp";
	}
	else if(!standardid.equals("null"))
	{
			SmsList		= attenquery.loadsms(); 
			StudentList	= attenquery.loadAbsentStudent(Sessionid,standardid,searchdate,"A");
			Backstatus="./AdminAttendanceView.jsp";
	}
	else
	{
		Backstatus="./AdminAttendanceView.jsp";
	}
%>
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
						<table id="rounded-corner" border=0 summary="	width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="15%">SMS Templates	</th>
									<th scope="col" class="rounded" width="80%" colspan=2></th>
									<th scope="col" class="rounded-q4" width="5%"></th>
								</tr>
							</thead>
							<tbody>
							<tr>
							<td></td>
							<td  width='25%' class='tablebold'>Sms Template :</td>
							<td width='30%'><select name='smstemplate'
											validate='Sms TemPlate' onchange='changedescription()'>
											<option value=''>-Select Template-</option>
											<%
												if(SmsList != null && SmsList.size()>0){
													for(int y=0;y<SmsList.size();y++){
														hashmap		= (HashMap)SmsList.get(y);
														//smstemplateid, , smsdescription
														out.print("<option value='"+hashmap.get("smsdescription")+"'>"+hashmap.get("smstemplatename")+"</option>");
													}
												}
											%>
										</select></td>
							<td></td>
							</tr>
							<tr>
							<td></td>
							<td class='tablebold'>
								Description :
							</td>
							<td>
							<textarea name='message' id='message' rows='6' cols='50'></textarea></td>
							<td></td>
							</tr>
							</tbody>
								<tfoot>
									<tr>
										<td colspan=3 class="rounded-foot-left"><em></em></td>
										<td class="rounded-foot-right">&nbsp;</td>
									</tr>
								</tfoot>
						</table>
						<br></br>
																		</td>

											</tr>
<tr>
				<td align='left' width='100%' height='100%'>
				
						
								<table border='0' id=rounded-corner1  align="center" width="100%" cellspacing=3 cellpadding=5>
											<tr class='tableheading'>
											<td width='15%'>Sl.No</td>
											<td width='20%'>Student Name</td>
											<td width='20%'>Roll No</td>
											<td width='25%'>Mobile Number</td>
											<td width='45%'>Email</td>
											</tr>
											<%
												if(StudentList != null && StudentList.size()>0){
													for(int y=0;y<StudentList.size();y++){
														hashmap		= (HashMap)StudentList.get(y);
														out.println("<tr>");
														String sectid=hashmap.get("personidid")+"";
														String uname=hashmap.get("uname")+"";
														String rollno=hashmap.get("rollno")+"";
														if(rollno.equals("null"))
															rollno="Not Yet Generatered";
														
														String emailid=hashmap.get("emailid")+"";
														out.print("<td align=center>"+(y+1)+"</td><td>"+uname+"</td>");
														out.print("<td>"+rollno+"</td>");
														String mobileno=hashmap.get("mobilenumber")+"";
														if(mobileno.equals("null"))
														{
															mobileno="-";
															out.print("<td>"+mobileno+"</td>");
														}
														else
														{
														out.print("<td>"+mobileno+"<input type='hidden' name='mobilenos' value='"+mobileno+"'></td>");
														}
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
										<a href="#"  onclick="sendfun()" class="bt_green"><span
		class="bt_green_lft"></span><strong>Send Sms </strong><span
		class="bt_green_r"></span></a>
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