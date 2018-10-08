<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<jsp:useBean id="validate" scope="page"
	class="com.iGrandee.Common.CommonDataAccess" />
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>Student Profile Entry</title> 

<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<link rel="stylesheet" type="text/css" media="all" href="<%=request.getContextPath()%>/jsp/kycpanel/niceforms-default.css" />
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<SCRIPT language="JavaScript" src="<%=request.getContextPath()%>/js/Validation.js"></SCRIPT>


<script language="JavaScript">

function submitfun()
{

	//alert(document.MainForm.ApplicationNumber.value);
		if(check_ForParticularElements(document.MainForm.ApplicationNumber,"text"))
   		{
			document.MainForm.action= "./StudentApplicationEntry.jsp";
			document.MainForm.submit();
		}
		
		

}
function resetfun()
{
document.MainForm.boardname.value="";
document.MainForm.descryption.value="";

}

function viewstudent()
{
document.MainForm.action= "./RegisteredStudentList.jsp";
document.MainForm.submit();

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
         <h2>Enrollment / Student Enrollment / Student Profile Entry </h2>
     
<%@ page import="java.io.*,java.util.*"%>

<form name="MainForm" method="post" action="">
 
<TABLE align="center" width="100%" height="100%" border=0 cellspacing=0
	cellpadding=0>
		<tr>
		<td>
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="90%">Student Profile Entry - [ <%=(String)session.getAttribute("sessionname") %> ]</th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <tr><td colspan=2>
     <table width=100%>
     <tr>
     
				<td class="tablebold" align=center colspan=2>Enter Application Number</td>
				<td class=tablebold>:</td>
				<td><input type="text" name="ApplicationNumber" validate="Appllication Number" class=tablelight size="50" value="" 	maxlength=100></td>
	</tr>
	</table></td></tr>
</tbody>
</table>
<a href="#"  onclick="viewstudent()" class="bt_blue"><span
		class="bt_blue_lft"></span><strong>View all Registered Student List </strong><span
		class="bt_blue_r"></span></a> 
				<a href="#" onclick="submitfun()"  class="bt_green" align=center><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a>
				&nbsp;&nbsp;&nbsp;&nbsp; 

	
</TABLE> </form>
</div><!-- end of right content-->


  </div>   <!--end of center content -->

		      
				

    <div class="clear"></div>
    </div> <!--end of main content-->
<%@ include file="../include/footer.jsp" %>

</div>

 
	
</body>
</html>