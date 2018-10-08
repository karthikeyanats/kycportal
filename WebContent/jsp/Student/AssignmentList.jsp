<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script language='javascript'>

	function loadAssignment(obj){

		document.workallotment.assignmentid.value	= obj.getAttribute("assignmentid");
		document.workallotment.expiredstatus.value	= obj.getAttribute("estatus");
		document.workallotment.action				= "./AssignmentProcess.jsp";
		document.workallotment.submit();

	}

	function goBack()
	{
		document.workallotment.action="AssignmentView.jsp";
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

    <h2>Activity / My Assignment / <%=displaystauts%></h2>
	<form name='workallotment' method='post'>


		<table id="rounded-corner" border=0 width="100%">
		    <thead>
		    	<tr>
		          <th scope="col" class="rounded-company" width="99%">Subject and Staff Details</th>
		            <th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>
		    		<table id="rounded-corner" border=0 summary="Department List" width="100%">
						<tr valign="top"><td width='20%' valign='top' class='tablebold'>Subject Name</td><td width='1%' valign='top' class='tablebold'>:</td><td><%=subjectname%></td></tr>
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
						</table>
				</td>
			</tr>
		</table>
		<br>


		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="9%">S.No</th>
		            <th scope="col" class="rounded" width="40%">Topic Name</th>
		            <th scope="col" class="rounded" width="12%">Start Date</th>
		            <th scope="col" class="rounded" width="12%">End Date</th>
		            <th scope="col" class="rounded" width="12%">Mark</th>
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
							out.print("<tr valign='top'><td colspan='6'><b>Lesson Name : </b>"+hashmap.get("lessonname")+"</td></tr>");
							lessonscheduleid_swap	= lessonscheduleid;
							flag					= false;
						}

						//out.print("assignment===>"+hashmap.get("assignmentid"));
						//out.print("studentid===>"+studentid);


						if(hashmap.get("assignmentid") != null){
							questionfile	= (String)hashmap.get("questionfile");
							out.print("<tr valign='top'><td>"+assignmentcounter+".</td>");

							if(((String)hashmap.get("datestatus")).equals("Available"))
								out.print("<td><a href='#cls' onClick='loadAssignment(this)' assignmentid='"+hashmap.get("assignmentid")+"'>"+hashmap.get("questionname")+"</td>");
							else{
								if(status != null && status.equals("S"))
									out.print("<td><a href='#cls' onClick='loadAssignment(this)' assignmentid='"+hashmap.get("assignmentid")+"'>"+hashmap.get("questionname")+"</td>");
								else{
									out.print("<td><a href='#cls' onClick='loadAssignment(this)' estatus='E' assignmentid='"+hashmap.get("assignmentid")+"'>"+hashmap.get("questionname")+"</a>&nbsp;&nbsp;[&nbsp;<font color='red'>Date Expired</font>&nbsp;]</td>");
								}
							}
							out.print("<td>"+hashmap.get("assignmentdate")+"</td><td>"+hashmap.get("submissiondate")+"</td><td>"+hashmap.get("obtained")+"/"+hashmap.get("questionmark")+"</td>");
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



		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>


		<input type='hidden' name='assignmentid' 		value=''>
		<input type='hidden' name='subjectscheduleid'	value='<%=subjectscheduleid %>'>
		<input type='hidden' name='status'				value='<%=status %>'>
		<input type='hidden' name='expiredstatus'		value=''>
		<input type='hidden' name='subjectname'			value='<%=subjectname %>'>
		<input type='hidden' name='assignmentid_flage' 	value='multiassignment'>

	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>


</div>
</body>
</html>