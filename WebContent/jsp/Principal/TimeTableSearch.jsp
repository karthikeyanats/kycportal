<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Time Table | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="../../js/Validation.js"></SCRIPT>
<script language='javascript'>

	function changeBoard(){
	
		if(check_ForParticularElements(document.wprkallotment.board,"select")){
			document.wprkallotment.standard.options.selectedIndex	= 0;
			document.wprkallotment.section.options.selectedIndex	= 0;
			document.wprkallotment.submit();
		}
	}	

	function changeStandard(){
		
		if(check_ForParticularElements(document.wprkallotment.board,"select",document.wprkallotment.standard,"select")){
			document.wprkallotment.submit();
		}
	}	
	
	
	function changeSection(){
		
		if(check_ForParticularElements(document.wprkallotment.standard,"select",document.wprkallotment.board,"select",document.wprkallotment.section,"select")){
			
			document.wprkallotment.standardname.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].text;
			document.wprkallotment.sectionname.value	= document.wprkallotment.section.options[document.wprkallotment.section.options.selectedIndex].text;
			document.wprkallotment.boardname.value		= document.wprkallotment.board.options[document.wprkallotment.board.options.selectedIndex].text;
			document.wprkallotment.action = "TimeTableView.jsp";
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

		    <h2><%=bundle.getString("label.schedule.stafftimetablestandard")%></h2>
		
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
			String sessionid		= session.getValue("sessionid")+"";
			String sectionid		= request.getParameter("section");
			String boardid			= request.getParameter("board");
			String standardid		= request.getParameter("standard");
			
			ArrayList sectionList	= null;
			
			ArrayList boardList		= wallot.boardDetails(instituteid,sessionid);
			ArrayList standardList	= null;
			
			if(boardid != null && !boardid.equals("") && !boardid.equalsIgnoreCase("null"))
				standardList	= wallot.loadScheduledStandards(sessionid,instituteid,boardid);	
			
			if(standardid != null && !standardid.equals("") && !standardid.equalsIgnoreCase("null")){
				sectionList		= wallot.loadScheduledSections(standardid);
			}
		%>
			<form name='wprkallotment' method='post'>
		
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%" colspan='2'><%=bundle.getString("label.schedule.selectscheduledetails")%></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
									<tfoot>
										<tr>
											<td colspan=2 class="rounded-foot-left"><em></em></td>
											<td class="rounded-foot-right">&nbsp;</td>
										</tr>
									</tfoot>								    
								    <tr>
								    	<td colspan='3'>							

											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=session.getValue("sessionname")%>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.board")%></td>
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
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='standard' validate='Standard Name' onchange='changeStandard()'>
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
													<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.section")%></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='section' validate='Section Name' >
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
		
							     <a href="#" class="bt_blue" onclick='changeSection()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.loadtimetable")%></strong><span class="bt_blue_r"></span></a>
		
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