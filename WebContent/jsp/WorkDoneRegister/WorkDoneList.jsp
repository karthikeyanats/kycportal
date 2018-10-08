<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry" />

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.workdoneregister.viewtitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="../highslide/highslide-with-html.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/js/highslide/highslide.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/highslide/highslide-with-html.js"></script>
<script type="text/javascript">
hs.graphicsDir = "<%=request.getContextPath()%>/js/highslide/graphics/"; 
hs.outlineType = 'rounded-white'; 
hs.wrapperClassName = 'draggable-header';  
</script>    

<script language='javascript'>
	
function goBack()
{
document.workallotment.action = "WorkDoneRegisterView.jsp";
		document.workallotment.submit();
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

<h2><%=bundle.getString("label.workdoneregister.viewrootpath_1") %></h2>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%
String instituteid = (String)session.getValue("instituteid");

	String sessionid = request.getParameter("session");
	String standardid = request.getParameter("standard");
	String sectionid = request.getParameter("section");
	String subjectid = request.getParameter("subject");
	String lessonid = request.getParameter("lesson");
	String sectionname = request.getParameter("sectionname");
	String subjectname = request.getParameter("subjectname");
	String lessonname = request.getParameter("lessonname");
	String standardname = request.getParameter("standardname");
	String sessionname = request.getParameter("sessionname");
	String lessonscheduleid = request.getParameter("lessonscheduleid");
	String userids = request.getParameter("userids");
	String staffname=request.getParameter("staffname");

		String newsection_temp=request.getParameter("newsection_temp");

String subjectcode=request.getParameter("subjectcode");
	HashMap hashmap = null;
	
	ArrayList dept=new ArrayList();
	HashMap newdept=new HashMap();
	String roleids="";
	dept=query_object.loadAllWorkDoneforHM(lessonscheduleid,userids);
	
%>
<form name='workallotment' method='post'>
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0  height="100%">

	<tr>
		<td>

		<table id="rounded-corner" border=0 summary="Department List"
			width="100%">
			 <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10" colspan=2><%=bundle.getString("label.workdoneregister.selectedinformation") %></th>
        	<th scope="col" class="rounded" width="60%" colspan=2> </th>
  	        	<th scope="col" class="rounded-q4" width="30%" colspan=2></th>
        	
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=5  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
			       <tr>
				
						<td class='tablebold' width='15%'><%=bundle.getString("label.workdoneregister.academicyear") %></td>
						<td class='tablebold' width='1'>:</td>
						<td class='tablelight'><%=sessionname%></td>


						<td class='tablebold' width='15%'><%=bundle.getString("label.workdoneregister.standard") %></td>
						<td class='tablebold' width='1'>:</td>
						<td class='tablelight'><%=standardname%></td>
					</tr>
					<tr>
				
						<td class='tablebold' width='15%'>Section</td>
						<td class='tablebold' width='1'>:</td>
						<td class='tablelight'><%=newsection_temp%></td>
						
						<td class='tablebold' width='15%'><%=bundle.getString("label.workdoneregister.subject") %></td>
						<td class='tablebold' width='1'>:</td>
						<td class='tablelight'><%=subjectname%></td>
					</tr>
					<tr height='23'>
						
						
						<td class='tablebold' width='15%'><%=bundle.getString("label.workdoneregister.subjectcode") %> </td>
						<td class='tablebold' width='1'>:</td>
						<td class='tablelight' ><%=subjectcode%></td>
						
						<td class='tablebold' width='15%'><%=bundle.getString("label.workdoneregister.lessonname") %></td>
						<td class='tablebold' width='1'>:</td>
						<td class='tablelight'><%=lessonname%></td>
					</tr>
					<tr>
					
					<td class='tablebold' width='15%'><%=bundle.getString("label.workdoneregister.staffname") %></td>
						<td class='tablebold' width='1'>:</td>
						<td class='tablelight'  colspan="4"><%=staffname%></td>
					</tr>
					
					</thead>
									</table>
									</td>
									</tr>
									
					<tr>
					<td>
					<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"><%=bundle.getString("label.workdoneregister.slno") %></th>
        	<th scope="col" class="rounded" width="60%"><%=bundle.getString("label.workdoneregister.workdonedetails") %></th>
  	        	<th scope="col" class="rounded-q4" width="30%"><%=bundle.getString("label.workdoneregister.dateofcreation") %></th>
        
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
				
				<% 
				String[] count=null;
				if(dept!=null && dept.size()>0)
				{	String as=request.getContextPath();							

					for(int i=0,j=1;i<dept.size();i++,j++)
					{
						out.println("<tr>");
						newdept=(HashMap)dept.get(i);
						String content=newdept.get("workdonedetails")+"";
						out.println("<td class='tablelight'>"+j+"</td>");
						if(content == null || content.equals("") || content.equals("-") || content.equalsIgnoreCase("null"))
						{
						
						out.print("<td class='tablelight'>-</td>");
						}
						else{
							
							   count=content.split(" ");
								if((count.length-1)>15)
								{
									out.print("<td class='tablelight' ");
									String des_tempnew="";
									for(int y=0;y<15;y++)
									{
										des_tempnew+=count[y]+" ";
									}%>
									<div>
									<%=content%><a href="index.htm" onclick="return hs.htmlExpand(this)">
								[<font color="red">More..</font>]
							</a>  
							<div class="highslide-maincontent">
								<h3></h3>
								<%=(content).replaceAll("\"","&quot;").replaceAll("\'","&apos;")%>
							</div>
								</div>
								<% }
								else
								{
									out.print("<td class='tablelight'>"+content+"</td>");

								}
								}
						out.println("<td class='tablelight'>"+newdept.get("newdates")+"</td>");


						out.println("</tr>");
			
					}

				}
				
				else
				{
					out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>Data Not Found</font></td></tr>");
					//out.println("<tr>");
					//out.println("<td colspan='3' align='center'class='tablelight'>Data Not Found</td>");
					//out.println("</tr>");

				}
				

				%>
			
			
				
			</tr>

 </td>
		</table>
		</td>
	</tr>
</table>
</td>
</tr>
<a href="#" class="bt_blue" onclick='goBack()'><span
					class="bt_blue_lft"></span><strong><%=bundle.getString("button.workdoneregister.back") %></strong><span
					class="bt_blue_r"></span></a>
					
<input type='hidden' name='session' value='<%=sessionid%>'><input
	type='hidden' name='sessionname' value='<%=sessionname%>'><input
	type='hidden' name='section' value='<%=sectionid%>'><input
	type='hidden' name='subject' value='<%=subjectid%>'><input
	type='hidden' name='lesson' value='<%=lessonid%>'><input
	type='hidden' name='standard' value='<%=standardid%>'><input
	type='hidden' name='standardname' value='<%=standardname%>'><input
	type='hidden' name='lessonname' value='<%=lessonname%>'><input
	type='hidden' name='subjectname' value='<%=subjectname%>'><input
	type='hidden' name='sectionname' value='<%=sectionname%>'><input
	type='hidden' name='dairyid' value=''><input type='hidden'
	name='dairyname' value=''><input type='hidden' 
	name='lessonscheduleid' value='<%=lessonscheduleid %>'></form> 


</div>
<!-- end of right content--></div>
<!--end of center content -->




<div class="clear"></div>
</div>
<!--end of main content--> <%@ include file="../include/footer.jsp"%>


</div>
</body>
</html>