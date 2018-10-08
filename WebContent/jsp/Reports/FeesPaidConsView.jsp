<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feespaidlist.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/kyccss.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

function goBack()
{
	//document.approvalForm.action="FeesPendingCons.jsp";
	document.approvalForm.action="PendingList_pre.jsp";
	document.approvalForm.submit();
}

	function printfun()
	{
	window.open("PrintPreview FeesPaidList_standard.jsp?req_sessionname="+document.approvalForm.req_sessionname.value+"&req_sessionid="+document.approvalForm.req_sessionid.value+"&req_boardid="+document.approvalForm.req_boardid.value+"&req_boardname="+document.approvalForm.req_boardname.value+"&standardpublishid="+document.approvalForm.standardpublishid.value+"&req_sessionstatus="+document.approvalForm.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
	}
	
function pendingView(obj)
{

	document.approvalForm.standardpublishid.value 	= obj.getAttribute("standardscheduleid");
	document.approvalForm.standardnamegp.value 		= obj.getAttribute("standardname");
	document.approvalForm.req_termfeesid.value 		= obj.getAttribute("termfeesid");
	document.approvalForm.req_termfeesname.value 	= obj.getAttribute("termname");
	document.approvalForm.req_termfeesamount.value 	= obj.getAttribute("termfeesamount");
	document.approvalForm.req_duedate.value 		= obj.getAttribute("duedate");
	
	document.approvalForm.action="FeesPaidDetailView.jsp";
	document.approvalForm.submit();
}

</script>
</head>
 <tbody>
 </tbody>
<%@ page import="java.util.ResourceBundle,java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess,java.text.NumberFormat,java.util.Locale"%>
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

    <h2><%=bundle1.getString("label.feespaidlist.rootpathforreport")%> </h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%"  ><%=bundle1.getString("label.feespaidlist.SelectedInformation")%> </th>
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
	 	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
		
		String applicantName=null;
		String applicationNo=null;
		String studentallocationId="";
		//String dateofallocation=null;
		String studentapprovalId="";
		String candidateregisterId=null;
		
		String feesPaid=null;
		String RemAmount=null;
		String feeStatus=null;
		ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
		Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
		String rollNo="";
		String instituteid=(String)session.getValue("instituteid");
		String sessionid=request.getParameter("req_sessionid");
 		String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("standardpublishid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String courseName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		//String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList pendingFeesList= null;
		ArrayList pendingCountList= null;
		String formattedTermFeeCurrency=null;
	    //Locale localcurrency = new Locale("en", "IN");
		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(secSchedId); 
		//pendingFeesList	=	(ArrayList)feesscheduleQuery.displayPendingFeesDetails(request.getParameter("req_sectionpubid"),request.getParameter("req_termfeesid"));
			pendingFeesList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesDetails(request.getParameter("req_sessionid"),request.getParameter("req_boardid"),instituteid);
		//System.out.print("pendingFeesList-->"+pendingFeesList);
		//HashMap remAmountmap		= (HashMap)pendingFeesList.get(0);
       %>

			<br>
<tbody>

<tr><td colspan=2><table border=0 >
<tr>
	<td class=tablebold width="25%"><%=bundle1.getString("label.feespaidlist.AcademicYear")%></td>
	<td class=tablebold >:</td>
	<td class=tablelight ><%=yearofsession %></td>
	
	<td class=tablebold><%=bundle1.getString("label.feespaidlist.Board")%> </td>
	<td class=tablebold >:</td>
	<td class=tablelight><%=boardName %></td>
</tr>
<%
	if(request.getParameter("req_sessionstatus") != null && request.getParameter("req_sessionstatus").equals("R"))
	{
	%>
	
	<tr class='tablebold' width='20%' height='23'>
			<td  class='tablebold'  valign=top align=left><%=bundle1.getString("label.feesreport.ArchivalDetails")%> &nbsp;</td>
			
			<td colspan=3  valign=top class='tablelight' align=left><h2><%=bundle1.getString("label.feesreport.ThisisanArchivedYear")%></h2></td>
	</tr>
	<%  
	} 
	%>		
<!--  
<tr><td class=tablebold width="25%">Standard</td><td class=tablelight><%=courseName %></td>
<td class=tablebold width="25%">Section</td><td class=tablelight><%=secName%></td>
</tr>
<tr><td class=tablebold width="25%">Term</td><td class=tablelight><%=request.getParameter("req_termfeesname")%></td>
<td class=tablebold width="25%">Term Fees Amount</td><td class=tablelight><%=request.getParameter("req_termfeesamount") %></td>
</tr>
-->
</table>
</td></tr>

</tbody>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="5%"><%=bundle1.getString("label.feespaidlist.SL.No")%></th>
            <th scope="col" class="rounded" width="30%"><%=bundle1.getString("label.feespaidlist.TermName")%></th>
            <th scope="col" class="rounded" width="25%"><%=bundle1.getString("label.feespaidlist.TermFees")%></th>
            <th scope="col" class="rounded" width="20%"><%=bundle1.getString("label.feespaidlist.DueDate")%></th>
            <th scope="col" class="rounded-q4" width="20%"><%=bundle1.getString("label.feespaidlist.No.ofStudentsPaid")%></th>                                   
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="4" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>

<% 
		ArrayList standardList = new ArrayList();
		int count = 0;
		int totPendingCount = 0;
		if(pendingFeesList.size()!=0)
		{

			for(int i=0;i<pendingFeesList.size();i++)
			{
				HashMap map					=	(HashMap)pendingFeesList.get(i);
				String standardName			=	(String) map.get("standardname");
				String standardscheduleId	=	(String) map.get("standardscheduleid");				
				String groupName			=	(String) map.get("groupname");
				String termfeesId			=	(String) map.get("termfeesid");				
				String termfeesAmount		=	(String) map.get("termfeesamount");
				String termName				=	(String) map.get("termname");
				String dueDate				=	(String) map.get("duedate");
				
				
			    Long termFeeObj 			= Long.valueOf(termfeesAmount); 
			    NumberFormat termFeeFormat 	= NumberFormat.getCurrencyInstance(localcurrency);
			    formattedTermFeeCurrency 	= termFeeFormat.format(termFeeObj);
			    
				if(groupName!=null)
					standardName = standardName+" - "+groupName;
				if(!standardList.contains(standardName))
				{
					count=0;
%>
<tr><td  colspan=5>
<table class=tableheading border=0 cellpadding=0 cellspacing=0 align=center width="100%" rules=groups>
<br>
<tr><td colspan=5>
<font size='2'><b><%=bundle1.getString("label.feespaidlist.Standard")%> :</b></font><%=standardName%>
</td></tr>
</table>
</td></tr>
    
	<%
	 
	boolean flag = false;
			}
					
				pendingCountList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesPending(standardscheduleId,termfeesId);
				int pendingCount = 0;
				
				if(pendingFeesList.size()!=0)
				{
					//pendingCount = 0;
				for(int j=0;j<pendingCountList.size();j++)
				{
					HashMap pendingMap			= (HashMap)pendingCountList.get(j);
					String pendingStatus		= (String)pendingMap.get("pendingstatus");
					//System.out.println("pendingMap-->"+pendingMap+"pendingStatus-->"+pendingStatus);
					if( pendingStatus.equals("0"))
					{
						pendingCount = pendingCount+1;
					}
					
				}
				//System.out.println("pendingCount-->"+pendingCount);
				
				}
				count = count+1;
				totPendingCount = totPendingCount + pendingCount;
				out.print("<tr><td>"+(count)+"</td><td>"+termName+"</td><td>"+formattedTermFeeCurrency+"</td><td>"+dueDate+"</td>");
				if(pendingCount>0)
					out.print("<td style='background-color:#B0FFB0' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' standardscheduleid='"+standardscheduleId+"' standardname='"+standardName+"' termfeesid='"+termfeesId+"' termname='"+termName+"' termfeesamount='"+termfeesAmount+"' duedate='"+dueDate+"'  onclick='pendingView(this)'>"+pendingCount+"</a></td></tr>");
				else
					out.print("<td style='background-color:lightblue' >&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+pendingCount+"</td></tr>");
				standardList.add(standardName);	
			}
			}
			else
			{
				//out.println("<tr><td colspan=5 align=center><font color=red><b>Data not found</b></font></td></tr>");
    	 		out.println("<tr align='center' class='tablebold'><td colspan='5'><font color='red'>Data Not Found</font></td></tr>");

	
			}		
			//out.print("<tr><td colspan=5></td></tr><tr><td colspan=2></td><td class=tablebold align=right colspan=2>Total No. of Paid</td><td style='background-color:lightblue'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+totPendingCount+"</td></tr>");
		//out.print("totPendingCount"+totPendingCount);
	%>
</table>
</table>
</td><td></td></tr>
</table>  
<br>
						</table></td><td></td></tr>

						</table>
<%
 if(pendingFeesList.size()!=0)
      {
%>
	
		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.feespaidlist.Back")%></strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle1.getString("button.feespaidlist.Print")%></strong><span class="bt_green_r"></span></a>
		
		<%
		
			//if(flag == true){
		%>
		    <!--  <input type="button" name=aapp value="Approve" class="buttons" onclick="approvefun()">	    
		    <a href="#" class="bt_green" onclick="allocatefun()"><span class="bt_green_lft"></span><strong>Allocate</strong><span class="bt_green_r"></span></a>-->	
		   <%
			//}
		   %>
			
		

<%
}
 else
	{
	%>
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.feespaidlist.Back")%></strong><span class="bt_blue_r"></span></a>

	<%
	}
	%>
	

<input type='hidden' name='standardpublishid'>
<input type='hidden' name='req_termfeesid'>
<input type='hidden' name='req_termfeesname'>
<input type='hidden' name='req_termfeesamount'>
<input type='hidden' name='req_duedate'>
<input type='hidden' name='standardnamegp'>
<input type='hidden' name='req_sessionname' value='<%=yearofsession%>'>
<input type='hidden' name='req_boardname' value='<%=boardName%>'>
<input type='hidden' name='req_sessionid' value='<%=sessionid%>'>
<input type='hidden' name='req_boardid' value='<%=boardid%>'>
<input type=hidden name=req_sessionstatus value=<%=request.getParameter("req_sessionstatus") %>>

<input type='hidden' name='stdscheduleid' value='<%=stdscheduleid%>'>
<input type='hidden' name='studentallocationid' value='<%=studentallocationId%>'>







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