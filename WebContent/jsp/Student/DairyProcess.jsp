<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - My Diary | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>

function savefun(){

	if(check_ForParticularElements(document.workallotment.studremarks,"textarea")){
	
		document.workallotment.action="DairySubmit.jsp";
		document.workallotment.submit();
	}
}

function goBack(){


	document.workallotment.action="Dairyview.jsp";
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

    <h2><%=bundle.getString("label.diary.studentroot1")%></h2>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy"%>
<%
	String sectionid				= (String)session.getValue("sectionscheduleid");
	String studentid				= (String)session.getValue("studentid");
	Dairy dairy						= new Dairy();
	HashMap	hashmap					= null;
	
	String subject					= "";
	String staffname				= "";
	String subjectname				= "";
	int remain						= 0;
	String workdetails				= "";
	String studentdiarycreateiondate= "";
	String dairysubmissiondate		= "";
	String studentdiaryremarks		= "";
	
	String staffdiaryremarks		= "";
	String staffdiaryreplydate		= "";
	String parentdate				= "";
	String parentremarks			= "";
	String studentreplydate			= "";
	
	
	String dairyid					= request.getParameter("dairyid");
	ArrayList questionList			= dairy.loadDairySingleStudentSubject(dairyid,studentid);
	
	if(questionList != null && questionList.size()>0){
		
		hashmap						= (HashMap)questionList.get(0);
		subjectname					= (String)hashmap.get("subjectname");
		subject						= (String)hashmap.get("subject");
		workdetails					= (String)hashmap.get("workdetails");
		studentdiarycreateiondate	= (String)hashmap.get("studentdiarycreateiondate");
		studentdiaryremarks			= (String)hashmap.get("studentdiaryremarks");
		
		staffdiaryremarks			= (String)hashmap.get("staffdiaryremarks");
		staffdiaryreplydate			= (String)hashmap.get("staffdiaryreplydate");
		parentdate					= (String)hashmap.get("parentdate");
		parentremarks				= (String)hashmap.get("parentremarks");
		studentreplydate			= (String)hashmap.get("studentreplydate");

		if(staffdiaryremarks == null)
			staffdiaryremarks		= "";
		
		if(parentremarks == null)
			parentremarks			= "";

		if(studentdiaryremarks == null)
			studentdiaryremarks		= "";
		

		remain						= 500-studentdiaryremarks.length();
		dairysubmissiondate			= (String)hashmap.get("dairysubmissiondate");
		staffname					= (String)hashmap.get("staffname");

	}%>    
    
	<form name='workallotment' method='post'>
	
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diary.DairyDetails")%></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
			<tr>
				<td colspan='2'>							
					<table align=center cellpadding=5 cellspacing=0 width="100%">

						<tr height=20>
							<td class=tablebold width='17%'><%=bundle.getString("label.diary.SubjectName")%></td><td class=tablebold width='1%'>:</td><td class=tablelight ><%=subjectname%></td>
							<td class=tablebold width='12%'><%=bundle.getString("label.diary.AssignedBy")%></td><td class=tablebold>:</td><td class=tablelight ><%=staffname%></td>
						</tr>
						<tr height=20>
							<td class=tablebold><%=bundle.getString("label.diary.DairyName")%></td><td class=tablebold>:</td><td colspan=3 class=tablelight><%=subject%></td>
						</tr>
						<tr height=20>
							<td class=tablebold><%=bundle.getString("label.diary.Remarks")%></td><td class=tablebold>:</td><td colspan=3 class=tablelight><%=workdetails%></td>
						</tr>
						<tr height=20>
							<td class=tablebold><%=bundle.getString("label.diary.DairyDate")%></td><td class=tablebold>:</td><td class=tablelight><%=studentdiarycreateiondate%></td>
							<td class=tablebold><%=bundle.getString("label.diary.EndDate")%></td><td class=tablebold>:</td><td class=tablelight ><%=dairysubmissiondate%></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
						
		<%
			if(studentdiaryremarks == null || studentdiaryremarks.equals("")){
		%>
						
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
			    <thead>
			    	<tr>
			
			            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diary.StudentRemarks")%><font color='red'>*</font></th>
			            <th scope="col" class="rounded-q4" width="2%"></th>
			        </tr>
			    </thead>
				<tr>
					<td colspan='2'>							
						<input type=hidden name='tempann' value='500'><textarea rows="5" cols="75" class="tablelight" name="studremarks" validate="Student Remarks" onkeydown="calculateRemaining(this,500,'remaining')" onkeyup="calculateRemaining(this,500,'remaining')" ><%=studentdiaryremarks%></textarea><br><span id='remaining'><font color='red'>500 characters remaining</font></span>
					</td>
				</tr>
			</table>
			
				
		<%}else{ %>
		
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
			    <thead>
			    	<tr>
			
			            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diary.StudentRemarks")%> on <%=studentreplydate%></th>
			            <th scope="col" class="rounded-q4" width="2%"></th>
			        </tr>
			    </thead>
				<tr>
					<td colspan='2'>							
						<%=studentdiaryremarks%>					
					</td>
				</tr>
			</table>

		<%} %>
		
		
		<%
			if(parentremarks != null && !parentremarks.equals("")){
		%>
						
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
			    <thead>
			    	<tr>
			
			            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diary.ParentRemarks")%> on <%=staffdiaryreplydate%></th>
			            <th scope="col" class="rounded-q4" width="2%"></th>
			        </tr>
			    </thead>
				<tr>
					<td colspan='2'>							
						<%=parentremarks %>
					</td>
				</tr>
			</table>
			
		<%}%>
		
		
		<%
			if(staffdiaryremarks != null && !staffdiaryremarks.equals("")){
		%>
						
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
			    <thead>
			    	<tr>
			
			            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.diary.StaffRemarks")%> on <%=parentdate%><font color='red'>*</font></th>
			            <th scope="col" class="rounded-q4" width="2%"></th>
			        </tr>
			    </thead>
				<tr>
					<td colspan='2'>							
						<%=staffdiaryremarks %>
					</td>
				</tr>
			</table>
				
		<%}%>
						
		         							
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.diary.Back")%></strong><span class="bt_blue_r"></span></a>
		
		<% 
		if(studentdiaryremarks == null || studentdiaryremarks.equals("")){
  		%>
  			<a href="#" id="savebut"  class="bt_green" onclick='savefun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.diary.Submit")%></strong><span class="bt_green_r"></span></a>
		<%} %>
							
	
		<input type='hidden' name='dairyid' 	value='<%=dairyid%>'/>
		
	</form>    
    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>