<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.assignmentview.assignmenttitle")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script language='javascript'>

function lessonclick(obj)
{

document.workallotment.assignmentid.value=obj.getAttribute("assignmentid");
document.workallotment.assignmentid_flage.value="singleassignment";

document.workallotment.action="AssignmentProcess.jsp";
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
 
    <h2><%=bundle.getString("label.assignmentview.assignmentrootpath")%></h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Assignment.AssignmentStudent"%>
<%
AssignmentStudent	assignment	= new AssignmentStudent();
HashMap	hashmap					= null;

	String sectionid				= (String)session.getValue("sectionscheduleid");
	String studentid				= (String)session.getValue("studentid");
	String assignmentid=request.getParameter("assignmentid");
	String usercategory1=(String)session.getValue("usercategory");
	String usercategory_temp				= (String)session.getValue("usercategory");
	ArrayList questionList			= assignment.loadAssignmentViewForStudentHomepage(sectionid,studentid,assignmentid);
	
%>    
    
    
	<form name='workallotment' method='post'>
	<input type="hidden" name="assignmentid" value="">
		<input type="hidden" name="assignmentid_flage" value="">
	
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="90%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left'>
							<tr class='tablebold' height='25'>
						<td valign='top'>
						<table id="rounded-corner" border=0 
							width="100%">
							<thead>
								<tr>
									<th scope="col" class="rounded-company" width="1%"></th>
									<th scope="col" class="rounded" width="98%"><%=bundle.getString("label.assignmentview.AssignmentDetails") %>
									</th>
									<th scope="col" class="rounded-q4" width="1%"></th>
								</tr>
							</thead>
							<tr>
								<td colspan='3'>
								<%
									out
											.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out
											.print("<tr><td width='17%'>"+bundle.getString("label.assignmentview.StudentName")+"</td><td width='1%'>:</td><td>"
													+ session.getValue("studentname") + "</td></tr>");
									out.print("<tr><td>"+bundle.getString("label.assignmentview.AcademicYear")+"</td><td>:</td><td>"
											+ session.getValue("sessionname") + "</td></tr>");
									if (session.getValue("groupname") == null)
										out.print("<tr><td>"+bundle.getString("label.assignmentview.StandardName")+"</td><td>:</td><td>"
												+ session.getValue("standardname") + "</td></tr>");
									else
										out.print("<tr><td>"+bundle.getString("label.assignmentview.StandardName")+"</td><td>:</td><td>"
												+ session.getValue("standardname")
												+ "&nbsp;&nbsp;[&nbsp;" + session.getValue("groupname")
												+ "&nbsp;]</td></tr>");
									out.print("<tr><td>"+bundle.getString("label.assignmentview.SectionName")+"</td><td>:</td><td>"
											+ session.getValue("sectionname") + "</td></tr>");
									out.print("<tr><td>"+bundle.getString("label.assignmentview.BoardName")+"</td><td>:</td><td>"
											+ session.getValue("boardname") + "</td></tr>");
									out.print("<tr><td>"+bundle.getString("label.assignmentview.MediumName")+"</td><td>:</td><td>"
											+ session.getValue("mediumname") + "</td></tr>");
									out.print("<tr><td>"+bundle.getString("label.assignmentview.RollNo")+"</td><td>:</td><td>"
											+ session.getValue("rollno") + "</td></tr>");

									out.print("</table>");
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
					</td>
					</tr>
						<br>
						<br>
						<tr>
						<td>
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="1%"></th>
								            <th scope="col" class="rounded" width="98%"><%= bundle.getString("label.assignmentview.AssignmentDetails")%></th>
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
															
															out.print("<table  border='0' align='center' width='100%' cellspacing='0' cellpadding='5'>");
															//out.print("<tr><td>Subject Name</td><td>"+hashmap.get("subjectname")+"</td>");
															if(hashmap.get("staffname") == null)
																out.print("<tr><td colspan='6'><table width='100%' border='0'><tr><td width='20%' class='tablebold'>"+ bundle.getString("label.assignmentview.SubjectName")+"</td><td width='1%' class='tablebold'>:</td><td width='36%'>"+hashmap.get("subjectname")+"</td><td width='20%' class='tablebold'>"+ bundle.getString("label.assignmentview.FacultyName")+"</td><td width='1%' class='tablebold'>:</td><td width='36%'>Not Yet Allotted</td></tr></table></td></tr>");
															else
																out.print("<tr><td colspan='6'><table width='100%' border='0'><tr><td width='20%' class='tablebold'>"+ bundle.getString("label.assignmentview.SubjectName")+"</td><td width='1%' class='tablebold'>:</td><td width='36%'>"+hashmap.get("subjectname")+"</td><td width='20%' class='tablebold'>"+ bundle.getString("label.assignmentview.FacultyName")+"</td><td width='1%'>:</td><td width='36%'>"+hashmap.get("staffname")+"</td></tr></table></td></tr>");
															out.print("<table align='center' width='100%' cellspacing='0' cellpadding='5'><tr class='tablebold'><td>"+ bundle.getString("label.assignmentview.slno")+"</td><td>Topic</td><td>"+ bundle.getString("label.assignmentview.StartDate")+"</td><td>"+ bundle.getString("label.assignmentview.EndDate")+"</td><td>"+ bundle.getString("label.assignmentview.Mark")+"</td></tr>");
															
															tempsubjectscheduleid	= subjectscheduleid;
															templessonscheduleid	= "";
															assignmentcount			= 0;
														}
														
														if(templessonscheduleid.equals("") || !templessonscheduleid.equals(lessonscheduleid)){
															out.print("<tr><td class='tablebold'>"+ bundle.getString("label.assignmentview.LessonName")+"</td><td colspan='5'>"+hashmap.get("lessonname")+"</td>");
															templessonscheduleid	= lessonscheduleid;
														}
														
														if(hashmap.get("assignmentid")== null){
															out.print("<tr><td colspan='6'>No Question Found</td></tr>");
														}
														else{
															assignmentcount++;
															if(usercategory1.equals("P"))
															{
															out.print("<tr><td>"+assignmentcount+"</td><td>"+hashmap.get("questionname")+"</td><td>"+hashmap.get("assignmentdate")+"</td><td>"+hashmap.get("submissiondate")+"</td><td>"+hashmap.get("questionmark")+"</td>");
															}
															else
															{
															out.print("<tr><td>"+assignmentcount+"</td><td><a href='#' assignmentid='"+hashmap.get("assignmentid")+"' onclick=lessonclick(this)>"+hashmap.get("questionname")+"</td><td>"+hashmap.get("assignmentdate")+"</td><td>"+hashmap.get("submissiondate")+"</td><td>"+hashmap.get("questionmark")+"</td>");

															}
															
															//out.print("<tr><td>"+assignmentcount+"</td><td>"+hashmap.get("questionname")+"</td><td>"+hashmap.get("assignmentdate")+"</td><td>"+hashmap.get("submissiondate")+"</td><td>"+hashmap.get("questionmark")+"</td>");
															
															//if(questionfile == null || questionfile.equals("") || questionfile.equals("-") || questionfile.equalsIgnoreCase("null"))
																//out.print("<td>-</td></tr>");
															//else
														//		out.print("<td><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+questionfile+"' target='_new'>View</a></td></tr>");
															
															
															if(hashmap.get("studentremarks") == null){
																out.print("<tr><td colspan='6'>Not Yet Submitted.</td></tr>");
															}
															else{
																out.print("<tr><td class='tablebold'>"+ bundle.getString("label.assignmentview.StudentRemarks")+"</td><td>"+hashmap.get("studentremarks")+"</td><td class='tablebold'>"+ bundle.getString("label.assignmentview.SubmittedDate")+"</td><td>"+hashmap.get("studentdate")+"</td>");
																questionfile	= (String)hashmap.get("file");
																if(questionfile == null || questionfile.equals("") || questionfile.equals("-") || questionfile.equalsIgnoreCase("null"))
																	out.print("<td>-</td></tr>");
																else
																out.print("<td><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+questionfile+"' target='_new'>View</a></td></tr>");

															}
															
															if(hashmap.get("facultyremarks") == null){
																out.print("<tr><td colspan='6'>No Faculty Remarks Given.</td></tr>");
															}
															else{
																out.print("<tr><td class='tablebold'>"+ bundle.getString("label.assignmentview.FacultyRemarks")+"</td><td>"+hashmap.get("facultyremarks")+"</td><td class='tablebold'>"+ bundle.getString("label.assignmentview.FacultyRemarksDate")+"</td><td>"+hashmap.get("facultydate")+"</td><td>"+hashmap.get("mark")+"</td></tr>");
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
	</form>  
	  <% 
	if(usercategory_temp.equals("P"))
	 {
            out.print("<a href='../../jsp/Parent/TimeTable.jsp' class='bt_blue'><span class='bt_blue_lft'></span><strong>"+bundle.getString("button.assignmentview.back")+"</strong><span class='bt_blue_r'></span></a>");
	 }
	else
	{
        out.print("<a href='./StudentHome.jsp' class='bt_blue'><span class='bt_blue_lft'></span><strong>"+bundle.getString("button.assignmentview.back")+"</strong><span class='bt_blue_r'></span></a>");

	} 
	%>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>