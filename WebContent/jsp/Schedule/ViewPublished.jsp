<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	
	function publishStandard(){
		
		if(check_ForParticularElements(document.Schedule_Form.eligibility,"textarea",document.Schedule_Form.seats,"text",document.Schedule_Form.startdate,"text",document.Schedule_Form.enddate,"text",document.Schedule_Form.lastdate,"text")){
			
			if(!isNaN(document.Schedule_Form.seats.value)){
				
				
				if(parseInt(document.Schedule_Form.seats.value)<parseInt(document.Schedule_Form.noofallocated.value))
					{
					alert("Already "+document.Schedule_Form.noofallocated.value+" students are allocated for this standard.\n So, you can not allow to reduce the seats");
					return false;
					}
				
				document.Schedule_Form.action = "UpdateStandard.jsp";
				document.Schedule_Form.submit();
			}
			else
				alert("Please enter number for number of seats.")

		}
	}
	
	function goBack(){
		
		document.Schedule_Form.action = "StandardSchedule.jsp";
		document.Schedule_Form.submit();
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

    <h2><%=bundle.getString("label.schedule.standardscheduleupdate")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Schedule.Schedule,com.iGrandee.Common.DateTime"%>
<%

		Schedule schedule			= new Schedule();
		ArrayList stndardList		= null;
		HashMap	hashmap				= null;
		String noofallocatedstudent =  null;
		String sessionid			= request.getParameter("session");
		String sessionnname			= request.getParameter("sessionname");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		String boardname			= request.getParameter("boardname");
		String boardid				= request.getParameter("board");
		stndardList					= schedule.viewDetails(standardscheduleid);
		noofallocatedstudent = schedule.loadAllocatedStudents(standardscheduleid);
		if(noofallocatedstudent ==null)
			noofallocatedstudent = "0";
		/* //select count(*) from studentallocation a,sectionschedule b
 where a.studentallocationstatus='A' and a.sectionscheduleid=b.sectionscheduleid and 
b.sectionschedulestatus='A' and b.standardscheduleid='2'; */
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		String eligibility			= "";
		String archival				= request.getParameter("archival");
		
%>

<form name="Schedule_Form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
		            <th scope="col" class="rounded-q4" 		width="10%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<%=sessionnname %>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.board")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<%=boardname %>
							</td>
						</tr>
						<%
						if(archival != null && archival.equals("R")){
						%>		
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.archivaldetails")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' width='79%'>
								<h3><%=bundle.getString("label.schedule.archivalmessage")%></h3>
							</td>
						</tr>
						<%		
							}
						%>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
				
					<table id="rounded-corner" border=0 summary="Department List" width="80%">
					    <thead>
					    	<tr>
					            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.schedule.updatedetails")%></th>
					            <th scope="col" class="rounded-q4" 		width="10%"></th>
					        </tr>
					    </thead>
						<tr>
							<td colspan='2'>
								<table width='90%' align='center' border='0' cellspacing='2' >
									<%
									try{
			
										if(stndardList != null && stndardList.size()>0){
											hashmap			= (HashMap)stndardList.get(0);
											
											out.print("<tr><td valign='top'>"+bundle.getString("label.schedule.standardname")+"</td><td valign='top'>:</td><td colspan=2>"+hashmap.get("standardname")+"</td></tr>");
											if(hashmap.get("groupstatus") != null && ((String)hashmap.get("groupstatus")).equals("Yes"))
												out.print("<tr><td valign='top'>"+bundle.getString("label.schedule.groupname")+"</td><td valign='top'>:</td><td colspan=2>"+hashmap.get("groupname")+"</td></tr>");
											
											eligibility	= (String)hashmap.get("eligibility");
											
											if(eligibility == null)
												eligibility	= "";
											
											out.print("<tr><td valign='top'>"+bundle.getString("label.schedule.eligibility")+"</td><td valign='top'>:</td><td colspan=2><textarea rows='5' validate='Eligibility' cols='50' name='eligibility' maxlength='500' onkeypress=calculateRemaining(this,500,'remaining') onkeyup=calculateRemaining(this,500,'remaining')>"+eligibility+"</textarea><br><span id='remaining'><font color='red'>"+(500-eligibility.length())+" characters remaining</font></span></td></tr>");
											out.print("<tr><td valign='top'>"+bundle.getString("label.schedule.noofseats")+"</td><td valign='top'>:</td><td><input type='text' validate='No of Seats' name='seats' size='5' maxlength='4' value='"+hashmap.get("noofseats")+"'></td><td>Allocated Students: "+noofallocatedstudent+"<input type=hidden name='noofallocated' value='"+noofallocatedstudent+"'></tr>");
											out.print("<tr><td valign='top'>"+bundle.getString("label.schedule.startdate")+"</td><td valign='top'>:</td><td colspan=2><input type='text' validate='Start Date' name='startdate' validate='Start Date' size='11' value='"+hashmap.get("startdate")+"' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.startdate','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td></tr>");
											out.print("<tr><td valign='top'>"+bundle.getString("label.schedule.enddate")+"</td><td valign='top'>:</td><td colspan=2><input type='text' validate='End Date' name='enddate' validate='End Date' size='11' value='"+hashmap.get("enddate")+"' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.enddate','0',event,'Not_Less_Than_StartDate',Schedule_Form.startdate)></td></tr>");
											//out.print("<tr><td valign='top'>"+bundle.getString("label.schedule.lastdate1")+"</td><td valign='top'>:</td><td><input type='text' validate='Last Date' name='lastdate' validate='Last Date' size='11' value='"+hashmap.get("applicationlastdate")+"' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.lastdate','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td></tr>");
											out.print("<input type='hidden' name='lastdate' value='"+hashmap.get("applicationlastdate")+"'>");
				
										}
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
											//out.print("<tr><td colspan='3' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
										}
									}
									catch(Exception e){
									}
									%>
								        
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>

		<%
		if(archival != null && archival.equals("R")){
		%>	
		<a href="#back" 	name='back' 	class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<%}else{ %>
				<a href="#back" 	name='back' 	class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		
			<a href="#" id="savebut"  class="bt_green" onclick='publishStandard()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.update")%></strong><span class="bt_green_r"></span></a>
		<%} %>
		
		<!-- <input type='hidden' name='todaydate' 			value='<=today%>'> -->
		<input type='hidden' name='todaydate' 			value=''>
		<input type='hidden' name='sessionname' 		value='<%=sessionnname%>'>
		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='boardname' 			value='<%=boardname%>'>
		<input type='hidden' name='board' 				value='<%=boardid%>'>
		<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid%>'>
		<input type='hidden' name='archival' 			value='<%=archival%>'>
		
		
		
</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>