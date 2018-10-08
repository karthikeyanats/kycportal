<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	
	var count	= 0; 

	function loadStandards(){
		if(check_ForParticularElements(document.Schedule_Form.session,"select")){
			document.Schedule_Form.archival.value	= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].getAttribute("status");
			document.Schedule_Form.submit();
		}
	}
	
	function loadStandards1(){
	
		if(check_ForParticularElements(document.Schedule_Form.session,"select")){
			document.Schedule_Form.archival.value	= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].getAttribute("status");
			if(check_ForParticularElements(document.Schedule_Form.board,"select")){
				document.Schedule_Form.submit();
			}
		}
		else
			document.Schedule_Form.board.options.selectedIndex	= 0;
			
	}	
	
	function checkCount(obj){
		var pos	= obj.getAttribute("pos");
		if(obj.checked){
			if(check_ForParticularElements(document.Schedule_Form.starts[pos],"text",document.Schedule_Form.ends[pos],"text",document.Schedule_Form.totalseat[pos],"text")){
				
				if(isNaN(document.Schedule_Form.totalseat[pos].value)){
					obj.checked = false;
					alert("Please provide a valid Seat Number.");
					document.Schedule_Form.totalseat[pos].value	= "";
					return false;
				}
				else{
					document.Schedule_Form.totalseat[pos].value		= parseInt(document.Schedule_Form.totalseat[pos].value,10);
				}
				count++;
			}
			else
				obj.checked = false;
		}
		else{
			count--;
		}
	}
	function publishStandard(){
		
		if(check_ForParticularElements(document.Schedule_Form.lastdate,"text",document.Schedule_Form.session,"select")){
			
			if(count>0){
			
				for(var i=0;i<document.Schedule_Form.checkstandard.length;i++){
				
					if(!document.Schedule_Form.checkstandard[i].checked){
						
						document.Schedule_Form.starts[i].disabled 		= true;
						document.Schedule_Form.ends[i].disabled 		= true;
						document.Schedule_Form.groups[i].disabled 		= true;	
						document.Schedule_Form.totalseat[i].disabled 	= true;
						
					
					}
				}

				document.Schedule_Form.action = "PublishStandard.jsp";
				document.Schedule_Form.submit();
			}
			else{
				
				alert("Please select atleast a standard to publish");			
			}
		}
	}
	
	function trashedStandard(){
	
		if(check_ForParticularElements(document.Schedule_Form.session,"select",document.Schedule_Form.board,"select")){
			
			document.Schedule_Form.sessionname.value	= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
			document.Schedule_Form.boardname.value		= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
			document.Schedule_Form.action 				= "TrashedStandard.jsp";
			document.Schedule_Form.submit();
		}
	}	
	
	function callEdit(obj){
	if(confirm("Do you want to Update the Standard Details ...?"))
	{
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewPublished.jsp";
		document.Schedule_Form.submit();
		}
	}
	
	function loadSubject(obj){
	
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewSubjects.jsp";
		document.Schedule_Form.submit();
	}
	
	function loadSections(obj){
	
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewSections.jsp";
		document.Schedule_Form.submit();
	}
	
	function callTrash(obj){
	if(confirm("Do you want to Trash the Standard Details ...?"))
	{
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.standardname.value		= obj.getAttribute("standardname");
		document.Schedule_Form.action = "StandardTrashPreview.jsp";
		document.Schedule_Form.submit();
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


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">
	<%    
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <h2><%=bundle.getString("label.schedule.standardschedule")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Schedule.Schedule,com.iGrandee.Common.DateTime"%>
<%

		Schedule schedule			= new Schedule();
		String instituteid			= (String)session.getValue("instituteid");
		
		ArrayList sessionList		= schedule.sessionDetails(instituteid);
		ArrayList boardList			= schedule.boardDetails(instituteid);
		HashMap	hashmap				= null;
		ArrayList standardList		= null;
		String groupstatus			= "";
		String standardid			= "";
		int count					= 0;
		int stotal					= 0;
		int tcount					= 0;
		String sessionid			= request.getParameter("session");
		String boardid				= request.getParameter("board");
		String today				= DateTime.showTime("calendar");
		String archival				= request.getParameter("archival");
		String tempstandardid		= "";
		
		if(sessionid != null && boardid != null) {
			standardList			= schedule.standardDetails(instituteid,sessionid,boardid);
		}
%>

<form name="Schedule_Form" action="" method="post">


<table id="rounded-corner" border=0 summary="Department List" width="80%">
    <thead>
    	<tr>
        	 
        	 <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.schedule.academicyearandboard")%></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.schedule.mandatoryfield") %></th> 
        </tr>
    </thead>
		    <tr>
		    	<td colspan='2'>
					<table width='100%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%><font color=red>*</font></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='session' validate='<%=bundle.getString("label.schedule.academicyear")%>' onchange='loadStandards()'>
									<option value='0'>-Academic Year-</option>
									<%
										if(sessionList != null && sessionList.size()>0)
											for(int y=0;y<sessionList.size();y++){
												hashmap		= (HashMap)sessionList.get(y);
												if(sessionid != null && sessionid.equals((String)hashmap.get("sessionid")))
													out.print("<option selected value='"+hashmap.get("sessionid")+"' status='"+hashmap.get("sessionstatus")+"'>"+hashmap.get("sessionname")+"</option>");
												else
													out.print("<option value='"+hashmap.get("sessionid")+"' status='"+hashmap.get("sessionstatus")+"'>"+hashmap.get("sessionname")+"</option>");
											}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.board")%><font color=red>*</font></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='board' validate='<%=bundle.getString("label.schedule.board")%>' onchange='loadStandards1()'>
									<option value='0'>-Select Board-</option>
									<%
										
										if(boardList != null && boardList.size()>0)
										for(int y=0;y<boardList.size();y++){
											hashmap		= (HashMap)boardList.get(y);
											if(boardid != null && boardid.equals((String)hashmap.get("boardid")))
												out.print("<option selected value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
											else
												out.print("<option value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"-"+hashmap.get("mediumname")+"</option>");
										}
									
									%>
								</select>
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
				
					<table id="rounded-corner" border=0  width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
					            <th scope="col" class="rounded" 		width="26%"><%=bundle.getString("label.schedule.standardname")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("label.schedule.subjects")%></th>
					            <th scope="col" class="rounded" 		width="10%"><%=bundle.getString("label.schedule.sections")%></th>
					            <th scope="col" class="rounded" 		width="17%"><%=bundle.getString("label.schedule.startdate")%></th>
					            <th scope="col" class="rounded" 		width="17%"><%=bundle.getString("label.schedule.enddate")%></th>
					            <th scope="col" class="rounded" 		width="5%"><%=bundle.getString("label.schedule.noofseats")%></th>
					            <th scope="col" class="rounded" 		width="5%"><%=bundle.getString("label.schedule.check")%></th>
					            <th scope="col" class="rounded-q4" 		width="5%"><%=bundle.getString("label.schedule.trash")%></th>
					        </tr>
					    </thead>
						<%
						try{
							if(standardList != null && standardList.size()>0){
								
								for(int y=0;y<standardList.size();y++){
									
									hashmap			= (HashMap)standardList.get(y);
									groupstatus		= (String)hashmap.get("groupstatus");
									standardid		= (String)hashmap.get("standardid");
									
									if(groupstatus == null || groupstatus.equals("No")){
									
										tcount++;
										if(hashmap.get("startdate") == null){
											if(archival != null && archival.equals("R"))
												out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td>-</td><td>-</td><td><input type='text' validate='Start Date' name='starts' size='11' value='' onfocus='this.blur()'><input type='button' disabled value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+count+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type='text' name='ends' size='11' value='' validate='End Date' onfocus='this.blur()'><input type='button' disabled value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.ends["+count+"]','0',event,'Not_Less_Than_StartDate',Schedule_Form.starts["+count+"])></td><td><input type='text' name='totalseat' validate='Total Seats' size='6' maxlength='6' value='' onfocus='this.blur()' ></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' disabled value='"+standardid+"'><input type='hidden' name='groups' value='-'></td><td></td></tr>");
											else 
												out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td>-</td><td>-</td><td><input type='text' validate='Start Date' name='starts' size='11' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+count+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type='text' name='ends' size='11' value='' validate='End Date' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.ends["+count+"]','0',event,'Not_Less_Than_StartDate',Schedule_Form.starts["+count+"])></td><td><input type='text' name='totalseat' validate='Total Seats' size='6' maxlength='6' value=''></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+standardid+"'><input type='hidden' name='groups' value='-'></td><td></td></tr>");
											
											count++;
										}
										else{
											if(archival != null && archival.equals("R"))
												out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td><td>"+hashmap.get("noofseats")+"</td><td>-</td><td>-</td></tr>");
											else
												out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td><td>"+hashmap.get("noofseats")+"</td><td><a href='#edit"+y+"' name='edit"+y+"' onclick='callEdit(this)' standardscheduleid='"+hashmap.get("standardscheduleid")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='Edit' title='Edit' border='0' /></a></td><td><a href='#edit"+y+"' name='edit"+y+"' standardname='"+hashmap.get("standardname")+"' onclick='callTrash(this)' class='ask' standardscheduleid='"+hashmap.get("standardscheduleid")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='Trash' title='Trash' border='0'/></a></td></tr>");
										}
									}
									else{
										if(tempstandardid.equals("") || !tempstandardid.equals(standardid)){
											stotal	= 1;
											tcount++;
											out.print("<tr><td valign='top'>"+tcount+".</td><td colspan='8'>"+hashmap.get("standardname")+"</td></tr>");
											tempstandardid	= standardid;
											
										}
										
										if(hashmap.get("startdate") == null){
											if(archival != null && archival.equals("R"))
												out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td>-</td><td>-</td><td><input type='text' name='starts' validate='Start Date' size='11' value='' onfocus='this.blur()'><input type='button' disabled value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+count+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type='text' name='ends' validate='End Date' size='11' value='' onfocus='this.blur()'><input type='button' disabled value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.ends["+count+"]','0',event,'Not_Less_Than_StartDate',Schedule_Form.starts["+count+"])></td><td><input type='text' name='totalseat' validate='Total Seats' size='6' maxlength='6' value='' onfocus='this.blur()'></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' disabled onclick='checkCount(this)' value='"+standardid+"'><input type='hidden' name='groups' value='"+hashmap.get("groupid")+"'></td><td></td></tr>");
											else
												out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td>-</td><td>-</td><td><input type='text' name='starts' validate='Start Date' size='11' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+count+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type='text' name='ends' validate='End Date' size='11' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.ends["+count+"]','0',event,'Not_Less_Than_StartDate',Schedule_Form.starts["+count+"])></td><td><input type='text' name='totalseat' validate='Total Seats' size='6' maxlength='6' value=''></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+standardid+"'><input type='hidden' name='groups' value='"+hashmap.get("groupid")+"'></td><td></td></tr>");
												
											count++;
										}
										else {
											if(archival != null && archival.equals("R"))
												out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td><td>"+hashmap.get("noofseats")+"</td><td>-</td><td>-</td></tr>");
											else
												out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td><td>"+hashmap.get("noofseats")+"</td><td><a href='#edit"+y+"' name='edit"+y+"' onclick='callEdit(this)' standardscheduleid='"+hashmap.get("standardscheduleid")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_edit.png' alt='Edit' title='Edit' border='0' /></a></td><td><a href='#trash"+y+"' name='trash"+y+"' class='ask' onclick='callTrash(this)' standardname='"+hashmap.get("standardname")+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='Trash' title='Trash' border='0'/></a></td></tr>");

										}
										stotal++;
									}
								}
							}
							else{
								out.println("<tr align='center' class='tablebold'><td colspan='9'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='8' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
							}
						
						}catch(Exception e){
							e.printStackTrace();
						}
						%>
					        
					</table>
					
				
				</td>
			</tr>
		</table>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='100%' align='right'>
					
					
					<!-- 
					<%if(archival != null && archival.equals("R")){ %>
						<%=bundle.getString("label.schedule.lastdate")%><font color=red>*</font>&nbsp;:&nbsp;<input type='text' disabled name='lastdate' validate='Last Date for application' size='11' value='' onFocus='this.blur()'><input disabled type='button' value='^' onClick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Schedule_Form.lastdate','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)>
					<%}else{ %>
						<%=bundle.getString("label.schedule.lastdate")%><font color=red>*</font>&nbsp;:&nbsp;<input type='text' name='lastdate' validate='Last Date for application' size='11' value='' onFocus='this.blur()'><input type='button' value='^' onClick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Schedule_Form.lastdate','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)>
					
					<%} %>
					 -->
					
				</td>
			</tr>
		</table>
		<%if(archival != null && archival.equals("R")){ %>
			<a href="#" class="bt_red" onclick='trashedStandard()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.trashedlist")%></strong><span class="bt_red_r"></span></a>
		<%}else{ %>
			
			<a href="#" class="bt_red" onclick='trashedStandard()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.trashedlist")%></strong><span class="bt_red_r"></span></a>
			<a href="#" id="savebut"  class="bt_green" onclick='publishStandard()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.publish")%></strong><span class="bt_green_r"></span></a>			
		<%}%>
		
		<input type='hidden' name='lastdate' 					value='<%=today %>'>
		<!-- <input type='hidden' name='todaydate' 					value='<=today %>'> -->
		<input type='hidden' name='todaydate' 					value=''>
		<input type='hidden' name='starts' 			disabled>
		<input type='hidden' name='ends' 			disabled>
		<input type='hidden' name='groups' 			disabled>
		<input type='hidden' name='checkstandard' 	disabled>
		<input type='hidden' name='totalseat' 		disabled>
		
		
		<input type='hidden' name='sessionname' 				value=''>
		<input type='hidden' name='boardname' 					value=''>
		<input type='hidden' name='standardscheduleid' >
		<input type='hidden' name='archival' 					value='<%=archival%>'>
		<input type='hidden' name='standardname' 				value=''>
		
		
		
		
</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>