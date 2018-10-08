<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.admisionprocess.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript">
function printfun()
{
	 window.open("RegPrint.jsp?regno="+document.f1.regno.value+"","Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300;")

	//window.open("RegPrint.jsp?regno="+document.f1.regno.value);

}
function deletefun()
{
	if(confirm("Are sure to want to delete this registration no?."))
	{
	f1.action="deleteRegistration.jsp";
	f1.submit();
}

}
function newfun()
{
	if(confirm("do you want to go to registration fees home page?"))
	{
	f1.action="RegistrationProcessList_Pre.jsp";
	f1.submit();
	}
}

function printfunnew()
{
	var req_sessionname = document.f1.reg_sessiontext.value;
	var req_boardname = document.f1.reg_boardname.value;
	var standardnamegp = document.f1.reg_coursename.value;
	 window.open("RegPrintFinal.jsp?applicationid="+document.f1.applicationid.value+"&req_sessionname="+req_sessionname+"&req_boardname="+req_boardname+"&standardnamegp="+standardnamegp,"Msg","top=250,left=350,help:no,center:no,status:no,width=500,height=300;")

	//window.open("RegPrint.jsp?regno="+document.f1.regno.value);

}

function goBack()
{
	document.f1.action="RegistrationProcessList_Pre.jsp";
	document.f1.submit();
}
</script>
</head>
<body>
<div id="main_container">
	<div class="header">
<%@ include file="../include/userheader.jsp" %>
   
    </div>

    <div class="main_content">

<%@ include file="../include/header.jsp" %>


    <div class="center_content">



    <div class="left_content">

    </div>

    <div class="right_content">

    <h2><%=bundle.getString("label.admisionprocess.rootpath")%></h2>

	<form name=f1 action="" method="post">
	<table id="rounded-corner" border=0 summary="Department List" width="100%">
	    <thead>
	    	<tr>
	        	<th scope="col" class="rounded-company" width="10"></th>
	        	<th scope="col" class="rounded" width="100%"><%=bundle.getString("label.admisionprocess.AdmissionPreview")%></th>
	        	<th scope="col" class="rounded-q4" width="10" ></th>
	            
	        </tr>
	    </thead>
	    <tfoot>
	    	<tr>
	        	<td colspan=2  class="rounded-foot-left"><em></em></td>
	        	<td class="rounded-foot-right">&nbsp;</td>
	       </tr>
	    </tfoot>	
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,java.util.ResourceBundle,java.util.Locale,com.iGrandee.Application.RegistrationProcess"%>

     <%
 	 //ResourceBundle bundle 	= ResourceBundle.getBundle("ResourceBundle.English_eng");
     ResourceBundle serBundle 	= ResourceBundle.getBundle("resources.serversetup");
	 Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
     
     com.iGrandee.Application.RegistrationProcess  queryBean = new com.iGrandee.Application.RegistrationProcess();	
     com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	

     try
     {
     String appidss = request.getParameter("applicationid");

 	String reg_sessionid = "";
 	String reg_sessiontext = "";
 	String reg_boardid = "";
 	String reg_boardname = "";
 	String reg_coursepubid = "";
 	String reg_coursename = "";
 	String regno = request.getParameter("regno");
 	String appno = request.getParameter("appno");
 	String formattedRegFeeCurrency=null;
 //out.print("appno-->"+appno);
 	reg_sessionid = request.getParameter("reg_sessionid");
 	reg_sessiontext = request.getParameter("reg_sessiontext");
 	reg_boardid = request.getParameter("reg_boardid");
 	reg_boardname = request.getParameter("reg_boardname");
 	reg_coursepubid = request.getParameter("reg_coursepubid");
 	reg_coursename = request.getParameter("reg_coursename");

 	ArrayList searchlist=(ArrayList)queryBean.displayforRegistrationDetails(appno);
 	String registrationid = "";
 	String applicationid="";
 	String registrationfees="";
 	String dateofregistration = "";
 	String branchid = "";
 	String applicationno = "";
 	String applicantname = "";
 	String receiptno = "";
 	if(searchlist.size() > 0)
 		{
 			for(int i=0;i<searchlist.size();i++)
 			{
 				HashMap searchmap = (HashMap)searchlist.get(i);
 				 registrationid = (String)searchmap.get("registrationid");
 				 applicationid=(String)searchmap.get("applicationid");
 				 registrationfees=(String)searchmap.get("registrationamount");
 				 dateofregistration = (String)searchmap.get("dateofcreation");
 				 //branchid = (String)searchmap.get("branchid");
 				 applicationid = (String)searchmap.get("applicationid");
 				 applicationno = (String)searchmap.get("applicationno");
 				 applicantname = (String)searchmap.get("applicantname");
 				 receiptno = (String)searchmap.get("receiptno");
 	
 			    Long regFeeObj 			= Long.valueOf(registrationfees); 
			    java.text.NumberFormat termFeeFormat 	= java.text.NumberFormat.getCurrencyInstance(localcurrency);
			    formattedRegFeeCurrency 	= termFeeFormat.format(regFeeObj); 	
 			}
 		}   
   
    %>

   <tr><td><td>
    <table id="rounded-corner1" width="100%" border=0>
    <% 
    if(searchlist.size() > 0)
    {
    %>
    <tr ><td><%=bundle.getString("label.admisionprocessprintpreview.ApplicationNo")%>. </td><td class=tablebold width='2%'>:</td><td><%=applicationno %></td></tr>
    <tr ><td><%=bundle.getString("label.admisionprocess.NameofApplicant")%></td><td class=tablebold width='2%'>:</td><td><%=applicantname %></td></tr>
    <tr><td><%=bundle.getString("label.admisionprocessprintpreview.Standard")%></td><td class=tablebold width='2%'>:</td><td><%=reg_coursename %></td></tr>
    <tr><td><%=bundle.getString("label.admisionprocessprintpreview.BoardName")%></td><td class=tablebold width='2%'>:</td><td><%=reg_boardname%></td></tr>
  	<tr ><td><%=bundle.getString("label.admisionprocessprintpreview.AcademicYear")%> </td><td class=tablebold width='2%'>:</td><td><%=reg_sessiontext %></td></tr>
    <tr><td><%=bundle.getString("label.admisionprocessprintpreview.AdmissionFees")%>. </td><td class=tablebold width='2%'>:</td><td><%=formattedRegFeeCurrency %></td></tr>
    	<input type=hidden name=applicationid value="<%=appidss %>">

	<input type=hidden name=reg_sessionid value="<%=reg_sessionid %>">
	<input type=hidden name=reg_sessiontext value="<%=reg_sessiontext %>">
	<input type=hidden name=reg_boardid value="<%=reg_boardid %>">
	<input type=hidden name=reg_boardname value="<%=reg_boardname %>">
	<input type=hidden name=reg_coursename value="<%=reg_coursename %>">
	<input type=hidden name=reg_coursepubid value="<%=reg_coursepubid %>">
    <% 
    }
    else
    {
    	%>
    	<tr><td class=tablelight colspan=5>No information</td></tr></table><br>

    	<%	
    }
	%>
     </table>
  </td><td></td></tr>
    	</tbody>
		</table>

 	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
    
    <a href="#" class="bt_green" onclick="printfunnew()"><span class="bt_green_lft"></span><strong>Print</strong><span class="bt_green_r"></span></a> 

</form>
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>

<% 	 	
     }
     catch(Exception e)
     {
     	//System.out.println("INTRAPORTAL"+e.getMessage());
     }
%>
 
     

</body>
</html>