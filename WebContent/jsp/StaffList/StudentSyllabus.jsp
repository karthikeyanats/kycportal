<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.syllabuslist.viewtitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script language='javascript'>


function getLessionDetails(obj)
{

document.f1.subjectid.value=obj.getAttribute("subjectids");
document.f1.subjectname.value=obj.getAttribute("subjectname");
document.f1.action="getLessionDetails.jsp";
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
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> <%
 
	 %> <%@ page import="com.iGrandee.StaffList.StaffEntry"%>

	 <%
	 StaffEntry studentquery = new StaffEntry();  
	ArrayList SyllabusDetails=new ArrayList();
	HashMap SyllabusDetailsmap=null;
	String standardscheduleid	= (String)session.getValue("standardscheduleid");
	SyllabusDetails=studentquery.ListSyllabusForStudent(standardscheduleid);

%>
<form name="f1" method="post" action="">
<input type="hidden" name="subjectid">
<input type="hidden" name="subjectname">
<h2> <%=bundle.getString("label.syllabuslist.viewrootpath") %> </h2>

 <%
	if(session.getValue("usercategory").equals("P")){%> 
					<table id="rounded-corner" border=0 summary="Department List" width="100%">
					    <thead>
					    	<tr>
					        	
					            <th scope="col" class="rounded-company" width="98%"><%=bundle.getString("label.syllabuslist.StudentDetails") %></th>
					            <th scope="col" class="rounded-q4" width="2%"></th>
					        </tr>
					    </thead>
					    <tr>		
					    	<td colspan='2'>					
				
								<%
									out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'>");
									out.print("<tr><td width='17%' class='tablebold'>"+bundle.getString("label.syllabuslist.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td>"+session.getValue("studentname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.syllabuslist.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
									if(session.getValue("groupname") == null)
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.syllabuslist.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td></tr>");
									else
										out.print("<tr><td class='tablebold'>"+bundle.getString("label.syllabuslist.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.syllabuslist.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.syllabuslist.BoardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.syllabuslist.MediumName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("mediumname")+"</td></tr>");
									out.print("<tr><td class='tablebold'>"+bundle.getString("label.syllabuslist.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");

									out.print("</table>"); 
								%>	
							</td>
						</tr>
					</table>					<br>

					<%} %>
					
	
<br>
	
		<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.syllabuslist.slno") %></th>
        	<th scope="col" class="rounded" width="40%"><%=bundle.getString("label.syllabuslist.subjectname") %>  </th>
        	<th scope="col" class="rounded" width="30%"><%=bundle.getString("label.syllabuslist.subjectcode") %> </th>
        	 <th scope="col" class="rounded-q4" width="20%"><%=bundle.getString("label.syllabuslist.subjecttype") %> </th>
        	
        	<!--<th scope="col" class="rounded" width="10%">Theoryinternalmin   </th>
        	<th scope="col" class="rounded" width="10%">Theoryinternalmax  </th>
        	<th scope="col" class="rounded" width="10%">theoryexternalmin  </th>
        	<th scope="col" class="rounded-q4" width="10%">theoryexternalmax  </th>  -->
  	        	
  	        	
        	
            
        </tr>
    </thead>
    <%
   
    %>
    <tfoot>
    	<tr>
        	<td colspan=3  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
        </tr>
    </tfoot>
   
   
		
				<% 
				if(SyllabusDetails!=null && SyllabusDetails.size()>0)
				{//c.subjectid,c.subjectname,c.subjectcode,d.subjectypename,b.theoryinternalmin,b.theoryexternalmax, b.theoryexternalmin,b.theoryexternalmax
					for(int i=0,j=1;i<SyllabusDetails.size();i++,j++)
					{
						out.print("<tr >");
						SyllabusDetailsmap=(HashMap)SyllabusDetails.get(i);
						out.print("<td >"+j+"</td>");
						out.print("<td ><a href='#' subjectids='"+SyllabusDetailsmap.get("subjectid")+"' subjectname='"+SyllabusDetailsmap.get("subjectname")+"' onclick=getLessionDetails(this) >"+SyllabusDetailsmap.get("subjectname")+"</td>");
						out.print("<td >"+SyllabusDetailsmap.get("subjectcode")+"</td>");
						out.print("<td >"+SyllabusDetailsmap.get("subjectypename")+"</td>");

						String theoryinternalmin=(String)SyllabusDetailsmap.get("theoryinternalmin");
						if(theoryinternalmin == null || theoryinternalmin.equals("") || theoryinternalmin.equals("-") || theoryinternalmin.equalsIgnoreCase("null"))
							theoryinternalmin="-";
						else
							theoryinternalmin=(String)SyllabusDetailsmap.get("theoryinternalmin");
						String theoryinternalmax=(String)SyllabusDetailsmap.get("theoryinternalmax");
						if(theoryinternalmax == null || theoryinternalmax.equals("") || theoryinternalmax.equals("-") || theoryinternalmax.equalsIgnoreCase("null"))
							theoryinternalmax="-";
						else
							theoryinternalmax=(String)SyllabusDetailsmap.get("theoryinternalmax");
						
						String theoryexternalmin=(String)SyllabusDetailsmap.get("theoryexternalmin");
						if(theoryexternalmin == null || theoryexternalmin.equals("") || theoryexternalmin.equals("-") || theoryexternalmin.equalsIgnoreCase("null"))
							theoryexternalmin="-";
						else
							theoryinternalmin=(String)SyllabusDetailsmap.get("theoryexternalmax");
						String theoryexternalmax=(String)SyllabusDetailsmap.get("theoryexternalmax");
						if(theoryexternalmax == null || theoryexternalmax.equals("") || theoryexternalmax.equals("-") || theoryexternalmax.equalsIgnoreCase("null"))
							theoryexternalmax="-";
						else
							theoryexternalmax=(String)SyllabusDetailsmap.get("theoryexternalmax");
						
						//out.print("<td>"+theoryinternalmin+"</td>");
						//out.print("<td>"+theoryinternalmax+"</td>");
						//out.print("<td>"+theoryexternalmin+"</td>");
						//out.print("<td>"+theoryexternalmax+"</td>");
						out.print("</tr>");
					}
				}
				else
				{   
					out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");
					//out.print("<tr><td colspan=4>Data Not Found</td></tr>");
	
				}
				%>
		</table>
		
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