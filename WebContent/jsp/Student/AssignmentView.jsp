<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language='javascript'>

	function loadSubmitted(obj){
	
		document.workallotment.subjectscheduleid.value	= obj.getAttribute("subjectscheduleid");
		document.workallotment.status.value				= obj.getAttribute("status");
		document.workallotment.subjectname.value		= obj.getAttribute("subjectname");
		document.workallotment.action					= "./AssignmentList.jsp";
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

    <h2>Activities / My Assignment</h2>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Assignment.AssignmentStudent"%>
<%
	
	String sectionid				= (String)session.getValue("sectionscheduleid");
	String studentid				= (String)session.getValue("studentid");
	AssignmentStudent	assignment	= new AssignmentStudent();
	HashMap	hashmap					= null;
	ArrayList subjectList			= assignment.loadAssignmentViewForStudentConsolidated(sectionid,studentid);
	ArrayList staffList				= null;
	
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
								        	<th scope="col" class="rounded-company" width="5%">Sl.No</th>
								            <th scope="col" class="rounded" width="30%">Subject Name</th>
								            <th scope="col" class="rounded" width="30%">Staff Name</th>
								            <th scope="col" class="rounded" width="10%">Assigned</th>
								            <th scope="col" class="rounded" width="10%">Submitted</th>
								            <th scope="col" class="rounded-q4" width="15%">Yet to Submit</th>
								        </tr>
								    </thead>
									
									<%
										String subjectscheduleid		= "";
										HashMap hashmap1				= null;
										int assigned					= 0;
										int submitted					= 0;
										int yettosubmit					= 0;
										
										if(subjectList != null && subjectList.size()>0){
											
											for(int y=0;y<subjectList.size();y++){
												hashmap				= (HashMap)subjectList.get(y);
												
												subjectscheduleid	= (String)hashmap.get("subjectscheduleid");
												
												if(hashmap.get("assigned") == null)
													assigned	= 0;
												else
													assigned	= Integer.parseInt((String)hashmap.get("assigned"));
													
												if(hashmap.get("submitted") == null)
													submitted	= 0;
												else
													submitted	= Integer.parseInt((String)hashmap.get("submitted"));
												
												
												staffList			= assignment.loadStaffForStudentConsolidated(sectionid,subjectscheduleid);
												
												out.print("<tr valign='top'><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td>");
												out.print("<td><table>");
												if(staffList != null && staffList.size()>0){
													for(int k=0;k<staffList.size();k++){
														hashmap1	= (HashMap)staffList.get(k);
														out.print("<tr valign='top'><td>"+hashmap1.get("staffname")+"</td></tr>");
													}
												}
												else
													out.print("<tr valign='top'><td>Not Yet Allotted</td></tr>");
												out.print("</table></td>");
												
												if(assigned == 0)
													out.print("<td>"+assigned+"</td>");
												else
													out.print("<td><a href='#cls' subjectname='"+hashmap.get("subjectname")+"' subjectscheduleid='"+subjectscheduleid+"' status='A' onClick='loadSubmitted(this)'><font color='blue' size='5'>"+assigned+"</font></a></td>");

												if(submitted == 0)
													out.print("<td>"+submitted+"</td>");
												else
													out.print("<td><a href='#cls' subjectname='"+hashmap.get("subjectname")+"' subjectscheduleid='"+subjectscheduleid+"' status='S' onClick='loadSubmitted(this)'><font color='green' size='5'>"+submitted+"</font></a></td>");
												
												yettosubmit		= assigned-submitted;
												
												if(yettosubmit <= 0)
													out.print("<td>0</td>");
												else
													out.print("<td><a href='#cls' subjectname='"+hashmap.get("subjectname")+"' subjectscheduleid='"+subjectscheduleid+"' status='Y' onClick='loadSubmitted(this)'><font color='red' size='5'>"+yettosubmit+"</font></a></td>");
												
												out.print("</tr>");
											}
										}
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
											//out.print("<tr><td colspan='6' class='tablebold' align='center'>Data Not Found</td></tr>");
										}
									%>
								</table>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<input type='hidden' name='assignmentid' 		value=''>
		<input type='hidden' name='subjectscheduleid'	value=''>
		<input type='hidden' name='status'				value=''>
		<input type='hidden' name='assignmentid_flage' 	value='multiassignment'>
		<input type='hidden' name='subjectname'			value=''>
		
		
	</form>    
    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>