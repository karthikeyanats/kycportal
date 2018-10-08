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
	
	document.feescollectionpreform.action="./Feescollectionreceipt.jsp";
	document.feescollectionpreform.submit();
}
function showamountdetails(obj) 
{
	
	document.feescollectionpreform.req_transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feescollectionpreform.req_transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feescollectionpreform.req_studentapprovalid.value=obj.getAttribute("studentapprovalid");
	document.feescollectionpreform.req_sessionid.value=obj.getAttribute("sessionid");
	document.feescollectionpreform.action="./Transportfeesdetails.jsp";
	document.feescollectionpreform.submit();
	}
	
function godetail(obj)
{
	document.feescollectionpreform.transportfeescollectionid.value=obj.getAttribute("transportfeescollectionid");
	document.feescollectionpreform.action="./Receiptdetails.jsp";
	document.feescollectionpreform.submit(); 
}

	
	function getPrint(obj)
	{
		window.open("./transportfeesreceipt.jsp?transportfeescollectionid="+obj.getAttribute("transportfeescollectionid")+"&rollnumber="+obj.getAttribute("reqrollnumbertext"))
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
<h2>Transport Fees/Fees Collection/ Enter Roll Number / Receipt Details / Receipt Detail View</h2>
     <%@page language="java" import="java.util.ResourceBundle"%> 

      <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale,com.iGrandee.Registration.InstitutionQurey"%>

    
<form name="feescollectionpreform"  method="post">
<%
String transportstageid     = null;

ArrayList paidList = null;

ArrayList receiptdetails = null;
String discountamnt = null;
String studentname= null;
String sessionname= null;
String sessionid=null;
String userid= null;
String studentapprovalid = null;
ArrayList used_discount_details = null;
com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
com.iGrandee.TransportFees.Feescollection.Feescollectionaction  transportFeesQry = new com.iGrandee.TransportFees.Feescollection.Feescollectionaction();
String instituteid		= (String)session.getAttribute("instituteid");
InstitutionQurey insquery=new InstitutionQurey();
ArrayList insdetails=insquery.getInstituteDetails(instituteid);
String transportfeescollectionid = request.getParameter("transportfeescollectionid");

String reqrollnumbertext = request.getParameter("rollnumbertext");
//out.println("reqrollnumbertext===>>>"+reqrollnumbertext);
String studentstageallocationstatus = null;


discountamnt = transportFeesQry.loadiscountpayment(transportfeescollectionid);
paidList = transportFeesQry.loadPaidDetails(transportfeescollectionid,"headdetails");
receiptdetails = transportFeesQry.loadPaidDetails(transportfeescollectionid,"paymentdetails");
ArrayList feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
used_discount_details = transportFeesQry.showDiscountDetails_receipt(transportfeescollectionid);

try
{

 ArrayList	transportDetails = transportFeesQry.loadStudentTransport(reqrollnumbertext,instituteid);
		
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
	    	if(transportDetails!=null && transportDetails.size()>0)
	    	{ int inc = 1;
	//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
	//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	    		HashMap transportDetailsMap=(HashMap)transportDetails.get(0);
	    		
	    		transportstagename     = (String)transportDetailsMap.get("transportstagename");
	    		transportroutename     = (String)transportDetailsMap.get("routename");
	    
	    			
	    			
	    		transportrouteid     = (String)transportDetailsMap.get("transportrouteid");
	    		transportstageid     = (String)transportDetailsMap.get("transportstageid");
	    		studentstageallocationstatus     = (String)transportDetailsMap.get("studentstageallocationstatus");
	    		
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
	    		studentname = studprefix+" "+firstname+" "+lastname;
	    		else
	    			studentname = studprefix+" "+firstname+" "+middlename+" "+lastname;
	    		
	    		if(studentgroupname ==null || studentgroupname.equals("-"))
	    			studentstandardname = studentstandardname;
	    		else
	    			studentstandardname = studentstandardname+""+studentgroupname;
	    		
	    		userid					= (String)feesScheduleListMap.get("userid");
	    		
	    		if(transportroutename == null)
	    			transportroutename ="-";
	    		if(transportstagename==null)
	    		transportstagename="-";
	    		
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
	    		<td class=tablebold>Session Name</td>
	    		<td class=tablebold>:</td><td><%=sessionname%></td>
	    		
	    		</tr>
	    		<tr>
	    		<td class=tablebold>Route Name</td>
	    		<td class=tablebold>:</td><td><%=transportroutename%></td>
	    		<td class=tablebold>Stage Name</td>
	    		<td class=tablebold>:</td><td><%=transportstagename%></td>
	    		</tr>
	    		<tr><td colspan=4>
	    		<%
	    		if(studentstageallocationstatus ==null)
	    		{
	    			out.println("<font color='red'><h3>The Stage Not Yet Allocated</h3></font>");
	    		}
	    		else if(studentstageallocationstatus !=null && studentstageallocationstatus.equals("C"))
	    		{
	    			out.println("<font color='red'><h3>The stage is closed</h3></font>");
	    		}
	    		
	    		%>
	    		</td></tr>
	    		
	    	<%
		    }else
		    	{
			    	
		    		out.print("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
			    	
		    	}
		    %>	 
	</table>
	</td></tr></table></td></tr></tbody></table>

<br></br>
</td></tr>
<tr height="30"><td></td></tr>
<tr><td>	
<table id="rounded-corner" border="0" cellpadding=5 width="100%" cellspacing=0>
	 
	 <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company">Sl.No.</th>
        	<th scope="col" class="rounded">Feeshead Name</th>
        	<th scope="col" class="rounded-q4">Allocated Amount</th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan="2"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
	<!-- <tr class=tableheading><td>SL.  No.</td><td> Feeshead Name</td><td>Allocated Amount </td><td>Paid Amount</td></tr> -->
	<%
	String paidamount = null;
	String paiddate = null;
	String receiptno = null;
	String transportfeesheadname = null;
	String allocatedamount = null;
	double totamount = 0.0d;		 
	if(paidList!=null && paidList.size()>0)
	{ int inc = 1;
for(int x=0;x<paidList.size();x++){
		HashMap paidListMap=(HashMap)paidList.get(x);
		
		paidamount     = (String)paidListMap.get("paidamount");
		paiddate     = (String)paidListMap.get("paiddate");
		receiptno     = (String)paidListMap.get("receiptno");
		transportfeesheadname     = (String)paidListMap.get("transportfeesheadname");
		allocatedamount     = (String)paidListMap.get("allocatedamount");
		totamount += Double.parseDouble(allocatedamount);
		%>
		
	<tr class=tablelight><td><%=inc++%><td><%=transportfeesheadname %></td><td><%=allocatedamount %></td><%-- <td><%= paidamount%></td> --%></tr>	
<%}	}
	
	%>	
	<tr><td></td><td>Total Amount</td><td><%=totamount %></td></tr>
	</table>
</td></tr></table>

<br></br>
<table id="rounded-corner" border="0" cellpadding=5 width="100%" cellspacing=0 rules=groups>
<%
String transportcategoryname = null;
if(receiptdetails!=null && receiptdetails.size()>0)
{ int inc = 1;
//standardscheduleid, sectionscheduleid, studentallocationid, sectionname, standardname, groupname, boardname,
//mediumname, firstname, middlename, lastname, emailid, imagepath, prefix,studentapprovalid   		 		
	HashMap receiptdetailsMap=(HashMap)receiptdetails.get(0);
	transportcategoryname = (String)receiptdetailsMap.get("transportcategoryname");
%>
	
	 <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%">Receipt Details</th>
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
     <tr><td colspan=2>
	<table id="rounded-corner1" width="100%">
	<tr>
	    		<td class=tablebold>Receipt No.</td>
	    		<td class=tablebold>:</td><td><%= receiptdetailsMap.get("receiptno")%></td>
	    		<td class=tablebold>Date of Paid </td>
	    		<td class=tablebold>:</td><td><%= receiptdetailsMap.get("dateofpaid") %></td>
	    		</tr>
	   <tr>
	    		<td class=tablebold>Category Name</td>
	    		<td class=tablebold>:</td><td><%= receiptdetailsMap.get("transportcategoryname")%></td>
	    		<td class=tablebold>Paid Amount</td>
	    		<td class=tablebold>:</td><td><%=receiptdetailsMap.get("paidamount") %></td>
	    		</tr> 		
	 <%
	 
	 double result = 0.0d;
	 float totdiscount = 0.0f;
	 double fipaidamount = 0.0d;
	 double paidamount1 = Double.parseDouble((String)receiptdetailsMap.get("paidamount"));
	// out.println(paidamount1);
	if(discountamnt!=null){
		
		totdiscount = Float.parseFloat(discountamnt); 
		
		result = totdiscount * totamount / 100;
		  result = Math.round(result);
		  
		//  fipaidamount = paidamount1-result;
		%>
		 <tr>
	    		<td class=tablebold>Discount Amount</td>
	    		<td class=tablebold>:</td><td><%=result%></td>
		
	    		</tr> 
		<%
	}
	
	%>
	  
	</table>
	
<!-- 	<tr><td>Discount %:-</td></tr> -->
	<%} %>
	</td>
	</tr>
	</tbody>
</table>


    

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
	    		<br></br>
<table id="rounded-corner" border="0" cellpadding=5 width="100%" cellspacing=0 rules=groups>
 <thead>
    	<tr>
        	
        	<th scope="col" class="rounded-company" width="90%" colspan=5>Discount Details</th>
        	<th scope="col" class="rounded-q4" width="10%" ></th>
            
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan=5><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
	    		<tr><td class=tablebold>Discount Category Name </td><td class=tablebold>:</td><td class=tablelight><%=exist_discountcategoryname %></td>
	    		<td class=tablebold>Discount Percentage </td><td class=tablebold>:</td><td class=tablelight  width="5%" al><%=exist_discountpercentage %>%</td>
	    		</tr></table>
 <%-- <div class="info_box">
 This Student Used the discount - <b><%=exist_discountcategoryname %> (<%= exist_discountpercentage%> %) </b>for this <b><%=transportcategoryname %></b><br></br>
 Now this discount name ( <b><%=exist_discountcategoryname %>-<%= exist_discountpercentage%> %</b> ) is closed for this student.
 Discount Category Name : <%=discountcategoryname %> (<%= discountpercentage%>)						        
</div> --%>
<%} %>

	
<a href="#" onclick="backfun()" class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
<%}catch(Exception e){e.printStackTrace();}%>
		<%
		if(request.getParameter("rollnumbertext")!=null){
		%>
			<input type="hidden" name="rollnumbertext" value="<%=request.getParameter("rollnumbertext")%>"/>
		<%
		}
		%>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>