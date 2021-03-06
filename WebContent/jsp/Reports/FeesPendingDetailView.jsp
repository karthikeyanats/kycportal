<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page language="java" import="java.util.ResourceBundle"%>
<%
ResourceBundle bundle1  =ResourceBundle.getBundle("resources.ApplicationResources");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - <%=bundle1.getString("label.feespendingdetails.title")%> | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

function goBack()
{
	document.approvalForm.action="FeesPendingConsView.jsp";
	document.approvalForm.submit();
}

function printfun()
	{
	window.open("PrintPreview FeesPendList_Student.jsp?&req_sessionname="+document.approvalForm.req_sessionname.value+"&req_sessionid="+document.approvalForm.req_sessionid.value+"&req_boardid="+document.approvalForm.req_boardid.value+"&req_boardname="+document.approvalForm.req_boardname.value+"&standardpublishid="+document.approvalForm.standardpublishid.value+"&req_termfeesid="+document.approvalForm.req_termfeesid.value+"&req_termfeesamount="+document.approvalForm.req_termfeesamount.value+"&standardnamegp="+document.approvalForm.standardnamegp.value+"&req_termfeesname="+document.approvalForm.req_termfeesname.value+"&req_duedate="+document.approvalForm.req_duedate.value+"&req_sessionstatus="+document.approvalForm.req_sessionstatus.value,"Msg","top=250,left=350,help:no,center:no,status:no,width=650,height=650,scrollbars=1;")
	}

