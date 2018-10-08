<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.eventtitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
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

<h2><%=bundle.getString("label.studentsearch.eventrootpath") %></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry"%>

<%
	StudentSearchEntry studentquery = new StudentSearchEntry(); 
	String rollnumber = "";
	//String studentid="";

	 rollnumber=request.getParameter("rollnumber");
	

		HashMap	hashmap				= null;
		ArrayList studentdetails=new ArrayList(); 

		
	
 			
 			HashMap stdmap = null;
 			HashMap secmap = null;
 			ArrayList Studentpersonminidetails=new ArrayList();
 			ArrayList studentidarray=new ArrayList();
 	 		HashMap map = null;
 	 		HashMap studentidmap = null;
 			
 			String sectionid="";
 			String standardid="";
 			String sectionname="";
 			String standardname="";
 			String name="";
 			String groupname = null;
 			String standardscheduleid=""; 
			String sessionname=""; 
			String studentallocationid = null;
 		
			Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)session.getValue("sessionid")); 
			//Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
 			//studentidarray = studentquery.getStudentId(rollnumber);
 			
 			/*
 			 if (studentidarray != null && studentidarray.size() > 0) {
 				studentidmap = (HashMap) studentidarray.get(0);
 				studentid = (String) studentidmap.get("studentid");
 			 }
 			 */
 			 
 			studentallocationid = request.getParameter("studentallocationid");
 			 //out.println(studentallocationid);
 			studentdetails=studentquery.listEventstudentdetails(studentallocationid);
 			 
				
 			 if (Studentpersonminidetails != null && Studentpersonminidetails.size() > 0)
 			 {  
 					

 				map = (HashMap) Studentpersonminidetails.get(0);
 				name = (String) map.get("uname");
 				standardid = (String) map.get("standardid");
 				sectionid = (String) map.get("sectionid");
 				
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
	</table>
	
<br>
	
		<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
			
<tr>
								        	<th scope="col" class="rounded-company" width="1%"></th>
								            <th scope="col" class="rounded" width="5%" ><%=bundle.getString("label.studentsearch.SL.No") %></th>
								            <th scope="col" class="rounded" width="25%" ><%=bundle.getString("label.studentsearch.EventName") %></th>
								            <th scope="col" class="rounded" width="10%" ><%=bundle.getString("label.studentsearch.extracurricularactivity") %></th>
								            <th scope="col" class="rounded" width="15%" ><%=bundle.getString("label.studentsearch.Venu") %></th>
								            <th scope="col" class="rounded" width="20%" ><%=bundle.getString("label.studentsearch.DateOfEvent") %></th>
								          	<th scope="col" class="rounded" width="25%" ><%=bundle.getString("label.studentsearch.AwardDetails") %></th>
								            <th scope="col" class="rounded-q4" width="1%"></th>
								        </tr>
								   </thead>
								   <tfoot>
										<tr>
											<td colspan=7 class="rounded-foot-left"><em></em></td>
											<td class="rounded-foot-right">&nbsp;</td>
											</tr>
									</tfoot>
			
			

   <%
				if(studentdetails.size()>0)
					{
					for(int y=0,z=1;y<studentdetails.size();y++,z++)
								{
									hashmap=(HashMap)studentdetails.get(y);
									out.println("<tr>");
									out.println("<td>");
									out.println("</td>");
									out.println("<td>");
									out.println(z);
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("curriculareventname"));
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("extracurricularname"));
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("venu"));
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("eventdate"));
									out.println("</td>");
									out.println("<td>");
									out.println(hashmap.get("awarddetails"));
									out.println("</td>");
									out.println("<td>");
									out.println("</td>");
									out.println("</tr>");
								}
					}
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr>");
					//out.println("<td colspan=8 align =center>");
					//out.println("Data Not Found");
					//out.println("</td>");
					//out.println("</tr>");
				}

								%>		
								</table>	
							</td>
						</tr>		
    <tfoot>
    	<tr>
        	<td colspan=7  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
   
   
		
				<% 
				%>
		
		  <a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.studentsearch.back") %></strong><span class="bt_blue_r"></span></a>

	
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