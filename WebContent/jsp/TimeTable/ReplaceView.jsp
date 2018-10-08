<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<SCRIPT language="JavaScript" src="../../js/xmlhttpobject.js"></SCRIPT>
<SCRIPT language="JavaScript" src="../../js/clearselects.js"></SCRIPT>

<script language='javascript'>
	
	function editSchedule(){

		if(check_ForParticularElements(document.wprkallotment.staff,"select",document.wprkallotment.subject,"select")){

			document.wprkallotment.action = "submitreplace.jsp";
			document.wprkallotment.submit();
		}
	}
	
	function backSchedule(){
	
		document.wprkallotment.action = "ReplacePeriod.jsp";
		document.wprkallotment.submit();
	}
	
	
	function loadSubjects(status)
	{
		if(status == "subject") {
		
			clearObjects("subject")
			if(check_ForParticularElements(document.wprkallotment.staff,"select")){
				url="ScheduleAjax.jsp?action=loadsujects&staffid="+document.getElementById("staff").value+"&sectionid="+document.wprkallotment.section.value;
			}
			else{
				return false;
			}
		
		}
		
		var req = initRequest();
		req.onreadystatechange = function()
		{
			if(req.readyState == 4)
			{
				if(req.status == 200)
				{
					parseResponse(req.responseXML,status);
				}
			}
		};
		req.open("GET", url, true);
		req.send(null);

	}	
	
	function parseResponse(responseXML,status){
	
			root_obj = responseXML.getElementsByTagName("MainEntity");
			node_len = root_obj[0].childNodes.length;

			if(status == "subject"){
				
				selectobj	= document.getElementById("subject");
				
				for(var i=0;i<node_len;i++){
					
					selectobj.options[selectobj.options.length] = new Option(root_obj[0].childNodes[i].childNodes[1].firstChild.nodeValue,root_obj[0].childNodes[i].childNodes[0].firstChild.nodeValue);
				}
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

    <h2><%=bundle.getString("label.schedule.replacetimetableallocation")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.TimeTable.PeriodTime.Schedule"%>
<%
	Schedule wallot 		= new Schedule();
	HashMap	hashmap			= null;
	String sessionid		= request.getParameter("session");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String sessionname		= request.getParameter("sessionname");
	String sectionname		= request.getParameter("sectionname");
	String standardname		= request.getParameter("standardname");
	String boardname		= request.getParameter("boardname");
	String timetableid		= request.getParameter("timetableid");
	String staffid			= request.getParameter("staffid");
	ArrayList periodList	= null; 
	ArrayList periodName	= wallot.loadPeriodName(timetableid); 
	ArrayList logList		= wallot.loadLogDetails(timetableid); 
	ArrayList staffList		= wallot.loadStaffReplaceDetails(timetableid,sessionid,staffid,sectionid); 
	
	
	String dayname			= "";
	String periodname		= "";
	String periodtime		= "";
	
	
	if(periodName != null && periodName.size()>0){
			hashmap		= (HashMap)periodName.get(0);
			periodname	= (String)hashmap.get("periodname");
			periodtime	= (String)hashmap.get("periodtime");
			dayname		= (String)hashmap.get("dayname");
	}

	
%>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
								
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
	    <thead>
	    	<tr>
	            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
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
							<%=sessionname %>
						</td>
					</tr>
					<tr height='23'>
						<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.board")%></td>
						<td  class='tablebold' width='1'>:</td>
						<td  class='tablelight'>
							<%=boardname %>
						</td>
						
					</tr>
					
					<tr height='23'>
						<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.standardname")%></td>
						<td  class='tablebold' width='1'>:</td>
						<td  class='tablelight' >
							<%=standardname %>
						</td>
					</tr>
					<tr height='23'>
						<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.section")%></td>
						<td  class='tablebold' width='1'>:</td>
						<td  class='tablelight' >
							<%=sectionname %>
						</td>
					</tr>
					<tr height='23'>
						<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.day")%></td>
						<td  class='tablebold' width='1'>:</td>
						<td  class='tablelight' >
							<%=dayname %>
						</td>
					</tr>
					<tr height='23'>
						<td  class='tablebold' width='20%'><%=bundle.getString("label.schedule.period")%></td>
						<td  class='tablebold' width='1'>:</td>
						<td  class='tablelight' >
							<%=periodname %>&nbsp;[&nbsp;<%=periodtime %>&nbsp;]
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
	        	<th scope="col" class="rounded-company" width="7%"><%=bundle.getString("label.schedule.slno")%></th>
	            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.schedule.staffname")%></th>
	            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.schedule.subjectname")%></th>
	            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.schedule.action")%></th>
	            <th scope="col" class="rounded-q4" width="25%"><%=bundle.getString("label.schedule.dateofcreation")%></th>
	            
	        </tr>
	    </thead>
		<%
			if(logList != null && logList.size()>0){
				for(int y=0;y<logList.size();y++) {
					hashmap		= (HashMap)logList.get(y);
					out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("name")+"</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("logdetails")+"</td><td>"+hashmap.get("dateofcreation")+"</td></tr>");
				}
			}
			else{
				out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
				//out.print("<tr><td colspan='5'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
			}
		%>
		</table>
		
		<br>
										
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.assignfreepool")%></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>	
		    <tr>
		    	<td colspan='2'>
					<table  border='0' align="center" width="100%" cellspacing=5 cellpadding=0>
						<tr>
							<td width='15%' class='tablebold'><%=bundle.getString("label.schedule.staffname")%><font color=red>*</font></td>
							<td width='1%' class='tablebold'>:</td>
							<td>
								<select name='staff' id='staff' validate='Staff Name' onchange='loadSubjects("subject")'>
									<option value='0'>-Select Staff-</option>
									<%
										if(staffList != null && staffList.size()>0){
											for(int y=0;y<staffList.size();y++) {
												hashmap		= (HashMap)staffList.get(y);
												out.print("<option value='"+hashmap.get("staffid")+"'>"+hashmap.get("name")+"</option>");
											}
										}
									%>
								</select>
							</td>
						</tr>
						<tr>
							<td  class='tablebold'><%=bundle.getString("label.schedule.subjectname")%><font color=red>*</font></td>
							<td  class='tablebold'>:</td>
							<td>
								<select name='subject' id='subject' validate='Subject Name'>
									<option value='0'>-Select Subject-</option>
								</select>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
							
		
		
		<a href="#" class="bt_blue" 	name='back' 	id='back' onclick='backSchedule()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" 	name='edit' 	id='edit' onclick='editSchedule()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.replacestaff")%></strong><span class="bt_green_r"></span></a>
		
		<input type='hidden' name='standardname' 	value='<%=standardname%>'>
		<input type='hidden' name='sectionname'		value='<%=sectionname%>'>
		<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
		<input type='hidden' name='boardname' 		value='<%=boardname%>'>
		<input type='hidden' name='section' 		value='<%=sectionid%>'>
		<input type='hidden' name='session' 		value='<%=sessionid%>'>
		<input type='hidden' name='standard'		value='<%=standardid%>'>
		<input type='hidden' name='timetableid'		value='<%=timetableid %>'>

	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>