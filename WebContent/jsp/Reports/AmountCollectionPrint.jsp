<%
	ResourceBundle bundle  = ResourceBundle.getBundle("resources.ApplicationResources");
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" import="java.util.*" %>
<html>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=bundle.getString("label.reports.finanicialreports")%></title>
</head>
<body bgcolor="#ffffff" topmargin=10 leftmargin=0 rightmargin=0 onload="window.print()">
<%

ArrayList applicantList= null;


//out.println(applno);

//int rep=Integer.parseInt(applno);
//valueList=registrationProcess.getApplicantDetails(applno);
    	  String instituteid = (String)session.getValue("instituteid");

    	  //applicantList = registrationProcess.loadApplicantList(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),request.getParameter("standardpublishid"),"A");
    	  //applicantList = registrationProcess.loadApplicantListDatewise(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),request.getParameter("standardpublishid"),"A",request.getParameter("appFrom"),request.getParameter("appTo"),instituteid);

//out.println("select a.*,'-' as coursename,'-' as coursepublishid from applicationissue_tb a where a.applicationno='"+applno+"' and a.coursepublishid is null");

Date d=new Date();
int month=1+d.getMonth();
int year= 1900+d.getYear();
String date=d.getDate()+" - "+month+" - "+year;
InstitutionQurey insquery=new InstitutionQurey();
ArrayList insdetails=insquery.getInstituteDetails(instituteid);
String process = request.getParameter("req_process");
%>
		<table  border=0  width=640 >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
<table border=0 cellpadding=0 cellspacing=0 width="100%" align=center height=100>
<tr>
<td>
		<!--<tr valign=top>
			<td class="tablebold" colspan=4 align=center>
				<font color="#000000"><b><%=session.getValue("institutename")%></b> 
			</td>
		</tr>  -->
				<tr><td colspan=2 class=tablebold  align=center><u><%=bundle.getString("label.reports.finanicialreports")%></u></td></tr>
		
		<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td class=tablebold width="25%"><%=bundle.getString("label.schedule.academicyear")%></td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
	</tr>
	
	<tr><td colspan=2>&nbsp;</td></tr>
	<tr><td colspan=2>&nbsp;</td></tr>
	
			<tr>
			<%
			if(process.equals("today"))
			{%>

			<td class=tablebold width="25%"><%=bundle.getString("label.schedule.todaydate")%></td><td class=tablelight ><%=request.getParameter("appFrom") %></td>
			<td colspan=2></td>
			<%}
			else if(process.equals("fromtodate"))
			{%>
				<td class=tablebold width="25%"><%=bundle.getString("label.schedule.fromdate")%></td><td class=tablelight ><%=request.getParameter("appFrom") %></td>
				<td class=tablebold width="25%"><%=bundle.getString("label.schedule.todate")%></td><td class=tablelight><%=request.getParameter("appTo") %></td>
			<%}
			else if(process.equals("month"))
			{%>
			<td class=tablebold width="25%"><%=bundle.getString("label.schedule.month")%></td><td class=tablelight ><%=request.getParameter("req_month") %></td>
			<td colspan=2></td>

			<%}%>
			</tr>
			
			<tr><td colspan=2>&nbsp;</td></tr>
			
	<% 
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
	%>
							<tr>
							<td width='25%' class='tablebold' ><%=bundle.getString("label.schedule.archivaldetails")%></td>
							<td class='tablelight' align=left colspan=3>
								<h4><%=bundle.getString("label.schedule.archivalmessage1")%></h4>
							</td>
						</tr>
	<%}%>						
	</Table><br>
