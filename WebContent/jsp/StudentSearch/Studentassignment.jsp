<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.assignmenttitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
document.f1.submit();

}

	function loadSubmitted(obj){
	
		document.f1.subjectscheduleid.value	= obj.getAttribute("subjectscheduleid");
		document.f1.status.value				= obj.getAttribute("status");
		document.f1.subjectname.value		= obj.getAttribute("subjectname");
		document.f1.action					= "./StudentAssignmentList.jsp";
		document.f1.submit();
	}
	


</script>
</head>
<body>
<div id="main_container">

<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.studentsearch.assignmentrootpath") %></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry,com.iGrandee.Assignment.AssignmentStudent"%>

<%
	String date_str = "";
	StudentSearchEntry studentquery = new StudentSearchEntry(); 
	String rollnumber = "";
	 rollnumber=request.getParameter("rollnumber");
	
	 AssignmentStudent	assignment	= new AssignmentStudent();
 			
 			
 			ArrayList Studentpersonminidetails=new ArrayList();
 			ArrayList standardarray=new ArrayList();
 			ArrayList studentidarray=new ArrayList();
 	 		HashMap map = null;
 	 		HashMap studentidmap = null;
 	 		HashMap getAllalloteddiarymap = null;
 			
 			String sectionid="";
 			String standardid="";
 			String sectionname="";
 			String standardname="";
 			String name="";
 			String studentid="";
 			String diarystate="";
 			int Delayed=0;
 			int ontime=0;
 			String alloted="";
 			Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)session.getValue("sessionid"));
 			//Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
 			
 			 /*studentidarray = studentquery.getStudentId(rollnumber);
 			
 			
 			 if (studentidarray != null && studentidarray.size() > 0) {
 				studentidmap = (HashMap) studentidarray.get(0);
 				studentid = (String) studentidmap.get("studentid");
 			 }*/
 			 
 			 
 			String standardscheduleid="";
 			String sessionname="";
 			String groupname = null;
 			 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0) {
 					

 				map = (HashMap) Studentpersonminidetails.get(0);
 				name = (String) map.get("uname");
 				studentid = (String) map.get("studentallocationid");
 				standardid = (String) map.get("standardid");
 				sectionid = (String) map.get("sectionscheduleid");
 				
 				standardname = (String) map.get("standardname");
 				sectionname = (String) map.get("sectionname");
 				standardscheduleid = (String) map.get("standardscheduleid");
 				sessionname = (String) map.get("sessionname");
 				groupname = (String) map.get("groupname");
 				if(groupname==null)
 					groupname = "";
 				else
 					groupname = " - "+groupname;

 			 }
 			 

 			ArrayList questionList=new ArrayList();
 			HashMap	hashmap					= null;
			//out.println(sectionid+"__"+studentid);
 			ArrayList subjectList=assignment.loadAssignmentViewForStudentConsolidated(sectionid,studentid);
 			ArrayList staffList				= null;
			
 			
 			
 %>
<form name="f1" method="post" action="">
<input type="hidden" name="rollnumber" value="<%=rollnumber %>">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
	<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="25%"><%=bundle.getString("label.studentsearch.hometableheading") %></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded" width="23%"></th>
					<th scope="col" class="rounded" width="25%"></th>
					<th scope="col" class="rounded" width="1%"></th>
					<th scope="col" class="rounded-q4" width="25%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=5 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
				</tfoot>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.rollno") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=rollnumber%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.studentname") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=name%></td>
				</tr>
				<tr>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.academicyear") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=sessionname%></td>
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.standard") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=standardname%><%=groupname %></td>
				</tr>
				<tr>
					
					<td class="tablebold" width="20%"><%=bundle.getString("label.studentsearch.section") %> </td><td class="tablebold" width="1%">:</td>
					<td class="tablelight" colspan=4 width="20%"><%=sectionname%></td>
				</tr>
				
				</table>
		</td>
	</tr>

