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

function savefun()
{
	if(check_ForParticularElements(document.workallotment.studremarks,"textarea"))
	{
		document.workallotment.action="EvaluateSubmit.jsp";
		document.workallotment.submit();
	}
}

function goBack()
{
	document.workallotment.action="TrackDairy.jsp";
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

    <h2><%=bundle.getString("label.tracking.diaryevaluationrootpath3")%></h2>
    
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Dairy.Dairy"%>
<%

	String studentid				= request.getParameter("studentid");
	Dairy dairy						= new Dairy();
	HashMap	hashmap					= null;
	String sessionid				= request.getParameter("session");
	String standardid				= request.getParameter("standard");
	String sectionid				= request.getParameter("section");
	String subjectid				= request.getParameter("subject");
	String sectionname				= request.getParameter("sectionname");
	String subjectname				= request.getParameter("subjectname");
	String standardname				= request.getParameter("standardname");
	String sessionname				= request.getParameter("sessionname");
	
	String subject					= "";
	String staffname				= "";
	int remain						= 0;
	String workdetails				= "";
	String studentdiarycreateiondate= "";
	String dairysubmissiondate		= "";
	String studentdiaryremarks		= "";
	String dairyid					= request.getParameter("dairyid");
	String dairyname 				= request.getParameter("dairyname");
	ArrayList questionList			= dairy.loadDairySingleStudent(dairyid,studentid);
	String parentremarks			= "";
	String parentdate				= "";
	String staffdiaryreplydate		= "";
	String staffdiaryremarks		= "";
	String studentreplydate			= "";



	if(questionList != null && questionList.size()>0){
		
		hashmap						= (HashMap)questionList.get(0);
		subjectname					= (String)hashmap.get("subjectname");
		subject						= (String)hashmap.get("subject");
		workdetails					= (String)hashmap.get("workdetails");
		studentdiarycreateiondate	= (String)hashmap.get("studentdiarycreateiondate");
		studentdiaryremarks			= (String)hashmap.get("studentdiaryremarks");
		dairysubmissiondate			= (String)hashmap.get("dairysubmissiondate");
		staffname					= (String)hashmap.get("staffname");
		parentremarks				= (String)hashmap.get("parentremarks");
		parentdate					= (String)hashmap.get("parentdate");
		studentreplydate			= (String)hashmap.get("studentreplydate");
		
		if(parentremarks == null)
			parentremarks			= "Not Yet Given";
		else
			parentremarks			+= "<br>"+parentdate;
		
		staffdiaryreplydate			= (String)hashmap.get("staffdiaryreplydate");
		staffdiaryremarks			= (String)hashmap.get("staffdiaryremarks");
		if(staffdiaryremarks == null)
			staffdiaryremarks		= "";
		else
			staffdiaryremarks			+= "<br>"+staffdiaryreplydate;
		
		remain						= 500-staffdiaryremarks.length();



	}%>    
    
    
	<form name='workallotment' method='post'>

							
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.tracking.DiaryDetails")%></th>
		            <th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
					<table  border=0 bordercolor='blue' align="center" width="90%" cellspacing=0 cellpadding=5>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.SessionName")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=sessionname%>
							</td>
						</tr>	
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.StandardName")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=standardname%>
							</td>
						</tr>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.SubjectName")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=subjectname%>
							</td>
						</tr>	
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.SectionName")%></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
							<%=sectionname%>
							</td>
						</tr>	
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.TopicName")%></td>
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
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.tracking.DiaryEvaluationDetails")%></th>
		            <th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
	
					<table align=center cellpadding=3 cellspacing=1 border=0 width="100%">

						<tr height=20 valign="top">
							<td class=tablebold width='17%'><%=bundle.getString("label.tracking.SubjectName")%></td><td class=tablebold width='1%'>:</td><td class=tablelight width='32%'><%=subjectname%></td>
							<td class=tablebold width='15%'><%=bundle.getString("label.tracking.AssignedBy")%></td><td class=tablebold width='1%'>:</td><td class=tablelight width='34%'><%=staffname%></td>
						</tr>
						<tr height=20 valign="top">
							<td class=tablebold><%=bundle.getString("label.tracking.DairyName")%></td><td class=tablebold>:</td><td colspan=4 class=tablelight><%=subject%></td>
						</tr>
						<tr height=20 valign="top">
							<td class=tablebold><%=bundle.getString("label.tracking.Remarks")%></td><td class=tablebold>:</td><td colspan=4 class=tablelight><%=workdetails%></td>
						</tr>
						<tr height=20 valign="top">
							<td class=tablebold><%=bundle.getString("label.tracking.StartDate")%></td><td class=tablebold>:</td><td class=tablelight colspan=1><%=studentdiarycreateiondate%></td>
							<td class=tablebold><%=bundle.getString("label.tracking.EndDate")%></td><td class=tablebold>:</td><td class=tablelight colspan=2><%=dairysubmissiondate%></td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
		<br>
		<%if(studentdiaryremarks != null){ %>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.tracking.StudentRemarks")%></th>
		            <th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>
		    <tr><td colspan='2'><%=studentdiaryremarks%><br><%=studentreplydate%></td></tr>
		 </table>
		<br>
		<%}%>
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		        	<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.tracking.ParentRemarks")%></th>
		            <th scope="col" class="rounded-q4" width="1%"></th>
		        </tr>
		    </thead>
		    <tr><td colspan='2'><%=parentremarks%></td></tr>
		 </table>
		 <br>
		 
		 <%if(staffdiaryremarks.equals("")){%>
		 
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
			    <thead>
			    	<tr>
			        	<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.tracking.FacultyRemarks")%><font color=red>*</font></th>
			            <th scope="col" class="rounded-q4" width="1%"></th>
			        </tr>
			    </thead>
			    <tr><td colspan='2'><textarea rows="5" cols="75" class="tablelight" name="studremarks" validate="Student Remarks" onkeydown="calculateRemaining(this,500,'remaining')" onkeyup="calculateRemaining(this,500,'remaining')" ></textarea><br><span id='remaining'><font color='red'>500 characters remaining</font></span></td></tr>
			 </table>
		 
		 <%}else{%>
		 
			<table id="rounded-corner" border=0 summary="Department List" width="100%">
			    <thead>
			    	<tr>
			        	<th scope="col" class="rounded-company" width="99%"><%=bundle.getString("label.tracking.FacultyRemarks")%></th>
			            <th scope="col" class="rounded-q4" width="1%"></th>
			        </tr>
			    </thead>
			    <tr><td colspan='2'><%=staffdiaryremarks%></td></tr>
			    <tr><td colspan='2'><b>Evaluated On&nbsp;:&nbsp;</b><%=staffdiaryreplydate%></td></tr>
			    
			 </table>
		 
		 <%}%>
		 
			
		<a href="#" class="bt_blue" onclick='goBack()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.tracking.Back")%></strong><span class="bt_blue_r"></span></a>
  			<%if(staffdiaryremarks.equals("")){%>
  			<a href="#" id="savebut"  class="bt_green" onclick='savefun()'><span class="bt_green_lft"></span><strong><%=bundle.getString("button.tracking.Submit")%></strong><span class="bt_green_r"></span></a>
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
		<input type='hidden' name='studentid' 			value='<%=studentid%>'>	
	
	</form>    
    
    

    </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>