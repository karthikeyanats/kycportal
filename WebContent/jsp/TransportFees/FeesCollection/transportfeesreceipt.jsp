<html>
<head>
<style>
.tablelight{font-family:"Arial",Times,arial;font-size:10pt;font-style:normal;}
.tableboldfornotfound{font-family:"Arial",Times,arial;font-size:10pt;font-style:normal;font-color:red;font-weight:bold;}
.tablebold{font-family:"Arial",Arial,arial;font-size:10pt;font-weight:bold;}
.tableheading{font-family:"Arial",Arial,arial;font-size:10pt;font-weight:bold;background-color: #60c8f2;}
</style>
<script language="javascript">
function printfun()
{
	
	document.getElementById("printbut").style.display="none";
	document.getElementById("closebut").style.display="none";
	window.print();

}
</script>
</head>
<body bgcolor="white">
<%@page language="java" import="java.util.ResourceBundle"%> 
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
      <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale,com.iGrandee.Registration.InstitutionQurey"%>

<%
try{
	String transportstageid     = null;
	ArrayList feesScheduleList 				= null;
	ArrayList paidList = null;
	ArrayList transportDetails = null;
	ArrayList receiptdetails = null;
	String paidamount =null;
	String studentname= null;
	String sessionname= null;
	String sessionid=null;
	String userid= null;
	String discountamnt = null;
	String studentapprovalid = null;
	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
	com.iGrandee.TransportFees.Feescollection.Feescollectionaction  transportFeesQry = new com.iGrandee.TransportFees.Feescollection.Feescollectionaction();
	String instituteid		= (String)session.getAttribute("instituteid");
	InstitutionQurey insquery=new InstitutionQurey();
	ArrayList insdetails=insquery.getInstituteDetails(instituteid);
	String transportfeescollectionid = request.getParameter("transportfeescollectionid");
	String reqtransportcategoryid = request.getParameter("reqtransportcategoryid");
	String req_discountamount = request.getParameter("req_discountamount");

//	System.out.println("transportfeescollectionid"+transportfeescollectionid);
	String reqrollnumbertext = request.getParameter("rollnumbertext");


feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
//transportFees = transportFeesQry.loadTransportCategoryDetails(reqrollnumbertext,instituteid);
transportDetails = transportFeesQry.loadStudentTransport(reqrollnumbertext,instituteid);
paidList = transportFeesQry.loadPaidDetails(transportfeescollectionid,"headdetails");
receiptdetails = transportFeesQry.loadPaidDetails(transportfeescollectionid,"paymentdetails");
  discountamnt = transportFeesQry.loadiscountpayment(transportfeescollectionid); 


%>
<table width="760" align=center>
	<tr height=50px><td align=left>
		<%@ include file="../../include/reportprintheader.jsp"%>
		</td></tr>
<tr align=center><td> <h3>Transport Fees Receipt</h3>
</td></tr>
<tr><td>
<table border="1px"  cellpadding="5" cellspacing="0" width="100%" align="center" rules=groups>
	    	<%
	    	String transportstagename     = null;
	    	String transportroutename     = null;
	    	String transportrouteid     = null;
	    	if(transportDetails!=null && transportDetails.size()>0)
	    	{ int inc = 1;
	//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
	//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	    		HashMap transportDetailsMap=(HashMap)transportDetails.get(0);
	    		
	    		transportstagename     = (String)transportDetailsMap.get("transportstagename");
	    		transportroutename     = (String)transportDetailsMap.get("routename");
	    		transportrouteid     = (String)transportDetailsMap.get("transportrouteid");
	    		transportstageid     = (String)transportDetailsMap.get("transportstageid");
	    		//out.println("transportstageid"+transportstageid);
	    		
	    	}
	
	    	
	    	
	    	String standardscheduleid     = null;
	    	if(feesScheduleList!=null && feesScheduleList.size()>0)
	    	{ int inc = 1;
	//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
	//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	    		HashMap feesScheduleListMap=(HashMap)feesScheduleList.get(0);
	    		
	    		standardscheduleid     = (String)feesScheduleListMap.get("standardscheduleid");
	    		
   		
	    		String studentstandardname      = (String)feesScheduleListMap.get("standardname");
	    		String sectionscheduleid     = (String)feesScheduleListMap.get("sectionscheduleid");
	    		String studentsectionname      = (String)feesScheduleListMap.get("sectionname");
	    		String studentallocationid     = (String)feesScheduleListMap.get("studentallocationid");
	    		String studentgroupname      = (String)feesScheduleListMap.get("groupname");
	    		String studentboardname     = (String)feesScheduleListMap.get("boardname");
	    		String mediumname      = (String)feesScheduleListMap.get("mediumname");
	    		String firstname      = (String)feesScheduleListMap.get("firstname");
	    		String middlename      = (String)feesScheduleListMap.get("middlename");
	    		String lastname      = (String)feesScheduleListMap.get("lastname");
	    		String emailid      = (String)feesScheduleListMap.get("emailid");
	    		String imagepath      = (String)feesScheduleListMap.get("imagepath");
	    		String studprefix      = (String)feesScheduleListMap.get("prefix");
	    		studentapprovalid      = (String)feesScheduleListMap.get("studentapprovalid");
	    		sessionname      = (String)feesScheduleListMap.get("sessionname");
	    		sessionid      = (String)feesScheduleListMap.get("sessionid");
	    		
	    		if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	    		studentname = studprefix+""+firstname+""+lastname;
	    		else
	    			studentname = studprefix+""+firstname+""+middlename+""+lastname;
	    		
	    		if(studentgroupname ==null || studentgroupname.equals("-"))
	    			studentstandardname = studentstandardname;
	    		else
	    			studentstandardname = studentstandardname+""+studentgroupname;
	    		
	    		userid					= (String)feesScheduleListMap.get("userid");
	    		
	    	%>
	    	
	    	<tr>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentRollNumber")%></td>
	    		<td class=tablebold>:</td><td class=tablelight><%=reqrollnumbertext %></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentName")%></td>
	    		<td class=tablebold>:</td><td class=tablelight><%=studentname %></td>
	    		
	    		</tr>
	    	<tr>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.Standard")%></td>
	    		<td class=tablebold>:</td><td class=tablelight><%=studentstandardname%></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.Section")%></td>
	    		<td class=tablebold>:</td><td class=tablelight><%=studentsectionname%></td>
	    		</tr>
	    		<tr>
	    		<td class=tablebold>Academic Year</td>
	    		<td class=tablebold>:</td><td colspan=4 class=tablelight><%=sessionname%></td>
	    		
	    		</tr>
	    		<tr>
	    		<td class=tablebold>Route Name</td>
	    		<td class=tablebold>:</td><td class=tablelight><%=transportroutename%></td> 
	    		<td class=tablebold>Stage Name</td>
	    		<td class=tablebold>:</td><td class=tablelight><%=transportstagename%></td>
	    		</tr>
	    		<%} %>
	    
	</table>
</td></tr>
<tr height="30"><td></td></tr>
<tr><td>	

<%
double sofarpaid = 0.0d;
	String alreadypaidamount = transportFeesQry.loadalreadypaidamount(reqtransportcategoryid,studentapprovalid);
	if(alreadypaidamount!=null)
	sofarpaid = Double.parseDouble(alreadypaidamount);
%>
<table border="1" cellpadding=5 width="100%" cellspacing=0 rules=groups>
<%


if(receiptdetails!=null && receiptdetails.size()>0)
{ int inc = 1;
//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	HashMap receiptdetailsMap=(HashMap)receiptdetails.get(0);
	paidamount = (String)receiptdetailsMap.get("paidamount");
%>
	<tr><td><a  class=tablebold>Recceipt No.:&nbsp;&nbsp;&nbsp;</a><a class=tablelight> <%= receiptdetailsMap.get("receiptno")%></a></td><td> <a  class=tablebold>Date of Paid : &nbsp;&nbsp;&nbsp; </a><a class=tablelight><%= receiptdetailsMap.get("dateofpaid") %></a></td></tr>
	<tr><td colspan=3><a  class=tablebold>Category Name : &nbsp;&nbsp;&nbsp;</a><a class=tablelight><%= receiptdetailsMap.get("transportcategoryname")%></a></td></tr>
<!-- 	<tr><td>Discount %:-</td></tr> -->
	<%} %>
</table>
</td></tr>
<tr height="30"><td></td></tr>
<tr><td align=right>	
<table border="1" cellpadding=5 width="50%" cellspacing=0 rules=groups>
	<tr bgcolor=#cfcfcf class=tablebold align=right><!-- <td>SL.  No.</td> --><td> Payment Details</td><td width="20%" align=right>  Amount </td><!-- <td>Paid Amount</td> --></tr>
	<%
	String hpaidamount = null;
	String paiddate = null;
	String receiptno = null;
	String transportfeesheadname = null;
	String allocatedamount = null;
	double totamount = 0.0d;
	double allocatedamountr = 0.0d;
	double dueamount =0.0d;
	if(paidList!=null && paidList.size()>0)
	{ int inc = 1;
for(int x=0;x<paidList.size();x++){
		HashMap paidListMap=(HashMap)paidList.get(x);
		
		hpaidamount     = (String)paidListMap.get("paidamount");
		paiddate     = (String)paidListMap.get("paiddate");
		receiptno     = (String)paidListMap.get("receiptno");
		transportfeesheadname     = (String)paidListMap.get("transportfeesheadname");
		allocatedamount     = (String)paidListMap.get("allocatedamount");
		//allocatedamountr += Double.parseDouble(allocatedamount);
		 totamount += Double.parseDouble(allocatedamount);
		%>
		
<%-- 	<tr align=right><td><%=inc++%><td class=tablelight><%=transportfeesheadname %></td><td align=right class=tablelight><%=allocatedamount %></td><td><%= paidamount%></td></tr>	
 --%><%}	}
	
	%>	
	
	<tr align=right><td class=tablebold>Total Amount</td><td align=right><a class=tablelight><%=Math.round(totamount) %></a> </td></tr>
	<tr><td colspan=2><hr></hr></td></tr><tr align=right><td class=tablebold>Already Paid</td><td align=right><a class=tablelight><%=Math.round(sofarpaid) %></a> </td></tr>
	
	 <%
	 
	 double result = 0.0d;
	 float totdiscount = 0.0f;
	 double fipaidamount = 0.0d;
	 double paidamount1 = Double.parseDouble(paidamount);
	 double fordiscount =0.0d;
	// out.println(paidamount1);
	if(discountamnt!=null){
		
	//	totdiscount = Float.parseFloat(discountamnt); 
		//out.println(totdiscount);
	//	out.println("totamount"+totamount);
		//out.println("sofarpaid"+sofarpaid);
		//fordiscount = totamount-sofarpaid;
		
		//result = totdiscount * fordiscount / 100;
		//out.println(result);
		 // result = Math.round(result);
		  
		//  fipaidamount = paidamount1-result;
	
	%>
		<%-- <tr><td colspan=2><hr></hr></td></tr> <tr align=right><td class=tablebold>Discount Amount ( <%=discountamnt %>%)</td><td align=right><a class=tablelight><%=result %></a> </td></tr> --%>
		
		<tr><td colspan=2><hr></hr></td></tr> <tr align=right><td class=tablebold>Discount Amount ( <%=discountamnt %>%)</td><td align=right><a class=tablelight><%=req_discountamount %></a> </td></tr>
		
	<%}
	else{
	//fipaidamount =  Double.parseDouble(paidamount);
	}
	fipaidamount =  Double.parseDouble(paidamount);
	//dueamount =totamount - (sofarpaid+fipaidamount);  
	dueamount =totamount - sofarpaid;
	%> 
	<tr><td colspan=2><hr></hr></td></tr> <tr align=right><td class=tablebold>Paid Amount</td><td align=right><a class=tablelight><%=fipaidamount %></a> </td></tr>
	<tr><td colspan=2><hr></hr></td></tr> <tr align=right><td class=tablebold>Due </td><td align=right><a class=tablelight><%=dueamount %></a> </td></tr>
	
	</table>
</td></tr>

</table>	
<center><input type=button id='printbut' name='printbut' style='display:black' value="Print" onclick="printfun()"><input type=button id='closebut' style='display:black' name='closebut' value="Close" onclick="window.close()"></center>
<%}catch(Exception e){e.printStackTrace();}%>
</body>
</html>