<Tr height ="20" ><td></td></Tr>	

	<tr>
							<td align='left'>
							
								<table id="rounded-corner" border=0 summary="Department List" width="100%">
								    <thead>
								    	<tr>
								        	<th scope="col" class="rounded-company" width="5%">S.No</th>
								            <th scope="col" class="rounded" width="30%">Subject Name</th>
								            <th scope="col" class="rounded" width="30%">Staff Name</th>
								            <th scope="col" class="rounded" width="10%">Assigned</th>
								            <th scope="col" class="rounded" width="10%">Submitted</th>
								            <th scope="col" class="rounded-q4" width="15%">Yet to Submit</th>
								        </tr>
								    </thead>
									
									<%
										String subjectscheduleid		= "";
										HashMap hashmap1				= null;
										int assigned					= 0;
										int submitted					= 0;
										int yettosubmit					= 0;
										
										if(subjectList != null && subjectList.size()>0){
											
											for(int y=0;y<subjectList.size();y++){
												hashmap				= (HashMap)subjectList.get(y);
												
												subjectscheduleid	= (String)hashmap.get("subjectscheduleid");
												
												if(hashmap.get("assigned") == null)
													assigned	= 0;
												else
													assigned	= Integer.parseInt((String)hashmap.get("assigned"));
													
												if(hashmap.get("submitted") == null)
													submitted	= 0;
												else
													submitted	= Integer.parseInt((String)hashmap.get("submitted"));
												
												
												staffList			= assignment.loadStaffForStudentConsolidated(sectionid,subjectscheduleid);
												
												out.print("<tr><td>"+(y+1)+".</td><td>"+hashmap.get("subjectname")+"</td>");
												out.print("<td><table>");
												if(staffList != null && staffList.size()>0){
													for(int k=0;k<staffList.size();k++){
														hashmap1	= (HashMap)staffList.get(k);
														out.print("<tr><td>"+hashmap1.get("staffname")+"</td></tr>");
													}
												}
												else
													out.print("<tr><td>Not Yet Allotted</td></tr>");
												out.print("</table></td>");
												
												if(assigned == 0)
													out.print("<td>"+assigned+"</td>");
												else
													out.print("<td><a href='#cls' subjectname='"+hashmap.get("subjectname")+"' subjectscheduleid='"+subjectscheduleid+"' status='A' onClick='loadSubmitted(this)'><font color='blue' size='5'>"+assigned+"</font></a></td>");

												if(submitted == 0)
													out.print("<td>"+submitted+"</td>");
												else
													out.print("<td><a href='#cls' subjectname='"+hashmap.get("subjectname")+"' subjectscheduleid='"+subjectscheduleid+"' status='S' onClick='loadSubmitted(this)'><font color='green' size='5'>"+submitted+"</font></a></td>");
												
												yettosubmit		= assigned-submitted;
												
												if(yettosubmit <= 0)
													out.print("<td>0</td>");
												else
													out.print("<td><a href='#cls' subjectname='"+hashmap.get("subjectname")+"' subjectscheduleid='"+subjectscheduleid+"' status='Y' onClick='loadSubmitted(this)'><font color='red' size='5'>"+yettosubmit+"</font></a></td>");
												
												out.print("</tr>");
											}
										}
										else{
											out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
											//out.print("<tr><td colspan='6'>Data Not Found</td></tr>");
										}
									%>
								</table>
							</td>
						</tr>
		
</TABLE>
	
	
	

		  <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentsearch.back") %></strong><span class="bt_blue_r"></span></a>
	<input type='hidden' name='assignmentid' 		value=''>
		<input type='hidden' name='subjectscheduleid'	value=''>
		<input type='hidden' name='status'				value=''>
		<input type='hidden' name='assignmentid_flage' 	value='multiassignment'>
		<input type='hidden' name='subjectname'			value=''>
		
		
		
	
</form>
</div>
<!-- end of right content--></div>
<!--end of center content -->
<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>
</div>
</body>
</html>