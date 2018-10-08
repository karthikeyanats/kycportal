<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script type="text/javascript">
	
	function goBack(){
		
		document.Schedule_Form.action = "MarkScheduleCheck.jsp";
		document.Schedule_Form.submit();
	}
	
	
	function goToMark( ){
		
		document.Schedule_Form.action = "UpdateMarkSchedule.jsp";
		document.Schedule_Form.submit();
	
	}
	
	function changeSession(){
	
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

    <h2><%=bundle.getString("label.schedule.importmarkschedulesession")%></h2>
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
		ArrayList subjectList		= schedule.viewSubjectsMarks(standardscheduleid);
		
		String sname				= "";
		String groupname			= "";
		String status				= "";
		String standardid			= "";
		String boardid				= request.getParameter("board");	
		String boardname			= request.getParameter("boardname");		
		String archival				= request.getParameter("archival");
		String academicyear			= request.getParameter("academicyear");
		
		if(stndardList != null && stndardList.size()>0){
			hashmap			= (HashMap)stndardList.get(0);
			sname			= (String)hashmap.get("standardname");
			standardid		= (String)hashmap.get("standardid");
			if(hashmap.get("groupstatus") != null && ((String)hashmap.get("groupstatus")).equals("Yes"))
				groupname	= (String)hashmap.get("groupname");
		}
		ArrayList sessionList		= schedule.viewSessionMarks(standardid,sessionid);
		
		if(academicyear == null || academicyear.equals("") || academicyear.equalsIgnoreCase("null") || academicyear.equals("0"))
			subjectList		= schedule.viewSubjectsMarks(standardscheduleid);
		else
			subjectList		= schedule.viewSubjectsMarksPrevious(standardscheduleid,standardid,academicyear);
	
%>

<form name="Schedule_Form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.schedule.selectedinfo")%></th>
		            <th scope="col" class="rounded-q4" 		width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
					<table width='100%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='22%' class='tablebold'><%=bundle.getString("label.schedule.academicyear")%></td>
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
						<%if(!groupname.equals("")){
						
						%>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.groupname")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<%=groupname %>
							</td>
						</tr>
						<%} %>
						<tr>
							<td width='20%' class='tablebold'><%=bundle.getString("label.schedule.previousyear")%></td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight'>
								<select name='academicyear' validate='Academic Year' onchange='changeSession()'>
									<option value='0'>-Select Academic Year-</option>
									<%
										if(sessionList != null && sessionList.size()>0)
										for (int y=0;y<sessionList.size();y++){
											hashmap			= (HashMap)sessionList.get(y);
											if(academicyear != null && academicyear.equals(""+hashmap.get("sessionid")))
												out.print("<option value='"+hashmap.get("sessionid")+"' selected>"+hashmap.get("sessionname")+"</option>");
											else
												out.print("<option value='"+hashmap.get("sessionid")+"'>"+hashmap.get("sessionname")+"</option>");

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
		<table width='90%' align='center' border='0' >
			<tr>
				<td width='20%' class='tablebold'>
					    <%
					    	if(subjectList != null && subjectList.size()>0){
					    		for(int y=0;y<subjectList.size();y++){
					    			hashmap		= (HashMap)subjectList.get(y);
					    			
					    			%>
					    				<br>
										<table id="rounded-corner" border=0 summary="Department List" width="80%">
										    <thead>
										    	<tr>
										            <th scope="col" class="rounded-company" width="99%"><%=hashmap.get("subjectname")+" - "+ hashmap.get("subjectcode")%><input type='hidden' name='subjectscheduleid' value='<%=hashmap.get("subjectscheduleid") %>'></th>
									            	<th scope="col" class="rounded-q4" 		width="1%"></th>
										        </tr>
										    </thead>
										    <tr>
										    	<td colspan='2'>
													<table border='0' summary="Department List" width="100%" cellpadding='0' cellspacing='0'>
														<!-- <tr>
															<td colspan='2'><%=bundle.getString("label.schedule.credithours")%></td>
															<td colspan='13'><input type='text' name='credithours' value='<%=hashmap.get("credithours")%>' maxlength='3' size='4'></td>
														</tr> -->
														<tr>
															<td rowspan='3' width='11%' class='tablebold'><%=bundle.getString("label.schedule.theory")%></td>
															<td colspan='2' width='11%' align='center' class='tablebold'><%=bundle.getString("label.schedule.internal")%></td>
															<td colspan='2' width='11%' align='center' class='tablebold'><%=bundle.getString("label.schedule.external")%></td>
															<td rowspan='3' width='12%' class='tablebold'><%=bundle.getString("label.schedule.practical")%></td>
															<td colspan='2' width='11%' align='center' class='tablebold'><%=bundle.getString("label.schedule.internal")%></td>
															<td colspan='2' width='11%' align='center' class='tablebold'><%=bundle.getString("label.schedule.external")%></td>
															<td rowspan='3' width='11%' class='tablebold'><%=bundle.getString("label.schedule.project")%></td>
															<td colspan='2' width='11%' align='center' class='tablebold'><%=bundle.getString("label.schedule.internal")%></td>
															<td colspan='2' width='11%' align='center' class='tablebold'><%=bundle.getString("label.schedule.external")%></td>
														</tr>
														<tr>
															<td class='tablelight'><%=bundle.getString("label.schedule.min")%></td><td><input type='text' size='3' maxlength='3' name='theoryinternalmin' value='<%=hashmap.get("theoryinternalmin")%>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.min")%></td><td><input type='text' size='3' maxlength='3' name='theoryexternalmin' value='<%=hashmap.get("theoryexternalmin") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.min")%></td><td><input type='text' size='3' maxlength='3' name='practicalinternalmin' value='<%=hashmap.get("practicalinternalmin") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.min")%></td><td><input type='text' size='3' maxlength='3' name='practicalexternalmin' value='<%=hashmap.get("practicalexternalmin") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.min")%></td><td><input type='text' size='3' maxlength='3' name='projectinternalmin' value='<%=hashmap.get("projectinternalmin") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.min")%></td><td><input type='text' size='3' maxlength='3' name='projectexternalmin' value='<%=hashmap.get("projectexternalmin") %>'></td>
														</tr>
														<tr>
															<td class='tablelight'><%=bundle.getString("label.schedule.max")%></td><td><input type='text' size='3' maxlength='3' name='theoryinternalmax' value='<%=hashmap.get("theoryinternalmax") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.max")%></td><td><input type='text' size='3' maxlength='3' name='theoryexternalmax' value='<%=hashmap.get("theoryexternalmax") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.max")%></td><td><input type='text' size='3' maxlength='3' name='practicalinternalmax' value='<%=hashmap.get("practicalinternalmax") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.max")%></td><td><input type='text' size='3' maxlength='3' name='practicalexternalmax' value='<%=hashmap.get("practicalexternalmax") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.max")%></td><td><input type='text' size='3' maxlength='3' name='projectinternalmax' value='<%=hashmap.get("projectinternalmax") %>'></td>
															<td class='tablelight'><%=bundle.getString("label.schedule.max")%></td><td><input type='text' size='3' maxlength='3' name='projectexternalmax' value='<%=hashmap.get("projectexternalmax") %>'></td>
														</tr>
													</table>
										    	</td>
										    </tr>
								    	</table>
								    <%
					    		}
					    	}
					    	else{
					    		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
				    			//out.print("<tr><td colspan='5' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
					    	}
					    	
					    %>
					</table>
				</td>
			</tr>
		</table>

		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
		<%if(academicyear != null && !academicyear.equals("") && !academicyear.equalsIgnoreCase("null") && !academicyear.equals("0")){ %>
			<a href="#" class="bt_green" onclick='goToMark()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.update")%></strong><span class="bt_green_r"></span></a>
		<%}%>
		
		<input type='hidden' name='sessionname' 				value='<%=sessionnname%>'>
		<input type='hidden' name='session' 					value='<%=sessionid%>'>
		<input type='hidden' name='board' 						value='<%=boardid%>'>
		<input type='hidden' name='standardscheduleid' 			value='<%=standardscheduleid%>'>
		<input type='hidden' name='boardname' 					value='<%=boardname%>'>
		<input type='hidden' name='archival' 					value='<%=archival%>'>
		<input type='hidden' name='returnpage' 					value='ImportMarkSchedule.jsp'>

	</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>