<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<% 
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feescollection.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>

<script type="text/javascript">
function backfun(){
	
	document.feescollectionpreform.action="./Feescollectionstudentinfo.jsp";
	document.feescollectionpreform.submit();
}

function showamountdetails()
{
	document.feescollectionpreform.action="./TransportFeesDetails.jsp";
	document.feescollectionpreform.submit();
/* 	select c.allocatedamount,b.transportstagename,a.dateofcreation,
	a.studentstageallocationstatus,a.studentstageallocationid 
	from studentstageallocation a,transportstage b,transportstageamountallocation c 
	where a.transportstageid=b.transportstageid and a.studentapprovalid='45' and
	c.transportcategoryid='1' and a.transportstageid=c.transportstageid and a.studentstageallocationstatus<>'T'
	and b.transportstagestatus<>'T';
 */	}
  
 
/*  function validateNumber(num) {
	  return /^-?[1-9][0-9]*(.[0-9]+)?$/.test(num);
	} */
 
function savefun()
{
	if(check_ForParticularElements(document.feescollectionpreform.paidamount,"text"))
	{
	
	/* if(document.feescollectionpreform.paidamount.value=="")
	{
		alert("Empty value not allowed");Transportfeesdetails
		document.feescollectionpreform.paidamount.focus();
		return false;
	} */
	
	if(isNaN(document.feescollectionpreform.paidamount.value))
	{
		alert("Enter Numeric value");
		document.feescollectionpreform.paidamount.focus();
		return false;
	}
//alert(parseInt(document.feescollectionpreform.paidamount.value)+" >"+0);
	if(parseInt(document.feescollectionpreform.paidamount.value) < parseInt(0))
	{
		alert("Paid Amount should be greater than zero");
		document.feescollectionpreform.paidamount.focus();
		return false;	
	}
	
	/* if(isNaN(parseFloat(document.feescollectionpreform.paidamount.value)))
	{
		alert("The Paid amount should not be less than the Actual Amount")
		document.feescollectionpreform.paidamount.focus();
		return false;	
	} */
	paidamount = parseFloat(document.feescollectionpreform.paidamount.value)+parseFloat(document.feescollectionpreform.discountamount.value);
	//alert(parseFloat(document.feescollectionpreform.totamount.value)+"__"+parseFloat(document.feescollectionpreform.alpaidamount.value));
	
	//alert(parseFloat(document.feescollectionpreform.totamount.value)-parseFloat(document.feescollectionpreform.alpaidamount.value));
	
	amountopaid = parseFloat(document.feescollectionpreform.totamount.value)-parseFloat(document.feescollectionpreform.alpaidamount.value)
			
	//alert(paidamount > parseFloat(document.feescollectionpreform.totamount.value))
	if(paidamount > parseFloat(amountopaid))
			{
				alert("The Paid amount should not be greater than the Actual Amount");
				return false;
			}
	//alert(paidamount+"__"+parseFloat(document.feescollectionpreform.freqamount.value));
	/* if(paidamount >= parseFloat(document.feescollectionpreform.freqamount.value))
	{
		alert("The Paid amount should not be greater than the Actual Amount")
		return false;
	} */
		/* if(paidamount < parseFloat(document.feescollectionpreform.totamount.value))
			{
				alert("The Paid amount should not be less than the Actual Amount")
				return false;
			}
	

		if(paidamount > parseFloat(document.feescollectionpreform.totamount.value))
			{
				alert("The Paid amount should not be greater than the Actual Amount")
				return false;
			} */
		
	/* //if(paidamount == parseFloat(document.feescollectionpreform.totamount.value)){ */
		//alert("ready to save");
		document.feescollectionpreform.actualpaidamount.value=paidamount;
		document.feescollectionpreform.action="./submittransportfees.jsp";
		document.feescollectionpreform.submit(); 
	/* }
	else
		{
	 alert("The Paid amount should not be less / greater than the Actual Amount")
	 return false;
	} */
	}
	
	}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2>Transport Fees / Fees Collection /  Payment Collection </h2>
      <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>
    
