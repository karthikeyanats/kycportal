<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Remove Assignment | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language='javascript'>

	var counter		= 0;
	
	function backfun(){
	
		document.workallotment.action = "Allocation.jsp";
		document.workallotment.submit();
	}
	
	function callCount(obj){
	
		if(obj.checked){
			counter ++;
		}
		else {
		counter--;
		}
	}
	
	function submitfun(){
	
		if(counter >0){
			document.workallotment.action = "RemoveSubmit.jsp";
			document.workallotment.submit();
		}
		else {
			alert("Please select any one student to remove.");
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

    <div class="right_content">

    <h2>Activities / Assignment /Assignment Remove</h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Assignment.Assignment"%>

	<form name='workallotment' method='post'>
		<%
			String questionid		= request.getParameter("assignment");
			String assignmentid		= request.getParameter("assignment_hide");
			Assignment assign		= new Assignment();
			ArrayList statusList 	= assign.loadAssignmentStudents(questionid);
			HashMap	hashmap			= null;
			String studentstatus	= "";
			String facultystatus	= "";
			String sessionid		= (String)session.getValue("sessionid");
			String sessionname		= (String)session.getValue("sessionname");
			
		
		%>
 		  <input type='hidden' name='assignment_hide'   	value='<%=assignmentid%>'>
 		  <input type='hidden' name='assignment'   			value='<%=questionid%>'>
 		  
 		 <table id="rounded-corner" border=0 summary="Department List" width="90%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%">Assignment Allocation</th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>				  		
		    <tr>
	 			<td colspan='2'>

		  			<table border=0 width="100%" align=left cellspacing=0 cellpadding=5>
		 				<tr height=20>
						<td class='tablebold' width='20%' align='left'>Academic Year</td>
						<td class='tablebold' width='1%' align='left'>:</td>
						<td class='tablelight' colspan='4' width='79%' align='left'>
							 <%=sessionname%>
							 <input type='hidden' name='sessionname'   	value='<%=sessionname%>'>
						</td>
					</tr>
		 				<tr bgcolor=f4f4f4 height=20>
		 					<td class=tablebold>Standard Name</td>
						<td class='tablebold' width='1%'>:</td>
						<td class='tablelight' colspan='4'>
							 <%=request.getParameter("standardname")%>
							 <input type='hidden' name='standardname'   	value='<%=request.getParameter("standardname")%>'>
						</td>
		 				</tr>
		 				<tr height=20>
		 					<td class=tablebold>Subject Name</td>
						<td class='tablebold' width='1%'>:</td>
						<td class='tablelight' colspan='4'>
							 <%=request.getParameter("subjectname")%>
							 <input type='hidden' name='subjectname'   	value='<%=request.getParameter("subjectname")%>'>
		
						</td>
		
		 				</tr>
		 				<tr bgcolor=f4f4f4 height=20>
		 					<td class=tablebold>Lesson Name</td>
						<td class='tablebold' width='1%'>:</td>
						<td class='tablelight' colspan='4'>
							 <%=request.getParameter("lessonname")%>
							 <input type='hidden' name='lessonname'   	value='<%=request.getParameter("lessonname")%>'>
		
						</td>
		
					<tr  height=20>
		 					<td class=tablebold valign=top>Section Name</td>
						<td class='tablebold' width='1%'>:</td>
						<td class='tablelight' colspan='4'>
							 <%=request.getParameter("sectionname")%>
							 <input type='hidden' name='sectionname'   	value='<%=request.getParameter("sectionname")%>'>
		
						</td>
					<tr  height=20>
		 					<td class=tablebold valign=top>Topic Name</td>
						<td class='tablebold' width='1%'>:</td>
						<td class='tablelight' colspan='4'>
							 <%=request.getParameter("assignmentname")%>
							 <input type='hidden' name='assignmentname'   	value='<%=request.getParameter("assignmentname")%>'>
		
						</td>
						
		 				</tr>
		 				<tr height=20 bgcolor=f4f4f4>
		 					<td class=tablebold valign=top>Description</td>
						<td class='tablebold' width='1%'>:</td>
						<td class='tablelight' colspan='4'>
							 <%=request.getParameter("task")%>
							 <input type='hidden' name='task'   	value='<%=request.getParameter("task")%>'>
		
						</td>
							</tr>
		 				<tr  height=20>
		 					<td class=tablebold>Start Date</td>
						<td class='tablebold' width='1%'>:</td>
						<td class='tablelight'>
							 <%=request.getParameter("startdate")%>
							 <input type='hidden' name='startdate'   	value='<%=request.getParameter("startdate")%>'>
		
						</td>
						<td class=tablebold>End Date</td>
						<td class='tablebold' width='1%'>:</td>
						<td class='tablelight' >
							 <%=request.getParameter("enddate")%>
							 <input type='hidden' name='enddate'   	value='<%=request.getParameter("enddate")%>'>
		
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
	        	<th scope="col" class="rounded-company" width="10%">Sl.No</th>
	            <th scope="col" class="rounded" width="40%">Student Name</th>
	            <th scope="col" class="rounded" width="25%">Submitted</th>
	            <th scope="col" class="rounded-q4" width="25%">Evaluated</th>
	        </tr>
	     </thead>
        <%
        try{
			if(statusList != null && statusList.size()>0){
				
				for(int z=0;z<statusList.size();z++)
				{
					hashmap			= (HashMap)statusList.get(z);
					studentstatus	= (String)hashmap.get("studentstatus");
					facultystatus	= (String)hashmap.get("facultystatus");


					out.print("<tr height='21'>");
					out.print("<td>");
					if(studentstatus.equals("Yes") || facultystatus.equals("Yes"))
						out.print("<input type='checkbox' disabled name='students' value='"+hashmap.get("studentallocationid")+"'>");
					else
						out.print("<input type='checkbox' name='students' value='"+hashmap.get("studentallocationid")+"' onclick='callCount(this)'>");

					out.print("</td><td class='tablelight'>"+hashmap.get("studentname")+"</td>");
					out.print("<td class='tablelight'>"+studentstatus+"</td>");
					out.print("<td class='tablelight'>"+facultystatus+"</td>");

					out.print("</tr>");
				}
			}
			else{
				out.println("<tr align='center' height='21' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
				//out.print("<tr height='21'><td colspan='4' align='center'>No Data Found</td></tr>");
			}
        }
        catch(Exception e){
        	
        }
      	%>					     
	</table>				
		
    <a href="#" class="bt_blue" onclick='backfun()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	<a href="#" id="rembut"   class="bt_red" onclick='submitfun()'><span class="bt_red_lft"></span><strong>Remove</strong><span class="bt_red_r"></span></a>

		
		
				
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>