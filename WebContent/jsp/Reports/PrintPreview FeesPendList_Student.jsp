<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Fees Pending List | Powered by i-Grandee</title>
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
<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>
<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey"%>
<%
		InstitutionQurey insquery=new InstitutionQurey();
		String instituteid			= (String)session.getValue("instituteid");
		ArrayList insdetails=insquery.getInstituteDetails(instituteid);
	 	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
		String applicantName=null;
		String studentallocationId="";
		String studentapprovalId="";
		String candidateregisterId=null;
		
		String feesPaid=null;
		String RemAmount=null;
		String sectionName=null;
		String termfeesAmount=null;
		String feeStatus=null;
		int datacount=0;
		String rollNo="";
		int rollNoNote = 0;
		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String stdName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		ArrayList pendingFeesList= null;
		pendingFeesList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesPending(request.getParameter("standardpublishid"),request.getParameter("req_termfeesid"));
		String totTermFee=request.getParameter("req_termfeesamount");
	     //Locale localcurrency = new Locale("en", "IN");
	         ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
     Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
	     String formattedTotTermFeeCurrency = null;
	     String formattedFeesPaidCurrency = null;
	     String formattedRemAmountCurrency = null;	     
	   
	    Long totTermFeeObj = Long.valueOf(totTermFee);
	    NumberFormat totFeeFormat = NumberFormat.getCurrencyInstance(localcurrency);
	    formattedTotTermFeeCurrency = totFeeFormat.format(totTermFeeObj);

	
       %>

		<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center>Fees Pending Student List
		</td></tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr align='left'>
							<td width='20%' class='tablebold'  align='left'>Academic Year</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
							
							<%=yearofsession %>
								
							</td>
							<td width='20%' class='tablebold' align='left'>Board</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
								<%=boardName %>
							</td>
						</tr>
						<tr  align='left'>
							<td width='20%' class='tablebold' align='left'>Standard</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
							
							<%=stdName %>
								
							</td>
							<td width='20%' class='tablebold' align='left'>Term</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
								<%=request.getParameter("req_termfeesname")%>
							</td>
						</tr>
						<tr align='left'>
							<td width='20%' class='tablebold' align='left'>Due Date</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' width='20%' align='left'>
							
							<%=request.getParameter("req_duedate")%>
								
							</td>
							<td width='30%' class='tablebold' align='left'>Term Fees Amount</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
								<%=formattedTotTermFeeCurrency %>
							</td>
						</tr>
						<%
							if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
							{
							%>
							
							<tr class='tablebold' width='20%' height='23'>
									<td  class='tablebold'   align=left>ArchivalDetails &nbsp;</td>
									<td>:</td>
									<td colspan=3   class='tablelight' align=left><h2>This is an Archived Year</h2></td>
							</tr>
							<%  
							} 
						%>		
					</table>					    	
		    	</td>
		    </tr>
		</table>

		<br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='20%' >
					<table id="rounded-corner" border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
					    <thead>
					    	<tr>
					        	<th align=left width="7%">Sl.No</th>
            					<th  align=left width="22%">Student Name</th>
            					<th  align=left width="12%">Section</th>
            					<th align=left width="12%">Roll No.</th>
					            <th align=left  width="20%">Paid Amount</th>
					            <th  align=left  width="20%">Pending Amount</th>                                     
					        </tr>
					    </thead>
						<%
	 int count=0;
	boolean flag = false;
	//out.print("pendingFeesList-->"+pendingFeesList.size());
	if(pendingFeesList.size()!=0)
	{
		for(int i=0;i<pendingFeesList.size();i++)
		{
			
			HashMap map				=	(HashMap)pendingFeesList.get(i);
			studentapprovalId		=	(String) map.get("studentapprovalid");
			feesPaid				=	(String) map.get("FeesPaid");
			termfeesAmount			=	(String) map.get("termfeesamount");
			applicantName			=	(String) map.get("applicantname");
			studentallocationId		=	(String) map.get("studentallocationid"); 
			//applicationNo			=	(String) map.get("applicationno");			
			rollNo					=	(String) map.get("rollno");
			candidateregisterId		=	(String) map.get("candidateregisterid");
			//dateofallocation 		=	(String) map.get("dateofallocation");
			feeStatus				=	(String) map.get("feestatus");
			RemAmount				=	(String) map.get("RemAmount");
			sectionName				=	(String) map.get("sectionname");
			
			datacount++;
			if(rollNo==null){
				rollNo = "<font color=red><i>-NYG-</i></font>";
				rollNoNote = rollNoNote+1;
			}

			if(RemAmount==null)
				RemAmount = termfeesAmount;
			
			Double feesPaidObj = Double.valueOf(feesPaid); 
		    NumberFormat paidFormat = NumberFormat.getCurrencyInstance(localcurrency);
		    formattedFeesPaidCurrency = paidFormat.format(feesPaidObj);

		    Double remAmountObj = Double.valueOf(RemAmount);
		    NumberFormat pendingFormat = NumberFormat.getCurrencyInstance(localcurrency);
		    formattedRemAmountCurrency = pendingFormat.format(remAmountObj);

			
			
			
			if(feeStatus.equals("Pending")){
				count=count+1;	
			//out.print("<tr><td>"+(count)+"</td><td>"+applicantName+"</td><td>"+sectionName+"</td><td>"+applicationNo+"</td><td>"+rollNo+"</td><td>"+formattedFeesPaidCurrency+"</td><td>"+formattedRemAmountCurrency+"</td></tr>");
				out.print("<tr class='tablelight' ><td>"+(count)+"</td><td>"+applicantName+"</td><td>"+sectionName+"</td><td>"+rollNo+"</td><td>"+formattedFeesPaidCurrency+"</td><td>"+formattedRemAmountCurrency+"</td></tr>");
			}
		}
	}
	else
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	  }


	%>
		        
					</table>
				</td></tr>
					
		</table>
		</td></tr>

		<% 
		if(rollNoNote>0)
		{
		%>
		<br>
		<tr>
		<td valign=top>
			<b>Note: </b>&nbsp;NYG - Not Yet Generated</td>
		</tr>  
		<br>
		<%}%>						
				
		<tr align=center><td>&nbsp;
		</td></tr>
		<tr align=center><td>
		<% 
		if(datacount>0){
		%>	
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>