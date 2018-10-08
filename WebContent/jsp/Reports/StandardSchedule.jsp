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
		if(check_ForParticularElements(document.Schedule_Form.board,"select")){
			//document.Schedule_Form.archival.value	= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].getAttribute("status");
			//document.Schedule_Form.archival.value	= document.Schedule_Form.req_sessionstatus.value;
			document.Schedule_Form.req_boardid.value = document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].value;
			document.Schedule_Form.submit();
		}
	}
	
	function checkCount(obj){
		var pos	= obj.getAttribute("pos");
		if(obj.checked){
			if(check_ForParticularElements(document.Schedule_Form.starts[pos],"text",document.Schedule_Form.ends[pos],"text")){
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
						
						document.Schedule_Form.starts[i].disabled 	= true;
						document.Schedule_Form.ends[i].disabled 	= true;
						document.Schedule_Form.groups[i].disabled 	= true;						
					
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
	
		if(check_ForParticularElements(document.Schedule_Form.board,"select")){
			
			//document.Schedule_Form.sessionname.value	= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
			document.Schedule_Form.sessionname.value	= document.Schedule_Form.req_sessionname.value
			document.Schedule_Form.req_boardid.value = document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].value;
			document.Schedule_Form.boardname.value		= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
			document.Schedule_Form.action 				= "TrashedStandard.jsp";
			document.Schedule_Form.submit();
		}
	}	
	
	function callEdit(obj){
	
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewPublished.jsp";
		document.Schedule_Form.submit();
	}
	
	function loadSubject(obj){
	
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		//document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.req_sessionname.value;
		document.Schedule_Form.req_boardid.value = document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].value;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewSubjects.jsp";
		document.Schedule_Form.submit();
	}
	
	function loadSections(obj){
	
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		//document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.req_sessionname.value;
		document.Schedule_Form.req_boardid.value = document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].value;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "ViewSections.jsp";
		document.Schedule_Form.submit();
	}
	
	function callTrash(obj){
	
		document.Schedule_Form.standardscheduleid.value	= obj.getAttribute("standardscheduleid");
		document.Schedule_Form.sessionname.value		= document.Schedule_Form.session.options[document.Schedule_Form.session.options.selectedIndex].text;
		document.Schedule_Form.boardname.value			= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		document.Schedule_Form.action = "StandardTrashPreview.jsp";
		document.Schedule_Form.submit();
	}	
	
	function goBack()
	{
		document.Schedule_Form.action = "ReportIndexView.jsp";
		document.Schedule_Form.submit();
	}
