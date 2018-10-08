<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child -  <%=bundle.getString("label.tracking.assignmentevaluationtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
	
function savefun()
{
	if(check_ForParticularElements(document.workallotment.studremarks,"textarea",document.workallotment.studentmark,"text"))
	{
		if(isNaN(document.workallotment.studentmark.value))
		{
			alert("Marks should be in numbers");
			document.workallotment.save.disabled	= false;
			document.workallotment.studentmark.value = "0";
			document.workallotment.studentmark.focus();
			return false;
		}
		if(parseInt(document.workallotment.studentmark.value)<0)
		{
			alert("Marks should be greater than or equal to zero");
			document.workallotment.studentmark.focus();
			document.workallotment.studentmark.value = "0";
			return false;
		}
		if(parseInt(document.workallotment.studentmark.value)>parseInt(document.workallotment.questionmark.value))
		{
			alert("Obtained marks should be less than total marks");
			document.workallotment.studentmark.focus();
			document.workallotment.studentmark.value = "0";
			return false;
		}
		document.workallotment.action="EvaluateSubmit.jsp";
		document.workallotment.submit();
	}
}
	
	function goBack(){
		
		document.workallotment.action = "TrackAssignment.jsp";
		document.workallotment.submit();
	}
	
	function openFile(object)
	{
		var filename=object.getAttribute("value");
		window.open("<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2="+filename,"","menubar=0,location=no,scrolbars=yes,resizable=yes")
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

    <h2><%=bundle.getString("label.tracking.AssignmentEvaluate") %></h2>

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
	String assignmentid		= request.getParameter("assignmentid");
	String studentid		= request.getParameter("studentallocationid");
	
	Assignment	assignment	= new Assignment();
	HashMap	hashmap			= null;
	ArrayList questionList	= assignment.loadAssignmentEvaluate(assignmentid,studentid);
	
	
	
	String assigntracking		= "";
	String ass_file				= "";
	String ass_rem				= "";
	String userid 				= "";
	String questionname1		= "";
	String assigndate			= "";
	String submissiondate		= "";
	String assigntopic			= "";
	String mark					= "";
	String agentid				= "";
	String assignid				= "";
	String agentname			= "";
	String assignfile 			= "";
	String assignmentstatus     = "insert";
	String studentname			= "";
	String studentremark		= "";
	String staffremark			= "";
	ArrayList Detailslist		= null;
	String questionmark			= "";
	String submitteddate		= "";
	int contentsize				= 500;
	String subject				= "";
	ArrayList	cour_str		= null;
	String slt_session			= null;
	String tracking				= "";
	
	
	if(questionList != null && questionList.size() > 0)
	{
	
			HashMap inList		= (HashMap)questionList.get(0);
			questionname		= (String)inList.get("questionname");
			assigndate			= (String)inList.get("assignmentdate");
			submissiondate		= (String)inList.get("submissiondate");
			assigntopic 		= (String)inList.get("remarks");
			studentname			= (String)inList.get("studentname");
			assignfile			= (String)inList.get("refernce");
		//	out.println(assignfile);
			
			questionmark		= (String)inList.get("questionmark");
			tracking			= (String)inList.get("assigntracking");
			
				staffremark			= (String)inList.get("facultyremarks");
				if(staffremark == null || staffremark.equalsIgnoreCase("null") || staffremark.equals(""))
					staffremark = "";
				else
					contentsize = 500-staffremark.length();
				assigntracking		= (String)inList.get("assigntracking");
				mark				= (String)inList.get("mark");
				if(mark == null || mark.equals("") || mark.equalsIgnoreCase("null"))
				mark = "";
				studentremark		= (String)inList.get("studentremarks");

				submitteddate		= (String)inList.get("studentdate");
				ass_file			= (String)inList.get("file");
				if(ass_file == null || ass_file.length()<2)
					ass_file = "-";
			
	
	}

	

%>
	<form name='workallotment' method='post'>
							
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
					</table>
				</td>
			</tr>
		</table>
		<br>
	
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		      
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.tracking.AssignmentSubmittedDetails") %></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
		    <tr>
		    	<td colspan='2'>						
	
					<table align=center cellpadding=5 cellspacing=0 border=0 width="100%">
						<tr height=20>
							<td class=tablebold width='20%'><%=bundle.getString("label.tracking.AssignmentTopic") %></td><td class=tablebold>:</td><td class=tablelight  colspan='4'><%=questionname%></td>
						</tr>
						<tr height=20 valign=top>
							<td class=tablebold><%=bundle.getString("label.tracking.Description") %></td><td class=tablebold>:</td><td class=tablelight colspan='4'><%=assigntopic%></td>
						</tr>
						<%
							if(assignfile != null && !assignfile.equals("-"))
							{
								%>
									<tr height=20>
										<td class=tablebold><%=bundle.getString("label.tracking.FileAttachment") %> </td><td class=tablebold>:</td><td class=tablelight colspan='4'><a href='<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=assignfile %>' target='_new' ><%=bundle.getString("hlink.tracking.AssignmentView") %></a></td>
									</tr>
								<%
							}
							else
							{
								%>
									<tr height=20>
										<td class=tablebold><%=bundle.getString("label.tracking.FileAttachment") %></td><td class=tablebold>:</td><td class=tablelight colspan='4'><%=bundle.getString("label.tracking.staffattachmentnotavailable") %></td>
									</tr>
								<%
							}
					
						%>												
						<tr height=20>
							<td class=tablebold><%=bundle.getString("label.tracking.StartDate") %></td><td class=tablebold>:</td><td class=tablelight ><%=assigndate%></td>
							<td class=tablebold><%=bundle.getString("label.tracking.EndDate") %></td><td class=tablebold width="1%">:</td><td class=tablelight width="20%" ><%=submissiondate%></td>
						</tr>
						<tr height=20>
							<td class=tablebold><%=bundle.getString("label.tracking.StudentName") %></td><td class=tablebold>:</td><td class=tablelight colspan='4'><%=studentname%></td>
						</tr>
						<tr height=20>
							<td class=tablebold>Student Remark</td><td class=tablebold>:</td><td class=tablelight colspan='4'><%=studentremark%></td>
						</tr>
						<%
							if(ass_file != null && !ass_file.equals("-"))
							{
								%>
									<tr height=20>
										<td class=tablebold><%=bundle.getString("label.tracking.StudentAttachment") %></td><td class=tablebold>:</td><td class=tablelight colspan='4'><a href='<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=ass_file %>' target='_new' ><%=bundle.getString("hlink.tracking.AssignmentView") %></a></td>
									</tr>
								<%
							}
							else
							{
								%>
									<tr height=20>
										<td class=tablebold><%=bundle.getString("label.tracking.StudentAttachment") %></td><td class=tablebold>:</td><td class=tablelight colspan='4'><%=bundle.getString("label.tracking.LessonName") %><%=bundle.getString("label.tracking.NoAttachmentfromStudent") %></td>
									</tr>
								<%
							}
					
						%>
						<tr height=20>
								<td class=tablebold><%=bundle.getString("label.tracking.SubmittedDate") %></td><td class=tablebold>:</td><td class=tablelight ><%=submitteddate%></td>
								<td class=tablebold ><%=bundle.getString("label.tracking.MarkObtained/TotalMark") %></td><td class=tablebold>:</td><td class=tablelight ><input type=text name='studentmark' validate="Mark" value="<%=mark%>" size=3 maxlength=3>/<%=questionmark%></td>
						</tr>
						<tr height=20>
							<td class=tablebold valign=top><%=bundle.getString("label.tracking.StaffRemark") %><font color='red'>*</font></td>
							<td class=tablebold colspan='4'><input type=hidden name='tempann' value='500'><textarea rows="5" cols="75" class="tablelight" name="studremarks" validate="Staff Remarks" onkeydown="textCounter(document.workallotment.studremarks,document.workallotment.remLen2,500)" onkeyup="textCounter(document.workallotment.studremarks,document.workallotment.remLen2,500)" ><%=staffremark%></textarea>&nbsp; <br><input readonly class='tablelight' type="text" name="remLen2" size="3" maxlength="3" value="<%=contentsize%>"><font class='tablebold' color='red'><%=bundle.getString("label.tracking.500CharactersOnly") %></font></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
							
			     	
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.tracking.Back") %></strong><span class="bt_blue_r"></span></a>
  		<a href="#" id="savebut"  class="bt_green" onclick='savefun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.tracking.Submit") %></strong><span class="bt_green_r"></span></a>
				
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
		<input type=hidden name='questionmark' 			value ="<%=questionmark%>">
		<input type='hidden' name='assignmentid' 		value='<%=assignmentid %>'>
		<input type='hidden' name='studentallocationid' value='<%=studentid%>'>
		<input type='hidden' name='trackingid' 			value='<%=tracking%>'>
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>