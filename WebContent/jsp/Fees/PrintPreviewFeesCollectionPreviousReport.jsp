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

String termfeesid =request.getParameter("termfeesid")+"";

	
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
					<%
						out.print("<table  border='0' bordercolor='blue' align='center' width='100%' cellspacing='0' cellpadding='5'  class='tablelight'>");
						out.print("<tr  align=left><td width='25%' class='tablebold' align=left>"+bundle1.getString("label.feescollectionparent.StudentName")+"</td><td width='1%' class='tablebold'>:</td><td align=left>"+session.getValue("studentname")+"</td><td class='tablebold' align=left>"+bundle1.getString("label.feescollectionparent.AcademicYear")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sessionname")+"</td></tr>");
						if(session.getValue("groupname") == null)
							out.print("<tr  align=left><td class='tablebold' align=left>"+bundle1.getString("label.feescollectionparent.BoardMedium")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+" -"+session.getValue("mediumname")+"</td><td class='tablebold' align=left>"+bundle1.getString("label.feescollectionparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"</td>");
						else
							out.print("<tr  align=left><td class='tablebold' align=left>"+bundle1.getString("label.feescollectionparent.BoardMedium")+"</td><td class='tablebold'>:</td><td>"+session.getValue("boardname")+" -"+session.getValue("mediumname")+"</td><td class='tablebold' align=left>"+bundle1.getString("label.feescollectionparent.StandardName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("standardname")+"&nbsp;&nbsp;[&nbsp;"+session.getValue("groupname")+"&nbsp;]</td>");
						
						out.print("</tr>");
						
						out.print("<tr  align=left><td class='tablebold' align=left>"+bundle1.getString("label.feescollectionparent.SectionName")+"</td><td class='tablebold'>:</td><td>"+session.getValue("sectionname")+"</td><td class='tablebold' align=left>"+bundle1.getString("label.feescollectionparent.RollNo.")+"</td><td class='tablebold'>:</td><td>"+session.getValue("rollno") + "</td></tr>");
						out.print("</table>");
					%>
					<br>
				</td>
				</tr>
				<tr>
				<td>
				   <table  border=1 bordercolor=black  width=100%  cellpadding=0 cellspacing=0 align=center >
    	<tr  class=tableheading height=25px>
        	<th scope="col" class="rounded-company"><%=bundle1.getString("label.feescollectionparent.SL.No") %></th>
        	<th scope="col" class="rounded" ><%=bundle1.getString("label.feescollectionparent.TermName") %></th>
        	<th scope="col" class="rounded"><%=bundle1.getString("label.feescollectionparent.DueDate") %></th>
        	<th scope="col" class="rounded"><%=bundle1.getString("label.feescollectionparent.FeesAmount") %></th>
        	<th scope="col" class="rounded"><%=bundle1.getString("label.feescollectionparent.PaidAmount") %></th>
        	<th scope="col" class="rounded-q4"><%=bundle1.getString("label.feescollectionparent.PaymentType1") %></th>
        </tr>
	     <%
	     //System.out.println("standardscheduleid-->"+standardscheduleid);
	     	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
	     	int totalamount =0;
	     	int totalPaidamount =0;
	     	int totalRemamount =0;

	     	int temptotalamount =0;
	     	int temptotalPaidamount =0;
	     	String paidformattedCurrency = null;
	     	String remformattedCurrency = null;

	     	String paidTermFee="0";
			ArrayList termList =  feesscheduleQuery.loadTermFeesDetailsForSelectedTermfeesid(session.getValue("standardscheduleid")+"",termfeesid,session.getValue("studentapprovalid")+"");
			HashMap termhashmap =null;
			if(termList != null && termList.size()>0){
				for(int y=0;y<termList.size();y++){
				termhashmap		= (HashMap)termList.get(y);
				String innertermfeesid  = (String)termhashmap.get("termfeesid");
				String termname  = (String)termhashmap.get("termname");
				String termfeesamount  = (String)termhashmap.get("termfeesamount");
				String duedate  = (String)termhashmap.get("duedate");
				String paymenttype  = (String)termhashmap.get("paymenttype");

				
				String formattedCurrency = null;
   
				 if(termfeesamount == null)
		    	  {
					 termfeesamount = "0";
		    	  }

		    	    Long lObj2 = Long.valueOf(termfeesamount);
		    	    NumberFormat format = NumberFormat.getCurrencyInstance(localcurrency);
		    	    formattedCurrency = format.format(lObj2);
		    	   temptotalamount = Integer.parseInt(termfeesamount);
		    	   totalamount +=Integer.parseInt(termfeesamount);
					paidTermFee =  (String)termhashmap.get("collectionamount");
					 if(paidTermFee == null)
			    	  {
						 paidTermFee = "0";
			    	  }

		    	    Long lObj3 = Long.valueOf(paidTermFee);
		    	    NumberFormat paidFormat = NumberFormat.getCurrencyInstance(localcurrency);
		    	    paidformattedCurrency = paidFormat.format(lObj3);
					if(paymenttype!=null && paymenttype.equals("Online"))
						paymenttype="Online Payment";
		%>
     <tr  class=tablelight >
     <!--  <td><input type=radio name=termcheck value="<%=termfeesid %>" termname="<%=termname %>" onclick="showterm(this)"/></td>-->
      <td><%= (y+1)%></td>
     <td><%= termname%></td>
     <td><%=duedate %></td>
     <td><%= formattedCurrency%></td>
     <td><%= paidformattedCurrency%></td>
     <td><%= paymenttype%></td>
	 </tr>
     <%
     datacount++;
				}
			}
			 	
     %>
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