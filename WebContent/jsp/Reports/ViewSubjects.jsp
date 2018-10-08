<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
	
	function goBack(){
		
		document.Schedule_Form.action = "StandardSchedule.jsp";
		document.Schedule_Form.submit();
	}

	function printfun()
	{
		window.open("PrintPreviewStandardSchedulesubject.jsp?boardname="+document.Schedule_Form.boardname.value+"&req_sessionname="+document.Schedule_Form.req_sessionname.value+"&req_sessionid="+document.Schedule_Form.req_sessionid.value+"&board="+document.Schedule_Form.board.value+"&req_sessionname="+document.Schedule_Form.req_sessionname.value+"&req_sessionid="+document.Schedule_Form.req_sessionid.value+"&board="+document.Schedule_Form.board.value+"&req_sessionstatus="+document.Schedule_Form.req_sessionstatus.value+"&req_standardscheduleid="+document.Schedule_Form.standardscheduleid.value+"&req_standardname="+document.Schedule_Form.standardname.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
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
	
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>
	<%
		ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
	%>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.reports.reportsstandardschedulesubject")%></h2>
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
		String boardid				= request.getParameter("board");	
		String boardname			= request.getParameter("boardname");		
		String archival				= request.getParameter("archival");
		int datacount 				= 0;
		String snames				= "";

		
		
		if(stndardList != null && stndardList.size()>0){
			hashmap			= (HashMap)stndardList.get(0);
			sname			= (String)hashmap.get("standardname");
			if(hashmap.get("groupstatus") != null && ((String)hashmap.get("groupstatus")).equals("Yes"))
				groupname	= (String)hashmap.get("groupname");
			if(!groupname.equals(""))
			snames=sname+" -"+groupname;
			else
				snames=sname;
		}
		
%>

<form name="Schedule_Form" action="" method="post">
		<table id="rounded-corner" border=0 summary="Department List" width="80%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" colspan='2' width="99%"><%=bundle.getString("label.schedule.academicyearandboard")%></th>
		            <th scope="col" class="rounded-q4" 					width="1%"></th>
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
						<%
							if(archival != null && archival.equals("R")){
						%>		
						<tr>
							<td width='20%' class='tablebold' valign=top><%=bundle.getString("label.schedule.archivaldetails")%></td>
							<td width='1%' class='tablebold' valign=top>:</td>
							<td class='tablelight' width='79%' valign=top>
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
					            <th scope="col" class="rounded" 		width="50%"><%=bundle.getString("label.schedule.subjectname")%></th>
					            <th scope="col" class="rounded-q4" 		width="40%"><%=bundle.getString("label.schedule.subjectcode")%></th>
					        </tr>
					    </thead>
						<tfoot>
						   	<tr>
						       	<td colspan="2" class="rounded-foot-left"><em></em></td>
						       	<td class="rounded-foot-right">&nbsp;</td>
						    </tr>
						</tfoot>		    					    
					    <%
					    try{
					    	
					    	if(subjectList != null && subjectList.size()>0){
					    		int count = 1;
					    		
					    		for(int y=0;y<subjectList.size();y++){
					    			
					    			hashmap		= (HashMap)subjectList.get(y);
					    			status		= (String)hashmap.get("status");
					    			if(status.equals("Yes")){
						    			out.print("<tr><td>"+(count++)+".</td><td><a href='#' subjectscid='"+hashmap.get("subjectscheduleid")+"' subjectname='"+hashmap.get("subjectname")+"' onclick='callLessons(this)'>"+hashmap.get("subjectname")+"</td><td>"+hashmap.get("subjectcode")+"</td>");
						    			datacount++;
									}
									
					    		}
								if(datacount==0){
									out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
									//out.print("<tr><td colspan='3' align='center'>"+bundle.getString("label.schedule.datanotfound")+"</td></tr>");
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
		</table>

		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("label.schedule.back")%></strong><span class="bt_blue_r"></span></a>
<%-- 		<a href="#" class="bt_red" onclick='deActivatedList()'><span class="bt_red_lft"></span><strong><%=bundle.getString("label.schedule.trashedlist")%></strong><span class="bt_red_r"></span></a>
 --%>		<%if(datacount>0){%> 
				<a href="#" 	name='back' 	class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
		<%} %>				
		
		<input type='hidden' name='sessionname' 				value='<%=sessionnname%>'>
		<input type='hidden' name='session' 					value='<%=sessionid%>'>
		<input type='hidden' name='board' 						value='<%=boardid%>'>
		<input type='hidden' name='standardscheduleid' 			value='<%=standardscheduleid%>'>
		<input type='hidden' name='standardname' 			        value='<%=snames%>'>
		<input type='hidden' name='subjectid' 					value=''>
		<input type='hidden' name='subjectscheduleid' 			value=''>
		<input type='hidden' name='subjectname' 				value=''>
		<input type='hidden' name='status' 						value=''>
		<input type='hidden' name='boardname' 					value='<%=boardname%>'>
		<input type='hidden' name='archival' 					value='<%=archival%>'>

		<input type='hidden' name='req_sessionname' 			value='<%=request.getParameter("req_sessionname") %>'>
		<input type='hidden' name='req_sessionid' 				value='<%=request.getParameter("req_sessionid") %>'>
		<input type='hidden' name='req_sessionstatus' 			value='<%=request.getParameter("req_sessionstatus") %>'>
		<input type='hidden' name='req_boardid' 				value='<%=request.getParameter("req_boardid") %>'>

	</form>		

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>

</html>