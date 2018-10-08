<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<jsp:useBean id="applicationQuery" scope="page" class="com.iGrandee.Application.ApplicationQuery"/>
<%@ page language="java" import="java.util.ArrayList,java.util.HashMap,java.text.NumberFormat,java.util.Locale" %>
<html>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />
<head>
<% 	java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Application Receipt	</title>

<script language="javascript">

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
 <body bgcolor="#ffffff" topmargin=10 leftmargin=0 rightmargin=0 onload="window.print()">

<!-- <body bgcolor="#ffffff" topmargin=10 leftmargin=0 rightmargin=0>
 --><%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,com.iGrandee.Fees.FeesSchedule,java.text.NumberFormat,java.util.Locale"%>	

<%@ page language="java" import="com.iGrandee.Registration.InstitutionQurey,com.iGrandee.Common.DateTime"%>
<% 
InstitutionQurey insquery=new InstitutionQurey();
String instituteid		= (String)session.getValue("instituteid");
ArrayList insdetails=insquery.getInstituteDetails(instituteid);
String transportfeestypeid = null;
String transportcategoryid = null;
String	studentname = null;
String sessionid    = null;String institutetransporttypeid=null;
sessionid= request.getParameter("sessionid");
String req_paidstatus = request.getParameter("req_paidstatus");
institutetransporttypeid= request.getParameter("institutetransporttypeid");
transportcategoryid= request.getParameter("transportcategoryid");
String transportcategoryname= request.getParameter("transportcategoryname");

//out.println(transportcategoryid);

//out.println(paidstatus);

%>

<!--  hidden by rams, as per the suriya's request change the print heder and size -->
<!-- <table border=0 cellpadding=0 cellspacing=0 width="350" align=center height=100>
 -->
 <table border=0 cellpadding=0 cellspac ing=0 width="700" align=center height=100>
 <tr>
<td>
	<table width="100%" border="0" cellspacing="0">
		<tr valign=top align=center>
			<td class="tablebold">
				<%-- <font color="#000000"><b><%=session.getValue("institutename")%></b> --%>
				<%@ include file="../include/reportprintheader.jsp"%>
				
			</td>
		</tr>

	</Table><br>
</td>
</tr>
<tr align=center>
<td>
<center>
 <h3>Transport Fees   
    <%if(request.getParameter("req_paidstatus").equals("paid")){ %>

     / Paid Student List
    <% %>
    <%}else{ %>
    / Pending Student List
    <%} %>
    </h3>
</center>

</td>
</tr>
<tr>
<td>

	<table id="rounded-corner" border=0 summary="Examname List" width="100%" align="center">
      
 <tr>
 <td class=tablebold> Session Name :</td><td class=tablelight colspan=3 align=left><%=request.getParameter("sessionname") %></td>
 <td class=tablebold>Category Name :</td><td><%=transportcategoryname%></td>
 </tr>
 </table>
		<br></br>
