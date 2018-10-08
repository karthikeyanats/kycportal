<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Student  List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	

	function loadStandards(){
		if(check_ForParticularElements(document.Attendance_Form.session,"select")){
			document.Attendance_Form.submit();
		}
	}
	var count=0;
	function radiovalue(obj)
	{
	count++;
	var no=obj.getAttribute("no");
	for(var i=0;i<eval("document.Attendance_Form.attendanceradio"+no+".length");i++)
	{
	if(document.Attendance_Form.attendanceoutput.length==undefined)
	{
	if(eval("document.Attendance_Form.attendanceradio"+no+"["+i+"].checked"))
	document.Attendance_Form.attendanceoutput.value=eval("document.Attendance_Form.attendanceradio"+no+"["+i+"].value");
	}
	else
	{
	if(eval("document.Attendance_Form.attendanceradio"+no+"["+i+"].checked"))
	document.Attendance_Form.attendanceoutput[no].value=eval("document.Attendance_Form.attendanceradio"+no+"["+i+"].value");
	}
	}
	}
	function insertattendance()
	{
	if(count>0){
	for(var j=0;j<document.Attendance_Form.attendanceoutput.length;j++)
		{
			if(document.Attendance_Form.attendanceoutput[j].value=="")
			{
				document.Attendance_Form.attendanceoutput[j].disabled=true;
				document.Attendance_Form.studallocationid[j].disabled=true;
				document.Attendance_Form.editstatus[j].disabled=true;
				document.Attendance_Form.studentattendanceid[j].disabled=true;
			}
		}
		document.Attendance_Form.action="./StudentAttendanceEntrySubmit.jsp";
		document.Attendance_Form.submit();
	}
	else
	{
	alert("Check any one State");
	}
	}
	function backfun()
	{
	document.Attendance_Form.action="./AttendanceEntry.jsp";
	document.Attendance_Form.submit();
	}
	
	function subnitfunc()
	{
	if(confirm("Do you want to Submit the Attendance...?"))
	{
	insertattendance();
	}
	}
	function attendenceedit(obj)
	{
	if(confirm("Do you want to Edit the Attendance Details...?"))
	{
	count++;
	var no=obj.getAttribute("no");
	if(document.Attendance_Form.attendanceoutput.length==undefined)
	{
		document.Attendance_Form.editstatus.value="update";
		eval("document.getElementById('studstatusedit"+no+"').style.visibility='hidden'");
		eval("document.getElementById('studstatusextra"+no+"').style.visibility='hidden'");
		eval("document.getElementById('studstatusdelete"+no+"').style.visibility='hidden'");
		eval("document.getElementById('studstatusradio"+no+"').style.visibility='visible'");
		if(document.Attendance_Form.editrestoredata.length==undefined)
		{
			for(var j=0;j<eval("document.Attendance_Form.attendanceradio"+no+".length");j++)
				{
					if(document.Attendance_Form.editrestoredata.value==eval("document.Attendance_Form.attendanceradio"+no+"["+j+"].value"))
						{
							eval("document.Attendance_Form.attendanceradio"+no+"["+j+"].checked=true")
							document.Attendance_Form.attendanceoutput.value=document.Attendance_Form.editrestoredata.value;
						}
				}	
		}
		else if(document.Attendance_Form.editrestoredata.length>0)
		{
			for(var j=0;j<eval("document.Attendance_Form.attendanceradio"+no+".length");j++)
			{
				if(document.Attendance_Form.editrestoredata[no].value==eval("document.Attendance_Form.attendanceradio"+no+"["+j+"].value"))
				{
					document.Attendance_Form.attendanceoutput.value=document.Attendance_Form.editrestoredata.value;
					eval("document.Attendance_Form.attendanceradio0.checked=true")
				}
			}
		}
	}
	else
	{
	document.Attendance_Form.editstatus[no].value="update";
	eval("document.getElementById('studstatusedit"+no+"').style.visibility='hidden'");
	eval("document.getElementById('studstatusextra"+no+"').style.visibility='hidden'");
	eval("document.getElementById('studstatusdelete"+no+"').style.visibility='hidden'");
	eval("document.getElementById('studstatusradio"+no+"').style.visibility='visible'");
	if(document.Attendance_Form.editrestoredata.length==undefined)
	{
	for(var j=0;j<eval("document.Attendance_Form.attendanceradio"+no+".length");j++)
	{
	if(document.Attendance_Form.editrestoredata.value==eval("document.Attendance_Form.attendanceradio"+no+"["+j+"].value"))
	{
	eval("document.Attendance_Form.attendanceradio"+no+"["+j+"].checked=true")
	document.Attendance_Form.attendanceoutput[no].value=document.Attendance_Form.editrestoredata.value;
	}
	}	
	}
	else if(document.Attendance_Form.editrestoredata.length>0)
	{
	for(var j=0;j<eval("document.Attendance_Form.attendanceradio"+no+".length");j++)
	{
	if(document.Attendance_Form.editrestoredata[no].value==eval("document.Attendance_Form.attendanceradio"+no+"["+j+"].value"))
	{
	document.Attendance_Form.attendanceoutput[no].value=document.Attendance_Form.editrestoredata[no].value;
	eval("document.Attendance_Form.attendanceradio"+no+"["+j+"].checked=true")
	}
	}
	}
	}
	}
	}
	function attendencedelete(obj)
	{
	if(confirm("Do you want to Delete the Attendance Details...?"))
	{
	count++;
	var no=obj.getAttribute("no");
	if(document.Attendance_Form.attendanceoutput.length==undefined)
	{
		document.Attendance_Form.editstatus.value="delete";
		document.Attendance_Form.attendanceoutput.value="X";
	}
	else
	{
		document.Attendance_Form.editstatus[no].value="delete";
		document.Attendance_Form.attendanceoutput[no].value="X";
	}
	document.Attendance_Form.finaleditstatus.value="delete";
	insertattendance();
	
	/*eval("d.getElementById('studstatus"+no+"').style.visibility='hidden'");
	eval("d.getElementById('studstatusedit"+no+"').style.visibility='hidden'");
	eval("d.getElementById('studstatusradio"+no+"').style.visibility='hidden'");*/
	}
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

    <h2><%=bundle.getString("label.schedule.studentattendancelist")%></h2>
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
		String sessionstatus			= request.getParameter("sessionstatus")+"";

		String sessionid			= request.getParameter("session");
		String boardid				= request.getParameter("board");
		String standardscheduleid	= request.getParameter("standard");
		String sectionscheduleid	= request.getParameter("section");
		String sessionname			= request.getParameter("sessionname");
		String boardname				= request.getParameter("boardname");
		String standardschedulename	= request.getParameter("standardname");
		String sectionschedulename	= request.getParameter("sectionname");
		String dateofattendance	= request.getParameter("attendancedate");
		
		String sessionuserid			= (String)session.getValue("userid");
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
		<input type=hidden name=dateofattendance value="<%=dateofattendance%>">
		<input type="hidden" name="sessionname" value="<%=sessionname%>">
		<input type="hidden" name="boardname" value="<%=boardname%>">
		<input type="hidden" name="standardname" value="<%=standardschedulename%>">
		<input type="hidden" name="sectionname" value="<%=sectionschedulename%>">
		<input type="hidden" name="finaleditstatus" value="">
		
		
		<table width='80%' id=rounded-corner align='center' border='0' >
			<thead>
			<tr>
				<th scope="col" class="rounded-company" width="90%" colspan=5><%=bundle.getString("label.schedule.selectedinfo")%></th>
				<th scope="col" class="rounded-q4" width="10%"></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan=5 class="rounded-foot-left"><em></em></td>
				<td class="rounded-foot-right">&nbsp;</td>
			</tr>
		</tfoot>			
			<tr>
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='34%'>
				<%=sessionname%>
				</td>
				<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='34%'>
					<%=boardname%>
				</td>
			</tr>
			<tr>
				<td class='tablebold' ><%=bundle.getString("label.schedule.standardname")%></td>
				<td class='tablebold'>:</td>
				<td class='tablelight'>
					<%=standardschedulename%>
				</td>
				<td class='tablebold'><%=bundle.getString("label.schedule.section")%></td>
				<td class='tablebold'>:</td>
				<td class='tablelight'>
					<%=sectionschedulename%>
				</td>
			</tr>
			<tr>
			<td class='tablebold'>
			<%=bundle.getString("label.schedule.date")%>
			</td>
			<td class='tablebold'>
			:
			</td>
				<td width='100%' colspan=4>
					 <%=dateofattendance%>
				</td>
			</tr>
			
		</table>
		<br>
				<table width='90%' align='center'  border='0' >
		
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0  width="100%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.schedule.slno")%>.</th>
					            <th scope="col" class="rounded" 		width="25%"><%=bundle.getString("label.schedule.studentname")%></th>
					            <th scope="col" class="rounded" 		width="15%"><%=bundle.getString("label.schedule.rollno")%></th>
					            <th scope="col" class="rounded"   	 width="25%"><%=bundle.getString("label.schedule.attendance")%></th>
					        	<th scope="col" class="rounded-q4"   align="center" width="25%"><%=bundle.getString("label.schedule.action")%></th>
					            
					        </tr>
					    </thead>
					        
						<%

						if(studentList != null && studentList.size()>0){
							for(int y=0,j=1;y<studentList.size();y++,j++){
								hashmap			= (HashMap)studentList.get(y);
								String Studname		= (String)hashmap.get("applicantname");
								String rollno		= hashmap.get("rollno")+"";
								if(rollno.equals("null"))
									rollno="-";
								String studallocationid	= (String)hashmap.get("studentallocationid");
								out.print("<tr>");
								out.print("<td align=center>"+j+".</td>");
								out.print("<td>"+Studname+"</td>");
								out.print("<td>"+rollno+"</td>");
								String searchdate=dateobj.getMySQLFormat(dateofattendance)+"";
								ArrayList Studstate=attencequery.getattendanceforstudent(studallocationid,searchdate);
								String status="";
								String attendanceid="";

								if(Studstate.size()>0)
								{
								HashMap studmap=(HashMap)Studstate.get(0);
								 status=studmap.get("studentstate")+"";
								 attendanceid=studmap.get("studentattendanceid")+"";
								if(status.equals("null"))
									status="";
								if(attendanceid.equals("null"))
									attendanceid="";
								}
								if(status.equals(""))
								{
								out.print("<td>-</td>");
								out.print("<td >");

								if(sessionstatus.equals("R"))
								{
									out.print("<input type=radio disabled name=attendanceradio"+y+" value='P' no='"+y+"' onclick='radiovalue(this)'>P");
									out.print("<input type=radio  disabled name=attendanceradio"+y+" value='A' no='"+y+"' onclick='radiovalue(this)'>A");
									out.print("<input type=radio  disabled name=attendanceradio"+y+" value='OD' no='"+y+"' onclick='radiovalue(this)'>OD");
								}
								else
								{
								out.print("<input type=radio name=attendanceradio"+y+" value='P' no='"+y+"' onclick='radiovalue(this)'>P");
								out.print("<input type=radio name=attendanceradio"+y+" value='A' no='"+y+"' onclick='radiovalue(this)'>A");
								out.print("<input type=radio name=attendanceradio"+y+" value='OD' no='"+y+"' onclick='radiovalue(this)'>OD");
								}
								}
								
								else
								{
									out.print("<td>");
									if(status.equals("P"))
											out.print("Present");
									else if(status.equals("A"))
										out.print("Absent");
									else 
										out.print(status);
									out.print("</td>");
									out.print("<td>");
									if(sessionstatus.equals("R"))
									{
									out.print("<font color=grey>Edit&nbsp;|&nbsp;Delete</font>");
									}
									else
									{
										out.print("<input type=hidden name=editrestoredata value='"+status+"'>");
										out.print("<a id='studstatusradio"+y+"' style='visibility:hidden'>");
										out.print("<input type=radio    name=attendanceradio"+y+" value='P' no='"+y+"' onclick='radiovalue(this)' />P <input type=radio    name=attendanceradio"+y+" value='A' no='"+y+"' onclick='radiovalue(this)' />A");
										out.print("<input type=radio    name=attendanceradio"+y+" value='OD' no='"+y+"' onclick='radiovalue(this)' />OD</a><br>");
										out.print("<a href='#' id='studstatusedit"+y+"' no='"+y+"' onclick='attendenceedit(this)'>Edit</a><a id='studstatusextra"+y+"'>&nbsp;|&nbsp;</a><a href='#' id='studstatusdelete"+y+"' no='"+y+"' onclick='attendencedelete(this)'>Delete</a><br>");
									}
								}
								out.print("<input type=hidden name=attendanceoutput value=''>");
								out.print("<input type=hidden name=editstatus value='new'>");
								out.print("<input type=hidden name=studallocationid value='"+studallocationid+"'>");
								out.print("<input type=hidden name=studentattendanceid value='"+attendanceid+"'>");
								out.print("</td>");  

								out.print("<tr>");
							}
						}
						else{
							out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
							//out.print("<tr><td colspan='5' align='center'> "+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
						}

						%>
					       <script>
					       if(document.Attendance_Form.attendanceoutput!=null )
					       {
						       if(document.Attendance_Form.attendanceoutput.length==undefined)
						       {
							       for(var i=0;i<eval("document.Attendance_Form.attendanceradio0.length");i++)
								   {
										if(eval("document.Attendance_Form.attendanceradio0["+i+"].value")==document.Attendance_Form.attendanceoutput.value)
										eval("document.Attendance_Form.attendanceradio0["+i+"].checked=true");
								   }
						       }
						       else
						       {					       
						       		for(var j=0;j<document.Attendance_Form.attendanceoutput.length;j++)
									{
										for(var i=0;i<eval("document.Attendance_Form.attendanceradio"+j+".length");i++)
										{
											if(eval("document.Attendance_Form.attendanceradio"+j+"["+i+"].value")==document.Attendance_Form.attendanceoutput[j].value)
											eval("document.Attendance_Form.attendanceradio"+j+"["+i+"].checked=true");
										}
									}
								}
					       }
							</script>
					</table>
					<br>
					<table>
					<tr>
					<%
					if(sessionstatus.equals("R"))
					{
						out.println("<div class=warning_box>"+bundle.getString("label.schedule.archivalmessage")+"</div>");
					}
					%>
					<td valign=top>
						Note:</td><td>&nbsp;</td><td> P-Present<br>A-Absent<br>OD-OnDuty</br></td>
						</tr>
					</table>
					
					<a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
					<a href="#" class="bt_green" onclick='insertattendance()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.submit")%></strong><span class="bt_green_r"></span></a>
				
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