<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Attendance View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>
<script type="text/javascript">
	
	function backfun()
	{
	document.Attendance_Form.action="./StudentAttendanceView.jsp";
	document.Attendance_Form.submit();
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

    <h2><%=bundle.getString("hmlabel.attendanceviewlist.rootpath")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page import="com.iGrandee.Common.DateTime" %>
	
<%@ page language="java" import="com.iGrandee.Attendance.AttendanceQuery,com.iGrandee.Common.DateTime"%>
<%

		AttendanceQuery attencequery			= new AttendanceQuery();
		HashMap	hashmap				= null;
		HashMap	hashmap1			= null;
		ArrayList 	studentList		=null;	
		DateTime dateobj=new DateTime();
		String sessionid			= request.getParameter("session");
		String boardid				= request.getParameter("board");
		String standardscheduleid	= request.getParameter("standard");
		String sectionscheduleid	= request.getParameter("section");
		String sessionname			= request.getParameter("sessionname");
		String boardname				= request.getParameter("boardname");
		String standardschedulename	= request.getParameter("standardname");
		String sectionschedulename	= request.getParameter("sectionname");
		String attendancedate	= request.getParameter("hiddenfromdate");
		String forMonth="";
		String convMonthPick = request.getParameter("monthdate")+"";
		//out.println("convMonthPick"+convMonthPick);
		int totalmonth=0;
		if(!convMonthPick.equals("null"))
		{
			if(convMonthPick.substring(0,2).equals("01"))
			forMonth = "January "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("02"))
			forMonth = "February "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("03"))
			forMonth = "March "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("04"))
			forMonth = "April "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("05"))
			forMonth = "May "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("06"))
			forMonth = "June "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("07"))
			forMonth = "July "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("08"))
			forMonth = "August "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("09"))
			forMonth = "September "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("10"))
			forMonth = "October "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("11"))
			forMonth = "November "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			if(convMonthPick.substring(0,2).equals("12"))
			forMonth = "December "+convMonthPick.substring(convMonthPick.lastIndexOf("-"));
			 totalmonth=Integer.parseInt(attencequery.toGetAllDates(convMonthPick));
		}
		String condition	= request.getParameter("attendanceradio");
		String sessionuserid		= (String)session.getValue("userid");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		if(sessionid != null && boardid!= null && standardscheduleid!= null && sectionscheduleid!= null) {
			studentList			= attencequery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid);
		}
			
%>

