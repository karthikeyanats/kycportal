<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.assignmentcreation.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>


	
	function changeStandard(){
		
		if(check_ForParticularElements(document.wprkallotment.standard,"select")){
			document.wprkallotment.submit();
		}
	}	
	
	function changeSubject(){
		
		if(check_ForParticularElements(document.wprkallotment.standard,"select",document.wprkallotment.subject,"select")){
			document.wprkallotment.submit();
		}
	}	

	function loadExisting(){
	
		if(check_ForParticularElements(document.wprkallotment.standard,"select",document.wprkallotment.subject,"select",document.wprkallotment.lesson,"select",document.wprkallotment.section,"select")){
			
			document.wprkallotment.standardname.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].text;
			document.wprkallotment.sectionname.value	= document.wprkallotment.section.options[document.wprkallotment.section.options.selectedIndex].text;
			document.wprkallotment.subjectname.value	= document.wprkallotment.subject.options[document.wprkallotment.subject.options.selectedIndex].text;
			document.wprkallotment.lessonname.value		= document.wprkallotment.lesson.options[document.wprkallotment.lesson.options.selectedIndex].text;
			document.wprkallotment.action 				= "AssignmentView.jsp";
			document.wprkallotment.submit();
		}
	}	
	
	
	
	
	
	function changeSection(){
		
		if(check_ForParticularElements(document.wprkallotment.standard,"select",document.wprkallotment.subject,"select",document.wprkallotment.lesson,"select",document.wprkallotment.section,"select")){
			
			document.wprkallotment.standardname.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].text;
			document.wprkallotment.sectionname.value	= document.wprkallotment.section.options[document.wprkallotment.section.options.selectedIndex].text;
			document.wprkallotment.subjectname.value	= document.wprkallotment.subject.options[document.wprkallotment.subject.options.selectedIndex].text;
			document.wprkallotment.lessonname.value		= document.wprkallotment.lesson.options[document.wprkallotment.lesson.options.selectedIndex].text;
			
			document.wprkallotment.action = "Assignment.jsp";
			document.wprkallotment.submit();
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

    <h2><%=bundle.getString("label.assignmentcreation.rootpath") %></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Assignment.Assignment"%>
	
<%
	Assignment wallot 		= new Assignment();
	String instituteid 		= (String)session.getValue("instituteid");
	String userid 			= (String)session.getValue("userid");
	HashMap	hashmap			= null;
	String sessionid		= (String)session.getValue("sessionid");
	String sessionname		= (String)session.getValue("sessionname");
	String sectionid		= request.getParameter("section");
	String standardid		= request.getParameter("standard");
	String lessonid			= request.getParameter("lesson");
	String subjectid		= request.getParameter("subject");
	
	ArrayList standardList	= null;
	ArrayList sectionList	= null;
	ArrayList subjectList	= null;
	ArrayList lessonList	= null;
	
	
	
	standardList	= wallot.loadStandardForStaff(userid,sessionid); 
	
	if(standardid != null && !standardid.equals("") && !standardid.equalsIgnoreCase("null")){
		subjectList		= wallot.loadSubjectForStaff(userid,standardid);
	}
	
	if(subjectid != null && !subjectid.equals("") && !subjectid.equalsIgnoreCase("null")){
		sectionList		= wallot.loadSectionForStaff(userid,subjectid);
		lessonList		= wallot.loadLessonForStaff(userid,subjectid);
	}
%>
	<form name='wprkallotment' method='post'>
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>

						<tr>
							<td align='left' >
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								    	
					<th scope="col" class="rounded-company" width="100%"><%=bundle.getString("label.assignmentcreation.AssignmentDetails")%></th>
					<th scope="col" class="rounded-q4" width="1%"></th>

				

								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='2'>							
							
							
											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.AcademicYear") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<%=sessionname %>
													</td>
													
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.StandardName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='standard' validate='Standard' onchange='changeStandard()'>
														<option value='0'>-Select Standard-</option>
														<%
														if(standardList != null && standardList.size()>0){
															for(int y=0;y<standardList.size();y++){
																hashmap		= (HashMap)standardList.get(y);
																
																String groupname = (String) hashmap.get("groupname");
												 				if(groupname==null)
												 					groupname = "";
												 				else
												 					groupname = " - "+groupname;
																if(standardid != null && standardid.equals(""+hashmap.get("standardscheduleid")))
																	out.print("<option selected value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+""+groupname+"</option>");
																else
																	out.print("<option value='"+hashmap.get("standardscheduleid")+"'>"+hashmap.get("standardname")+""+groupname+"</option>");
															}
														}
														%>											
														</select>
													</td>
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.SubjectName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='subject' validate='Subject' onchange='changeSubject()'>
															<option value='0'>-Select Subject-</option>
															<%
															if(subjectList != null && subjectList.size()>0){
																for(int y=0;y<subjectList.size();y++){
																	hashmap		= (HashMap)subjectList.get(y);
																	if(subjectid != null && subjectid.equals(hashmap.get("subjectscheduleid")+""))
																		out.print("<option selected value='"+hashmap.get("subjectscheduleid")+"'>"+hashmap.get("subjectname")+"</option>");
																	else
																		out.print("<option value='"+hashmap.get("subjectscheduleid")+"'>"+hashmap.get("subjectname")+"</option>");
																}
															}
															%>												
														</select>
													</td>
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.LessonName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='lesson' validate='Lesson' >
															<option value='0'>-Select Lesson-</option>
															<%
															if(lessonList != null && lessonList.size()>0){
																for(int y=0;y<lessonList.size();y++){
																	hashmap		= (HashMap)lessonList.get(y);
																	out.print("<option value='"+hashmap.get("lessonscheduleid")+"'>"+hashmap.get("lessonname")+"</option>");
																}
															}
															%>												
														</select>
													</td>
												</tr>
												<tr class='tablebold' height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.SectionName") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
														<select name='section' validate='Section' >
															<option value='0'>-Select Section-</option>
															<%
															if(sectionList != null && sectionList.size()>0){
																for(int y=0;y<sectionList.size();y++){
																	hashmap		= (HashMap)sectionList.get(y);
																	out.print("<option value='"+hashmap.get("sectionscheduleid")+"'>"+hashmap.get("sectionname")+"</option>");
																}
															}
															%>												
														</select>
													</td>
												</tr>
												
											</table>
						
			     						</td>
			     					</tr>
			     				</table>
			     				
								<a href="#" class="bt_blue" onclick='loadExisting()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.assignmentcreation.ViewExisting") %> </strong><span class="bt_blue_r"></span></a>
			     				<a href="#" id="savebut"  class="bt_green" onclick='changeSection()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.assignmentcreation.Create") %></strong><span class="bt_green_r"></span></a>
			     				
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		
		<input type='hidden' name='standardname' 	value=''>
		<input type='hidden' name='sectionname'		value=''>
		<input type='hidden' name='lessonname' 		value=''>
		<input type='hidden' name='subjectname' 	value=''>
		
		
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>