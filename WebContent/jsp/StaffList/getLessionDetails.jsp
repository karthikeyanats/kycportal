<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.lessonlist.viewtitle") %> | Powered by i-Grandee</title>
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

function goback()
{

document.f1.action="StudentSyllabus.jsp";
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
<h2><%=bundle.getString("label.lessonlist.viewrootpath") %> </h2>

<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
	 %> <%@ page import="com.iGrandee.StaffList.StaffEntry"%>

	 <%
	 StaffEntry studentquery = new StaffEntry(); 

ArrayList SyllabusDetails=new ArrayList();
HashMap SyllabusDetailsmap=null;
	String sectionscheduleid	= (String)session.getValue("sectionscheduleid");
	String subjectid	= request.getParameter("subjectid");
	String subjectname	= request.getParameter("subjectname");

	SyllabusDetails=studentquery.ListLessionForStudent(subjectid);

%>
<form name="f1" method="post" action="">
<input type="hidden" name="subjectid">
	<table id="rounded-corner" border=0  width="100%" align="center">
		<thead>
			<tr>
				<th scope="col" class="rounded-company" width="99%" ><%=bundle.getString("label.schedule.selectedinfo")%></th>
				<th scope="col" class="rounded-q4" width="1%"></th>
			</tr>
		</thead>
		<tfoot>
		<tr>
		<td class="rounded-foot-left"><em></em></td>
		<td class="rounded-foor-right">&nbsp;</td>
		</tr>
		</tfoot>
		<tbody>
    			<tr>
    			<td colspan=2>
    			<table width="100%" border=0>
    			<tr>
    			<td width="15%" class=tablebold ><%=bundle.getString("label.schedule.subjectname")%></td>
    			<td width="1%" class=tablebold>:</td>
    			<td class=tablelight><%=subjectname %></td>
    			</tr>
    			</table></td></tr>
    			</tbody>
    			</table>
    			
		
		 <%
	if(session.getValue("usercategory").equals("P")){%> 
		<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.lessonlist.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.lessonlist.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.lessonlist.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.lessonlist.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.lessonlist.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.lessonlist.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.lessonlist.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.lessonlist.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.lessonlist.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.lessonlist.SubjectName")+"</td><td class='tablebold'>:</td><td>"+subjectname + "</td></tr>");

									out.print("</table>");  
								%>	
							</td>
						</tr>
					</table>	
					<%} %>
					<br>
					
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.lessonlist.slno") %></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.lessonlist.lessonname") %>  </th>
        	<th scope="col" class="rounded-q4" width="50%"><%=bundle.getString("label.lessonlist.lessondescription") %>  </th>
  	        	
  	        	
        	
            
        </tr>
    </thead>
    <%
   
    %>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
   
   
		
				<% 
				if(SyllabusDetails!=null && SyllabusDetails.size()>0)
				{
					for(int i=0,j=1;i<SyllabusDetails.size();i++,j++)
					{
						out.print("<tr >");
						SyllabusDetailsmap=(HashMap)SyllabusDetails.get(i);
						out.print("<td >"+j+"</td>");
						out.print("<td >"+SyllabusDetailsmap.get("lessonname")+"</td>");

						String lessondescription=(String)SyllabusDetailsmap.get("lessondescription");
						if(lessondescription == null || lessondescription.equals("") || lessondescription.equals("-") || lessondescription.equalsIgnoreCase("null"))
							lessondescription="-";
						else
							lessondescription=(String)SyllabusDetailsmap.get("lessondescription");
						
						out.print("<td>"+lessondescription+"</td>");
						out.print("</tr>");
					}
				}
				else
				{
					out.println("<td colspan='3' align=center><font color='red'><b>Data Not Found</b></font></td>");
					//out.print("<td colspan=3 align=center >Data Not Found</td>");
	
				}
				%>
		</table>
		

		  <a href="#" onclick="goback()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.lessonlist.back") %> </strong><span class="bt_blue_r"></span></a>

	
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