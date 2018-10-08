<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
<%@ page language="java"
	import="java.util.*,com.iGrandee.Common.DateTime"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Change Password | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">



function loadfun()
{
document.f1.oldpassword.focus();
}
function backfun()
{

	document.f1.action = "./adminchangepasswd.jsp";
	document.f1.submit();

}
function changepasswd()
{
if(confirm("Do you want to Change the Password...?"))
{
	document.f1.action = "./adminoldpassword.jsp";
	document.f1.submit();
}

}
function Submitfun()
{
if(document.f1.oldpassword.value == "")
	{
		alert("Old password should not be empty");
		document.f1.oldpassword.focus();
		return false;
	}
if(confirm("Do you want to Change the Password...?"))
{
	document.f1.action = "./adminCheckPassword.jsp";
	document.f1.submit();
}

}
</script>
</head>
<body onload="loadfun()">

<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/header.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2>General / Change Password</h2>
<form name="f1" action="" method="post">

<TABLE align="center" width="100%" height="100%" BORDER=0 CELLSPACING=0
	CELLPADDING=0>
	<tr>
		<td align="center">
		<table id="rounded-corner_home" border=0   
			width="50%" align="center">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="80%">Change Password</th>
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
					<td colspan="2" >
					<table border=0 cellspacing=0 cellpadding=0 width="100%" align=center>
						<tr>
						<td class=tablebold align=right>Old Password:</td>
						<td><input type=password name=oldpassword id=oldpassword value="" /></td>
						</tr>
						<tr>
						<td class=tablebold align=right colspan=2><a href="#na2" name="na2" class="bt_blue" onclick="backfun()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a><a href="#na2" name="na2" class="bt_green" onclick="Submitfun()"><span class="bt_green_lft"></span><strong>Submit</strong><span class="bt_green_r"></span></a></td>
						</tr>
						
					</table>
					</td>
			</tbody>
		</table>
		</td>
	</tr>
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