</td>
</tr>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Report.Reports,java.text.NumberFormat,java.util.Locale,com.iGrandee.Registration.InstitutionQurey"%>
    	<table>
		<table id="rounded-corner" border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>    	
    	<tr>
        	<td width="5%" class=tablebold><%=bundle.getString("label.schedule.slno")%></td>
            <td width="25%" class=tablebold><%=bundle.getString("label.schedule.amountcollectedfrom")%></td>
            <td width="20%" class=tablebold align=center><%=bundle.getString("label.applicationreport.AmountCollected")%></td>
        </tr>
     <%
     Reports reportQuery			= new Reports();
	  //out.print(applicantList);
	  java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
	    //Locale localcurrency = new Locale("en", "IN");

		ArrayList 	collectionList		=null;
		int totalAmount = 0;
		String amount      = null;
		String appTotCostCurrency = null;
		String totCostCurrency = null;
		String checkBoxParamet = "";
		String collectFrom = "";
		
		if(request.getParameter("req_sessionid") != null && request.getParameter("appFrom") != null && request.getParameter("appTo")!= null) {
			collectionList = reportQuery.getAmountCollection(request.getParameter("req_sessionid"),request.getParameter("appFrom"),request.getParameter("appTo"));
		}
		
	     String chkBoxVal = request.getParameter("req_chkBoxId");
		 if(chkBoxVal != null)
		 {
			 	String[] chkBoxId = chkBoxVal.split("@");  
				for(int j=0;j<(chkBoxId.length);j++){
					//String[] var=null;
					//regId=chkBoxId[j].split("@");
					//out.print(chkBoxId[j]);
					if(chkBoxId[j].equals("AI"))
						collectFrom = "Application Issue";
					if(chkBoxId[j].equals("AD"))
						collectFrom = "Admission";
					if(chkBoxId[j].equals("FC"))
						collectFrom = "Fees Collection";
					
					
				   	 if(collectionList!=null && collectionList.size()>0)
						{
						 	HashMap collectionListMap=(HashMap)collectionList.get(0);
							amount      = (String)collectionListMap.get(chkBoxId[j]);
							
							if(amount==null || amount.equals("null")){
								amount = "0";
							}
							else
							{
								totalAmount += Integer.parseInt(amount);
							}
						}
				   	 
					    Long appTotCostObj 					= Long.valueOf(amount); 
						NumberFormat appTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
						appTotCostCurrency 					= appTotCostObjFormat.format(appTotCostObj);

						
					out.print("<tr><td class=tablelight >"+(j+1)+"</td><td class=tablelight >"+collectFrom+"</td><td class=tablelight align=right>"+appTotCostCurrency+"</td></tr>");
					
				}
				
			    Long totCostObj 					= Long.valueOf(totalAmount+""); 
				NumberFormat totCostObjFormat 		= NumberFormat.getCurrencyInstance(localcurrency);
				totCostCurrency 					= totCostObjFormat.format(totCostObj);

				out.print("<tr><td colspan=3></td></tr><tr><td class=tablebold colspan=2 align=center>"+bundle.getString("label.applicationreport.Total")+"</td><td class=tablelight align=right>"+totCostCurrency+"</td></tr>");
				//out.print("<tr><td colspan=3></td></tr><tr><td class=tablebold colspan=1></td><td class=tablebold colspan=1>"+bundle.getString("label.applicationreport.Total")+"</td><td style='background-color:lightblue'>"+totCostCurrency+"</td></tr>");
					
		//studentList			= attencequery.loadstudent(standardscheduleid,sessionid,sectionscheduleid,instituteid);
		}
 	 	else{
 	 		
 	 		String[] chkBoxId=null;
 	 		
 	 		out.print(request.getParameter("req_chkBoxId").length());
 	 		out.println("<tr align='center' class='tablebold'><td colspan='3'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");
  			//out.println("<tr><td colspan=7>Data not found</td></tr>");    	 
 	 	}
			%>
			</table>			
			<tr><td>&nbsp;</td></tr>
<tr><td colspan=5>
<table width=100% border=0>
	<tr class='tablelight'>	
	<td align=left width=100%>
			<font color='#000000'><b><%=bundle.getString("label.schedule.createdby")%></b>
	</td>
	<td>&nbsp;</td>
	<td align=right  width=100%>
			<font color='#000000'><b><%=bundle.getString("label.schedule.signature")%></b>
	</td>
	</tr>
</table>
</td></tr>
<tr><td>
<table>
	<tr class='tablelight'>	
	<td align=left width=100% colspan=5>
			<font color='#000000'><%=session.getValue("userfullname")%>
	</td>

	</tr>
</table>
</td></tr>
</table>

</html>