<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="applicationQuery" scope="page" class="com.iGrandee.Application.ApplicationQuery"/>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale" %>
<html>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />
<head>
<% 	java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Application Receipt	</title>

<script language="javascript">

function goBack()
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
 <body bgcolor="#ffffff" topmargin=10 leftmargin=0 rightmargin=0 onload="window.print()">

<!-- <body bgcolor="#ffffff" topmargin=10 leftmargin=0 rightmargin=0>
 --><%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,com.iGrandee.Fees.FeesSchedule,java.text.NumberFormat,java.util.Locale"%>	

<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.Common.DateTime"%>

<%
InstitutionQurey insquery=new InstitutionQurey();
ArrayList valueList= null;
String receipt= "";
String applno = "";
String standardnamegp = "";
String instituteid		= (String)session.getValue("instituteid");
//receipt=request.getParameter("receipt");
applno=request.getParameter("applno");
standardnamegp=request.getParameter("standardnamegp");


//out.println(applno);

//int rep=Integer.parseInt(applno);
valueList=applicationQuery.getApplicantDetails(applno);
ArrayList insdetails=insquery.getInstituteDetails(instituteid);

//out.println("select a.*,'-' as coursename,'-' as coursepublishid from applicationissue_tb a where a.applicationno='"+applno+"' and a.coursepublishid is null");

//Date d=new Date();
//int month=1+d.getMonth();
//int year= 1900+d.getYear();
//String date=d.getDate()+" - "+month+" - "+year;
%>
<!--  hidden by rams, as per the suriya's request change the print heder and size -->
<!-- <table border=0 cellpadding=0 cellspacing=0 width="350" align=center height=100>
 -->
 <table border=0 cellpadding=0 cellspac ing=0 width="640" align=center height=100>
 <tr>
<td>
	<table width="100%" border="0" cellspacing="0">
		<tr valign=top align=center>
			<td class="tablebold">
				<%-- <font color="#000000"><b><%=session.getValue("institutename")%></b> --%>
				<%@ include file="../include/reportprintheader.jsp"%>
				
			</td>
		</tr>

	</Table><br>
</td>
</tr>
<tr>
<td>
<table border="1" width="100%"  cellpadding="5" align=center cellspacing="0" cellspacing="0" >
<tr class='tablelight'><td colspan=2 align=center class=tablebold><font color="#000000"><b><%=bundle.getString("label.applicationissueprint.ApplicationReceipt")%></b></td></tr>
	<%
	//String temp=applicationQuery.receiptNo();

	%>
	<%

	String appId				= 	"";
	String applicantname		= 	"";
	String Applicationno		= 	"";
	String appCost				= 	"";
	String contactno			=	"";
	String standardpublishid	=	"";
	String standardname			=	"";
	String currentdate			=	"";
	String formattedCurrency 	= null;

	Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));

	if(valueList.size() > 0 )
	{
	for(int i=0;i<valueList.size();i++)
	{
		HashMap map=(HashMap)valueList.get(i);
		 appId=(String)map.get("applicationid");
		 applicantname=(String)map.get("applicantname");
		 Applicationno=(String)map.get("applicationno");
		 appCost=(String)map.get("cost");
		 String receiptno=(String)map.get("receiptno");
		 //corseType=(String)map.get("type");
		 contactno=(String)map.get("contactno");
		 standardpublishid=(String)map.get("standardpublishid");
		 standardname=(String)map.get("standardname");
		 currentdate = (String)map.get("currentdate");
		// String check=corseType.substring(0,1);

		String formattedAppCost = appCost+"";
		Long lObj2 = Long.valueOf(formattedAppCost);
		NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
    	formattedCurrency = format.format(lObj2);


		out.println("<tr class='tablelight'><td align='right' colspan=2 align=right class=tablelight><font color='#000000'><b>"+bundle.getString("label.applicationissueprint.Date")+" : </b>"+currentdate+"</td></tr>");
		out.println("<tr class='tablelight'><td class=tablelight><font color='#000000'><b>"+bundle.getString("label.applicationissueprint.ReceiptNo")+"</b></td><td><font color='#000000' class=tablelight>"+receiptno+"</td></tr>");
		out.println("<tr class='tablelight'><td class=tablelight><font color='#000000'><b>"+bundle.getString("label.applicationissueprint.AcademicYear")+"</b></td><td class=tablelight><font color='#000000'>"+request.getParameter("req_sessionname")+"</td></tr>");
		out.println("<tr class='tablelight'><td class=tablelight><font color='#000000'><b>"+bundle.getString("label.applicationissueprint.BoardName")+"</b></td><td class=tablelight><font color='#000000'>"+request.getParameter("req_boardname")+"</td></tr>");
		out.println("<tr class='tablelight'><td class=tablelight><font color='#000000'><b>"+bundle.getString("label.applicationissueprint.Standard")+"</b></td><td class=tablelight><font color='#000000'>"+standardnamegp+"</td></tr>");
		out.println("<tr class='tablelight'><td width='45%' class=tablelight><font color='#000000'><b>"+bundle.getString("label.applicationissueprint.ApplicantName")+"</b></td><td class=tablelight><font color='#000000'>"+applicantname+"</td></tr>");
		out.println("<tr class='tablelight'><td class=tablelight><font color='#000000'><b>"+bundle.getString("label.applicationissueprint.ApplicationNo")+".</b></td><td class=tablelight><font color='#000000'>"+Applicationno+"</td></tr>");
		out.println("<tr class='tablelight'><td class=tablelight><font color='#000000'><b>"+bundle.getString("label.applicationissueprint.ApplicationFee")+"</b></td><td class=tablelight><font color='#000000'>"+formattedCurrency+"</td></tr>");

		//out.println("<tr><td colspan='3' align='center'><input type='button' value='Print' class='buttons'></td></tr>");

	}
}
else
{
	out.println("<tr align='center' class='tablebold'><td><font color='red'>Data Not Found</font></td></tr>");
	//out.println("<tr><td><font color='#000000'>Data not found</td></tr>");
}
	%>
</table>
</td></tr>
<tr><td>
<table border="0" align=right>
	<br>
	<tr class='tablelight'>
	<td align=left width=50%>
	<!-- as per the suriya's request hidden the followning changes -->
			<%-- <font color='#000000'><b><%=bundle.getString("label.applicationissueprint.CreatedBy")%></b> --%>
	</td>
	<td align=right  width=100%>
			<font color='#000000'><b><%=bundle.getString("label.applicationissueprint.Signature")%></b>
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
</html>