function win(obj)
{

}
	function printfun()
	{
		//var attachment=obj.getAttribute("atta");
		document.Schedule_Form.boardname.value		= document.Schedule_Form.board.options[document.Schedule_Form.board.options.selectedIndex].text;
		window.open("PrintPreviewStandardSchedule.jsp?boardname="+document.Schedule_Form.boardname.value+"&req_sessionname="+document.Schedule_Form.req_sessionname.value+"&req_sessionid="+document.Schedule_Form.req_sessionid.value+"&board="+document.Schedule_Form.board.value+"&req_sessionname="+document.Schedule_Form.req_sessionname.value+"&req_sessionid="+document.Schedule_Form.req_sessionid.value+"&board="+document.Schedule_Form.board.value+"&req_sessionstatus="+document.Schedule_Form.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
		//document.Schedule_Form.action = "PrintPreviewStandardSchedule.jsp";
		//document.Schedule_Form.submit();
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

    <h2><%=bundle.getString("label.reports.reportsstandardschedule")%></h2>
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
		int datacount				= 0;
		String sessionid			= request.getParameter("req_sessionid");
		String boardid				= request.getParameter("req_boardid");
		
		String today				= DateTime.showTime("calendar");
		String archival				= request.getParameter("req_sessionstatus");
		String tempstandardid		= "";
		
		if(sessionid != null && boardid != null) {
			standardList			= schedule.standardDetails(instituteid,sessionid,boardid);
		}
%>

<form name="Schedule_Form" action="" method="post">


		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" colspan="2" width="98%"><%=bundle.getString("label.schedule.academicyearandboard")%></th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
			<tfoot>
			   	<tr>
			       	<td colspan="2" class="rounded-foot-left"><em></em></td>
			       	<td class="rounded-foot-right">&nbsp;</td>
			    </tr>
			</tfoot>		    
		    <tr>
		    	<td colspan='3'>
					<table width='100%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
							
							<%=request.getParameter("req_sessionname") %>
								
							</td>
						</tr>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.board")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='board' validate='Board Name' onchange='loadStandards()'>
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
							<td width='20%' class='tablebold' valign=top><%=bundle.getString("label.schedule.archivaldetails")%></td>
							<td width='1%' class='tablebold' valign=top>:</td>
							<td class='tablelight' width='79%'>
								<h2><%=bundle.getString("label.schedule.archivalmessage1")%></h2>
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
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
					            <th scope="col" class="rounded" 		width="35%"><%=bundle.getString("label.schedule.standardname")%></th>
					            <th scope="col" class="rounded" 		width="11%"><%=bundle.getString("label.schedule.subjects")%></th>
					            <th scope="col" class="rounded" 		width="11%"><%=bundle.getString("label.schedule.sections")%></th>
					            <th scope="col" class="rounded" 		width="17%"><%=bundle.getString("label.schedule.startdate")%></th>
					            <th scope="col" class="rounded-q4" 		width="17%"><%=bundle.getString("label.schedule.enddate")%></th>
					        </tr>
					    </thead>
						<tfoot>
						   	<tr>
						       	<td colspan="5" class="rounded-foot-left"><em></em></td>
						       	<td class="rounded-foot-right">&nbsp;</td>
						    </tr>
						</tfoot>					    
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
											//if(archival != null && archival.equals("R"))
												//out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td>-</td><td>-</td><td><input type='text' validate='Start Date' name='starts' size='11' value='' onfocus='this.blur()'><input type='button' disabled value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+count+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type='text' name='ends' size='11' value='' validate='End Date' onfocus='this.blur()'><input type='button' disabled value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.ends["+count+"]','0',event,'Not_Less_Than_StartDate',Schedule_Form.starts["+count+"])></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' disabled value='"+standardid+"'><input type='hidden' name='groups' value='-'></td><td></td></tr>");
											//else 
												//out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td>-</td><td>-</td><td><input type='text' validate='Start Date' name='starts' size='11' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+count+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type='text' name='ends' size='11' value='' validate='End Date' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.ends["+count+"]','0',event,'Not_Less_Than_StartDate',Schedule_Form.starts["+count+"])></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+standardid+"'><input type='hidden' name='groups' value='-'></td><td></td></tr>");
											//datacount++;
											count++;
										}
										else{
											if(archival != null && archival.equals("R")){
												datacount++;
												//out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td><td>-</td><td>-</td></tr>");
												out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td></tr>");
											}
											else{
												datacount++;
												//out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td><td><a href='#edit"+y+"' name='edit"+y+"' onclick='callEdit(this)' standardscheduleid='"+hashmap.get("standardscheduleid")+"'>Edit</a></td><td><a href='#edit"+y+"' name='edit"+y+"' onclick='callTrash(this)' class='ask' standardscheduleid='"+hashmap.get("standardscheduleid")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='' title='' border='0'/></a></td></tr>");
												out.print("<tr><td>"+tcount+".</td><td>"+hashmap.get("standardname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td></tr>");
											}
										}
									}
									else{
										if(tempstandardid.equals("") || !tempstandardid.equals(standardid)){
											stotal	= 1;
											tcount++;
											//datacount++;
											//out.print("<tr><td valign='top'>"+tcount+".</td><td colspan='7'>"+hashmap.get("standardname")+"</td></tr>");
											out.print("<tr><td valign='top'>"+tcount+".</td><td colspan='5'>"+hashmap.get("standardname")+"</td></tr>");
											tempstandardid	= standardid;
											
										}
										
										if(hashmap.get("startdate") == null){
											//if(archival != null && archival.equals("R"))
												//out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td>-</td><td>-</td><td><input type='text' name='starts' validate='Start Date' size='11' value='' onfocus='this.blur()'><input type='button' disabled value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+count+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type='text' name='ends' validate='End Date' size='11' value='' onfocus='this.blur()'><input type='button' disabled value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.ends["+count+"]','0',event,'Not_Less_Than_StartDate',Schedule_Form.starts["+count+"])></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' disabled onclick='checkCount(this)' value='"+standardid+"'><input type='hidden' name='groups' value='"+hashmap.get("groupid")+"'></td><td></td></tr>");
											//else
												//out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td>-</td><td>-</td><td><input type='text' name='starts' validate='Start Date' size='11' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.starts["+count+"]','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)></td><td><input type='text' name='ends' validate='End Date' size='11' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','Schedule_Form.ends["+count+"]','0',event,'Not_Less_Than_StartDate',Schedule_Form.starts["+count+"])></td><td><input type='checkbox' name='checkstandard' pos='"+count+"' onclick='checkCount(this)' value='"+standardid+"'><input type='hidden' name='groups' value='"+hashmap.get("groupid")+"'></td><td></td></tr>");
											//datacount++;	
											count++;
										}
										else {
											if(archival != null && archival.equals("R")){
												datacount++;
												//out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td><td>-</td><td>-</td></tr>");
												out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td></tr>");
											}
											else{
												datacount++;
												//out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td><td><a href='#edit"+y+"' name='edit"+y+"' onclick='callEdit(this)' standardscheduleid='"+hashmap.get("standardscheduleid")+"'>Edit</a></td><td><a href='#trash"+y+"' name='trash"+y+"' class='ask' onclick='callTrash(this)' standardscheduleid='"+hashmap.get("standardscheduleid")+"'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/trash.png' alt='' title='' border='0'/></a></td></tr>");
												out.print("<tr><td>&nbsp;&nbsp;"+tcount+"."+stotal+"</td><td>"+hashmap.get("groupname")+"</td><td><a href='#subject"+y+"' name='subject"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSubject(this)'>View</a></td><td><a href='#section"+y+"' name='section"+y+"' standardscheduleid='"+hashmap.get("standardscheduleid")+"' onclick='loadSections(this)'>View</a></td><td>"+hashmap.get("startdate")+"</td><td>"+hashmap.get("enddate")+"</td></tr>");
											}
											stotal++;	
										}
										
									}
								}
								if(datacount==0){
									out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
									//out.print("<tr><td colspan='6' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
								}
							}
							else{
								out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
								//out.print("<tr><td colspan='6' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
							}
						
						}catch(Exception e){
							e.printStackTrace();
						}
						%>
					        
					</table>
					
				
				</td>
			</tr>
		</table>
		<!--  <table width='100%' align='center' border='0' >
			<tr>
				<td width='100%' align='right'>
					Last Date For Application&nbsp;:&nbsp;<input type='text' name='lastdate' validate='Last Date for application' size='11' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('<%=request.getContextPath()%>/js/Calendar/CalendarWindow.html','Schedule_Form.lastdate','0',event,'Not_Less_Than_CurrentDate',Schedule_Form.todaydate)>
				</td>
			</tr>
		</table>
		<%
		//if(archival != null && archival.equals("R")){ 
		%>
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
			<a href="#" class="bt_red" onclick='trashedStandard()'><span class="bt_red_lft"></span><strong>Trashed List</strong><span class="bt_red_r"></span></a>
			<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
		<%
		//}else{ 
		%>
			
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
			<a href="#" class="bt_red" onclick='trashedStandard()'><span class="bt_red_lft"></span><strong>Trashed List</strong><span class="bt_red_r"></span></a>
			<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a>
		<%
		//}
		%>-->
			<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
