<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle.getString("label.profileinfo.infotitle") %> | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script language='javascript'>

function backfun()
{

document.f1.action= "HomePage.jsp";
			document.f1.submit();

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

<h2><%=bundle.getString("label.profileinfo.inforootpath") %></h2>
<form name="f1" method="post" enctype="multipart/form-data">

<%@ page
	import="java.util.*"%> <%
 	
 %> <jsp:useBean id="relationcheck" scope="page"
	class="com.iGrandee.Registration.InstitutionQurey" /> <%
 	ArrayList instituteArray = new ArrayList();
 	HashMap instituteMap = null;
 	String instituteid = (String) session.getValue("instituteid");
 	instituteArray = relationcheck.getInstituteDetails(instituteid);

 	String institutenames = "";
 	String contactaddress = "";
 	String country = "";
 	String state = "";
 	String landlinenumber = "";
 	String mobilenumber = "";
 	String emailid = "";
 	String fax = "";
 	String photo = "";
 	String url = "";
 	String city = "";
 	String zip = "";
 	

 	if (instituteArray != null && instituteArray.size() > 0) {
 		for (int k = 0; k < instituteArray.size(); k++) {
 			instituteMap = (HashMap) instituteArray.get(k);
 			institutenames = (String) instituteMap.get("institutename");
 			contactaddress = (String) instituteMap
 					.get("contactaddress");
 			country = (String) instituteMap.get("country");
 			state = (String) instituteMap.get("state");
 			landlinenumber = (String) instituteMap
 					.get("landlinenumber");
 			mobilenumber = (String) instituteMap.get("mobilenumber");
 			emailid = (String) instituteMap.get("emailid");
 			fax = (String) instituteMap.get("fax");
 			emailid = (String) instituteMap.get("emailid");
 			photo = (String) instituteMap.get("institutelogo");
 			url = (String) instituteMap.get("url");
 			city = (String) instituteMap.get("city");
 			zip = (String) instituteMap.get("zip");
 		}
 	}
 %>




<table border=0 id="rounded-corner" align="center" width="100%" cellspacing=0 cellpadding=0>
		<thead>
			<tr class=tableheading valign="top">
			<th width="90%" class="rounded-company"><%=bundle.getString("label.profileinfo.inforootpath") %></th>
			<th width="10%" class="rounded-q4" align="right"></th>
			</tr>
		
		<tr>
		<td colspan="2">
			<table border='0' align="center" width="100%" cellspacing=0	cellpadding=5> 
				<tr style="height: 25" class=tableheading valign="top">
					<td class="tablebold" width="10%"><%=bundle.getString("label.profileinfo.nameofschool") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="10%" colspan="5"  ><%=institutenames%></td>
					<td rowspan="3" align="right"><img
						src="<%=request.getContextPath()%>/OpenDocument?r1=storagepath&r2=<%=photo%>"
						name='stphoto_img1' id=stphoto_img width=120 height=130></td>
				</tr>
				<tr style="height: 25">
					<td class="tablebold" width="20%"  colspan="1"><%=bundle.getString("label.profileinfo.street") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"  colspan="1"><%=contactaddress%></td>
				</tr>
				<tr style="height: 25">
					<td class="tablebold" width="20%"  colspan="1"><%=bundle.getString("label.profileinfo.country") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"  colspan="1"><%=country%></td>
					<td class="tablebold" width="20%" colspan="1"><%=bundle.getString("label.profileinfo.state") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%" colspan="1"><%=state%></td>
				</tr>
				<tr style="height: 25">
					<td class="tablebold" width="20%"  colspan="1"><%=bundle.getString("label.profileinfo.city") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"  colspan="1"><%=city%></td>
					<td class="tablebold" width="20%" colspan="1"><%=bundle.getString("label.profileinfo.zip") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%" colspan="1"><%=zip%></td>
				</tr>
				
				<tr style="height: 25">  

					<td class="tablebold" width="20%"><%=bundle.getString("label.profileinfo.contactno") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"><%=landlinenumber%></td>


				</tr>
				<tr style="height: 25">
					<td class="tablebold" width="20%"  colspan="1"><%=bundle.getString("label.profileinfo.email") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"  colspan="1"><a href="mailto:<%=emailid%>"><%=emailid%></a></td>
					<td class="tablebold" width="20%"  colspan="1"><%=bundle.getString("label.profileinfo.web") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"  colspan="1"><a href='http://<%=url%>'  target='_new'><%=url%></a></td>


				</tr>
				<tr style="height: 25">
					<td class="tablebold" width="20%"  colspan="1"><%=bundle.getString("label.profileinfo.mobile") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"  colspan="1"><%=mobilenumber%></td>
					<td class="tablebold" width="20%"  colspan="1"><%=bundle.getString("label.profileinfo.fax") %></td>
					<td class="tablebold" width="1%">:</td>
					<td class="tablelight" width="20%"  ><%=fax%></td>


				</tr>
			</table>
	</thead>

</table>
</td>
</tr>
</table>


<br>
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