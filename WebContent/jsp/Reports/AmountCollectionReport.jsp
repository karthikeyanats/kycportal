<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>


<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.applicationreport.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />

<script type="text/javascript">
function printfun()
{
	window.open("PrintPreviewAmountCollectionReportDateWise.jsp?sessionname="+document.approvalForm.sessionname.value+"&sessionid="+document.approvalForm.sessionid.value+"&boardid="+document.approvalForm.boardid.value+"&boardname="+document.approvalForm.boardname.value+"&amountradio="+document.approvalForm.amountradio.value+"&appFromdate="+document.approvalForm.appFromdate.value+"&appTodate="+document.approvalForm.appTodate.value+"&todaydate="+document.approvalForm.todaydate.value+"","Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
}	
function goBack()
{
	document.approvalForm.action="./AmountCollection_Pre.jsp";
	document.approvalForm.submit();
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>
<jsp:useBean id="date_object" scope="page" class="com.iGrandee.Common.DateTime"/>
<body bgcolor="#2B303E" topmargin="0" bottommargin="0">
<form name="approvalForm" action="" method="post">
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

    <h2><%=bundle.getString("label.reports.finanicialreportstandardwisereport")%></h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" colspan='2' width="100%"><%=bundle.getString("label.applicationreport.SelectedInformation")%> </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td colspan="2" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
	 try{
	 	String date_str = date_object.showTime("WithTime");	 
	 	com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
		String instituteid=(String)session.getValue("instituteid");
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String checkoption=request.getParameter("amountradio");

 		String fromdate=date_object.getMySQLFormat(request.getParameter("appFromdate")+"")+"";
		String todate=date_object.getMySQLFormat(request.getParameter("appTodate")+"")+"";
		String todaydate=date_object.getMySQLFormat(request.getParameter("todaydate")+"")+"";
		//String datewisedate=date_object.getMySQLFormat(request.getParameter("datewise")+"")+"";

		ArrayList feesCollectionList= null;
		String appCostCurrency=null;
		String regCostCurrency=null;
		String feeCostCurrency=null;
		
		String appTotCostCurrency=null;
		String regTotCostCurrency=null;
		String feeTotCostCurrency=null;

		java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
	    /*if(checkoption.equalsIgnoreCase("datewise"))
	    	feesCollectionList	=	(ArrayList)applicationQuery.getAllFeesReport(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid,datewisedate,datewisedate);
	    else*/  if(checkoption.equalsIgnoreCase("today"))
	    	feesCollectionList	=	(ArrayList)applicationQuery.getAllFeesReport(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid,todaydate,todaydate);
	    else
		    feesCollectionList	=	(ArrayList)applicationQuery.getAllFeesReport(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid,fromdate,todate);

       %>

			<br>

<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%"><%=bundle.getString("label.applicationreport.AcademicYear")%>  </td><td>:</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold><%=bundle.getString("label.applicationreport.Board")%> </td><td>:</td><td   class=tablelight><%=boardName %></td>
</tr>
	<% 
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
		 if(checkoption.equalsIgnoreCase("today"))
				out.print("<tr><td class=tablebold width='25%'> Today  </td><td>:</td><td class=tablelight >"+date_str.substring(0,11)+"</td></tr>");
			 else
			 {
				out.print("<tr><td class=tablebold width='25%' > From Date </td><td> :</td><td class=tablelight colspan=4>"+request.getParameter("appFromdate")+"</td></tr>");
				out.print("<tr><td class=tablebold width='25%'> To Date  </td><td>:</td><td class=tablelight  colspan=4>"+request.getParameter("appTodate")+"</td></tr>");
			 }
				out.print("<tr><td class=tablebold width='25%'>"+bundle.getString("label.applicationreport.ArchivalDetails")+"</td><td>:</td><td class=tablelight >"+bundle.getString("label.applicationreport.message")+"</td></tr>");
	}
	else{
		 if(checkoption.equalsIgnoreCase("today"))
			out.print("<tr><td class=tablebold width='25%'> Today  </td><td>:</td><td class=tablelight >"+date_str.substring(0,11)+"</td></tr>");
		 else
		 {
			out.print("<tr><td class=tablebold width='25%' > From Date </td><td> :</td><td class=tablelight colspan=4>"+request.getParameter("appFromdate")+"</td></tr>");
			out.print("<tr><td class=tablebold width='25%'> To Date  </td><td>:</td><td class=tablelight  colspan=4>"+request.getParameter("appTodate")+"</td></tr>");
		 }
		 
	}
	%>	


</table>
</td><td></td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"><%=bundle.getString("label.applicationreport.SL.No")%></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.applicationreport.StandardName")%></th>
            <th scope="col" class="rounded" width="23%"><%=bundle.getString("label.applicationissue.title")%></th>
            <th scope="col" class="rounded" width="23%"><%=bundle.getString("label.schedule.admission")%></th>
            <th scope="col" class="rounded-q4" width="23%"><%=bundle.getString("label.schedule.feescollection")%></th>                                   
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>

<% 
		if(feesCollectionList.size()!=0)
		{
			ArrayList standardList 	= new ArrayList();
			int count 				= 0;
			float applicationTotCost 	= 0f;
			float applicationCost	 	= 0f;
			float admissionTotCost 	= 0f;
			float admissionCost	 	= 0f;
			float feeCollectionTotCost= 0f;
			float feeCollectionCost	= 0f;			
			String appCost 			= "";
			String regCost 			= "";
			String feeCost 			= "";
			String standardName		= "";
			String groupName 		="";
			
			for(int i=0;i<feesCollectionList.size();i++)
			{

				HashMap map					=	(HashMap)feesCollectionList.get(i);
				standardName				=	(String)map.get("standardname");
				groupName					=	(String)map.get("groupname"); 
				appCost 					= 	(String)map.get("appCost");
				regCost						=	(String)map.get("regCost");
				feeCost 					=	(String)map.get("feeCost");
				
				if(!groupName.equals("NoGroup"))
				{												
					standardName = standardName+" - "+groupName; 
				}
			
				if(appCost==null)
					appCost = "0";
				if(regCost==null)
					regCost = "0";
				if(feeCost==null)
					feeCost = "0";				
				//applicationCount = Integer.parseInt(appCount);
				 //applicationTotCount +=applicationCount;

				//applicationCost = Integer.parseInt(appCost);
				applicationCost = Float.parseFloat(appCost);
				applicationTotCost +=applicationCost;
				
				admissionCost = Float.parseFloat(regCost);
				admissionTotCost +=admissionCost;

	
				feeCollectionCost = Float.parseFloat(feeCost);
				
				
				feeCollectionTotCost +=feeCollectionCost;
	
				 Double appCostObj = Double.valueOf(appCost);
				NumberFormat appCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				appCostCurrency 				= appCostObjFormat.format(appCostObj);

			    
			    Double regCostObj = Double.valueOf(regCost);
				NumberFormat regCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				regCostCurrency 				= appCostObjFormat.format(regCostObj);
				
				Double feeCostObj = Double.valueOf(feeCost);
				NumberFormat feeCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				feeCostCurrency 				= feeCostObjFormat.format(feeCostObj); 
				/* 	
			    Long feeCostObj 				= Long.valueOf(feeCost); 
				NumberFormat feeCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				feeCostCurrency 				= feeCostObjFormat.format(feeCostObj); */
				
				out.print("<tr><td>"+(i+1)+"</td><td>"+standardName+"</td><td>"+appCostCurrency+"</td><td>"+regCostCurrency+"</td><td>"+feeCostCurrency+"</td>");
	
			}
			//Long appTotCostObj 					= Long.valueOf(applicationTotCost); 
			Double appTotCostObj = Double.valueOf(applicationTotCost);
			NumberFormat appTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			appTotCostCurrency 					= appTotCostObjFormat.format(appTotCostObj);
			
		 	//Long regTotCostObj 					= Long.valueOf(admissionTotCost);
			Double regTotCostObj = Double.valueOf(admissionTotCost);
			NumberFormat regTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			regTotCostCurrency 					= appTotCostObjFormat.format(regTotCostObj);

			//Long feeTotCostObj 					= Long.valueOf(feeCollectionTotCost);
			Double feeTotCostObj = Double.valueOf(feeCollectionTotCost);
			NumberFormat feeTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			feeTotCostCurrency 					= feeTotCostObjFormat.format(feeTotCostObj);
			
			out.print("<tr><td colspan=5></td></tr><tr><td class=tablebold colspan=1></td><td class=tablebold>"+bundle.getString("label.applicationreport.Total")+"</td><td class=tablebold >"+appTotCostCurrency+"</td><td class=tablebold>"+regTotCostCurrency+"</td><td class=tablebold >"+feeTotCostCurrency+"</td></tr>");
		}
		else
		{			
			out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>"+bundle.getString("label.schedule.datanotfound")+"</font></td></tr>");	
		}
	%>
</table>

						
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.applicationreport.Back")%></strong><span class="bt_blue_r"></span></a>						
	<a href="#" class="bt_green" onclick="printfun()"><span class="bt_green_lft"></span><strong><%=bundle.getString("label.schedule.print")%></strong><span class="bt_green_r"></span></a>
		
<input type='hidden' name='appFromdate' value='<%=request.getParameter("appFromdate")+""%>'>
<input type='hidden' name='appTodate' value='<%=request.getParameter("appTodate")+""%>'>
<input type='hidden' name='todaydate' value='<%=request.getParameter("todaydate")+""%>'>
<input type='hidden' name='amountradio' value='<%=checkoption%>'>

<input type='hidden' name='sessionname' value='<%=yearofsession%>'>
<input type='hidden' name='boardname' value='<%=boardName%>'>
<input type='hidden' name='sessionid' value='<%=request.getParameter("req_sessionid")%>'>
<input type='hidden' name='boardid' value='<%=request.getParameter("req_boardid")%>'>
<%}catch(Exception e){e.printStackTrace();}%>
  
	<!-- <a href="#" class="bt_green" onclick="navAction()"><span class="bt_green_lft"></span><strong>Admit</strong><span class="bt_green_r"></span></a> 
	<a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong>Back</strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewStudent()"><span class="bt_blue_lft"></span><strong>View Students</strong><span class="bt_blue_r"></span></a>-->
     

     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</form>
</body>

</html>