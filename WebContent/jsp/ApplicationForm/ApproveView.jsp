<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Know Your Child - Approved List | Powered by i-Grandee</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/jsp/kycpanel/style.css" />

<script type="text/javascript">

function editApplicant(obj)
{
	document.applicationForm.registrationid_hidden.value=obj.getAttribute("registrationid");
	document.applicationForm.applicantname_hidden.value=obj.getAttribute("applicantname");
	document.applicationForm.applicationno_hidden.value=obj.getAttribute("applicationno");
	document.applicationForm.regamount_hidden.value=obj.getAttribute("regamount");
	//document.applicationForm.contactno_hidden.value=obj.getAttribute("contactno");
	document.applicationForm.receiptno_hidden.value=obj.getAttribute("receiptno");
	document.applicationForm.standardpubid_hidden.value=obj.getAttribute("standardpubid");
	document.applicationForm.action="RegistrationUpdate.jsp";
	document.applicationForm.submit();
}

function statusChangeFun(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant ...?"))
		{
			document.applicationForm.applicantname_hidden.value=obj.getAttribute("applicantname");
			document.applicationForm.applicationno_hidden.value=obj.getAttribute("applicationno");		
			document.applicationForm.studentapprovalid_hidden.value = obj.getAttribute("studentapprovalid");
			document.applicationForm.dateofapproval_hidden.value = obj.getAttribute("dateofapproval");
			document.applicationForm.profilestatus_hidden.value = obj.getAttribute("profilestatus");
			document.applicationForm.statuschange.value = obj.getAttribute("status");
			document.applicationForm.statusval.value = obj.getAttribute("statusval");
			//alert(document.applicationForm.applicantname_hidden.value)
			document.applicationForm.action= "ApprovalTrashPreview.jsp";
			document.applicationForm.submit();
		}
}

function statusChangeFun1(obj)
{
		if(confirm("Do you want to "+obj.getAttribute("statusval")+" the Applicant ...?"))
		{
			document.applicationForm.studentapprovalid_hidden.value = obj.getAttribute("studentapprovalid");
			document.applicationForm.statuschange.value = obj.getAttribute("status");
			//alert(document.applicationForm.statuschange.value)
			document.applicationForm.action= "approvalStatusSubmit.jsp";
			document.applicationForm.submit();
		}
}

function addnew_fun()
{
	document.applicationForm.req_sessionstatus.value = null;	
	document.applicationForm.action= "StudentApproval.jsp";
	document.applicationForm.submit();
}

function viewDeactive()
{
	document.applicationForm.action= "ApproveDeactivatedView.jsp";
	document.applicationForm.submit();
}

