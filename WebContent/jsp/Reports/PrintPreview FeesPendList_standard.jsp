<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Fees Pending List (Standard)| Powered by i-Grandee</title>
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
			//com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
		 	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
		 	int datacount=1;
			String applicantName=null;
			String applicationNo=null;
			String studentallocationId="";
			//String dateofallocation=null;
			String studentapprovalId="";
			String candidateregisterId=null;
			
			String feesPaid=null;
			String RemAmount=null;
			String feeStatus=null;
			
			String rollNo="";
			String sessionid=request.getParameter("req_sessionid");
	 		String boardid=request.getParameter("req_boardid");

	 		String yearofsession=request.getParameter("req_sessionname");
			String boardName=request.getParameter("req_boardname");
			ArrayList pendingFeesList= null;
			ArrayList pendingCountList= null;
			String formattedTermFeeCurrency=null;
		   // Locale localcurrency = new Locale("en", "IN");
		        ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
     Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
			pendingFeesList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesDetails(sessionid,boardid,instituteid);
	       %>

		<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>

		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center> Fees Pending List 
		</td></tr>
		<tr><td valign=top><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold' align='left'>Academic Year</td>
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
						<%
							if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
							{
							%>
							
							<tr class='tablebold' width='20%' height='23'>
									<td  class='tablebold'  align=right>ArchivalDetails &nbsp;</td>
									<td>:</td>
									<td colspan=4   class='tablelight' align=left><h2>This is an Archived Year</h2></td>
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
					        	<th scope="col" class="rounded-company" width="5%">Sl.No</th>
					            <th scope="col" class="rounded" width="25%">Term Name</th>
					            <th scope="col" class="rounded" width="20%">Term Fees</th>
					            <th scope="col" class="rounded" width="20%">Due Date</th>
					            <th scope="col" class="rounded-q4" width="30%">No.of Students Pending</th>                                   
					        </tr>
					    </thead>
						<% 
		ArrayList standardList = new ArrayList();
		int count = 0;
		int totPendingCount = 0;
		if(pendingFeesList.size()!=0)
		{

			for(int i=0;i<pendingFeesList.size();i++)
			{
				HashMap map					=	(HashMap)pendingFeesList.get(i);
				String standardName			=	(String) map.get("standardname");
				String standardscheduleId	=	(String) map.get("standardscheduleid");				
				String groupName			=	(String) map.get("groupname");
				String termfeesId			=	(String) map.get("termfeesid");				
				String termfeesAmount		=	(String) map.get("termfeesamount");
				String termName				=	(String) map.get("termname");
				String dueDate				=	(String) map.get("duedate");
				
				
			    Long termFeeObj 			= Long.valueOf(termfeesAmount); 
			    NumberFormat termFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			    formattedTermFeeCurrency 	= termFeeFormat.format(termFeeObj);
			    
				if(groupName!=null)
					standardName = standardName+" - "+groupName;
				if(!standardList.contains(standardName))
				{
					count=0;
%>
<tr><td  colspan=5 class="tableheading">
<table class=tablebold border=0 cellpadding=0 cellspacing=0 align=center width="100%" rules=groups>
<tr><td>
<font size='2'><b>Standard :</b></font><%=standardName%>
</td></tr>
</table>
</td></tr>
    
	<%
	 
	boolean flag = false;
			}
					
				pendingCountList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesPending(standardscheduleId,termfeesId);
				int pendingCount = 0;
				
				if(pendingFeesList.size()!=0)
				{
					//pendingCount = 0;
				for(int j=0;j<pendingCountList.size();j++)
				{
					HashMap pendingMap			= (HashMap)pendingCountList.get(j);
					String pendingStatus		= (String)pendingMap.get("pendingstatus");
					//System.out.println("pendingMap-->"+pendingMap+"pendingStatus-->"+pendingStatus);
					if( pendingStatus.equals("1"))
					{
						pendingCount = pendingCount+1;
					}
					
				}
				//System.out.println("pendingCount-->"+pendingCount);
				
				}
				datacount++;
				count = count+1;
				totPendingCount = totPendingCount + pendingCount;
				out.print("<tr class='tablelight' ><td>"+(count)+"</td><td>"+termName+"</td><td>"+formattedTermFeeCurrency+"</td><td>"+dueDate+"</td>");
				out.print("<td align=center  >"+pendingCount+"</td></tr>");
				standardList.add(standardName);	
			}
			}
		else
		{
	 		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");

		}
			//out.print("<tr><td colspan=5></td></tr><tr><td class=tablebold align=right colspan=4>Total No. of Pending</td><td align=center >"+totPendingCount+"</td></tr>");
		%>
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
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>