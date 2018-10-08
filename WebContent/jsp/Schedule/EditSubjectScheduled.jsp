<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>


<script type="text/javascript">
	
	function publishStandard(){
		
		if(check_ForParticularElements(document.Schedule_Form.seats[0],"text",document.Schedule_Form.seats[1],"text",document.Schedule_Form.seats[2],"text",document.Schedule_Form.seats[3],"text",document.Schedule_Form.seats[4],"text",document.Schedule_Form.seats[5],"text",document.Schedule_Form.seats[6],"text",document.Schedule_Form.seats[7],"text",document.Schedule_Form.seats[8],"text",document.Schedule_Form.seats[9],"text",document.Schedule_Form.seats[10],"text",document.Schedule_Form.seats[11],"text",document.Schedule_Form.chours,"text")){
			if(checkNumber(document.Schedule_Form.seats[0],document.Schedule_Form.seats[1],document.Schedule_Form.seats[2],document.Schedule_Form.seats[3],document.Schedule_Form.seats[4],document.Schedule_Form.seats[5],document.Schedule_Form.seats[6],document.Schedule_Form.seats[7],document.Schedule_Form.seats[8],document.Schedule_Form.seats[9],document.Schedule_Form.seats[10],document.Schedule_Form.seats[11],document.Schedule_Form.chours)){

				document.Schedule_Form.action = "UpdateSubjectsScheduled.jsp";
				document.Schedule_Form.submit();
			}
		}
	}
	
	function goBack(){
		
		document.Schedule_Form.action = "ViewSubjects.jsp";
		document.Schedule_Form.submit();
	}
	
	function checkNumber(){
	
	   	for(var i=0;i<arguments.length;i++)
	   	{
			var isValid = false;
			if(arguments[i].value.length == 1)
				isValid =/^[1-9]/.test(arguments[i].value)
			else if(arguments[i].value.length == 2)
				isValid =/^[1-9][0-9]/.test(arguments[i].value)
			else if(arguments[i].value.length == 3)
				isValid =/^[1-9][0-9][0-9]/.test(arguments[i].value)
			
			if(!isValid){
				alert("Please enter a valid "+arguments[i].getAttribute("validate"));
				arguments[i].value	= 0;
				arguments[i].focus();
				return isValid;
			}
		}
		return true;
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

    <h2><%=bundle.getString("label.schedule.updatesubjectschedule")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Schedule.Schedule,com.iGrandee.Common.DateTime"%>
<%

		Schedule schedule			= new Schedule();
		String standardscheduleid	= request.getParameter("standardscheduleid");
		ArrayList stndardList		= schedule.viewDetails(standardscheduleid);
		HashMap	hashmap				= null;
		String sessionid			= request.getParameter("session");
		String sessionnname			= request.getParameter("sessionname");
		String boardname			= request.getParameter("boardname");
		String boardid				= request.getParameter("board");
		String subjectid			= request.getParameter("subjectid");
		String subjectscheduleid	= request.getParameter("subjectscheduleid");
		String subjectname			= request.getParameter("subjectname");
		String instituteid			= (String)session.getValue("instituteid");
		String today				= DateTime.showTime("calendar");
		String eligibility			= "";
		String archival				= request.getParameter("archival");
		ArrayList subjectList		= schedule.viewSubjectsScheduledDetail(subjectscheduleid);
		String sname				= "";
		String groupname			= "";
		String status				= "";
		
		if(stndardList != null && stndardList.size()>0){
			hashmap			= (HashMap)stndardList.get(0);
			sname			= (String)hashmap.get("standardname");
			if(hashmap.get("groupstatus") != null && ((String)hashmap.get("groupstatus")).equals("Yes"))
				groupname	= (String)hashmap.get("groupname");
		}
		
		
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
		    	<td colspan='3'>						
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
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.standardname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<%=sname %>
							</td>
						</tr>
						<%if(!groupname.equals("")){
						
						%>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.groupname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<%=groupname %>
							</td>
						</tr>
						<%} %>	
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.subjectname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<%=subjectname %>
							</td>
						</tr>
						<%
						if(archival != null && archival.equals("R")){
						%>		
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.archivaldetails") %></td>
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
					            <th scope="col" class="rounded-company" 		width="90%"><%=bundle.getString("label.schedule.updatedetails")%></th>
					            <th scope="col" class="rounded-q4" 		width="10%"></th>
					        </tr>
					    </thead>
						<tr>
							<td colspan='3'>
								<table width='90%' align='center' border='0' cellspacing='2' >
								
									<%
									
									try{
			
										if(subjectList != null && subjectList.size()>0){
											hashmap			= (HashMap)subjectList.get(0);
											
											out.print("<tr><td  rowspan='2' width='20%'>"+bundle.getString("label.schedule.theoryinternal")+"</td><td valign='top' width='10%'>"+bundle.getString("label.schedule.min")+"<font color=red>*</font></td><td valign='top' width='1%'>:</td><td width='69%'><input type='text' validate='Theory Internal Min' name='seats' size='5' maxlength='3' value='"+hashmap.get("theoryinternalmin")+"'></td></tr>");
											out.print("<tr><td  valign='top' >"+bundle.getString("label.schedule.max")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Theory Internal Max' name='seats' size='5' maxlength='3' value='"+hashmap.get("theoryinternalmax")+"'></td></tr>");
											
											out.print("<tr><td  rowspan='2'>"+bundle.getString("label.schedule.theoryexternal")+"</td><td valign='top' >"+bundle.getString("label.schedule.min")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Theory External Min' name='seats' size='5' maxlength='3' value='"+hashmap.get("theoryexternalmin")+"'></td></tr>");
											out.print("<tr><td  valign='top' >"+bundle.getString("label.schedule.max")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Theory External Max' name='seats' size='5' maxlength='3' value='"+hashmap.get("theoryexternalmax")+"'></td></tr>");
											
											out.print("<tr><td  rowspan='2'>"+bundle.getString("label.schedule.practicalinternal")+"</td><td valign='top' >"+bundle.getString("label.schedule.min")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Practical Internal Min' name='seats' size='5' maxlength='3' value='"+hashmap.get("practicalinternalmin")+"'></td></tr>");
											out.print("<tr><td  valign='top' >"+bundle.getString("label.schedule.max")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Practical Internal Max' name='seats' size='5' maxlength='3' value='"+hashmap.get("practicalinternalmax")+"'></td></tr>");
											
											out.print("<tr><td  rowspan='2'>"+bundle.getString("label.schedule.practicalexternal")+"</td><td valign='top' >"+bundle.getString("label.schedule.min")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Practical External Min' name='seats' size='5' maxlength='3' value='"+hashmap.get("practicalexternalmin")+"'></td></tr>");
											out.print("<tr><td  valign='top' >"+bundle.getString("label.schedule.max")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Practical External Max' name='seats' size='5' maxlength='3' value='"+hashmap.get("practicalexternalmax")+"'></td></tr>");
											
											out.print("<tr><td  rowspan='2'>"+bundle.getString("label.schedule.projectinternal")+"</td><td valign='top' >"+bundle.getString("label.schedule.min")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Project Internal Min' name='seats' size='5' maxlength='3' value='"+hashmap.get("projectinternalmin")+"'></td></tr>");
											out.print("<tr><td  valign='top' >"+bundle.getString("label.schedule.max")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Project Internal Max' name='seats' size='5' maxlength='3' value='"+hashmap.get("projectinternalmax")+"'></td></tr>");
											out.print("<tr><td  rowspan='2'>"+bundle.getString("label.schedule.projectexternal")+"</td><td valign='top' >"+bundle.getString("label.schedule.min")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Project External Min' name='seats' size='5' maxlength='3' value='"+hashmap.get("projectexternalmin")+"'></td></tr>");
											out.print("<tr><td  valign='top' >"+bundle.getString("label.schedule.max")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Project External Max' name='seats' size='5' maxlength='3' value='"+hashmap.get("projectexternalmax")+"'></td></tr>");
											out.print("<tr><td  valign='top' colspan='2'>"+bundle.getString("label.schedule.credithours")+"<font color=red>*</font></td><td valign='top'>:</td><td><input type='text' validate='Credit Hours' name='chours' size='5' maxlength='3' value='"+hashmap.get("credithours")+"'></td></tr>");
										}
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
											//out.print("<tr><td colspan='4' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
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
			<a href="#" id="savebut"  class="bt_green" onclick='publishStandard()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.update")%></strong><span class="bt_green_r"></span></a>
			<a href="#back" 	name='back' 	class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<%} %>
		
		<input type='hidden' name='todaydate' 			value='<%=today%>'>
		<input type='hidden' name='sessionname' 		value='<%=sessionnname%>'>
		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='boardname' 			value='<%=boardname%>'>
		<input type='hidden' name='board' 				value='<%=boardid%>'>
		<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid%>'>
		<input type='hidden' name='archival' 			value='<%=archival%>'>
		<input type='hidden' name='subjectid' 			value='<%=subjectid%>'>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>
		<input type='hidden' name='subjectscheduleid' 	value='<%=subjectscheduleid%>'>
		
		
		
		
</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>