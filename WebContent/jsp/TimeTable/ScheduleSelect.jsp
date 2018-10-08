<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<script language='javascript'>


	function changeBoard(){
	
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.board,"select")){
			document.wprkallotment.standard.options.selectedIndex	= 0;
			document.wprkallotment.section.options.selectedIndex	= 0;
			document.wprkallotment.submit();
		}
	}	


	function changeSession(){
		
		if(check_ForParticularElements(document.wprkallotment.session,"select")){
			document.wprkallotment.submit();
		}
	}
	
	function changeStandard(){
		
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.board,"select",document.wprkallotment.standard,"select")){
			document.wprkallotment.submit();
		}
	}	
	
	
	function changeSection(){
		
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.board,"select",document.wprkallotment.standard,"select",document.wprkallotment.section,"select")){
			
			document.wprkallotment.sessionname.value	= document.wprkallotment.session.options[document.wprkallotment.session.options.selectedIndex].text;
			document.wprkallotment.standardname.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].text;
			document.wprkallotment.sectionname.value	= document.wprkallotment.section.options[document.wprkallotment.section.options.selectedIndex].text;
			document.wprkallotment.boardname.value		= document.wprkallotment.board.options[document.wprkallotment.board.options.selectedIndex].text;
			
			document.wprkallotment.action = "Schedule.jsp";
			document.wprkallotment.submit();
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
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>
    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.timetable")%></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.WorkAllotment"%>
	
<%
	WorkAllotment wallot 	= new WorkAllotment();
	String instituteid 		= (String)session.getValue("instituteid");
	ArrayList academicList	= wallot.loadAcadamicYear(instituteid);
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String boardid			= request.getParameter("board");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	ArrayList standardList	= null;
	ArrayList sectionList	= null;
	ArrayList boardList		= null;
	
	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null")){
		boardList		= wallot.boardDetails(instituteid,sessionid);
	}

	if(sessionid != null && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null") && boardid != null && !boardid.equals("") && !boardid.equalsIgnoreCase("null")){
		standardList	= wallot.loadScheduledStandards(sessionid,instituteid,boardid); 
	}
	
	if(standardid != null && !standardid.equals("") && !standardid.equalsIgnoreCase("null")){
		sectionList		= wallot.loadScheduledSections(standardid);
	}
%>
	<form name='wprkallotment' method='post'>

								<table id="rounded-corner" border=0 width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.schedule.selectscheduledetails")%></th>
								            <th scope="col" class="rounded-q4" width="20%"><font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>
								        </tr>
								    </thead>
								    <tr>
								    	<td colspan='2'>							
							
											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%><font color=red>*</font></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='session' validate='Academic Year' onchange='changeSession()'>
														<option value='0'>-Select Academic Year-</option>
														<%
															if(academicList != null && academicList.size()>0){
																for(int y=0;y<academicList.size();y++){
																	hashmap		= (HashMap)academicList.get(y);
																	
																	if(sessionid != null && sessionid.equals(""+hashmap.get("sessionid")))
																		out.print("<option selected value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
																	else
																		out.print("<option value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");
			
																}
															}
														%>
														</select>
													</td>
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%' ><%=bundle.getString("label.schedule.board")%><font color=red>*</font></td>
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
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%><font color=red>*</font></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='standard' validate='Standard' onchange='changeStandard()'>
														<option value='0'>-Select Standard-</option>
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
														<select name='section' validate='Section' >
															<option value='0'>-Select Section-</option>
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
						
	     				 		<a href="#" class="bt_green" 	onclick='changeSection()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.schedule")%></strong><span class="bt_green_r"></span></a>
								
		
		<input type='hidden' name='standardname' 	value=''>
		<input type='hidden' name='sectionname'		value=''>
		<input type='hidden' name='sessionname' 	value=''>
		<input type='hidden' name='boardname' 		value=''>
		
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>