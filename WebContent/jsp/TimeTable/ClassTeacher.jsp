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


	function loadStaffs()
	{
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.board,"select",document.wprkallotment.standard,"select",document.wprkallotment.section,"select")){
			
			document.wprkallotment.submit();
		}
	}
	
	
	function loadSession()
	{
		if(check_ForParticularElements(document.wprkallotment.session,"select")){
			document.wprkallotment.section.options.selectedIndex	= 0;
			document.wprkallotment.submit();
		}
	}	
	
	function loadStandard()
	{
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.board,"select",document.wprkallotment.standard,"select")){
			document.wprkallotment.section.options.selectedIndex	= 0;
			document.wprkallotment.submit();
		}
	}	
	
	function viewClassTeacher(){
		
		if(check_ForParticularElements(document.wprkallotment.session,"select",document.wprkallotment.board,"select",document.wprkallotment.standard,"select",document.wprkallotment.section,"select")){
			
			
			document.wprkallotment.sessionname.value	= document.wprkallotment.session.options[document.wprkallotment.session.options.selectedIndex].text;
			document.wprkallotment.standardname.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].text;
			document.wprkallotment.sectionname.value	= document.wprkallotment.section.options[document.wprkallotment.section.options.selectedIndex].text;
			document.wprkallotment.boardname.value		= document.wprkallotment.board.options[document.wprkallotment.board.options.selectedIndex].text;
			document.wprkallotment.action	= "ViewClassTeacher.jsp";
			document.wprkallotment.submit();
		}
	
	}
	
	var count	= 0;
	
	function addCount(obj)
	{
		if(obj.checked){
			count++;
		}
		else{
			if(count>0)
				count--
		}
	}	
	
	var count1		= 0;
	var chk=false;
	function submitWorks(){
	 	count1		= 0;
	 	
	 	if(document.wprkallotment.staffid.length==undefined)
	 		{
	 		alert("select any one options");
	 		return false;
	 		}
	 	
	 	 if(count== 0)
	 		{
	 		alert("select Any one option");
	 		return false;
	 		}

	 	for(var i=0;i<document.wprkallotment.staffid.length;i++){
			
			if(document.wprkallotment.staffid[i].checked){
				count1++;
			}
				
		}
	 
		 	
		if(count1 > 1){
			count1 = 0;
			alert("Please select only one Staff to allot.");
			return false;
		
		}
		
		document.wprkallotment.action = "ClassTeacherSubmit.jsp";
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

	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>


    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.setclassteacher")%></h2>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.WorkAllotment"%>
	
<%
	WorkAllotment wallot 	= new WorkAllotment();
	String instituteid		= (String)session.getValue("instituteid");
	ArrayList academicList	= wallot.loadAcadamicYear(instituteid);
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String standardid		= request.getParameter("standard");
	String sectionid		= request.getParameter("section");
	ArrayList staffList		= null;
	ArrayList standardList	= null;
	ArrayList sectionList	= null;
	String boardid			= request.getParameter("board");
	boolean schedulestatus = false;
	ArrayList boardList		= wallot.boardDetails(instituteid,sessionid);
	
	if(boardid != null && !boardid.equals("") && !boardid.equalsIgnoreCase("null") && !boardid.equals("0") && sessionid != null && !sessionid.equals("0") && !sessionid.equals("") && !sessionid.equalsIgnoreCase("null"))
		standardList	= wallot.loadScheduledStandards(sessionid,instituteid,boardid);
	
	if(standardid != null && !standardid.equals("0") && !standardid.equals("") && !standardid.equalsIgnoreCase("null")){
		sectionList		= wallot.loadScheduledSections(standardid);
	}
	
	if(sectionid != null && !sectionid.equals("0") && !sectionid.equals("") && !sectionid.equalsIgnoreCase("null")){
		staffList			= wallot.loadClassTeacherSections(sectionid);
		schedulestatus			= wallot.loadscheduledstatus(sectionid);
	}	
	
	
%>
	<form name='wprkallotment' method='post'>

	<table id="rounded-corner" border=0 summary="Department List" width="100%">
	    <thead>
	    	<tr>
	            <th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.schedule.classteacherdetails")%></th>
	            <th scope="col" class="rounded-q4" width="20%"><font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>
	        </tr>
	    </thead>
	    <tr>
	    	<td colspan='2'>
				<table  border=0  width="100%">
	    	<tr>
				<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.academicyear")%><font color=red>*</font></td>
				<td  class='tablebold' width='1'>:</td>
				<td  class='tablelight' >
					<select name='session' validate='Academic Year' onchange='loadSession()'>
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
				<td  class='tablebold' width='20%' ><%=bundle.getString("label.schedule.standardname")%><font color=red>*</font></td>
				<td  class='tablebold' width='1'>:</td>
				<td  class='tablelight' >
					<select name='standard' validate='Standard Name' onchange='loadStandard()'>
					<option value='0'>-Select Standard-</option>
					<%
						if(standardList != null && standardList.size()>0){
							for(int y=0;y<standardList.size();y++){
								hashmap		= (HashMap)standardList.get(y);
								if(standardid != null && standardid.equals(hashmap.get("standardscheduleid")+""))
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
	
	<br>
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
		            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.schedule.staffname")%></th>
		            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.schedule.subjectname")%></th>
		            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.schedule.check")%></th>
		        </tr>
		    </thead>
	        <%
	        		String status	= "";
					if(staffList != null && staffList.size()>0){
						for(int y=0;y<staffList.size();y++){
							hashmap		= (HashMap)staffList.get(y);
							status		= (String)hashmap.get("status");
							if(status != null && status.equals("Scheduled"))
								out.print("<tr><td>"+(y+1)+"</td><td>"+hashmap.get("staffname")+"</td><td>"+hashmap.get("subjectname")+"</td><td>Allocated</td></tr>");
							else
								out.print("<tr><td>"+(y+1)+"</td><td>"+hashmap.get("staffname")+"</td><td>"+hashmap.get("subjectname")+"</td><td><input type='checkbox' name='staffid' value='"+hashmap.get("staffid")+"' onclick='addCount(this)'></td></tr>");
							
								/* out.print("<tr><td>"+(y+1)+"</td><td>"+hashmap.get("staffname")+"</td><td>"+hashmap.get("subjectname")+" - "+hashmap.get("subjectcode")+"</td><td><input type='checkbox' name='staffid' value='"+hashmap.get("staffid")+"' checked onclick='addCount(this)'></td></tr>");
							else
								out.print("<tr><td>"+(y+1)+"</td><td>"+hashmap.get("staffname")+"</td><td>"+hashmap.get("subjectname")+" - "+hashmap.get("subjectcode")+"</td><td><input type='checkbox' name='staffid' value='"+hashmap.get("staffid")+"' onclick='addCount(this)'></td></tr>"); */
							
							
						}
					}
					else{
						out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
						//out.print("<tr><td colspan='4' align=center>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
					}
	        %>
		</table>
 <% if(!schedulestatus){%> 
		<a href="#" id="savebut"  class="bt_green" onclick='submitWorks()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.setasclassteacher")%></strong><span class="bt_green_r"></span></a>
 		<%} %>
		<a href="#" class="bt_blue" onclick='viewClassTeacher()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.view")%></strong><span class="bt_blue_r"></span></a>
		
		<input type='hidden' name='staffid' 		disabled>
		<input type='hidden' name='sessionname' 	value=''>
		<input type='hidden' name='standardname' 	value=''>
		<input type='hidden' name='sectionname'		value=''>
		<input type='hidden' name='boardname'		value=''>
		
		
	</form>

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>