<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - Admission Report Datewise | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function goBack()
{
	document.applicationForm.action= "RegistrationReportDatewiseCons.jsp";
	document.applicationForm.submit();
}

function printReport()
{
  //window.open("./ApplicationReportPrint.jsp?applno=A12&standardnamegp=standardname&req_sessionname=sessionname&req_boardname=boardname","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800;")
	//window.open("./ApplicationReportPrint.jsp?req_sessionname="+document.applicationForm.req_sessionname.value+"&req_boardname="+document.applicationForm.req_boardname.value+"&req_sessionid="+document.applicationForm.req_sessionid.value+"&req_boardid="+document.applicationForm.req_boardid.value+"&req_sessionstatus="+document.applicationForm.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
	window.open("./RegistrationReportPrint.jsp?req_sessionname="+document.applicationForm.req_sessionname.value+"&req_boardname="+document.applicationForm.req_boardname.value+"&req_sessionid="+document.applicationForm.req_sessionid.value+"&req_boardid="+document.applicationForm.req_boardid.value+"&standardnamegp="+document.applicationForm.standardnamegp.value+"&standardpublishid="+document.applicationForm.standardpublishid.value+"&appFrom="+document.applicationForm.appFrom.value+"&appTo="+document.applicationForm.appTo.value+"&req_sessionstatus="+document.applicationForm.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=800,scrollbars=1;")
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

    <h2><%=bundle.getString("label.admisionreportviewdatewisecons.rootpath1")%></h2>

<form name="applicationForm" action="" method="post">


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
      
            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.admisionreport.SelectedInformation")%> </th>
            <th scope="col" class="rounded-q4" width="10%"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td  class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
    <tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
		<td class=tablebold width="25%"><%=bundle.getString("label.admisionview.AcademicYear")%></td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold width="25%"><%=bundle.getString("label.admisionreport.Board")%></td><td class=tablebold width='2%'>:</td><td class=tablelight><%=request.getParameter("req_boardname") %></td>
	</tr>
	<tr><td class=tablebold><%=bundle.getString("label.admisionreport.Standard")%></td><td class=tablebold width='2%'>:</td><td  colspan=3  class=tablelight><%=request.getParameter("standardnamegp") %></td>
	<tr>
		<td class=tablebold width="25%"><%=bundle.getString("label.admisionreport.FromDate")%></td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=request.getParameter("appFormatFrom") %></td>
		<td class=tablebold width="25%"><%=bundle.getString("label.admisionreport.ToDate")%></td><td class=tablebold width='2%'>:</td><td class=tablelight><%=request.getParameter("appFormatTo") %></td>
	</tr>
	<% 
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
		out.print("<tr><td class=tablebold width='25%'>Archival Details</td><td class=tablebold width='2%'>:</td><td class=tablelight >This is an Archived Year</td></tr>");
	}	
	%>	
</tr>
</table>
</td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
   <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle.getString("label.admisionreport.SL.No")%></th>
            <th scope="col" class="rounded" width="35%"><%=bundle.getString("label.admisionreport.ApplicantName")%></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.admisionreport.ApplicationNo")%></th>
            <th scope="col" class="rounded" width="20%"><%=bundle.getString("label.admisionreport.AdmissionFees")%></th>
            <th scope="col" class="rounded-q4" width="40%"><%=bundle.getString("label.admisionreport.DateofAdmission")%></th>

                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>

     <%
     com.iGrandee.Application.RegistrationProcess  applicationQuery = new com.iGrandee.Application.RegistrationProcess();
     String instituteid = null;
     ArrayList applicantList = null;
		java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
	    //Locale localcurrency = new Locale("en", "IN");


	 int costofApplication 	  = 0;
	 String substCostofApplication 	  = null;
     String appCostCurrency = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");

    	  //applicantList = applicationQuery.loadApplicantListDatewise(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),request.getParameter("standardpublishid"),"A",request.getParameter("appFrom"),request.getParameter("appTo"));
    	  applicantList = applicationQuery.loadAdmittedListDatewise(request.getParameter("standardpublishid"),"A",request.getParameter("appFrom"),request.getParameter("appTo"),instituteid);
    	//System.out.println("applicantList-->"+applicantList);
    	//scholarshipcategoryid,categoryname
    	 if(applicantList!=null && applicantList.size()>0)
			{
    		 for (int i = 0, j = 1; i < applicantList.size(); i++) {
			
				HashMap applicantListMap=(HashMap)applicantList.get(i);
				String registrationId      = (String)applicantListMap.get("registrationid");
				String applicantName      = (String)applicantListMap.get("applicantname");
				String applicationNo      = (String)applicantListMap.get("applicationno");
				String costofApp		  = (String)applicantListMap.get("registrationamount");
				String contactNo		  = (String)applicantListMap.get("contactno");
				String receiptNo		  = (String)applicantListMap.get("receiptno");
				String dateofcreation     = (String)applicantListMap.get("dateofadmission");				
				
				//substCostofApplication 	  = costofApp.substring(0,costofApp.lastIndexOf("."));
						
			    costofApplication 	  	  		= Integer.parseInt(costofApp);
				Long appCostObj 				= Long.valueOf(costofApplication); 
				NumberFormat appCostObjFormat	= NumberFormat.getCurrencyInstance(localcurrency);
				appCostCurrency 				= appCostObjFormat.format(appCostObj);
				%>
				
				<tr>
        	 <td><%=j++ %></td>
            <td><%=applicantName %></td>
            <td><%=applicationNo %></td>
            <td><%=appCostCurrency %></td>           
            <td><%=dateofcreation %> </td>
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=7>Data not found</td></tr>");    	 
    	 	}
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>
  
   <a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.admisionreport.Back")%></strong><span class="bt_blue_r"></span></a>
   <a href="#" class="bt_green" onclick="printReport()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.admisionreport.Print")%></strong><span class="bt_green_r"></span></a>
   
	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	
	<input type=hidden name="statuschange">
	
	<input type='hidden' name='appFrom' value='<%=request.getParameter("appFrom")%>'>
	<input type='hidden' name='appTo' value='<%=request.getParameter("appTo")%>'>
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>