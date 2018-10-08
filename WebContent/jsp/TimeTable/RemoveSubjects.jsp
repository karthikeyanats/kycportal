<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>


	function changeBoard(){

		if(check_ForParticularElements(document.workallotment.board,"select")){
			document.workallotment.standard.options.selectedIndex	= 0;
			document.workallotment.section.options.selectedIndex	= 0;
			document.workallotment.submit();
		}
	}	
	function goBack(){
	
		document.workallotment.action	= "SubjectAllotment.jsp";
		document.workallotment.submit();
	
	}

	function loadStaffs()
	{
		if(check_ForParticularElements(document.workallotment.standard,"select",document.workallotment.section,"select")){
			document.workallotment.submit();
		}
	}
	
	function changeSession(){
	
		if(check_ForParticularElements(document.workallotment.standard,"select")){
			document.workallotment.submit();
		}
	}
	
	function deleteWorks(){
	
		if(count >0){
		
			document.workallotment.status.value = "delete";
			document.workallotment.action = "RemoveSubmit.jsp";
			document.workallotment.submit();
		}
		else{
			alert("Please select atleast one staff to set working hour");
		}
	}
	
	
	function submitWorks()
	{
		var status = false;
		if(document.workallotment.schedule.length!=undefined)
			{
				for(var i=0;i<document.workallotment.schedule.length;i++)
				{
					if(document.workallotment.schedule[i].checked)
					{
						if(!check_ForParticularElements(document.workallotment.hours[i],"text"))
						{
							document.workallotment.schedule[i].checked=false;
							return false;
						}
					}
				}

			}
		else
			{
				if(document.workallotment.schedule.checked)
				{
					if(!check_ForParticularElements(document.workallotment.hours,"text"))
					{
						document.workallotment.schedule.checked=false;
						return false;
					}
				}
			}
		if(document.workallotment.schedule.length!=undefined)
		{
			for(var i=0;i<document.workallotment.schedule.length;i++)
			{
				if(document.workallotment.schedule[i].checked)
				{
					
					status = true;
				}
			}

		}
	else
		{
			if(document.workallotment.schedule.checked)
			{
				status = true;

			}
		}
		if(status){
			
			for(var i=0;i<document.workallotment.schedule.length;i++){
				if(document.workallotment.schedule[i].checked){
					if(isNaN(document.workallotment.hours[i].value)){
						alert("Hours should only be a number.")
						document.workallotment.hours[i].value = "0";
						document.workallotment.hours[i].focus();
						status = false;
						break;
					}
				}
				}
			}
					
			if(status){
			
				for(var i=0;i<document.workallotment.schedule.length;i++){
					if(!document.workallotment.schedule[i].checked){
						document.workallotment.hours[i].disabled = true;
					}
				}
			
				document.workallotment.status.value = "update";
				document.workallotment.action = "RemoveSubmit.jsp";
				document.workallotment.submit();
			}
		else{
			alert("Please select atleast one subject to update.");
		}
	}		
	
	var count = 0;
		
	function countChecked(obj)
	{
		if(obj.checked)
			count++;
		else
			count--;
	}
	
	
	function checkTotal(obj){
	
		var i 		= obj.getAttribute("pos");
		var diff	= 0;
		
		if(isNaN(document.workallotment.hours[i].value)){
			
			alert("Hours should only be a number.")
			document.workallotment.hours[i].value = document.workallotment.hours[i].getAttribute("oldvalue");
			document.workallotment.hours[i].focus();
			return false;
		}
		
		if(parseInt(document.workallotment.hours[i].getAttribute("scheduledhours"),10) > parseInt(document.workallotment.hours[i].value,10)){
			alert("Staff already scheduled for "+document.workallotment.hours[i].getAttribute("scheduledhours")+" hours, So please remove the staff from schedule and update.");
			document.workallotment.hours[i].value = document.workallotment.hours[i].getAttribute("scheduledhours");
			document.workallotment.hours[i].focus();
			return false;		
		}
		
		for(var x=0;x<document.workallotment.schedule.length;x++){
			if(!document.workallotment.schedule[x].disabled){

				diff	+= parseInt(document.workallotment.hours[x].value,10)-parseInt(document.workallotment.hours[x].getAttribute("oldvalue"),10)
			}
		}
		

		if(diff>parseInt(parseInt(document.workallotment.remaining.value,10))){
			
			alert("Allotted hours must be less than or equal to the Total hours.\n Please check the remaining hours and hours you are trying to allot.");
			document.workallotment.hours[i].value = document.workallotment.hours[i].getAttribute("oldvalue");
			document.workallotment.hours[i].focus();
			return false;
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
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.removesubjects")%></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.WorkAllotment"%>
	
<%
	WorkAllotment wallot 	= new WorkAllotment();
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String standardid		= request.getParameter("standard");
	String sectionid		= request.getParameter("section");
	String remaining		= request.getParameter("remaining");
	String allotted			= request.getParameter("allotted");
	String noofhours		= request.getParameter("noofhours");
	String staffid			= request.getParameter("staffid");
	String staffname		= request.getParameter("staffname");
	String sessionname		= request.getParameter("sessionname");
	String deptid			= request.getParameter("department");
	String roleid			= request.getParameter("role");
	String boardid			= request.getParameter("board");
	String instituteid		= (String)session.getValue("instituteid");
	String scheduledhours	= "";
	
	ArrayList boardList		= wallot.boardDetails(instituteid,sessionid);
	ArrayList standardList	= null;
	
	if(boardid != null && !boardid.equals("") && !boardid.equalsIgnoreCase("null"))
		standardList	= wallot.loadScheduledStandards(sessionid,instituteid,boardid);
	
	ArrayList sectionList	= null;
	ArrayList subjectList	= null;
	
	
	if(sectionid != null && !sectionid.equals("") && !sectionid.equalsIgnoreCase("null")){
		subjectList			= wallot.loadScheduledSubjects(staffid,sectionid); 
	}
	
	if(standardid != null && !standardid.equals("") && !standardid.equalsIgnoreCase("null")){
		sectionList		= wallot.loadScheduledSections(standardid);
	}


%>
	<form name='workallotment' method='post'>

								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.staffallotmentdetails")%></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>
								    	<td colspan='2'>							
											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=sessionname%>
													</td>
												</tr>		
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.staffname")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=staffname%>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.workhours")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=noofhours%>
													</td>
												</tr>	
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.allottedhours")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=allotted%>
													</td>
												</tr>									
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.pendinghours")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=remaining%>
													</td>
												</tr>									
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.board")%><font color=red>*</font></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='board' validate='Board Name' onchange='changeBoard()'>
														<option value='0'>-Select Board Name-</option>
														<%
															if(boardList != null && boardList.size()>0){
																for(int y=0;y<boardList.size();y++){
																	hashmap		= (HashMap)boardList.get(y);
																	if(boardid != null && boardid.equals(""+hashmap.get("boardid")))
																		out.print("<option selected value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"</option>");
																	else
																		out.print("<option value='"+hashmap.get("boardid")+"'>"+hashmap.get("boardname")+"</option>");
																}
															}
														%>
														</select>
													</td>
												</tr>								
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%><font color=red>*</font></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='standard' validate='Standard Name' onchange='changeSession()'>
														<option value='0'>-Select Standard Name-</option>
														<%
															if(standardList != null && standardList.size()>0){
																for(int y=0;y<standardList.size();y++){
																	hashmap		= (HashMap)standardList.get(y);
																	if(standardid != null && standardid.equals(""+hashmap.get("standardscheduleid")))
																		out.print("<option selected value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+"</option>");
																	else
																		out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+"</option>");
																}
															}
														%>
														</select>
													</td>
													
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.section")%><font color=red>*</font></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='section' validate='Section Name' onchange='loadStaffs()'>
														<option value='0'>-Select Section Name-</option>
														<%
															if(sectionList != null && sectionList.size()>0){
																for(int y=0;y<sectionList.size();y++){
																	hashmap		= (HashMap)sectionList.get(y);
																	if(sectionid != null && sectionid.equals(hashmap.get("sectionscheduleid")+""))
																		out.print("<option selected value='"+hashmap.get("sectionscheduleid")+"'>"+hashmap.get("sectionname")+"</option>");
																	else
																		out.print("<option value='"+hashmap.get("sectionscheduleid")+"'>"+hashmap.get("sectionname")+"</option>");
																}
															}
														%>											
														</select>
													</td>
												</tr>
											</table>
										</td>
									</tr>
								</table>
								<br>							
							<table id="rounded-corner" border=0 summary="Department List" width="100%">
							    <thead>
							    	<tr>
							        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
							            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.schedule.subjectname")%></th>
							            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.schedule.mode")%></th>
							            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.schedule.scheduledhours")%></th>
							            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.schedule.hours")%></th>
							            <th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.schedule.check")%></th>
							            
							        </tr>
							    </thead>

									<%
										if(subjectList != null && subjectList.size()>0){
											for(int y=0;y<subjectList.size();y++){

												hashmap			= (HashMap)subjectList.get(y);
												scheduledhours	= (String)hashmap.get("scheduledhours");
												if(scheduledhours == null || scheduledhours.equals("") || scheduledhours.equalsIgnoreCase("null"))
													scheduledhours	= "0";
												out.print("<tr><td class='tablelight'>"+(y+1)+"</td><td class='tablelight'>"+hashmap.get("subjectname")+"</td><td class='tablelight'>"+hashmap.get("subjectypename")+"</td><td class='tablelight'>"+scheduledhours+"</td><td class='tablelight'><input type='text' name='hours' size='4' pos='"+y+"' scheduledhours='"+scheduledhours+"' oldvalue='"+hashmap.get("allottedhours")+"' value='"+hashmap.get("allottedhours")+"' onblur='checkTotal(this)'></td><td class='tablelight'><input type='checkbox' name='schedule' value='"+hashmap.get("subjectallotmentid")+"' scheduledhours='"+scheduledhours+"' onclick='countChecked(this)'></td></tr>");
											}
										}
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
											//out.print("<tr ><td class='tablelight' colspan='5' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
										}

									%>
								</table>

					     <a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
					
					<%										
						if(subjectList != null && subjectList.size()>0){
					%>

				     	 <a href="#" class="bt_red" 	onclick='deleteWorks()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.delete")%></strong><span class="bt_red_r"></span></a>
	     				 <a href="#" class="bt_green" 	onclick='submitWorks()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.update")%></strong><span class="bt_green_r"></span></a>
					     
					<%
						}
					%>
					
				
		<input type='hidden' name='session' 	value='<%=sessionid%>'>
		<input type='hidden' name='remaining' 	value='<%=remaining%>'>
		<input type='hidden' name='allotted' 	value='<%=allotted%>'>
		<input type='hidden' name='noofhours' 	value='<%=noofhours%>'>
		<input type='hidden' name='staffid' 	value='<%=staffid%>'>
		<input type='hidden' name='staffname' 	value='<%=staffname%>'>
		<input type='hidden' name='sessionname' value='<%=sessionname%>'>
		<input type='hidden' name='status' 		value=''>
		<input type='hidden' name='department' 	value='<%=deptid%>'>
		<input type='hidden' name='role' 		value='<%=roleid%>'>
		
		<input type='hidden' name='schedule' disabled>
		<input type='hidden' name='hours' 	 disabled>
		
		
		
		
	</form>

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>