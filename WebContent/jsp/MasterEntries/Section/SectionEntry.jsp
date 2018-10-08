<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title><%=bundle.getString("label.section.entrytitle") %></title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>

<script language="JavaScript">


function submitfun()
{
	if(check_ForParticularElements(document.MainForm.SectionName,"text"))
	{
			document.MainForm.action= "SectionSubmit.jsp";
			document.MainForm.submit();
		
		
	}
	else
		document.getElementById("save_but").disabled=false;
		

}

function resetfun()
{
document.MainForm.reset();
document.getElementById("labelid").innerHTML	= "2000";

}
function deptview()
{
document.MainForm.action= "SectionList.jsp";
document.MainForm.submit();
}

</script>
</head>

<body>
<form name="MainForm" method="post" action="">

<div id="main_container">

	<div class="header">
	
<%@ include file="../../include/userheader.jsp" %>
   
	   </div>

    <div class="main_content">
    
<%@ include file="../../include/header.jsp" %>
    <div class="center_content">

     <div class="left_content">

    </div>

    <div class="right_content">
       <h2><%=bundle.getString("label.section.entryrootpath") %></h2>

<form name="MainForm" method="post" action="">
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	
	<tr>
		<td>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	 <th scope="col" class="rounded-company" width="1%"></th>
        	 <th scope="col" class="rounded" width="80%"><%=bundle.getString("label.section.entrytableheading") %></th>      
        	<th scope="col" class="rounded-q4" width="20%" ><font color=red>*</font> <%=bundle.getString("label.group.mandatoryfields") %></th> 
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan=2  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
</tbody>
</table>
<table id="rounded-corner" border=0  width="100%">
    <thead>			<tr valign="top">
				<td class="tablebold"><%=bundle.getString("label.section.sectionname") %> <font color=red>*</font></td>
					<td class=tablebold>:</td><td><input type="text" name="SectionName"
					validate="Section Name" class=tablelight size="50" value=""
					maxlength=45></td>
			</tr>
			<tr valign="top">
				<td class="tablebold"><%=bundle.getString("label.section.description") %></td>
				
				<td class=tablebold>:</td> <td><textarea  cols=75 rows=2 class="tablelight" name="Description" onkeydown="textCounter_label(document.MainForm.Description,document.getElementById('labelid'),2000)" onkeyup="textCounter_label(document.MainForm.Description,document.getElementById('labelid'),2000)"></textarea>&nbsp; <br><br><i><font color="red"><label id="labelid" ><%=bundle.getString("label.section.charactercount") %></label>&nbsp;&nbsp;<%=bundle.getString("label.section.charactersleft") %></font></i></td>
					
			</tr>
			
			</thead>
		</table>
	<a href="#" onclick="resetfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.section.reset") %></strong><span class="bt_blue_r"></span></a>

     <a href="#" onclick="deptview()"  class="bt_blue"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.section.viewallsection") %> </strong><span class="bt_blue_r"></span></a>
	     <a href="#" class="bt_green" onclick="submitfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.section.submit") %></strong><span class="bt_green_r"></span></a>
	
		</td>
	</tr>
	
</TABLE>
</div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->
    
<%@ include file="../../include/footer.jsp" %>

</div>

    </form>
	
</body>
</html>