<table border=1 summary="Examname List" cellpadding=4 cellspacing=0 width="100%" align="center">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%"><%=bundle.getString("label.examnamelist.SL.No")%></th>
        	<th scope="col" class="rounded">Student Name</th>
            <th scope="col" class="rounded">Roll No.</th>
        	<th scope="col" class="rounded">Standard Name</th>
            <th scope="col" class="rounded">Section Name</th>
            
        	<!-- <th scope="col" class="rounded-q4">E-Mail</th> -->
        	<th scope="col" class="rounded-q4">Mobile Number</th>
        	
        </tr>
    </thead>
    
   <!--  <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot> -->
     
     <tbody> 	
     <jsp:useBean id="query_object" scope="page"
	class="com.iGrandee.TransportFees.FeesSettingsAction" />
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.TransportFees.FeesSettingsAction"%>
     		 <%
			     FeesSettingsAction  transportmonth = new FeesSettingsAction();			     
			     ArrayList Loadtransportmonth = null;
			  ArrayList paycountlist=null;
					int payno=0;int notpayno=0;

			     HashMap innermap=null; 
				     try
				     {
				    	 //Loadtransportmonth = transportmonth.categorywiseStudentList(transportcategoryid);
				    	 Loadtransportmonth = transportmonth.categorywiseStudentList(transportcategoryid,sessionid);
				    	 //out.println("Loadtransportmonth===>>"+Loadtransportmonth);
					    	 ArrayList archivalDetails = new ArrayList();
					    	 String temp_transportstageid = "";
					    	 String temp1_transportstageid = "";
					    	 String paid=null; String notpaid= null;
					    	 if(Loadtransportmonth!=null && Loadtransportmonth.size()>0)
								{
					    		 
					    		 for (int i = 0, j = 1; i < Loadtransportmonth.size(); i++) {
								
									HashMap feestypeListMap=(HashMap)Loadtransportmonth.get(i);
									
									String standardname   = (String)feestypeListMap.get("standardname");
									String sectionname   	= (String)feestypeListMap.get("sectionname");
									String studprefix = (String)feestypeListMap.get("prefix");
									String firstname   	= (String)feestypeListMap.get("firstname");
									String middlename   	= (String)feestypeListMap.get("middlename");
									String transportstageid   	= (String)feestypeListMap.get("transportstageid");
									String transportstagename   	= (String)feestypeListMap.get("transportstagename");
									String spaidstatus   	= (String)feestypeListMap.get("paidstatus");
									String lastname   	= (String)feestypeListMap.get("lastname");
									String rollnumber   	= (String)feestypeListMap.get("rollno");
									String mobilenumber   	= (String)feestypeListMap.get("mobilenumber");
									if(rollnumber ==null)
										rollnumber = "<i>NYG<i>";
									
									String emailid = (String)feestypeListMap.get("emailid");
									if(middlename==null || middlename.equals("") ||  middlename.equals("-"))
							    		studentname = studprefix+""+firstname+"&nbsp;"+lastname;
							    		else
							    		studentname = studprefix+"&nbsp;"+firstname+"&nbsp;"+middlename+"&nbsp;"+lastname;	
									 
									
									%> 
								<%
								
								
								if(req_paidstatus.equals("paid") && spaidstatus.equals("Paid"))
								{if(!temp_transportstageid.equals(transportstageid))
								{
									out.println("<tr><td colspan=6> <a class=tablebold>Stage Name : </a><a class=tablelight>"+transportstagename+"</a></td></tr>");
									temp_transportstageid= transportstageid;
								} 
									out.println("<tr class=tablelight>");
									
									out.println("<td>"+j+++".</td>");
									out.println("<td>"+studentname+"</td>");
									out.println("<td>"+rollnumber+"</td>");

									out.println("<td>"+standardname+"</td>");								
									out.println("<td>"+sectionname+"</td>");
									/* out.println("<td>"+emailid+"</td>"); */
									out.println("<td>"+mobilenumber+"</td>");
								}
								else if(req_paidstatus.equals("pending")  && spaidstatus.equals("Pending"))
								{if(!temp1_transportstageid.equals(transportstageid))
								{
									out.println("<tr><td colspan=6> <a class=tablebold>Stage Name : </a><a class=tablelight>"+transportstagename+"</a></td></tr>");
									temp1_transportstageid= transportstageid;
								}
									out.println("<tr>");
									out.println("<td>"+j+++".</td>");
									out.println("<td>"+studentname+"</td>");
									out.println("<td>"+rollnumber+"</td>");
									out.println("<td>"+standardname+"</td>");								
									out.println("<td>"+sectionname+"</td>");
									
									
									/* out.println("<td>"+emailid+"</td>"); */
									out.println("<td>"+mobilenumber+"</td>");
									
								}
									
									
									
										 
									
										
									out.println("</tr>");
					    		 }
							}
					    	 
					    	 else{
								out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
					    	 }
				     }	 
					catch(Exception e){
						
						e.printStackTrace();
						
					}
			     %>
    </tbody>
 </table>
</td></tr>
<tr><td>
<table border="0" align=right>
	<br>
	<tr class='tablelight'>
	<td align=left width=50%>
	<!-- as per the suriya's request hidden the followning changes -->
			<%-- <font color='#000000'><b><%=bundle.getString("label.applicationissueprint.CreatedBy")%></b> --%>
	</td>
	<td align=right  width=100%>
			<font color='#000000'><b><%=bundle.getString("label.applicationissueprint.Signature")%></b>
	</td>
	</tr>
</table>
</td></tr>
<tr><td>
<table>
	<tr class='tablelight'>
	<td align=left width=100%>
			<%-- <font color='#000000'><%=session.getValue("userfullname")%> --%>
	</td>
	<td align=right  width=100%>

	</td>
	</tr>
</table>
</td></tr>
</table>
<center>
<input type=button  name=printbutt id=printbutt  onclick='printfun()'  value=Print >

	<input type=button name=backbutt id=backbutt onclick='goBack()' value=Close >
	</center>
</html>