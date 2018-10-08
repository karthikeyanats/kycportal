<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">
	
	function publishStandard(){

		document.Schedule_Form.action = "StandardTrashSubmit.jsp";
		document.Schedule_Form.submit();
	}
	
	function goBack(){
		
		document.Schedule_Form.action = "StandardSchedule.jsp";
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
	<%    
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>    

    <div class="right_content">

    <h2><%=bundle.getString("label.schedule.trashedstandardpreview")%></h2>
<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java" import="com.iGrandee.Schedule.Schedule"%>
<%

		Schedule schedule			= new Schedule();
		ArrayList stndardList		= null;
		ArrayList sectionList		= null;
		HashMap	hashmap				= null;
		String sessionid			= request.getParameter("session");
		String sessionnname			= request.getParameter("sessionname");
		String standardscheduleid	= request.getParameter("standardscheduleid");
		String boardname			= request.getParameter("boardname");
		String boardid				= request.getParameter("board");
		String standardname			= request.getParameter("standardname");
		stndardList					= schedule.viewSubjectsScheduled(standardscheduleid);
		sectionList					= schedule.viewSectionsScheduled(standardscheduleid);
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
								<%=standardname %>
							</td>
						</tr>			
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
					            <th scope="col" class="rounded" 		width="50%"><%=bundle.getString("label.schedule.subjectname")%></th>
					            <th scope="col" class="rounded-q4" 		width="40%"><%=bundle.getString("label.schedule.subjectcode")%></th>
					        </tr>
					    </thead>
						<%
						
							try{
	
								if(stndardList != null && stndardList.size()>0){
									for(int y=0;y<stndardList.size();y++){
										hashmap			= (HashMap)stndardList.get(y);
										out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("subjectcode")+"</td></tr>");
									}
								}
								else{
									out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
									//out.print("<tr><td colspan='3' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
								}
							}
							catch(Exception e){
								
							}
						%>
								        
					</table>
				</td>
			</tr>
			<tr>
				<td width='20%' class='tablebold'>
				<br>
					<table id="rounded-corner" border=0 summary="Department List" width="80%">
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.schedule.slno")%></th>
					            <th scope="col" class="rounded" 		width="50%"><%=bundle.getString("label.schedule.section")%></th>
					            <th scope="col" class="rounded-q4" 		width="40%"><%=bundle.getString("label.schedule.desc")%></th>
					        </tr>
					    </thead>
						<%
						
							try{
	
								if(sectionList != null && sectionList.size()>0){
									for(int y=0;y<sectionList.size();y++){
										hashmap			= (HashMap)sectionList.get(y);
										out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("sectionname")+"</td><td>"+hashmap.get("description")+"</td></tr>");
									}
								}
								else{
									out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
									//out.print("<tr><td colspan='3' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
								}
							}
							catch(Exception e){
								
							}
						%>
								        
					</table>
				</td>
			</tr>
			<%
				if((stndardList != null && stndardList.size()>0) || (sectionList != null && sectionList.size()>0)){
					//out.print("<tr><td><h4>You Cannot Trash a Standard if it has active section and subject scheduled.</h4></td></tr>");
					 out.println("<tr><td><br><div class='warning_box'>");
					 out.println("<a align=left class='tablebold'>You Cannot Trash a Standard if it has active section and subject scheduled.</a>");
					 out.println(" </div></td></tr>");					
				}
			
			%>
		</table>
			<%
				if((stndardList == null || stndardList.size()==0) && (sectionList == null || sectionList.size()==0)){
				%>
			     	<a href="#" class="bt_red" onclick='publishStandard()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.delete")%></strong><span class="bt_red_r"></span></a>
				<%
				}
			%>
		
		<a href="#back" 	name='back' 	class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		
		<input type='hidden' name='sessionname' 				value='<%=sessionnname%>'>
		<input type='hidden' name='session' 					value='<%=sessionid%>'>
		<input type='hidden' name='boardname' 					value='<%=boardname%>'>
		<input type='hidden' name='board' 						value='<%=boardid%>'>
		<input type='hidden' name='standardscheduleid' 			value='<%=standardscheduleid%>'>
		
		
		
		
</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>