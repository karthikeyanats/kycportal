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

<script type="text/javascript" src="<%=request.getContextPath()%>/js/Validation.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/js/Calendar/Calendar.js"></script>

<script type="text/javascript">

function goBack()
{
	document.approvalForm.action="RegistrationReport.jsp";
	document.approvalForm.submit();
}

function datewiseReport()
{
//alert("document.approvalForm.appFrom.value-->"+document.approvalForm.appFrom.value)
	if(document.approvalForm.appFrom.value == "")
	{
		alert("Select From date");
		document.approvalForm.appFrom.focus();
		return;
	}
	if(document.approvalForm.appTo.value == "")
	{
		alert("Select To date");
		document.approvalForm.appTo.focus();
		return;
	}
	document.approvalForm.action="RegistrationReportDatewiseCons.jsp";
	document.approvalForm.submit();
}

function todayReport()
{
//alert("document.approvalForm.appFrom.value-->"+document.approvalForm.appFrom.value)

	document.approvalForm.appFrom.value = document.approvalForm.server_date.value;
	document.approvalForm.appTo.value = document.approvalForm.server_date.value;
	document.approvalForm.action="RegistrationReportDatewiseCons.jsp";
	document.approvalForm.submit();
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale,com.iGrandee.Common.DateTime"%>
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

    <h2><%=bundle.getString("label.admisionreportview.rootpath")%></h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%"><%=bundle.getString("label.admisionreport.SelectedInformation")%></th>
            <th scope="col" class="rounded-q4" width="10%"></th>        
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
	  DateTime	datetime				= new DateTime();
	  String datestr					= datetime.showTime("calendar");
	  
		String applicantName=null;
		String applicationNo=null;
		String studentallocationId="";
		//String dateofallocation=null;
		String studentapprovalId="";
		String candidateregisterId=null;
		
		String feesPaid=null;
		String RemAmount=null;
		String feeStatus=null;
		
		String rollNo="";
		String instituteid=(String)session.getValue("instituteid");
		//String sessionid=request.getParameter("req_sessionid");
 		//String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("standardpublishid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String courseName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		//String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList applicationCountList= null;
		ArrayList pendingCountList= null;
		String formattedTermFeeCurrency=null;
		String appCostCurrency=null;
		String appTotCostCurrency=null;
		
		java.util.ResourceBundle serBundle 	= 	java.util.ResourceBundle.getBundle("resources.serversetup");
	    Locale localcurrency = new Locale(serBundle.getString("language"), serBundle.getString("code"));
	    //Locale localcurrency = new Locale("en", "IN");


		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//pendingFeesList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesDetails(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid);
		applicationCountList	=	(ArrayList)applicationQuery.getReport(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid,"Application");
		
		//System.out.print("applicationCountList-->"+applicationCountList);
		//HashMap remAmountmap		= (HashMap)pendingFeesList.get(0);
       %>

	

<tr><td colspan=2> <table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%"><%=bundle.getString("label.admisionview.AcademicYear")%></td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold><%=bundle.getString("label.admisionreport.Board")%> </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=boardName %></td>
</tr>

	<% 
	out.print("<tr><td class=tablebold width='25%'>"+bundle.getString("label.admisionreport.FromDate")+"</td><td class=tablebold width='2%'>:</td><td><input type='text' name='appFrom' validate='Start Date' size='11' value='' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','approvalForm.appFrom','0',event,'Not_Greater_Than_CurrentDate',approvalForm.server_date)></td>");
	out.print("<td class=tablebold>"+bundle.getString("label.admisionreport.ToDate")+"</td><td class=tablebold width='2%'>:</td><td><input type='text' name='appTo' size='11' value='' validate='End Date' onfocus='this.blur()'><input type='button' value='^' onclick=Calendar_Fun('"+request.getContextPath()+"/js/Calendar/CalendarWindow.html','approvalForm.appTo','0',event,'Not_Less_Than_StartDate',approvalForm.appFrom)></td></tr>");
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R")){
		out.print("<tr><td class=tablebold width='25%'>Archival Details</td><td class=tablebold width='2%'>:</td><td class=tablelight >This is an Archived Year</td></tr>");
	}
	%>
	
	

</table>
</td></tr>
</table>
	<a href="#" class="bt_red" onclick="goBack()"><span class="bt_red_lft"></span><strong><%=bundle.getString("button.admisionreport.Back")%></strong><span class="bt_red_r"></span></a>						
	<a href="#" class="bt_blue" onclick="todayReport()"><span class="bt_blue_lft"></span><strong><%=bundle.getString("button.admisionreport.TodayReport")%></strong><span class="bt_blue_r"></span></a>
	<a href="#" class="bt_green" onclick="datewiseReport()"><span class="bt_green_lft"></span><strong><%=bundle.getString("button.admisionreport.Search")%></strong><span class="bt_green_r"></span></a>
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
<input type='hidden' name='studentallocationid' value='<%=studentallocationId%>'>
<input type=hidden name='server_date' value='<%=datestr%>'>






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