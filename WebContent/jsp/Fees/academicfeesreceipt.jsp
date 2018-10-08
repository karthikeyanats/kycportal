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
	String academicfeesreceiptid = request.getParameter("feesreceitpid");

	//System.out.println("transportfeescollectionid"+academicfeesreceiptid);
	String reqrollnumbertext = request.getParameter("rollnumbertext");

	
feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
//transportFees = transportFeesQry.loadTransportCategoryDetails(reqrollnumbertext,instituteid);
//transportDetails = transportFeesQry.loadStudentTransport(reqrollnumbertext,instituteid);
receiptdetails = transportFeesQry.loadacademicPaidDetails(academicfeesreceiptid,"paymentdetails");
 


%>
<table width="640" align=center border=0>
	<tr height=50px><td align=left>
		<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
<tr align=center><td> <h3>Fees Receipt</h3>
</td></tr>
<tr><td>
<table border="1px"  cellpadding="5" cellspacing="0" width="100%" align="center" rules=groups>
	    	<%
	    	String termname     = null;
	    //	String paidamount     = null;
	    	String dateofpaid     = null;
	    	String academicfeesreceiptno     = null;
	    	
	    	if(receiptdetails!=null && receiptdetails.size()>0)
	    	{ int inc = 1;
	//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
	//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	    		HashMap transportDetailsMap=(HashMap)receiptdetails.get(0);
	    		
	    		termname     = (String)transportDetailsMap.get("termname");
	    		paidamount     = (String)transportDetailsMap.get("paidamount");
	    		dateofpaid     = (String)transportDetailsMap.get("dateofpaid");
	    		academicfeesreceiptno     = (String)transportDetailsMap.get("academicfeesreceiptno");
	    		
	    		
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
	    		studentname = studprefix+" "+firstname+" "+lastname;
	    		else
	    			studentname = studprefix+" "+firstname+" "+middlename+" "+lastname;
	    		
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
	    		<td class=tablebold>Academic Yar</td>
	    		<td class=tablebold>:</td><td class=tablelight><%=sessionname%></td>
	    		<td class=tablebold>Receipt No.</td>
	    		<td class=tablebold>:</td><td class=tablelight><%=academicfeesreceiptno%></td>
	    		
	    		</tr>
	    		<tr>
	    		<td class=tablebold>Term Name</td>
	    		<td class=tablebold>:</td><td class=tablelight><%=termname%></td> 
	    		<td class=tablebold>Date</td>
	    		<td class=tablebold>:</td><td class=tablelight><%=dateofpaid%></td>
	    		</tr>
	    		<%} %>
	    
	</table>
</td></tr>
<tr height="30"><td></td></tr>
<tr><td>	

<%-- <%
double paidamount = 0.0d;
	
paidamount = Double.parseDouble(paidamount);
%> --%>
<table border=1 cellpadding=10 cellspacing=0 width="100%" align=right>
<tr class=tableheading><td width="10%">Sl.No.</td><td>Particulars</td><td align=right>Amount</td></tr>
<tr><td class=tablebold>1.</td><td class=tablebold>Tuition Fees</td><td  class=tablelight align=right><%=paidamount %></td></tr>
<tr><td class=tablebold colspan=2 align=right>Total Amount</td><td  class=tablelight align=right><%=paidamount %></td></tr>
</table>
<br><br>
<tr height=60><td></td></tr>
<tr><td></td></tr>
<tr><td>
<table border=0 cellpadding=10 cellspacing=0 width="100%" align=right><tr><td class=tablebold align=right>Authorised Signatory</td></tr>
</table>
</td></tr>
</table>

<br>
<center><input type=button id='printbut' name='printbut' style='display:black' value="Print" onclick="printfun()"><input type=button id='closebut' style='display:black' name='closebut' value="Close" onclick="window.close()"></center>
<%}catch(Exception e){e.printStackTrace();}%>
</body>
</html>