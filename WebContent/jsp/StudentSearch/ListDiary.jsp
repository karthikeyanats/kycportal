<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studentsearch.diarytitle") %> | Powered by i-Grandee</title>
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

document.f1.action= "StudentDiary.jsp";
			document.f1.submit();

}
function allotedfun(flag)
{
document.f1.action= "ListDiary.jsp?flag="+flag;
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
<%
 String flag="";
flag=request.getParameter("flag");

				if(flag.equals("alloted"))
				{ 
					out.println("<h2>"+bundle.getString("label.studentsearch.viewdiaryrootpath")+" Student Allotted Diary </h2>");
				}else if(flag.equals("ontime"))
				{
					out.println("<h2>"+bundle.getString("label.studentsearch.viewdiaryrootpath")+" Student On time Diary </h2>");

				}
				else
				{
					out.println("<h2>"+bundle.getString("label.studentsearch.viewdiaryrootpath")+" Student Delayed Diary </h2>");
	
				}
				%>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
 %> <%@ page import="com.iGrandee.StudentSearch.StudentSearchEntry"%>

<%
	StudentSearchEntry studentquery = new StudentSearchEntry(); 
	String rollnumber = "";
	 rollnumber=request.getParameter("rollnumber");
	
 			
 			
 		
 			HashMap NoofAlloteddiarymap = null;
 			ArrayList Studentpersonminidetails=new ArrayList();
 			ArrayList studentidarray=new ArrayList();
 			ArrayList getAllalloteddiaryarray=new ArrayList();
 			ArrayList subjectList = new ArrayList();
 			ArrayList staffList = new ArrayList();
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
 			
 			Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber,(String)(session.getValue("sessionid")));
 			 //Studentpersonminidetails = studentquery.Studentpersonminidetails(rollnumber);
 			//studentidarray = studentquery.getStudentId(rollnumber);
 			
 			
 			 //if (studentidarray != null && studentidarray.size() > 0) {
 				//studentidmap = (HashMap) studentidarray.get(0);
 				//studentid = (String) studentidmap.get("studentid");
 			 //}
 			 
 			 
 			
				String standardscheduleid="";
				String sessionname="";
				String groupname = null;
				String sectionscheduleid = "";
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
 				studentid	= (String) map.get("studentallocationid");
 				sectionscheduleid	= (String) map.get("sectionscheduleid");
 				
 				groupname = (String) map.get("groupname");
 				if(groupname==null)
 					groupname = "";
 				else
 					groupname = " - "+groupname;
 			 }
 			 
 			

