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
	
	document.feescollectionpreform.action="./Feescollectionrollnumber.jsp";
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
function showamountdetails1(obj) 
{
	
	document.feescollectionpreform.req_transportcategoryname.value=obj.getAttribute("transportcategoryname");
	document.feescollectionpreform.req_transportcategoryid.value=obj.getAttribute("transportcategoryid");
	document.feescollectionpreform.req_studentapprovalid.value=obj.getAttribute("studentapprovalid");
	document.feescollectionpreform.req_sessionid.value=obj.getAttribute("sessionid");
	
	
	
	document.feescollectionpreform.action="./Transportfeesdetails1.jsp";
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

    <h2>Transport Fees / Payment Details</h2>
      <%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Common.DateTime,java.text.NumberFormat,java.util.Locale"%>
    
<form name="feescollectionpreform"  method="post">
<%
String transportstageid     = null;
ArrayList feesScheduleList 				= null;
ArrayList transportFees 				= null;
ArrayList transportDetails = null;
String studentname= null;
String sessionname= null;
String sessionid=null;
String userid= null;
String studentapprovalid = null;
String reqrollnumbertext= null;
String instituteid = null;
String studentstageallocationstatus =null;
com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();  
com.iGrandee.TransportFees.Feescollection.Feescollectionaction  transportFeesQry = new com.iGrandee.TransportFees.Feescollection.Feescollectionaction();
try
{
 reqrollnumbertext=request.getParameter("rollnumbertext");
 instituteid = (String)session.getAttribute("instituteid");
 sessionid = (String)session.getAttribute("sessionid");
feesScheduleList = feesscheduleQuery.checkandLoadStudent(reqrollnumbertext,instituteid);
//transportFees = transportFeesQry.loadTransportCategoryDetails(reqrollnumbertext,instituteid);


transportDetails = transportFeesQry.loadStudentTransport(reqrollnumbertext,instituteid);
 
//out.println(transportFees);
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
		    	}else{
		    		out.print("<tr align='center' class='tablebold'><td colspan='2'><font color='red'>Data Not Found</font></td></tr>");
		    	}%>	 
	</table>
	
	    </td>
	    </tr>
    </table>

    </td></tr>
    </tbody>
</table>
  <a href="#" onclick=backfun() class="bt_blue"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

<%
if(studentstageallocationstatus.equals("A")){
		if(transportDetails!=null && transportDetails.size()>0)
		{ 
%>
<br/><br/>
  <table  id="rounded-corner" border=0 width="100%" cellpadding=5 cellspacing=0>
    <thead>
    	<tr >
        	
        	<th  scope="col" class="rounded-company"  width="5%">Sl.No.</th>
        	<th scope="col" class="rounded"  width="25%">Category Name</th>
        	<th scope="col"  width="10%"  class="rounded">Total Amount</th>
        	<th scope="col"  width="10%" >Paid  Amount</th> 
        	<th scope="col"  width="10%" class="rounded">Paid Status</th>
        	<th scope="col"  width="5%" class="rounded-q4" >Payment</th>
            
        </tr>
    </thead>
    
   <!--  <tfoot>
    	<tr>
        	<td class="rounded-foot-left" colspan=4><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> -->
	<%
	
	transportFees = transportFeesQry.loadStudentTransportcategory(studentapprovalid,sessionid, instituteid);
	if(transportFees!=null && transportFees.size()>0)
	{ int inc = 1;
	for(int y=0;y<transportFees.size();y++){ 		
		HashMap transportFeesListMap=(HashMap)transportFees.get(y);
		
	//	i.transportcategoryname,g.transportstagename,studentstageallocationstatus,allocatedamount,j.transportfeesheadid,j.transportfeesheadname
		String transportcategoryname      = (String)transportFeesListMap.get("transportcategoryname");
		String transportcategoryid     = (String)transportFeesListMap.get("transportcategoryid");
		//String paidamount     = (String)transportFeesListMap.get("paidamount");
		String paidamount = feesscheduleQuery.loadPaidAmount(studentapprovalid,transportcategoryid);
		String allocatedamount = feesscheduleQuery.loadAcutualAmount(studentapprovalid,transportcategoryid,transportstageid);
		if(allocatedamount==null)
			allocatedamount="0";
	//	String allocatedamount     = (String)transportFeesListMap.get("allocatedamount");
		
		
	%>
		<tr>
		<td><%=inc++ %></td>
		
		<%-- 	<td><a href='#' transportcategoryid="<%=transportcategoryid %>" transportcategoryname="<%=transportcategoryname %>" studentapprovalid='<%=studentapprovalid %>' sessionid='<%=sessionid %>' onclick=showamountdetails(this)> <%=transportcategoryname %></a></td> --%>
		<td><%=transportcategoryname %></td>
		<td><%=allocatedamount %></td>
		
		<%
		//Double paidamountval = Double.valueOf(paidamounts);
		Double tallocatedamount = Double.valueOf(allocatedamount);
		
	
		
		if(paidamount == null)
			paidamount="0";
		
		Double tpaidamount = Double.valueOf(paidamount);
		%>
	 	<td><%=tpaidamount %></td> 
		<%
		
		if(tallocatedamount>0 && tallocatedamount <= tpaidamount)
		{
			
					String transportfeescollectionid = feesscheduleQuery.loadFeescollectionid(transportcategoryid,reqrollnumbertext);
		/* out.println("<td><font color=green></font><a href='#' transportfeescollectionid='"+transportfeescollectionid+"' reqrollnumbertext='"+reqrollnumbertext+"' target='_new' onclick='getPrint(this)'>Get Receipt</a></td><td>-</td>"); */	
		out.println("<td><font color=green></font>Paid</td><td>-</td>");
		}
		else
		{
			

			out.println("<td><font color=red>Pending</font></td>");

			%>
			
			<td>
			<%if(tallocatedamount>0){ %>
			<a href='#' transportcategoryid="<%=transportcategoryid %>" transportcategoryname="<%=transportcategoryname %>" studentapprovalid='<%=studentapprovalid %>' sessionid='<%=sessionid %>' onclick=showamountdetails(this)>Go To Payment</a> 
			<%-- | 
			<a href='#' transportcategoryid="<%=transportcategoryid %>" transportcategoryname="<%=transportcategoryname %>" studentapprovalid='<%=studentapprovalid %>' sessionid='<%=sessionid %>' onclick=showamountdetails1(this)>Go To Payment1</a> --%>
			
			<%} else{out.println("-");}%></td>
		<% }
		%>
				
<!-- 		<td><input type=checkbox></input></td>
 -->		
		
		</tr>
	<% }}
	
	else
	{
		out.println("<tr><td colspan=6>Amount  / Category is not allocated for this stage</td></tr>");
	}
	}else
	{//out.println("<tr><td colspan=5>Data not found</td></tr>");
	}
	}%>
	</table>
	
	

<br/><br/><br></br>
<input type=hidden name="req_transportcategoryname"/>
	<input type=hidden name="req_transportcategoryid"/>
	<input type=hidden name="req_studentapprovalid"/>
		<input type=hidden name="req_sessionid"/>
	
	
	<input type=hidden name="rollnumbertext" value="<%=reqrollnumbertext %>"></input>
	<%}catch(Exception e){e.printStackTrace();
		} %>
</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../../include/footer.jsp" %>
    

</div>
</body>
</html>