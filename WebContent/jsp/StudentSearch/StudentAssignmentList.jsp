	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>

<script language='javascript'>

	

	
	function goBack()
	{
		document.workallotment.action="Studentassignment.jsp";
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
	<%@ page language="java"	import="com.iGrandee.StudentSearch.StudentSearchEntry,java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Assignment.AssignmentStudent"%>
<%

StudentSearchEntry studentquery = new StudentSearchEntry(); 
String rollnumber = "";
rollnumber=request.getParameter("rollnumber");
ArrayList Studentpersonminidetails=new ArrayList();


Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);

	String subjectscheduleid	= request.getParameter("subjectscheduleid");
	String subjectname			= request.getParameter("subjectname");
	String status				= request.getParameter("status");
	String displaystauts		= "";
	String sectionid="";
		String standardid="";
		String sectionname="";
		String standardname="";
		String studentid="";
		String name="";
		String groupname = null;
		String standardscheduleid="";
			String sessionname="";
	if(status != null && status.equals("A"))
		displaystauts			= "Assigned List";
	else if(status != null && status.equals("S"))
		displaystauts			= "Submitted List";
	else if(status != null && status.equals("Y"))
		displaystauts			= "Yet to Submit List";
	
	AssignmentStudent	assignment	= new AssignmentStudent();
	HashMap	hashmap					= null;
	
	ArrayList staffList				= null;
	
	 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0) {
			

		 HashMap	map = (HashMap) Studentpersonminidetails.get(0);
			name = (String) map.get("uname");
			studentid = (String) map.get("studentallocationid");
			standardid = (String) map.get("standardid");
			sectionid = (String) map.get("sectionscheduleid");
			
			standardname = (String) map.get("standardname");
			sectionname = (String) map.get("sectionname");
			standardscheduleid = (String) map.get("standardscheduleid");
			sessionname = (String) map.get("sessionname");
			groupname = (String) map.get("groupname");
				if(groupname==null)
					groupname = "";
				else
					groupname = " - "+groupname;
		 }
	 ArrayList assignmentList		= assignment.loadAssignmentViewForStudentSubject(studentid,subjectscheduleid,status);
%>   
    
    <h2><%=bundle.getString("label.studentsearch.assignmentrootpath") %> / <%=displaystauts%></h2>
	<form name='workallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="90%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left'>
							
							<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.studentsearch.hometableheading") %></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded" width="23%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded-q4" width="25%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.rollno") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=rollnumber%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.studentname") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=name%></td>
				</tr>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.academicyear") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=sessionname%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.standard") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=standardname%><%=groupname %></td>
				</tr>
				<tr>
					
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.section") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" colspan=4 width="20%"><%=sectionname%></td>
				</tr>
				
				</table>
				<br>
							
								<table id="rounded-corner" border=0 width="80%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="20%">Subject and Staff Details</th>
								            <th scope="col" class="rounded" width="1%"></th>
								            <th scope="col" class="rounded-q4" width="80%"></th>
								        </tr>
								    </thead>
								    <tr>
								    	<td colspan='3'>
												<tr><td width='20%' valign='top' class='tablebold'>Subject Name</td><td width='1%' valign='top' class='tablebold'>:</td><td><%=subjectname%></td></tr>
												<%  
													staffList			= assignment.loadStaffForStudentConsolidated(sectionid,subjectscheduleid);
													if(staffList != null && staffList.size()>0){
														
														out.print("<tr><td class='tablebold' rowspan='"+staffList.size()+"' valign='top'>Staff Name</td><td rowspan='"+staffList.size()+"' valign='top' class='tablebold'>:</td>");
														for(int k=0;k<staffList.size();k++){
															hashmap	= (HashMap)staffList.get(k);
															if(k==0)
																out.print("<td>"+hashmap.get("staffname")+"</td></tr>");
															else
																out.print("<tr><td>"+hashmap.get("staffname")+"</td></tr>");
														}
													}
												%>
												
										</td>
									</tr>
								</table>								    
								<br>
							
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="10%">S.No</th>
								            <th scope="col" class="rounded" width="35%">Topic Name</th>
								            <th scope="col" class="rounded" width="10%">Start Date</th>
								            <th scope="col" class="rounded" width="10%">End Date</th>
								            <th scope="col" class="rounded" width="10%">Mark</th>
								            <th scope="col" class="rounded-q4" width="15%">Reference File</th>
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
													out.print("<tr><td colspan='6'><b>Lesson Name : </b>"+hashmap.get("lessonname")+"</td></tr>");
													lessonscheduleid_swap	= lessonscheduleid;
													flag					= false;
												}
												
												if(hashmap.get("assignmentid") != null){
													questionfile	= (String)hashmap.get("questionfile");
													out.print("<tr><td>"+assignmentcounter+".</td>");
													
													if(((String)hashmap.get("datestatus")).equals("Available"))
														out.print("<td>"+hashmap.get("questionname")+"</td>");
													else
														out.print("<td>"+hashmap.get("questionname")+"&nbsp;&nbsp;[&nbsp;<font color='red'>Date Expired</font>&nbsp;]</td>");
													
													out.print("<td>"+hashmap.get("assignmentdate")+"</td><td>"+hashmap.get("submissiondate")+"</td><td>"+hashmap.get("questionmark")+"</td>");
													if(questionfile == null || questionfile.equals("") || questionfile.equalsIgnoreCase("null") || questionfile.equalsIgnoreCase("-"))
														out.print("<td>No Reference</td></tr>");
													else
														out.print("<td><a href='"+request.getContextPath()+"/OpenDocument?r1=path&r2="+java.net.URLEncoder.encode(questionfile)+"' target='_new'>View</a></td></tr>");
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
		
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		
		
		<input type='hidden' name='assignmentid' 		value=''>
		<input type='hidden' name='subjectscheduleid'		value='<%=subjectscheduleid %>'>
		<input type='hidden' name='status'				value='<%=status %>'>
		<input type='hidden' name='subjectname'			value='<%=subjectname %>'>
		<input type='hidden' name='assignmentid_flage' 	value='multiassignment'>
		<input type='hidden' name='rollnumber'			value="<%=rollnumber%>">
		
		
	</form>    
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>