<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Fee Structure | Powered by i-Grandee</title>
<LINK rel=stylesheet href="<%=request.getContextPath()%>/css/kyccss.css">
<script type="text/javascript">
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
<body>
<%@ page import=" java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,com.iGrandee.Fees.FeesSchedule,java.text.NumberFormat,java.util.Locale"%>	
<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey"%>
<%
			String	status  = "A";
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
			 	status = "D";
		
			}
		%>		
<form name="StudentReport_Form" action="" method="post">
<%
int datacount=0;
String instituteid		= (String)session.getValue("instituteid");
InstitutionQurey insquery=new InstitutionQurey();	
ArrayList insdetails=insquery.getInstituteDetails(instituteid);
ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
      ArrayList termfeesscheduleList = null;
     ArrayList feesheadscheduleList = null;
	//String sectionid				= (String)session.getValue("sectionscheduleid");
	//String studentid				= (String)session.getValue("studentid");
	HashMap	hashmap					= null;
	  int termtotalamount =0;
	  int headtotalamount =0;
	     String formattedCurrency = null;
	    // Locale localcurrency = new Locale("en", "IN");
	 	String sessionname			= request.getParameter("req_sessionname");
		String boardname			= request.getParameter("boardname");
		String standardschedulename	= request.getParameter("req_standardnamegp");
    	//String standardscheduleid = (String)session.getValue("standardscheduleid");
    	String standardscheduleid = request.getParameter("standardpublishid");
    	  
     try
     { 
    	 termfeesscheduleList = feesscheduleQuery.loadTermFeesDetails(standardscheduleid);
    	 feesheadscheduleList = feesscheduleQuery.loadFeesHeadDetails(standardscheduleid);
    }catch(Exception e){}	
%> 
<form name="Schedule_Form" action="" method="post">
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
		<table  border=0  width=640 >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>

		</td></tr>
		
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center><%=bundle1.getString("label.reports.feesstructure")%>
		</td></tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr align='left'>
				<td width='25%' class='tablebold' align='left'><%=bundle1.getString("label.schedule.academicyear")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' align='left'>
				<%=sessionname%>
				</td>
				<td width='5%' class='tablebold' align='left'><%=bundle1.getString("label.schedule.board")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' width='40%' align='left'>
					<%=boardname%>
				</td>
			</tr>
			<tr align='left'>
				<td width='20%' class='tablebold'  align='left'><%=bundle1.getString("label.schedule.standardname")%></td>
				<td width='1%' class='tablebold'>:</td>
				<td class='tablelight' align='left'>
					<%=standardschedulename%>
				</td>
			</tr>
			
		    	<%
			if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
		%>
		<tr>
			<td width='20%'  class='tablebold'><%=bundle1.getString("label.schedule.archivaldetails")%></td>
			<td width='1%' class='tablebold'>:</td>
			<td valign=top class='tablelight'  colspan=4>
				<h2><%=bundle1.getString("label.schedule.archivalmessage1")%></h2>
			</td>
		</tr>
		</table>
		<%		
			}
		%>		
		<br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='20%' >
					<table id="rounded-corner" border=0 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
					    
					    <tr>
					    <td valign=top>
						<table border=1 cellpadding=5 cellspacing=0 width="100%">
		        <tr><td colspan=2 class=tablebold align=center> <%=bundle1.getString("label.schedule.termwiseamount")%></td></tr>
		     
		    <tr class=tableheading><td> <%=bundle1.getString("label.schedule.termname")%></td><td align=right><%=bundle1.getString("label.schedule.amount")%></td></tr>
		   	    	<%
			
					if(termfeesscheduleList!=null && termfeesscheduleList.size()>0)
			    	{ int inc = 1;
			    	for(int y=0;y<termfeesscheduleList.size();y++){
						
			    		HashMap termfeesscheduleListMap		= (HashMap)termfeesscheduleList.get(y);
						
			    		String termname     = (String)termfeesscheduleListMap.get("termname");
			    		String termid      = (String)termfeesscheduleListMap.get("termid");
			    		String termfeesid      = (String)termfeesscheduleListMap.get("termfeesid");
			    		String termfeesamount      = (String)termfeesscheduleListMap.get("termfeesamount");
			    	%>
				<tr>
					<td class=tablebold><%= termname%></td>
					<td class=tablelight><%= termfeesamount%></td>
				</tr>
				<%
				headtotalamount +=Integer.parseInt(termfeesamount);
				datacount++;

			    	}
			    	Long lObj2 = Long.valueOf(headtotalamount);
				    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
				    formattedCurrency = format.format(lObj2);
			    	out.println("<tr><Td class='tablebold' >"+bundle1.getString("label.schedule.total")+"</td><td>"+formattedCurrency+"</td></tr>");
			    }else{
			    	out.println("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>"+bundle1.getString("label.schedule.datanotfound")+"</font></td></tr>");
					//out.println("<tr><td colspan=2 align=center>"+bundle1.getString("label.schedule.datanotfound")+"</td></tr>");
				}%>
				</table>
		</td>
		<td width="50%" valign=top>
		  <table border=1 cellpadding=5 cellspacing=0 width="100%">
   <tr><td colspan=2 class=tablebold align=center> <%=bundle1.getString("label.schedule.feesheadwiseamount")%></td></tr>
    <tr  class=tableheading><td> Head Name</td><td><%=bundle1.getString("label.schedule.amount")%></td></tr><%
	
			if(feesheadscheduleList!=null && feesheadscheduleList.size()>0)
	    	{ int inc = 1;
	    	for(int y=0;y<feesheadscheduleList.size();y++){
				
	    		HashMap feesheadscheduleListtMap		= (HashMap)feesheadscheduleList.get(y);
				
	    		String feesheadid     = (String)feesheadscheduleListtMap.get("feesheadid");
	    		String feesheadname      = (String)feesheadscheduleListtMap.get("feesheadname");
	    		String feesscheduleamount      = (String)feesheadscheduleListtMap.get("feesscheduleamount");
	    	%>
		<tr>
			<td  class=tablebold><%= feesheadname%></td>
			<td class=tablelight><%= feesscheduleamount%></td>
		</tr>
		<%
		termtotalamount +=Integer.parseInt(feesscheduleamount);
		datacount++;
	    	}
	    	Long lObj2 = Long.valueOf(termtotalamount);
		    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
		    formattedCurrency = format.format(lObj2);
	    	out.println("<tr><Td class='tablebold' >"+bundle1.getString("label.schedule.total")+"</td><td>"+formattedCurrency+"</td></tr>");
	    }else{
			out.println("<tr><td colspan=2 align=center>"+bundle1.getString("label.schedule.datanotfound")+"</td></tr>");
		}%>
		
	</table>
					</td>
					</tr>        
					</table>
				</td></tr>
					
		</table>
		</td></tr>
		<tr align=center><td>&nbsp;
		</td></tr>
		<tr align=center><td>
		<% 
		if(datacount>0){
		%>	
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value='<%=bundle1.getString("label.schedule.print")%>' >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value='<%=bundle1.getString("label.schedule.close")%>' >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>