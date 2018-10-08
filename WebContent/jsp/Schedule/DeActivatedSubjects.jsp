<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
	
	function goBack(){
		
		document.Schedule_Form.action = "ViewSubjects.jsp";
		document.Schedule_Form.submit();
	}
	
	function activate(obj){
		
		document.Schedule_Form.subjectid.value			= obj.getAttribute("subjectid");
		document.Schedule_Form.subjectscheduleid.value	= obj.getAttribute("subjectscid");
		document.Schedule_Form.status.value				= obj.getAttribute("status");
		document.Schedule_Form.action 					= "Deactivesubmit.jsp";
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
	<%    
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>    

    <h2><%=bundle.getString("label.schedule.trashedsubjects")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Schedule.Schedule,com.iGrandee.Common.DateTime"%>
<%

		Schedule schedule			= new Schedule();
		ArrayList stndardList		= null;
		HashMap	hashmap				= null;
		String boardid				= request.getParameter("board");
		String sessionid			= request.getParameter("session");
		String sessionnname			= request.getParameter("sessionname");
		String boardname			= request.getParameter("boardname");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		stndardList					= schedule.viewDetails(standardscheduleid);
		ArrayList subjectList		= schedule.viewDeActiveSubjects(standardscheduleid);
		String sname				= "";
		String groupname			= "";
		String status				= "";
		String archival				= request.getParameter("archival");
		
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
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.standardname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<%=sname %>
							</td>
						</tr>
						<%if(groupname != null && !groupname.equals("")){
						%>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.groupname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<%=groupname %>
							</td>
						</tr>
						<%} %>
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
					        	<th scope="col" class="rounded-company" width="10%">SL No.</th>
					            <th scope="col" class="rounded" 		width="50%">Subject Name</th>
					            <th scope="col" class="rounded" 		width="20%">Subject Code</th>
					            <th scope="col" class="rounded" 		width="10%">Delete</th>
					            <th scope="col" class="rounded-q4" 		width="10%">Restore</th>
					        </tr>
					    </thead>
					    <%
					    	if(subjectList != null && subjectList.size()>0){
					    		for(int y=0;y<subjectList.size();y++){
					    			hashmap		= (HashMap)subjectList.get(y);
					    			status		= (String)hashmap.get("status");
					    			if(archival != null && archival.equals("R"))
					    				out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("subjectcode")+"</td><td>-</td><td>-</td></tr>");
					    			else
					    				out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("subjectcode")+"</td><td><a href='#' subjectid='"+hashmap.get("subjectid")+"' subjectscid='"+hashmap.get("subjectscheduleid")+"' status='X' onclick='activate(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/user_logout.png' alt='Delete' title='Delete' border='0' /></a></td><td><a href='#' subjectid='"+hashmap.get("subjectid")+"' subjectscid='"+hashmap.get("subjectscheduleid")+"' status='A' onclick='activate(this)'><img src='"+request.getContextPath()+"/jsp/kycpanel/images/16-undo1.png' alt='Restore' title='Restore' border='0' /></a></td></tr>");
					    		}
					    		
					    	}
					    	else{
								out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
				    			//out.print("<tr><td colspan='5' align='center'>Data Not Found</td></tr>");
					    	}

					    %>
					</table>
				</td>
			</tr>
		</table>

		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		
		
		<input type='hidden' name='sessionname' 		value='<%=sessionnname%>'>
		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='board' 				value='<%=boardid%>'>
		<input type='hidden' name='boardname' 			value='<%=boardname%>'>
		<input type='hidden' name='standardscheduleid' 	value='<%=standardscheduleid%>'>
		<input type='hidden' name='subjectid' 			value=''>
		<input type='hidden' name='subjectscheduleid' 	value=''>
		<input type='hidden' name='status' 				value=''>
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