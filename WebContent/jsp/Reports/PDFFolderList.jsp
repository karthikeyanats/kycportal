<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="sun.misc.Request"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Archival List  | Powered by i-Grandee</title>
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
	document.wprkallotment.action ="PDFArchivalView.jsp";
	document.wprkallotment.submit();
	}
	function submitfun(obj)
	{
	document.wprkallotment.folder.value=obj.getAttribute("foldername");
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


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Reports / Archival Reports </h2>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ page language="java"
	import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap"%>
<%@ page language="java"
	import="com.iGrandee.Attendance.AttendanceQuery"%>
<%
	//ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_en");
	AttendanceQuery attenquery		= new AttendanceQuery();
	HashMap hashmap=null;
	String instituteid			= (String)session.getValue("instituteid");
	String sessionid			= request.getParameter("sessionhiddenid")+"";
	String sessionname			= request.getParameter("sessionnamehidden")+"";

%>
<jsp:useBean id="obj"  scope="page" class="com.iGrandee.Report.Reports"/>
<body topmargin=0 leftmargin=0 bottommargin=0 rightmargin=0>
	<form name='wprkallotment' method='post'>
		<input type="hidden" name="sessionhiddenid" value="<%=sessionid %>">
		<input type="hidden" name="sessionnamehidden" value="<%=sessionname %>">
		<input type="hidden" name="folder" value="">
		
		
			<table class="bodyinnercolor" border='0' align="center" width="100%" height='100%' cellspacing=0 cellpadding=0>
				<tr>
					<td width='100%' >
						<font class=tablebold color=red >Archived Academic Year:<%=sessionname %><br>&nbsp;</font>
					
						<table width='100%' id=rounded-corner align='center' border='0'  cellspacing=0 cellpadding=0 >
							 <thead>
							    	<tr>
							        	<th scope="col" class="rounded-company">Sl.No</th>
							            <th scope="col" class="rounded"  width="50%">Title</th>
							        	<th scope="col" class="rounded"   width="50%"  >PDF File List</th>
							        	<th scope="col" class="rounded-q4"     ></th>
							        	
							        </tr>
							    </thead>
							    <tfoot>
									<tr>
										<td colspan=3 class="rounded-foot-left"><em></em></td>
										<td class="rounded-foot-right">&nbsp;</td>
									</tr>
								</tfoot>
								<tbody >
									<tr>
									<td align=center>1</td>
									<td>StudentList</td>
									<td><a href='#pdf' foldername='StudentList' onclick='submitfun(this)'> PDF File List</a>
									</td>
									<td ></td>
									</tr>
									<tr>
									<td align=center>2</td>
									<td>Fees Details</td>
									<td><a href='#pdf'  foldername='Fees Details' onclick='submitfun(this)'> PDF File List</a>
									</td>
									<td></td>
									</tr><tr>
									<td align=center>3</td>
									<td>Subject allotment List</td>
									<td><a href='#pdf' foldername='Subject allotment List'  onclick='submitfun(this)'> PDF File List</a>
									</td>
									<td></td>
									</tr>
									<tr>
									<td  align=center>4</td>
									<td>Exam Details</td>
									<td><a href='#pdf'  foldername='Exam Details' onclick='submitfun(this)'> PDF File List</a>
									</td>
									<td></td>
									
									</tr>
									<tr>
									<td  align=center>5</td>
									<td>Mark Details</td>
									<td><a href='#pdf'   foldername='Mark Details' onclick='submitfun(this)'> PDF File List</a>
									</td>
									<td></td>
									
									</tr>
									<tr>
									<td align=center>6</td>
									<td>Attendance List </td>
									<td><a href='#pdf'   foldername='Attendance List' onclick='submitfun(this)'> PDF File List</a>
									</td>
									<td></td>
									
									</tr>
								</tbody>
						</table>
						<a href="#" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
					</td>
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