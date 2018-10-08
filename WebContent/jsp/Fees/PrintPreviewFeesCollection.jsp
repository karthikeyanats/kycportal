<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feesprintpreview.FeesReceipt")%> | Powered by i-Grandee</title>
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
String rows =request.getParameter("rows")+"";
String studentapprovalid =request.getParameter("studentapprovalid")+"";
String termname =request.getParameter("termname")+"";
String termamount =request.getParameter("termamount")+"";
String paymenttype =request.getParameter("paymenttype")+"";

Long lObj2 = Long.valueOf(termamount);
NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
String formattedCurrency = format.format(lObj2);



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
	feesdetailsList = feesscheduleQuery.studentFeescollectionDetailsforprint(studentapprovalid,rows);
	if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
	studentname = studprefix+""+firstname+""+lastname;
	else
		studentname = studprefix+""+firstname+""+middlename+""+lastname;
	
	if(studentgroupname ==null || studentgroupname.equals("-"))
		studentstandardname = studentstandardname;
	else
		studentstandardname = studentstandardname+" - "+studentgroupname;
	 String  time				= DateTime.showTime("Time");
	 String  date				= DateTime.showTime("calendar");

%>
<form name="Schedule_Form" action="" method="post">

		<table  border=0  width=640 >
		<tr height=50px><td align=left>
						<%@ include file="../include/reportprintheader.jsp"%>
		</td></tr>
		<tr><td><hr  color=grey>
		</td></tr>
		<tr><td>
		<table border=0>
		<tr><td align =center width=70%><font size=4px class =tablebold><u><%=bundle1.getString("label.feesprintpreview.FeesReceipt")%></u></font>
		</td><td></td><td></td><td align =right class =tablelight><font class =tablebold><%=bundle1.getString("label.feesprintpreview.Date")%> :</font><%=date+" "+time %>
		</td></tr>
		</table>
		</td></tr>
		<!--  <tr height=50px><td align=center>
		<table  border=0 width=100% class=tablebold cellpadding='0' cellspacing='0'>
		
		<tr height=100px ><td colspan=2>
		<table border=0  cellpadding='0' cellspacing='0' style="float:left;" align=left>-->		
		<%
		/*
    	if(insdetails!=null && insdetails.size()>0)
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
        	String zip=map.get("zip")+"";        	
        	String url=map.get("url")+"";
        	if(url.equals("-"))
        		url="";
        	out.println("<tr align=left>");
        	out.println("<td rowspan=7 valign=top><img src='"+request.getContextPath()+"/OpenDocument?r1=storagepath&r2="+inslogo+"' width=110 height=110>&nbsp;</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>"+insname+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>"+contactaddress+"</td>"); 
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>"+state+","+country+"-"+zip+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>"+landlinenumber+","+landlinenumber+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>"+emailid+"</td>");
        	out.println("</tr>");
        	out.println("<tr align=left>");
        	out.println("<td>"+url+"</td>");
        	out.println("</tr>");
        	
        	//out.println("<td  ><img src='/kycportal/OpenDocument?r1=storagepath&r2="+inslogo+"' width=110 height=110></td>");
        	//out.println("<td valign=top ><font size=4px >"+insname+"</font></td>");
        	//out.println("</tr>");
        	}*/
        	%>
		<!--  </table>
		</td></tr>
		<tr><td colspan=2><hr  color=grey>
		</td></tr>
		<tr><td align =right width=55%><font size=4px class =tablebold><u><%=bundle1.getString("label.feesprintpreview.FeesReceipt")%></u></font>
		</td><td align =right class =tablelight><font class =tablebold><%=bundle1.getString("label.feesprintpreview.Date")%> :</font><%=date+" "+time %>
		</td></tr>-->
		<tr><td valign=top align=center  colspan=2><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 > 
		    <tr>
		    	<td  align= center>  
				<table width='90%' align='center' border='0' cellpadding='5' cellspacing='0'>
					<tr align='left' height=30px>
					<td  class='tablebold'><%=bundle1.getString("label.feesprintpreview.NameofStudent")%> </td> 
					<td width='1%' class='tablebold'>:</td>
					<td class='tablelight'  >
					<%=studentname%>
					</td>
					<td  class='tablebold' ><%=bundle1.getString("label.feesprintpreview.RollNo")%></td>
					<td width='1%' class='tablebold'>:</td>
					<td class='tablelight' >
							<%=rollno%>
					</td>
					</tr>
					<tr align='left' height=30px>
						<td  class='tablebold' ><%=bundle1.getString("label.feesprintpreview.Standard")%></td>
						<td width='1%' class='tablebold'>:</td>
						<td class='tablelight'>
							<%=studentstandardname%>
						</td>
						<td  class='tablebold' ><%=bundle1.getString("label.feesprintpreview.Section")%></td>
						<td width='1%' class='tablebold'>:</td>
						<td class='tablelight' >
							<%=sectionname%>
						</td>
					</tr>
					<tr align='left' height=30px>
						<td class='tablebold' ><%=bundle1.getString("label.feesprintpreview.TermName")%></td>
						<td width='1%' class='tablebold' >:</td>
						<td class='tablelight'  >
							<%=termname%>
						</td>
						<td  class='tablebold' ><%=bundle1.getString("label.feesprintpreview.TermAmount")%></td>
						<td width='1%' class='tablebold' >:</td>
						<td class='tablelight'  >
							<%=formattedCurrency%>
						</td>
					</tr>
						<tr align='left' height=30px>
						<td  class='tablebold' ><%=bundle1.getString("label.feesprintpreview.paymenttype")%></td>
						<td width='1%' class='tablebold' >:</td>
						<td class='tablelight'  colspan=4>
							<%=paymenttype%>
						</td>
					</tr>
			    </table>		
				<br><br>
				</td></tr>
				<tr><td  colspan=2>
				<table border=1  cellpadding=5 cellspacing=0 width="100%">
				    <thead>
				    <tr class="tableheading">
				    <th><%=bundle1.getString("label.feesprintpreview.SL.No")%> </th>
				    <th><%=bundle1.getString("label.feesprintpreview.Bank/BranchName")%></th>
				    <th><%=bundle1.getString("label.feesprintpreview.DD.Number")%></th>
				    <th><%=bundle1.getString("label.feesprintpreview.DDDate")%></th>
				    <th width="30"><%=bundle1.getString("label.feesprintpreview.Amount")%></th>
				    <th><%=bundle1.getString("label.feesprintpreview.PaymentType")%></th>
				    </tr>
				    </thead>
				    <tbody>
				    <% if(feesdetailsList!=null && feesdetailsList.size()>0)
				    {
				    	int total=0;
				    	for(int i=0;i<feesdetailsList.size();i++)
				    	{
				    		HashMap map=(HashMap)feesdetailsList.get(i);
				    		out.print("<tr class='tablelight'>");
				    		out.print("<td>"+(i+1)+"</td>");
				    		out.print("<td align=left>"+map.get("bankname")+"</td>");
				    		out.print("<td align=left>"+map.get("ddno")+"</td>");
				    		if(map.get("dddate")==null || map.get("dddate").equals("null"))
				    			out.print("<td align=left>-</td>");
				    		else	
				    			out.print("<td align=left>"+map.get("dddate")+"</td>");
				    		
				    		Long lObjCollected = Long.valueOf(map.get("collectionamount")+"");
							NumberFormat colFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
							String Currency = colFormat1.format(lObjCollected);
				    		out.print("<td align=left>"+Currency+"</td>");
				    		out.print("<td align=left>"+map.get("scholarshipname")+"</td>");
				    		out.print("</tr>");
				    		total+=Integer.parseInt(map.get("collectionamount")+"");
				    	}
				    	Long lObjCollected = Long.valueOf(total);
						NumberFormat colFormat1 = NumberFormat.getCurrencyInstance(localcurrency);
						String colformattedCurrency = colFormat1.format(lObjCollected);
			    		out.print("<tr><td colspan=4 align=right class='tablebold'>Total Amount</td><td align=left class='tablelight'>"+colformattedCurrency+"</td><td></td></tr>");

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