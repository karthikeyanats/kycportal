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
String rows =request.getParameter("rows")+"";
String studentapprovalid =session.getValue("studentapprovalid")+"";
String termfeesid =request.getParameter("termfeesid")+"";
String termamount =request.getParameter("termamount")+"";

Long lObj2 = Long.valueOf(termamount);
NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
String formattedCurrency = format.format(lObj2);



	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
    ArrayList feesScheduleList = null;
	String	 termname= feesscheduleQuery.studenttermfeesnameDetailsforprint(termfeesid);

	feesScheduleList = feesscheduleQuery.LoadStudentDetails(studentapprovalid);
	String standardscheduleid="";
	HashMap feesScheduleListMap=(HashMap)feesScheduleList.get(0);
	String studentstandardname      = (String)feesScheduleListMap.get("standardname");
	String studentsectionname      = (String)feesScheduleListMap.get("sectionname");
	String studentgroupname      = (String)feesScheduleListMap.get("groupname");
	String uname      = (String)feesScheduleListMap.get("uname");
	String imagepath      = (String)feesScheduleListMap.get("imagepath");
	String rollno      = (String)feesScheduleListMap.get("rollno");
	datacount++;
	//studentapprovalid      = (String)feesScheduleListMap.get("studentapprovalid");
	ArrayList feesdetailsList = null;  
	feesdetailsList = feesscheduleQuery.studentFeescollectionDetailsforprint(studentapprovalid,rows);
	
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
		<table border=0 width=100%>
		
		<tr align =right width=100%>
		<td align =right class =tablelight><font class =tablebold><%=bundle1.getString("label.feesprintpreview.Date")%> :</font><%=date+" "+time %>
		</td></tr>
		<tr>
		<td align =center width=100%>
		<font size=4px class =tablebold>
		<u><%=bundle1.getString("label.feesprintpreview.FeesReceipt")%></u></font>
		</td>
		</tr>
		</table>
		</td></tr>
		<tr><td valign=top align=center  colspan=2><br>
		<table  border=0 width=100% cellspacing=0 cellpadding=0 > 
		    <tr>
		    	<td  align= center>  
				<table width='55%' align='center' border='0' cellpadding='5' cellspacing='0'>
					<tr align='left' height=30px>
					<td  class='tablebold' width=50% ><%=bundle1.getString("label.feesprintpreview.NameofStudent")%> </td> 
					<td width='1%' class='tablebold'>:</td>
					<td class='tablelight'  >
					<%=uname%>
					</td>
					</tr>
					<tr align='left' height=30px>
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
						</tr>
					<tr align='left' height=30px>
						<td  class='tablebold' ><%=bundle1.getString("label.feesprintpreview.Section")%></td>
						<td width='1%' class='tablebold'>:</td>
						<td class='tablelight' >
							<%=studentsectionname%>
						</td>
					</tr>
					<tr align='left' height=30px>
						<td class='tablebold' ><%=bundle1.getString("label.feesprintpreview.TermName")%></td>
						<td width='1%' class='tablebold' >:</td>
						<td class='tablelight'  >
							<%=termname%>
						</td>
						</tr>
					<tr align='left' height=30px>
						<td  class='tablebold' ><%=bundle1.getString("label.feesprintpreview.TermAmount")%></td>
						<td width='1%' class='tablebold' >:</td>
						<td class='tablelight'  >
							<%=formattedCurrency%>
						</td>
					</tr>
					<tr align='left' height=30px>
						<td  class='tablebold' ><%=bundle1.getString("label.feesprintpreview.paymenttype")%></td>
						<td width='1%' class='tablebold' >:</td>
						<td class='tablelight'  >
							Online Payment
						</td>
					</tr>
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