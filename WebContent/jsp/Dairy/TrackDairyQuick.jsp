<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.tracking.diaryevaluationtitle") %> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script language='javascript'>
	

	
	function callEvaluate(obj){
		
		document.workallotment.studentid.value 	= obj.getAttribute("studentid");
		document.workallotment.action 			= "EvaluateDairy.jsp";
		document.workallotment.submit();
	}	
	
	function goBack(){
		
		document.workallotment.action = "TrackDairyTopic.jsp";
		document.workallotment.submit();
	}
	
	function submitRemarks(){
	
		document.workallotment.action = "QuickDairySubmit.jsp";
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

    <h2><%=bundle.getString("label.tracking.diaryevaluationrootpath4") %></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy"%>
<%
	
	String sessionid		= request.getParameter("session");
	String standardid		= request.getParameter("standard");
	String sectionid		= request.getParameter("section");
	String subjectid		= request.getParameter("subject");
	String sectionname		= request.getParameter("sectionname");
	String subjectname		= request.getParameter("subjectname");
	String standardname		= request.getParameter("standardname");
	String sessionname		= request.getParameter("sessionname");
	String dairyid			= request.getParameter("dairyid");
	String dairyname		= request.getParameter("dairyname");
	Dairy	dairy			= new Dairy();
	HashMap	hashmap			= null;
	ArrayList questionList	= dairy.loadDairyOnlySubmitted(dairyid);

	

%>
	<form name='workallotment' method='post'>
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.tracking.DiaryDetails") %></th>
		            <th scope="col" class="rounded-q4" width="2%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
	
					<table  border=0 bordercolor='blue' align="center" width="100%" cellspacing=0 cellpadding=5>

						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.AcademicYear") %> </td>
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
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.SectionName") %></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=sectionname%>
							</td>
						</tr>	
						<tr height='23'>
							<td  class='tablebold' width='20%'>Diary Name</td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=dairyname%>
							</td>
						</tr>	
					</table>
				</td>
			</tr>
		</table>

		<br>
								
		<table border='1' summary="Department List" width="100%" cellspacing='0' cellpadding='5'>
	    	<tr class='tableheading'>
	        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.tracking.SL.No") %></th>
	            <th scope="col" class="rounded" width="15%"><%=bundle.getString("label.tracking.StudentName") %> </th>
	            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.tracking.StudentRemark") %></th>
	            <th scope="col" class="rounded" width="25%"><%=bundle.getString("label.tracking.ParentRemark") %></th>
	            <th scope="col" class="rounded-q4" width="30%"><%=bundle.getString("label.tracking.FacultyRemark") %></th>

			<%
				int vount	= 0;
				if(questionList != null && questionList.size()>0){
					for(int y=0;y<questionList.size();y++){
						hashmap		= (HashMap)questionList.get(y);
						out.print("<tr><td valign='top'>"+(y+1)+".</td><td valign='top'>"+hashmap.get("studentname")+"</td>");
						
						if(hashmap.get("studentdiaryremarks") == null){
							out.print("<td valign='top'>Not Submitted</td>");
						}
						else{
							out.print("<td  valign='top'>"+hashmap.get("studentdiaryremarks")+"<br>"+hashmap.get("studentreplydate")+"</td>");
						}
						
						if(hashmap.get("parentremarks") == null){
							out.print("<td valign='top'>Not Given</td>");
						}
						else{
							out.print("<td >"+hashmap.get("parentremarks")+"<br>"+hashmap.get("parentdate")+"</td>");
						}												
						
						if(hashmap.get("staffdiaryremarks") == null){ 
							vount++;
							out.print("<td valign='top'><input type='hidden' name='replyid' value='"+hashmap.get("studentdiaryreplyid")+"'><input type='hidden' name='studentid' value='"+hashmap.get("studentid")+"'><textarea name='staffremark' class=tablelight rows=3 cols=30 validate='Staff Remark' onKeyPress=calculateRemaining(this,500,'remaining"+y+"') onKeyUp=calculateRemaining(this,500,'remaining"+y+"')></textarea><br><span id='remaining"+y+"'><font color='red'>500 Characters Remaining</font></span></td></tr>");
						}
						else{
							out.print("<td valign='top'>"+hashmap.get("staffdiaryremarks")+"<br>"+hashmap.get("staffdiaryreplydate")+"</td></tr>");
						}
						
					}
				}
				else{
					out.print("<tr align='center' class='tablebold'><td colspan='7'><a class='nodata'>Data Not Found</a></td></tr>");
				}
			%>
		</table>
								
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.tracking.Back") %></strong><span class="bt_blue_r"></span></a>

		<%if(vount >0){%>

			<a href="#" class="bt_green" onclick='submitRemarks()'><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
		<%}%>
		
		<input type='hidden' name='session' 			value='<%=sessionid%>'>
		<input type='hidden' name='sessionname' 		value='<%=sessionname%>'>
		<input type='hidden' name='section' 			value='<%=sectionid%>'>
		<input type='hidden' name='subject' 			value='<%=subjectid%>'>
		<input type='hidden' name='standard' 			value='<%=standardid%>'>
		<input type='hidden' name='standardname' 		value='<%=standardname%>'>
		<input type='hidden' name='subjectname' 		value='<%=subjectname%>'>
		<input type='hidden' name='sectionname' 		value='<%=sectionname%>'>
		<input type='hidden' name='dairyid' 			value='<%=dairyid %>'>
		<input type='hidden' name='dairyname' 			value='<%=dairyname %>'>
		
		<input type='hidden' name='studentid' 			disabled>
		<input type='hidden' name='staffremark' 		disabled>
		
		
	</form>


    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>