<form name="feescollectionpreform" action="" method="post">
<%
try
{
ArrayList feesScheduleList 				= null;
ArrayList transportFees 				= null;
ArrayList transportDetails 				= null;
ArrayList transportdiscount 				= null;
ArrayList used_discount_details 				= null;

boolean discountusageverification =false; 


String studentname= null;
String userid= null;
String studentapprovalid = null;
com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
com.iGrandee.TransportFees.Feescollection.Feescollectionaction  transportFeesQry = new com.iGrandee.TransportFees.Feescollection.Feescollectionaction();

String reqrollnumbertext=request.getParameter("rollnumbertext");
String transportcategoryid=request.getParameter("req_transportcategoryid");
String transportcategoryname=request.getParameter("req_transportcategoryname");
studentapprovalid=request.getParameter("req_studentapprovalid");
String req_sessionid=request.getParameter("req_sessionid");




String instituteid = (String)session.getAttribute("instituteid");
feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
transportDetails = transportFeesQry.loadStudentTransport(reqrollnumbertext,instituteid);
//transportdiscount = transportFeesQry.loadusersDiscount(studentapprovalid,req_sessionid,transportcategoryid);
transportdiscount = transportFeesQry.loadusersDiscount(studentapprovalid,req_sessionid);

//discountusageverification = transportFeesQry.verifyDiscountUseage(transportcategoryid);
discountusageverification = transportFeesQry.verifyDiscountUseage(transportcategoryid,studentapprovalid);
used_discount_details = transportFeesQry.showDiscountDetails(transportcategoryid,studentapprovalid);


//String transportcategoryid,String transportstageid,String studentapprovalid
//transportFees = transportFeesQry.loadTransportFeesDetails(reqrollnumbertext,instituteid,studentapprovalid,transportcategoryid);

   if(feesScheduleList!=null && feesScheduleList.size()>0)
	{
    %>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%"><%=bundle1.getString("label.studentfeescollection.StudentInformation")%></th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
   
    <tr><td colspan=2><table id="rounded-corner1" width="100%">
    	<tr>
    	<td>
	    	<table border="0" cellpadding="0" cellspacing="0" width="100%" align="center">
	    	<%
	    	
	     	String transportstagename     = null;
	    	String transportroutename     = null;
	    	String transportrouteid     = null;
	    	String transportstageid     = null;
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
	    	String standardscheduleid     = null;
	    	if(feesScheduleList!=null && feesScheduleList.size()>0)
	    	{ 
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
	    		<td class=tablebold>:</td><td><%=reqrollnumbertext %></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.StudentName")%></td>
	    		<td class=tablebold>:</td><td><%=studentname %></td>
	    		
	    		</tr>
	    	<tr>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.Standard")%></td>
	    		<td class=tablebold>:</td><td><%=studentstandardname%></td>
	    		<td class=tablebold><%=bundle1.getString("label.studentfeescollection.Section")%></td>
	    		<td class=tablebold>:</td><td><%=studentsectionname%></td>
	    		</tr>
	    		<tr>
	    		<td class=tablebold>Transport Category Name</td>
	    		<td class=tablebold>:</td><td><%=transportcategoryname%></td>
	    		
	    		</tr><tr>
	    		<td class=tablebold>Route Name</td>
	    		<td class=tablebold>:</td><td><%=transportroutename%></td>
	    		<td class=tablebold>Stage Name</td>
	    		<td class=tablebold>:</td><td><%=transportstagename%></td>
	    		</tr>
	    	<%
		    }else
		    	{
			    	
		    		out.print("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
		    		%>
		    		  <a href="#" onclick=backfun() class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		    		if(!discountusageverification)
		    		<% 
		    	}
		    	}else{
		    		out.print("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
		    		%>
		    		  <a href="#" onclick=backfun() class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
		    		
		    		<% 
		    	}%>	 
	</table>
	
	    </td>
	    </tr>
    </table>

    </td></tr>
    </tbody>
</table>
<br/>
<%
String exist_discountcategoryname     = null;
String exist_discountpercentage     = null;
String exist_discountuserstatus = null;
 if(used_discount_details!=null && used_discount_details.size()>0)
	    	{ int inc = 1;
	//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
	//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	    		HashMap used_discount_detailsMap=(HashMap)used_discount_details.get(0);
	    		
	    		exist_discountcategoryname     = (String)used_discount_detailsMap.get("discountcategoryname");
	    		 exist_discountpercentage     = (String)used_discount_detailsMap.get("discountpercentage");
	    		 exist_discountuserstatus = (String)used_discount_detailsMap.get("discountuserstatus");
	    		%>
 <div class="info_box">
 This Student Used the discount - <b><%=exist_discountcategoryname %> (<%= exist_discountpercentage%> %) </b>for this <b><%=transportcategoryname %></b><br></br>
 <%if(exist_discountuserstatus.equals("D")){ %>
 Now this discount name ( <b><%=exist_discountcategoryname %>-<%= exist_discountpercentage%> %</b> ) is cancelled for this student.
 <% }%>
 <%-- Discount Category Name : <%=discountcategoryname %> (<%= discountpercentage%>) --%>						        
</div>
<%} %>

<br/>
  <table  id="rounded-corner" border=0 width="100%" cellpadding=5>
    <thead> 
    	<tr>
        	
         	<th scope="col" scope="col" class="rounded-company"  width="15%">Sl.No.</th>
         <!-- 	<th scope="col"  width="25%" >Stage Name</th> -->
        	<th scope="col" class="rounded" width="65%" >Fees Head Name</th>
        	<th scope="col" class="rounded-q4"  width="20%" align=right >Allocated Amount</th>
<!--         	<th scope="col"  width="10%" >Current Status</th>
 --><!--         	<th scope="col"  width="10%" >Paid Status</th>
 --><!--         	<th scope="col"  width="5%">Selection</th>
 -->            
        </tr>
    </thead>
     <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan=2><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
   
	<%
	transportFees = transportFeesQry.loadTransportFeesDetails(transportcategoryid,transportstageid,studentapprovalid);
	ArrayList arrs = new ArrayList(1); 
	double totamount = 0.0d;
	String studentstageallocationid     = null;
	if(transportFees!=null && transportFees.size()>0)
	{ int inc = 1;
	int rowinc=0;
	String temp_studentstageallocationid = "";
	for(int y=0;y<transportFees.size();y++){ 		
		
		HashMap transportFeesListMap=(HashMap)transportFees.get(y);
		// b.transportstageid,c.transportstageamountallocationid,d.transportfeesheadname,c.transportfeesheadid,
		//c.allocatedamount,b.transportstagename,a.dateofcreation,a.studentstageallocationstatus,
 //a.studentstageallocationid 
		//String transportstagename      = (String)transportFeesListMap.get("transportstagename");
		String dateofcreation     = (String)transportFeesListMap.get("dateofcreation");
		String allocatedamount     = (String)transportFeesListMap.get("allocatedamount");
		String studentstageallocationstatus     = (String)transportFeesListMap.get("studentstageallocationstatus");
		studentstageallocationid     = (String)transportFeesListMap.get("studentstageallocationid");
		String transportfeesheadname     = (String)transportFeesListMap.get("transportfeesheadname");
		String transportstageamountallocationid     = (String)transportFeesListMap.get("transportstageamountallocationid");
		String transportfeesheadid     = (String)transportFeesListMap.get("transportfeesheadid");
		//String transportstageid     = (String)transportFeesListMap.get("transportstageid");
		
		
		 totamount += Double.parseDouble(allocatedamount);
		
	%>
		
		<%

		
	/* 	if(arrs.contains(studentstageallocationid))
		{
			arrs.add(studentstageallocationid);
		}
		 */
		
		%>
		
		<%-- <td rowspan='<%=arrs.size()%>'><%=inc++ %><%=rowinc %></td> --%>
		
		<%-- <%if(paidamount == null)
			paidamount="0";
		
		Double tpaidamount = Double.valueOf(paidamount);
		%>
	 	<td><%=tpaidamount %></td> 

			if(!studentstageallocationid.equals(temp_studentstageallocationid))
			{%>
						<tr><td  colspan="3" class=tablebold>
						<table border=0 cellpadding=0 width="100%"><tr><td width="40%">
						<%=inc++ %>.)&nbsp;Stage Name :  <a href='#' transportcategoryid='"+transportcategoryid+"' studentapprovalid='"+studentapprovalid+"' onclick=showamountdetails(this)> <%=transportstagename %></a>
						</td>
						<%
		if(studentstageallocationstatus.equals("A"))
		out.println("<td width=\"30%\">Active Stage</td>");
		if(studentstageallocationstatus.equals("D"))
				out.println("<td width=\"30%\">Stage Closed</td>");
	%>
		
						
						<td align=right width="30%">
						
						Paid Status : Paid
						</td>
						</tr></table>
						
						</td></tr>

				<%
				temp_studentstageallocationid = studentstageallocationid;
			}
		%> --%>
		<tr>
		<td>
						<%=inc++ %>.<input type=hidden name="transportstageamountallocationid" value="<%=transportstageamountallocationid %>"></input></td>
		<td><%=transportfeesheadname %></td>
		<td align=right><%=allocatedamount %></td>
		
		</tr>
		
	<%
	//totamount++;
	}}
	else
	{
		out.println("<tr><td colspan=3>Data Not Found</td></tr>");
	}%>
	</table><br/>
	<!-- <hr></hr> -->
	<table  id="rounded-corner" border=0 width="100%" cellpadding=5>
	 <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%">Amount To be Paid</th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    	<tr align=right>
   <%  String paidamount = feesscheduleQuery.loadPaidAmount(studentapprovalid,transportcategoryid);
if(paidamount == null)
			paidamount="0";

Double tpaidamount = Double.valueOf(paidamount);
%>
	<td class=tablebold>Total Amount </td><td width="10%" class=tablebold align=right><%=Math.round(totamount) %><input type="hidden" name="totamount" value="<%=Math.round(totamount) %>"></input></td></tr>
<tr><td class=tablebold align=right>Already Paid Amount </td><td width="10%" class=tablebold align=right><%=Math.round(tpaidamount) %><input type=hidden name='alpaidamount' value="<%=Math.round(tpaidamount) %>"></input><input type="hidden" name="atotamount" value="<%=Math.round(totamount) %>"></input></td></tr>
	<%
	String discountamountid     = null;
	String discountcategoryname     = null;
	String discountpercentage = null;
	String discountuserid= null;
	//Float totdiscount= 0f;
	float totdiscount= 0f;
	//float totdiscount1= 0f;
	String usedMessage = ""; 
	 double result = 0.0d;
	 double freqamount =0.0d;
	 String current_discountuserstatus = null;
	 //out.println("transportdiscount"+transportdiscount);
	if(transportdiscount!=null && transportdiscount.size()>0)
	{ int inc = 1;
//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	for(int y1=0;y1<transportdiscount.size();y1++){ 		
		
		HashMap transportdiscountMap=(HashMap)transportdiscount.get(y1);
		discountamountid     = (String)transportdiscountMap.get("discountamountid");
		discountcategoryname     = (String)transportdiscountMap.get("discountcategoryname");
		discountpercentage     = (String)transportdiscountMap.get("discountpercentage");
		//out.println(discountpercentage);
		discountuserid     = (String)transportdiscountMap.get("discountusersid");
		current_discountuserstatus     = (String)transportdiscountMap.get("discountuserstatus");
		if(transportdiscountMap.get("discountcategoryname")==null)
			discountcategoryname="";
	  else 
		  discountcategoryname = " ("+discountcategoryname+") - ";
		  /* select transportfeescollectiondiscountid from studentstageallocation a,transportfeescollection b,transportfeescollectiondiscount c
		   where studentapprovalid='57' and studentstageallocationstatus<>'T' 
		   and a.studentstageallocationid=b.studentstageallocationid and c.transportfeescollectionid=b.transportfeescollectionid; */

		  // out.println("discountcategoryname-->"+	discountcategoryname);
		//totdiscount += Float.parseFloat(discountpercentage);
		totdiscount+= Float.parseFloat(discountpercentage);
		
		
		
	}

//out.println(Math.round(totdiscount));
			freqamount = totamount-tpaidamount;
			//out.println(freqamount);
			
	if(!discountusageverification)
	{
			  result = totdiscount * freqamount / 100;
			// out.println("result"+result);
			  result = Math.round(result);
			  freqamount = totamount-tpaidamount;
		//	  out.println("freqamount"+freqamount);
			  freqamount = freqamount-result;
			  
			  usedMessage = "";
			//  out.println("here"); 
			  out.println("<input type=hidden name='discountusedstatus' value='no'></input>"); 
	}else
	{
		usedMessage = "(Already Used) -  ";
		out.println("<input type=hidden name='discountusedstatus' value='yes'></input>");
	}
	
			  
				  
	
	}
	else{
		//out.println("here also");
		discountcategoryname = "";
		usedMessage = "";
		//out.println(totamount+_"")
		freqamount = totamount-tpaidamount;
		if(discountusageverification)
		{
			usedMessage = "(Already Used) -  ";
			out.println("<input type=hidden name='discountusedstatus' value='yes'></input>");
			
		}else{
		
			out.println("<input type=hidden name='discountusedstatus' value='no'></input>");	
		}
		
		 
	}
	
	%>
	<tr class=tablebold align=right><td>
	<%if(discountusageverification){ %>
			<%=usedMessage %><%=exist_discountcategoryname %> (<%=exist_discountpercentage %>%)
			<%}else{ %>
			<%=discountcategoryname %>Discount Amount -  (<%=totdiscount%>%)
			<%} %> 
			<input type="hidden" name="discountamountid" value="<%=discountamountid %>"></input><input type="hidden" name="discountuserid" value="<%= discountuserid %>"></input></td>
			<td align=right><%=Math.round(result) %><input type="hidden" name="discountamount" value="<%=Math.round(result) %>"></td>
		</tr>
	<tr class=tablebold align=right><td>Amount To be Paid</td><td align=right><%=Math.round(freqamount) %><input type=hidden name="freqamount" value="<%=Math.round(freqamount) %>"></input></td></tr>
	<tr class=tablebold align=right><td>Paid Amount</td><td class=tablebold><input type=text name=paidamount class=tablelight validate="Paid Amount" maxlength=7 onkeyup="valid(this,'numbers')"></input></td></tr>
	</table>
	
	<a href="#" onclick=backfun() class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
	 <a href="#" onclick=savefun() class="bt_blue"><span class="bt_blue_lft"></span><strong>SAVE</strong><span class="bt_blue_r"></span></a>
	
<input type=hidden name="rollnumbertext" value="<%=reqrollnumbertext%>"/>
<input type=hidden name="actualpaidamount"/>
<input type=hidden name="studentstageallocationid" value="<%=studentstageallocationid%>"/>
<input type="hidden" name="req_transportcategoryid" value="<%=request.getParameter("req_transportcategoryid")%>">
<input type="hidden" name="req_studentapprovalid" value="<%=request.getParameter("req_studentapprovalid")%>">
<input type="hidden" name="req_sessionid" value="<%=request.getParameter("req_sessionid")%>">
<%}
   else{
	   out.println("datanotfound");
   }
   }catch(Exception e){e.printStackTrace();} %>



</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>