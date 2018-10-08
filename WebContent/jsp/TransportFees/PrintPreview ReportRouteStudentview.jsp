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
<jsp:useBean id="query_object" scope="page" class="com.iGrandee.TransportFees.TransportStageAction" />
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

		

ArrayList studentList=new ArrayList();
ArrayList containList=new ArrayList();
HashMap hashmap=new HashMap();
HashMap innermap=new HashMap();
int count=0;
ArrayList Stagecount=null;

String studentapprovalid=null;String[] studentapprovalidarr=null;
%>

<%
if(request.getParameter("transportstagename")!=null){
%>
	<input type="hidden" name="transportstagename" value="<%=request.getParameter("transportstagename")%>" />


<%
}
%>
	       

		<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 align=center>
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>

		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td width="35%" valign=top align=center> <h3>Stage wise Students List</h3>	 
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
							
							
							<td width='20%' class='tablebold' align='left'>Stage Name</td>
							<td width='1%' class='tablebold'>:</td>
							<td class='tablelight' align='left'>
							
							<%=(request.getParameter("transportstagename"))%>
								
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
					        	<th scope="col" class="rounded" width="25%">Student Name</th>
					            <th scope="col" class="rounded" width="25%">Roll No.</th>
					            <th scope="col" class="rounded" width="25%">Standard Name</th>
					            <th scope="col" class="rounded" width="25%">Section Name</th>
					            
					            
					            <th scope="col" class="rounded-q4" width="30%">mobile No.</th>                                   
					        </tr>
					    </thead>
						<%
							studentapprovalid=request.getParameter("studentapprovalid");
							studentapprovalidarr=studentapprovalid.split(","); 
							if(studentapprovalidarr!=null){   
							for(int k=0;k<studentapprovalidarr.length;k++){	
							studentList=query_object.getstudentstandard(studentapprovalidarr[k]);
						if(studentList != null && studentList.size()>0){
							for(int y=0,j=1;y<studentList.size();y++,j++){
								count++;
								hashmap			= (HashMap)studentList.get(y);
								String Studname		= (String)hashmap.get("uname");
								String rollno		= hashmap.get("rollno")+"";
								if(rollno.equals("null")){
									rollno="<font color=red><i>-NYG-</i></font>";
									//rollNoNote = rollNoNote+1;
								}
								String mobilenumber		= hashmap.get("mobilenumber")+"";
								if(mobilenumber.equals("null"))
									mobilenumber="-";
								String emailid		= hashmap.get("emailid")+"";
								if(emailid.equals("null"))
									emailid="-";								
								
								String studallocationid	= (String)hashmap.get("studentallocationid");
								String personid	= (String)hashmap.get("personid");

								out.print("<tr class=tablelight>");
								out.print("<td>"+count+".</td>");
								out.print("<td>"+Studname+"</td>");
								out.print("<td>"+rollno+"</td>");
								out.print("<td>"+hashmap.get("standardname")+"</td>");
								out.print("<td>"+hashmap.get("sectionname")+"</td>");
								
								
								out.print("<td>"+mobilenumber+"</td>");
								out.print("</tr>");
							}
						}
						else
						{
							//out.print("<tr><td colspan='3' align='center'> Data Not Found</td></tr>");
							out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
						}
							
							
							
							}
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