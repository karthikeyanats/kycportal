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
<script type="text/javascript" src="<%=request.getContextPath()%>/js/clearselects.js"></script>

<script language='javascript'>

	function changeStandard(){
		
		if(check_ForParticularElements(document.wprkallotment.standard,"select")){
			
			document.wprkallotment.section.options.selectedIndex	= 0;
			document.wprkallotment.subject.options.selectedIndex	= 0;
	
			document.wprkallotment.submit();
		}
	}	
	
	function changeSubject(){
		
		if(check_ForParticularElements(document.wprkallotment.standard,"select",document.wprkallotment.subject,"select")){
			document.wprkallotment.section.options.selectedIndex	= 0;
			
			document.wprkallotment.submit();
		}
	}	
	
	function changeSection(){
		
		if(check_ForParticularElements(document.wprkallotment.standard,"select",document.wprkallotment.subject,"select",document.wprkallotment.section,"select")){
			
			document.wprkallotment.submit();
			
		}
	}		

	function loadExisting(){
	
		if(check_ForParticularElements(document.wprkallotment.standard,"select",document.wprkallotment.subject,"select",document.wprkallotment.section,"select")){
			
			document.wprkallotment.standardname.value	= document.wprkallotment.standard.options[document.wprkallotment.standard.options.selectedIndex].text;
			document.wprkallotment.sectionname.value	= document.wprkallotment.section.options[document.wprkallotment.section.options.selectedIndex].text;
			document.wprkallotment.subjectname.value	= document.wprkallotment.subject.options[document.wprkallotment.subject.options.selectedIndex].text;
			document.wprkallotment.action 				= "TrackDairyTopic.jsp";
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

	<%
	//out.print(session.getValue("usercategory"));
	String sessioncategory = (String)session.getValue("usercategory");
	if(sessioncategory == "HM" || sessioncategory.equals("HM"))	
		out.print("<h2>"+bundle.getString("label.assignment.diaryevaluationrootpath")+"</h2>");
	else
		out.print("<h2>"+bundle.getString("label.tracking.diaryevaluationrootpath")+"</h2>");
	%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Assignment.Assignment,com.iGrandee.Dairy.Dairy"%>
	
<%

	Assignment wallot 		= new Assignment();
	String sessionid		= (String)session.getValue("sessionid");
	String sessionname		= (String)session.getValue("sessionname");
	String userid 			= (String)session.getValue("userid");
	HashMap	hashmap			= null;
	String standardid		= request.getParameter("standard");
	String subjectid		= request.getParameter("subject");
	
	ArrayList standardList	= null;
	ArrayList sectionList	= null;
	ArrayList subjectList	= null;
	
	
	standardList	= wallot.loadStandardForStaff(userid,sessionid); 
	
	if(standardid != null && !standardid.equals("") && !standardid.equalsIgnoreCase("null")){
		subjectList		= wallot.loadSubjectForStaff(userid,standardid);
	}
	
	if(subjectid != null && !subjectid.equals("") && !subjectid.equalsIgnoreCase("null")){
		sectionList		= wallot.loadSectionForStaff(userid,subjectid);
	}
	
%>
	<form name='wprkallotment' method='post'>
							
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
		    <thead>
		    	<tr>
		    		<th scope="col" class="rounded-company" width="85%"><%=bundle.getString("label.tracking.DiaryEvaluationDetails") %></th>
		            <th scope="col" class="rounded-q4" width="15%"><font color=red>*</font><%=bundle.getString("label.common.mandatory") %></th>
		        </tr>
		    </thead>
		    <tr>		
		    	<td colspan='2'>							
					<table  border=0 bordercolor='blue' align="center" width="100%" cellspacing=5 cellpadding=0>
						<tr height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.AcademicYear") %></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
								<%=sessionname %>
							</td>
						</tr>
						<tr class='tablebold' height='23'>
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.Standard") %><font color=red>*</font></td>
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
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.Subject") %><font color=red>*</font></td>
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
							<td  class='tablebold' width='20%'><%=bundle.getString("label.tracking.Section") %><font color=red>*</font></td>
							<td  class='tablebold' width='1'>:</td>
							<td  class='tablelight' >
								<select name='section' validate='Section'>
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
  				
		<a href="#" class="bt_blue" onclick='loadExisting()'><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.tracking.loadtopic") %></strong><span class="bt_blue_r"></span></a>

	
		<input type='hidden' name='standardname' 	value=''>
		<input type='hidden' name='sectionname'		value=''>
		<input type='hidden' name='sessionname' 	value='<%=sessionname%>'>
		<input type='hidden' name='sessionid' 		value='<%=sessionid%>'>
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