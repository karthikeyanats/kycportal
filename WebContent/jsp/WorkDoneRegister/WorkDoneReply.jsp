<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
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
<script type="text/javascript">

function goBack(){
		
		document.f1.action = "WorkDoneRegister.jsp";
		document.f1.submit();
	}
	function saveFun()
	{
		
	if(check_ForParticularElements(document.f1.workdonedetail,"text"))
	{
		document.f1.action = "WorkDoneRegisterSave.jsp";
		document.f1.submit();
		}
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

<h2><%=bundle.getString("label.workdoneregister.replyrootpath") %></h2>
<form name="f1" method="post" action=""><%@ page
	import="java.util.*"%> 
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%> <%@ page
	language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
	<%@ page language="java"
	import="com.iGrandee.WorkDoneRegister.WorkDoneRegisterEntry"%>
 <%
ArrayList WorkDoneregDailForStaff=new ArrayList();
WorkDoneRegisterEntry wallot 		= new WorkDoneRegisterEntry();
String userid=(String)session.getValue("userid");

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
	String subjectcode = request.getParameter("subjectcode");
	WorkDoneregDailForStaff=wallot.getWorkDoneregDailForStaff(userid,lessonscheduleid);

	HashMap hashmap = null;
 %>
<form name="f1" method="post" action="">
<TABLE border=0 class="tablecolor" cellspacing=0 width=100% align=center
	height="100%" cellpadding=0>
	
	
	
	<br>
	<tr>
		<td valign='top'>
				<table border=0 id="rounded-corner" width="80%">

			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.workdoneregister.selectedinformation") %></th>
					<th scope="col" class="rounded-q4" width="20%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td> 
					<td class="rounded-foot-right">&nbsp;</td> 
				</tr>
				</tfoot>
				<tr>
				<td colspan=2><table width="100%">
				<tr height='23'>
						<td class='tablebold' width="20%"><%=bundle.getString("label.workdoneregister.academicyear") %> </td>
						<td class="tablebold" >:</td>
						<td class='tablelight'><%=sessionname%></td>


						<td class='tablebold'><%=bundle.getString("label.workdoneregister.standard") %></td>
						<td class="tablebold">:</td>
						<td class='tablelight' ><%=standardname%></td>
					</tr>
					<tr height='23'>
						<td class='tablebold'><%=bundle.getString("label.workdoneregister.subject") %></td>
						<td class="tablebold">:</td>
						<td class='tablelight'><%=subjectname%></td>

						<td class='tablebold' ><%=bundle.getString("label.workdoneregister.lessonname") %> </td>
						<td class="tablebold">:</td>
						<td class='tablelight' ><%=lessonname%></td>
					</tr>
					<tr>
					<td class='tablebold' ><%=bundle.getString("label.workdoneregister.subjectcode") %> </td>
					<td class="tablebold">:</td>
					<td class='tablelight' colspan=4><%=subjectcode%></td>
					</tr>
				</table></td></tr>	
			</thead>
		</table>
		</td>
	</tr>
	</table>
	
<br>
	
	<tr>
	<td  valign="top">
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("label.workdoneregister.replytableheading") %> :</th>
			
					<th scope="col" class="rounded-q4" width="20%"></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				<tr>
				<td width="100%" colspan=3>
				<table width="100%" border=0 >
					<tr height=25>
				<td align=left colspan=3 class="tablebold"><%=bundle.getString("label.workdoneregister.workdetails") %> :</td>
			</tr>
			
					<tr>
						<td colspan=6><textarea name="workdonedetail" cols=70 rows=4 validate="Work Done Details"
							onkeydown="textCounter_label(document.f1.workdonedetail,document.getElementById('labelid'),2000)"
							onkeyup="textCounter_label(document.f1.workdonedetail,document.getElementById('labelid'),2000)"></textarea>
						<br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.workdoneregister.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.workdoneregister.charactersleft") %></font></i></td>
					</tr>
					</table>
				</tbody>
			</table>
			<br>
			
			
			
			<tr>
	<td  valign="top">
		<table border=0 id="rounded-corner" width="80%">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.workdoneregister.slno") %></th>
					<th scope="col" class="rounded"  width="60%" ><%=bundle.getString("label.workdoneregister.workdonedetails") %></th>
					<th scope="col" class="rounded-q4" width="15%"><%=bundle.getString("label.workdoneregister.dateofcreation") %></th>

				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan=2 class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
				
			
					<% String[] count=null;  
				HashMap hshmap=null;
				if(WorkDoneregDailForStaff !=null && WorkDoneregDailForStaff.size()>0)
				{
					for(int k=0,j=1;k<WorkDoneregDailForStaff.size();k++,j++)
					{
						hshmap=(HashMap)WorkDoneregDailForStaff.get(k);
						String content=hshmap.get("workdonedetails")+"";
						out.print("<tr>");
						out.print("<td width='5%'>"+j+"</td>");
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
						
						out.print("<td class='tablelight'>"+hshmap.get("newdates")+"</td>");

						out.print("</tr>");
					}
				}
				else
				{
					out.println("<td colspan='3' align=center><font color='red'><b>Data Not Found</b></font></td>");
					//out.print("<td colspan=3 align='center'>Data Not Found</td>");

				}
				%>
					
				</tbody>
			</table>
			
			
			
			
		</td>
	</tr>

	</table>
	<input type='hidden' name='subjectcode' value='<%=subjectcode%>'>
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
	name='lessonscheduleid' value='<%=lessonscheduleid %>'>
	<input type='hidden'
	name='lessonname' value=''>
<a href="#" class="bt_blue" onclick='goBack()'><span
					class="bt_blue_lft"></span><strong><%=bundle.getString("button.workdoneregister.back") %></strong><span
					class="bt_blue_r"></span></a> <a href="#" class="bt_green"
					onclick="saveFun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.workdoneregister.save") %></strong><span
					class="bt_green_r"></span></a>
	
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