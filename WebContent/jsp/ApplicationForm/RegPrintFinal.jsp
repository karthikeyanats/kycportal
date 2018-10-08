<html>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />
<title><%=bundle.getString("label.admisionprocessprintpreview.title")%> Window</title>
<head>
<script language="javascript">
function printfun()
{
window.print(document.text);
}function goBack()
	{
	window.close();
	}
	
	function printfun()
	{	
	document.getElementById("printbutt").style.visibility='hidden';
	document.getElementById("backbutt").style.visibility='hidden';
	window.print();
	document.getElementById("printbutt").style.visibility='visible';
	document.getElementById("backbutt").style.visibility='visible';	
	}
</script>
</head>
<body  topmargin="0" bottommargin="0" onload=printfun()>
<form name=f1 action="" method="post">
<jsp:useBean id="queryBean" scope="page" class="com.iGrandee.Application.RegistrationProcess"/>
<%@ page language="java" import="java.text.NumberFormat,java.util.Locale" %>
<% 	java.util.ResourceBundle bundle1 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");%>
<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,com.iGrandee.Fees.FeesSchedule,java.text.NumberFormat,java.util.Locale"%>	

<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.Common.DateTime"%>
<%
			///ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_eng");
			String registrationid = "";
			String applicationid="";
			InstitutionQurey insquery=new InstitutionQurey();

			String registrationfees="";
			String dateofregistration = "";
			String branchid = "";
			String applicationno = "";
			String applicantname = "";
			String receiptno = "";
			String applicationids = "";
			String coursename = "";
			String currentdate = "";
			String formattedCurrency = null;
			String instituteid		= (String)session.getValue("instituteid");

			String req_sessionname = request.getParameter("req_sessionname");
			String standardnamegp = request.getParameter("standardnamegp");
			String req_boardname = request.getParameter("req_boardname");
			Locale localcurrency = new Locale(bundle1.getString("language"), bundle1.getString("code"));
			ArrayList insdetails=insquery.getInstituteDetails(instituteid);

//out.print("req_sessionname-->"+req_sessionname);
ArrayList searchlist= null;

applicationids = request.getParameter("applicationid");

searchlist=(ArrayList)queryBean.displayRegistrationDetailsPrint(applicationids);

for(int i=0;i<searchlist.size();i++)
		{
			HashMap searchmap = (HashMap)searchlist.get(i);
			 registrationid = (String)searchmap.get("registrationid");
			 applicationid=(String)searchmap.get("applicationid");
			 registrationfees=(String)searchmap.get("registrationamount");
			 dateofregistration = (String)searchmap.get("dateofcreation");
			 //branchid = (String)searchmap.get("branchid");
			 applicationid = (String)searchmap.get("applicationid");
			 applicationno = (String)searchmap.get("applicationno");
			 applicantname = (String)searchmap.get("applicantname");
			 currentdate = (String)searchmap.get("currentdate");
			 //receiptno = (String)searchmap.get("receiptno");
			 //coursename = (String)searchmap.get("coursename");

			Long lObj2 = Long.valueOf(registrationfees);
			NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
			formattedCurrency = format.format(lObj2);


		}
%>
<table border=0 cellpadding=5 cellspacing=0 width="650" align=center>
<tr><td>
<table border=0 cellpadding=0 cellspacing=0 width="100%" align=center height=100>
<tr>
<td>
	<table width="100%" border="0" cellspacing="0">
		<tr valign=top align=center>
			<td class="tablebold">
				<%@ include file="../include/reportprintheader.jsp"%>
				<%-- <font color="#000000"><%=session.getValue("institutename")%> <br> --%>
			</td>
		</tr>
	</Table><br>
</td>
</tr>
<tr><td colspan=2 align=right><a class=tablebold><font color='#000000'><%=bundle.getString("label.admisionprocessprintpreview.Date")%> : </a><a class=tablelight><font color='#000000'><%=currentdate%></a></td></tr>
<%-- <tr class='tablelight'><td colspan=2 align=center class=tablebold><font color='#000000'><%=bundle.getString("label.admisionprocessprintpreview.AdmissionReceipt")%></td></tr> --%>
 <tr class='tablelight'><td colspan=2 align=center class=tablebold><font color='#000000'><%=bundle.getString("label.admisionprocessprintpreview.AdmissionReceipt")%></td></tr>
 
<tr class='tablelight'><td colspan=2 align=center></td></tr>

<tr><td >
<table border=1 cellpadding=5 cellspacing=0 width="100%" align=center>
		<tr><td width="35%" class=tablelight><font color='#000000'><b><%=bundle.getString("label.admisionprocessprintpreview.ApplicationNo")%>.</b></td><td class=tablelight><font color='#000000'><%=applicationno%></td></tr>
		<tr><td width="35%" class=tablelight><font color='#000000'><b><%=bundle.getString("label.admisionprocessprintpreview.Standard")%></b></td><td class=tablelight><font color='#000000'><%=standardnamegp%></td></tr>
		<tr><td width="35%" class=tablelight><font color='#000000'><b><%=bundle.getString("label.admisionprocessprintpreview.ApplicantName")%></b></td><td class=tablelight><font color='#000000'><%=applicantname%></td></tr>
		<tr><td width="35%" class=tablelight><font color='#000000'><b><%=bundle.getString("label.admisionprocessprintpreview.BoardName")%></b></td><td class=tablelight><font color='#000000'><%=req_boardname%></td></tr>
		<tr><td width="35%" class=tablelight><font color='#000000'><b><%=bundle.getString("label.admisionprocessprintpreview.AcademicYear")%></b></td><td class=tablelight><font color='#000000'><%=req_sessionname%></td></tr>

		<tr><td width="35%" class=tablelight><font color='#000000'><b><%=bundle.getString("label.admisionprocessprintpreview.AdmissionFees")%></b></td><td class=tablelight><font color='#000000'><%= formattedCurrency %></td></tr>
	</table>
	</td></tr>
		<tr><td>
	<table align=right>
	<br>
		<tr class='tablelight' align=right>
		<td align=left width=50%>
				<%-- <font color='#000000'><b><%=bundle.getString("label.admisionprocessprintpreview.CreatedBy")%></b> --%>
		</td>
		<td align=right  width=100%>
				<font color='#000000'><b><%=bundle.getString("label.admisionprocessprintpreview.Signature")%></b>
		</td>
		</tr>
	</table>
	</td></tr>
	<tr><td>
	<table>
		<tr class='tablelight'>
		<td align=left width=100%>
				<%-- <font color='#000000'><%=session.getValue("userfullname")%> --%>
		</td>
		<td align=right  width=100%>

		</td>
		</tr>
	</table>
	</td></tr>
	</table>
	
	<center>
<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >

	<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
	</center>
</form>

</body>
</html>
