<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.assignmentparent.entrytitle") %>  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>

	function goBack()
	{
		document.backform.action="AssignmentListParent.jsp";
		document.backform.submit();
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
<%

	String assignmentid_flage	= request.getParameter("assignmentid_flage");
	String status				= request.getParameter("status");
	String displaystauts		= "";
	
	if(status != null && status.equals("A"))
		displaystauts			= "Assigned List";
	else if(status != null && status.equals("S"))
		displaystauts			= "Submitted List";
	else if(status != null && status.equals("Y"))
		displaystauts			= "Yet to Submit List";
	
	out.print(" <h2>"+bundle.getString("label.assignmentparent.entryheading")+" / "+displaystauts+" / "+bundle.getString("label.assignmentparent.AssignmentDetails")+"</h2>");
	
%>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Assignment.AssignmentStudent"%>
<%
	String sectionid			= (String)session.getValue("sectionscheduleid");
	String studentid			= (String)session.getValue("studentid");
	String	assignmentid		= request.getParameter("assignmentid"); 
	String subjectscheduleid	= request.getParameter("subjectscheduleid");
	String subjectname			= request.getParameter("subjectname");
	
	
	AssignmentStudent	assignment	= new AssignmentStudent();
	HashMap	hashmap					= null;
	ArrayList questionList			= assignment.loadAssignmentForSubmit(assignmentid,studentid);
	
	String questionname				= "";
	String lessonname				= "";
	String staffname				= "";
	String remarks					= "";
	String questionfile				= "";
	String studentremarks			= "";
	String assignmentdate			= "";
	String submissiondate			= "";
	String file						= "";
	int remain						= 0;
	
	if(questionList != null && questionList.size()>0){
		hashmap			= (HashMap)questionList.get(0);
		
		questionname	= (String)hashmap.get("questionname");
		staffname		= (String)hashmap.get("staffname");
		remarks			= (String)hashmap.get("remarks");
		questionfile	= (String)hashmap.get("questionfile");
		studentremarks	= (String)hashmap.get("studentremarks");
		if(studentremarks == null)
			studentremarks	= "";
		remain			= 500-studentremarks.length();
		assignmentdate	= (String)hashmap.get("assignmentdate");
		submissiondate	= (String)hashmap.get("submissiondate");
		file			= (String)hashmap.get("file");
		subjectname		= (String)hashmap.get("subjectname");
		lessonname		= (String)hashmap.get("lessonname");
	}
%>    
    
    
	<form name='workallotment' method='post' enctype='multipart/form-data'>
		
		<input type="hidden" name="assignmentid_flage" 	value="<%=assignmentid_flage %>">
		<input type="hidden" name="assignmentid" 		value="<%=assignmentid%>">
		
		
					<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.assignmentparent.StudentDetails")%></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>				
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.assignmentparent.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.assignmentparent.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");
	
									out.print("</table>");
								%>	
							</td>
						</tr>
					</table>
					<br>
		
								
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
	    <thead>
	    	<tr>
	        	
	            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.assignmentparent.AssignmentDetails") %></th>
	            <th scope="col" class="rounded-q4" width="2%"></th>
	        </tr>
	    </thead>
		<tr>
			<td colspan='2'>								
				<table align=center cellpadding=5 cellspacing=0 border=0 width="100%">
					<tr height=20>
						<td class=tablebold width='17%'><%=bundle.getString("label.assignmentparent.SubjectName") %></td><td class=tablebold width='1%'>:</td><td class=tablelight width='32%'><%=subjectname%></td>
						<td class=tablebold width='15%'><%=bundle.getString("label.assignmentparent.LessonName") %></td><td class=tablebold width='1%'>:</td><td class=tablelight  width='34%'><%=lessonname%></td>
					</tr>
					<tr height=20>
						<td class=tablebold ><%=bundle.getString("label.assignmentparent.AssignmentTopic") %></td><td class=tablebold>:</td><td class=tablelight><%=questionname%></td>
						<td class=tablebold><%=bundle.getString("label.assignmentparent.AssignedBy") %></td><td class=tablebold>:</td><td class=tablelight bgcolor=f4f4f4><%=staffname%></td>
					</tr>
					<tr height=20>
						<td class=tablebold valign='top'><%=bundle.getString("label.assignmentparent.Remarks") %></td><td class=tablebold valign='top'>:</td><td colspan=4 class=tablelight bgcolor=f4f4f4><%=remarks%></td>
					</tr>
					<tr height=20>
						<td class=tablebold><%=bundle.getString("label.assignmentparent.FileAttachment") %></td><td class=tablebold>:</td><td colspan=4 class=tablelight>
							<%
								if(questionfile != null && !questionfile.equals("-") && !questionfile.equalsIgnoreCase("null"))
									out.print("<a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(questionfile)+"' target='_new'>"+bundle.getString("label.assignmentparent.View")+"</a>");
								else
									out.print("No Reference");
							%>
						</td>
					</tr>
					<tr height=20>
						<td class=tablebold><%=bundle.getString("label.assignmentparent.StartDate") %></td><td class=tablebold>:</td><td class=tablelight ><%=assignmentdate%></td>
						<td class=tablebold><%=bundle.getString("label.assignmentparent.EndDate") %></td><td class=tablebold>:</td><td class=tablelight><%=submissiondate%></td>
					</tr>
					<tr height=20>
						<td class=tablebold valign=top><%=bundle.getString("label.assignmentparent.StudentRemarks") %></td>
						<td class=tablebold>:</td>
						<td class=tablelight colspan=4><%=studentremarks%></td>
					</tr>
					<tr height=20>
						<td class=tablebold ><%=bundle.getString("label.assignmentparent.AttachFile") %></td>
						<td class=tablebold>:</td>						
						<td colspan=4 bgcolor=f4f4f4 class=tablelight>
						<%
							if(file != null && !file.equals("-") && !file.equalsIgnoreCase("null"))
								out.print("<a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(file)+"' target='_new'>"+bundle.getString("hlink.assignmentparent.Attached")+"</a>");
							else
								out.print("No Attachment");
						%>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	
	
	<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.assignmentparent.Back") %></strong><span class="bt_blue_r"></span></a>
		
	
	</form>  
	
	<form name='backform' action="./AssignmentListParent.jsp" method='post'>
		<input type='hidden' name='subjectscheduleid'	value='<%=subjectscheduleid %>'>
		<input type='hidden' name='status'				value='<%=status %>'>
		<input type='hidden' name='subjectname'			value='<%=subjectname%>'>
	</form>  
    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>