<form name="Attendance_Form" action="" method="post">
		<input type=hidden name=session value="<%=sessionid%>">
		<input type=hidden name=board value="<%=boardid%>">
		<input type=hidden name=standard value="<%=standardscheduleid%>">
		<input type=hidden name=section value="<%=sectionscheduleid%>">
		<input type=hidden name=fromdate value="<%=attendancedate%>">
		<input type=hidden name=condition value="<%=condition%>">
		
		<input type="hidden" name="sessionname" value="<%=sessionname%>">
		<input type="hidden" name="boardname" value="<%=boardname%>">
		<input type="hidden" name="standardname" value="<%=standardschedulename%>">
		<input type="hidden" name="sectionname" value="<%=sectionschedulename%>">
		<table width='80%' id=rounded-corner align='center' border='0' >
		 <thead>
		    	<tr>
		        	
		            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("hmlabel.attendanceviewlist.selecteddetails")%></th>
		        	<th scope="col" class="rounded-q4" width="10%" ></th>
		        </tr>
		    </thead>
			<tr>
			<td colspan=2><table border=0 cellpadding=0 width="100%">
			<tr>
				<td width='20%' class='tablebold'><%=bundle.getString("hmlabel.attendanceviewlist.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
				<%=sessionname%>
				</td>
				<td width='5%' class='tablebold'><%=bundle.getString("hmlabel.attendanceviewlist.board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%'>
					<%=boardname%>
				</td>
			
			</tr>
			<tr>
			
				<td width='20%' class='tablebold' ><%=bundle.getString("hmlabel.attendanceviewlist.standard")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=standardschedulename%>
				</td>
				<td  class='tablebold'><%=bundle.getString("hmlabel.attendanceviewlist.section")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=sectionschedulename%>
				</td>
			</tr>
			<tr>
			<%
			if(condition.equals("today") ||  condition.equals("date"))
			{%>
			<td class='tablebold'>
			<%=bundle.getString("hmlabel.attendanceviewlist.date")%>
			</td>
			<td class='tablebold'>
			:
			</td>
				<td width='100%' colspan=4>
					 <%=attendancedate%>
				</td>
				<%}
			else if(condition.equals("month"))
			{%>
				<td width='20%' class='tablebold' ><%=bundle.getString("hmlabel.attendanceviewlist.month")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' colspan=4>
					<%=forMonth%>
				</td>
			<%}%>
			</tr>
		</table>
		</td></tr></table>
		<br/>
						<%
						if(condition.equals("today") || condition.equals("date"))
						{
							%>
					<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("hmlabel.attendanceviewlist.slno")%></th>
					            <th scope="col" class="rounded" 		width="40%"><%=bundle.getString("hmlabel.attendanceviewlist.studentname")%></th>
					            <th scope="col" class="rounded" 		width="25%"><%=bundle.getString("hmlabel.attendanceviewlist.rollno")%></th>
					        	<th scope="col" class="rounded-q4"   align="center" width="25%"><%=bundle.getString("hmlabel.attendanceviewlist.attendance")%></th>
					        </tr>
					    </thead>
							<%
						if(studentList != null && studentList.size()>0){
							attendancedate=dateobj.getMySQLFormat(attendancedate)+"";

							for(int y=0,j=1;y<studentList.size();y++,j++){
								hashmap			= (HashMap)studentList.get(y);
								String Studname		= (String)hashmap.get("applicantname");
								String rollno		= (String)hashmap.get("rollno")+"";
								if(rollno.equals("null"))
									rollno="-";
								String studallocationid	= (String)hashmap.get("studentallocationid");
								out.print("<tr>");
								out.print("<td align=center>"+j+".</td>");
								out.print("<td>"+Studname+"</td>");
								out.print("<td>"+rollno+"</td>");
								//System.out.println("attendancedate========>>>>>>"+attendancedate);
								ArrayList Studstate=attencequery.getattendanceforview(studallocationid,attendancedate);
								String status="-";
								if(Studstate.size()>0)
								{
								HashMap studmap=(HashMap)Studstate.get(0);
								status=studmap.get("studentstate")+"";
									if(status.equals("null"))
									status="-";
									else if(status.equals("P"))
										status="Present";
									else if(status.equals("A"))
										status="Absent";
									else  if(status.equals("OD"))
										status="On Duty";
								}
								out.print("<td>"+status+"</td>");
								out.print("</tr>");
							}
						}
						else
						{
							out.print("<tr><td colspan='5' class=tablebold align='center'><font color=red> Data Not Found</font></td></tr>");
						}
							out.print("</table>");

						}
						else if(condition.equals("month"))
						{%>
						<div class="myScrollingDiv">
						<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="5%" ><%=bundle.getString("hmlabel.attendanceviewlist.slno")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("hmlabel.attendanceviewlist.studentname")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("hmlabel.attendanceviewlist.rollno")%></th>
					            <%
					            for(int y=1;y<=totalmonth;y++){
					           	if(totalmonth==y)
					           	{
								out.print("<th width='1' class='rounded-q4'>"+y+"</th>");
					            }
					           	else
					           	{
									out.print("<th width='1' class='rounded'>"+y+"</th>");
					           	}
					            }
					            %>
					        </tr>
					    </thead>
					    <tbody>
					<%
					if(studentList != null && studentList.size()>0){
						for(int y=0,j=1;y<studentList.size();y++,j++){
							hashmap			= (HashMap)studentList.get(y);
							String Studname		= (String)hashmap.get("applicantname");
							String rollno		= (String)hashmap.get("rollno");
							String studallocationid	= (String)hashmap.get("studentallocationid");
							out.print("<tr>");
							out.print("<td>"+j+".</td>");
							out.print("<td>"+Studname+"</td>");
							out.print("<td>"+rollno+"</td>");
							 for(int i=1;i<=totalmonth;i++){
							if(!convMonthPick.equals("") || !convMonthPick.equals("null"))
							{
							String monthPickarray []= convMonthPick.split("-");
							attendancedate=monthPickarray[1]+"-"+monthPickarray[0]+"-"+i;
							}
							ArrayList Studstate=attencequery.getattendanceforview(studallocationid,attendancedate);
							String status="-";
							if(Studstate.size()>0)
							{
							HashMap studmap=(HashMap)Studstate.get(0);
							status=studmap.get("studentstate")+"";
							if(status.equals("null"))
							status="-";
							}
							out.print("<td>"+status+"</td>");
							 }
							out.print("</tr>");
						}
					}
					else
					{
						out.print("<tr><td colspan='5' align='center' class='tablebold'><font color=red>Data Not Found</font></td></tr>");
					}
					%>
					
						</tbody>
						</table>
						
					
</div>
<br>
<table>
					<tr>
					<td valign=top>
						Note:</td><td>&nbsp;</td><td> P-Present<br>A-Absent<br>OD-OnDuty</br></td>
						</tr>
					</table>
						<%}%>
			
		</table>
							
							<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("hmbutton.attendanceviewlist.back")%></strong><span class="bt_blue_r"></span></a>
		
</form>		
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>