function viewTrash()
{
	document.applicationForm.action= "ApproveTrashView.jsp";
	document.applicationForm.submit();
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

    <h2>Enrollment / Student Enrollment / Approval / Approved Students</h2>

<form name="applicationForm" action="" method="post">

<input type=hidden name=studentapprovalid_hidden>
<input type=hidden name=standardpubid_hidden>
<input type=hidden name=applicantname_hidden>
<input type=hidden name=applicationno_hidden>
<input type=hidden name=dateofapproval_hidden>
<input type=hidden name=profilestatus_hidden>


<table id="rounded-corner" border=0 summary="Department List" width="100%">
    <thead>
    	<tr>
            <th scope="col" class="rounded-company" width="90%">Selected Information </th>
            <th scope="col" class="rounded-q4" width="10%"></th>        
        </tr>
    </thead>
    
        <tfoot>
    	<tr>
        	<td class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
    
    <tr><td colspan=2><table border=0 align=center id="rounded-corner1" width="100%">
	<tr>
		<td class=tablebold width="25%"> Academic Year</td><td class=tablebold width='2%'>:</td><td class=tablelight ><%=request.getParameter("req_sessionname") %></td>
		<td class=tablebold>Board </td><td class=tablebold width='2%'>:</td><td  colspan=2  class=tablelight><%=request.getParameter("req_boardname") %></td>
	</tr>
	<tr><td class=tablebold width="25%">Standard</td><td class=tablebold width='2%'>:</td><td class=tablelight colspan=3><%=request.getParameter("standardnamegp") %></td>

</tr>
</table>
</td></tr>
</table>
<br>
<table id="rounded-corner" border=0 summary="Department List" width="100%" align="center">
   <thead>
    	<tr>
        	<th scope="col" class="rounded-company" width="10%">Sl.No</th>
            <th scope="col" class="rounded" width="35%">Applicant Name</th>
            <th scope="col" class="rounded" width="25%">Application No</th>
            <th scope="col" class="rounded" width="25%">Date of Approval</th>
            <!--  <th scope="col" class="rounded" width="10%">Edit</th>-->
            <th scope="col" class="rounded" width="10%">Action</th>
            <th scope="col" class="rounded-q4" width="10%">Trash</th>
                      
        </tr>
    </thead>
    <tfoot>
    	<tr>
        	<td colspan="5" class="rounded-foot-left"><em></em></td>
        	<td class="rounded-foot-right">&nbsp;</td>
       </tr>
    </tfoot>
     <tbody>
     <%@ page import="java.util.ArrayList,java.util.HashMap,com.iGrandee.Application.RegistrationProcess"%>

     <%
     com.iGrandee.Application.RegistrationProcess  applicationQuery = new com.iGrandee.Application.RegistrationProcess();
     String instituteid = null;
     ArrayList applicantList = null;
     try
     {
    	  instituteid = (String)session.getValue("instituteid");
    	  //applicantList = applicationQuery.loadApplicantList(sessionid,boardid,standardpublishid);
    	    
    	  applicantList = applicationQuery.loadApprovedList(request.getParameter("standardpublishid"),"A");
   	
    	 if(applicantList!=null && applicantList.size()>0)
			{
    		 for (int i = 0, j = 1; i < applicantList.size(); i++) {
			
				HashMap applicantListMap=(HashMap)applicantList.get(i);
				String studentapprovalId  = (String)applicantListMap.get("studentapprovalid");
				String applicantName      = (String)applicantListMap.get("applicantname");
				String applicationNo      = (String)applicantListMap.get("applicationno");
				String dateofapproval     = (String)applicantListMap.get("dateofapproval");
				String profilestatus     = (String)applicantListMap.get("profilestatus");
				
				%>
				
				<tr>
        	 <td><%=j++%></td>
            <td><%=applicantName%></td>
            <td><%=applicationNo%></td>
            <td><%=dateofapproval%> </td> 
            <!--  <td><a href="#"  studentapprovalid="<%=studentapprovalId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" standardpubid="<%=request.getParameter("standardpublishid")%>" onclick="editApplicant(this)"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/user_edit.png" alt="" title="" border="0" /></a></td>-->
            <% 
            if(request.getParameter("req_sessionstatus")=="A" || request.getParameter("req_sessionstatus").equals("A"))
            {
            %>            
            <td><a href="#"   profilestatus="<%=profilestatus%>" studentapprovalid="<%=studentapprovalId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" dateofapproval="<%=dateofapproval %>" statusval="DeActivate" status="D" onclick="statusChangeFun(this)" class="ask">Deactivate</a></td>
            <td><a href="#"   profilestatus="<%=profilestatus%>" studentapprovalid="<%=studentapprovalId%>" applicantname="<%=applicantName %>" applicationno="<%=applicationNo %>" dateofapproval="<%=dateofapproval %>" statusval="Trash" status="T" onclick="statusChangeFun(this)" class="ask"><img src="<%=request.getContextPath()%>/jsp/kycpanel/images/trash.png" alt="" title="" border="0" /></a></td>
            <%
            } 
            else
            {
            %>
            <td>-</td>
            <td>-</td>
            <% 
            }
			%>        
        
        </tr>
				<%
    		 }
			}
    	 	else{
    	 		out.println("<tr align='center' class='tablebold'><td colspan='7'><font color='red'>Data Not Found</font></td></tr>");
     			//out.println("<tr><td colspan=7>Data not found</td></tr>");    	 
    	 	}
     }catch(Exception e){}
          
     %>
    	
    </tbody>
</table>



	<a href="#" class="bt_green" onclick="addnew_fun()"><span class="bt_green_lft"></span><strong>Add new item</strong><span class="bt_green_r"></span></a>
    <a href="#" class="bt_red" onclick="viewDeactive()"><span class="bt_red_lft"></span><strong>View Deactive Applicants </strong><span class="bt_red_r"></span></a>
    <a href="#" class="bt_blue" onclick="viewTrash()"><span class="bt_blue_lft"></span><strong>Trashed Applicants</strong><span class="bt_blue_r"></span></a>

	<input type=hidden name="req_sessionname" value = "<%=request.getParameter("req_sessionname")%>">
	<input type=hidden name="req_sessionid" value = "<%=request.getParameter("req_sessionid")%>">
	<input type=hidden name="req_boardname" value = "<%=request.getParameter("req_boardname")%>">
	<input type=hidden name="req_boardid" value = "<%=request.getParameter("req_boardid")%>">
	<input type=hidden name="standardnamegp" value = "<%=request.getParameter("standardnamegp")%>">
	<input type=hidden name="standardpublishid" value = "<%=request.getParameter("standardpublishid")%>">
	<input type=hidden name="req_sessionstatus" value = "<%=request.getParameter("req_sessionstatus")%>">
		
	<input type=hidden name="statuschange">
	<input type=hidden name="statusval">
	
	
	
	
     </div><!-- end of right content-->


  </div>   <!--end of center content -->




    <div class="clear"></div>
    </div> <!--end of main content-->

<%@ include file="../include/footer.jsp" %>
    

</div>
</body>
</html>