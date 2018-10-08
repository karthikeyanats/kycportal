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
	alert("Successfully Printed");
	document.getElementById("printbutt").style.visibility='visible';
	document.getElementById("backbutt").style.visibility='visible';	
	}
	
</script>
</head>
<body>
<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>
<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey"%>
<jsp:useBean id="query_object" scope="page" class="com.iGrandee.TransportFees.TransportRouteAction" />
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
	       
	       <%
ArrayList RouteList=new ArrayList();
HashMap sessionMap=new HashMap();
String roleids="";
if(session.getValue("instituteid")!=null){
	instituteid=(String)session.getValue("instituteid");
} 

String transportrouteid = null;

if(request.getParameter("transportrouteid")!=null){
	transportrouteid=request.getParameter("transportrouteid");
	
}

String routename = null;

if(request.getParameter("routename")!=null){
	routename=request.getParameter("routename");
	
}

ArrayList Stagecount=null;

RouteList=query_object.gettransportroutestagecount(transportrouteid); 
%>
	       

		<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 align=center>
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>

		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center><h3>Stage wise Students Counts</h3> 	 
		</td></tr>
		<tr><td valign=top><br></br>		
		<table  border=0 width=100% cellspacing=0 cellpadding=0 >
			
		    <tr>
		    	<td  align= center>
					<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
						<tr>
							<td width='20%' class='tablebold' align='left'>Route Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
							
							<%=routename %>
								
							</td>
							</tr>						
								
					</table>					    	
		    	</td>
		    </tr>
		</table>
		<br></br>
		<table width='100%' align='center' border='0' >
			<tr>
				<td width='20%' >
					<table id="rounded-corner" border=1 summary="Department List" width="100%" cellspacing=0 cellpadding=5 bordercolor=grey>   
					    <thead>
					    	<tr>
					        	<th scope="col" class="rounded-company" width="5%">Sl.No</th>
					            <th scope="col" class="rounded" width="25%">Stage Name</th>
					            <th scope="col" class="rounded-q4" width="30%">No.of.Students</th>                                   
					        </tr>
					    </thead>
						<% 
				int count=0;int stcount=0;
				if(RouteList!=null && RouteList.size()>0)	
				{	String as=request.getContextPath();						

					for(int i=0;i<RouteList.size();i++)
					{
						count++;
						sessionMap=(HashMap)RouteList.get(i);
						
						out.print("<tr valign='top'>");
						stcount=Integer.parseInt(sessionMap.get("total")+"");
						out.print("<td class='tablelight' valign='top' align='center'>"+(count)+".</td>");
						out.print("<td class='tablelight' valign='top' align='center'>"+sessionMap.get("transportstagename")+"</td>");
						if(stcount!=0)
							out.print("<td class='tablelight' valign='top' align='center'>"+sessionMap.get("total")+"</td>");
						else
							out.print("<td class='tablelight' valign='top' align='center'>"+sessionMap.get("total")+"</td>");
				} 
				}
				else
				{ 
					out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");


				} 
				

				%>
		</table>
		</td></tr>
		</table>
		</td></tr>
		<tr align=center><td>&nbsp;
		</td></tr>
		<tr align=center><td>
		<% 
		if(count>0){
		%>	
			<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >
		<%}%>
		<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
		
		</td></tr>
		</table>
		</form>		
</body>

</html>	