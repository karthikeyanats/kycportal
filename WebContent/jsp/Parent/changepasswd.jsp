<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderEntry" />
<jsp:useBean id="instituteBean" scope="page"
	class="com.iGrandee.SchoolCalender.SchoolCalenderBean" />
<%@ page language="java"
	import="java.util.*,com.iGrandee.Common.DateTime"%>
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.studpswchange.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="jquery.min.js"></script>
<script type="text/javascript" src="ddaccordion.js"></script>
<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">



function changepasswd()
{
if(confirm("Do you want to Change the Password...?"))
{
	
	document.f1.action = "./oldpassword.jsp";
	document.f1.submit();
	}

}

</script>
</head>
<body>

<div id="main_container">
<div class="header"><%@ include file="../include/userheader.jsp"%>

</div>

<div class="main_content"><%@ include file="../include/ParentHeader.jsp"%>


<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("label.parentpswchange.rootpath")%></h2>
<form name="f1" action="" method="post">
<TABLE align="center" width="100%" height="100%" BORDER=0 CELLSPACING=0
	CELLPADDING=0>
	<tr>
		<td align="center">
		<table id="rounded-corner_home" border=0   
			width="50%" align="center">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="50%"><%=bundle.getString("label.studpswchange.ChangePassword")%></th>
					<th scope="col" class="rounded" width="30%"></th>
					<th scope="col" class="rounded-q4" width="20%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td colspan="2" class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
			<tr>
					<td colspan="3" >
					<table border=0 cellspacing=0 cellpadding=0 width="100%" align=center>
<%@page import="com.iGrandee.Prinicipal.PrinicipalQuery"%>
						<% 
							PrinicipalQuery details = new PrinicipalQuery();
							ArrayList profiledetails = new ArrayList();
							String userid =session.getValue("userid")+"";
							String studentname ="";
							String fathername ="-";
							String mobilenumber ="-";
							String mothername="-";
							String usernames="-";
							profiledetails = details.loadparentprofiledetails(userid);
							for (int i = 0; i < profiledetails.size(); i++) {
								 HashMap innermap = (HashMap) profiledetails.get(i);
								 if(i==0)
								 {
									 mobilenumber = innermap.get("mobilenumber") + "";
									 fathername = innermap.get("fathername") + "";
									 usernames = innermap.get("parentusername") + "";
								 }
							}  
							out.println("<tr>");
							out.println("<td class=tablebold>"+bundle.getString("label.parentpswchange.Name")+"</td><td class=tablebold>:</td><td>&nbsp;&nbsp;"+ fathername + "</td>");
							out.println("</tr>");
							out.println("<tr>");
							out.println("<td class=tablebold>"+bundle.getString("label.parentpswchange.Role")+"</td><td class=tablebold>:</td><td>&nbsp;&nbsp;" + session.getValue("userrolename")+ "</td>");
							out.println("</tr>");
							out.println("<tr>");
							out.println("</tr>");
							out.println("<tr>");
							out.println("<td class=tablebold>"+bundle.getString("label.parentpswchange.UserName")+"</td><td class=tablebold>:</td><td colspan=2>&nbsp;&nbsp" + usernames + "</td>");
							out.println("</tr>");
							out.println("<tr>");
							out.println("<td class=tablebold>"+bundle.getString("label.parentpswchange.Password")+"</td><td class=tablebold>:</td><td colspan=2>&nbsp;&nbsp************&nbsp;&nbsp;&nbsp;<a href='#' onclick='changepasswd()'><font color=red>(&nbsp;"+bundle.getString("label.studpswchange.ChangePassword")+"&nbsp;)</font></a></td>");
							out.println("</tr>"); 
						%>
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