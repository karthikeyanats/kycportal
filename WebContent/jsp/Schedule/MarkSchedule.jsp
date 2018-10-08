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
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>


<script type="text/javascript">
	
	function publishStandard(){
		
		if(check_ForParticularElements(document.Schedule_Form.eligibility,"textarea",document.Schedule_Form.seats,"text",document.Schedule_Form.startdate,"text",document.Schedule_Form.enddate,"text",document.Schedule_Form.lastdate,"text")){
			
			if(!isNaN(document.Schedule_Form.seats.value)){
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
	
	function activate(obj){
		
		document.Schedule_Form.subjectid.value	= obj.getAttribute("subjectid");
		document.Schedule_Form.subjectscheduleid.value	= obj.getAttribute("subjectscid");
		document.Schedule_Form.status.value	= obj.getAttribute("status");
		
		document.Schedule_Form.action = "UpdateSubjects.jsp";
		document.Schedule_Form.submit();
	
	}
	
	function deActivatedList(){
		
		document.Schedule_Form.action = "DeActivatedSubjects.jsp";
		document.Schedule_Form.submit();
	
	}
	
	function callLessons(obj){
		
		document.Schedule_Form.subjectname.value		= obj.getAttribute("subjectname");
		document.Schedule_Form.subjectscheduleid.value	= obj.getAttribute("subjectscid");
		document.Schedule_Form.action = "ViewLessons.jsp";
		document.Schedule_Form.submit();
	
	}	
	
	function markschedule()
	{
		document.Schedule_Form.action = "MarkSchedule.jsp";
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

    <div class="right_content">

    <h2>Schedule / Scheduled Subjects</h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Schedule.Schedule,com.iGrandee.Common.DateTime"%>
<%

		Schedule schedule			= new Schedule();
		ArrayList stndardList		= null;
		HashMap	hashmap				= null;
		String sessionid			= request.getParameter("session");
		String sessionnname			= request.getParameter("sessionname");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		stndardList					= schedule.viewDetails(standardscheduleid);
		ArrayList subjectList		= schedule.viewSubjects(standardscheduleid);
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
						
		<table width='100%' align='center' border='0' cellpadding='5' cellspacing='0'>
			<tr>
				<td width='20%' class='tablebold'>Year of Session</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=sessionnname %>
				</td>
			</tr>
			<tr>
				<td width='20%' class='tablebold'>Standard Name</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=sname %>
				</td>
			</tr>
			<%if(!groupname.equals("")){
			
			%>
			<tr>
				<td width='20%' class='tablebold'>Group Name</td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight'>
					<%=groupname %>
				</td>
			</tr>
			<%} %>
			
			
		</table>
		<br>
		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
					<table id="rounded-corner" border=0 summary="Department List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="15%">SL No.</th>
					            <th scope="col" class="rounded" 		width="40%">Subject Name</th>
					            <th scope="col" class="rounded" 		width="30%">Description</th>
					            <th scope="col" class="rounded-q4" 		width="10%">Allocate/DeAllocate</th>
					        </tr>
					    </thead>
					    <%
					    	if(subjectList != null && subjectList.size()>0){
					    		for(int y=0;y<subjectList.size();y++){
					    			hashmap		= (HashMap)subjectList.get(y);
					    			status		= (String)hashmap.get("status");
					    			
					    			
									if(status.equals("Yes"))
						    			out.print("<tr><td>"+(y+1)+".</td><td><a href='#' subjectscid='"+hashmap.get("subjectscheduleid")+"' subjectname='"+hashmap.get("subjectname")+"' onclick='callLessons(this)'>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("description")+"</td>");
									else
						    			out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("description")+"</td>");
										
									if(status.equals("Yes"))
						    			out.print("<td><a href='#' subjectid='"+hashmap.get("subjectid")+"' subjectscid='"+hashmap.get("subjectscheduleid")+"' status='D' onclick='activate(this)'>DeAllocate</a></td></tr>");
									else
						    			out.print("<td><a href='#' subjectid='"+hashmap.get("subjectid")+"' subjectscid='"+hashmap.get("subjectscheduleid")+"' status='A' onclick='activate(this)'>Allocate</a></td></tr>");

					    		}
					    	}
					    	else{
					    		out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
				    			//out.print("<tr><td colspan='4'>No Data Found</td></tr>");
					    	}

					    %>
					</table>
				</td>
			</tr>
		</table>

		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_blue" onclick='markschedule()'><span class="bt_blue_lft"></span><strong>Mark Schedule</strong><span class="bt_blue_r"></span></a>
		
		
		<input type='hidden' name='sessionname' 				value='<%=sessionnname%>'>
		<input type='hidden' name='session' 					value='<%=sessionid%>'>
		<input type='hidden' name='standardscheduleid' 			value='<%=standardscheduleid%>'>
		<input type='hidden' name='subjectid' 					value=''>
		<input type='hidden' name='subjectscheduleid' 			value=''>
		<input type='hidden' name='subjectname' 				value=''>
		<input type='hidden' name='status' 						value=''>
		
		
		
		
		
		
		
</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>