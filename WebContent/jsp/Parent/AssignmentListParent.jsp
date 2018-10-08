<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.assignmentparent.entrytitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>

<script language='javascript'>

	function loadAssignment(obj){
		
		document.workallotment.assignmentid.value	= obj.getAttribute("assignmentid");
		document.workallotment.action				= "./AssignmentProcessParent.jsp";
		document.workallotment.submit();
	
	}

	
	function goBack()
	{
		document.workallotment.action="Assignment.jsp";
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

    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Assignment.AssignmentStudent"%>
<%
	
	String sectionid			= (String)session.getValue("sectionscheduleid");
	String studentid			= (String)session.getValue("studentid");
	String subjectscheduleid	= request.getParameter("subjectscheduleid");
	String subjectname			= request.getParameter("subjectname");
	String status				= request.getParameter("status");
	String displaystauts		= "";
	
	if(status != null && status.equals("A"))
		displaystauts			= "Assigned List";
	else if(status != null && status.equals("S"))
		displaystauts			= "Submitted List";
	else if(status != null && status.equals("Y"))
		displaystauts			= "Yet to Submit List";
	
	AssignmentStudent	assignment	= new AssignmentStudent();
	HashMap	hashmap					= null;
	ArrayList assignmentList		= assignment.loadAssignmentViewForStudentSubject(studentid,subjectscheduleid,status);
	ArrayList staffList				= null;
	
%>    
    
    <h2><%=bundle.getString("label.assignmentparent.entryheading") %> <%=displaystauts%></h2>
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
								        	
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.assignmentparent.StudentDetails") %></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='2'>				
							
											<%
												out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
												out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.assignmentparent.StudentName") +"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
												out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.AcademicYear") +"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
												if(session.getValue("groupname") == null)
													out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.StandardName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
												else
													out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.StandardName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
												out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.SectionName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
												out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.BoardName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
												out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.MediumName") +"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
												out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.RollNo.") +"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");
				
												out.print("</table>");
											%>	
										</td>
									</tr>
								</table>
								<br>
								
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.assignmentparent.SubjectandStaffDetails") %></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>
								    	<td colspan='2'>
								    		<table id="rounded-corner" border=0 summary="Department List" width="100%">
												<tr><td width='20%' valign='top' class='tablebold'><%=bundle.getString("label.assignmentparent.SubjectName") %></td><td width='1%' valign='top' class='tablebold'>:</td><td><%=subjectname%></td></tr>
												<%
													staffList			= assignment.loadStaffForStudentConsolidated(sectionid,subjectscheduleid);
													if(staffList != null && staffList.size()>0){
														
														out.print("<tr><td class='tablebold' rowspan='"+staffList.size()+"' valign='top'>"+bundle.getString("label.assignmentparent.StaffName")+"</td><td rowspan='"+staffList.size()+"' valign='top' class='tablebold'>:</td>");
														for(int k=0;k<staffList.size();k++){
															hashmap	= (HashMap)staffList.get(k);
															if(k==0)
																out.print("<td>"+hashmap.get("staffname")+"</td></tr>");
															else
																out.print("<tr><td>"+hashmap.get("staffname")+"</td></tr>");
														}
													}
												%>
												</table>
										</td>
									</tr>
								</table>								    
								<br>
							
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.assignmentparent.S.No") %></th>
								            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.assignmentparent.QuestionName") %></th>
								            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.assignmentparent.StartDate") %></th>
								            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.assignmentparent.EndDate") %></th>
								            <th scope="col" class="rounded" width="10%"><%=bundle.getString("label.assignmentparent.Mark") %></th>
								            <th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.assignmentparent.ReferenceFile") %></th>
								        </tr>
								    </thead>
									
									<%
										String lessonscheduleid		= "";
										String lessonscheduleid_swap= "";
										int assignmentcounter		= 1;
										boolean flag				= false;
										String questionfile			= "";
										
										if(assignmentList != null && assignmentList.size()>0){
											
											for(int y=0;y<assignmentList.size();y++){
												hashmap				= (HashMap)assignmentList.get(y);
												lessonscheduleid	= (String)hashmap.get("lessonscheduleid");

												if(lessonscheduleid_swap.equals("") || !lessonscheduleid.equals(lessonscheduleid_swap)){
													out.print("<tr><td colspan='6'><b>"+bundle.getString("label.assignmentparent.LessonName") +" : </b>"+hashmap.get("lessonname")+"</td></tr>");
													lessonscheduleid_swap	= lessonscheduleid;
													flag					= false;
												}
												
												if(hashmap.get("assignmentid") != null){
													questionfile	= (String)hashmap.get("questionfile");
													out.print("<tr><td>"+assignmentcounter+".</td>");
													
													if(((String)hashmap.get("datestatus")).equals("Available"))
														out.print("<td><a href='#cls' onClick='loadAssignment(this)' assignmentid='"+hashmap.get("assignmentid")+"'>"+hashmap.get("questionname")+"</a></td>");
													else
														out.print("<td><a href='#cls' onClick='loadAssignment(this)' assignmentid='"+hashmap.get("assignmentid")+"'>"+hashmap.get("questionname")+"</a>&nbsp;&nbsp;[&nbsp;<font color='red'>Date Expired</font>&nbsp;]</td>");
													
													out.print("<td>"+hashmap.get("assignmentdate")+"</td><td>"+hashmap.get("submissiondate")+"</td><td>"+hashmap.get("questionmark")+"</td>");
													if(questionfile == null || questionfile.equals("") || questionfile.equalsIgnoreCase("null") || questionfile.equalsIgnoreCase("-"))
														out.print("<td>No Reference</td></tr>");
													else
														out.print("<td><a href='"+request.getContextPath()+"/OpenDocument?r1=path&r2="+java.net.URLEncoder.encode(questionfile)+"' target='_new'>"+bundle.getString("label.assignmentparent.View") +"</a></td></tr>");
													assignmentcounter++;
													flag	= true;
												}
												else
													if(!flag){
														out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
														//out.print("<tr><td colspan='6'>Data Not Found</td></tr>");
													}

											}
										}
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
											//out.print("<tr><td colspan='6'>Data Not Found</td></tr>");
										}
									%>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.assignmentparent.Back")%></strong><span class="bt_blue_r"></span></a>
		
		
		<input type='hidden' name='assignmentid' 		value=''>
		<input type='hidden' name='subjectscheduleid'	value='<%=subjectscheduleid %>'>
		<input type='hidden' name='status'				value='<%=status %>'>
		<input type='hidden' name='subjectname'			value='<%=subjectname %>'>
		
	</form>    
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>