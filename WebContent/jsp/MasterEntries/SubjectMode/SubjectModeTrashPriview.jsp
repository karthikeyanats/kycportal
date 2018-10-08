<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.MasterEntries.SubjetMode.SubjectModeEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.MasterEntries.SubjetMode.SubjectModeBean" />
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Subject Mode</title>

<LINK rel=stylesheet href="../css/kyccss.css">
<link rel="stylesheet" type="text/css" href="../../../jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" media="all" href="../jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="../../../js/Validation.js"></SCRIPT>
<script type="text/javascript" src="../jsp/jconfirmaction.jquery.js"></script>

<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script language="javascript" type="text/javascript" src="niceforms.js"></script>

<script language="JavaScript">

	$(document).ready(function() {
		$('.ask').jConfirmAction();
	});


ddaccordion.init({
	headerclass: "submenuheader", //Shared CSS class name of headers group
	contentclass: "submenu", //Shared CSS class name of contents group
	revealtype: "click", //Reveal content when user clicks or onmouseover the header? Valid value: "click", "clickgo", or "mouseover"
	mouseoverdelay: 200, //if revealtype="mouseover", set delay in milliseconds before header expands onMouseover
	collapseprev: true, //Collapse previous content (so only one open at any time)? true/false
	defaultexpanded: [], //index of content(s) open by default [index1, index2, etc] [] denotes no content
	onemustopen: false, //Specify whether at least one header should be open always (so never all headers closed)
	animatedefault: false, //Should contents open by default be animated into view?
	persiststate: true, //persist state of opened contents within browser session?
	toggleclass: ["", ""], //Two CSS classes to be applied to the header when it's collapsed and expanded, respectively ["class1", "class2"]
	togglehtml: ["suffix", "<img src='images/plus.gif' class='statusicon' />", "<img src='images/minus.gif' class='statusicon' />"], //Additional HTML added to the header when it's collapsed and expanded, respectively  ["position", "html1", "html2"] (see docs)
	animatespeed: "fast", //speed of animation: integer in milliseconds (ie: 200), or keywords "fast", "normal", or "slow"
	oninit:function(headers, expandedindices){ //custom code to run when headers have initalized
		//do nothing
	},
	onopenclose:function(header, index, state, isuseractivated){ //custom code to run whenever a header is opened or closed
		//do nothing
	}
})



function goToBack()
{
	document.MainForm.action= "SubjectModeList.jsp";
document.MainForm.submit();
}
function goToTrash()
{
if(confirm("Do you want to trash the Details"))
{
	document.MainForm.action= "SubjectModeTrash.jsp";
document.MainForm.submit();
}
else{}
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
         <h2>Master Entries /Subject Mode Trash</h2>

<%@ page language="java" import="java.util.*"%>
<%
	String curstatus = "T";
//instituteBean.setgroupid(groupid);
	//instituteBean.setgroupname(groupname);
	String subjectmodename=request.getParameter("subjectmodename");
String subjectmodeid=request.getParameter("subjectmodeid");

	String description = request.getParameter("description");
	String description1="";
	
	String noofdept="";
	String noofdept1="";

	String noofdesp="";
	String noofdesp1="";


	if(noofdept.equals(""))
	{
		noofdept1="-";
	}
	else
	{
		noofdept1=noofdept;
	}
	if(noofdesp.equals(""))
	{
		noofdesp1="-";
	}
	else
	{
		noofdesp1=noofdesp;
	}
	
if(description.equals(""))
{
	description1="-";
	}
else
{
	description1=description;

}

	//instituteBean.setDepartmentid(groupid);
	//out.println("************" + groupid);
	//instituteBean.setStatus(curstatus);
	//int trashlist = query_object.UpdatetashDepartments();
	
%>
<form name="MainForm" method="post" action="">

<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
	
	<tr>
		<td>
		<table border=1 width="90%" bordercolor='#e3e3e3' cellpadding=10
			cellspacing=1>
			<tr bordercolor=white>
				<td align=center class="tablebold">Subject Type Name :</td><td class="tablelight"><%=subjectmodename %></td>
			</tr>
			<tr bordercolor=white>
				<td align=center class="tablebold">Description :</td><td class="tablelight"><%=description1 %></td>
			</tr>
			
			<tr bordercolor=white>
				<td align=center class="tablebold">No of  Subject Types:</td><td class="tablelight"><%=noofdesp1%></td>
			</tr>
			<tr bordercolor=white>
				<td align=center class="tablebold">No of Description:</td><td class="tablelight"><%=noofdesp1%></td>
			</tr>
		</table>
		<br>
		<table border=0 width="90%" cellpadding=0 cellspacing=0 align="center">
			<tr align="center">
				<td><input type="button" name="back" class=buttonTab
					style="width: 80" value="Trash" onclick="goToTrash()">&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="button" name="back" class=buttonTab
					style="width: 80" value="Back" onclick="goToBack()">
					</td>
			</tr>
		</table>
	
	<input type="hidden" name="subjectmodeid" value="<%=subjectmodeid %>">
	
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