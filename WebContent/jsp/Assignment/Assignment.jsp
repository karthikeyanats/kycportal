<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.assignmentcreation.title") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
	var count = 0;
	
	function callCount(obj){
		var pos	= obj.getAttribute("pos");
		if(obj.checked){
			if(check_ForParticularElements(document.workallotment.topic[pos],"text",document.workallotment.mark[pos],"text")){
					
					if(!isNaN(document.workallotment.mark[pos].value)){
						count++;
					}
					else{
						alert("Mark should be a number.");
						document.workallotment.mark[pos].value = "0";
						document.workallotment.mark[pos].focus();
						obj.checked = false;
					}
			}
			else
				obj.checked = false;
		}
		else{
			count--;
		}
 	}


	function goBack(){
		
		document.workallotment.action = "AssignmentCreation.jsp";
		document.workallotment.submit();
	}
	

	
	
	function submitWorks()
	{
		var status = true; 
		if(count >0){
			
			for(var i=0;i<document.workallotment.topics.length;i++){
				if(!document.workallotment.topics[i].checked){
					document.workallotment.topic[i].disabled 		= true;
					document.workallotment.mark[i].disabled 		= true;
					document.workallotment.reference[i].disabled 	= true;
				}
			}
					
			document.workallotment.action = "AssignmentSubmit.jsp";
			document.workallotment.submit();
		}
		else{
			alert("Please select atleast one Topic to Submit");
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

    <h2><%=bundle.getString("label.assignmentcreation.creationrootpath") %></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%
	String sessionid		= (String)session.getValue("sessionid");
	String sessionname		= (String)session.getValue("sessionname");
	String standardid		= request.getParameter("standard");
	String sectionid		= request.getParameter("section");
	String subjectid		= request.getParameter("subject");
	String lessonid			= request.getParameter("lesson");

	String sectionname		= request.getParameter("sectionname");
	String subjectname		= request.getParameter("subjectname");
	String lessonname		= request.getParameter("lessonname");
	String standardname		= request.getParameter("standardname");

	

%>
	<form name='workallotment' method='post' enctype="multipart/form-data">
		<table class="bodyinnercolor" border=0 bordercolor='red' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
			<tr>
				<td width='100%' align='center'>
					<table  border=0 bordercolor='blue' align="center" width="80%" cellspacing=0 cellpadding=0>
						<tr>
							<td align='left' >
							
								<table id="rounded-corner" border=0  width="100%">
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
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.AcademicYear") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=sessionname%>
													</td>
												</tr>	
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Standard") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=standardname%>
													</td>
												</tr>
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Subject") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=subjectname%>
													</td>
												</tr>	
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Lesson") %></td>
													<td  class='tablebold' width='1'>:</td>
													<td  class='tablelight' >
													<%=lessonname%>
													</td>
												</tr>									
												<tr height='23'>
													<td  class='tablebold' width='20%'><%=bundle.getString("label.assignmentcreation.Section") %></td>
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
								        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.assignmentcreation.S.No") %>.</th>
								            <th scope="col" class="rounded" width="40%"><%=bundle.getString("label.assignmentcreation.TopicName") %></th>
								            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.assignmentcreation.Mark") %></th>
								            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.assignmentcreation.File") %></th>
								            <th scope="col" class="rounded-q4" width="10%"><%=bundle.getString("label.assignmentcreation.Check") %></th>
								            
								        </tr>
								    </thead>

									<%
										for(int y=0;y<5;y++){
											%>
											<tr>
												<td><%=y+1%>.</td>
												<td><input type='text' 		name='topic' 		size='50' validate='Assignment Topic'	maxlength='200'></td>
												<td><input type='text' 		name='mark'  		size='4'  validate='Assignment Mark'	maxlength='3'></td>
												<td><input type='file' 		name='reference' 	size='10' 	></td>
												<td><input type='checkbox' 	name='topics' 		pos='<%=y%>' onclick='callCount(this)'></td>
											<%	
										}
									%>
								</table>
							</td>
						</tr>
					</table>
					<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.assignmentcreation.Back") %></strong><span class="bt_blue_r"></span></a>
     				<a href="#" id="savebut"  class="bt_green" onclick='submitWorks()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.assignmentcreation.Submit") %></strong><span class="bt_green_r"></span></a>
				
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
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>