<%-- 			<a href="#" class="bt_red" onclick='trashedStandard()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.trashedlist")%></strong><span class="bt_red_r"></span></a>
 --%>		<% 
		//out.print("datacount-->"+datacount);
		if(datacount>0){
		%>	
			<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
		<%}%>
		<input type='hidden' name='todaydate' 					value='<%=today %>'>
		<input type='hidden' name='starts' 			disabled	value='<%=today %>'>
		<input type='hidden' name='ends' 			disabled	value='<%=today %>'>
		<input type='hidden' name='groups' 			disabled	value='<%=today %>'>
		<input type='hidden' name='checkstandard' 	disabled	value='<%=today %>'>
		<input type='hidden' name='sessionname' 				value=''>
		<input type='hidden' name='boardname' 					value=''>
		<input type='hidden' name='standardscheduleid' 			value=''>
		<input type='hidden' name='archival' 					value='<%=request.getParameter("req_sessionstatus") %>'>
		
		<input type='hidden' name='req_sessionname' 			value='<%=request.getParameter("req_sessionname") %>'>
		<input type='hidden' name='req_sessionid' 			value='<%=request.getParameter("req_sessionid") %>'>
		<input type='hidden' name='req_sessionstatus' 				value='<%=request.getParameter("req_sessionstatus") %>'>
		<input type='hidden' name='req_boardid' 			value=''>
		
		
		
		
		
</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>