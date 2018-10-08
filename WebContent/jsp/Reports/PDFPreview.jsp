<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="sun.misc.Request"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child -  Archival List  | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/jquery.min.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/ddaccordion.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language='javascript'>
	function backfun()
	{
	document.wprkallotment.action ="PDFFileList.jsp";
	document.wprkallotment.submit();
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

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,java.io.File"%>
<%@ page language="java"
	import="com.iGrandee.Attendance.AttendanceQuery"%>
<%
String attachment	   	= request.getParameter("attachment")+"";
String sessionid		= request.getParameter("sessionhiddenid")+"";
String sessionname		= request.getParameter("sessionnamehidden")+"";
String folder			= request.getParameter("folder")+"";

%>
    <div class="center_content">
    <div class="left_content">
    </div>
    <div class="right_content">
    <h2>Reports / Archival Reports / <%=folder %> / PDF View</h2>

<jsp:useBean id="obj"  scope="page" class="com.iGrandee.Report.Reports"/>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
			<input type="hidden" name="sessionhiddenid" value="<%=sessionid %>">
			<input type="hidden" name="sessionnamehidden" value="<%=sessionname %>">
			<input type="hidden" name="folder" value="<%=folder%>">
						<font class=tablebold color=red >Archived Academic Year:<%=sessionname %><br>&nbsp;</font>
			
			<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
				<tr>
					<td width='100%' align='center'>
						 <iframe src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=attachment %>" width="100%" height="600px"></iframe>
						<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
				</tr>
			</table>

	</form>
    </div><!-- end of right content-->


  </div>   <!--end of center content -->
    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>