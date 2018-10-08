<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Standard List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>

	function savefun()
	{
		if(check_ForParticularElements(document.workallotment.studremarks,"textarea"))
		{
			index_attach = document.workallotment.assin_file.value;
			if(index_attach != "")
			{
				var ext	   = index_attach.substring(index_attach.lastIndexOf(".")+1);
				ext		   = ext.toLowerCase();
				if(!(ext == "doc" || ext == "pdf" || ext == "ppt"))
				{
					alert("only the following file formats are allowed. \n *.doc,*.pdf,*.ppt");
					return false;
				}
			}
			document.workallotment.action="AssignmentSubmit.jsp";
			document.workallotment.submit();
		}
	}

	function goBack()
	{
		
		if(document.workallotment.assignmentid_flage.value=="singleassignment")
		{
			document.workallotment.action="./StudentHome.jsp";
			document.workallotment.submit();
		}
		else
		{
			document.backform.action="AssignmentList.jsp";
			document.backform.submit();
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
<%

	String assignmentid_flage	= request.getParameter("assignmentid_flage");
	String status				= request.getParameter("status");
	
	


	if(assignmentid_flage!=null && !assignmentid_flage.equals("") && !assignmentid_flage.equalsIgnoreCase("null"))
	{
		if(assignmentid_flage.equals("singleassignment"))
		{
			out.print(" <h2>Dashboard / My Assignment</h2>");
		}
		else  
		{
			String displaystauts		= "";
			
			if(status != null && status.equals("A"))
				displaystauts			= "Assigned List";
			else if(status != null && status.equals("S"))
				displaystauts			= "Submitted List";
			else if(status != null && status.equals("Y"))
				displaystauts			= "Yet to Submit List";
			
			out.print(" <h2>Activity / My Assignment / "+displaystauts+" / Assignment Details</h2>");
		}
	}
%>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Assignment.AssignmentStudent"%>
<%
	String pagefrom				= null;
	String sectionid			= (String)session.getValue("sectionscheduleid");
	String studentid			= (String)session.getValue("studentid");
	String	assignmentid		= request.getParameter("assignmentid"); 
	String subjectscheduleid	= request.getParameter("subjectscheduleid");
	String subjectname			= request.getParameter("subjectname");
	String expiredstatus		= request.getParameter("expiredstatus");
	

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
								
	<table id="rounded-corner" border=0 width="100%">
	    <thead>
	    	<tr>
	            <th scope="col" class="rounded-company" width="98%">Assignment Details</th>
	            <th scope="col" class="rounded-q4" width="2%"></th>
	        </tr>
	    </thead>
		<tr>
			<td colspan='2'>								
				<table align=center cellpadding=5 cellspacing=0 border=0 width="100%">
					<tr height=20 valign="top">
						<td class=tablebold width='20%'>Subject Name</td><td class=tablebold>:</td><td class=tablelight colspan=1 ><%=subjectname%></td>
						<td class=tablebold width='20%'>Lesson Name</td><td class=tablebold>:</td><td class=tablelight colspan=2 ><%=lessonname%></td>
					</tr>
					<tr height=20 valign='top'>
						<td class=tablebold width='2%'>Assignment Topic</td><td class=tablebold>:</td><td class=tablelight colspan=1 ><%=questionname%></td>
						<td class=tablebold>Assigned By</td><td class=tablebold>:</td><td class=tablelight colspan=2 bgcolor=f4f4f4><%=staffname%></td>
					</tr>
					<tr height=20 valign='top'>
						<td class=tablebold>Remarks</td><td class=tablebold>:</td><td colspan=4 class=tablelight bgcolor=f4f4f4><%=remarks%></td>
					</tr>
					<tr height=20 valign='top'>
						<td class=tablebold>File Attachment</td><td class=tablebold>:</td><td colspan=4 class=tablelight>
							<%
								if(questionfile != null && !questionfile.equals("-") && !questionfile.equalsIgnoreCase("null"))
									out.print("<a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(questionfile)+"' target='_new'>View</a>");
								else
									out.print("No Reference");
							%>
						</td>
					</tr>
					<tr height=20 valign='top'>
						<td class=tablebold>Start Date</td><td class=tablebold>:</td><td class=tablelight ><%=assignmentdate%></td>
						<td class=tablebold>End Date</td><td class=tablebold>:</td><td class=tablelight colspan=2><%=submissiondate%></td>
					</tr>
					<%if(status != null && status.equals("S")){%>
					<tr height=20 valign='top'>
						<td class=tablebold valign=top>Student Remarks</td>
						<td class=tablebold>:</td><td class=tablelight colspan=4><%=studentremarks%></td>
					</tr>
					<tr height=20 valign='top'>
						<td class=tablebold width="25%">Attach File</td>
						<td class=tablebold>:</td><td colspan=4 bgcolor=f4f4f4 class=tablelight>
						<%
							if(file != null && !file.equals("-") && !file.equalsIgnoreCase("null"))
								out.print("<a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(file)+"' target='_new'>Attached</a>");
							else
								out.print("No Attachment");
						%>
						</td>
					</tr>
				<%}else{ 
				
					if(expiredstatus != null && expiredstatus.equals("E")){
					%>
						<tr height=20 valign='top'>
							<td class=tablebold valign=top>Student Remarks</td>
							<td class=tablebold>:</td><td class=tablelight colspan=4><%=studentremarks%></td>
						</tr>
						<tr height=20 valign='top'>
							<td class=tablebold width="25%">Attach File</td>
							<td class=tablebold>:</td><td colspan=4 bgcolor=f4f4f4 class=tablelight>
							<%
								if(file != null && !file.equals("-") && !file.equalsIgnoreCase("null"))
									out.print("<a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(file)+"' target='_new'>Attached</a>");
								else
									out.print("No Attachment");
							%>
							</td>
						</tr>
					<%
					}
					else{
				
				%>
					<tr height=20 valign=top>
						<td class=tablebold>Student Remarks<font color='red'>*</font></td>
						<td class=tablebold>:</td><td class=tablelight colspan=4 bgcolor=f4f4f4><input type=hidden name='tempann' value='500'><textarea rows="5" cols="75" class="tablelight" name="studremarks" validate="Student Remarks" onkeydown="textCounter(document.workallotment.studremarks,document.workallotment.remLen2,500)" onkeyup="textCounter(document.workallotment.studremarks,document.workallotment.remLen2,500)" ><%=studentremarks%></textarea>&nbsp; <br><input readonly class='tablelight' type="text" name="remLen2" size="3" maxlength="3" value="<%=remain%>"><font class='tablebold' color='red'>500 Characters Only</font></td>
					</tr>
					<tr height=20 valign='top'>
						<td class=tablebold width="25%">Attach File</td>
						<td class=tablebold>:</td><td colspan=4 bgcolor=f4f4f4 class=tablelight><input type=file validate="File" name=assin_file class=tablelight onkeydown='this.blur()'>
						<input type='hidden' name='oldfile'        value='<%=file%>'>
						<%
							if(file != null && !file.equals("-") && !file.equalsIgnoreCase("null"))
							out.println("<a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+java.net.URLEncoder.encode(file)+"' target='_new'>Attached</a>");
						%>
				
						</td>
					</tr>
				
				<%} 
				}
				
				%>
				</table>
			</td>
		</tr>
	</table>
	
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	
	<%if(status != null && !status.equals("S")){%>
		<a href="#" id="savebut"  class="bt_green" onclick='savefun()'><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
	<%} %>
		
	
	</form>  
	
	<form name='backform' action="./AssignmentList.jsp" method='post'>
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