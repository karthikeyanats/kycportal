<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.assignmentcreation.updatetitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
	
	function goBack(){
		
		document.workallotment1.action = "AssignmentView.jsp";
		document.workallotment1.submit();
	}

	function updateQuestion(){

		if(check_ForParticularElements(document.workallotment.topic,"text",document.workallotment.mark,"text")){
		
			if(isNaN(document.workallotment.mark.value)){

				alert("Mark should be a number.");
				document.workallotment.mark.value = "0";
				document.workallotment.mark.focus();
				return false;
			}
		
			document.workallotment.action = "UpdateSubmit.jsp";
			document.workallotment.submit();
		}
	}
	
	function deleteQuestion(){
		
		document.workallotment1.action = "DeleteSubmit.jsp";
		document.workallotment1.submit();
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

    <h2><%=bundle.getString("label.assignmentcreation.updaterootpath") %></h2>

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
	
	Assignment	assignment	= new Assignment();
	HashMap	hashmap			= null;
	ArrayList questionList	= assignment.loadQuestionsSingle(questionid);

	

%>
	<form name='workallotment' method='post' enctype="multipart/form-data">
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' >
							
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.assignmentcreation.AssignmentDetails") %></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
								    <tr>		
								    	<td colspan='2'>							
											<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=5 cellpadding=0>
			
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Session") %> </td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=sessionname%>
													</td>
												</tr>	
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Standard") %> </td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=standardname%>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Subject") %> </td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=subjectname%>
													</td>
												</tr>	
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Lesson") %> </td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=lessonname%>
													</td>
												</tr>									
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Section") %> </td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=sectionname%>
													</td>
												</tr>									
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr height='10'>
							<td align='left'>
							</td>
						</tr>					
						<tr>
							<td align='left'>
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.assignmentcreation.UpdateQuestion") %></th>
								            <th scope="col" class="rounded-q4" width="2%"></th>
								        </tr>
								    </thead>
									<tr>
										<td colspan='2'>
											<table border=0 summary="Department List" width="100%">
											
												<%
													String file			= "";
													if(questionList != null && questionList.size()>0){
														for(int y=0;y<questionList.size();y++){
															hashmap		= (HashMap)questionList.get(y);
															file		= (String)hashmap.get("file");
															out.print("<tr><td class=tablebold>"+bundle.getString("label.assignmentcreation.TopicName")+"</td><td class=tablebold>:</td><td><input type='text' name='topic' value='"+hashmap.get("questionname")+"' size='50' maxlength='200'></tr>");
															out.print("<tr><td class=tablebold>"+bundle.getString("label.assignmentcreation.Mark")+"</td><td class=tablebold>:</td><td><input type='text' name='mark' value='"+hashmap.get("mark")+"' size='4' maxlength='3'></td></tr>");
															out.print("<tr><td class=tablebold>"+bundle.getString("label.assignmentcreation.Reference")+"</td><td class=tablebold>:</td><td><input type='file' name='reference' </td></tr>");
															
															out.print("<tr class=tablebold><td>"+bundle.getString("label.assignmentcreation.Exisitng")+"</td><td class=tablebold>:</td>");
																
															if(file != null && !file.equals("-"))
																out.print("<td><a href='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+file+"' target='_new'>View</a></td></tr>");
															else
																out.print("<td>-</td></tr>");
														}
													}
													else{
														out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
														//out.print("<tr><td colspan='3'>No Data Found</td></tr>");
													}
												%>
											</table>
										</td>
									</tr>
								</table>
							</td>
						</tr>
					</table>
			     	
			     	
			     	
			     	<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%= bundle.getString("button.assignmentcreation.Back")%></strong><span class="bt_blue_r"></span></a>
			     	<a href="#" class="bt_red" onclick='deleteQuestion()'><span class="bt_red_lft"></span><strong><%= bundle.getString("button.assignmentcreation.Delete")%></strong><span class="bt_red_r"></span></a>
     				<a href="#" id="savebut"  class="bt_green" onclick='updateQuestion()'><span class="bt_green_lft"></span><strong><%= bundle.getString("button.assignmentcreation.Update")%></strong><span class="bt_green_r"></span></a>

				</td>
			</tr>
		</table>
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
		<input type='hidden' name='oldfile' 			value='<%=file%>'>
		
	</form>
	<form name='workallotment1' method='post'>
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
	
	</form>

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>