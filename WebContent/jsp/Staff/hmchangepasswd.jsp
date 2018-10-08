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
	src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script language="JavaScript"
	src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">



function changepasswd()
{
if(confirm("Do you want to Change the Password...?"))
{
	
	document.f1.action = "./hmoldpassword.jsp";
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
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>

<div class="center_content">



<div class="left_content"></div>

<div class="right_content">

<h2><%=bundle.getString("hmlabel.changepassword.rootpath") %></h2>
<form name="f1" action="" method="post">
<TABLE align="center" width="100%" height="100%" BORDER=0 CELLSPACING=0
	CELLPADDING=0>
	<tr>
		<td align="center">
		<table id="rounded-corner_home" border=0   
			width="50%" align="center">
			<thead>
				<tr>
					<th scope="col" class="rounded-company" width="80%"><%=bundle.getString("hmlabel.changepassword.changehead") %></th>
					<th scope="col" class="rounded-q4" width="20%"></th>
				</tr>
			</thead>
			<tfoot>
				<tr>
					<td  class="rounded-foot-left"><em></em></td>
					<td class="rounded-foot-right">&nbsp;</td>
				</tr>
			</tfoot>
			<tbody>
			<tr>
					<td colspan="2" >
					<table border=0 cellspacing=0 cellpadding=0 width="100%" align=center>
					<%@page import="com.iGrandee.Prinicipal.PrinicipalQuery"%>

						<% 
							PrinicipalQuery details = new PrinicipalQuery();
							ArrayList profiledetails = new ArrayList();
							String userid =session.getValue("userid")+"";
							profiledetails = details.loadprofiledetails(userid);
							//out.println("profiledetails>>>"+profiledetails);
							for (int i = 0; i < profiledetails.size(); i++) {
								HashMap innermap = (HashMap) profiledetails.get(i);
								String username = innermap.get("uname") + "";
								String mobilenumber = innermap.get("mobilenumber") + "";
								String emailid = innermap.get("emailid") + "";
								String image = innermap.get("imagepath") + "";
								String usernames = innermap.get("username") + "";

								

								out.println("<tr>");
								
								out
										.println("<td class=tablebold>"+bundle.getString("hmlabel.changepassword.name")+"</td><td class=tablebold>:</td><td>"+ username + "</td>");
								out
								.println("<td rowspan=4 valign=top align=right><img src='"
										+ request.getContextPath()
										+ "/OpenDocument?r1=path&r2="
										+ image
										+ "' alt='' title='' border='0'  width='100' height='100'/> </td>");
								out.println("</tr>");

								out.println("<tr>");

								out
										.println("<td class=tablebold>"+bundle.getString("hmlabel.changepassword.role")+"</td><td class=tablebold>:</td><td>" + session.getValue("userrolename")
												+ "</td>");

								out.println("</tr>");
								out.println("<tr>");
								if(mobilenumber.equals("null"))
									mobilenumber = "-";
								 
								out.println("<td class=tablebold>"+bundle.getString("hmlabel.changepassword.mobileno")+"</td><td class=tablebold>:</td><td>" + mobilenumber + "</td>");

								out.println("</tr>");
								//out.println("<tr>");
  
								//out.println("<td>" + mobilenumber + "</td>");

								//out.println("</tr>");
								out.println("<tr>");

								out.println("<td class=tablebold>"+bundle.getString("hmlabel.changepassword.email")+"</td><td class=tablebold>:</td><td>" + emailid + "</td>");

								out.println("</tr>");
								out.println("<tr>");

								out.println("<td class=tablebold>"+bundle.getString("hmlabel.changepassword.username")+"</td><td class=tablebold>:</td><td colspan=2>" + usernames + "</td>");

								out.println("</tr>");
								out.println("<tr>");

								out.println("<td class=tablebold>"+bundle.getString("hmlabel.changepassword.password")+"</td><td class=tablebold>:</td><td colspan=2>************&nbsp;&nbsp;&nbsp;<a href='#' onclick='changepasswd()'><font color=red>(&nbsp;Change Password&nbsp;)</font></a></td>");

								out.println("</tr>"); 
								
							}  
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