//out.prinln(studentid+"__"+sectionscheduleid);
  		//	getAllalloteddiaryarray= studentquery.getAllalloteddiary(studentid,flag);
			getAllalloteddiaryarray= studentquery.getAllalloteddiarynew(studentid,sectionscheduleid,flag);

 			
 
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
				
			</thead>
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
        	<th scope="col" class="rounded-company" width="5"><%=bundle.getString("label.studentsearch.SL.No") %></th>
        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.studentsearch.Alloteddiary") %> </th>
  	        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.studentsearch.StudentRemork") %> </th>
  	        	<th scope="col" class="rounded" width="12%"><%=bundle.getString("label.studentsearch.StudentRemorkDate") %> </th>
  	        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.studentsearch.StaffRemork") %> </th>
  	        	<th scope="col" class="rounded" width="12%"><%=bundle.getString("label.studentsearch.Staff") %>&nbsp;&nbsp; <%=bundle.getString("label.studentsearch.RemorkDate") %> </th>
  	        	<th scope="col" class="rounded" width="15%"><%=bundle.getString("label.studentsearch.ParentRemork") %> </th>
  	        	<th scope="col"class="rounded-q4" width="12%"><%=bundle.getString("label.studentsearch.ParentRemorkDate") %> </th>
  	        	
        	
            
        </tr>
    </thead>
    <%
   
    if (getAllalloteddiaryarray != null && getAllalloteddiaryarray.size() > 0)
    {
    	String subjectScheduleId = "";
    	String staffId = "";
    	for(int i=0,j=1;i<getAllalloteddiaryarray.size();i++,j++)
    	{
    		NoofAlloteddiarymap=(HashMap)getAllalloteddiaryarray.get(i);
    		//out.println(NoofAlloteddiarymap);
    		subjectScheduleId = (String)NoofAlloteddiarymap.get("subjectscheduleid");
    		staffId = (String)NoofAlloteddiarymap.get("createdby");
    		if(!subjectList.contains(subjectScheduleId)){

    			if(i!=0){
	    		out.println("<tr  bgcolor=red>");
	    		out.println("<td colspan=8 style='background-color:#60c8f2'>");
	    		//out.println("&nbsp;");
	    		out.println("</td></tr>");
    			}

    		out.println("<tr>");
    		out.println("<td colspan=8>");
    		out.println("<table border=0 width='100%'><tr><td width='14%' class=tablebold>"+bundle.getString("label.subject.SubjectName")+"</td><td width='2%' class=tablebold > : </td><td width='84%'>"+(String)NoofAlloteddiarymap.get("subjectname")+"</td></tr></table>");
    		//out.println("<td colspan=2 class=tablebold>Subject Name : </td><td colspan=6>"+(String)NoofAlloteddiarymap.get("subjectname")+"</td>");
    		out.println("</td></tr>");
    		}
    		
    		/* if(!staffList.contains(staffId)){    		
    		out.println("<tr>");
    		out.println("<td colspan=8>");
    		out.println("<table width='100%'><tr><td width='14%' class=tablebold>"+bundle.getString("label.workdoneregister.staffname")+"</td><td width='2%' class=tablebold> : </td><td width='84%'>"+(String)NoofAlloteddiarymap.get("staffname")+"</td></tr></table>");
    		//out.println("<td colspan=2 class=tablebold>Staff Name : </td><td colspan=6>"+(String)NoofAlloteddiarymap.get("staffname")+"</td>");
    		out.println("</td></tr>");
    		} */
    		
    		out.println("<tr>");
    		out.println("<td valign=top>"+j+"</td>");
    		out.println("<td valign=top>"+(String)NoofAlloteddiarymap.get("subject")+" <br><a class=tablebold> By :</a><a class=tablelight>"+NoofAlloteddiarymap.get("staffname")+"</td>");
    		String stdremarks=(String)NoofAlloteddiarymap.get("studentdiaryremarks");
    		if(stdremarks == null || stdremarks.equals("") || stdremarks.equals("-") || stdremarks.equalsIgnoreCase("null"))
    			stdremarks="-";
    		else
    			stdremarks=(String)NoofAlloteddiarymap.get("studentdiaryremarks");
    		
    		out.println("<td valign=top>"+stdremarks+"</td>");
    		
    		String stdreplydate=(String)NoofAlloteddiarymap.get("stureplydate");
    		if(stdreplydate == null || stdreplydate.equals("") || stdreplydate.equals("-") || stdreplydate.equalsIgnoreCase("null"))
    			stdreplydate="-";
    		else
    			stdreplydate=(String)NoofAlloteddiarymap.get("stureplydate");
    		
    		 out.println("<td valign=top>"+stdreplydate+"</td>");
    		 
    		 String stafreplyremarks=(String)NoofAlloteddiarymap.get("staffdiaryremarks");
     		if(stafreplyremarks == null || stafreplyremarks.equals("") || stafreplyremarks.equals("-") || stafreplyremarks.equalsIgnoreCase("null"))
     			stafreplyremarks="-";
     		else
     			stafreplyremarks=(String)NoofAlloteddiarymap.get("staffdiaryremarks");
     		
     		 out.println("<td valign=top>"+stafreplyremarks+"</td>");
     		String stafreplydate=(String)NoofAlloteddiarymap.get("stafreplydate"); 
     		if(stafreplydate == null || stafreplydate.equals("") || stafreplydate.equals("-") || stafreplydate.equalsIgnoreCase("null"))
     			stafreplydate="-";
     		else
     			stafreplydate=(String)NoofAlloteddiarymap.get("stafreplydate");
     		
     		 
    		out.println("<td valign=top>"+stafreplydate+"</td>");
    		
    		
    		String parentremarks=(String)NoofAlloteddiarymap.get("parentremarks"); 
     		if(parentremarks == null || parentremarks.equals("") || parentremarks.equals("-") || parentremarks.equalsIgnoreCase("null"))
     			parentremarks="-";
     		else
     			parentremarks=(String)NoofAlloteddiarymap.get("parentremarks");
     		
     		 
    		out.println("<td valign=top>"+parentremarks+"</td>");
    		
    		String parentreplydate=(String)NoofAlloteddiarymap.get("parentreplydate"); 
     		if(parentreplydate == null || parentreplydate.equals("") || parentreplydate.equals("-") || parentreplydate.equalsIgnoreCase("null"))
     			parentreplydate="-";
     		else
     			parentreplydate=(String)NoofAlloteddiarymap.get("parentreplydate");
     		
     		 
    		out.println("<td valign=top>"+parentreplydate+"</td>");


    		out.println("</tr>");
    		
    		subjectList.add(subjectScheduleId);
    		staffList.add(staffId);
    	}
    }
    else
    {
    	out.println("<tr align='center' class='tablebold'><td colspan='8'><font color='red'>Data Not Found</font></td></tr>");
        		//out.println("<td colspan=8 align='center'>Data Not Found</td>");
    }
   
    %>
    <tfoot>
    	<tr>
        	<td colspan=7  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
   
   
		
				<% 
				%>
		</table>
		
		</td>
	</tr>
	</table>
	
	
						</table>
				</tbody>
			</table>
			</td>
	</tr>
	</table>
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