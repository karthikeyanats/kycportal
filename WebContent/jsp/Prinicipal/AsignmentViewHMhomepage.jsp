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

<script language='javascript'>


	
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

    <h2>Activity / My Assignment</h2>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Assignment.AssignmentStudent"%>
<%
	String sectionid				= (String)session.getValue("sectionscheduleid");
	String studentid				= (String)session.getValue("studentid");
	AssignmentStudent	assignment	= new AssignmentStudent();
	HashMap	hashmap					= null;
	String assignmentid=request.getParameter("assignmentid");
	ArrayList questionList			= assignment.loadAssignmentViewForHMHomepage(assignmentid);
%>    
    
    
	<form name='workallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="90%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left'>
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="1%"></th>
								            <th scope="col" class="rounded" width="98%">Assignment Details</th>
								            <th scope="col" class="rounded-q4" width="1%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='3'>						
							
							
										<%
												String lessonscheduleid			= "";
												String templessonscheduleid		= "";
												String subjectscheduleid		= "";
												String tempsubjectscheduleid	= "";
												int assignmentcount				= 0;
												String questionfile				= "";
											
												if(questionList != null && questionList.size()>0){
													
													for(int y=0;y<questionList.size();y++){
														hashmap				= (HashMap)questionList.get(y);
														subjectscheduleid	= (String)hashmap.get("subjectscheduleid");
														lessonscheduleid	= (String)hashmap.get("lessonscheduleid");
														questionfile		= (String)hashmap.get("questionfile");
														
														if(tempsubjectscheduleid.equals("") || !tempsubjectscheduleid.equals(subjectscheduleid)){
															if(y != 0)
																out.print("</table>");
															
															out.print("<table  border='1' align='center' width='100%' cellspacing='0' cellpadding='5'>");
															out.print("<tr><td colspan='6'><table width='100%' border='0'><tr><td width='13%'>Academic Name </td><td width='1%'>:</td><td width='36%'>"+hashmap.get("sessionname")+"</td><td width='13%'>Standard Name</td><td width='1%'>:</td><td width='36%'>"+hashmap.get("standardname")+"</td></tr></table></td></tr>");
															if(hashmap.get("staffname") == null)
																out.print("<tr><td colspan='6'><table width='100%' border='0'><tr><td width='13%'>Subject Name</td><td width='1%'>:</td><td width='36%'>"+hashmap.get("subjectname")+"</td><td width='13%'>Faculty Name</td><td width='1%'>:</td><td width='36%'>Not Yet Allotted</td></tr></table></td></tr>");
															else
																out.print("<tr><td colspan='6'><table width='100%' border='0'><tr><td width='13%'>Subject Name</td><td width='1%'>:</td><td width='36%'>"+hashmap.get("subjectname")+"</td><td width='13%'>Faculty Name</td><td width='1%'>:</td><td width='36%'>"+hashmap.get("staffname")+"</td></tr></table></td></tr>");
															out.print("<tr><td>SL No.</td><td>Topic</td><td>Start Date</td><td>End Date</td><td>Mark</td></tr>");
															
															tempsubjectscheduleid	= subjectscheduleid;
															templessonscheduleid	= "";
															assignmentcount			= 0;
														}
														
														if(templessonscheduleid.equals("") || !templessonscheduleid.equals(lessonscheduleid)){
															out.print("<tr><td>Lesson Name</td><td colspan='5'>"+hashmap.get("lessonname")+"</td>");
															templessonscheduleid	= lessonscheduleid;
														}
														
														if(hashmap.get("assignmentid")== null){
															out.print("<tr><td colspan='6'>No Question Found</td></tr>");
														}
														else{
															assignmentcount++;
															out.print("<tr><td>"+assignmentcount+"</td><td>"+hashmap.get("questionname")+"</td><td>"+hashmap.get("assignmentdate")+"</td><td>"+hashmap.get("submissiondate")+"</td><td>"+hashmap.get("questionmark")+"</td>");
															
															if(questionfile == null || questionfile.equals("") || questionfile.equals("-") || questionfile.equalsIgnoreCase("null"))
																out.print("<td>-</td></tr>");
															else
																//out.print("<td><a href='#'>View</a></td></tr>");
															
															
															if(hashmap.get("studentremarks") == null){
																out.print("<tr><td colspan='6'>Not Yet Submitted.</td></tr>");
															}
															else{
																out.print("<tr><td>Student Remarks</td><td>"+hashmap.get("studentremarks")+"</td><td>Submitted Date</td><td>"+hashmap.get("studentdate")+"</td>");
																questionfile	= (String)hashmap.get("file");
																if(questionfile == null || questionfile.equals("") || questionfile.equals("-") || questionfile.equalsIgnoreCase("null"))
																	out.print("<td>-</td></tr>");
																else
																	out.print("<td><a href='#'>View</a></td></tr>");
															}
															
															if(hashmap.get("facultyremarks") == null){
																out.print("<tr><td colspan='6'>No Remarks Given.</td></tr>");
															}
															else{
																out.print("<tr><td>Faculty Remarks</td><td>"+hashmap.get("facultyremarks")+"</td><td>Remarks Date</td><td>"+hashmap.get("facultydate")+"</td><td>"+hashmap.get("mark")+"</td></tr>");
															}												
														}
													}
													out.print("</table>");
												}
												else{
													
												}
											%>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</form>    <% 
           // out.print("<a href='./AssignmentView.jsp' class='bt_blue'><span class='bt_blue_lft'></span><strong>Back to Assignment View</strong><span class='bt_blue_r'></span></a>");
    
	%>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>