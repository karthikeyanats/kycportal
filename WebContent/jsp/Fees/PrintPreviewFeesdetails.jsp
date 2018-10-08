<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Fees Receipt | Powered by i-Grandee</title>
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
<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,com.iGrandee.Fees.FeesSchedule,java.text.NumberFormat,java.util.Locale"%>	
<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.Common.DateTime"%>
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
//Locale localcurrency = new Locale("en", "IN");
ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));

ArrayList insdetails=insquery.getInstituteDetails(instituteid);
String rollno =request.getParameter("rollno")+"";
String feesdate =request.getParameter("feesdate")+"";
String disfeesdate =request.getParameter("disfeesdate")+"";

String studentapprovalid =request.getParameter("studentapprovalid")+"";




	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
    ArrayList feesScheduleList = null;

	feesScheduleList = feesscheduleQuery.checkandLoadStudent(rollno,instituteid);
	String standardscheduleid="";
	String studentname="";
	int inc = 1;
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
	String imagepath      = (String)feesScheduleListMap.get("imagepath");
	String studprefix      = (String)feesScheduleListMap.get("prefix");
	//studentapprovalid      = (String)feesScheduleListMap.get("studentapprovalid");
	String sectionname      = (String)feesScheduleListMap.get("sectionname");
	ArrayList feesdetailsList = null;  
	String splitdate =null;
   	splitdate=feesdate.substring(0,10);
	feesdetailsList = feesscheduleQuery.studentFeescollectionDetailsforDate(studentapprovalid,splitdate);
	if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	studentname = studprefix+""+firstname+""+lastname;
	else
		studentname = studprefix+""+firstname+""+middlename+""+lastname;
	
	if(studentgroupname ==null || studentgroupname.equals("-"))
		studentstandardname = studentstandardname;
	else
		studentstandardname = studentstandardname+""+studentgroupname;
	 String  time				= DateTime.showTime("Time");
	 String  date				= DateTime.showTime("calendar");

