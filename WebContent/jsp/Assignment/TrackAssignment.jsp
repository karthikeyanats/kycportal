<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.tracking.assignmentevaluationtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
	
	function callEdit(obj){
		
		document.workallotment.questionid.value = obj.getAttribute("questionid");
		document.workallotment.action = "UpdateQuestion.jsp";
		document.workallotment.submit();
	
	}
	
	function callEvaluate(obj){
		
		document.workallotment.assignmentid.value 			= obj.getAttribute("assignmentid");
		document.workallotment.studentallocationid.value 	= obj.getAttribute("studentallocationid");
		document.workallotment.action = "EvaluateAssignment.jsp";
		document.workallotment.submit();
	}	
	
	function goBack(){
		
		document.workallotment.action = "AssignmentEvaluation.jsp";
		document.workallotment.submit();
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

    <h2><%=bundle.getString("label.tracking.assignmentevaluationrootpath_1") %> </h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Assignment.Assignment"%>
<%
	
	String sessionid		= request.getParameter("session");
	String standardid		= request.getParameter("standard");
	String sectionid		= request.getParameter("section");
	String subjectid		= request.getParameter("subject");
	String lessonid			= request.getParameter("lesson");
	String sectionname		= request.getParameter("sectionname");
	String subjectname		= request.getParameter("subjectname");
	String lessonname		= request.getParameter("lessonname");
	String standardname		= request.getParameter("standardname");
	String sessionname		= request.getParameter("sessionname");
	String questionid		= request.getParameter("questionid");
	String questionname		= request.getParameter("questionname");
	Assignment	assignment	= new Assignment();
	HashMap	hashmap			= null;
	ArrayList questionList	= assignment.loadAssignmentSubmitted(questionid);

	

%>
	<form name='workallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="100%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' >
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.tracking.AssignmentDetails") %></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='2'>							
							
											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
			
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.SessionName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=sessionname%>
													</td>
												</tr>	
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.StandardName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=standardname%>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.SubjectName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=subjectname%>
													</td>
												</tr>	
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.LessonName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=lessonname%>
													</td>
												</tr>									
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.SectionName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=sectionname%>
													</td>
												</tr>	
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.TopicName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=questionname%>
													</td>
												</tr>									
											</table>
										</td>
									</tr>
								</table>
						
						<tr height='10'>
							<td align='left'>
							</td>
						</tr>					
						<tr>
							<td align='left'>
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.tracking.SL.No") %>.</th>
								            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.tracking.StudentName") %></th>
								            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.tracking.StudentRemark") %></th>
								            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.tracking.Reference") %></th>
								            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.tracking.FacultyRemark") %></th>
								            <th scope="col" class="rounded" width="5%"><%=bundle.getString("label.tracking.Mark") %></th>
								            <th scope="col" class="rounded-q4" width="5%"><%=bundle.getString("label.tracking.Evaluate") %></th>
								        </tr>
								    </thead>

									<%
									try{
										String file		= "";
										String link		= "";
										if(questionList != null && questionList.size()>0){
											for(int y=0;y<questionList.size();y++){
												hashmap		= (HashMap)questionList.get(y);
												file		= (String)hashmap.get("file");
												out.print("<tr valign='top'><td>"+(y+1)+".</td><td>"+hashmap.get("studentname")+"</td>");
												
												if(hashmap.get("studentremarks") == null){
													out.print("<td colspan='2'><i>-Not Submitted-</i></td>");
													
												}
												else{
													out.print("<td >"+hashmap.get("studentremarks")+"</td>");
													if(file != null && !file.equals("-") && !file.equals("null") && !file.equalsIgnoreCase("null"))
														out.print("<td><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+file+"' target='_new'>"+bundle.getString("hlink.tracking.View") +"</a></td>");
													else
														out.print("<td>-</td>");
												}
												
												if(hashmap.get("facultyremarks") == null){
													out.print("<td colspan='2'><i>-Not Evaluated-</i></td>");
													link	= "Evaluate";
												}
												else{
													out.print("<td >"+hashmap.get("facultyremarks")+"</td><td>"+hashmap.get("mark")+"</td>");
													link	= "Evaluated";
												}
												if(hashmap.get("studentremarks") == null)
													out.print("<td>-</td></tr>");
												else
													out.print("<td><a href='#' studentallocationid='"+hashmap.get("studentallocationid")+"' assignmentid='"+hashmap.get("assignmentid")+"' onclick='callEvaluate(this)'>"+bundle.getString("hlink.tracking."+link) +"</a></td></tr>");

											}
										}
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
											//out.print("<tr><td colspan='7'>No Data Found</td></tr>");
										}
									}catch(Exception e){
										
									}
									%>
								</table>
							</td>
						</tr>
					</table>
					<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.tracking.Back") %></strong><span class="bt_blue_r"></span></a>
				
				</td>
			</tr>
		</table>
		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
		<input type='hidden' name='section' 			value='<%=sectionid%>'>
		<input type='hidden' name='subject' 			value='<%=subjectid%>'>
		<input type='hidden' name='lesson' 				value='<%=lessonid%>'>
		<input type='hidden' name='standard' 			value='<%=standardid%>'>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>
		<input type='hidden' name='lessonname' 			value='<%=lessonname%>'>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>
		<input type='hidden' name='sectionname' 		value='<%=sectionname%>'>
		<input type='hidden' name='questionid' 			value='<%=questionid %>'>
		<input type='hidden' name='questionname' 		value='<%=questionname %>'>
		<input type='hidden' name='assignmentid' 		value=''>
		<input type='hidden' name='studentallocationid' value=''>
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>