function viewProfile(id)
{
	document.approvalForm.id.value=id
	document.approvalForm.action="ProfileView.jsp";
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

    <h2><%=bundle1.getString("label.feespendingdetails.rootpathforreport")%></h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="100%" colspan='2'><%=bundle1.getString("label.feespendingdetails.SelectedInformation")%> </th>
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
		//com.iGrandee.Application.RegistrationProcess  registrationQuery = new com.iGrandee.ApplicatioFeesPendingDetailViewn.RegistrationProcess();
	 	com.iGrandee.Fees.FeesSchedule  feesscheduleQuery = new com.iGrandee.Fees.FeesSchedule();
		
		String applicantName=null;
		//String applicationNo=null;
		String studentallocationId="";
		//String dateofallocation=null;
		String studentapprovalId="";
		String candidateregisterId=null;
		
		String feesPaid=null;
		String RemAmount=null;
		String scholarshipamount=null;
		
		String sectionName=null;
		String termfeesAmount=null;
		String feeStatus=null;
		
		String rollNo="";
		int rollNoNote = 0;
		//String sessionid=request.getParameter("req_sessionid");
 		//String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		//String stdscheduleid=request.getParameter("standardpublishid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String boardName=request.getParameter("req_boardname");
		String stdName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		String standardpublishid=request.getParameter("standardpublishid");
		String req_termfeesid=request.getParameter("req_termfeesid");
		String req_termfeesamount=request.getParameter("req_termfeesamount");
		//String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList pendingFeesList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(secSchedId);
		//pendingFeesList	=	(ArrayList)feesscheduleQuery.displayPendingFeesDetails(request.getParameter("req_sectionpubid"),request.getParameter("req_termfeesid"));
		pendingFeesList	=	(ArrayList)feesscheduleQuery.displayConsolidateFeesPendingnew(request.getParameter("standardpublishid"),request.getParameter("req_termfeesid"));
		String totTermFee=request.getParameter("req_termfeesamount");
	  //   Locale localcurrency = new Locale("en", "IN");
	       ResourceBundle bundle 	= 	ResourceBundle.getBundle("resources.serversetup");
     Locale localcurrency = new Locale(bundle.getString("language"), bundle.getString("code"));
	     String formattedTotTermFeeCurrency = null;
	     String formattedFeesPaidCurrency = null;
	     String formattedRemAmountCurrency = null;	     
	     String formattedscholarshipamountCurrency = null;
	    Long totTermFeeObj = Long.valueOf(totTermFee);
	    NumberFormat totFeeFormat = NumberFormat.getCurrencyInstance(localcurrency);
	    formattedTotTermFeeCurrency = totFeeFormat.format(totTermFeeObj);

		//out.print("pendingFeesList-->"+pendingFeesList);
		//HashMap remAmountmap		= (HashMap)pendingFeesList.get(0);
       %>

			<br>

<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%"><%=bundle1.getString("label.feespendingdetails.AcademicYear")%></td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold><%=bundle1.getString("label.feespendingdetails.Board")%> </td><td  colspan=2  class=tablelight><%=boardName %></td>
</tr>
<tr><td class=tablebold width="25%"><%=bundle1.getString("label.feespendingdetails.Standard")%></td><td class=tablelight><%=request.getParameter("standardnamegp") %></td>
<td class=tablebold width="25%"><%=bundle1.getString("label.feespendingdetails.Term")%></td><td class=tablelight><%=request.getParameter("req_termfeesname")%></td>
</tr>
<tr><td class=tablebold width="25%"><%=bundle1.getString("label.feespendingdetails.DueDate")%></td><td class=tablelight><%=request.getParameter("req_duedate")%></td>
<td class=tablebold width="25%"><%=bundle1.getString("label.feespendingdetails.TermFeesAmount")%></td><td class=tablelight><%=formattedTotTermFeeCurrency %></td>
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
</table>
</td><td></td></tr>
</table>

<table border=0 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
<% 
		out.print("<br>");
%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%"><%=bundle1.getString("label.feespendingdetails.SL.No")%></th>
            <th scope="col" class="rounded" width="35%"><%=bundle1.getString("label.feespendingdetails.StudentName")%></th>
            <th scope="col" class="rounded" width="15%"><%=bundle1.getString("label.feespendingdetails.Section")%></th>
            <!--  <th scope="col" class="rounded" width="15%">Application No.</th>-->
            <th scope="col" class="rounded" width="10%"><%=bundle1.getString("label.feespendingdetails.RollNo")%>.</th>
            <th scope="col" class="rounded" width="12%">Scholoarship</th>
            <th scope="col" class="rounded" width="12%"><%=bundle1.getString("label.feespendingdetails.PaidAmount")%></th>
            
            <th scope="col" class="rounded-q4" width="15%"><%=bundle1.getString("label.feespendingdetails.PendingAmount")%></th>                       
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="6" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
	<%
	 int count=0;
	boolean flag = false;
	//out.print("pendingFeesList-->"+pendingFeesList.size());
	if(pendingFeesList.size()!=0)
	{
		for(int i=0;i<pendingFeesList.size();i++)
		{
			
			HashMap map				=	(HashMap)pendingFeesList.get(i);
			studentapprovalId		=	(String) map.get("studentapprovalid");
			feesPaid				=	(String) map.get("FeesPaid");
			termfeesAmount			=	(String) map.get("termfeesamount");
			applicantName			=	(String) map.get("applicantname");
			studentallocationId		=	(String) map.get("studentallocationid"); 
			//applicationNo			=	(String) map.get("applicationno");			
			rollNo					=	(String) map.get("rollno");
			candidateregisterId		=	(String) map.get("candidateregisterid");
			//dateofallocation 		=	(String) map.get("dateofallocation");
			feeStatus				=	(String) map.get("feestatus");
			RemAmount				=	(String) map.get("RemAmount");
			sectionName				=	(String) map.get("sectionname");
			scholarshipamount				=	(String) map.get("scholarship");
			
			
			
			if(rollNo==null){
				rollNo = "<font color=red><i>-NYG-</i></font>";
				rollNoNote = rollNoNote+1;
			}

			if(RemAmount==null)
				RemAmount = termfeesAmount;
			if(scholarshipamount==null)
				scholarshipamount = "0";
			
			Double feesPaidObj = Double.valueOf(feesPaid); 
		    NumberFormat paidFormat = NumberFormat.getCurrencyInstance(localcurrency);
		    formattedFeesPaidCurrency = paidFormat.format(feesPaidObj);
		    
		    Double scholarshipamountObj = Double.valueOf(scholarshipamount); 
		    NumberFormat paidFormatn = NumberFormat.getCurrencyInstance(localcurrency);
		    formattedscholarshipamountCurrency = paidFormat.format(scholarshipamountObj);
		    
		    

		    Double remAmountObj = Double.valueOf(RemAmount);
		    NumberFormat pendingFormat = NumberFormat.getCurrencyInstance(localcurrency);
		    formattedRemAmountCurrency = pendingFormat.format(remAmountObj);

			
			
			
			if(feeStatus.equals("Pending")){
				count=count+1;	
			//out.print("<tr><td>"+(count)+"</td><td>"+applicantName+"</td><td>"+sectionName+"</td><td>"+applicationNo+"</td><td>"+rollNo+"</td><td>"+formattedFeesPaidCurrency+"</td><td>"+formattedRemAmountCurrency+"</td></tr>");
				out.print("<tr><td>"+(count)+"</td><td>"+applicantName+"</td><td>"+sectionName+"</td><td>"+rollNo+"</td><td>"+formattedscholarshipamountCurrency+"</td><td>"+formattedFeesPaidCurrency+"</td><td>"+formattedRemAmountCurrency+"</td></tr>");
			}
		}
	}
	else
	  {
		  out.println("<tr align='center' class='tablebold'><td colspan='6'><font color='red'>Data Not Found</font></td></tr>");
	  }


	%>
</table>
</table>
</td><td></td></tr>
</table>  
<br>
						</table></td><td></td></tr>

						</table>
		<% 
		if(rollNoNote>0)
		{
		%>
		<br>
		<tr>
		<td valign=top colspan=2>
			<b>Note: </b></td><td>&nbsp;</td><td>NYG - Not Yet Generated</td>
		</tr>  
		<br>
		<%}%>						
<%
//out.print("pendingFeesList.size()-->"+pendingFeesList.size());
 if(pendingFeesList.size()!=0)
      {
%>
	
		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong><%=bundle1.getString("button.feespendingdetails.Back")%></strong><span class="bt_blue_r"></span></a>
		<a href="#" class="bt_green" onclick='printfun()'><span class="bt_green_lft"></span><strong><%=bundle1.getString("button.feespendingdetails.Print")%></strong><span class="bt_green_r"></span></a>
		<%
		
			//if(flag == true){
		%>
		    <!--  <input type="button" name=aapp value="Approve" class="buttons" onclick="approvefun()">	    
		    <a href="#" class="bt_green" onclick="allocatefun()"><span class="bt_green_lft"></span><strong>Allocate</strong><span class="bt_green_r"></span></a>-->	
		   <%
			//}
		   %>
			
		</td>
		</tr>
	</table>

<%
}
 else
	{
	%>
	<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>

	<%
	}
	%>

<input type='hidden' name='studentallocationid' value='<%=studentallocationId%>'>
<input type='hidden' name='standardpublishid' value='<%=standardpublishid%>'>
<input type='hidden' name='req_sessionname' value='<%=yearofsession%>'>
<input type='hidden' name='req_boardname' value='<%=boardName%>'>
<input type='hidden' name='req_sessionid' value='<%=request.getParameter("req_sessionid")%>'>
<input type='hidden' name='req_boardid' value='<%=request.getParameter("req_boardid")%>'>
<input type='hidden' name='req_termfeesid' value='<%=request.getParameter("req_termfeesid")%>'>
<input type='hidden' name='req_termfeesamount' value='<%=request.getParameter("req_termfeesamount")%>'>
<input type='hidden' name='req_termfeesname' value='<%=request.getParameter("req_termfeesname")%>'>
<input type='hidden' name='standardnamegp' value='<%=request.getParameter("standardnamegp")%>'>
<input type='hidden' name='req_duedate' value='<%=request.getParameter("req_duedate")%>'>
<input type=hidden name=req_sessionstatus value=<%=request.getParameter("req_sessionstatus") %>>





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