%>
<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=700px >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
				
		<!--  <tr height=50px><td align=center  colspan=2>
		<table  border=0 width=100% class=tablebold cellpadding='0' cellspacing='0'>
		<tr height=100px valign=top>-->
		<%
    	/*if(insdetails!=null && insdetails.size()>0)
    	{
    		datacount++;
    		HashMap map=(HashMap)insdetails.get(0);
        	String inslogo=map.get("institutelogo")+"";
        	String insname=map.get("institutename")+"";
        	String contactaddress=map.get("contactaddress")+"";
        	String country=map.get("country")+"";
        	String landlinenumber=map.get("landlinenumber")+"";
        	String state=map.get("state")+"";
        	String mobilenumber=map.get("mobilenumber")+"";
        	String emailid=map.get("emailid")+"";
        	String url=map.get("url")+"";
        	if(url.equals("-"))
        		url="";
        	out.println("<td  align=left><img src='/kycportal/OpenDocument?r1=storagepath&r2="+inslogo+"' width=110 height=110></td>");
        	out.println("<td valign=top align=left><font size=4px >"+insname+"</font></td>");
        	out.println("</tr>");
        	}*/
        	%>
		<!--  </table>
		</td></tr>
		<tr><td colspan=2><hr  color=grey>
		</td></tr>-->
		<tr><td>
		<table border=0 width="100%">
		<tr><td align=left width=76%><font size=4px class =tablebold><u>Fees Receipt</u></font>
		</td><td align=right width=24% class =tablelight><font class =tablebold>Date :</font><%=date+" "+time %>
		</td></tr>
		</table>
		</td></tr>
 		<tr><td valign=top align=center  colspan=2><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 > 
		    <tr>
		    	<td  align= center>  
				<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
					<tr align='left' height=30px>
					<td  class='tablebold'>Name of Student </td> 
					<td width='1%' class='tablebold'>:</td>
					<td class='tablelight'  >
					<%=studentname%>
					</td>
					<td  class='tablebold' >Roll No</td>
					<td width='1%' class='tablebold'>:</td>
					<td class='tablelight' >
							<%=rollno%>
					</td>
					</tr>
					<tr align='left' height=30px>
						<td  class='tablebold' >Standard</td>
						<td width='1%' class='tablebold'>:</td>
						<td class='tablelight'>
							<%=studentstandardname%>
						</td>
						<td  class='tablebold' >Section</td>
						<td width='1%' class='tablebold'>:</td>
						<td class='tablelight' >
							<%=sectionname%>
						</td>
					</tr>
					<tr align='left' height=30px>
						<td class='tablebold' >Collection Date</td>
						<td width='1%' class='tablebold' >:</td>
						<td class='tablelight' colspan=4 >
							<%=disfeesdate%>
						</td>
					</tr>
			    </table>		
				<br><br>
				</td></tr>
				<tr><td  colspan=2>
				<table border=1  cellpadding=5 cellspacing=0 width="100%">
				    <thead>
				    <tr class="tableheading">
				    <th>Sl. No </th>
				    <th>Payment Type</th>
				    <th>Bank / Branch Name</th>
				    <th>DD.Number</th>
				    <th>DD Date</th>
				    <th width="30">Amount</th>
				 <!--    <th>Scholarship Type</th> -->
				    
				    
				    </tr>
				    </thead>
				    <tbody>
				    <% if(feesdetailsList!=null && feesdetailsList.size()>0)
				    {
			   	    	String temp_termid="";

				    	int total=0;
				    	for(int i=0;i<feesdetailsList.size();i++)
				    	{
				    		HashMap map=(HashMap)feesdetailsList.get(i);

				    		String termname=map.get("termname")+"";
				    		String termid=map.get("termid")+"";

				    		if(!temp_termid.equals(termid))
				    		{
				    		out.println("<tr><td align=left colspan=7 class=tablebold>"+termname+"</td></tr>");
				    		temp_termid = termid;
				    		}
				    		out.print("<tr class='tablelight'>");
				    		out.print("<td align=left>"+(i+1)+"</td>");
				    		
				    		String bankname=(String)map.get("bankname");
				    		if(bankname==null || bankname.equals(""))
				    			bankname="-";
				    		String ddno=(String)map.get("ddno");

				    		if(ddno==null || ddno.equals("") )
				    			ddno="-";
				    		
				    		String paymenttype      = (String)map.get("paymenttype");
				    		if(paymenttype!=null &&  paymenttype.equals("Online"))
				    			paymenttype="Online Payment";
				    		out.print("<td align=left>"+paymenttype+"</td>");
				    		out.print("<td align=left>"+bankname+"</td>");
				    		out.print("<td align=left>"+ddno+"</td>");
				    		String dddate=(String)map.get("dddate");
				    	/* 	String scholarshipname    = (String)map.get("scholarshipname");
				    		if(scholarshipname==null )
				    			scholarshipname="No Scholarship"; */
				    		
				    		
				    		if(dddate==null || dddate.equals("null"))
				    			dddate="-";
				    		
				    		out.print("<td align=left>"+dddate+"</td>");

				    		Long lObjCollected = Long.valueOf(map.get("collectionamount")+"");
							NumberFormat colFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
							String Currency = colFormat1.format(lObjCollected);
				    		out.print("<td align=left>"+Currency+"</td>");
/* 				    		out.print("<td align=left>"+scholarshipname+"</td>");
 */				    		

				    		out.print("</tr>");
				    		total+=Integer.parseInt(map.get("collectionamount")+"");
				    	}
				    	Long lObjCollected = Long.valueOf(total);
						NumberFormat colFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
						String colformattedCurrency = colFormat1.format(lObjCollected);
			    		out.print("<tr><td colspan=5 align=right class='tablebold'>Total Amount</td><td align=left class='tablelight'>"+colformattedCurrency+"</td></tr>");

				    }
				    %>
				    </tbody>
				    </table>
				 </td></tr>
				 
		</table>
		</td></tr>
		<tr align=center><td colspan=2>&nbsp;
		</td></tr>
		<tr align=center><td colspan=2>
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