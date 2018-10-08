<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Pending Fees View | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockp.js"></script>
<script type="text/javascript" src="<%=request.getContextPath()%>/jsp/kycpanel/clockh.js"></script>

<script type="text/javascript">

function goBack()
{
	document.approvalForm.action="FeesPendingSelect.jsp";
	document.approvalForm.submit();
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
<%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>
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

    <h2>Fees / Pending List / Pending List View</h2>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10"></th>
            <th scope="col" class="rounded" width="100%">Selected Information </th>
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
		String termfeesAmount=null;
		String feeStatus=null;
		
		String rollNo="";
		String sessionid=request.getParameter("req_sessionid");
 		String boardid=request.getParameter("req_boardid");
 		//out.println("boardid==>"+boardid);
 		String stdscheduleid=request.getParameter("standardpublishid");
 		//out.println("stdscheduleid==>"+stdscheduleid);
 		String yearofsession=request.getParameter("req_sessionname");
		String batchName=request.getParameter("req_boardname");
		String courseName=request.getParameter("standardnamegp");
		String secName=request.getParameter("req_sectionname");
		//String secSchedId=request.getParameter("req_sectionpubid");
		//out.println("secSchedId-->"+secSchedId+"secName-->"+secName);
		ArrayList pendingFeesList= null;

		//out.println("<script>alert('"+sessionid+"')</script>");
		//	out.println("<script>alert('"+batchid+"')</script>");
		//out.println("<script>alert('"+stdscheduleid+"')</script>");
		//registeredList	=	(ArrayList)registrationQuery.displayAllocatedDetails(secSchedId);
		pendingFeesList	=	(ArrayList)feesscheduleQuery.displayPendingFeesDetails(request.getParameter("req_sectionpubid"),request.getParameter("req_termfeesid"));
		//out.print("pendingFeesList-->"+pendingFeesList);
		//HashMap remAmountmap		= (HashMap)pendingFeesList.get(0);
       %>

			<br>

<tr><td><td><table border=0 align=center id="rounded-corner1" width="100%">
<tr>
	<td class=tablebold width="25%">Academic Year</td><td class=tablelight ><%=yearofsession %></td>
	<td class=tablebold>Board </td><td  colspan=2  class=tablelight><%=batchName %></td>
</tr>
<tr><td class=tablebold width="25%">Standard</td><td class=tablelight><%=courseName %></td>
<td class=tablebold width="25%">Section</td><td class=tablelight><%=secName%></td>
</tr>
<tr><td class=tablebold width="25%">Term</td><td class=tablelight><%=request.getParameter("req_termfeesname")%></td>
<td class=tablebold width="25%">Term Fees Amount</td><td class=tablelight><%=request.getParameter("req_termfeesamount") %></td>
</tr>
</table>
</td><td></td></tr>
</table>

<table border=1 cellpadding=5 cellspacing=0 align=center width="80%" rules=groups>
<% 
		out.print("<br>");
%>
<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="7%">Sl.No</th>
            <th scope="col" class="rounded" width="25%">Student Name</th>
            <th scope="col" class="rounded" width="15%">Application No.</th>
            <th scope="col" class="rounded" width="15%">Roll No.</th>
            <th scope="col" class="rounded" width="20%">Paid Amount</th>
            <th scope="col" class="rounded-q4" width="20%">Pending Amount</th>                       
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
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
			applicationNo			=	(String) map.get("applicationno");			
			rollNo					=	(String) map.get("rollno");
			candidateregisterId		=	(String) map.get("candidateregisterid");
			//dateofallocation 		=	(String) map.get("dateofallocation");
			feeStatus				=	(String) map.get("feestatus");
			RemAmount				=	(String) map.get("RemAmount");
			
			
			if(rollNo==null)
				rollNo = "-";

			if(RemAmount==null)
				RemAmount = termfeesAmount;
			if(feeStatus.equals("Pending")){
				count=count+1;	
			out.print("<tr><td>"+(count)+"</td><td>"+applicantName+"</td><td>"+applicationNo+"</td><td>"+rollNo+"</td><td>"+feesPaid+"</td><td>"+RemAmount+"</td></tr>");
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
//out.print("pendingFeesList.size()-->"+pendingFeesList.size());
 if(pendingFeesList.size()!=0)
      {
%>
	
		<a href="#" class="bt_blue" onclick="goBack()"><span class="bt_blue_lft"></span><strong>Back</strong><span class="bt_blue_r"></span></a>
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