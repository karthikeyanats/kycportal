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
String instituteid		= (String)session.getValue("instituteid");
ArrayList insdetails=insquery.getInstituteDetails(instituteid);

String transportfeestypeid = null;
String sessionid    = null;String institutetransporttypeid=null;
sessionid= request.getParameter("sessionid");
String paidstatus = null;
institutetransporttypeid= request.getParameter("institutetransporttypeid");
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
 <td><a class=tablebold> Academic Year </a> <a class=tablelight><%=request.getParameter("sessionname") %></td>
 
 </tr>
<tr>
<td>
<table border=1 cellpadding=5 cellspacing=0 summary="Examname List" width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded" width="30%">Category</th>
            <th scope="col" class="rounded" width="30%">No.of Paid Students</th>
        	<th scope="col" class="rounded-q4" width="30%">No.of Pending Students</th>
        </tr>
    </thead>
    

     
     <tbody> 	
     <jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.FeesSettingsAction" />
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>
     		 <%
			     FeesSettingsAction  transportmonth = new FeesSettingsAction();			     
			     ArrayList Loadtransportmonth = null;String transportcategoryname =null;
			     String transportcategoryid=null; ArrayList paycountlist=null;
					int payno=0;int notpayno=0;

			     HashMap innermap=null; 
				     try
				     {
				    	 Loadtransportmonth = transportmonth.getcatname(institutetransporttypeid,sessionid);
					    	 ArrayList archivalDetails = new ArrayList();
					    	 String paid=null; String notpaid= null;
					    	 if(Loadtransportmonth!=null && Loadtransportmonth.size()>0)
								{
					    		 
					    		 for (int i = 0, j = 1; i < Loadtransportmonth.size(); i++) {
								
									HashMap feestypeListMap=(HashMap)Loadtransportmonth.get(i);
									 transportcategoryname   = (String)feestypeListMap.get("transportcategoryname");
									 transportcategoryid   	= (String)feestypeListMap.get("transportcategoryid");
									 
									%> 
								<%
									out.println("<tr class=tablelight>");
									out.println("<td>"+j+++"</td>"); 
									out.println("<td>"+transportcategoryname+"</td>");								
									
									
									/* notpayno=transportmonth.getnotpaidcount(transportcategoryid);
									payno=transportmonth.getpaidcount(transportcategoryid); */
									ArrayList paidstate = transportmonth.listpaymentdetails(transportcategoryid,sessionid);
									//out.println("paidstate===>>>"+paidstate);
									
									  if(paidstate!=null && paidstate.size()>0)
										{
										 HashMap paidstateMap=(HashMap)paidstate.get(0);
										 paidstatus = (String)paidstateMap.get("paidstatus");
										 //out.println("paidstatus===>>>"+paidstatus);
										 if(paidstateMap.get("paid") ==null)
											 	paid = "0";
										 else
											 paid   = (String)paidstateMap.get("paid");
										
										 if(paidstateMap.get("notpaid") ==null)
											 notpaid = "0";
										 else
											 notpaid   = (String)paidstateMap.get("notpaid");
										 
										 if(paid.equals("0"))
										 {
											 out.println("<td>"+paid+"</td>");
										 }
										 else
										 {
											 out.println("<td>"+paid+"</td>");
										 }
											//out.println("<td><a href='#' transportcategoryid='"+transportcategoryid+"' transportcategoryname='"+transportcategoryname+"' paidstatus='paid' onclick='showstudents(this)'>"+paid+"</a></td>");
											if(notpaid.equals("0"))
										 {
											 out.println("<td>"+notpaid+"</td>");
										 }
										 else
										 {
											 out.println("<td>"+notpaid+"</td>");
										 }
											
										}
									 else
									 {
										 out.println("<td>0</td><td>0</td>");
									 }
										
									out.println("</tr>");
					    		 }
							}
					    	 
					    	 else{
								out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					    	 }
				     }	 
					catch(Exception e){
						
						e.printStackTrace();
						
					}
			     %>
    </tbody>
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