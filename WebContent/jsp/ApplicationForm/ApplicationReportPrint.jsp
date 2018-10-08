<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%@ page language="java" import="java.util.*" %>
<html>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><%=bundle.getString("label.applicationreportviewdatewisecons.title")%></title>
</head>
<body bgcolor="#ffffff" topmargin=10 leftmargin=0 rightmargin=0 onload="window.print()">
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale,com.iGrandee.Registration.InstitutionQurey"%>

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

%>
		<table  border=0  width="640"  align=center>
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey></td></tr>
		
		<tr>
		<td valign=top align=center><u><%=bundle.getString("label.applicationreportviewdatewisecons.title")%></u>
		</td>
		</tr>				
	<tr><td>
<table border=0 cellpadding=0 cellspacing=0 width="100%" align=center height=100 align=center>
<tr>
<td>

		<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td class=tablebold width="25%"><%=bundle.getString("label.applicationreport.AcademicYear")%></td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold><%=bundle.getString("label.applicationreport.Board")%> </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>
	</tr>
		<tr><td colspan=2>&nbsp;</td></tr>
	<tr><td class=tablebold width="25%"><%=bundle.getString("label.applicationreport.Standard")%></td><td class=tablebold width='2%'>:</td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
	
			<tr><td colspan=2>&nbsp;</td></tr>
	<tr>
		<td class=tablebold width="25%">From date</td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=request.getParameter("appFrom") %></td>
		<td class=tablebold width="25%">To Date</td><td class=tablebold width='2%'>:</td><td class=tablelight><%=request.getParameter("appTo") %></td>
	</tr>
	<% 
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
	%>
							<tr>
							<td width='25%' class='tablebold' >Archival Details</td>
							<td class=tablebold width='2%'>:</td>
							<td class='tablelight' align=left colspan=3>
								<h2>This is an Archived Year</h2>
							</td>
						</tr>
	<%}%>					
	</Table><br>
</td>
</tr>
<tr><td>
		<table id="rounded-corner" border=1 summary="Department List" width="100%" align=center  cellspacing=0 cellpadding=5 bordercolor=grey>   
    	<tr>
        	<td width="5%" class=tablebold><%=bundle.getString("label.applicationreport.SL.No")%></td>
            <td width="25%" class=tablebold><%=bundle.getString("label.applicationreport.ApplicantName")%></td>
            <td width="20%" class=tablebold><%=bundle.getString("label.applicationreport.ApplicationNo")%></td>
            <td width="25%" class=tablebold><%=bundle.getString("label.applicationreport.ApplicationFees")%></td>
            <td width="25%" class=tablebold><%=bundle.getString("label.applicationreport.DateofIssue")%></td>                      
        </tr>
     <%
     com.iGrandee.Application.RegistrationProcess  registrationProcess = new com.iGrandee.Application.RegistrationProcess();
//out.print(request.getParameter("req_sessionid")+"--"+request.getParameter("req_boardid")+"--"+request.getParameter("standardpublishid")+"--"+"A"+"--"+request.getParameter("appFrom")+"--"+request.getParameter("appTo")+"--"+instituteid);	
	  applicantList = registrationProcess.loadApplicantListDatewise(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),request.getParameter("standardpublishid"),"A",request.getParameter("appFrom"),request.getParameter("appTo"),instituteid);
	  //out.print(applicantList);
		java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
	    //Locale localcurrency = new Locale("en", "IN");


	  	String substCostofApplication 	  = null;
		 int costofApplication 	  = 0;
	     String appCostCurrency = null;
    	 if(applicantList!=null && applicantList.size()>0)
			{
    		 for (int i = 0, j = 1; i < applicantList.size(); i++) {
			
				HashMap applicantListMap=(HashMap)applicantList.get(i);
				String applicationId      = (String)applicantListMap.get("applicationid");
				String applicantName      = (String)applicantListMap.get("applicantname");
				String applicationNo      = (String)applicantListMap.get("applicationno");
				String costofApp		  = (String)applicantListMap.get("cost");
				String contactNo		  = (String)applicantListMap.get("contactno");
				String receiptNo		  = (String)applicantListMap.get("receiptno");
				String dateofcreation     = (String)applicantListMap.get("dateofcreation");
				
				if(costofApp.contains("."))
					substCostofApplication 	  = costofApp.substring(0,costofApp.lastIndexOf("."));
				else
					substCostofApplication    = costofApp;
						
			    costofApplication 	  	  		= Integer.parseInt(substCostofApplication);
				Long appCostObj 				= Long.valueOf(costofApplication); 
				NumberFormat appCostObjFormat	= NumberFormat.getCurrencyInstance(localcurrency);
				appCostCurrency 				= appCostObjFormat.format(appCostObj);
				%>
				
			<tr class='tablelight'>
        	 <td><%=j++ %></td>
            <td><%=applicantName %></td>
            <td><%=applicationNo %></td>
            <td><%=appCostCurrency %></td>           
            <td><%=dateofcreation %> </td>
        
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=7>Data not found</td></tr>");    	 
    	 	}
			%>
			</table>
			<tr><td>&nbsp;</td></tr>
<tr><td colspan=5>
<table width=100% border=0>
	<tr class='tablelight'>	
	<td align=left width=50%>
			<%-- <font color='#000000'><b><%=bundle.getString("label.applicationreport.CreatedBy")%> --%></b>
	</td>
	<td align=right  width=100%>
			<font color='#000000'><b><%=bundle.getString("label.applicationreport.Signature")%></b>
	</td>
	</tr>
</table>
</td></tr>
<tr><td>
<table>
	<tr class='tablelight'>	
	<td align=left width=100% colspan=5>
			<%-- <font color='#000000'><%=session.getValue("userfullname")%> --%>
	</td>

	</tr>
</table>
</td></tr>
</table>

</html>