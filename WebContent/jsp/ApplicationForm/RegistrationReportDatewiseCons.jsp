<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<% 	
	java.util.ResourceBundle bundle 	= 	java.util.ResourceBundle.getBundle("resources.ApplicationResources");
%>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=bundle.getString("label.product.name")%> - <%=bundle.getString("label.admisionreportviewdatewisecons.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />

<script type="text/javascript">

function goBack()
{
	document.approvalForm.action="RegistrationReportDatewise.jsp";
	document.approvalForm.submit();
}

function applicationView(obj)
{
	document.approvalForm.standardpublishid.value 	= obj.getAttribute("standardscheduleid");
	document.approvalForm.standardnamegp.value 		= obj.getAttribute("standardname");
	document.approvalForm.action="RegistrationReportDatewiseView.jsp";
	document.approvalForm.submit();
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>
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

    <h2>Enrollment / Student Enrollment / Admission / Datewise Report</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.admisionreport.SelectedInformation")%> </th>
            <th scope="col" class="rounded-q4" width="10"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>


	 <%
		//com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.Application.RegistrationProcess();
	 com.iGrandee.Application.ApplicationQuery  applicationQuery = new com.iGrandee.Application.ApplicationQuery();	
	 //com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
		
		String instituteid=(String)session.getValue("instituteid");
 		String stdscheduleid=request.getParameter("standardpublishid");
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String courseName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		ArrayList applicationCountList= null;
		
		String appCostCurrency=null;
		String appTotCostCurrency=null;
		
		java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
	    //Locale localcurrency = new Locale("en", "IN");


		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//pendingFeesList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesDetails(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid);
		applicationCountList	=	(ArrayList)applicationQuery.getReport(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid,request.getParameter("appFrom"),request.getParameter("appTo"),"Registration");
		
		ArrayList dateList		=	(ArrayList)applicationCountList.get(0);
		String fromDate			=	(String) dateList.get(4);
		String toDate			=	(String) dateList.get(5);
		//System.out.print("applicationCountList-->"+applicationCountList);
		//HashMap remAmountmap		= (HashMap)pendingFeesList.get(0);
       %>


<tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%"><%=bundle.getString("label.admisionview.AcademicYear")%></td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold><%=bundle.getString("label.admisionreport.Board")%> </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=boardName %></td>
</tr>
<tr>
	<td class=tablebold width="25%"><%=bundle.getString("label.admisionreport.FromDate")%></td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=fromDate%></td>
	<td class=tablebold><%=bundle.getString("label.admisionreport.ToDate")%></td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=toDate %></td>
</tr>
<% 
if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
	out.print("<tr><td class=tablebold width='25%'>Archival Details</td><td class=tablebold width='2%'>:</td><td class=tablelight >This is an Archived Year</td></tr>");
}
%>
</table>
</td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="1%"><%=bundle.getString("label.admisionreport.SL.No")%></th>
            <th scope="col" class="rounded" width="45%"><%=bundle.getString("label.admisionreport.StandardName")%></th>
            <th scope="col" class="rounded" width="30%"><%=bundle.getString("label.admisionreport.AmountCollected")%></th>
            <th scope="col" class="rounded-q4" width="24%"><%=bundle.getString("label.admisionreport.No.ofApplicants")%></th>                                   
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="3" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>

<% 
		ArrayList standardList = new ArrayList();
		int count = 0;
		int applicationTotCount = 0;
		int applicationTotCost = 0;
		
		int totPendingCount = 0;
		if(applicationCountList.size()!=0)
		{
			int applicationCount = 0;
			int applicationCost	 = 0;
			
			for(int i=0;i<applicationCountList.size();i++)
			{
				ArrayList mapList			=	(ArrayList)applicationCountList.get(i);
				
				//HashMap map					=	(HashMap)applicationCountList.get(i);
				String standardscheduleId	=	(String) mapList.get(0);				
				String standardName			=	(String) mapList.get(1);
				String appCost				=	(String) mapList.get(2);
				String appCount				=	(String) mapList.get(3);				
				
				if(appCost==null)
					appCost = "0";

				applicationCount = Integer.parseInt(appCount);
				 applicationTotCount +=applicationCount;

				applicationCost = Integer.parseInt(appCost);
				 applicationTotCost +=applicationCost;
				 
			    Long appCostObj 				= Long.valueOf(appCost); 
				NumberFormat appCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				appCostCurrency 				= appCostObjFormat.format(appCostObj);
				
				out.print("<tr><td>"+(i+1)+"</td><td>"+standardName+"</td><td>"+appCostCurrency+"</td>");
				if(applicationCount>0)
					out.print("<td style='background-color:lightblue' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' standardscheduleid='"+standardscheduleId+"' standardname='"+standardName+"' onclick='applicationView(this)'>"+appCount+"</a></td></tr>");
				else
					out.print("<td style='background-color:lightblue' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+appCount+"</td></tr>");
			    Long appTotCostObj 					= Long.valueOf(applicationTotCost); 
				NumberFormat appTotCostObjFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
				appTotCostCurrency 					= appTotCostObjFormat.format(appTotCostObj);
				
			   // Long termFeeObj 			= Long.valueOf(termfeesAmount); 
			   // NumberFormat termFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			   // formattedTermFeeCurrency 	= termFeeFormat.format(termFeeObj);
			}
			out.print("<tr><td colspan=4></td></tr><tr><td class=tablebold colspan=1></td><td class=tablebold colspan=1>"+bundle.getString("label.admisionreport.Total")+"</td><td colspan=1>"+appTotCostCurrency+"</td><td style='background-color:lightblue'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+applicationTotCount+"</td></tr>");
		}
		else
		{			
			out.println("<tr align='center' class='tablebold'><td colspan='4'><font color='red'>Data Not Found</font></td></tr>");	
		}
			
		//out.print("totPendingCount"+totPendingCount);
	%>
</table>
</table>
</td><td></td></tr>
</table>  
<br>
						</table></td><td></td></tr>

						</table>
						
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.admisionreport.Back")%></strong><span class="bt_blue_r"></span></a>						
	
		</td>
		</tr>
	</table>	

<input type='hidden' name='standardpublishid'>
<input type='hidden' name='req_termfeesid'>
<input type='hidden' name='req_termfeesname'>
<input type='hidden' name='req_termfeesamount'>
<input type='hidden' name='req_duedate'>
<input type='hidden' name='standardnamegp'>
<input type='hidden' name='req_sessionname' value='<%=yearofsession%>'>
<input type='hidden' name='req_boardname' value='<%=boardName%>'>
<input type='hidden' name='req_sessionid' value='<%=request.getParameter("req_sessionid")%>'>
<input type='hidden' name='req_sessionstatus' value='<%=request.getParameter("req_sessionstatus")%>'>
<input type='hidden' name='req_boardid' value='<%=request.getParameter("req_boardid")%>'>

<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>

<input type='hidden' name='appFormatFrom' value='<%=fromDate%>'>
<input type='hidden' name='appFormatTo' value='<%=toDate%>'>

<input type='hidden' name='appFrom' value='<%=request.getParameter("appFrom")%>'>
<input type='hidden' name='appTo' value='<%=request.getParameter("appTo")%>'>




  	</td>
 						</table></td><td></td></tr>

						</table>

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